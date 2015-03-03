From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 3 Mar 2015 14:14:49 +0000
Subject: [RFC PATCH 3/4] arm64: add support for memtest
In-Reply-To: <54F57E62.6050206@arm.com>
References: <1425308145-20769-1-git-send-email-vladimir.murzin@arm.com>
 <1425308145-20769-4-git-send-email-vladimir.murzin@arm.com>
 <20150302185607.GG7919@arm.com> <54F57E62.6050206@arm.com>
Message-ID: <20150303141449.GM28951@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 09:26:58AM +0000, Vladimir Murzin wrote:
> On 02/03/15 18:56, Will Deacon wrote:
> > On Mon, Mar 02, 2015 at 02:55:44PM +0000, Vladimir Murzin wrote:
> >> Add support for memtest command line option.
> >>
> >> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> >> ---
> >>  arch/arm64/mm/init.c |    2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >> index ae85da6..597831b 100644
> >> --- a/arch/arm64/mm/init.c
> >> +++ b/arch/arm64/mm/init.c
> >> @@ -190,6 +190,8 @@ void __init bootmem_init(void)
> >>  	min = PFN_UP(memblock_start_of_DRAM());
> >>  	max = PFN_DOWN(memblock_end_of_DRAM());
> >>  
> >> +	early_memtest(min << PAGE_SHIFT, max << PAGE_SHIFT);
> >> +
> >>  	/*
> >>  	 * Sparsemem tries to allocate bootmem in memory_present(), so must be
> >>  	 * done after the fixed reservations.
> > 
> > This is really neat, thanks for doing this Vladimir!
> > 
> >   Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > For the series, modulo Baruch's comments about Documentation updates.
> 
> Thanks Will! I'll wait for awhile for other comments and repost updated
> version.
> 
> I wonder which tree it might go?

Since it touches mm, x86, arm, arm64, I guess it could go in via the mm
tree (akpm). We could take it via the arm64 tree as well if we have all
the acks in place.

-- 
Catalin
