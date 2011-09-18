From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 18 Sep 2011 17:44:25 +0200
Subject: READ THIS: the next mach-types update
In-Reply-To: <20110916102754.GA6205@netboy.at.omicron.at>
References: <20110915102528.GI6267@n2100.arm.linux.org.uk>
	<20110916102754.GA6205@netboy.at.omicron.at>
Message-ID: <2659680.vCa59q5ODA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 September 2011 12:27:54 Richard Cochran wrote:
> On Thu, Sep 15, 2011 at 11:25:28AM +0100, Russell King - ARM Linux wrote:
> > -devixp                  MACH_DEVIXP             DEVIXP                  2885
> > -miccpt                  MACH_MICCPT             MICCPT                  2886
> > -mic256                  MACH_MIC256             MIC256                  2887
> 
> Russell,
> 
> I had posted support for these some time ago, and shortly thereafter
> the whole "clean up the ARM mess" campaign started. I did not follow
> up on posting a second time, for fear of adding more churn.
> 
> So, my question is, what can I do to keep these in the list?
> 
> Can I get plain old board setup files merged (like three of the
> following) ...
> 
>  arch/arm/mach-ixp4xx/Kconfig                   |    8 +
>  arch/arm/mach-ixp4xx/Makefile                  |    2 +
>  arch/arm/mach-ixp4xx/include/mach/uncompress.h |    2 +-
>  arch/arm/mach-ixp4xx/miccpt-pci.c              |   78 +++++++++
>  arch/arm/mach-ixp4xx/miccpt-setup.c            |  219 ++++++++++++++++++++++++
>  5 files changed, 308 insertions(+), 1 deletions(-)
> 
> or would I have to somehow upgrade to DT?

Post them for review again. The rules for new boards are much stricter
now, but we still allow them to get merged if they look good enough.

ixp4xx is not a very active platform, which means that it will take
a while before converting it to device tree probing becomes a priority,
so I would not object adding one board there. It's quite different for
platforms that are still used for new hardware development and have
lots of new boards waiting to get merged.

	Arnd
