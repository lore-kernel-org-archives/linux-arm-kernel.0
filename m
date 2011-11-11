From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Nov 2011 10:54:51 +0000
Subject: [PATCH v8 08/16] ARM: LPAE: Page table maintenance for the
 3-level format
In-Reply-To: <alpine.LFD.2.02.1111101654400.3307@xanadu.home>
References: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
 <1320682618-1182-9-git-send-email-catalin.marinas@arm.com>
 <alpine.LFD.2.02.1111101654400.3307@xanadu.home>
Message-ID: <20111111105450.GB23243@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 09:59:33PM +0000, Nicolas Pitre wrote:
> On Mon, 7 Nov 2011, Catalin Marinas wrote:
> 
> > This patch modifies the pgd/pmd/pte manipulation functions to support
> > the 3-level page table format. Since there is no need for an 'ext'
> > argument to cpu_set_pte_ext(), this patch conditionally defines a
> > different prototype for this function when CONFIG_ARM_LPAE.
> 
> Maybe it doesn't make sense to still call it cpu_set_pte_ext then?

We could do this but it adds several #ifdef's, especially if we also
change macro names like set_pte_ext(). Otherwise we could leave the
latter macro unchanged and only change the name in the processor
structure. But I think it just adds more clutter.

-- 
Catalin
