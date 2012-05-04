From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 May 2012 15:46:43 +0100
Subject: [RFC] Remove support for ARMv3 ARM610 and ARM710 CPUs
In-Reply-To: <201205041441.24573.arnd@arndb.de>
References: <20120504095645.GD26481@n2100.arm.linux.org.uk>
 <201205041441.24573.arnd@arndb.de>
Message-ID: <20120504144643.GG26481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 02:41:24PM +0000, Arnd Bergmann wrote:
> On Friday 04 May 2012, Russell King - ARM Linux wrote:
> > This patch removes support for ARMv3 CPUs, which haven't worked properly
> > for quite some time (see the FIXME comment in arch/arm/mm/fault.c).  The
> > only V3 parts left is the cache model for ARMv3, which is needed for some
> > odd reason by ARM740T CPUs, and being able to build with -march=armv3,
> > which is required for the RiscPC platform due to its bus structure.
> 
> No objections to the patch, but I wonder if this change obsoletes any
> hardware drivers in turn.  Are there any RiscPC peripherals that are
> only available on the older models?

"older models" ?  It's not a machine where the CPU is soldered to the
motherboard.  I could describe it as being like an x86 motherboard where
you can plug either an ARM610, ARM710 or StrongARM CPU into it.  The
CPU type is merely incidental.
