From: will.deacon@arm.com (Will Deacon)
Date: Fri, 31 Aug 2018 10:53:51 +0100
Subject: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B090FF3@us01wembx1.internal.synopsys.com>
References: <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com>
 <1535629996.4465.44.camel@synopsys.com>
 <20180830141713.GN24082@hirez.programming.kicks-ass.net>
 <20180830142354.GB13005@arm.com>
 <20180830142920.GO24082@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075012B090EA4@us01wembx1.internal.synopsys.com>
 <20180830204515.GC24124@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075012B090FF3@us01wembx1.internal.synopsys.com>
Message-ID: <20180831095351.GD13166@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 12:30:50AM +0000, Vineet Gupta wrote:
> On 08/30/2018 01:45 PM, Peter Zijlstra wrote:
> >>
> >> Indeed this is the mother of all issues, I tried and system is clearly hosed with
> >> and works after.
> >> What's amazing is the commit 4aef66c8ae9 which introduced it is from 2016 ;-)
> >> Back then we had a retry branch with backoff stuff which I'd reverted for new
> >> cores and the merge conflict somehow missed it.
> >>
> >> @PeterZ I'll create a patch with you as author ? do I need any formal sign offs,
> >> acks etc ?
> > Well, Will spotted it, give authorship to him, you have my ack per the
> > above.
> 
> Oops, sorry for the mixup. I have him as author now and pushed to ARC for-curr
> (will trickle into linux-next eventually).

Okey doke: you can have my Signed-off-by for all the diffs I sent. Just
stick something like [vineet: wrote commit message] in there so I don't
read it in the future and confuse myself.

Will
