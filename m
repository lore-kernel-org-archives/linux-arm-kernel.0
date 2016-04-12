From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 12 Apr 2016 16:00:36 +0100
Subject: [PATCH 2/2] arm64: mm: make pfn always valid with flat memory
In-Reply-To: <570B85B6.8000805@huawei.com>
References: <1459844572-53069-1-git-send-email-puck.chen@hisilicon.com>
 <1459844572-53069-2-git-send-email-puck.chen@hisilicon.com>
 <570B85B6.8000805@huawei.com>
Message-ID: <20160412150036.GG8066@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 07:08:38PM +0800, Xishi Qiu wrote:
> On 2016/4/5 16:22, Chen Feng wrote:
> 
> > Make the pfn always valid when using flat memory.
> > If the reserved memory is not align to memblock-size,
> > there will be holes in zone.
> > 
> > This patch makes the memory in buddy always in the
> > array of mem-map.
> > 
> > Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
> > Signed-off-by: Fu Jun <oliver.fu@hisilicon.com>
> > ---
> >  arch/arm64/mm/init.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index ea989d8..0e1d5b7 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -306,7 +306,8 @@ static void __init free_unused_memmap(void)
> 
> How about let free_unused_memmap() support for CONFIG_SPARSEMEM_VMEMMAP?

We would need extra care to check that the memmap was actually allocated
in the first place.

-- 
Catalin
