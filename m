From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Feb 2016 10:18:03 +0000
Subject: [PATCH v5sub1 7/8] arm64: move kernel image to base of vmalloc
 area
In-Reply-To: <56C43A23.1020301@virtuozzo.com>
References: <20160212152641.GK31665@e104818-lin.cambridge.arm.com>
 <56BDFC86.5010705@arm.com>
 <20160212160652.GL31665@e104818-lin.cambridge.arm.com>
 <56C1E072.2090909@virtuozzo.com>
 <20160215185957.GB19413@e104818-lin.cambridge.arm.com>
 <56C31D1D.50708@virtuozzo.com>
 <CAKv+Gu8WE=fTZF0Pou24FKDocgshWu8dJRbaC5SJ11E-6T=2Hw@mail.gmail.com>
 <56C34204.60605@virtuozzo.com> <20160216164245.GC8022@leverpostej>
 <56C43A23.1020301@virtuozzo.com>
Message-ID: <20160217101803.GB32714@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 12:15:15PM +0300, Andrey Ryabinin wrote:
> On 02/16/2016 07:42 PM, Mark Rutland wrote:
> > FWIW with the below patch I don't see any "screwed shadow mapping"
> > warnings on my board, and still later see a tonne of KASAN splats in the
> > scheduler.
> 
> It is possible that I missed something, but I think it means that
> shadow is alright.
> 
> I wonder whether this happens on 4.4. If not, than something in
> 4.5-rc1 caused this, and the obvious suspect here is irq stack.

It doesn't seem to happen on 4.4, it starts somewhere before 4.5-rc1. I
tested the arm64 branch that we pushed upstream with the irq stack
changes but it didn't trigger. It could as well be a combination of
multiple change or just something else.

We'll do some bisecting, though it's not that fun going through the
merging window commits, especially since many are based on 4.4-rcX (we
could try on merges only first, there are fewer).

-- 
Catalin
