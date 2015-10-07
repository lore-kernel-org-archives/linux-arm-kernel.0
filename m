From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Oct 2015 06:26:42 -0700
Subject: All OMAP platforms: MMC is broken
In-Reply-To: <20151007124551.GI21626@n2100.arm.linux.org.uk>
References: <20151005112304.GZ23801@atomide.com>
 <20151005143532.GA23801@atomide.com>
 <20151005145127.GB23801@atomide.com>
 <20151005171155.GF23801@atomide.com>
 <20151005183813.GD21626@n2100.arm.linux.org.uk>
 <20151006090015.GE21626@n2100.arm.linux.org.uk>
 <20151006094425.GM23801@atomide.com>
 <20151006150009.GF21626@n2100.arm.linux.org.uk>
 <20151006153710.GS23801@atomide.com>
 <20151007124551.GI21626@n2100.arm.linux.org.uk>
Message-ID: <20151007132642.GV23801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [151007 05:50]:
> On Tue, Oct 06, 2015 at 08:37:11AM -0700, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [151006 08:04]:
> > > On Tue, Oct 06, 2015 at 02:44:25AM -0700, Tony Lindgren wrote:
> > > > 
> > > > Hmm DT-based boot finds the MMC card for LDP, dmesg below from DT boot [1].
> > > > Looks like you're on on -rc4 and not -rc3. My guess is that MMC is not
> > > > working for you with DT-based booting because you don't seem to have
> > > > CONFIG_REGULATOR_PBIAS in your seed config for. Care to try enabling that
> > > > for both your omap3 and omap4 seed config files?
> > > 
> > > This is precisely the kind of crap I'm objecting to.  New kernel versions
> > > come along, and things break because people add extra Kconfig symbols that
> > > previous versions did not rely upon - and there's no communication of
> > > what's required for new kernel versions.
> > > 
> > > This stuff needs documenting, so that people are aware what changes they
> > > need to make - please put something in Documentation/arm/OMAP which
> > > tracks what new additions are required to the Kconfig to keep things
> > > working.
> > 
> > Good idea, how about something like the following? AFAIK that's the
> > only .config option needed as MFD_SYSCON is selected by Kconfig
> > already.
> 
> Right, that resolves the issue.  Now, what's the story on the revert
> and the other patch - have they already been taken for -rc kernels?

Not yet, I was waiting for the confirmation from you. I've now posted the
revert with proper description and the fix so Ulf can pick them up and
merged as regression fixes for the -rc series:

http://marc.info/?l=linux-omap&m=144422416621373&w=2
http://marc.info/?l=linux-omap&m=144422416921375&w=2

Regards,

Tony
