From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 6 Sep 2012 15:46:44 +0000
Subject: [PATCH] ARM: add support for BCM2708/BCM2835 and Raspberry Pi
In-Reply-To: <20120906094703.GA7308@glitch>
References: <1346908038-22421-1-git-send-email-swarren@wwwdotorg.org>
 <201209060904.14903.arnd@arndb.de> <20120906094703.GA7308@glitch>
Message-ID: <201209061546.45242.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 September 2012, Domenico Andreoli wrote:
> On Thu, Sep 06, 2012 at 09:04:14AM +0000, Arnd Bergmann wrote:
> > On Thursday 06 September 2012, Stephen Warren wrote:
> > 
> > > Questions:
> > > * It is asserted (I believe by Broadcom) that the BCM2835 is the only SoC
> > >   in the series likely to see Linux support. Irrespective, those working
> > >   on BCM2835 support downstream (see git URL above) have chosen to name
> > >   the kernel support after the primary SoC (BCM2708) rather than the
> > >   particular instance in use on the Raspberry Pi (BCM2835). I've followed
> > >   that here, although I wonder if it's really the correct thing to do?
> > 
> > Doesn't matter too much. Depending on how different the various broadcom
> > SoCs actually are, we might even name this mach-bcm and eventually try to
> > merge the existing bcmring into it.
> 
> I've some stuff for the BCM4760. Working at clean-room patches, which is
> easy because the reference published GPL sources [0] are based on 2.6.28 and
> may look scary (190k lines of register definitions header file, completely
> broken and unused monster to manage clocks, no pinctrl, old-style gpios,
> reimplementation of pl011, pl080 - old style dma, to say a few).

The naming gets increasingly confusing. I thought that bcm47xx were
MIPS based router chips, but it seems their number have no meaning at all.
Reminds me of IBM's four digit product codes ;-)

> Moreover many IP blocks are already in the kernel (PL011, PL081, sdhci,
> dwc-usb2 in the device-only implementation of s3c-hsotg).
> 
> It's incomplete, has a lot of issues. sdhci and usb not working. PMU
> BCM59040 is barely implemented, only regulators. But it can boot from
> initramfs, minimal user space works. Yeah... a side project, mostly a
> continous-study project.

If the code looks good, we can always merge it and see how it progresses,
maybe other people are also interested in helping out. Of course if
it just ends up being stale with nobody working on completing it,
we can remove it again just as quickly. We just had a discussion about
stale platforms at the ARM mini summit in San Diego. IMHO if a port
gets started and then nobody works on filling the gaps for two
years, we should remove it again. 

> I could find some similarities with something in bcmring, while grepping,
> but I've never dig into it. I also quickly looked into the Raspberry PI
> SoC but I could not find anything familiar.  However there could be some
> code to share. I'll manage a first post of these patches if interested.

Ok. If code for a new platform that is like bcmring were to come out of
Broadcom, I'd ask them to clean that up first and merge the two, but if
you do a cleanroom implementation, that's probably fine to go in separately.
We might actually end up removing bcmring eventually.

	Arnd
