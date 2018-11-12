From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 12 Nov 2018 18:00:55 +0000
Subject: [PATCH v6 02/24] arm64: cpufeature: Set SYSREG_GIC_CPUIF as a
 boot system feature
In-Reply-To: <1542023835-21446-3-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-3-git-send-email-julien.thierry@arm.com>
Message-ID: <f2676179-f032-348f-1df1-4631d9cffd35@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/11/2018 11:56, Julien Thierry wrote:
> It is not supported to have some CPUs using GICv3 sysreg CPU interface
> while some others do not.
> 
> Once ICC_SRE_EL1.SRE is set on a CPU, the bit cannot be cleared. Since
> matching this feature require setting ICC_SRE_EL1.SRE, it cannot be
> turned off if found on a CPU.
> 
> Set the feature as STRICT_BOOT, if boot CPU has it, all other CPUs are
> required to have it.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm64/kernel/cpufeature.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index af50064..03a9d96 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1149,7 +1149,7 @@ static void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused)
>   	{
>   		.desc = "GIC system register CPU interface",
>   		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
> -		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
>   		.matches = has_useable_gicv3_cpuif,
>   		.sys_reg = SYS_ID_AA64PFR0_EL1,
>   		.field_pos = ID_AA64PFR0_GIC_SHIFT,
> 

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
