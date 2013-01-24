From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Jan 2013 14:32:24 +0000
Subject: [PATCH v6 02/15] ARM: Section based HYP idmap
In-Reply-To: <20130116175734.29147.19552.stgit@ubuntu>
References: <20130116175716.29147.15348.stgit@ubuntu>
 <20130116175734.29147.19552.stgit@ubuntu>
Message-ID: <20130124143224.GC18233@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 05:57:34PM +0000, Christoffer Dall wrote:
> --- a/arch/arm/mm/idmap.c
> +++ b/arch/arm/mm/idmap.c
> @@ -1,4 +1,6 @@
> +#include <linux/module.h>

Minor thing - do you need to include linux/module.h here?

> +	identity_mapping_add(hyp_pgd, __hyp_idmap_text_start,
> +			     __hyp_idmap_text_end, PMD_SECT_AP1);

It would be more consistent if you define PMD_SECT_HYP or something like
that. I think you have a L_PTE_HYP bit as well.

-- 
Catalin
