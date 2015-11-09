From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 9 Nov 2015 13:14:13 -0800
Subject: [GIT PULL] Allwinner DT changes for 4.4, round 3
In-Reply-To: <20151109000403.GU6114@lukather>
References: <4745252.gLSrJNQ42D@wuerfel> <9946613.K7Ehp1DEiL@wuerfel>
 <20151025201308.GS10947@lukather>
 <20151026010752.GG14238@localhost>
 <CAGb2v671MmpRHkWKpOd8kmEbvfTKTU9k7AU_bP+AgRuguodWkQ@mail.gmail.com>
 <20151026054828.GD4216@localhost> <20151026103409.GX10947@lukather>
 <CAOesGMjNQeaA0etj0fk0E_QPNLYA3WTaRCfWE7YFz50RoDXu-w@mail.gmail.com>
 <20151102191923.GO19782@codeaurora.org>
 <20151109000403.GU6114@lukather>
Message-ID: <20151109211413.GC26852@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08, Maxime Ripard wrote:
> On Mon, Nov 02, 2015 at 11:19:23AM -0800, Stephen Boyd wrote:
> > > >> I've merged this in now. Note that this has resulted in a tree that won't
> > > >> misect cleanly, since having the clk contents merged instead of used as a base
> > > >> for the dt branch means that you could end up in a bisect state that has the DT
> > > >> branch but not the clk branch.
> > > >
> > > > Even if it has been merged before the DT patches have been applied?
> > > > That's not really what I'd expect from bisect :/
> > > 
> > > Yeah, due to the way bisect works, the only way to guarantee
> > > bisectability is if you base the DT branch on top of the clk branch
> > > when you build it. Otherwise the bisect can come down the path of only
> > > having the DT contents not the clk contents.
> > 
> > Why can't the dts changes be applied directly on top of the
> > branch that's in the clk tree and then sent off to arm-soc? The
> > git merge && git commit technique also works, but it introduces
> > an unnecessary merge commit into the history.
> 
> Wouldn't that mean that you have to rebase your whole DT branch
> whenever a single patch introduces a dependency on some clock patch?
> 

That depends on whether or not the single patch depends on the
other patches in the "DT" branch. If it did, then do the merge
and apply the single patch on top. But if doesn't, maybe it's
something like new SoC support that needs a binding header, I
would make a second DT branch that points at the branch in the
clk tree and then apply the dt patch directly on top.

Of course, this is just one way to do it. I'm mostly trying to
avoid unnecessary merges, but sometimes merges are unavoidable.
The most important thing is to maintain bisectability and to make
it clear why merges from other trees are done by putting some
sort of reason in the commit text of the merge.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
