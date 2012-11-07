From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Nov 2012 13:39:15 +0000
Subject: Building for MMU-less vexpress targets
In-Reply-To: <201211071259.15107.arnd@arndb.de>
References: <20121105173640.GR3351@mudshark.cambridge.arm.com>
 <201211062114.49933.arnd@arndb.de>
 <20121106221437.GQ28327@n2100.arm.linux.org.uk>
 <201211071259.15107.arnd@arndb.de>
Message-ID: <20121107133915.GX28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2012 at 12:59:14PM +0000, Arnd Bergmann wrote:
> On Tuesday 06 November 2012, Russell King - ARM Linux wrote:
> > Now, we don't _have_ to have the single and multi variants if they aren't
> > appropriate for the platform, but we can cover all the cases: a platform
> > where it's part of the multi-platform kernel when built for MMU, but is
> > incapable of being a multi-platform kernel when built without MMU.
> >
> > And we can do it without _too_ much Kconfig pain, and certainly without
> > having to delve into anything beyond arch/arm/Kconfig.
> 
> Sure, that works. My point was just that I think it would be simpler
> to keep vexpress multiplatform-only if there are no reasons that prevent
> us from doing that.
> 
> I also hope that we can at some point in the future get all ARMv6 and ARMv7
> platforms to be multiplatform-only, while leaving each ARMv4/ARMv5 to be
> any of single, multi, or mixed.

Except... we have one report where this approach already doesn't work,
where we have what is essentially an ARMv7 platform needing to be built
outside the multiplatform stuff...
