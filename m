From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 18 Apr 2011 23:40:15 +0200 (CEST)
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110418202301.GA13808@opensource.wolfsonmicro.com>
References: <20110414120209.GG1611@n2100.arm.linux.org.uk>
	<20110414123126.GA3336@atomide.com>
	<BANLkTi=3+yQU_URj0Tao_MP7v=O7cO_ftg@mail.gmail.com>
	<20110415155642.GO1611@n2100.arm.linux.org.uk>
	<BANLkTi=iqcwq+kEaDEWGrCAutZUAPPXFyw@mail.gmail.com>
	<20110416082802.GS1611@n2100.arm.linux.org.uk>
	<20110416165725.GA25811@opensource.wolfsonmicro.com>
	<20110418081050.GG12272@atomide.com>
	<20110418135704.GB1765@opensource.wolfsonmicro.com>
	<20110418171857.GC25671@n2100.arm.linux.org.uk>
	<20110418202301.GA13808@opensource.wolfsonmicro.com>
Message-ID: <alpine.LFD.2.00.1104182315180.2744@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Apr 2011, Mark Brown wrote:
> On Mon, Apr 18, 2011 at 06:18:57PM +0100, Russell King - ARM Linux wrote:
> 
> > Linus has replied in this thread with his view, which is not much
> > different from the view which I've been stating all along.
> 
> Yeah, I saw that.  Quite frankly it's astonishing - I must apologise, I
> had thought you were most likely misinterpreting what he was saying.

Sigh.
 
> > Will we ever be able to put John's code in the kernel?  Honestly, I have
> > no idea.  What I do know is that unless we start doing something to solve
> > the problem we have today with the quantity of code under arch/arm _and_
> > the constant churn of that code, we will _never_ be able to add new
> > platform support in any shape or form to the kernel.
> 
> Given where we're at right now I'm guessing we're going to see ARM
> development halted until at least the merge window after next which is
> 5-6 months or so.  We're not talking about trivial bits of
> infrastructure here and obviously any substantial reworks here are going
> to involve churn anyway.
> 
> To make matters worse unless people just give up the longer we keep the
> tree shut down the larger the merge will be when it does reopen.

I tend to disagree. It's not rocket science to cleanup stuff just
along the way. I did the (not yet perfect) conversion of about 20 irq
chips on saturday just to see how far I get with that abstract
chip. And it simply got rid of >1200 LOC with some more potential
reduction already detected.

So when we come up with such generic abstractions then it's not
a too big burden for a maintainer to care about his 1 or 2 irq chips
and some other small cleanups here and there.

Linus does not expect that ARM code shrinks 80% in the next cycle, but
he wants to see that people take him seriously and actually cut down
code in a diffstat visible way.

Thanks,

	tglx
