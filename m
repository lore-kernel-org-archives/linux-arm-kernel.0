From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Nov 2013 12:53:42 +0800
Subject: [PATCH v2 1/2] can + ARM i.MX53: use 24 MHz clock parent on i.MX53
In-Reply-To: <1385414121-21493-1-git-send-email-mkl@pengutronix.de>
References: <1385414121-21493-1-git-send-email-mkl@pengutronix.de>
Message-ID: <20131126045340.GJ30476@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 10:15:19PM +0100, Marc Kleine-Budde wrote:
> Hello,
> 
> this series first fixes a bug in the flexcan driver, using the wrong clock for
> the bit rate calculcation. The next patch switches the peripheral clock on
> i.MX53 to lp_apm, which has a rate of 24 MHz. This is optimal for the CIA
> recommended bit rates.
> 
> Tested on TQ's mba53 and mba6x [1].
> 
> Who is taking the series? Due to Lucas' patch:
> 
>     0a5b8df clk: imx5: introduce DT includes for clock provider
> 
> this series does not yet apply to my upstream (net-next/mastet).

If the clock setting in flexcan driver is already broken, it shouldn't
matter to have two patches go different tree?  Otherwise, I can have
both go via IMX tree with your ACK on the first one?

> 
> Marc
> 
> [1] On i.MX6 the following patch is needed (which is already in Shawn's
>     for-next):
> 
>     9b3d423 ARM: i.MX6q: fix the wrong parent of can_root clock

This one already hits mainline.

Shawn

> 
> changes since v1:
> * move switch to 24 MHz clock to mx53_clocks_init
>   (tnx Alexander)
> 
> 
