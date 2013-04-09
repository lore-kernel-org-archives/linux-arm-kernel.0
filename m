From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 9 Apr 2013 19:53:26 +0800
Subject: [PATCH] ARM: imx: provide twd clock lookup from device tree
In-Reply-To: <1365004963-27957-1-git-send-email-shawn.guo@linaro.org>
References: <1365004963-27957-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130409115324.GJ5047@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 04, 2013 at 12:02:43AM +0800, Shawn Guo wrote:
> While booting from device tree, imx6q used to provide twd clock lookup
> by calling clk_register_clkdev() in clock driver.  However, the commit
> bd60345 (ARM: use device tree to get smp_twd clock) forces DT boot to
> look up the clock from device tree.  It causes the failure below when
> twd driver tries to get the clock, and hence kernel has to calibrate the
> local timer frequency.
> 
>  smp_twd: clock not found -2
>  ...
>  Calibrating local timer... 396.13MHz.
> 
> Fix the regression by providing twd clock lookup from device tree, and
> remove the unused twd clk_register_clkdev() call from clock driver.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Arnd, Olof,
> 
> This is a fix for 3.9.

I will have this included in the pull request that is to be sent.

Shawn
