From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 03 Feb 2011 17:11:28 +0000
Subject: [PATCH v4 08/19] ARM: LPAE: Introduce the 3-level page table
	format definitions
In-Reply-To: <1295891761-18366-9-git-send-email-catalin.marinas@arm.com>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-9-git-send-email-catalin.marinas@arm.com>
Message-ID: <1296753088.28466.18.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-01-24 at 17:55 +0000, Catalin Marinas wrote:
> --- /dev/null
> +++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
> @@ -0,0 +1,81 @@
[...]
> +#define PMD_SECT_UNCACHED      (_AT(pteval_t, 0) << 2) /* strongly ordered */
> +#define PMD_SECT_BUFFERED      (_AT(pteval_t, 1) << 2) /* normal non-cacheable */
> +#define PMD_SECT_WT            (_AT(pteval_t, 2) << 2) /* normal inner write-through */
> +#define PMD_SECT_WB            (_AT(pteval_t, 3) << 2) /* normal inner write-back */
> +#define PMD_SECT_WBWA          (_AT(pteval_t, 7) << 2) /* normal inner write-alloc */

The above definitions should use pmdval_t rather than pteval_t (fixup
pushed to the arm-lpae branch).

-- 
Catalin
