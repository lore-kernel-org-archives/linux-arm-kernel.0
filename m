From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 May 2013 15:32:36 +0100
Subject: [RFC PATCH v2 09/11] ARM64: mm: HugeTLB support.
In-Reply-To: <1368006763-30774-10-git-send-email-steve.capper@linaro.org>
References: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
 <1368006763-30774-10-git-send-email-steve.capper@linaro.org>
Message-ID: <20130516143236.GD18308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 10:52:41AM +0100, Steve Capper wrote:
> --- /dev/null
> +++ b/arch/arm64/include/asm/hugetlb.h
...
> +static inline int pud_large(pud_t pud)
> +{
> +	return !(pud_val(pud) & PUD_TABLE_BIT);
> +}

I already commented on this - do we really need pud_large() which is
the same as pud_huge()? It's only defined on x86 and can be safely
replaced with pud_huge().

> --- /dev/null
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -0,0 +1,70 @@
...
> +int pmd_huge(pmd_t pmd)
> +{
> +	return !(pmd_val(pmd) & PMD_TABLE_BIT);
> +}
> +
> +int pud_huge(pud_t pud)
> +{
> +	return !(pud_val(pud) & PUD_TABLE_BIT);
> +}

You could even go further and make pud/pmd_huge static inline functions
for slightly better efficiency (needs changing in the linux/hugetlb.h
header).

-- 
Catalin
