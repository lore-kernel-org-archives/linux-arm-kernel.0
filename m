From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 22 Jun 2018 18:47:37 +0800
Subject: [PATCH v2] arm64: kpti: Use early_param for kpti= command-line
 option
In-Reply-To: <1529659525-21340-1-git-send-email-will.deacon@arm.com>
References: <1529659525-21340-1-git-send-email-will.deacon@arm.com>
Message-ID: <5B2CD3C9.6040606@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 2018/6/22 17:25, Will Deacon wrote:
> We inspect __kpti_forced early on as part of the cpufeature enable
> callback which remaps the swapper page table using non-global entries.
>
> Ensure that __kpti_forced has been updated to reflect the kpti=
> command-line option before we start using it.
>
> Reported-by: Wei Xu <xuwei5@hisilicon.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
Thanks!
Tested and works on a hisilicon platform.

Tested-by: Wei Xu <xuwei5@hisilicon.com>

Best Regards,
Wei

> ---
>
> v1->v2: Fix typo (remove '=' from option)
>
>   arch/arm64/kernel/cpufeature.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index d2856b129097..f24892a40d2c 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -937,7 +937,7 @@ static int __init parse_kpti(char *str)
>   	__kpti_forced = enabled ? 1 : -1;
>   	return 0;
>   }
> -__setup("kpti=", parse_kpti);
> +early_param("kpti", parse_kpti);
>   #endif	/* CONFIG_UNMAP_KERNEL_AT_EL0 */
>   
>   #ifdef CONFIG_ARM64_HW_AFDBM
