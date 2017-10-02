From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 2 Oct 2017 13:17:01 +0100
Subject: [PATCH] arm64: fix misleading data abort decoding
In-Reply-To: <1506944520-21998-1-git-send-email-mark.rutland@arm.com>
References: <1506944520-21998-1-git-send-email-mark.rutland@arm.com>
Message-ID: <79b16fda-43be-63f5-aabd-9078f92a97aa@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/10/17 12:42, Mark Rutland wrote:
> Currently data_abort_decode() dumps the ISS field as a decimal value
> with a '0x' prefix, which is somewhat misleading.
> 
> Fix it to print as hexadecimal, as was intended.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Julien Thierry <julien.thierry@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Fixes: 1f9b8936f36f4a8e ("arm64: Decode information from ESR upon mem faults")
> ---
>   arch/arm64/mm/fault.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 89993c4b..a6d5281 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -97,7 +97,7 @@ static void data_abort_decode(unsigned int esr)
>   			 (esr & ESR_ELx_SF) >> ESR_ELx_SF_SHIFT,
>   			 (esr & ESR_ELx_AR) >> ESR_ELx_AR_SHIFT);
>   	} else {
> -		pr_alert("  ISV = 0, ISS = 0x%08lu\n", esr & ESR_ELx_ISS_MASK);
> +		pr_alert("  ISV = 0, ISS = 0x%08lx\n", esr & ESR_ELx_ISS_MASK);

Whoops, thanks for catching that.

FWIW:
reviewed-by: Julien Thierry <julien.thierry@arm.com>

Thanks,

-- 
Julien Thierry
