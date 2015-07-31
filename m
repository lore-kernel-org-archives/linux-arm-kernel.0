From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 31 Jul 2015 15:13:58 +0800
Subject: [PATCH v1 3/4] Crypto: Add support for APM X-Gene SoC CRC32C h/w
 accelerator driver
In-Reply-To: <1438258268-3099-4-git-send-email-rsahu@apm.com>
References: <1438258268-3099-1-git-send-email-rsahu@apm.com>
 <1438258268-3099-4-git-send-email-rsahu@apm.com>
Message-ID: <20150731071358.GA25228@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 05:41:07PM +0530, Rameshwar Prasad Sahu wrote:
>
> +		.cra_name		= "xgene(crc32c)",
> +		.cra_driver_name	= "crc32c-xgene",

This looks wrong.  If you're implementing crc32c then cra_name
should be just crc32c, i.e., the name of the algorithm that you
are providing.

> +MODULE_DESCRIPTION("APM X-Gene SoC CRC32C HW accelerator driver");
> +MODULE_AUTHOR("Rameshwar Prasad Sahu <rsahu@apm.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION("1.0");

You should add a MODULE_ALIAS_CRYPTO too.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
