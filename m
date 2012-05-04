From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 May 2012 16:38:36 +0100
Subject: [RFC] Remove support for ARMv3 ARM610 and ARM710 CPUs
In-Reply-To: <201205041533.38392.arnd@arndb.de>
References: <20120504095645.GD26481@n2100.arm.linux.org.uk>
 <20120504144643.GG26481@n2100.arm.linux.org.uk>
 <20120504150253.GH26481@n2100.arm.linux.org.uk>
 <201205041533.38392.arnd@arndb.de>
Message-ID: <20120504153836.GJ897@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 03:33:38PM +0000, Arnd Bergmann wrote:
> On Friday 04 May 2012, Russell King - ARM Linux wrote:
> > On Fri, May 04, 2012 at 03:46:43PM +0100, Russell King - ARM Linux wrote:
> > > On Fri, May 04, 2012 at 02:41:24PM +0000, Arnd Bergmann wrote:
> > > > On Friday 04 May 2012, Russell King - ARM Linux wrote:
> > > > > This patch removes support for ARMv3 CPUs, which haven't worked properly
> > > > > for quite some time (see the FIXME comment in arch/arm/mm/fault.c).  The
> > > > > only V3 parts left is the cache model for ARMv3, which is needed for some
> > > > > odd reason by ARM740T CPUs, and being able to build with -march=armv3,
> > > > > which is required for the RiscPC platform due to its bus structure.
> > > > 
> > > > No objections to the patch, but I wonder if this change obsoletes any
> > > > hardware drivers in turn.  Are there any RiscPC peripherals that are
> > > > only available on the older models?
> > > 
> > > "older models" ?  It's not a machine where the CPU is soldered to the
> > > motherboard.  I could describe it as being like an x86 motherboard where
> > > you can plug either an ARM610, ARM710 or StrongARM CPU into it.  The
> > > CPU type is merely incidental.
> > 
> > I'll point out that we can remove drivers if we kill off ARMv4 support,
> > which would mean getting rid of all the StrongARM and FA526 CPU support.
> > That would also mean removing all of ebsa110, footbridge, riscpc, gemini,
> > sa1100, and shark mach- subdirectories.
> 
> Also all ARM720, ARM7TDMI and ARM920/922, right?

These are ARMv4T rather than ARMv4.

> I certainly wouldn't suggest
> that, especially since it looks like we are about to gain support for a new
> ARM920T based platform (lpc31xx) and the renewed interest in ep93xx in
> addition to the StrongARM systems you mention.
> 
> Removing ARM720 support might not hurt as much, but there is also little
> to gain there, since it doesn't cause any problems. I was just asking
> to make sure we remove all code that is known to be unused after the ARMv3
> removal and you already confirmed that there is none.

ARM720T is ARMv4T, so all that you'd gain is the removal of the CPU
support file for that CPU, and the ARMv4 "writethrough cache mode" TLB
support file.  That clocks in around 300 lines... I'd say not worth it
on balance, but I personally wouldn't miss it if it went.
