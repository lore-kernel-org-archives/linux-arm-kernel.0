From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Dec 2009 09:07:50 +0000
Subject: CPU consumption is going as high as 95% on ARM Cortex A8
In-Reply-To: <19F8576C6E063C45BE387C64729E73940449F43E29@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E73940449F43857@dbde02.ent.ti.com>
	<20091217095641.GA399@n2100.arm.linux.org.uk>
	<19F8576C6E063C45BE387C64729E73940449F43E29@dbde02.ent.ti.com>
Message-ID: <20091221090750.GA11669@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2009 at 11:56:23AM +0530, Hiremath, Vaibhav wrote:
> >         vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > 
> > will result in the memory being mapped as 'Strongly Ordered',
> > resulting
> > in there being multiple mappings with differing types.  In later
> > kernels, we have pgprot_dmacoherent() and I'd suggest changing the
> > above
> > macro for that.
> > 
> 
> I tried with your suggestion above but unfortunately it didn't work for
> me. I am seeing the same behavior with the pgprot_dmacoherent(). I
> pulled your patch (which got applied cleanly on 2.6.32-rc5) -

What happens if you comment out the pgprot_dmacoherent() / pgprot_noncached()
line completely?

I suspect that will "solve" the problem - but you'll then no longer have
DMA coherency with userspace, so its not really a solution.
