From: mgr@pengutronix.de (Michael Grzeschik)
Date: Thu, 23 Aug 2012 13:36:08 +0200
Subject: [PATCH v2] ARM: imx: add imx5x usb controller clock lookups
In-Reply-To: <CAOMZO5AV5eYgjuxAHBi-r1-kA4w2ue3kGVqYYG83d4=qxUxhDw@mail.gmail.com>
References: <1345718328-6547-1-git-send-email-m.grzeschik@pengutronix.de>
 <1345719696-25738-1-git-send-email-m.grzeschik@pengutronix.de>
 <CAOMZO5AV5eYgjuxAHBi-r1-kA4w2ue3kGVqYYG83d4=qxUxhDw@mail.gmail.com>
Message-ID: <20120823113608.GF10429@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Thu, Aug 23, 2012 at 08:13:38AM -0300, Fabio Estevam wrote:
> On Thu, Aug 23, 2012 at 8:01 AM, Michael Grzeschik
> <m.grzeschik@pengutronix.de> wrote:
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > ---
> >  arch/arm/mach-imx/clk-imx51-imx53.c |   24 ++++++++++++++++++++++++
> 
> Just curious: does the current Chip Idea USB driver work 'as is' on mx5?

Not "as is" but we are working on it to get all patches for that
mainline. Currently there is the static CI13XXX_REQUIRE_TRANSCEIVER flag
in the ci13xxx_imx_data, which makes the socs with no real xceiver
depend on the nop-xceiver. But that one lags clk_prepare_{enable, disable}.
But we already prepared that in some, "hopefully ready for mainline", patches.

> Are you also going to submit the <soc>.dtsi and <board>.dts patches?

Yes, the dtsi patch is alread on the list:
http://www.spinics.net/lists/arm-kernel/msg190737.html

> I would like to try it on a mx53qsb.

we got it already running with that board and the above mentioned
dependencies.

Cheers,

Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
