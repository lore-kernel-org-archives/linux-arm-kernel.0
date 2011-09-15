From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Sep 2011 17:26:02 +0200
Subject: READ THIS: the next mach-types update
In-Reply-To: <20110915102528.GI6267@n2100.arm.linux.org.uk>
References: <20110915102528.GI6267@n2100.arm.linux.org.uk>
Message-ID: <201109151726.02445.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 September 2011, Russell King - ARM Linux wrote:
> Moreover, entries older than 12 months which have not been merged will
> be removed.  It is not possible to automatically check for machine_is_xxx()
> usages as these could conflict with other architectures, and I'm
> certainly NOT checking for them by hand (I estimate that'd take a
> significant amount of manual effort to do.)  What that means is that it
> is important to get the core platform support in first before any
> drivers which may make use of this.

Hi Russell,

I've just tried checking the machine_is_xxx() values in the kernel for
the list you posted and found just two that are actually being used:

arch/arm/mach-orion5x/ts209-setup.c:    if (machine_is_ts_x09())
arch/arm/mach-kirkwood/sheevaplug-setup.c:      if (machine_is_sheeva_esata())

Would it be possible to just fix these to use the correct form instead,
along with the respective mach-types change?

	Arnd
