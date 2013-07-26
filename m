From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 26 Jul 2013 14:48:28 +0200
Subject: [PATCH 05/10] ARM: sunxi: Add Allwinner A31 DTSI
In-Reply-To: <20130726123747.7c88d976@skate>
References: <1374618312-19001-1-git-send-email-maxime.ripard@free-electrons.com>
 <1374618312-19001-6-git-send-email-maxime.ripard@free-electrons.com>
 <20130726123747.7c88d976@skate>
Message-ID: <20130726124828.GD3056@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Fri, Jul 26, 2013 at 12:37:47PM +0200, Thomas Petazzoni wrote:
> Dear Maxime Ripard,
> 
> On Wed, 24 Jul 2013 00:25:07 +0200, Maxime Ripard wrote:
> 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 641b3c9..1482533 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -210,7 +210,8 @@ dtb-$(CONFIG_ARCH_SUNXI) += \
> >  	sun4i-a10-mini-xplus.dtb \
> >  	sun4i-a10-hackberry.dtb \
> >  	sun5i-a10s-olinuxino-micro.dtb \
> > -	sun5i-a13-olinuxino.dtb
> > +	sun5i-a13-olinuxino.dtb \
> > +	sun6i-a31-colombus.dtb
> 
> Wrong patch for this chunk. The colombus .dts is added in PATCH 06/10.

Indeed, it was already pointed out by Emilio.

> > +	soc at 01c20000 {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		reg = <0x01c20000 0x300000>;
> > +		ranges;
> 
> Just curious, what are these reg and ranges properties for?

The fdt parsing code seem to be needing a ranges property, since it
prints a warning if it's not set.

For the reg one, honestly, I don't have a strong argument on this. The
platforms I'm used to did it that way, so did I. The documentation of
simple-bus doesn't seem to mention it, so maybe it's not needed at all.

I find it pretty convenient though to have the size and range where the
different IPs are located in.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130726/b80465c2/attachment.sig>
