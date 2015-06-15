From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 15 Jun 2015 13:39:31 +0200
Subject: [RESEND PATCH v4 04/14] crypto: add a new driver for Marvell's
 CESA
In-Reply-To: <20150615093754.GA31948@gondor.apana.org.au>
References: <1434093366-14681-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434093366-14681-5-git-send-email-boris.brezillon@free-electrons.com>
 <20150615093754.GA31948@gondor.apana.org.au>
Message-ID: <20150615133931.73f6f105@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Jun 2015 17:37:54 +0800
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Fri, Jun 12, 2015 at 09:15:56AM +0200, Boris Brezillon wrote:
> >
> > +static inline int mv_cesa_sg_count(struct scatterlist *sg, int nbytes)
> > +{
> > +	int nents = 0;
> > +
> > +	while (nbytes > 0) {
> > +		nents++;
> > +		nbytes -= sg->length;
> > +		sg = sg_next(sg);
> > +	}
> > +
> > +	return nents;
> > +}
> 
> Please replace this with the newly added sg_nents_for_len.

Sure, I'll use the sg_nents_for_len function.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
