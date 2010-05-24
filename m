From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 May 2010 12:31:04 +0100
Subject: [PATCH 0/4] Patches for -next
In-Reply-To: <20100521190456.GB11042@n2100.arm.linux.org.uk>
References: <20100520142715.22202.33516.stgit@e102109-lin.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5667016@dbde02.ent.ti.com>
	<1274435541.11965.18.camel@e102109-lin.cambridge.arm.com>
	<20100521190456.GB11042@n2100.arm.linux.org.uk>
Message-ID: <1274700664.4720.7.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-05-21 at 20:04 +0100, Russell King - ARM Linux wrote:
> On Fri, May 21, 2010 at 10:52:21AM +0100, Catalin Marinas wrote:
> > +     if (cache_is_vivt())
> > +             make_coherent(mapping, vma, addr, ptep, pfn);
> > +     else if (vma->vm_flags & VM_EXEC) {
> > +             __flush_icache_all();
> > +#ifdef CONFIG_SMP
> > +             set_pte_ext(ptep, __pte(pte_val(*ptep) | L_PTE_EXEC),
> > +                         addr >= TASK_SIZE ? 0 : PTE_EXT_NG);
> 
> You don't need this test - pages which have VMAs are userspace pages,
> and therefore the address is always < TASK_SIZE.  Therefore, they're
> always non-global:
> 
>                 set_pte_ext(ptep, __pte(pte_val(*ptep) | L_PTE_EXEC),
>                             PTE_EXT_NG);

Good point. Thanks.

So, are you ok for me to push these patches to -next?

-- 
Catalin
