From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 03 Jun 2016 10:55:17 +0200
Subject: [PATCH v2 7/9] ARM: bcm2835: Add devicetree for the Raspberry Pi
 3.
In-Reply-To: <1464943546.24775.131.camel@redhat.com>
References: <1464934708-24769-1-git-send-email-kraxel@redhat.com>
 <5490184.9quKRk1Imx@wuerfel> <1464943546.24775.131.camel@redhat.com>
Message-ID: <3885625.kWfxlR3OJi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 3, 2016 10:45:46 AM CEST Gerd Hoffmann wrote:
> On Fr, 2016-06-03 at 09:38 +0200, Arnd Bergmann wrote:
> > On Friday, June 3, 2016 8:18:26 AM CEST Gerd Hoffmann wrote:
> > > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > > index 06b6c2d..71e2d36 100644
> > > --- a/arch/arm/boot/dts/Makefile
> > > +++ b/arch/arm/boot/dts/Makefile
> > > @@ -66,7 +66,8 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
> > >         bcm2835-rpi-b-rev2.dtb \
> > >         bcm2835-rpi-b-plus.dtb \
> > >         bcm2835-rpi-a-plus.dtb \
> > > -       bcm2836-rpi-2-b.dtb
> > > +       bcm2836-rpi-2-b.dtb \
> > > +       ../../../arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dtb
> > >  dtb-$(CONFIG_ARCH_BCM_5301X) += \
> > >         bcm4708-asus-rt-ac56u.dtb \
> > >         bcm4708-asus-rt-ac68u.dtb \
> > 
> > Let's make this hunk a separate patch so we can discuss it on its
> > own.
> 
> Hmm, I through we where in agreement to do it this way ...

I think it's ok in principle, this is about the specific syntax.

> > I'm not really happy about the way it looks (in general, using ../../../
> > anywhere in the kernel looks hacky.
> > 
> > How about a separate
> > 
> > dtb-$(CONFIG_ARCH_BCM2835) +=
> >       ../../../arm64/boot/dts/broadcom/
> 
> Not working.
> 
> Tried "subdir-$(CONFIG_ARCH_BCM) += ...".  Didn't work either.
> Same for "dts-dirs += ...".
> 
> Running out of ideas.  Guess I have to leave this to someone who knows
> kbuild better than me.

I tried

subdir-y += ../../../arm64/boot/dts/broadcom

and it seemed to work fine, I got

  DTC     arch/arm/boot/dts/../../../arm64/boot/dts/broadcom/ns2-svk.dtb

in an allmodconfig build, which also includes CONFIG_ARCH_BCM_IPROC.

	Arnd
