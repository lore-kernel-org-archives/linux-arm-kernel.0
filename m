From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 14:51:53 +0100
Subject: [PATCH 1/2] MTD: s3c2410_nand: Add option to disable hw ECC at
	runtime
In-Reply-To: <1302876071.3220.60.camel@localhost>
References: <1302637672-25339-1-git-send-email-lars@metafoo.de>
	<1302782911.2796.21.camel@localhost> <4DA7094D.9070002@metafoo.de>
	<1302876071.3220.60.camel@localhost>
Message-ID: <20110428135153.GB19709@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 05:01:11PM +0300, Artem Bityutskiy wrote:
> Well, I got this understanding by talking to the OMAP maintainer and by
> chatting with rmk. But I might be wrong. So the understanding is that
> board data extending is banned, at least for a while. And the arm world
> has to consolidate and probably switch to the DT tree approach. This
> would be painful, this would make some vendors to return to behind the
> curtains, so this would be a step back in the short run.

Well, what Linus desires from ARM folk is a concerted effort to get the
ARM tree 'under control' and stop the thing forever increasing without
any apparant control.

Linus has said is that if arch/arm/mach* show up with significant numbers
of net additional lines of code in the diffstat, he'll refuse to pull the
git tree.  (See various mails from Linus on linux-arm-kernel.)

My preference is to limit this merge window to just consolidation and
bug fixes so that we can show that we're taking the issue seriously and
are putting a decent amount of effort into addressing the problem.
However, the problem with adding new stuff is that it dilutes the
diffstat, and makes it much harder to show that we're doing what's
required.

Eg, lets say we end up removing 1000 LOC, but end up adding 1000 LOC of
new platform data via other trees.  I don't think Linus will be pleased
when he comes to the end of the merge window and arch/arm/ again shows
up heavily in the statistics without a significant reduction.  I suspect
if that were to happen, things will get much harder for us.

When you bear in mind that in total, arch/arm was pusing 60k lines of
new code into the kernel _each_ merge window.  If we manage to reduce
the size of arch/arm by only 10k, it is really just a small drop in the
ocean in comparison - we need much more effort than that...
