From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Jan 2017 18:06:26 +0000
Subject: [PATCH v3 7/9] arm64: cpufeature: Track user visible fields
In-Reply-To: <1483552147-9605-8-git-send-email-suzuki.poulose@arm.com>
References: <1483552147-9605-1-git-send-email-suzuki.poulose@arm.com>
 <1483552147-9605-8-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170105180626.GH29765@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 05:49:05PM +0000, Suzuki K. Poulose wrote:
> Track the user visible fields of a CPU feature register. This will be
> used for exposing the value to the userspace. All the user visible
> fields of a feature register will be passed on as it is, while the
> others would be filled with their respective safe value.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

> @@ -81,75 +82,75 @@ cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused)
>  
>  
>  static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
> -	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64ISAR0_RDM_SHIFT, 4, 0),
> -	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_ATOMICS_SHIFT, 4, 0),
> -	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_CRC32_SHIFT, 4, 0),
> -	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_SHA2_SHIFT, 4, 0),
> -	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_SHA1_SHIFT, 4, 0),
> -	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_AES_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64ISAR0_RDM_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_ATOMICS_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_CRC32_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_SHA2_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_SHA1_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_AES_SHIFT, 4, 0),

BTW, as a separate patch I think we need to expose the RDM field in this
register as well, together with a corresponding HWCAP bit.

-- 
Catalin
