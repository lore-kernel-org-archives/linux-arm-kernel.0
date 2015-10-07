From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Oct 2015 13:45:51 +0100
Subject: All OMAP platforms: MMC is broken
In-Reply-To: <20151006153710.GS23801@atomide.com>
References: <20151001100326.GV21513@n2100.arm.linux.org.uk>
 <20151005112304.GZ23801@atomide.com>
 <20151005143532.GA23801@atomide.com>
 <20151005145127.GB23801@atomide.com>
 <20151005171155.GF23801@atomide.com>
 <20151005183813.GD21626@n2100.arm.linux.org.uk>
 <20151006090015.GE21626@n2100.arm.linux.org.uk>
 <20151006094425.GM23801@atomide.com>
 <20151006150009.GF21626@n2100.arm.linux.org.uk>
 <20151006153710.GS23801@atomide.com>
Message-ID: <20151007124551.GI21626@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 08:37:11AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [151006 08:04]:
> > On Tue, Oct 06, 2015 at 02:44:25AM -0700, Tony Lindgren wrote:
> > > 
> > > Hmm DT-based boot finds the MMC card for LDP, dmesg below from DT boot [1].
> > > Looks like you're on on -rc4 and not -rc3. My guess is that MMC is not
> > > working for you with DT-based booting because you don't seem to have
> > > CONFIG_REGULATOR_PBIAS in your seed config for. Care to try enabling that
> > > for both your omap3 and omap4 seed config files?
> > 
> > This is precisely the kind of crap I'm objecting to.  New kernel versions
> > come along, and things break because people add extra Kconfig symbols that
> > previous versions did not rely upon - and there's no communication of
> > what's required for new kernel versions.
> > 
> > This stuff needs documenting, so that people are aware what changes they
> > need to make - please put something in Documentation/arm/OMAP which
> > tracks what new additions are required to the Kconfig to keep things
> > working.
> 
> Good idea, how about something like the following? AFAIK that's the
> only .config option needed as MFD_SYSCON is selected by Kconfig
> already.

Right, that resolves the issue.  Now, what's the story on the revert
and the other patch - have they already been taken for -rc kernels?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
