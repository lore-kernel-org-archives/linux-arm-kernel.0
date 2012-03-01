From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Mar 2012 20:46:17 +0000
Subject: [PATCH 5/8] ARM: tegra: work around tegra THUMB2_KERNEL bug
In-Reply-To: <20120301204203.GA19274@n2100.arm.linux.org.uk>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
 <74CDBE0F657A3D45AFBB94109FB122FF17BE861726@HQMAIL01.nvidia.com>
 <20120301204203.GA19274@n2100.arm.linux.org.uk>
Message-ID: <201203012046.17768.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 March 2012, Russell King - ARM Linux wrote:
> On Thu, Mar 01, 2012 at 12:02:42PM -0800, Stephen Warren wrote:
> > Alan Ott wrote at Thursday, March 01, 2012 12:27 PM:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > The tegra smp code cannot currently be built for t2, so
> > > disable that combination for now, as a workaround.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > At least in next-20120229 with the .config I'm using, everything appears
> > to compile fine. The link step does fail, but the error messages I get
> > don't appear to be Tegra specific:
> > 
> > xxx/kernel/sched/clock.c:334: relocation truncated to fit: R_ARM_THM_JUMP11 against symbol `sched_clock' defined in .text section in arch/arm/kernel/built-in.o
> > kernel/built-in.o: In function `post_relocation':
> > xxx/kernel/module.c:2860: relocation truncated to fit: R_ARM_THM_JUMP11 against symbol `module_finalize' defined in .text section in arch/arm/kernel/built-in.o
> > kernel/built-in.o: In function `show_interrupts':
> > xxx/kernel/irq/proc.c:431: relocation truncated to fit: R_ARM_THM_JUMP11 against symbol `arch_show_interrupts' defined in .text section in arch/arm/kernel/built-in.o
> > drivers/built-in.o: In function `pci_set_master':
> > xxx/drivers/pci/pci.c:2674: relocation truncated to fit: R_ARM_THM_JUMP11 against symbol `pcibios_set_master' defined in .text section in arch/arm/kernel/built-in.o
> 
> At a guess, it suggests your kernel image is too big for the relocations
> contained within the code.  That's something for Thumb people to look
> into and solve.

IIRC, that was not the issue I was trying to fix when I originally made the
patch. It's quite likely that the original bug was fixed already, so I'd suggest
we drop the patch for now and see if the problem comes back when all other
randconfig problems have been resolved on Tegra.

	Arnd
