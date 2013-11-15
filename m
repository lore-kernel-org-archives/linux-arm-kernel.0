From: joe@perches.com (Joe Perches)
Date: Fri, 15 Nov 2013 10:20:24 -0800
Subject: [PATCHv5] dmaengine: Add support for BCM2835
In-Reply-To: <20131115174337.GP16735@n2100.arm.linux.org.uk>
References: <52864BBC.7000506@koalo.de> <1384535016.18739.23.camel@joe-AO722>
 <20131115174337.GP16735@n2100.arm.linux.org.uk>
Message-ID: <1384539624.18739.27.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-11-15 at 17:43 +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 15, 2013 at 09:03:36AM -0800, Joe Perches wrote:
> > On Fri, 2013-11-15 at 17:28 +0100, Florian Meier wrote:
> > > +static size_t bcm2835_dma_desc_size_pos(struct bcm2835_desc *d, dma_addr_t addr)
> > > +{
> > > +	unsigned i;
> > > +	size_t size;
> > 
> > Please set size to 0 here and not in the for loop
> > > +
> > > +	for (size = i = 0; i < d->frames; i++) {
> 
> I disagree with that comment; I think the above is not only cleaner, but
> also more obvious that _this_ loop is calculating _this_ size.

I think that using
	size_t size = 0;
is not only _much_ more commonly used
throughout the kernel but makes it
clearer that the initialization of the
return value is done before the loop.

Reasonable minds can differ and there
is no style guide that prefers one over
the other.

No matter really to me.
As I said, it's trivial.

cheers, Joe
