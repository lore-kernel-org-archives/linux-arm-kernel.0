From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Mon, 23 May 2011 17:49:44 +0100
Subject: [PATCH] ARM: fix missing 'cpu_relax()' declaration
In-Reply-To: <20110523164508.GE15138@n2100.arm.linux.org.uk>
References: <1306157607-18406-1-git-send-email-marc.zyngier@arm.com>
	<20110523160944.GA15138@n2100.arm.linux.org.uk>
	<20110523162339.GC15138@n2100.arm.linux.org.uk>
	<1306168473.27474.88.camel@e102391-lin.cambridge.arm.com>
	<20110523164123.GD15138@n2100.arm.linux.org.uk>
	<20110523164508.GE15138@n2100.arm.linux.org.uk>
Message-ID: <1306169384.27474.95.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-05-23 at 17:45 +0100, Russell King - ARM Linux wrote:
> On Mon, May 23, 2011 at 05:41:23PM +0100, Russell King - ARM Linux wrote:
> > On Mon, May 23, 2011 at 05:34:33PM +0100, Marc Zyngier wrote:
> > > Odd... It seems to build just fine here with UP:
> > > 
> > > $ grep SMP .config
> > > CONFIG_BROKEN_ON_SMP=y
> > > # CONFIG_SMP is not set
> > > $ time make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- -j4 all
> > >   CHK     include/linux/version.h
> > >   HOSTCC  scripts/basic/fixdep
> > >   HOSTCC  scripts/basic/docproc
> > >   HOSTCC  scripts/kallsyms
> > >   HOSTCC  scripts/conmakehash
> > >   CC      scripts/mod/empty.o
> > >   HOSTCC  scripts/mod/mk_elfconfig
> > >   MKELF   scripts/mod/elfconfig.h
> > >   HOSTCC  scripts/mod/file2alias.o
> > >   HOSTCC  scripts/mod/modpost.o
> > >   HOSTCC  scripts/mod/sumversion.o
> > >   HOSTLD  scripts/mod/modpost
> > >   CHK     include/generated/utsrelease.h
> > > make[1]: `include/generated/mach-types.h' is up to date.
> > >   CC      kernel/bounds.s
> > >   GEN     include/generated/bounds.h
> > >   CC      arch/arm/kernel/asm-offsets.s
> > >   GEN     include/generated/asm-offsets.h
> > >   CALL    scripts/checksyscalls.sh
> > > <stdin>:1554: warning: #warning syscall sendmmsg not implemented
> > >   CC      init/main.o
> > >   CHK     include/generated/compile.h
> > >   HOSTCC  usr/gen_init_cpio
> > > [...]
> > 
> > For what platform?  I've tried a few and getting the same error message.
> 
> Found it, my for-next tree has the prefetching change but not this:
> 
> commit d974d905cbfc1039a73ba0c7eea3f4d4e13c0624
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date:   Fri May 20 15:48:17 2011 +1000
> 
>     spinlock_up.h: include asm/processor.h in for cpu_relax
> 
> which fixes the UP build problem.
> 

Makes sense. Thanks for solving the mystery!

	M.

-- 
Reality is an implementation detail.
