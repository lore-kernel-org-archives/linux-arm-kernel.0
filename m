From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Mar 2013 15:26:34 +0000
Subject: Starting the kernel on Core1 of a Cortex-A9 system
In-Reply-To: <5130BFA6.5020701@fh-trier.de>
References: <5130BFA6.5020701@fh-trier.de>
Message-ID: <20130301152633.GF17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 01, 2013 at 03:48:06PM +0100, Till Crueger wrote:
> Does anybody have any other possible explanation why this behavior might
> be different on Core0 and Core1? The Bootloader (U-Boot) only runs on
> Core0 so there might be some initialization that is missing for Core1,
> but I cannot figure out which one.

What you describe is consistent with data being left in the caches and
not written back to physical memory.

I know that TI have said many times that the secure firmware that they
have on their devices only works from Core 0, but that shouldn't be
involved at this point in the boot process.

Maybe the L2 cache is left on somehow when booting from Core 1 and
that isn't the case when Core 0 is used to boot via the boot loader?
