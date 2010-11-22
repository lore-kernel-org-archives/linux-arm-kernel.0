From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Nov 2010 13:15:46 +0000
Subject: [PATCH v2 11/20] ARM: LPAE: Add fault handling support
In-Reply-To: <1289584840-18097-12-git-send-email-catalin.marinas@arm.com>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<1289584840-18097-12-git-send-email-catalin.marinas@arm.com>
Message-ID: <20101122131546.GG31227@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 12, 2010 at 06:00:31PM +0000, Catalin Marinas wrote:
> @@ -108,7 +113,9 @@ void show_pte(struct mm_struct *mm, unsigned long addr)
>  
>  		pte = pte_offset_map(pmd, addr);
>  		printk(", *pte=%08lx", pte_val(*pte));
> +#ifndef CONFIG_ARM_LPAE
>  		printk(", *ppte=%08lx", pte_val(pte[-LINUX_PTE_OFFSET]));
> +#endif

This is an unrelated change - should it be in a different patch?
