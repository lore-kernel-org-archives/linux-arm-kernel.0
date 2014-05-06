From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 6 May 2014 14:00:02 +0200
Subject: [PATCH] ARM: dts: i.MX53: Fix ipu register space size
In-Reply-To: <20140506134943.4d87a726@ipc1.ka-ro>
References: <1399374094-32451-1-git-send-email-s.hauer@pengutronix.de>
 <20140506134943.4d87a726@ipc1.ka-ro>
Message-ID: <20140506120002.GC5918@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 06, 2014 at 01:49:43PM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> Sascha Hauer wrote:
> > The IPU register space is 128MB, not 2GB.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx53.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> > index 9c2bff2..6a1bf4f 100644
> > --- a/arch/arm/boot/dts/imx53.dtsi
> > +++ b/arch/arm/boot/dts/imx53.dtsi
> > @@ -115,7 +115,7 @@
> >  			#address-cells = <1>;
> >  			#size-cells = <0>;
> >  			compatible = "fsl,imx53-ipu";
> > -			reg = <0x18000000 0x080000000>;
> > +			reg = <0x18000000 0x08000000>;
> >
> IMO this should be either 0x00800000 or 0x800000
> while I prefer the first notation.

Look again, the original size is 9 digits wide: 0x0_8000_0000. I
changed this to 0x_08000_0000 which is 8 digits wide.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
