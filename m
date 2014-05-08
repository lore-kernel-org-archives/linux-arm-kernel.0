From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 8 May 2014 15:02:04 +0800
Subject: [PATCH] ARM: imx: add HDMI support for SolidRun HummingBoard and
 Cubox-i
In-Reply-To: <20140419054134.GV2523@dragon>
References: <E1Wb5br-0002ZE-T3@rmk-PC.arm.linux.org.uk>
 <20140419054134.GV2523@dragon>
Message-ID: <20140508070203.GC2798@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 19, 2014 at 01:41:35PM +0800, Shawn Guo wrote:
> On Fri, Apr 18, 2014 at 11:01:27AM +0100, Russell King wrote:
> > Add the HDMI DT configuration for the SolidRun HummingBoard and Cubox-i.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  arch/arm/boot/dts/imx6dl-hummingboard.dts | 28 ++++++++++++++++++++++++++++
> >  arch/arm/boot/dts/imx6qdl-cubox-i.dtsi    | 28 ++++++++++++++++++++++++++++
> >  2 files changed, 56 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx6dl-hummingboard.dts b/arch/arm/boot/dts/imx6dl-hummingboard.dts
> > index 5bfae54fb780..d3095f58bf7b 100644
> > --- a/arch/arm/boot/dts/imx6dl-hummingboard.dts
> > +++ b/arch/arm/boot/dts/imx6dl-hummingboard.dts
> > @@ -67,6 +67,14 @@
> >  	status = "okay";
> >  };
> >  
> > +&hdmi {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_hummingboard_hdmi>;
> > +	ddc-i2c-bus = <&i2c2>;
> > +	status = "okay";
> > +	crtcs = <&ipu1 0>;
> 
> The 'crtcs' should be dropped now, right?

Dropped the crtcs line and applied the patch, thanks.

Shawn
