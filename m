From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 10 Jun 2015 13:38:04 +0800
Subject: [PATCH 2/2] scatterlist: cleanup sg_chain() and sg_unmark_end()
In-Reply-To: <20150609162715.21910.77696.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150609162659.21910.41681.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150609162715.21910.77696.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <20150610053803.GA1693@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 09, 2015 at 12:27:15PM -0400, Dan Williams wrote:
>
> +#define scatterwalk_sg_chain(prv, num, sgl)	sg_chain(prv, num, sgl)
> +#define scatterwalk_sg_next(sgl)		sg_next(sgl)

Why are you reintroducing the scatterwalk_sg_next macro that we
just removed?

I also don't understand why this is so urgent that it has to go
into mainline at this late date.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
