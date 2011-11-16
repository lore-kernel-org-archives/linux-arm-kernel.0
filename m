From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Wed, 16 Nov 2011 08:48:22 +0200
Subject: [PATCH v2 1/5] dmaengine: add ep93xx DMA support
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F3E93FDC22@AUSP01VMBX24.collaborationhost.net>
References: <cover.1306662317.git.mika.westerberg@iki.fi>
 <3ea8d56034f25cbe3fd8a4c31d7d0d1540b6ac7e.1306662317.git.mika.westerberg@iki.fi>
 <4EC27EED.4030108@metasoft.pl>
 <ADE657CA350FB648AAC2C43247A983F001F3E93FDC22@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20111116064822.GA2703@mwesterb-mobl.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2011 at 11:59:50AM -0600, H Hartley Sweeten wrote:
> >
> > Index: linux-2.6/drivers/dma/ep93xx_dma.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/dma/ep93xx_dma.c
> > +++ linux-2.6/drivers/dma/ep93xx_dma.c
> > @@ -246,6 +246,7 @@ static void ep93xx_dma_set_active(struct
> >  static struct ep93xx_dma_desc *
> >  ep93xx_dma_get_active(struct ep93xx_dma_chan *edmac)
> >  {
> > +	BUG_ON(list_empty(&edmac->active));
> 
> BUG_ON is evil...
> 
> I'm not sure this is the right way to handle this.
> 
> If your doing dma the list should never be empty.  If it is I think it should
> have been caught way before this.  Mika, do you have any comments?

I agree - the list should never be empty when this is called. The actual bug
is somewhere else.
