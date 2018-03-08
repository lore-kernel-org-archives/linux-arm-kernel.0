From: willy@infradead.org (Matthew Wilcox)
Date: Wed, 7 Mar 2018 20:00:16 -0800
Subject: [PATCH 1/2] mm/vmalloc: Add interfaces to free unused page table
In-Reply-To: <20180307183227.17983-2-toshi.kani@hpe.com>
References: <20180307183227.17983-1-toshi.kani@hpe.com>
 <20180307183227.17983-2-toshi.kani@hpe.com>
Message-ID: <20180308040016.GB9082@bombadil.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2018 at 11:32:26AM -0700, Toshi Kani wrote:
> +/**
> + * pud_free_pmd_page - clear pud entry and free pmd page
> + *
> + * Returns 1 on success and 0 on failure (pud not cleared).
> + */
> +int pud_free_pmd_page(pud_t *pud)
> +{
> +	return pud_none(*pud);
> +}

Wouldn't it be clearer if you returned 'bool' instead of 'int' here?

Also you didn't document the pud parameter, nor use the approved form
for documenting the return type, nor the calling context.  So I would
have written it out like this:

/**
 * pud_free_pmd_page - Clear pud entry and free pmd page.
 * @pud: Pointer to a PUD.
 *
 * Context: Caller should hold mmap_sem write-locked.
 * Return: %true if clearing the entry succeeded.
 */
