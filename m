From: msalter@redhat.com (Mark Salter)
Date: Tue, 17 Dec 2013 14:15:15 -0500
Subject: [PATCH 4/4] arm64: add early_ioremap support
In-Reply-To: <20131205162800.GB1495@darko.cambridge.arm.com>
References: <1385606679-30446-1-git-send-email-msalter@redhat.com>
 <1385606679-30446-5-git-send-email-msalter@redhat.com>
 <20131205162800.GB1495@darko.cambridge.arm.com>
Message-ID: <1387307715.1979.169.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-12-05 at 16:28 +0000, Catalin Marinas wrote:
> > +#define FIXMAP_PAGE_NORMAL __pgprot(PROT_NORMAL | PTE_PXN | PTE_UXN)
> 
> I'll push a fix to change PROT_DEFAULT to (pgprot_default | PTE_DIRTY).
> 

This doesn't help early_ioremap because pgprot_default gets set up in
init_mem_pgprot() which is called from paging_init(). The early_ioremaps
happen before paging_init(). Would it be okay to make init_mem_pgprot()
non-static and call it from setup_arch() before early_ioremap_init()?

--Mark
