From: cavokz@gmail.com (Domenico Andreoli)
Date: Thu, 6 Sep 2012 11:47:03 +0200
Subject: [PATCH] ARM: add support for BCM2708/BCM2835 and Raspberry Pi
In-Reply-To: <201209060904.14903.arnd@arndb.de>
References: <1346908038-22421-1-git-send-email-swarren@wwwdotorg.org>
 <201209060904.14903.arnd@arndb.de>
Message-ID: <20120906094703.GA7308@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2012 at 09:04:14AM +0000, Arnd Bergmann wrote:
> On Thursday 06 September 2012, Stephen Warren wrote:
> 
> > Questions:
> > * It is asserted (I believe by Broadcom) that the BCM2835 is the only SoC
> >   in the series likely to see Linux support. Irrespective, those working
> >   on BCM2835 support downstream (see git URL above) have chosen to name
> >   the kernel support after the primary SoC (BCM2708) rather than the
> >   particular instance in use on the Raspberry Pi (BCM2835). I've followed
> >   that here, although I wonder if it's really the correct thing to do?
> 
> Doesn't matter too much. Depending on how different the various broadcom
> SoCs actually are, we might even name this mach-bcm and eventually try to
> merge the existing bcmring into it.

I've some stuff for the BCM4760. Working at clean-room patches, which is
easy because the reference published GPL sources [0] are based on 2.6.28 and
may look scary (190k lines of register definitions header file, completely
broken and unused monster to manage clocks, no pinctrl, old-style gpios,
reimplementation of pl011, pl080 - old style dma, to say a few).

Moreover many IP blocks are already in the kernel (PL011, PL081, sdhci,
dwc-usb2 in the device-only implementation of s3c-hsotg).

It's incomplete, has a lot of issues. sdhci and usb not working. PMU
BCM59040 is barely implemented, only regulators. But it can boot from
initramfs, minimal user space works. Yeah... a side project, mostly a
continous-study project.

I could find some similarities with something in bcmring, while grepping,
but I've never dig into it. I also quickly looked into the Raspberry PI
SoC but I could not find anything familiar.  However there could be some
code to share. I'll manage a first post of these patches if interested.

Regards,
Domenico

[0] http://www.tomtom.com/page.php?Page=gpl
