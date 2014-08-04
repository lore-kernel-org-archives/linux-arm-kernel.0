From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 4 Aug 2014 10:06:15 +0100
Subject: [PATCH 1/3] arm64: fix typo in I-cache policy detection
In-Reply-To: <1407140216-22747-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1407140216-22747-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140804090615.GA16525@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 04, 2014 at 09:16:54AM +0100, Ard Biesheuvel wrote:
> This removes an unfortunately placed semi-colon resulting in all instruction
> caches being classified as AIVIVT.

Whoops, my bad. That obviously shouldn't have been there:

Acked-by: Mark Rutland <mark.rutland@arm.com>

At least this results in a performance hit rather than completely
erroneous operation.

Mark.

> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/cpuinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index f82f7d1c468e..744fad2ff418 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -49,7 +49,7 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
>  
>  	if (l1ip != ICACHE_POLICY_PIPT)
>  		set_bit(ICACHEF_ALIASING, &__icache_flags);
> -	if (l1ip == ICACHE_POLICY_AIVIVT);
> +	if (l1ip == ICACHE_POLICY_AIVIVT)
>  		set_bit(ICACHEF_AIVIVT, &__icache_flags);
>  
>  	pr_info("Detected %s I-cache on CPU%d", icache_policy_str[l1ip], cpu);
> -- 
> 1.8.3.2
> 
> 
