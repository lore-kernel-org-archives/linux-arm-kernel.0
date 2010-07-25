From: balbir@linux.vnet.ibm.com (Balbir Singh)
Date: Sun, 25 Jul 2010 22:33:08 +0530
Subject: [PATCH] Tight check of pfn_valid on sparsemem - v3
In-Reply-To: <1280066561-8543-1-git-send-email-minchan.kim@gmail.com>
References: <1280066561-8543-1-git-send-email-minchan.kim@gmail.com>
Message-ID: <AANLkTimtN9PuvwrB2PAUZMajWzg=TbEP1jeseVM3MST3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 25, 2010 at 7:32 PM, Minchan Kim <minchan.kim@gmail.com> wrote:
> Changelog since v2
> ?o Change some function names
> ?o Remove mark_memmap_hole in memmap bring up
> ?o Change CONFIG_SPARSEMEM with CONFIG_ARCH_HAS_HOLES_MEMORYMODEL
>
> I have a plan following as after this patch is acked.
>
> TODO:
> 1) expand pfn_valid to FALTMEM in ARM
> I think we can enhance pfn_valid of FLATMEM in ARM.
> Now it is doing binary search and it's expesive.
> First of all, After we merge this patch, I expand it to FALTMEM of ARM.
>
> 2) remove memmap_valid_within
> We can remove memmap_valid_within by strict pfn_valid's tight check.
>
> 3) Optimize hole check in sparsemem
> In case of spasemem, we can optimize pfn_valid through defining new flag
> like SECTION_HAS_HOLE of hole mem_section.
>

Is there an assumption somewhere that assumes that page->private will
always have MEMMAP_HOLE set when the pfn is invalid, independent of
the context in which it is invoked? BTW, I'd also recommend moving
over to using set_page_private() and page_private() wrappers (makes
the code easier to search)

Balbir
