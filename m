From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 15 Aug 2016 11:44:06 +0100
Subject: [PATCH] arm64: cpufeature: allow for version discrepancy in PMU
 implementations
In-Reply-To: <1471257732-29594-1-git-send-email-will.deacon@arm.com>
References: <1471257732-29594-1-git-send-email-will.deacon@arm.com>
Message-ID: <9e66d0db-a304-34c8-cec0-0f1329ec8dc7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/08/16 11:42, Will Deacon wrote:
> Perf already supports multiple PMU instances for heterogeneous systems,
> so there's no need to be strict in the cpufeature checking, particularly
> as the PMU extension is optional in the architecture.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 62272eac1352..a65a638965a4 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -172,7 +172,11 @@ static struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
>  	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_CTX_CMPS_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_WRPS_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_BRPS_SHIFT, 4, 0),
> -	S_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64DFR0_PMUVER_SHIFT, 4, 0),
> +	/*
> +	 * We can instantiate multiple PMU instances with different levels
> +	 * of support.
> +	 * */
> +	S_ARM64_FTR_BITS(FTR_NONSTRICT, FTR_EXACT, ID_AA64DFR0_PMUVER_SHIFT, 4, 0),


Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Suzuki
