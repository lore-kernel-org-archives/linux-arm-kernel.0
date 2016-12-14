From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 14 Dec 2016 14:45:50 +0000
Subject: [RESEND PATCH 1/2] arm64: change from CONT_PMD_SHIFT to
 CONT_PTE_SHIFT
In-Reply-To: <1481725151-20549-2-git-send-email-zhongjiang@huawei.com>
References: <1481725151-20549-1-git-send-email-zhongjiang@huawei.com>
 <1481725151-20549-2-git-send-email-zhongjiang@huawei.com>
Message-ID: <CAKv+Gu8Qh8N+fagYqtO_04fZ=Wxg5S-=4bmPD0bxQrSyb+NZvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 December 2016 at 14:19, zhongjiang <zhongjiang@huawei.com> wrote:
> From: zhong jiang <zhongjiang@huawei.com>
>
> I think that CONT_PTE_SHIFT is more reasonable even if they are some
> value. and the patch is not any functional change.
>

This may be the case for 64k pages, but not for 16k pages, and I
actually think add_default_hugepagesz() could be made unconditional,
given that both 64k on 4k kernels and 2 MB on 16k kernels are useful
hugepage sizes that are not otherwise available by default.

> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/mm/hugetlbpage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 2e49bd2..0a4c97b 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -323,7 +323,7 @@ static __init int setup_hugepagesz(char *opt)
>  static __init int add_default_hugepagesz(void)
>  {
>         if (size_to_hstate(CONT_PTES * PAGE_SIZE) == NULL)
> -               hugetlb_add_hstate(CONT_PMD_SHIFT);
> +               hugetlb_add_hstate(CONT_PTE_SHIFT);
>         return 0;
>  }
>  arch_initcall(add_default_hugepagesz);
> --
> 1.8.3.1
>
