From: marex@denx.de (Marek Vasut)
Date: Wed, 23 Jul 2014 16:07:20 +0200
Subject: [PATCH 3/3] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <20140723135735.GA30132@gondor.apana.org.au>
References: <1400771396-9686-1-git-send-email-clabbe.montjoie@gmail.com>
 <201405241400.03456.marex@denx.de>
 <20140723135735.GA30132@gondor.apana.org.au>
Message-ID: <201407231607.21106.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 23, 2014 at 03:57:35 PM, Herbert Xu wrote:
> On Sat, May 24, 2014 at 02:00:03PM +0200, Marek Vasut wrote:
> > > +	}
> > > +#endif
> > > +
> > > +#ifdef CONFIG_CRYPTO_DEV_SUNXI_SS_MD5
> > > +	err = crypto_register_shash(&sunxi_md5_alg);
> > 
> > Do not use shash for such device. This is clearly and ahash (and async in
> > general) device. The rule of a thumb here is that you use sync algos only
> > for devices which have dedicated instructions for computing the
> > transformation. For devices which are attached to some kind of bus, you
> > use async algos (ahash etc).
> 
> I'm sorry that I didn't catch this earlier but there is no such
> rule.
> 
> Unless you need the async interface you should stick to the sync
> interfaces for the sake of simplicity.
> 
> We have a number of existing drivers that are synchronous but
> using the async interface.  They should either be converted
> over to the sync interface or made interrupt-driven if possible.

Sure, but this device is interrupt driven and uses DMA to feed the crypto 
engine, therefore async, right ?

Best regards,
Marek Vasut
