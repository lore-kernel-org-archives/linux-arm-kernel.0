From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Tue, 10 Nov 2015 12:34:08 +0100
Subject: [PATCH] arm64: add HAVE_LATENCYTOP_SUPPORT config
In-Reply-To: <20151110111829.GD31947@arm.com>
References: <1446825478-24824-1-git-send-email-yalin.wang2010@gmail.com>
 <20151106160501.GR6087@arm.com>
 <247F438B-3EEA-4550-970E-A649D0E604ED@gmail.com>
 <20151106162109.GT6087@arm.com> <20151110074124.GB6672@osiris>
 <20151110100547.GC31947@arm.com> <20151110110145.GE6672@osiris>
 <20151110111829.GD31947@arm.com>
Message-ID: <20151110113408.GF6672@osiris>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Will Deacon <will.deacon@arm.com>
> Date: Tue, 10 Nov 2015 11:10:04 +0000
> Subject: [PATCH] Kconfig: remove HAVE_LATENCYTOP_SUPPORT
> 
> As illustrated by a3afe70b83fd ("[S390] latencytop s390 support."),
> HAVE_LATENCYTOP_SUPPORT is defined by an architecture to advertise an
> implementation of save_stack_trace_tsk.
> 
> However, as of 9212ddb5eada ("stacktrace: provide save_stack_trace_tsk()
> weak alias") a dummy implementation is provided if STACKTRACE=y.
> Given that LATENCYTOP already depends on STACKTRACE_SUPPORT and selects
> STACKTRACE, we can remove HAVE_LATENCYTOP_SUPPORT altogether.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arc/Kconfig        | 3 ---
>  arch/arm/Kconfig        | 5 -----
>  arch/metag/Kconfig      | 3 ---
>  arch/microblaze/Kconfig | 3 ---
>  arch/parisc/Kconfig     | 3 ---
>  arch/powerpc/Kconfig    | 3 ---
>  arch/s390/Kconfig       | 3 ---
>  arch/sh/Kconfig         | 3 ---
>  arch/sparc/Kconfig      | 4 ----
>  arch/unicore32/Kconfig  | 3 ---
>  arch/x86/Kconfig        | 3 ---
>  lib/Kconfig.debug       | 1 -
>  12 files changed, 37 deletions(-)

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
