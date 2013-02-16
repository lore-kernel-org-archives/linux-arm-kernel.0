From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 16 Feb 2013 10:07:39 +0000
Subject: [PATCH 2/4] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <CAKohpo=u_b9u1=78+tm-rhVR14P0=2XbLrZEDJrQBY5W8LXiCw@mail.gmail.com>
References: <1360952512-971558-1-git-send-email-arnd@arndb.de>
 <1360952512-971558-3-git-send-email-arnd@arndb.de>
 <CAKohpo=u_b9u1=78+tm-rhVR14P0=2XbLrZEDJrQBY5W8LXiCw@mail.gmail.com>
Message-ID: <201302161007.39657.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 February 2013, Viresh Kumar wrote:
> On 15 February 2013 23:51, Arnd Bergmann <arnd@arndb.de> wrote:
> > diff --git a/Documentation/devicetree/bindings/dma/snps-dma.txt b/Documentation/devicetree/bindings/dma/snps-dma.txt
> > +- #dma-cells: must be <3>
> 
> > +DMA clients connected to the Designware DMA controller must use the format
> > +described in the dma.txt file, using a five-cell specifier for each channel.
> 
> s/five/four ?

Right. I thought I had fixed up all instances.

> > +static bool dw_dma_generic_filter(struct dma_chan *chan, void *param)
> >  {
> 
> > +       dws->cfg_hi     = 0xffffffff;
> > +       dws->cfg_lo     = 0xffffffff;
> 
> s/0xffffffff/-1 ?

It's an 'unsigned int'. While -1 would work here, I always find it a little
odd to rely on that feature of the C language.

Thannks for the review.

	Arnd
