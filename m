From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 3 Jan 2017 12:31:20 +0000
Subject: [RESEND PATCH 1/2] arm64: change from CONT_PMD_SHIFT to
 CONT_PTE_SHIFT
In-Reply-To: <1481725151-20549-2-git-send-email-zhongjiang@huawei.com>
References: <1481725151-20549-1-git-send-email-zhongjiang@huawei.com>
 <1481725151-20549-2-git-send-email-zhongjiang@huawei.com>
Message-ID: <20170103123120.GA1244@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2016 at 10:19:10PM +0800, zhongjiang wrote:
> From: zhong jiang <zhongjiang@huawei.com>
> 
> I think that CONT_PTE_SHIFT is more reasonable even if they are some
> value. and the patch is not any functional change.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
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
>  	if (size_to_hstate(CONT_PTES * PAGE_SIZE) == NULL)
> -		hugetlb_add_hstate(CONT_PMD_SHIFT);
> +		hugetlb_add_hstate(CONT_PTE_SHIFT);
>  	return 0;
>  }
>  arch_initcall(add_default_hugepagesz);

It looks like I fixed this already when I merged some other hugetlb
patches. See commit 6ed0038d5ecb ("arm64: Fix typo in
add_default_hugepagesz() for 64K pages").

-- 
Catalin
