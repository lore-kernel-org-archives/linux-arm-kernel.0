From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 23 May 2014 17:03:22 +0800
Subject: [PATCH v2] pwm: imx: set can_sleep flag for imx_pwm
In-Reply-To: <20140523084359.GD20155@pengutronix.de>
References: <1400834488-2660-1-git-send-email-shawn.guo@freescale.com>
 <20140523084359.GD20155@pengutronix.de>
Message-ID: <20140523090321.GA2650@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 10:43:59AM +0200, Uwe Kleine-K?nig wrote:
> On Fri, May 23, 2014 at 04:41:28PM +0800, Shawn Guo wrote:
> > The .config() hook imx_pwm_config() calls clk APIs like clk_prepare()
> > and clk_get_rate(), which might sleep, so we need to set can_sleep flag
> > on pwm_chip.
> Wasn't there a bug that was fixed or at least made more obvious with
> this change? Is it worth mentioning in the commit log?

The bug should be the one same as what we fixed on pwm-mxs[1].  But I
did not try to trigger it on pwm-imx myself, because it's obvious.

Shawn

[1] http://article.gmane.org/gmane.linux.pwm/570
