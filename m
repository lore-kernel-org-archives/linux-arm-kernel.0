From: tony@atomide.com (Tony Lindgren)
Date: Mon, 18 Apr 2011 11:10:52 +0300
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110416165725.GA25811@opensource.wolfsonmicro.com>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<20110414110854.GF29938@atomide.com>
	<20110414120209.GG1611@n2100.arm.linux.org.uk>
	<20110414123126.GA3336@atomide.com>
	<BANLkTi=3+yQU_URj0Tao_MP7v=O7cO_ftg@mail.gmail.com>
	<20110415155642.GO1611@n2100.arm.linux.org.uk>
	<BANLkTi=iqcwq+kEaDEWGrCAutZUAPPXFyw@mail.gmail.com>
	<20110416082802.GS1611@n2100.arm.linux.org.uk>
	<20110416165725.GA25811@opensource.wolfsonmicro.com>
Message-ID: <20110418081050.GG12272@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown <broonie@opensource.wolfsonmicro.com> [110416 19:54]:
> On Sat, Apr 16, 2011 at 09:28:02AM +0100, Russell King - ARM Linux wrote:
> 
> > Towards the end of the cycle, we may be able to consider some platforms,
> > but _only_ if they make use of the consolidated features and therefore
> > have _minimal_ additional code.
> 
> ...this is the negative side of the message - what we're not willing to
> accept.  What's the positive side of the message, what can people do to
> help?  What is the level of consolidation work that's needed before we
> can develop again, and what's needed to make progress there?

I gues a large chunk of the consolidation work will happen only after
we have some new frameworks in place.

But meanwhile there is still tons of work left to do in coalescing
code just within the various ARM architectures. 

I think we _should_ accept new platforms if they're sane as we
don't have any alternative available.

But with the existing platforms, I think that the policy for the
next merge window should  be that more code disappears than gets
added.
 
> For example, with support for new machines are we saying that for
> example we're going to refuse to accept anything that isn't device tree
> based?  If so then what needs doing?

Well we can't require that until the device tree code is merged.
And for older platforms, we need the device tree append support.

It seems that there is still at least one problem with the device
tree append support, but once that's sorted out we should
probably merge that code.

Adding a new machine should be a minimal amount of code already.
So with existing platforms that amount of code can be "exchanged"
for some platform code consolidation patches :)

Regards,

Tony
