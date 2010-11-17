From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Nov 2010 11:05:23 +0000
Subject: [PATCH 2/9] ARM: smp: pass an ipi number to smp_cross_call()
In-Reply-To: <E1PI3Jm-00029a-GK@rmk-PC.arm.linux.org.uk>
References: <20101115175553.GC31421@n2100.arm.linux.org.uk>
	<E1PI3Jm-00029a-GK@rmk-PC.arm.linux.org.uk>
Message-ID: <1289991923.2351.18.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-11-15 at 17:58 +0000, Russell King - ARM Linux wrote:
> --- a/arch/arm/mach-msm/include/mach/smp.h
> +++ b/arch/arm/mach-msm/include/mach/smp.h
> @@ -31,9 +31,9 @@
> 
>  #include <asm/hardware/gic.h>
> 
> -static inline void smp_cross_call(const struct cpumask *mask)
> +static inline void smp_cross_call(const struct cpumask *mask, int ipi)
>  {
> -       gic_raise_softirq(mask, 1);
> +       gic_raise_softirq(mask, ipi);
>  }

BTW, why don't we make smp_cross_call() generic, it looks like all
platforms define the same thing.

Unless we get SMP systems in the future without a GIC.

-- 
Catalin
