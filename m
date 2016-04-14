From: will.deacon@arm.com (Will Deacon)
Date: Thu, 14 Apr 2016 17:39:34 +0100
Subject: [PATCH v3 3/7] arm64: Add helpers for detecting AArch32 support
 at EL0
In-Reply-To: <1459445255-15653-4-git-send-email-suzuki.poulose@arm.com>
References: <1459445255-15653-1-git-send-email-suzuki.poulose@arm.com>
 <1459445255-15653-4-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160414163933.GG4584@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 06:27:31PM +0100, Suzuki K Poulose wrote:
> Adds a helper to extract the support for AArch32 at EL0
> 
> Tested-by: Yury Norov <ynorov@caviumnetworks.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |    7 +++++++
>  arch/arm64/include/asm/sysreg.h     |    1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index b9b6494..7f64285 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -170,6 +170,13 @@ static inline bool id_aa64mmfr0_mixed_endian_el0(u64 mmfr0)
>  		cpuid_feature_extract_unsigned_field(mmfr0, ID_AA64MMFR0_BIGENDEL0_SHIFT) == 0x1;
>  }
>  
> +static inline bool id_aa64pfr0_32bit_el0(u64 pfr0)
> +{
> +	u32 val = cpuid_feature_extract_unsigned_field(pfr0, ID_AA64PFR0_EL0_SHIFT);
> +
> +	return val == ID_AA64PFR0_EL0_32BIT_64BIT;

Should this be >=? What are the rules for this register?

Will
