From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 13 Feb 2018 08:07:00 +0100 (CET)
Subject: [PATCH v4 5/5] dmaengine: mediatek: fix zalloc-simple.cocci
 warnings
In-Reply-To: <20180213064659.GD3666@localhost>
References: <cover.1518110810.git.sean.wang@mediatek.com>
 <ede5702c460a5b4b41186a8cff1e3c29b2380c08.1518110810.git.sean.wang@mediatek.com>
 <20180209125817.GB3666@localhost>
 <alpine.DEB.2.20.1802091555290.2944@hadrien>
 <20180213064659.GD3666@localhost>
Message-ID: <alpine.DEB.2.20.1802130805550.2264@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 13 Feb 2018, Vinod Koul wrote:

> On Fri, Feb 09, 2018 at 03:55:58PM +0100, Julia Lawall wrote:
> >
> > > > -	ring->txd = dma_alloc_coherent(hsdma2dev(hsdma),
> > > > -				       pc->sz_ring, &ring->tphys,
> > > > -				       GFP_ATOMIC | __GFP_ZERO);
> > > > +	ring->txd = dma_zalloc_coherent(hsdma2dev(hsdma), pc->sz_ring,
> > > > +					&ring->tphys, GFP_ATOMIC);
> > > >  	if (!ring->txd)
> > > >  		return -ENOMEM;
> > > >
> > > > -	memset(ring->txd, 0, pc->sz_ring);
> > >
> > > This should be folded back..
> >
> > Sorry, I'm not sure what you mean by "folded back".
>
> Since the original patch is also up for review in this series, it doesn't
> help much to add a change and fix on top in a series. The fix should be
> folded back into the original commit. IIRC Fengguang's bot also recommends
> so..

Sure, no problem.  Thanks.  (I thought you meant folding or unfolding of a
function definition).

julia
