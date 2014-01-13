From: chris@printf.net (Chris Ball)
Date: Mon, 13 Jan 2014 18:40:09 +0000
Subject: [PATCH V2 2/2] mmc: sdhci-esdhc-imx: fix warning during module
 remove function
In-Reply-To: <1388042634-17281-2-git-send-email-b29396@freescale.com> (Dong
 Aisheng's message of "Thu, 26 Dec 2013 15:23:54 +0800")
References: <1388042634-17281-1-git-send-email-b29396@freescale.com>
 <1388042634-17281-2-git-send-email-b29396@freescale.com>
Message-ID: <8638krbu9i.fsf@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 26 2013, Dong Aisheng wrote:
> Since the clock is managed by runtime pm currently, we do not need
> disable it again during driver remove function, or it will cause
> clock disable count mismatch issue since the clocks have already been disabled.
>
> The issue can be simply reproduced by unbind the devices via sysfs.
> mx6slevk:/sys/bus/platform/drivers/sdhci-esdhc-imx# echo 2194000.usdhc > unbind
> mmc1: card aaaa removed
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 657 at drivers/clk/clk.c:842 __clk_disable+0x68/0x88()

Thanks, pushed to mmc-next.

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
