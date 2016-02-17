From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 17 Feb 2016 19:35:33 +0000
Subject: [PATCH v5sub1 7/8] arm64: move kernel image to base of vmalloc
 area
In-Reply-To: <56C4A06F.3040702@virtuozzo.com>
References: <20160212151006.GJ31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu84mVP=YjbLhWoGj9AEUD8m8+Lq8kTCniCHwxJwMWaZtA@mail.gmail.com>
 <20160212152641.GK31665@e104818-lin.cambridge.arm.com>
 <56BDFC86.5010705@arm.com>
 <20160212160652.GL31665@e104818-lin.cambridge.arm.com>
 <56C1E072.2090909@virtuozzo.com>
 <20160215185957.GB19413@e104818-lin.cambridge.arm.com>
 <56C31D1D.50708@virtuozzo.com> <20160217143950.GC32647@leverpostej>
 <56C4A06F.3040702@virtuozzo.com>
Message-ID: <20160217193532.GL32647@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 07:31:43PM +0300, Andrey Ryabinin wrote:
> On 02/17/2016 05:39 PM, Mark Rutland wrote:
> > Andrey, on a tangential note, what do we do around hotplug? I assume
> > that we must unpooison the shadow region for the stack of a dead CPU,
> > but I wasn't able to figure out where we do that. Hopefuly we're not
> > just getting lucky?
> 
> We do nothing about it. AFAIU we need to clear swapper's stack,
> somewhere in secondary_start_kernel() perhaps.

Oh, joy...

Surely other architectures (e.g. x86) will need to do something similar?

Do they do anything currently? I can't see that they do...

Mark.
