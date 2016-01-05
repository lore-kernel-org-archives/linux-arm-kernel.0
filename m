From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 4 Jan 2016 17:23:19 -0800
Subject: [PATCH] ARM: Runtime patch udiv/sdiv instructions into
 __aeabi_{u}idiv()
In-Reply-To: <alpine.LFD.2.20.1512111842280.26920@knanqh.ubzr>
References: <alpine.LFD.2.20.1512110105450.26920@knanqh.ubzr>
 <alpine.LFD.2.20.1512111125330.26920@knanqh.ubzr>
 <alpine.LFD.2.20.1512111216350.26920@knanqh.ubzr>
 <1941958.3p422lB7Mz@wuerfel>
 <alpine.LFD.2.20.1512111842280.26920@knanqh.ubzr>
Message-ID: <20160105012319.GC22188@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11, Nicolas Pitre wrote:
> On Fri, 11 Dec 2015, Arnd Bergmann wrote:
> 
> > On Friday 11 December 2015 12:22:20 Nicolas Pitre wrote:
> > > Subject: [PATCH] ARM: Runtime patch udiv/sdiv instructions into __aeabi_{u}idiv()
> > > 
> 
> Thanks.
> 
> > Before you put it in the patch tracker, I think it would be good to
> > give Stephen a chance to comment as well, since he did a lot of
> > work upfront and this obsoletes his original patch series.
> 
> Given he'll get back from vacation only after the new year, I'll put the 
> patch in the tracker now so it can go in before the next merge window.  
> 
> Stephen's series could still be relevant by extending what is done here, 
> and it requires what this patch is doing anyway for those call sites 
> that can't be substituted by a div instruction (like conditional 
> branches, tail call optimizations, etc.)
> 

I'm back from vacation now. Where have we left off on this topic?

I can update the patches to be based on this patch here and
handle the conditional branches and tail call optimization cases
by adding some safety checks like we have for the ftrace branch
patching. But I'd rather not do that work unless we all agree
that it's worthwhile pursuing it.

Is there still any concern about the benefit of patching each
call site vs. patching the functions? The micro benchmark seems
to show some theoretical improvement on cortex-a7 and I can run
it on Scorpion and Krait processors to look for any potential
benefits there, but I'm not sure of any good kernel benchmark for
this. If it will be rejected due to complexity vs. benefit
arguments I'd rather work on something else.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
