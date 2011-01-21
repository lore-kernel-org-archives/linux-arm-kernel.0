From: saaguirre@ti.com (Aguirre, Sergio)
Date: Fri, 21 Jan 2011 10:57:13 -0600
Subject: [Query] mm: !*pte hit in mm/memory.c:remap_pte_range
In-Reply-To: <20110121103005.GA14142@n2100.arm.linux.org.uk>
References: <A24693684029E5489D1D202277BE89448521EEAA@dlee02.ent.ti.com>,
	<20110121103005.GA14142@n2100.arm.linux.org.uk>
Message-ID: <A24693684029E5489D1D202277BE89448521EEB1@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> ________________________________________
> From: Russell King - ARM Linux [linux at arm.linux.org.uk]
> Sent: Friday, January 21, 2011 4:30 AM
> To: Aguirre, Sergio
> Cc: linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org
> Subject: Re: [Query] mm: !*pte hit in mm/memory.c:remap_pte_range
> 
> On Thu, Jan 20, 2011 at 03:06:30PM -0600, Aguirre, Sergio wrote:
> > And while debugging further, i realized that the point of stall was
> > in mm/memory.c, function:
> >
> > static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
> >                       unsigned long addr, unsigned long end,
> >                       unsigned long pfn, pgprot_t prot)
> > {

> >               BUG_ON(!pte_none(*pte)); <---******* HERE

> > }

> > How should i interpret this? Does this mean something specific?
> 
> It is asserting that the pte we are about to overwrite was empty.  In
> other words, there is no existing mapping in place at that virtual
> address.
> 
> If there was a pre-existing mapping, you're doing something wrong
> because you're potentially overwriting something else.

Ok. I see.

Thanks for the detailed explanation. I appreciate it.

Regards,
Sergio
> 
