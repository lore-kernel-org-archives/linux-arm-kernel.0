From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Oct 2017 17:13:34 +0200
Subject: [PATCH 1/2] dt-bindings: add binding for A64 DE2 CCU with SRAM
 section
In-Reply-To: <b8c770bdc7a0541b8d1179598d814b75@aosc.io>
References: <20171014122925.13220-1-icenowy@aosc.io>
 <20171016091136.b4rnckh2tfi26shx@flea.lan>
 <d62ac8b8ff9073b886ceaa9ce54e6903@aosc.io>
 <20171016120912.lxu7rikhffxsu5o4@flea.lan>
 <b8c770bdc7a0541b8d1179598d814b75@aosc.io>
Message-ID: <20171027151334.c3b7yqoiexgwopsf@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 27, 2017 at 10:33:29PM +0800, icenowy at aosc.io wrote:
> ? 2017-10-16 20:09?Maxime Ripard ???
> > On Mon, Oct 16, 2017 at 05:41:10PM +0800, icenowy at aosc.io wrote:
> > > ? 2017-10-16 17:11?Maxime Ripard ???
> > > > On Sat, Oct 14, 2017 at 08:29:24PM +0800, Icenowy Zheng wrote:
> > > > > A64's Display Engine 2.0 needs a section of SRAM (SRAM C) to be
> > > > > claimed.
> > > >
> > > > Why?
> > > 
> > > Allwinner didn't document this, but if the SRAM is not claimed, the
> > > DE2 MMIO zone is totally not accessible.
> > 
> > Not accessible how? It generates an abort when you access it? It
> > returns 0?
> > 
> > > It seems that Allwinner uses the SRAM C in the DE2 internally.
> > 
> > Then shouldn't it be tied to all the DE2 devices then? So mixers
> > too. Either way, this should be mentionned in your commit logs. How
> > you're fixing things is much less interesting than why you're doing
> > them. You can tell how you're doing them from your code already.
> 
> Yes I checked and when the SRAM is not claimed any part in DE2 memory
> zone can't be accessed.

Then all the nodes that depend on it should have it, and the bindings
should be modified appropriately.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171027/59cf5cc0/attachment.sig>
