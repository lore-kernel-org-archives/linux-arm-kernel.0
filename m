From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 09 Sep 2012 01:34:42 +0000
Subject: [PATCH] ARM: add support for BCM2708/BCM2835 and Raspberry Pi
In-Reply-To: <20120909003027.GB13519@glitch>
References: <1346908038-22421-1-git-send-email-swarren@wwwdotorg.org>
 <20120908215609.GH13739@n2100.arm.linux.org.uk>
 <20120909003027.GB13519@glitch>
Message-ID: <2862099.nQ3UIKtPXP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 09 September 2012 02:30:27 Domenico Andreoli wrote:
> On Sat, Sep 08, 2012 at 10:56:10PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Sep 06, 2012 at 03:46:44PM +0000, Arnd Bergmann wrote:
> > > We just had a discussion about
> > > stale platforms at the ARM mini summit in San Diego. IMHO if a port
> > > gets started and then nobody works on filling the gaps for two
> > > years, we should remove it again. 
> > 
> > One of the issues there is that you don't know if the reason it's not
> > receiving patches or comments is because it works and people are using
> > it, and they don't have anything to report against it.
> > 
> > That's certainly true of a number of platforms we currently have.
> 
> I would also like to know the usefulness/completeness requirements of
> new platforms.
> 
> Expecting the latest designs in each area, what is wanted for a first
> submission, besides the core stuff required for booting?
> 
>  - clocks
>  - gpios
>  - pinctrl
>  - devicetree
>  - uarts
>  - dma
>  - i2c
>  - ...
> 
> For instance, I'm absolutely not interested in audio, displays and GPUs at
> the moment, at least not those equipping this board. So I will not spend
> any time to contribute anything of them. Would this be a stopper?

The only real requirements that I have for new platforms are

a) the code has to look reasonable and follow the quality standards,
in particular using all the generic subsystems (e.g. irqchip,
clocksource, common-clock, mtd, pinctrl, dmaengine, asoc, regulator,
pwm) where applicable. You don't have to use all of them, but if
you have a driver for one of these, you must use the common code
instead of reimplementing it differently.

b) a commitment from the submitter to keep looking after the platform,
and review bug fixes and other code changes that are submitted by
other people.

There is no need for an initial submission to be complete in any way.
In fact I would argue that basically none of the big ARMv7 platforms
(omap, exynos, imx, ux500, msm, mmp, ...) are complete because they
are all lacking proper graphics drivers. 

Having the first version be able to boot to a shell prompt is certainly
a good thing, but I would put the entry bar as low as possible really
and rather take nice looking work-in-progress code early than review a
large amount of code all at once and have to tell the submitters that
they got something fundamentally wrong and need to redo everything.

	Arnd
