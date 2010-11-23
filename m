From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 23 Nov 2010 12:56:18 -0500 (EST)
Subject: [PATCH v2 8/9] ARM: Thumb-2: Fix long-distance conditional
	branches in head.S for Thumb-2.
In-Reply-To: <20101123085649.GA17561@n2100.arm.linux.org.uk>
References: <1290449065-28843-1-git-send-email-dave.martin@linaro.org>
	<1290449065-28843-9-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1011221346170.9313@xanadu.home>
	<20101122191719.GO31227@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1011221512460.9313@xanadu.home>
	<20101122234427.GP31227@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1011221918230.9313@xanadu.home>
	<20101123085649.GA17561@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1011231252470.9313@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Nov 2010, Russell King - ARM Linux wrote:

> On Mon, Nov 22, 2010 at 07:26:51PM -0500, Nicolas Pitre wrote:
> > On Mon, 22 Nov 2010, Russell King - ARM Linux wrote:
> > 
> > > On Mon, Nov 22, 2010 at 03:24:11PM -0500, Nicolas Pitre wrote:
> > > > On Mon, 22 Nov 2010, Russell King - ARM Linux wrote:
> > > > > No, you're not thinking right.  It was _intentional_ that __error_p
> > > > > ended up in a different section to __init.  With CPU hotplug, as it
> > > > > is called from the hotplug CPU initialization path, it needs to be
> > > > > available for that path to call.
> > > > 
> > > > Well... agreed for the hotplug CPU case.  The section selection is good 
> > > > as it is for that.
> > > > 
> > > > However I doubt this was intentional when commit 75d90832d5 was created, 
> > > > which is when the actual section move took place.
> > > 
> > > Well, T2 is not something I particularly test for.  There's already too
> > > many combinations to test as it is.
> > 
> > Fair enough.  My point was only about the unintentional drop of the 
> > __init section attribute for the __error_p and __error_a functions (and 
> > probably some others in head-common.S) from commit 75d9083 which is 
> > orthogonal to the T2 issue.
> 
> What are you talking about Nicolas?
> 
> 75d9083 is about adding nommu support, which was added some 4 years ago
> well before Thumb 2 was talked about.

Exactly my point.

> It moves some code out of head.S,
> and creates a new file, head-common.S to contain this code.

So far so good.

> head-common.S is included by head.S, which means the assembler sees it 
> as a single file.

And that's where I screwed up with my analysis.  I somehow was under the 
impression this was a separate compilation unit.  Sorry for the noise.


Nicolas
