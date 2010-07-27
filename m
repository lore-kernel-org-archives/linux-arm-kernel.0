From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Jul 2010 10:43:42 +0100
Subject: [PATCH 0/2] Fix ptrace software breakpoints
In-Reply-To: <4C4E36CE.3080108@ti.com>
References: <1279209238-16234-1-git-send-email-will.deacon@arm.com>
	<4C4E36CE.3080108@ti.com>
Message-ID: <002401cb2d70$33206820$99613860$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

> > Will Deacon (2):
> >    ARM: errata: TLBIASIDIS and TLBIMVAIS operations can broadcast a
> >      faulty ASID
> >    ARM: flush_ptrace_access: invalidate all I-caches
> >
> >   arch/arm/Kconfig                |   12 ++++++++++++
> >   arch/arm/include/asm/tlbflush.h |    8 ++++++++
> >   arch/arm/mm/flush.c             |    4 ++--
> >   3 files changed, 22 insertions(+), 2 deletions(-)
> >
> 
> Tested on omap4430 (cortex-a9 SMP).. with this patchset I have yet to
> see it fail, in regular use nor in the test case I wrote to show the
> problem (git://github.com/robclark/gdb-test.git).  Without these
> patches, I'd see SIGILL and missed breakpoints 90+% of the time in
> regular use of gdb (basically gdb was unusable unless I booted with
> nosmp or disabled cache), and 100% of the time in my gdb-test.
> 
> Tested-by: Rob Clark<rob@ti.com>

Thanks for testing this. I've seen the same results on my Versatile
Express board running Ubuntu Lucid.

Russell - can I submit these to the patch system please or do you have
any outstanding concerns?

Cheers,

Will

 
