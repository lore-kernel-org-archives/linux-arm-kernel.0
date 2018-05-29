From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 29 May 2018 16:44:38 +0200
Subject: [PATCH v3 3/3] x86/mm: add TLB purge to free pmd/pte page
 interfaces
In-Reply-To: <20180516233207.1580-4-toshi.kani@hpe.com>
References: <20180516233207.1580-1-toshi.kani@hpe.com>
 <20180516233207.1580-4-toshi.kani@hpe.com>
Message-ID: <20180529144438.GM18595@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 05:32:07PM -0600, Toshi Kani wrote:
>  	pmd = (pmd_t *)pud_page_vaddr(*pud);
> +	pmd_sv = (pmd_t *)__get_free_page(GFP_KERNEL);
> +	if (!pmd_sv)
> +		return 0;

So your code still needs to allocate a full page where a simple
list_head on the stack would do the same job.

Ingo, Thomas, can you please just revert the original broken patch for
now until there is proper fix?

Thanks,

	Joerg
