From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Nov 2012 16:48:44 +0100
Subject: [PATCH] ARM: mx5: Replace clk_register_clkdev with clock DT lookup
In-Reply-To: <50ABA25C.7050304@pengutronix.de>
References: <1353350425-1075-1-git-send-email-fabio.estevam@freescale.com>
 <20121120152836.GM10369@pengutronix.de>
 <50ABA25C.7050304@pengutronix.de>
Message-ID: <20121120154844.GN10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 04:31:40PM +0100, Marc Kleine-Budde wrote:
> On 11/20/2012 04:28 PM, Sascha Hauer wrote:
> > On Mon, Nov 19, 2012 at 04:40:25PM -0200, Fabio Estevam wrote:
> >> Similarly as it was done for mx6q, use a DT lookup in order to make maintainance
> >> task for the clock devices easier.
> >>
> >> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> >> ---
> >>  .../devicetree/bindings/clock/imx5-clock.txt       |  197 ++++++++++++++++++++
> >>  arch/arm/boot/dts/imx51.dtsi                       |   39 ++++
> >>  arch/arm/boot/dts/imx53.dtsi                       |   48 +++++
> >>  arch/arm/mach-imx/clk-imx51-imx53.c                |   26 +--
> >>  arch/arm/mach-imx/imx51-dt.c                       |   28 +--
> >>  arch/arm/mach-imx/mach-imx53.c                     |   31 +--
> >>  6 files changed, 299 insertions(+), 70 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/clock/imx5-clock.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/imx5-clock.txt b/Documentation/devicetree/bindings/clock/imx5-clock.txt
> >> new file mode 100644
> >> index 0000000..a6fb29e
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/imx5-clock.txt
> >> @@ -0,0 +1,197 @@
> >> +* Clock bindings for Freescale i.MX5
> >> +
> >> +Required properties:
> >> +- compatible: Should be "fsl,<soc>-ccm" , where <soc> can be mx51 or mx53
> > 
> > s/mx51/imx51/
> > s/mx53/iMX53/
>          ^^^^^
> imx53?

even better ;)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
