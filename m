From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 14 Apr 2011 09:39:58 -0400 (EDT)
Subject: [PATCH 0/2] Common struct clk implementation, v14
In-Reply-To: <20110414120904.GH1611@n2100.arm.linux.org.uk>
References: <1299134429.100626.661279191478.0.gpush@pororo>
	<1302754859.2767.30.camel@pororo>
	<20110414100048.GB1611@n2100.arm.linux.org.uk>
	<1302776705.28876.113.camel@pasglop>
	<20110414103200.GF1611@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104140751220.24613@xanadu.home>
	<20110414120904.GH1611@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1104140920110.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Apr 2011, Russell King - ARM Linux wrote:

> On Thu, Apr 14, 2011 at 07:59:58AM -0400, Nicolas Pitre wrote:
> > Quoting Linus:
> > 
> > | Umm. The whole "number of lines of code" thing has become a total red
> > | herring.
> > | 
> > | THAT IS NOT WHY I STARTED TO COMPLAIN!
> > | 
> > | The reason I point out the number of lines of code is because it's one
> > | of the more obvious _symptoms_ of the problem.
> > 
> > So we need to work on infrastructure, and the clock API is exactly that.  
> > Obviously adding it will increase the number of lines of code initially, 
> > but eventually this will help _reduce_ them, and more importantly it 
> > will allow for the reduction of mindless duplication of code that was 
> > identified as being the actual problem causing maintenance pain.
> 
> Adding it without anyone using it doesn't solve anything.  We need
> people to commit to producing patches to use it for the next merge
> window.

People are simply waiting for the API to hit some upstream tree (like 
yours) before committing to it.  You would be in a much better position 
if those patches are in your tree, so that you can tell people: "Here's 
the Git branch with the API in it, so now I'm expecting patches to 
convert clock users to it".

> And if you think its not about lines of code - grab the current linux-next
> tree and look at the diff between v2.6.39-rc1 and master for arch/arm, and
> then tell me whether using LOC is unreasonable given the patch content.

I might have a look later.  However it is clear that the ARM tree will 
_never_ be as small as, say, X86 or even PPC given the indisputable 
amount of hardware variations within the ARM landscape that is not to be 
seen anywhere else.  Until the ARM ecosystem converge towards a single 
whole-system architecture we won't be able to match X86 in terms of code 
reduction.  Anyone thinking otherwise is living in a different universe.

However we can and must do better in consolidation work in order to make 
the tree more maintainable of course.  _That_ is the real issue and 
_that_ is what the ARM tree sucks at.  The fact that this consolidation 
work might reduce the size of the ARM code is only a side effect, not 
the primary goal.  So let's not get too hung up about LOC but focus on 
improving the infrastructure instead.


Nicolas
