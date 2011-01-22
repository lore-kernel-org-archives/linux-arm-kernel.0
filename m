From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 22 Jan 2011 18:49:09 +0000
Subject: [PATCH 0/7] Nexus One Support
In-Reply-To: <AANLkTinH47x9S8m3yKt3MarCDudB0Sdh3gFWb_MHGrRA@mail.gmail.com>
References: <1295632828.19880.22.camel@m0nster>
	<20110121100441.06a94482@jbarnes-desktop>
	<1295633882.19880.31.camel@m0nster>
	<AANLkTi=L+MW5-KLP_TKSxhstD8JEtBW=RKci5wSbZsd6@mail.gmail.com>
	<1295642995.19880.42.camel@m0nster>
	<1295643762.25868.31.camel@Joe-Laptop>
	<1295645098.22882.1.camel@m0nster>
	<AANLkTi=mvdfpCPefGeDr+eGxpSUr3is5jgugHtgB-m1w@mail.gmail.com>
	<20110122122018.GC5194@n2100.arm.linux.org.uk>
	<AANLkTinH47x9S8m3yKt3MarCDudB0Sdh3gFWb_MHGrRA@mail.gmail.com>
Message-ID: <20110122184909.GB11960@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 22, 2011 at 10:06:44AM -0800, Dima Zavin wrote:
> All I ask is that if files are directly copied out of the tree with
> only slight modifications or if they are copied and stripped down for
> easier consumption, just say
> Original Authors: <dude@co> if it's reasonable to gather who the
> primary contributors are. If that is hard due to lots of commits and
> squashes, even a Cc: to the people who wrote the code would have been
> enough. Had any of that been done, I would have not said a word.

Well, having read what Thomas said in his mail:

Thomas said:
| Patch 3/7 is extracted from another large dump (37431502c4) in the
| android tree which has:
[diffstat summary cut]
| And if you look at the above 37431502c4 commit then you'll notice that
| the author is Dima Zavin <dima@android.com>, while in fact the whole
| commit is a conglomerate of commits from some other place with 16
| different authors, but there is no way to identify who wrote what.

I decided to investigate:

http://android.git.kernel.org/?p=kernel/msm.git;a=commit;h=37431502c4

| author	Dima Zavin <dima@android.com>
| committer	Arve Hj?nnev?g <arve@android.com>
|
| [ARM] msm: mahimahi: Update the memory map.
| 
| - move framebuffer to SMI and mdp pmem to bank 2 of EBI
| - remove the gpu pmem regions since we now use the MMU
| - move the adsp region to bank 2, and make it bigger (41MB vs 32MB)
| - move ram console to SMI
| 
| Change-Id: I88b4033e98374fc038609fbbb1c7e5cbed4f87c4
| Signed-off-by: Dima Zavin <dima@android.com>
| 
| [ARM] msm: mahimahi: Expand memory available to kernel to 219MB
| 
| Change-Id: I59e69ce4209d16ce9804d3fa81814c9d0bda9a03
| Signed-off-by: Dima Zavin <dima@android.com>
| 
| [ARM] msm: mahimahi: Read bluetooth address from ATAG and export in sysfs.
| 
| Signed-off-by: Nick Pelly <npelly@google.com>
... etc ...

Those change IDs are meaningless, they provide no way for external people
to trace the history of the original commits and work out who did what
in the resulting diff.

Maybe you could illustrate how to take that particular commit, which
Daniel apparantly based his 3/7 patch on, and identify who Daniel should
and should not give credit to using *just* the text in that commit and
no other information.

If you can't do that without reference to some other information, then I
don't think you have a leg to stand on when complaining to Daniel about
not giving credit, as you've made it impossible for that to happen.

While it is not fair _not_ to give credit to people who worked on a
particular piece of code, it is also not fair _to_ give credit to
people who didn't work on that same code.  It erodes the value of
crediting the real authors.

I'd say that Daniel is doing a bloody good job, everything considered.
