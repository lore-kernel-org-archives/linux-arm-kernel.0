From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 15 Jul 2011 18:50:03 -0600
Subject: [PATCH V2 05/12] ARM: SAMSUNG: Add common DMA operations
In-Reply-To: <001301cc4350$d4c09fa0$7e41dee0$%kim@samsung.com>
References: <1310546857-6304-1-git-send-email-kgene.kim@samsung.com>
	<1310546857-6304-6-git-send-email-kgene.kim@samsung.com>
	<20110715025347.GU2927@ponder.secretlab.ca>
	<001301cc4350$d4c09fa0$7e41dee0$%kim@samsung.com>
Message-ID: <20110716005003.GQ2833@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 16, 2011 at 09:39:31AM +0900, Boojin Kim wrote:
> Grant Likely wrote:
> > > +void *samsung_dma_get_ops(void)
> > > +{
> > > +	return (void *)&dmaeng_ops;
> > > +}
> > > +EXPORT_SYMBOL(samsung_dma_get_ops);
> > 
> > If all that is needed is a reference to the dma ops, then you could
> > simply export samsung_dmaeng_ops() without a separate function.
> 
> Grant, Thanks for your comments. I can't understand this comment well.
> Do you mean to change function name from 'samsung_dma_get_ops()' to
> 'samsung_dmaeng_ops()' ?
> Or export 'dmaeng_ops' variable instead of making this
> 'samsung_dma_get_ops()' function

I mean export dmaeng_ops instead of using a function.  You also get
some type checking by not casting it into a (void*).
