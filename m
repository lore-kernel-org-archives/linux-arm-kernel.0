From: js1304@gmail.com (Joonsoo Kim)
Date: Fri, 13 Jul 2018 15:29:29 +0900
Subject: [PATCH 1/2] mm/cma: remove unsupported gfp_mask parameter from
 cma_alloc()
In-Reply-To: <20180712071536.GA15506@lst.de>
References: <CGME20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29@eucas1p2.samsung.com>
 <20180709121956.20200-1-m.szyprowski@samsung.com>
 <20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29~-sqTPJKij2939229392eucas1p2j@eucas1p2.samsung.com>
 <CAAmzW4PPNYhUj_MeZox+ddq8MjXqnJs_AJ3xkayf710udD1pSg@mail.gmail.com>
 <20180710095056.GE14284@dhcp22.suse.cz>
 <CAAmzW4P1m_T77DfQzDD6ysGaOF46++-0gwRaOajmo6ef=VYp=A@mail.gmail.com>
 <20180711085407.GB20050@dhcp22.suse.cz>
 <CAAmzW4M3KADCZD9+B2h7=WsYksGtg-GzYRCJjbqK5Scceynrrg@mail.gmail.com>
 <20180712071536.GA15506@lst.de>
Message-ID: <CAAmzW4MNuZOZRP1fHt7E42Mm6+-CLkYYA1Ju2Cfe0ik4Ynb4Lw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-07-12 16:15 GMT+09:00 Christoph Hellwig <hch@lst.de>:
> On Thu, Jul 12, 2018 at 11:48:47AM +0900, Joonsoo Kim wrote:
>> One of existing user is general DMA layer and it takes gfp flags that is
>> provided by user. I don't check all the DMA allocation sites but how do
>> you convince that none of them try to use anything other
>> than GFP_KERNEL [|__GFP_NOWARN]?
>
> They use a few others things still like __GFP_COMP, __GPF_DMA or
> GFP_HUGEPAGE.  But all these are bogus as we have various implementations
> that can't respect them.  I plan to get rid of the gfp_t argument
> in the dma_map_ops alloc method in a few merge windows because of that,
> but it needs further implementation consolidation first.

Okay. If those flags are all, this change would be okay.

For the remind of this gfp flag introduction in cma_alloc(), see the
following link.

https://marc.info/?l=linux-mm&m=148431452118407

Thanks.
