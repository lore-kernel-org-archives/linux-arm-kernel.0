From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 21 May 2018 12:45:22 +0100
Subject: [PATCH v3 1/6] arm64: cpufeature: Allow early detect of specific
 features
In-Reply-To: <1526902515-13769-2-git-send-email-julien.thierry@arm.com>
References: <1526902515-13769-1-git-send-email-julien.thierry@arm.com>
 <1526902515-13769-2-git-send-email-julien.thierry@arm.com>
Message-ID: <697af68e-3cee-4d0d-8493-106cc42eed3b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/05/18 12:35, Julien Thierry wrote:
> From: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Currently it is not possible to detect features of the boot CPU
> until the other CPUs have been brought up.
> 
> This prevents us from reacting to features of the boot CPU until
> fairly late in the boot process. To solve this we allow a subset
> of features (that are likely to be common to all clusters) to be
> detected based on the boot CPU alone.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> [julien.thierry at arm.com: check non-boot cpu missing early features, avoid
> 			 duplicates between early features and normal
> 			 features]
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>

nit: Since this is completely different from what Daniel started with,
you could simply reset the author to yourself. The boot CPU feature was
added keeping this user in mind.

The patch as such looks good to me.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> ---
>   arch/arm64/kernel/cpufeature.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9d1b06d..e03e897 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1030,7 +1030,7 @@ static void cpu_copy_el2regs(const struct arm64_cpu_capabilities *__unused)
>   	{
>   		.desc = "GIC system register CPU interface",
>   		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
> -		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
>   		.matches = has_useable_gicv3_cpuif,
>   		.sys_reg = SYS_ID_AA64PFR0_EL1,
>   		.field_pos = ID_AA64PFR0_GIC_SHIFT,
> --
> 1.9.1
> 
