From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 17 Jan 2011 10:23:30 +0000
Subject: [PATCHv2] hwrng: add support for picoxcell TRNG
In-Reply-To: <20110115004416.GA19686@gondor.apana.org.au>
References: <20110114181609.GN2822@pulham.picochip.com>
	<1295030661-16364-1-git-send-email-jamie@jamieiles.com>
	<20110115004416.GA19686@gondor.apana.org.au>
Message-ID: <20110117102330.GB2622@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 15, 2011 at 11:44:16AM +1100, Herbert Xu wrote:
> On Fri, Jan 14, 2011 at 06:44:21PM +0000, Jamie Iles wrote:
> >
> > +	/* Wait for some data to become available. */
> > +	while (__raw_readl(csr) & CSR_OUT_EMPTY_MASK) {
> > +		if (!wait)
> > +			return 0;
> > +		cpu_relax();
> > +	}
> 
> This has the potential to loop indefinitely.  Please add a time-out
> to prevent that (see existing RNG drivers for example).

Ok, that's a fair point!  Here's an updated version with a timeout.  
I've also added in support for the fault detection which I previously 
overlooked.

Jamie

8<--------
