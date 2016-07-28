From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 28 Jul 2016 16:23:05 +0200
Subject: [PATCH 4/9] clk: sunxi-ng: mux: Add support for mux tables
In-Reply-To: <20160728132842.GA6682@lukather>
References: <1469516671-19377-1-git-send-email-wens@csie.org>
 <1469516671-19377-5-git-send-email-wens@csie.org>
 <20160726194306.9b6aadd3d1669bd6f5a54d99@free.fr>
 <20160727065934.GD6560@lukather>
 <20160727091827.e26f72701ce5758fa29aff7a@free.fr>
 <20160727074020.GH6560@lukather>
 <20160727103649.9e6ef332847b5a5c8fac66af@free.fr>
 <20160728132842.GA6682@lukather>
Message-ID: <20160728162305.b157e6a8073c7db375f2b5d3@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Jul 2016 15:28:42 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Wed, Jul 27, 2016 at 10:36:49AM +0200, Jean-Francois Moine wrote:
> > On Wed, 27 Jul 2016 09:40:20 +0200
> > Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> > 
> > > > > Parenting functions would also not work as expected,
> > > > > clk_hw_get_parent_by_index being the obvious example, in that case
> > > > > returning the empty string for an invalid parent, while it should
> > > > > really return NULL.
> > > > 
> > > > I don't see why the clock should be orphan.
> > > > Then, when a parent is "", clk_hw_get_parent_by_index() returns NULL.
> > > 
> > > Why? It should return NULL when there's no parent, while you
> > > explicitly registered a parent.
> > 
> > "" is not an existing parent. It could be "none" / "dum" / "toto" / ...
> > with the same result: 'this index cannot be used in mux'.
> 
> And the clock is marked as orphan, while it really isn't.

Sorry for I don't follow you.

A clock is orphan when it has no parent. In our case, there are many
possible parents and, at startup time, the hardware or the boot sets
the mux to point to a real parent, with an index out of the usused
values.
Yes, the clock may be orphan, as the other clocks, but just the time
this real parent becomes visible.

So, how could such a clock stay marked as orphan?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
