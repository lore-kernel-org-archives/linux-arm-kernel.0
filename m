From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 15 Jan 2011 11:44:16 +1100
Subject: [PATCHv2] hwrng: add support for picoxcell TRNG
In-Reply-To: <1295030661-16364-1-git-send-email-jamie@jamieiles.com>
References: <20110114181609.GN2822@pulham.picochip.com>
	<1295030661-16364-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20110115004416.GA19686@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 06:44:21PM +0000, Jamie Iles wrote:
>
> +	/* Wait for some data to become available. */
> +	while (__raw_readl(csr) & CSR_OUT_EMPTY_MASK) {
> +		if (!wait)
> +			return 0;
> +		cpu_relax();
> +	}

This has the potential to loop indefinitely.  Please add a time-out
to prevent that (see existing RNG drivers for example).

Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
