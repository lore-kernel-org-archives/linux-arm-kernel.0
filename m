From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 24 Jan 2015 15:39:45 +0100
Subject: [PATCH] ARM: dts: sun4i: Add initial dts for Gemei G9 tablet
In-Reply-To: <1422050375.1799.9.camel@plaes.org>
References: <1422045409-1251-1-git-send-email-plaes@plaes.org>
 <20150123212203.GB8470@lukather>
 <1422050375.1799.9.camel@plaes.org>
Message-ID: <20150124143945.GD8470@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 23, 2015 at 11:59:35PM +0200, Priit Laes wrote:
> 
> On Fri, 2015-01-23 at 22:22 +0100, Maxime Ripard wrote:
> > On Fri, Jan 23, 2015 at 10:36:49PM +0200, Priit Laes wrote:
> > > Gemei G9 is an A10 based tablet, with 1G RAM, 16G NAND, 1024x768 
> > > IPS LCD display, stereo speakers, 1.3MP front camera and 5 MP
> > > rear camera, 8000mAh battery, GT901 2+1 touchscreen, Bosch BMA250 
> > > accelerometer and RTL8188CUS USB wifi. It also has MicroSD slot, 
> > > miniHDMI, 1 x MicroUSB OTG port and 1 x MicroUSB host port and 
> > > 3.5mm headphone jack.
> > > More details are available at: http://linux-sunxi.org/Gemei_G9
> > > 
> [..]
> > > 
> > > +/ {
> > > +    model = "Gemei G9 Tablet";
> > > +    compatible = "gemei,g9", "allwinner,sun4i-a10";
> > > +};
> > > +
> > > +/*
> > > + * http://linux-sunxi.org/Gemei_G9
> > 
> > Please don't put URL in the DT. This is very likely to change in the 
> > future, and won't be valid anymore.
> 
> OK! The URL in commit message is ok to stay?

Yeah, I'm not that fond of it, but it's not that important either.

> > > +&i2c1 {
> > > +    pinctrl-names = "default";
> > > +    pinctrl-0 = <&i2c1_pins_a>;
> > > +    status = "okay";
> > > +
> > > +    /* Accelerometer */
> > > +    bma250 at 18 {
> > > +        compatible = "bosch,bma250";
> > > +        reg = <0x18>;
> > 
> > Is there a driver for this? It looks weird that it doesn't need more 
> > properties than that.
> 
> Yes, it's supported by drivers/iio/accel/bma180.c though I have to 
> admit that this name is a bit misleading. (bosch-bma.c would 
> better, I guess).
> 
> And I was a bit surprised that it worked out of the box too, but the 
> device was present under /sys and I was able to read x, y, z and 
> temperature values.

Cool :)

There's no interrupt wired to it then?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150124/3f1eb110/attachment.sig>
