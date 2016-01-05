From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 4 Jan 2016 20:42:29 -0500 (EST)
Subject: [PATCH] ARM: Runtime patch udiv/sdiv instructions into
 __aeabi_{u}idiv()
In-Reply-To: <20160105012319.GC22188@codeaurora.org>
References: <alpine.LFD.2.20.1512110105450.26920@knanqh.ubzr>
 <alpine.LFD.2.20.1512111125330.26920@knanqh.ubzr>
 <alpine.LFD.2.20.1512111216350.26920@knanqh.ubzr>
 <1941958.3p422lB7Mz@wuerfel>
 <alpine.LFD.2.20.1512111842280.26920@knanqh.ubzr>
 <20160105012319.GC22188@codeaurora.org>
Message-ID: <alpine.LFD.2.20.1601042035190.3603@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 4 Jan 2016, Stephen Boyd wrote:

> On 12/11, Nicolas Pitre wrote:
> > Stephen's series could still be relevant by extending what is done here, 
> > and it requires what this patch is doing anyway for those call sites 
> > that can't be substituted by a div instruction (like conditional 
> > branches, tail call optimizations, etc.)
> > 
> 
> I'm back from vacation now. Where have we left off on this topic?
> 
> I can update the patches to be based on this patch here and
> handle the conditional branches and tail call optimization cases
> by adding some safety checks like we have for the ftrace branch
> patching. But I'd rather not do that work unless we all agree
> that it's worthwhile pursuing it.
> 
> Is there still any concern about the benefit of patching each
> call site vs. patching the functions? The micro benchmark seems
> to show some theoretical improvement on cortex-a7 and I can run
> it on Scorpion and Krait processors to look for any potential
> benefits there, but I'm not sure of any good kernel benchmark for
> this. If it will be rejected due to complexity vs. benefit
> arguments I'd rather work on something else.

You could run the benchmark on Scorpion and Krait to start with. If 
there is no improvement what so ever like on A15's then the answer might 
be rather simple.


Nicolas
