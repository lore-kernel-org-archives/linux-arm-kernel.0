From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 16 Aug 2011 11:06:01 +0200
Subject: [PATCH v2 1/8] ARM: cpuid: add support for reading MPIDR
In-Reply-To: <1313429452-2820-2-git-send-email-will.deacon@arm.com>
References: <1313429452-2820-1-git-send-email-will.deacon@arm.com>
	<1313429452-2820-2-git-send-email-will.deacon@arm.com>
Message-ID: <CAKfTPtCzr0hgbfcmBy5rT1C6HO+Uq6g0wHsgfuP1V3zyo0scPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

The read_cpuid_mpidr function has been added in a previous patch :

http://lists.arm.linux.org.uk/lurker/message/20110705.131623.8f41d3a6.en.html

It's now in Russell's patch system: ref 7011/1

Vincent

On 15 August 2011 19:30, Will Deacon <will.deacon@arm.com> wrote:
> The MPIDR register forms part of the CPUID interface and allows software
> to determine the physical ID of the CPU on which it is currently
> executing.
>
> This patch adds support for reading the MPIDR to cputype.h
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> ?arch/arm/include/asm/cputype.h | ? ?6 ++++++
> ?1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
> index cd4458f..cb47d28 100644
> --- a/arch/arm/include/asm/cputype.h
> +++ b/arch/arm/include/asm/cputype.h
> @@ -8,6 +8,7 @@
> ?#define CPUID_CACHETYPE ? ? ? ?1
> ?#define CPUID_TCM ? ? ?2
> ?#define CPUID_TLBTYPE ?3
> +#define CPUID_MPIDR ? ?5
>
> ?#define CPUID_EXT_PFR0 "c1, 0"
> ?#define CPUID_EXT_PFR1 "c1, 1"
> @@ -70,6 +71,11 @@ static inline unsigned int __attribute_const__ read_cpuid_tcmstatus(void)
> ? ? ? ?return read_cpuid(CPUID_TCM);
> ?}
>
> +static inline unsigned int __attribute_const__ read_cpuid_mpidr(void)
> +{
> + ? ? ? return read_cpuid(CPUID_MPIDR);
> +}
> +
> ?/*
> ?* Intel's XScale3 core supports some v6 features (supersections, L2)
> ?* but advertises itself as v5 as it does not support the v6 ISA. ?For
> --
> 1.7.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
