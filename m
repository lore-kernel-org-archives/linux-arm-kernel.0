From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Oct 2013 10:53:22 +0100
Subject: [PATCH v3 1/2] KVM: ARM: Support hugetlbfs backed huge pages
In-Reply-To: <1380903201-32644-2-git-send-email-christoffer.dall@linaro.org>
References: <1380903201-32644-1-git-send-email-christoffer.dall@linaro.org>
 <1380903201-32644-2-git-send-email-christoffer.dall@linaro.org>
Message-ID: <20131007095321.GB32012@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 04, 2013 at 05:13:20PM +0100, Christoffer Dall wrote:
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -85,6 +85,8 @@
>  #define PTE_S2_RDONLY          (_AT(pteval_t, 1) << 6)   /* HAP[2:1] */
>  #define PTE_S2_RDWR            (_AT(pteval_t, 3) << 6)   /* HAP[2:1] */
> 
> +#define PMD_S2_RDWR            (_AT(pmdval_t, 3) << 6)   /* HAP[2:1] */
> +
>  /*
>   * Memory Attribute override for Stage-2 (MemAttr[3:0])
>   */

For the arm64 part:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
