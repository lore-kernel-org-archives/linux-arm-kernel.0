From: marex@denx.de (Marek Vasut)
Date: Wed, 3 Apr 2013 02:21:18 +0200
Subject: [PATCH] pinctrl: imx5: fix SD2_DATA1 pad AUDMUX_AUD4 configuration
In-Reply-To: <20130402114323.GE24039@S2101-09.ap.freescale.net>
References: <1364882642-25574-1-git-send-email-marex@denx.de>
 <20130402114323.GE24039@S2101-09.ap.freescale.net>
Message-ID: <201304030221.18506.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> Marek,
> 
> On Tue, Apr 02, 2013 at 08:04:02AM +0200, Marek Vasut wrote:
> > The IOMUXC_AUDMUX_P4_INPUT_TXCLK_AMX_SELECT_INPUT must be configured as 1
> > instead of 0 to have AUD4 muxed on SD2 pins working.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > ---
> > 
> >  drivers/pinctrl/pinctrl-imx53.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > NOTE: Shawn, we might want this in -stable too ?
> 
> I have queued patch b466af3 (pinctrl: imx: move hard-coding data into
> device tree) on my imx/dt branch to remove these tables from pinctrl
> drivers.
> 
> Since there is no in-tree users for MX53_PAD_SD2_DATA1__AUDMUX_AUD4_TXFS,
> and we're moving away from it, can we just patch
> arch/arm/boot/dts/imx53-pinfunc.h instead?
> 
> Shawn

One serving of such patch, coming right up ;-)

btw. do you want to apply this one for -stable or do we just leave it as is ?

Best regards,
Marek Vasut
