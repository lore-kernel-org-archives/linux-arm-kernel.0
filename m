From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Sep 2013 17:00:24 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <1379518822.753.91.camel@shinybook.infradead.org>
References: <20130913102127.GD29403@sirena.org.uk>
 <52366F97.5030402@freescale.com>
 <20130916101912.GY29403@sirena.org.uk>
 <5236DD17.5090203@freescale.com>
 <20130916110634.GC29403@sirena.org.uk>
 <5237BB01.3080700@freescale.com>
 <20130917105142.GO21013@sirena.org.uk>
 <20130917150548.GE14747@book.gsilab.sittig.org>
 <20130917191318.GJ21013@sirena.org.uk>
 <1379518822.753.91.camel@shinybook.infradead.org>
Message-ID: <20130918160024.GB21013@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 18, 2013 at 10:40:22AM -0500, David Woodhouse wrote:
> On Tue, 2013-09-17 at 20:13 +0100, Mark Brown wrote:

> > > [ potential "LUT" optimization, implementation details ]

> > AFAICT the big issue with the LUTs in this controller is that they are
> > expensive to reprogram so things are going to work better if there is a
> > small set of known operations that will happen repeatedly.  Otherwise
> > walking the transfer list at runtime isn't too hard.

> I think you can drop the word "known" there. With decent management of
> the LUT as a kind of LRU cache of recent operations, surely you'll
> quickly get into a situation where the operations you're actually
> *doing* on the flash are all already in the LUT and you're never
> actually *having* to reprogram it?

Yeah, assuming it's not too annoying to identify the repeated patterns
and doesn't blow up horribly just caching should work fine.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130918/41f92132/attachment.sig>
