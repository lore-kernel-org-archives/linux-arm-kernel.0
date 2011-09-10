From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 10 Sep 2011 10:23:57 -0400 (EDT)
Subject: [PATCH] ARM: make cpu_is_v6_unaliagned() independent of
	CONFIG_PROC_FS
In-Reply-To: <1315629891-29102-1-git-send-email-eric.y.miao@gmail.com>
References: <1315629891-29102-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <alpine.LFD.2.00.1109101023360.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Sep 2011, Eric Miao wrote:

> From: Eric Miao <eric.miao@linaro.org>
> 
> Signed-off-by: Eric Miao <eric.miao@linaro.org>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>


> ---
>  arch/arm/mm/alignment.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
> index cfbcf8b..2170021 100644
> --- a/arch/arm/mm/alignment.c
> +++ b/arch/arm/mm/alignment.c
> @@ -86,6 +86,12 @@ core_param(alignment, ai_usermode, int, 0600);
>  #define UM_FIXUP	(1 << 1)
>  #define UM_SIGNAL	(1 << 2)
>  
> +/* Return true if and only if the ARMv6 unaligned access model is in use. */
> +static bool cpu_is_v6_unaligned(void)
> +{
> +	return cpu_architecture() >= CPU_ARCH_ARMv6 && (cr_alignment & CR_U);
> +}
> +
>  #ifdef CONFIG_PROC_FS
>  static const char *usermode_action[] = {
>  	"ignored",
> @@ -96,12 +102,6 @@ static const char *usermode_action[] = {
>  	"signal+warn"
>  };
>  
> -/* Return true if and only if the ARMv6 unaligned access model is in use. */
> -static bool cpu_is_v6_unaligned(void)
> -{
> -	return cpu_architecture() >= CPU_ARCH_ARMv6 && (cr_alignment & CR_U);
> -}
> -
>  static int safe_usermode(int new_usermode, bool warn)
>  {
>  	/*
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
