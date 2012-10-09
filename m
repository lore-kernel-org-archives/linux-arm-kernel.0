From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 9 Oct 2012 18:33:32 +0530
Subject: [PATCH 1/1] mtd:nand:clk: preparation for switch to common clock
 framework
In-Reply-To: <1347899860-24358-2-git-send-email-m-karicheri2@ti.com>
References: <1347899860-24358-1-git-send-email-m-karicheri2@ti.com>
 <1347899860-24358-2-git-send-email-m-karicheri2@ti.com>
Message-ID: <507420A4.8090905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/17/2012 10:07 PM, Murali Karicheri wrote:
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

Tested this using NAND flash on DA850 EVM.

Acked-by: Sekhar Nori <nsekhar@ti.com>

Any chance this can make into the v3.7 kernel?

Thanks,
Sekhar
