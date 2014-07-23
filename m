From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 23 Jul 2014 21:57:35 +0800
Subject: [PATCH 3/3] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <201405241400.03456.marex@denx.de>
References: <1400771396-9686-1-git-send-email-clabbe.montjoie@gmail.com>
 <1400771396-9686-4-git-send-email-clabbe.montjoie@gmail.com>
 <201405241400.03456.marex@denx.de>
Message-ID: <20140723135735.GA30132@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 24, 2014 at 02:00:03PM +0200, Marek Vasut wrote:
>
> > +	}
> > +#endif
> > +
> > +#ifdef CONFIG_CRYPTO_DEV_SUNXI_SS_MD5
> > +	err = crypto_register_shash(&sunxi_md5_alg);
> 
> Do not use shash for such device. This is clearly and ahash (and async in 
> general) device. The rule of a thumb here is that you use sync algos only for 
> devices which have dedicated instructions for computing the transformation. For 
> devices which are attached to some kind of bus, you use async algos (ahash etc).

I'm sorry that I didn't catch this earlier but there is no such
rule.

Unless you need the async interface you should stick to the sync
interfaces for the sake of simplicity.

We have a number of existing drivers that are synchronous but
using the async interface.  They should either be converted
over to the sync interface or made interrupt-driven if possible.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
