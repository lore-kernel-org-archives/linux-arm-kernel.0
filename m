From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Jan 2015 11:20:19 +0000
Subject: arm64 fails to build in -next
In-Reply-To: <20150107111642.GU2634@sirena.org.uk>
References: <E1Y8ilQ-00009L-4i@debutante> <20150107111642.GU2634@sirena.org.uk>
Message-ID: <20150107112019.GI7485@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 11:16:42AM +0000, Mark Brown wrote:
> On Wed, Jan 07, 2015 at 05:02:36AM +0000, Build bot for Mark Brown wrote:
> 
> > Failed defconfigs:
> > 	arm64-allnoconfig
> > 	arm64-allmodconfig
> > 	arm64-defconfig
> 
> For the past few days the arm64 tree hasn't built at all in -next as far
> as I can see:
> 
> > 	arm64-allmodconfig
> > ../arch/arm64/include/asm/processor.h:47:32: error: 'PHYS_MASK' undeclared (first use in this function)
> > ../arch/arm64/include/asm/processor.h:47:32: error: 'PHYS_MASK' undeclared (first use in this function)
> > ../arch/arm64/include/asm/processor.h:47:32: error: 'PHYS_MASK' undeclared (first use in this function)
> > ../arch/arm64/include/asm/processor.h:47:32: error: 'PHYS_MASK' undeclared (first use in this function)
> > ../arch/arm64/mm/dump.c:55:20: error: 'PCI_IOBASE' undeclared here (not in a function)
> > ../arch/arm64/include/asm/arch_timer.h:112:2: error: implicit declaration of function 'BUG' [-Werror=implicit-function-declaration]
> > ../arch/arm64/kernel/module.c:408:4: error: implicit declaration of function 'apply_alternatives' [-Werror=implicit-function-declaration]
> > ../arch/arm64/kernel/smp_spin_table.c:80:2: error: implicit declaration of function 'ioremap_cache' [-Werror=implicit-function-declaration]
> > ../arch/arm64/kernel/smp_spin_table.c:92:2: error: implicit declaration of function 'writeq_relaxed' [-Werror=implicit-function-declaration]
> > ../arch/arm64/kernel/smp_spin_table.c:101:2: error: implicit declaration of function 'iounmap' [-Werror=implicit-function-declaration]
> > ../arch/arm64/include/asm/processor.h:47:32: error: 'PHYS_MASK' undeclared (first use in this function)
> > ../arch/arm64/include/asm/processor.h:47:32: error: 'PHYS_MASK' undeclared (first use in this function)
> > ../arch/arm64/include/asm/processor.h:47:32: error: 'PHYS_MASK' undeclared (first use in this function)
> > ../arch/arm64/include/asm/processor.h:47:32: error: 'PHYS_MASK' undeclared (first use in this function)
> > ../arch/arm64/include/asm/processor.h:47:32: error: 'PHYS_MASK' undeclared (first use in this function)
> > ../arch/arm64/include/asm/processor.h:47:32: error: 'PHYS_MASK' undeclared (first use in this function)
> > ../arch/arm64/include/asm/processor.h:47:32: error: 'PHYS_MASK' undeclared (first use in this function)
> > ../arch/arm64/include/asm/processor.h:47:32: error: 'PHYS_MASK' undeclared (first use in this function)
> > ../arch/arm64/include/asm/processor.h:47:32: error: 'PHYS_MASK' undeclared (first use in this function)
> > ../arch/arm64/include/asm/processor.h:47:32: error: 'PHYS_MASK' undeclared (first use in this function)
> > ../arch/arm64/include/asm/processor.h:47:32: error: 'PHYS_MASK' undeclared (first use in this function)
> > ../arch/arm64/include/asm/processor.h:47:32: error: 'PHYS_MASK' undeclared (first use in this function)
> > ../arch/arm64/include/asm/processor.h:47:32: error: 'PHYS_MASK' undeclared (first use in this function)
> > ../arch/arm64/include/asm/processor.h:47:32: error: 'PHYS_MASK' undeclared (first use in this function)
> 
> The other builds have a subset of these errors.  I spoke to Will on IRC
> yesterday and he mentioned a missing includes fix from Paul Walmsley,
> I've not seen that fix but it sounds like it may well be relevant.

Paul posted a new series of his fixes this morning, so I'll send them in the
pull for -rc4.

Will
