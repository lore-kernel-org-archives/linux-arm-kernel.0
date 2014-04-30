From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 30 Apr 2014 09:02:27 +0200
Subject: [PATCH 3/3] ARM: dts: imx6dl, fix i2c4 device node
In-Reply-To: <20140430064159.GF16727@dragon>
References: <1398694356-22511-1-git-send-email-mpa@pengutronix.de>
 <1398694356-22511-4-git-send-email-mpa@pengutronix.de>
 <20140430064159.GF16727@dragon>
Message-ID: <20140430070227.GH15179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 02:42:01PM +0800, Shawn Guo wrote:
> On Mon, Apr 28, 2014 at 04:12:36PM +0200, Markus Pargmann wrote:
> > i2c4 is exactly the same hardware module as i2c 1 to 3. The compatible
> > property is wrong and the appropriate clock was missing.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx6dl.dtsi | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
> > index 9c4942f..a48a542 100644
> > --- a/arch/arm/boot/dts/imx6dl.dtsi
> > +++ b/arch/arm/boot/dts/imx6dl.dtsi
> > @@ -84,9 +84,10 @@
> >  			i2c4: i2c at 021f8000 {
> >  				#address-cells = <1>;
> >  				#size-cells = <0>;
> > -				compatible = "fsl,imx1-i2c";
> > +				compatible = "fsl,imx6q-i2c", "fsl,imx21-i2c";
> >  				reg = <0x021f8000 0x4000>;
> >  				interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks 209>;
> 
> It needs to be a different number when you rebase the patch on my
> branch.

I will rebase this patch and resend with the correct clock number.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140430/7510daeb/attachment.sig>
