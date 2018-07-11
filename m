From: js1304@gmail.com (Joonsoo Kim)
Date: Wed, 11 Jul 2018 16:35:28 +0900
Subject: [PATCH 1/2] mm/cma: remove unsupported gfp_mask parameter from
 cma_alloc()
In-Reply-To: <20180710095056.GE14284@dhcp22.suse.cz>
References: <CGME20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29@eucas1p2.samsung.com>
 <20180709121956.20200-1-m.szyprowski@samsung.com>
 <20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29~-sqTPJKij2939229392eucas1p2j@eucas1p2.samsung.com>
 <CAAmzW4PPNYhUj_MeZox+ddq8MjXqnJs_AJ3xkayf710udD1pSg@mail.gmail.com>
 <20180710095056.GE14284@dhcp22.suse.cz>
Message-ID: <CAAmzW4P1m_T77DfQzDD6ysGaOF46++-0gwRaOajmo6ef=VYp=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-07-10 18:50 GMT+09:00 Michal Hocko <mhocko@kernel.org>:
> On Tue 10-07-18 16:19:32, Joonsoo Kim wrote:
>> Hello, Marek.
>>
>> 2018-07-09 21:19 GMT+09:00 Marek Szyprowski <m.szyprowski@samsung.com>:
>> > cma_alloc() function doesn't really support gfp flags other than
>> > __GFP_NOWARN, so convert gfp_mask parameter to boolean no_warn parameter.
>>
>> Although gfp_mask isn't used in cma_alloc() except no_warn, it can be used
>> in alloc_contig_range(). For example, if passed gfp mask has no __GFP_FS,
>> compaction(isolation) would work differently. Do you have considered
>> such a case?
>
> Does any of cma_alloc users actually care about GFP_NO{FS,IO}?

I don't know. My guess is that cma_alloc() is used for DMA allocation so
block device would use it, too. If fs/block subsystem initiates the
request for the device,
it would be possible that cma_alloc() is called with such a flag.
Again, I don't know
much about those subsystem so I would be wrong.

Thanks.
