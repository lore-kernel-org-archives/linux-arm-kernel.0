From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 28 Jul 2016 15:28:42 +0200
Subject: [PATCH 4/9] clk: sunxi-ng: mux: Add support for mux tables
In-Reply-To: <20160727103649.9e6ef332847b5a5c8fac66af@free.fr>
References: <1469516671-19377-1-git-send-email-wens@csie.org>
 <1469516671-19377-5-git-send-email-wens@csie.org>
 <20160726194306.9b6aadd3d1669bd6f5a54d99@free.fr>
 <20160727065934.GD6560@lukather>
 <20160727091827.e26f72701ce5758fa29aff7a@free.fr>
 <20160727074020.GH6560@lukather>
 <20160727103649.9e6ef332847b5a5c8fac66af@free.fr>
Message-ID: <20160728132842.GA6682@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2016 at 10:36:49AM +0200, Jean-Francois Moine wrote:
> On Wed, 27 Jul 2016 09:40:20 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > > > Parenting functions would also not work as expected,
> > > > clk_hw_get_parent_by_index being the obvious example, in that case
> > > > returning the empty string for an invalid parent, while it should
> > > > really return NULL.
> > > 
> > > I don't see why the clock should be orphan.
> > > Then, when a parent is "", clk_hw_get_parent_by_index() returns NULL.
> > 
> > Why? It should return NULL when there's no parent, while you
> > explicitly registered a parent.
> 
> "" is not an existing parent. It could be "none" / "dum" / "toto" / ...
> with the same result: 'this index cannot be used in mux'.

And the clock is marked as orphan, while it really isn't.

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160728/82b5fabd/attachment.sig>
