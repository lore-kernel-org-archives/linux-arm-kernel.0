From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 17 Jun 2015 09:15:38 +0200
Subject: [PATCH v5 04/14] crypto: add a new driver for Marvell's CESA
In-Reply-To: <20150617055824.GA9155@gondor.apana.org.au>
References: <1434448748-10828-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434448748-10828-5-git-send-email-boris.brezillon@free-electrons.com>
 <20150617055824.GA9155@gondor.apana.org.au>
Message-ID: <20150617091538.340f93d2@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Jun 2015 13:58:24 +0800
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Tue, Jun 16, 2015 at 11:58:58AM +0200, Boris Brezillon wrote:
> >
> > +config CRYPTO_DEV_MARVELL_CESA
> > +	tristate "New Marvell's Cryptographic Engine driver"
> > +	depends on (PLAT_ORION || ARCH_MVEBU || COMPILE_TEST) && HAS_DMA && HAS_IOMEM
> > +	select CRYPTO_ALGAPI
> > +	select CRYPTO_AES
> > +	select CRYPTO_DES
> > +	select CRYPTO_BLKCIPHER2
> > +	select CRYPTO_HASH
> 
> While you're fixing the DMA issue, could you also replace BLKCIPHER2
> with BLKCIPHER and kill the select on ALGAPI? BLKCIPHER2 is internal
> to the crypto API and should not be used elsewhere while ALGAPI is
> only meant to be selected by crypto types such as BLKCIPHER.
> 
> I know the existing driver does this too and I will fix that now.

Fixed.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
