From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Mar 2010 17:07:22 +0000
Subject: [GIT PULL] pxa: patches for next merge window
In-Reply-To: <alpine.LFD.2.00.1003010856200.3616@localhost.localdomain>
References: <f17812d71002241849m6b37f601h7eef1a723b2d0335@mail.gmail.com>
	<20100225205113.GF3101@n2100.arm.linux.org.uk>
	<20100225212915.GA24043@n2100.arm.linux.org.uk>
	<f17812d71002260105q54c26198jc9b61851c35ae8ef@mail.gmail.com>
	<20100228161449.GD16745@n2100.arm.linux.org.uk>
	<20100301093927.GC29952@pengutronix.de>
	<20100301094820.GA10863@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1003010827330.3616@localhost.localdomain>
	<alpine.LFD.2.00.1003010856200.3616@localhost.localdomain>
Message-ID: <20100301170722.GB3002@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 01, 2010 at 08:58:12AM -0800, Linus Torvalds wrote:
> On Mon, 1 Mar 2010, Linus Torvalds wrote:
> > 
> > rmk: I think it's ok if you end up having to rebase something this time in 
> > order to fix up a mistake that has already happened - no rule should be 
> > _so_ set in stone that it can't be violated when bad things happen.
> 
> Btw, since I have a pending pull from you already, let me know if I should 
> pull it or not. I was just about to pull it, and then I started wondering 
> whether the pax patches are involved, so I kept off.

That pull request contains just local commits, so it's safe to be pulled
in respect of this issue.  The only concern raised on it is from Geert
Uytterhoeven over a bit of missing documentation - basically:

 5) void update_mmu_cache(struct vm_area_struct *vma,
-                        unsigned long address, pte_t pte)
+                        unsigned long address, pte_t *ptep)

        At the end of every page fault, this routine is invoked to
        tell the architecture specific code that a translation
-       described by "pte" now exists at virtual address "address"
-       for address space "vma->vm_mm", in the software page tables.
+       now exists at virtual address "address" for address space
+       "vma->vm_mm", in the software page tables.

the complaint is that 'ptep' is not documented.  "ptep is a pointer to
the pte" wouldn't (at least to me) provide any additional information
to the reader.

> But if you're just going to ask the pxa people to fix things up (which is 
> my preference), just send me an email saying "go ahead and pull". I'm 
> checking, just in case.

I hope that the PXA situation does get straightened out soon, at which
point this will be part of a pull request next week.
