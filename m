From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 14 May 2011 10:49:20 +0100
Subject: [patch v4 3/3] arm: omap4: support pmu
In-Reply-To: <BANLkTimkrf8-+-JTQy-gWK9t9grj-n0Ftw@mail.gmail.com>
References: <1299598729-27974-1-git-send-email-tom.leiming@gmail.com>
	<1299598729-27974-4-git-send-email-tom.leiming@gmail.com>
	<BANLkTi=u8Lv=MR+gW_KmsOJn99Vv2sNkmg@mail.gmail.com>
	<BANLkTimkrf8-+-JTQy-gWK9t9grj-n0Ftw@mail.gmail.com>
Message-ID: <20110514094920.GA6803@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 14, 2011 at 04:48:52PM +0800, Ming Lei wrote:
> Hi Rabin,
> 
> 2011/5/14 Rabin Vincent <rabin@rab.in>:
> > What happened to this patch? ?It is neither in mainline nor in
> > linux-next.
> >
> 
> This patch depends on the two with titles:
> 
>       introduce cross trigger interface helpers
>       pmu: allow platform specific irq enable/disable handling
> 
> and the above patches have been submitted to RMK's patch system
> as 6839/1 and 6840/1, but not been pushed to -next or mainline by rmk,
> so I can't ask omap guys to merge this one into their tree now.

Given the state of linux-next, which isn't showing much in the way of
consolidation by anyone other than what's in my tree, I'm _desperately_
avoiding adding any new code for this coming merge window.  In fact, the
picture in linux-next is looking worse than the state of my tree.

For arch/arm, my tree looks like this:

 256 files changed, 1022 insertions(+), 14022 deletions(-)

And for-next:

 748 files changed, 15066 insertions(+), 26209 deletions(-)

So there's a net reduction of 13000 lines in my tree, compared to a net
reduction of 11143 lines in linux-next - so a net increase of 1857 lines
for arch/arm from trees which aren't my tree.

This is rather disappointing, and if linux-next really does reflect the
current state across all ARM trees, it means that we have to keep the
consolidation agenda running into the next merge cycle.

So, I really can not afford to be adding new stuff into my tree at the
present time.
