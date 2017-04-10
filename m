From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 10 Apr 2017 18:55:47 +0800
Subject: [PATCH v4 2/2] crypto: hw_random - Add new Exynos RNG driver
In-Reply-To: <20170408133245.30147-3-krzk@kernel.org>
References: <20170408133245.30147-1-krzk@kernel.org>
 <20170408133245.30147-3-krzk@kernel.org>
Message-ID: <20170410105547.GA8615@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 08, 2017 at 03:32:45PM +0200, Krzysztof Kozlowski wrote:
>
> +static struct rng_alg exynos_rng_alg = {
> +	.generate		= exynos_rng_generate,
> +	.seed			= exynos_rng_seed,
> +	.seedsize		= EXYNOS_RNG_SEED_SIZE,
> +	.base			= {
> +		.cra_name		= "exynos_rng",

Please use stdrng.  Or is there a reason why this can't be used
by the crypto layer itself?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
