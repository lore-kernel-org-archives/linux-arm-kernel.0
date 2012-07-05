From: xiyou.wangcong@gmail.com (Cong Wang)
Date: Thu, 5 Jul 2012 13:56:43 +0000 (UTC)
Subject: Bad use of highmem with buffer_migrate_page?
References: <4FAC200D.2080306@codeaurora.org>
 <02fc01cd2f50$5d77e4c0$1867ae40$%szyprowski@samsung.com>
 <4FAD89DC.2090307@codeaurora.org>
 <CAH+eYFBhO9P7V7Nf+yi+vFPveBks7SFKRHfkz3JOQMBKqnkkUQ@mail.gmail.com>
 <015f01cd5a95$c1525dc0$43f71940$%szyprowski@samsung.com>
 <20120705104520.GA6773@latitude>
Message-ID: <jt46eq$lq0$4@dough.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 05 Jul 2012 at 10:45 GMT, Rabin Vincent <rabin@rab.in> wrote:
> 8<----
> From 8a94126eb3aa2824866405fb78bb0b8316f8fd00 Mon Sep 17 00:00:00 2001
> From: Rabin Vincent <rabin@rab.in>
> Date: Thu, 5 Jul 2012 15:52:23 +0530
> Subject: [PATCH] mm: cma: don't replace lowmem pages with highmem
>
> The filesystem layer expects pages in the block device's mapping to not
> be in highmem (the mapping's gfp mask is set in bdget()), but CMA can
> currently replace lowmem pages with highmem pages, leading to crashes in
> filesystem code such as the one below:
>
...
> Fix this by replacing only highmem pages with highmem.
>

Looks good to me too,

    Reviewed-by: WANG Cong <xiyou.wangcong@gmail.com>
