From: mhocko@kernel.org (Michal Hocko)
Date: Tue, 10 Jul 2018 11:50:56 +0200
Subject: [PATCH 1/2] mm/cma: remove unsupported gfp_mask parameter from
 cma_alloc()
In-Reply-To: <CAAmzW4PPNYhUj_MeZox+ddq8MjXqnJs_AJ3xkayf710udD1pSg@mail.gmail.com>
References: <CGME20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29@eucas1p2.samsung.com>
 <20180709121956.20200-1-m.szyprowski@samsung.com>
 <20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29~-sqTPJKij2939229392eucas1p2j@eucas1p2.samsung.com>
 <CAAmzW4PPNYhUj_MeZox+ddq8MjXqnJs_AJ3xkayf710udD1pSg@mail.gmail.com>
Message-ID: <20180710095056.GE14284@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 10-07-18 16:19:32, Joonsoo Kim wrote:
> Hello, Marek.
> 
> 2018-07-09 21:19 GMT+09:00 Marek Szyprowski <m.szyprowski@samsung.com>:
> > cma_alloc() function doesn't really support gfp flags other than
> > __GFP_NOWARN, so convert gfp_mask parameter to boolean no_warn parameter.
> 
> Although gfp_mask isn't used in cma_alloc() except no_warn, it can be used
> in alloc_contig_range(). For example, if passed gfp mask has no __GFP_FS,
> compaction(isolation) would work differently. Do you have considered
> such a case?

Does any of cma_alloc users actually care about GFP_NO{FS,IO}?
-- 
Michal Hocko
SUSE Labs
