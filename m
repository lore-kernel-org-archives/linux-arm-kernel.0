From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 9 Aug 2013 15:54:00 +0200
Subject: [PATCH 6/7] ARM: dts: imx27 pinctrl
In-Reply-To: <20130805061819.GF24629@S2101-09.ap.freescale.net>
References: <1375439907-10462-1-git-send-email-mpa@pengutronix.de>
 <1375439907-10462-7-git-send-email-mpa@pengutronix.de>
 <20130805061819.GF24629@S2101-09.ap.freescale.net>
Message-ID: <20130809135400.GG13664@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 02:18:21PM +0800, Shawn Guo wrote:
> On Fri, Aug 02, 2013 at 12:38:26PM +0200, Markus Pargmann wrote:
> > Pinctrl driver node and pin group definitions for other driver nodes.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx27.dtsi | 216 +++++++++++++++++++++++++++++++------------
> >  1 file changed, 158 insertions(+), 58 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> > index 76cd89f..57a4855 100644
> > --- a/arch/arm/boot/dts/imx27.dtsi
> > +++ b/arch/arm/boot/dts/imx27.dtsi
> > @@ -10,6 +10,7 @@
> >   */
> >  
> >  #include "skeleton.dtsi"
> > +#include "imx27-pinfunc.h"
> >  
> >  / {
> >  	aliases {
> > @@ -142,6 +143,8 @@
> >  				compatible = "fsl,imx27-owire", "fsl,imx21-owire";
> >  				reg = <0x10009000 0x1000>;
> >  				clocks = <&clks 35>;
> > +				pinctrl-names = "default";
> > +				pinctrl-0 = <&pinctrl_owire>;
> 
> These should be added in board level dts file.
> 
> Shawn
> 
> >  				status = "disabled";
> >  			};
> 
> <snip>
> 
> > +				fec {
> > +					pinctrl_fec: fec-1 {
> 
> I suggest we name the node and label in the same pattern we use in
> imx5/6.  I do not know how you will label node fec-2.

Will fix both.

Thanks,

Markus

> 
> Shawn
> 
> > +						fsl,pins = <
> > +							MX27_PAD_SD3_CMD__FEC_TXD0 0x0
> > +							MX27_PAD_SD3_CLK__FEC_TXD1 0x0
> > +							MX27_PAD_ATA_DATA0__FEC_TXD2 0x0
> > +							MX27_PAD_ATA_DATA1__FEC_TXD3 0x0
> > +							MX27_PAD_ATA_DATA2__FEC_RX_ER 0x0
> > +							MX27_PAD_ATA_DATA3__FEC_RXD1 0x0
> > +							MX27_PAD_ATA_DATA4__FEC_RXD2 0x0
> > +							MX27_PAD_ATA_DATA5__FEC_RXD3 0x0
> > +							MX27_PAD_ATA_DATA6__FEC_MDIO 0x0
> > +							MX27_PAD_ATA_DATA7__FEC_MDC 0x0
> > +							MX27_PAD_ATA_DATA8__FEC_CRS 0x0
> > +							MX27_PAD_ATA_DATA9__FEC_TX_CLK 0x0
> > +							MX27_PAD_ATA_DATA10__FEC_RXD0 0x0
> > +							MX27_PAD_ATA_DATA11__FEC_RX_DV 0x0
> > +							MX27_PAD_ATA_DATA12__FEC_RX_CLK 0x0
> > +							MX27_PAD_ATA_DATA13__FEC_COL 0x0
> > +							MX27_PAD_ATA_DATA14__FEC_TX_ER 0x0
> > +							MX27_PAD_ATA_DATA15__FEC_TX_EN 0x0
> > +						>;
> > +					};
> > +				};
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
