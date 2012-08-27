From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Aug 2012 09:29:14 +0100
Subject: Question about ION carveout heap support partial cache flush
In-Reply-To: <CAMj5BkiVq9ayJjUrwh3S-gDfezUTNiPFW-xd_dsbTJYTyLv2WQ@mail.gmail.com>
References: <CAMj5BkgffAW6azUjwz+iCF1tBLmBDRBvBjR-_fTr=4G=h+BLZw@mail.gmail.com>
 <CAN1soZyZ=4wjKkVrk5--2U_8SeT7qee9QAfhss7NgqtQAz+RrA@mail.gmail.com>
 <CAMj5BkiVq9ayJjUrwh3S-gDfezUTNiPFW-xd_dsbTJYTyLv2WQ@mail.gmail.com>
Message-ID: <20120827082914.GN18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 04:23:31PM +0800, zhangfei gao wrote:
> On Mon, Aug 27, 2012 at 1:46 PM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
> > Let me summerize it. First, user space address is mapped. Then,
> > flushing user space
> > address is triggered. It's a workaround of fixing non-existed virtual
> > address without fixing
> > vmap() or any other solution. It's just a quick fix.
> >
> > Zhangfei,
> > I doubt that the issue may be caused by missing memory barrier.
> > Flushing is using
> > coprocessor instructions. It's a little different.
> 
> Is there any limitation that dmac_map_area & dmac_flush_range
> supporting addr mapped from user space?

They DEFINITELY DO NOT SUPPORT FLUSHING USER SPACE.
