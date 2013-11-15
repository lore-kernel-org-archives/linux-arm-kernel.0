From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Nov 2013 17:43:37 +0000
Subject: [PATCHv5] dmaengine: Add support for BCM2835
In-Reply-To: <1384535016.18739.23.camel@joe-AO722>
References: <52864BBC.7000506@koalo.de> <1384535016.18739.23.camel@joe-AO722>
Message-ID: <20131115174337.GP16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 09:03:36AM -0800, Joe Perches wrote:
> On Fri, 2013-11-15 at 17:28 +0100, Florian Meier wrote:
> > +static size_t bcm2835_dma_desc_size_pos(struct bcm2835_desc *d, dma_addr_t addr)
> > +{
> > +	unsigned i;
> > +	size_t size;
> 
> Please set size to 0 here and not in the for loop
> > +
> > +	for (size = i = 0; i < d->frames; i++) {

I disagree with that comment; I think the above is not only cleaner, but
also more obvious that _this_ loop is calculating _this_ size.
