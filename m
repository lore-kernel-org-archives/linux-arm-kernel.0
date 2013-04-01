From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Mon, 1 Apr 2013 17:28:49 +0900
Subject: [RFC PATCH 5/6] ARM, mm: change meaning of max_low_pfn to
 maximum pfn for nobootmem
In-Reply-To: <20130325094816.GO4977@n2100.arm.linux.org.uk>
References: <1364184674-13798-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1364184674-13798-6-git-send-email-iamjoonsoo.kim@lge.com>
 <20130325094816.GO4977@n2100.arm.linux.org.uk>
Message-ID: <20130401082849.GE12015@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Russell.

On Mon, Mar 25, 2013 at 09:48:16AM +0000, Russell King - ARM Linux wrote:
> On Mon, Mar 25, 2013 at 01:11:13PM +0900, Joonsoo Kim wrote:
> > nobootmem use max_low_pfn for computing boundary in free_all_bootmem()
> > So we need proper value to max_low_pfn.
> > 
> > But, there is some difficulty related to max_low_pfn. max_low_pfn is used
> > for two meanings in various architectures. One is for number of pages
> > in lowmem and the other is for maximum lowmem pfn. Now, in ARM, it is used
> > as number of pages in lowmem. You can get more information in below link.
> > http://lwn.net/Articles/543408/
> > http://lwn.net/Articles/543424/
> > 
> > As I investigated, architectures which use max_low_pfn as maximum pfn are
> > more than others, so to change meaning of max_low_pfn to maximum pfn
> > is preferable solution to me. This patch change max_low_pfn as maximum
> > lowmem pfn in ARM. In addition, min_low_pfn, max_pfn is assigned according
> > to this criteria.
> > 
> > There is no real user for max_low_pfn except block/blk-setting.c and
> > blk-setting.c assume that max_low_pfn is maximum lowmem pfn,
> > so this patch may not harm anything.
> 
> This will need some very rigorous testing before it can go into mainline.

There is no attention from others to this patchset. :)
Do you have any plan to test this?
What I can do best is just to run this patchset on my platform.

Would you guide me how to go into mainline for this patchset.

Thanks.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
