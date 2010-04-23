From: janboe.ye@gmail.com (Janboe Ye)
Date: Fri, 23 Apr 2010 11:05:56 +0800
Subject: [PATCH 0/8] Initial implementation of kdump for ARM
In-Reply-To: <20100422120308.GD26418@gw.healthdatacare.com>
References: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
	<20100422120308.GD26418@gw.healthdatacare.com>
Message-ID: <20100423030556.GA8012@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am trying this. But it seems need to do a lot work to make kdump
to work on other omap3 board.

Janboe
On Thu, Apr 22, 2010 at 03:03:08PM +0300, Mika Westerberg wrote:
> On Tue, Apr 20, 2010 at 11:50:46AM +0300, Mika Westerberg wrote:
> > Hello,
> > 
> > This is revised series of kdump code, now without "RFC"-prefix. Original
> > series can be found here:
> > 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/012353.html
> > 
> > Changes to previous version:
> > 	- crash_setup_regs() uses Russell's suggestion for saving registers
> > 	- copy_oldmem_page() code is changed to use ioremap()
> > 	- there is no need for special 'mem=' parameters
> > 
> > I've been testing this on my N900.
> > 
> > I have patches for kexec-tools ready and send them once this kernel part is
> > accepted.
> 
> Hi,
> 
> Any comments on this?
> 
> Thanks,
> MW
> 
> > 
> > As a sidenote: I got crashkernel booting correctly just by modifying PHYS_OFFSET
> > and mach/Makefile.boot for my platform. So it is enough just to pass 'mem=size'
> > to dump capture kernel. This is documented in Kconfig CONFIG_CRASH_DUMP.
> > 
> > Regards,
> > MW
> > 
> > Mika Westerberg (8):
> >   arm: kdump: reserve memory for crashkernel
> >   arm: kdump: implement crash_setup_regs()
> >   arm: kdump: implement machine_crash_shutdown()
> >   arm: kdump: skip indirection page when crashing
> >   arm: kdump: implement copy_oldmem_page()
> >   arm: allow passing an ELF64 header to elf_check_arch()
> >   arm: kdump: add support for elfcorehdr= parameter
> >   arm: kdump: add CONFIG_CRASH_DUMP Kconfig option
> > 
> >  arch/arm/Kconfig                  |   12 ++++++
> >  arch/arm/include/asm/elf.h        |    4 +-
> >  arch/arm/include/asm/kexec.h      |   22 +++++++++-
> >  arch/arm/kernel/Makefile          |    1 +
> >  arch/arm/kernel/crash_dump.c      |   58 ++++++++++++++++++++++++++++
> >  arch/arm/kernel/elf.c             |    6 ++-
> >  arch/arm/kernel/machine_kexec.c   |    4 ++
> >  arch/arm/kernel/relocate_kernel.S |    6 +++
> >  arch/arm/kernel/setup.c           |   76 +++++++++++++++++++++++++++++++++++++
> >  9 files changed, 182 insertions(+), 7 deletions(-)
> >  create mode 100644 arch/arm/kernel/crash_dump.c
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
