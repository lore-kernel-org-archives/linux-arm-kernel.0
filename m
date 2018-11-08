From: Steve.Capper@arm.com (Steve Capper)
Date: Thu, 8 Nov 2018 10:35:57 +0000
Subject: [PATCH V3 4/5] arm64/mm: Enable HugeTLB migration
In-Reply-To: <1540299721-26484-5-git-send-email-anshuman.khandual@arm.com>
References: <1540299721-26484-1-git-send-email-anshuman.khandual@arm.com>
 <1540299721-26484-5-git-send-email-anshuman.khandual@arm.com>
Message-ID: <20181108103545.c634kha6kpgpy34q@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 06:32:00PM +0530, Anshuman Khandual wrote:
> Let arm64 subscribe to generic HugeTLB page migration framework. Right now
> this only works on the following PMD and PUD level HugeTLB page sizes with
> various kernel base page size combinations.
> 
>        CONT PTE    PMD    CONT PMD    PUD
>        --------    ---    --------    ---
> 4K:         NA     2M         NA      1G
> 16K:        NA    32M         NA
> 64K:        NA   512M         NA
> 
> Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>


Reviewed-by: Steve Capper <steve.capper@arm.com>

> ---
>  arch/arm64/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a8ae30f..4b3e269 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1331,6 +1331,10 @@ config SYSVIPC_COMPAT
>  	def_bool y
>  	depends on COMPAT && SYSVIPC
>  
> +config ARCH_ENABLE_HUGEPAGE_MIGRATION
> +	def_bool y
> +	depends on HUGETLB_PAGE && MIGRATION
> +
>  menu "Power management options"
>  
>  source "kernel/power/Kconfig"
> -- 
> 2.7.4
> 
