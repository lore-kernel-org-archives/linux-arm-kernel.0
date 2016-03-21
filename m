From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 21 Mar 2016 15:40:24 +0100
Subject: [PATCH v3 4/5] dmaengine: sun6i: Simplify some macros
In-Reply-To: <20160321074843.GX30977@lukather>
References: <cover.1458311540.git.moinejf@free.fr>
 <a25c76bc3c63afc311069366af4970b909d356ef.1458311540.git.moinejf@free.fr>
 <20160321074843.GX30977@lukather>
Message-ID: <20160321154024.75584f8a6b4d1d22035327b8@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Mar 2016 08:48:43 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Fri, Mar 18, 2016 at 03:21:11PM +0100, Jean-Francois Moine wrote:
> > As the max burst and bus width values are now checked, there is
> > no reason to check them again when setting the hardware registers.
> > 
> > Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> > ---
> >  drivers/dma/sun6i-dma.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> > index 3f73123..643ba4c 100644
> > --- a/drivers/dma/sun6i-dma.c
> > +++ b/drivers/dma/sun6i-dma.c
> > @@ -65,8 +65,8 @@
> >  #define DMA_CHAN_CFG_SRC_DRQ(x)		((x) & 0x1f)
> >  #define DMA_CHAN_CFG_SRC_IO_MODE	BIT(5)
> >  #define DMA_CHAN_CFG_SRC_LINEAR_MODE	(0 << 5)
> > -#define DMA_CHAN_CFG_SRC_BURST(x)	(((x) & 0x3) << 7)
> > -#define DMA_CHAN_CFG_SRC_WIDTH(x)	(((x) & 0x3) << 9)
> > +#define DMA_CHAN_CFG_SRC_BURST(x)	((x) << 7)
> > +#define DMA_CHAN_CFG_SRC_WIDTH(x)	((x) << 9)
> 
> Well, you can easily end up with values higher than that. I still
> believe that making sure you only always write what is expected is a
> good thing.

How the values could be higher? They are locally generated in
convert_burst() and convert_buswidth() from checked client values.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
