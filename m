From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 16 Feb 2013 13:43:43 +0000
Subject: [PATCH 2/4] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <20130216105159.GN17833@n2100.arm.linux.org.uk>
References: <1360952512-971558-1-git-send-email-arnd@arndb.de>
 <201302161007.39657.arnd@arndb.de>
 <20130216105159.GN17833@n2100.arm.linux.org.uk>
Message-ID: <201302161343.43434.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 February 2013, Russell King - ARM Linux wrote:
> On Sat, Feb 16, 2013 at 10:07:39AM +0000, Arnd Bergmann wrote:
> > On Saturday 16 February 2013, Viresh Kumar wrote:
> > > On 15 February 2013 23:51, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > +static bool dw_dma_generic_filter(struct dma_chan *chan, void *param)
> > > >  {
> > > 
> > > > +       dws->cfg_hi     = 0xffffffff;
> > > > +       dws->cfg_lo     = 0xffffffff;
> > > 
> > > s/0xffffffff/-1 ?
> > 
> > It's an 'unsigned int'. While -1 would work here, I always find it a little
> > odd to rely on that feature of the C language.
> 
> However, relying on an 'int' being 32-bits is also rather odd, and
> probably much more dubious too.  If you want to set all bits in an
> int, the portable way to do that is ~0.

Right, I can do that, too. All I really need here though is to make sure
I use the same value in this place and when comparing it in dwc_initialize,
and it needs to be something that cannot be a valid register setting.

Thanks,

	Arnd
