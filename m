From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Jul 2016 17:30:02 +0100
Subject: [PATCH 06/11] arm: arm64: Add routine to determine cpuid of
 other cpus
In-Reply-To: <1466529109-21715-7-git-send-email-jeremy.linton@arm.com>
References: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
 <1466529109-21715-7-git-send-email-jeremy.linton@arm.com>
Message-ID: <20160706163001.GC31910@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 12:11:44PM -0500, Jeremy Linton wrote:
> It is helpful if we can read the cpuid/midr of other CPUs
> in the system independent of arm/arm64.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm/include/asm/cputype.h   | 6 +++++-
>  arch/arm64/include/asm/cputype.h | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
> index 1ee94c7..e391b67 100644
> --- a/arch/arm/include/asm/cputype.h
> +++ b/arch/arm/include/asm/cputype.h
> @@ -81,6 +81,8 @@
>  #define ARM_CPU_XSCALE_ARCH_V2		0x4000
>  #define ARM_CPU_XSCALE_ARCH_V3		0x6000
>  
> +#define ARM_PARTNUM(cpuid_id) (cpuid_id & ARM_CPU_PART_MASK)
> +
>  extern unsigned int processor_id;
>  
>  #ifdef CONFIG_CPU_CP15
> @@ -180,7 +182,7 @@ static inline unsigned int __attribute_const__ read_cpuid_implementor(void)
>   */
>  static inline unsigned int __attribute_const__ read_cpuid_part(void)
>  {
> -	return read_cpuid_id() & ARM_CPU_PART_MASK;
> +	return ARM_PARTNUM(read_cpuid_id());

I don't understand why you need to make this change.

Will
