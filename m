From: kraxel@redhat.com (Gerd Hoffmann)
Date: Tue, 13 Sep 2016 08:22:40 +0200
Subject: [PATCH v2 2/6] ARM: dts: bcm283x: Define standard pinctrl
 groups in the gpio node.
In-Reply-To: <1273800480.83718.15854341-2f8e-4e20-95f4-e76f81e6fd56.open-xchange@email.1und1.de>
References: <1473668576-22256-1-git-send-email-kraxel@redhat.com>
 <1473668576-22256-3-git-send-email-kraxel@redhat.com>
 <1273800480.83718.15854341-2f8e-4e20-95f4-e76f81e6fd56.open-xchange@email.1und1.de>
Message-ID: <1473747760.11547.7.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mo, 2016-09-12 at 20:19 +0200, Stefan Wahren wrote:
> Hi Gerd,
> 
> > Gerd Hoffmann <kraxel@redhat.com> hat am 12. September 2016 um 10:22
> > geschrieben:
> > 
> > 
> > From: Eric Anholt <eric@anholt.net>
> > 
> > The BCM2835-ARM-Peripherals.pdf documentation specifies what the
> > function selects do for the pins, and there are a bunch of obvious
> > groupings to be made.  With these created, we'll be able to replace
> > bcm2835-rpi.dtsi's main "set all of these pins to alt0" with
> > references to specific groups we want enabled.
> > 
> > Signed-off-by: Eric Anholt <eric@anholt.net>
> > 
> > squashed in:
> >   ARM: dts: bcm283x: Add the emmc pin group to bcm283x.dtsi.
> >   ARM: dts: bcm283x: Add a group for mapping pins 48-53 to sdhost.
> >   ARM: dts: bcm283x: Add a new EMMC pin group from the downstream tree.
> > 
> > fixups by kraxel:
> >   * fix spi0 name
> >   * sort & group entries
> >   * use pull defines
> >   * add dpi group
> 
> this looks like a changelog.

It actually is, trying to keep track of what comes from Eric and what
comes from me.  But I guess I can also simply summarize that as "based
on a patch from Eric".

> > +			dpi_gpio4: dpi_gpio4 {
> > +				brcm,pins = <0 1 2 3 4 5 6 7 8 9 10 11
> > +					     12 13 14 15 16 17 18 19
> > +					     20 21 22 23 24 25 26 27>;
> > +				brcm,function = <BCM2835_FSEL_ALT2>;
> > +			};
> 
> s/dpi_gpio4/dpi_gpio0

Yea, right, will fix.

cheers,
  Gerd
