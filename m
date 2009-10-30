From: niam.niam@gmail.com (Ni@m)
Date: Fri, 30 Oct 2009 07:44:42 +0200
Subject: what's zero_pages for in paging_int
In-Reply-To: <tencent_6A57DBDE2957BDF72E459404@qq.com>
References: <tencent_6A57DBDE2957BDF72E459404@qq.com>
Message-ID: <a9e22dff0910292244i293eeae0xf604bb0bf0cf71a2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, rocky.
Mostly zeropage is needed to catch NULL-dereferencing.

Regards.
-- Dima

2009/10/30 ??? <914059751@qq.com>

> Hi, guys
>
>     In paging_int, after setting up bootmem allocator, why zero page is
> needed? i cannot see any things usefull resides on that page, something i
> missing obviously?
>
>    thanks
> ----rocky
>
>  ---------------------Linux-2.6.30/arch/arm/mm/mmu.c-----------------------
>
> void __init paging_init(struct machine_desc *mdesc)
> {
>         void *zero_page;
>
>         build_mem_type_table();
>         sanity_check_meminfo();
>         prepare_page_table();
>         bootmem_init();
>         devicemaps_init(mdesc);
>         kmap_init();/*DF: most embedded system do NOT have any HIGH MEM */
>         top_pmd = pmd_off_k(0xffff0000);
>
>
>         /*
>          * allocate the zero page.  Note that this always succeeds and
>          * returns a zeroed result.
>          */
>         zero_page = alloc_bootmem_low_pages(PAGE_SIZE);   /* DF: what?s
> this for? */
>         empty_zero_page = virt_to_page(zero_page);
>         flush_dcache_page(empty_zero_page);
>
> }
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091030/9e0c3573/attachment.htm>
