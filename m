From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 8 Dec 2013 03:44:56 +0100
Subject: [RFC part1 PATCH 0/7] Make ACPI core running on ARM64
In-Reply-To: <20131206135825.GG29268@sirena.org.uk>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <201312052325.02603.arnd@arndb.de> <20131206135825.GG29268@sirena.org.uk>
Message-ID: <201312080344.56317.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 December 2013, Mark Brown wrote:
> On Thu, Dec 05, 2013 at 11:25:02PM +0100, Arnd Bergmann wrote:
> 
> > However, as I mentioned before I am much more worried about the parts that
> > are not done (or not posted) yet and that will be required to actually
> > have working support for a real server system. Until we know more about
> > where this is heading, I think we should not merge any of the ARM specific
> > parts of your patches. Any patches that are reasonable cleanups and bug
> > fixes for the ACPI subsystem should of course get merged once they are
> > reviewed.
> 
> OTOH if it's well encapsulated, is going to be required for any kind of
> ACPI use and gets to the point where people are OK with it by itself
> then I'm not sure what we'd gain by keeping it out of tree - it'd make
> the real system patch sets bigger and harder to review.

I'd agree as soon as someone can convince me that we actually want ACPI
support in the kernel for ARM64 servers. As far as I'm concerned it's quite
possible that the people who have worked on this for the past couple of
years behind closed doors know what they are doing and it will all be
good, but it's also possible that it turns into a huge trainwreck once
we see multiple implementations that have fundamentally incompatible
requirements regarding what they want from ACPI and we end up not doing
it at all. I just don't have enough information at this point to know which
of the two is true and I'd like to ensure that accepting the patches
that meet your criteria above would not be seen as an endorsement to do
crazy stuff later.

	Arnd
