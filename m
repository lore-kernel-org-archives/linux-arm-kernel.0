From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 8 Aug 2018 15:50:17 +0100
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <19c70d2a0b224db78f72dd316ad006b8@AcuMS.aculab.com>
References: <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
 <20180808121641.GB24736@iMac.local>
 <b1de49af14d941979977af07dc81e1c2@AcuMS.aculab.com>
 <alpine.LRH.2.02.1808080939180.3325@file01.intranet.prod.int.rdu2.redhat.com>
 <19c70d2a0b224db78f72dd316ad006b8@AcuMS.aculab.com>
Message-ID: <20180808145017.GE24736@iMac.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2018 at 02:26:11PM +0000, David Laight wrote:
> From: Mikulas Patocka
> > Sent: 08 August 2018 14:47
> ...
> > The problem on ARM is that I see data corruption when the overlapping
> > unaligned writes are done just by a single core.
> 
> Is this a sequence of unaligned writes (that shouldn't modify the
> same physical locations) or an aligned write followed by an
> unaligned one that updates part of the earlier write.
> (Or the opposite order?)

In the memcpy() case, there can be a sequence of unaligned writes but
they would not modify the same byte (so no overlapping address at the
byte level).

-- 
Catalin
