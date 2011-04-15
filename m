From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 15 Apr 2011 09:12:39 -0600
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110414123126.GA3336@atomide.com>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<20110414110854.GF29938@atomide.com>
	<20110414120209.GG1611@n2100.arm.linux.org.uk>
	<20110414123126.GA3336@atomide.com>
Message-ID: <BANLkTi=3+yQU_URj0Tao_MP7v=O7cO_ftg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2011 at 6:31 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110414 14:59]:
>> On Thu, Apr 14, 2011 at 02:08:54PM +0300, Tony Lindgren wrote:
>> >
>> > It's going to take some time before the consolidated code starts
>> > being available.. And until we have something available, we all
>> > should aim for negative diffstat.
>>
>> I think we've already lost any hope of a negative diffstat - with 6k new
>> lines, we will need a heck of a lot of consolidation to counter that.
>>
>> The only thing which I've seen any work being put into is some of the
>> GPIO code - which will be lost in the noise in much the same way that
>> my ARM platform consolidation and deletion of two machine classes in
>> the last merge window was. ?That resulted in the deletion of around 10k
>> lines from the kernel as a whole, or 4.5k lines from arch/arm.
>>
>> Some people are believing that Linus' complaint is about the core ARM
>> code rather than the platform specific code which is the problem.
>
> I think that 6k lines of new code should wait in the platform specific
> trees and not get merged until we have some real progress on the
> consolidation of code.
>
>> We need significant amounts of effort to reverse this - and the more new
>> stuff that appears in peoples trees (and therefore linux-next) the bigger
>> problem we have to convince Linus that we're taking him seriously.
>>
>> So, I think we've already lost any hope of making Linus happy for the
>> next merge window. ?I wish I'm wrong on that, but I don't think so.

Linus isn't stupid either though.  He knows lots of effort is going
into fixing things but that it takes time to get it sorted out.  I
expect he'll provide some grace as we get our house in order, so to
speak.

>
> We should make it clear that we're not merging new code except for code
> consolidation. Looks like some people have missed it despite the
> massive flaming.

I hate to disagree, but I fear that stopping simply isn't an option.
We've finally got many of the vendors to care about upstreaming their
code (which in large part created this new problem).  Turning around
and saying no new code is accepted until an unspecified set of changes
and consolidations are made in mainline both risks that relationship
and it doesn't to anything to stem the tide of new platforms that need
to be supported in some way.

At the very least, if we say 'no' to new code, then at the same time
we must give developers specific options on what they can do right now
to make the code acceptable.  If we cannot provide constructive
alternatives, then it is better to go ahead and accept the code
(assuming the code quality is up-to-snuff, and it follows current
patterns).  I've heard from non-core developers who are more than
willing to make changes to their code to make it ready for upstream,
but are frustrated about simply not knowing how to change their code
to meet the new consolidation requirements.  For example, John Linn
has posted support for the new Xilinx ARM FPGA platform, has been
through several rounds of review, but now he fears that it will all be
rejected and he'll have to start over in 3 months.

On Thu, Apr 14, 2011 at 8:20 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> I think we need to give people a tractable route to addressing the
> consolidation issues with the code they're trying to contribute before
> we start rejecting code.  If we can identify something useful that
> people can do that's in some way related to what they're trying to
> accomplish that's constructive and likely to inspire contributions to
> the consolidation efforts but if we're rejecting the code without
> any route to improving it that's much less so.

+1

g.
