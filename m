From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 27 Aug 2012 21:45:23 +0800
Subject: Question about ION carveout heap support partial cache flush
In-Reply-To: <CAMj5BkjqUNV2o_BMyHH8C5ZCsUf6qChamc6h4H-a9otEGVBx4A@mail.gmail.com>
References: <CAMj5BkgffAW6azUjwz+iCF1tBLmBDRBvBjR-_fTr=4G=h+BLZw@mail.gmail.com>
 <CAN1soZyZ=4wjKkVrk5--2U_8SeT7qee9QAfhss7NgqtQAz+RrA@mail.gmail.com>
 <CAMj5BkiVq9ayJjUrwh3S-gDfezUTNiPFW-xd_dsbTJYTyLv2WQ@mail.gmail.com>
 <20120827082914.GN18957@n2100.arm.linux.org.uk>
 <CAMj5BkjqUNV2o_BMyHH8C5ZCsUf6qChamc6h4H-a9otEGVBx4A@mail.gmail.com>
Message-ID: <CAN1soZyPp4--G3GjSpy8JZViFE4ed8dSyRnxgBfORam21SzpDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 4:56 PM, zhangfei gao <zhangfei.gao@gmail.com> wrote:
>
> Any suggestion of flushing cache according to cache line, instead of PAGE_SIZE.
> In order to get specific area, we use addr from user directly, which
> may not be the PAGE start.
>
> We have some usage case to flush cache according to cache line.
> CPU - cache - ddr - gpu
> 1. For correctness, driver only flush used size, if align to PAGE_SIZE,
> other area may be flushed by mistake.
> 2. for efficiency, cache line align will be perfered.

I think that maybe flushing PAGE_SIZE is acceptable. ION/PMEM is always designed
for large memory sharing. Maybe you can monitor the partial flushing
user case, I doubt
they're always flushing several pages, not several cachelines.
