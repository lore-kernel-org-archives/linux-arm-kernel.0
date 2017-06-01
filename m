From: will.deacon@arm.com (Will Deacon)
Date: Thu, 1 Jun 2017 13:37:50 +0100
Subject: [PATCH 2/2] arm64: mm: don't print out page table entries on EL0
 faults
In-Reply-To: <59b82477-b937-0ffb-6cf1-d86e9b0488ba@arm.com>
References: <1495453554-9412-1-git-send-email-kristina.martsenko@arm.com>
 <1495453554-9412-2-git-send-email-kristina.martsenko@arm.com>
 <20170522122115.GF1107@arm.com>
 <59b82477-b937-0ffb-6cf1-d86e9b0488ba@arm.com>
Message-ID: <20170601123750.GG12832@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 31, 2017 at 08:38:00PM +0100, Kristina Martsenko wrote:
> On 22/05/17 13:21, Will Deacon wrote:
> > On Mon, May 22, 2017 at 12:45:54PM +0100, Kristina Martsenko wrote:
> >> When we take a fault from EL0 that can't be handled, we print out the
> >> page table entries associated with the faulting address. This allows
> >> userspace to print out any current page table entries, including kernel
> >> (TTBR1) entries.  Exposing kernel mappings like this could pose a
> >> security risk, so don't print out page table information on EL0 faults.
> >> (But still print it out for EL1 faults.)
> >>
> >> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> > 
> > It might be worth mentioning that this follows the same behaviour as x86.
> 
> Yep.
> 
> > In fact, they print the name of the faulting VMA using print_vma_addr,
> > which might be useful too.
> 
> Looks useful, should I add that in a separate patch in v2?

Sure, works for me.

Will
