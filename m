From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Dec 2017 15:40:57 +0000
Subject: [PATCH v2 5/8] arm64: don't open code page table entry creation
In-Reply-To: <20171222152307.11252-6-catalin.marinas@arm.com>
References: <20171222152307.11252-1-catalin.marinas@arm.com>
 <20171222152307.11252-6-catalin.marinas@arm.com>
Message-ID: <04646731-e1e1-06fd-0c53-48cd61407ce6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/12/17 15:23, Catalin Marinas wrote:
> From: Kristina Martsenko <kristina.martsenko@arm.com>
> 
> Instead of open coding the generation of page table entries, use the
> macros/functions that exist for this - pfn_p*d and p*d_populate. Most
> code in the kernel already uses these macros, this patch tries to fix
> up the few places that don't. This is useful for the next patch in this
> series, which needs to change the page table entry logic, and it's
> better to have that logic in one place.
> 
> The KVM extended ID map is special, since we're creating a level above
> CONFIG_PGTABLE_LEVELS and the required function isn't available. Leave
> it as is and add a comment to explain it. (The normal kernel ID map code
> doesn't need this change because its page tables are created in assembly
> (__create_page_tables)).
> 
> Tested-by: Bob Picco <bob.picco@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
