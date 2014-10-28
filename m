From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Oct 2014 13:36:51 +0000
Subject: [PATCH] arm64: ARCH_PFN_OFFSET should be unsigned long
In-Reply-To: <1971110.TLNM8kRvV0@wuerfel>
References: <1414475041-31480-1-git-send-email-zhangwm@marvell.com>
 <20141028123610.GC12136@arm.com> <1971110.TLNM8kRvV0@wuerfel>
Message-ID: <20141028133651.GA29706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 12:51:56PM +0000, Arnd Bergmann wrote:
> On Tuesday 28 October 2014 12:36:11 Will Deacon wrote:
> > On Tue, Oct 28, 2014 at 05:44:01AM +0000, Neil Zhang wrote:
> > > pfns are unsigned long, but PHYS_PFN_OFFSET is phys_addr_t. This leads
> > > to page_to_pfn() returning phys_addr_t which cause type mismatches in
> > > some print statements.
> > 
> > Do you have a specific example? Both of those types are 64-bit on arm64.
> > 
> > 
> 
> printf warns about the fact that phys_addr_t is defined as 'u64', which
> is 'unsigned long long' rather than 'unsigned long'. It's the same size
> but not the same printf format string.

Ok, fair enough. I'll let Catalin pick this up for 3.18.

Will
