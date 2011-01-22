From: swetland@google.com (Brian Swetland)
Date: Sat, 22 Jan 2011 11:22:57 -0800
Subject: [PATCH 0/7] Nexus One Support
In-Reply-To: <20110122122018.GC5194@n2100.arm.linux.org.uk>
References: <20110121094827.41818a55@jbarnes-desktop>
	<20110121095658.1ab623fe@jbarnes-desktop>
	<1295632828.19880.22.camel@m0nster>
	<20110121100441.06a94482@jbarnes-desktop>
	<1295633882.19880.31.camel@m0nster>
	<AANLkTi=L+MW5-KLP_TKSxhstD8JEtBW=RKci5wSbZsd6@mail.gmail.com>
	<1295642995.19880.42.camel@m0nster>
	<1295643762.25868.31.camel@Joe-Laptop>
	<1295645098.22882.1.camel@m0nster>
	<AANLkTi=mvdfpCPefGeDr+eGxpSUr3is5jgugHtgB-m1w@mail.gmail.com>
	<20110122122018.GC5194@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=47z21zExtfHq2WYdUdXeC1rNhe7vQsqPkFsMi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 22, 2011 at 4:20 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> One of the problems of preserving the micro-detail of history right
> from the early inception of support for a platform is that quite often
> the early support is buggy or broken - it might not even compile.  There
> may be 20 or so patches on top of that which eventually get it to a
> usable state.
>
> Do we really want to put off people from reviewing patches because of
> the size of micro-development that happened prior to getting to a point
> where the result of that development is usable?
...
>
> I personally believe that Daniel is doing the right thing here, except
> he needs to preserve a better record of authorship.  I even think it's
> fine if he decides to drop people's sign-offs if he thinks the code has
> changed significantly from the original authors - provided he's willing
> to take responsibility for the submission of that code.
>
> If you read what a sign-off means (the DCO) then it's clear that if the
> code has changed significantly, the original sign-offs do not apply
> anymore - the original sign-offs can't warrant that the modified code
> is covered by appropriate licenses or even that the person who modified
> their code has the rights to submit it.

I completely agree that it's not realistic that the entire development
history of this code be preserved as it goes upstream.  Nobody needs
to see the 20-30 fiddly changes over a couple months of people from
three companies tinkering with subtleties of the SCPLL sequencing for
QSD8x50, when the end result is (hopefully) 200-300 lines of working
code.

I also will state that I have absolutely no problem with people
picking patches that we've made available, tidying things up, and
pushing them into mainline, particularly bits that have languished for
a while.  At the same time, we're working to improving our process for
future work -- for example the Tegra2 development efforts, I believe,
have been a step forward as far as getting stuff upstream from the
start of a project.

All we ask is that some reasonable acknowledgement of original
authorship is maintained for non-trivial work.  A 5-10 line patch that
deals with mechanical issues of board files or cleans stuff up is no
big deal.  100s of lines that represent some real work is something
else.

I'm in the same boat as Daniel much of the time, since we often do
spend some time toward the end of a development cycle collapsing a
bunch of patches from multiple developers at Google or closely-working
OEM partners down into a smaller set that hopefully makes a little bit
more sense.

What would be useful would be a reasonable convention for
acknowledging multiple authors, perhaps something along the lines of:

Author: Awesome Upstreamer <au@example.com>  or  Main Author <main@example.com>
Committer: Awesome Upstreamer <au@example.com>
Subject: arm: msm8k: acpu clock management

... summary of the patch ...

Original-Author: Joe Firmware Guy <joe@oem.com>
Original-Author: Kernel Droid <droid@android.com>
Signed-off-by: ...

Though I'm not sure "Original-Author" is the best phrasing here...  Or
perhaps just having the patch description end with "This patch is
based on original code by Joe Firmware Guy, Kernel Droid, etc is the
way to go.  I do think that for work where there is one clear original
author, it's nice to leave them as the Author, but at the end of the
day, provided the code's heading in the right direction and the
contributors are acknowledged, that's a detail.

If there's some consensus on the way to do this, we can make sure to
use the same method when we're collapsing history on our own patchsets
(obviously the current model we're using can be messy and confusing)
to simplify things going forward.

Brian
