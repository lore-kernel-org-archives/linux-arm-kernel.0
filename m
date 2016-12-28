From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 28 Dec 2016 17:23:28 +0800
Subject: [PATCH] crypto: arm/aes-neonbs - process 8 blocks in parallel if
 we can
In-Reply-To: <B32240B5-953F-42A2-A010-6FF64AC45859@linaro.org>
References: <1481291246-20216-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161227085745.GA10121@gondor.apana.org.au>
 <CAKv+Gu8OkOR3Xzx=XEOWyFpo6sLiq=WQrq0SauaY0V57uYetCQ@mail.gmail.com>
 <20161228091020.GE11904@gondor.apana.org.au>
 <B32240B5-953F-42A2-A010-6FF64AC45859@linaro.org>
Message-ID: <20161228092328.GA12494@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 28, 2016 at 09:19:32AM +0000, Ard Biesheuvel wrote:
>
> Ok, so that implies a field in the skcipher algo struct then, rather than some definition internal to the driver?

Oh yes it should definitely be visible to other crypto API drivers
and algorithms.  It's just that we don't want to export it outside
of the crypto API, e.g., to IPsec or algif.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
