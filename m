From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 6 Feb 2014 20:27:20 +0800
Subject: [PATCH] ARM: imx6: Initialize low-power mode early again
In-Reply-To: <1391011804-22516-1-git-send-email-p.zabel@pengutronix.de>
References: <1391011804-22516-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20140206122718.GH3708@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 05:10:04PM +0100, Philipp Zabel wrote:
> Since commit 9e8147bb5ec5d1dda2141da70f96b98985a306cb
> "ARM: imx6q: move low-power code out of clock driver"
> the kernel fails to boot on i.MX6Q/D if preemption is
> enabled (CONFIG_PREEMPT=y). The kernel just hangs
> before the console comes up.
> 
> The above commit moved the initalization of the low-power
> mode setting (enabling clocked WAIT states), which was
> introduced in commit 83ae20981ae924c37d02a42c829155fc3851260c
> "ARM: imx: correct low-power mode setting", from
> imx6q_clks_init to imx6q_pm_init. Now it is called
> much later, after all cores are enabled.
> 
> This patch moves the low-power mode initialization back
> to imx6q_clks_init again (and to imx6sl_clks_init).
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied, thanks.
