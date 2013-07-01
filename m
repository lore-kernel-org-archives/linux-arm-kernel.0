From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 1 Jul 2013 10:14:45 -0400
Subject: [RFC PATCH 5/6] ARM, mm: change meaning of max_low_pfn to maximum
 pfn for nobootmem
In-Reply-To: <1364184674-13798-6-git-send-email-iamjoonsoo.kim@lge.com>
References: <1364184674-13798-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1364184674-13798-6-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <51D18ED5.50103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joonsoo,

On Monday 25 March 2013 12:11 AM, Joonsoo Kim wrote:
> nobootmem use max_low_pfn for computing boundary in free_all_bootmem()
> So we need proper value to max_low_pfn.
> 
> But, there is some difficulty related to max_low_pfn. max_low_pfn is used
> for two meanings in various architectures. One is for number of pages
> in lowmem and the other is for maximum lowmem pfn. Now, in ARM, it is used
> as number of pages in lowmem. You can get more information in below link.
> http://lwn.net/Articles/543408/
> http://lwn.net/Articles/543424/
> 
> As I investigated, architectures which use max_low_pfn as maximum pfn are
> more than others, so to change meaning of max_low_pfn to maximum pfn
> is preferable solution to me. This patch change max_low_pfn as maximum
> lowmem pfn in ARM. In addition, min_low_pfn, max_pfn is assigned according
> to this criteria.
> 
> There is no real user for max_low_pfn except block/blk-setting.c and
> blk-setting.c assume that max_low_pfn is maximum lowmem pfn,
> so this patch may not harm anything.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
I have been also carrying similar patch as yours in an attempt
to make LPAE kernel work on ARM. Your patch carries better
description, so will your version and include in my series
which I plan to post on the list after some more testing.
Will copy you. The changes are very similar to your series.

Regards,
Santosh
 
