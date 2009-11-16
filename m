From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 16 Nov 2009 11:03:25 +0000
Subject: [GIT PULL] Patches for 2.6.33
In-Reply-To: <20091116105325.GA27894@n2100.arm.linux.org.uk>
References: <1258367694.6705.16.camel@pc1117.cambridge.arm.com>
	<20091116105325.GA27894@n2100.arm.linux.org.uk>
Message-ID: <1258369405.6705.28.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-11-16 at 10:53 +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 16, 2009 at 10:34:54AM +0000, Catalin Marinas wrote:
> > Catalin Marinas (3):
> >       Fix the machine description printing in __error_a
> 
> I think you can drop this one - doesn't 158bc5a cover it?

Yes, I didn't see it.

> >       Add an earlyprintk debug console
> >       ARMv7: Use lazy cache flushing if hardware broadcasts cache operations
> 
> I'm holding off on this - I think I have something similar in smp_plat.h
> in my git tree, and I don't remember whether that stuff has been sent to
> the list as part of my previous patch dump.

Your devel branch only has something on highmem and TLB broadcasting in
smp_plat.h but I tried applying my patch and it fails in other files
like fault-armv.c and flush.c.

Anyway, the for-rmk branch now looks like this:


The following changes since commit c97c5aa83c41a532bc67da356d77da929bc41b9c:
  Catalin Marinas (1):
        RealView: Add sparsemem support for the RealView PBX platform

are available in the git repository at:

  git://linux-arm.org/linux-2.6.git for-rmk

Catalin Marinas (1):
      Add an earlyprintk debug console

Varun Swara (1):
      Do not allow the probing of the local timer

 arch/arm/Kconfig.debug         |    8 +++++
 arch/arm/kernel/Makefile       |    1 +
 arch/arm/kernel/early_printk.c |   57 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/smp_twd.c      |    1 +
 4 files changed, 67 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/kernel/early_printk.c

-- 
Catalin
