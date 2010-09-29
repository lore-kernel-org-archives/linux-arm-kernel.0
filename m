From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 29 Sep 2010 17:14:30 +0100
Subject: [PATCH 1/2] ARM: add memory types for the TCMs
In-Reply-To: <20100929154249.GA24118@n2100.arm.linux.org.uk>
References: <1278623805-17027-1-git-send-email-linus.walleij@stericsson.com>
	<20100929154249.GA24118@n2100.arm.linux.org.uk>
Message-ID: <1285776870.7983.87.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-09-29 at 16:42 +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 08, 2010 at 11:16:45PM +0200, Linus Walleij wrote:
> > I'm especially in the dark about the usage of the L_PTE_* stuff,
> > and when to use DOMAIN_KERNEL, DOMAIN_USER and DOMAIN_IO. For
> > example: does DOMAIN_KERNEL imply kernel usage? DOMAIN_KERNEL
> > for ITCM makes the code non-executable. Does DOMAIN_USER imply
> > that L_PTE_USER shall also be set?
> 
> Sorry, should've replied to this much earlier.  We now have a problem in
> that this stuff for the ITCM entry is wrong (identified via Santosh's
> MT_MEMORY problems).
> 
> L_PTE_* define what ends up in the PTE entries.  L_PTE_USER and
> L_PTE_WRITE operate together:
> 
> - None set, page is read-only in SVC mode, inaccessible in user mode.
> - L_PTE_WRITE, page is read-write in SVC mode, inaccessible in user mode.
> - L_PTE_USER, page is read-write in SVC mode, read-only in user mode.

Just a small addition - with the domains removal patch on ARMv7, this
becomes read-only for both SVC and user modes.

-- 
Catalin
