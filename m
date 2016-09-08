From: kraxel@redhat.com (Gerd Hoffmann)
Date: Thu, 08 Sep 2016 09:48:48 +0200
Subject: [PATCH 1/8] ARM: dts: bcm283x: Define standard pinctrl groups
 in the gpio node.
In-Reply-To: <87bmzzr1bg.fsf@eliezer.anholt.net>
References: <1473244289-20728-1-git-send-email-kraxel@redhat.com>
 <1473244289-20728-2-git-send-email-kraxel@redhat.com>
 <1564766913.23457.026b1e4b-e35d-48e6-9394-7eeea0ff9add.open-xchange@email.1und1.de>
 <87bmzzr1bg.fsf@eliezer.anholt.net>
Message-ID: <1473320928.6698.28.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mi, 2016-09-07 at 11:50 -0700, Eric Anholt wrote:
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > Hi Gerd,
> >
> >> Gerd Hoffmann <kraxel@redhat.com> hat am 7. September 2016 um 12:31
> >> geschrieben:
> >> 
> >> 
> >> From: Eric Anholt <eric@anholt.net>
> >> 
> >> The BCM2835-ARM-Peripherals.pdf documentation specifies what the
> >> function selects do for the pins, and there are a bunch of obvious
> >> groupings to be made.  With these created, we'll be able to replace
> >> bcm2835-rpi.dtsi's main "set all of these pins to alt0" with
> >> references to specific groups we want enabled.
> >
> > on IMX/MXS platform it's unwanted to add all possible muxes in the dtsi file. So
> > i would suggest to add only the actually used muxes. That makes it easier to
> > maintain.
> 
> On the other hand, I find that having to go back to the docs for
> determining the fsels is worse than just verifying and defining them
> here all at once.

Agreeing here.  IMO it is nice to have them all even if unused for
documentation purposes.

> Maintaining has also gotten harder because our DTs
> are split across 32 and 64-bit ARM, so rpi3 changes that require adding
> one of these pinmux definitions back to the dtsi would require painful
> cross-branch merges.

It'll also easily cause merge conflicts.

cheers,
  Gerd
