From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 18 Apr 2011 14:57:04 +0100
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110418081050.GG12272@atomide.com>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<20110414110854.GF29938@atomide.com>
	<20110414120209.GG1611@n2100.arm.linux.org.uk>
	<20110414123126.GA3336@atomide.com>
	<BANLkTi=3+yQU_URj0Tao_MP7v=O7cO_ftg@mail.gmail.com>
	<20110415155642.GO1611@n2100.arm.linux.org.uk>
	<BANLkTi=iqcwq+kEaDEWGrCAutZUAPPXFyw@mail.gmail.com>
	<20110416082802.GS1611@n2100.arm.linux.org.uk>
	<20110416165725.GA25811@opensource.wolfsonmicro.com>
	<20110418081050.GG12272@atomide.com>
Message-ID: <20110418135704.GB1765@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 11:10:52AM +0300, Tony Lindgren wrote:
> * Mark Brown <broonie@opensource.wolfsonmicro.com> [110416 19:54]:

> > ...this is the negative side of the message - what we're not willing to
> > accept.  What's the positive side of the message, what can people do to
> > help?  What is the level of consolidation work that's needed before we
> > can develop again, and what's needed to make progress there?

> I gues a large chunk of the consolidation work will happen only after
> we have some new frameworks in place.

> But meanwhile there is still tons of work left to do in coalescing
> code just within the various ARM architectures. 

> I think we _should_ accept new platforms if they're sane as we
> don't have any alternative available.

> But with the existing platforms, I think that the policy for the
> next merge window should  be that more code disappears than gets
> added.

This is all fairly sensible and reasonable but unfortunately it's not
what's actually being said - what's actually being said is a flat
refusal to accept any new code at all, even when we have no idea what a
viable alternative might be and no matter what other progress is made,
and no clear route to opening up that possibility.

I do think that a flat lines of code criterion isn't terribly helpful as
it isn't *really* what we're trying to optimise and will needlessly
peanalise newer architectures which have good reasons for active
development (like having been merged recently and only having stub
support initially).  There's a big difference between an established
architecture and a recent one here.

> > For example, with support for new machines are we saying that for
> > example we're going to refuse to accept anything that isn't device tree
> > based?  If so then what needs doing?

> Well we can't require that until the device tree code is merged.
> And for older platforms, we need the device tree append support.

> It seems that there is still at least one problem with the device
> tree append support, but once that's sorted out we should
> probably merge that code.

I think we need the append support for all platforms - the idea of
having the description of the CPU in each board device tree just doesn't
seem sensible to me.

> Adding a new machine should be a minimal amount of code already.
> So with existing platforms that amount of code can be "exchanged"
> for some platform code consolidation patches :)

You can easily be pushing at something in four digits by the time you
map out a large board, it's certainly not a trivial amount of code to go
trying to save especially when that's not really directly relevant to
improving the reuse for board drivers and you get into diminishing
returns fairly rapidly.

This does also come back to the whole thing about pointing at relevant
work that people can do - we're not telling people the code they're
submitting is problematic and they need to address things with it, we're
saying that we're not even willing to look at the code or talk about
things that would make it OK.  That's a really negative response that's
essentially impossible to work with.
