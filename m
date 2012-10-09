From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 9 Oct 2012 17:07:17 +0530
Subject: [PATCH 1/1] spi:clk: preparation for switch to common clock
 framework
In-Reply-To: <1347900122-25101-2-git-send-email-m-karicheri2@ti.com>
References: <1347900122-25101-1-git-send-email-m-karicheri2@ti.com>
 <1347900122-25101-2-git-send-email-m-karicheri2@ti.com>
Message-ID: <50740C6D.7070906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/17/2012 10:12 PM, Murali Karicheri wrote:
> As a first step towards migrating davinci platforms to use common clock
> framework, replace all instances of clk_enable() with clk_prepare_enable()
> and clk_disable() with clk_disable_unprepare(). Until the platform is
> switched to use the CONFIG_HAVE_CLK_PREPARE Kconfig variable, this just
> adds a might_sleep() call and would work without any issues.
> 
> This will make it easy later to switch to common clk based implementation
> of clk driver from DaVinci specific driver.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Reviewed-by: Mike Turquette <mturquette@linaro.org>

This patch had to be applied manually and with some fuzz when I applied
it to latest linus/master. There were no conflicts though and once I
applied it, I was able to test SPI flash on DA850 EVM successfully using it.

Acked-by: Sekhar Nori <nsekhar@ti.com>

I am hoping this patch can still go in v3.7. I realize we are in the
middle of the merge window though.

Thanks,
Sekhar
