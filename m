From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 25 Feb 2014 15:16:26 +0800
Subject: [RFC PATCH] arm64: add support for AES in CCM mode using Crypto
 Extensions
In-Reply-To: <CAKv+Gu-HnTk5RCLRoCnae7-HH7C-Tq2YJF57Nc-hOEykdY52XA@mail.gmail.com>
References: <1392106905-28709-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140225070252.GB9934@gondor.apana.org.au>
 <CAKv+Gu-HnTk5RCLRoCnae7-HH7C-Tq2YJF57Nc-hOEykdY52XA@mail.gmail.com>
Message-ID: <20140225071626.GA10524@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 08:12:36AM +0100, Ard Biesheuvel wrote:
>
> Do you have any comments specifically about using an inner blkcipher
> instance to implement the aead?

Indeed, the inner block cipher looks superfluous since it's only
used once by ccm and there is no nesting similar to aesni-intel.

Inner algorithms are only needed if you want to nest it, e.g.,
through fpu().  Otherwise I don't see any difference vs. calling
the underlying functions directly, especially since you seem to
be calling them directly anyway.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
