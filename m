From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 16 Feb 2013 10:51:59 +0000
Subject: [PATCH 2/4] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <201302161007.39657.arnd@arndb.de>
References: <1360952512-971558-1-git-send-email-arnd@arndb.de>
 <1360952512-971558-3-git-send-email-arnd@arndb.de>
 <CAKohpo=u_b9u1=78+tm-rhVR14P0=2XbLrZEDJrQBY5W8LXiCw@mail.gmail.com>
 <201302161007.39657.arnd@arndb.de>
Message-ID: <20130216105159.GN17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 16, 2013 at 10:07:39AM +0000, Arnd Bergmann wrote:
> On Saturday 16 February 2013, Viresh Kumar wrote:
> > On 15 February 2013 23:51, Arnd Bergmann <arnd@arndb.de> wrote:
> > > +static bool dw_dma_generic_filter(struct dma_chan *chan, void *param)
> > >  {
> > 
> > > +       dws->cfg_hi     = 0xffffffff;
> > > +       dws->cfg_lo     = 0xffffffff;
> > 
> > s/0xffffffff/-1 ?
> 
> It's an 'unsigned int'. While -1 would work here, I always find it a little
> odd to rely on that feature of the C language.

However, relying on an 'int' being 32-bits is also rather odd, and
probably much more dubious too.  If you want to set all bits in an
int, the portable way to do that is ~0.
