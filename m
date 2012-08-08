From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 8 Aug 2012 12:56:54 -0400 (EDT)
Subject: [PATCH 01/22] ARM: add mechanism for late code patching
In-Reply-To: <20120808160517.GO18957@n2100.arm.linux.org.uk>
References: <1343775898-28345-1-git-send-email-cyril@ti.com>
 <1343775898-28345-2-git-send-email-cyril@ti.com>
 <alpine.LFD.2.02.1208040045360.5231@xanadu.home> <50219C45.7030601@ti.com>
 <alpine.LFD.2.02.1208080106500.5231@xanadu.home> <5022673A.7060407@ti.com>
 <alpine.LFD.2.02.1208080948210.5231@xanadu.home>
 <20120808160517.GO18957@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1208081248340.5231@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Aug 2012, Russell King - ARM Linux wrote:

> On Wed, Aug 08, 2012 at 09:55:12AM -0400, Nicolas Pitre wrote:
> > On Wed, 8 Aug 2012, Cyril Chemparathy wrote:
> > > Neat macro magic.  Are you thinking that we build this in as a self test in
> > > the code?
> > 
> > For such things, this is never a bad idea to have some test alongside 
> > with the main code, especially if this is extended to more cases in the 
> > future.  It is too easy to break it in subtle ways.
> > 
> > See arch/arm/kernel/kprobes-test*.c for a precedent.
> 
> Done correctly, it shouldn't be a problem, but I wouldn't say that
> arch/arm/kernel/kprobes-test*.c is done correctly.  It's seen quite
> a number of patching attempts since it was introduced for various
> problems, and I've seen quite a number of builds fail for various
> reasons in this file (none which I could be bothered to investigate.)
> 
> When the test code ends up causing more problems than the code it's
> testing, something is definitely wrong.

I think we shouldn't compare the complexity of test code for kprobes and 
test code for runtime patching code.  The former, while more difficult 
to keep compiling, has found loads of issues in the former kprobes code.  
So it certainly paid back many times its cost in maintenance.

My mention of it wasn't about the actual test code implementation, but 
rather about the fact that we do have test code in the tree which can be 
enabled with a config option.

As for build failures with that test code, I'd suggest you simply drop a 
note to Tixy who is normally very responsive.  I randomly enable it 
myself and didn't run into any issues yet.


Nicolas
