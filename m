From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 15 May 2015 14:49:33 +0800
Subject: [PATCH v9 4/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <1431608341-10936-5-git-send-email-clabbe.montjoie@gmail.com>
References: <1431608341-10936-1-git-send-email-clabbe.montjoie@gmail.com>
 <1431608341-10936-5-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20150515064932.GB16704@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 02:59:01PM +0200, LABBE Corentin wrote:
>
> +	err = crypto_ablkcipher_setkey(op->fallback, kkey, op->keylen);
> +	if (err != 0) {
> +		dev_err(ss->dev, "Cannot set key on fallback\n");
> +		return -EINVAL;
> +	}

You cannot call setkey from an atomic context.  The easiest solution
is to call setkey in your setkey function instead.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
