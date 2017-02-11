From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 11 Feb 2017 18:53:39 +0800
Subject: [PATCH v3 0/3] crypto: time invariant AES for CCM (and CMAC/XCBC)
In-Reply-To: <1486133377-23290-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1486133377-23290-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170211105339.GE855@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2017 at 02:49:34PM +0000, Ard Biesheuvel wrote:
> This series is primarily directed at improving the performance and security
> of CCM on the Rasperry Pi 3. This involves splitting the MAC handling of
> CCM into a separate driver so that we can efficiently replace it by something
> else using the ordinary algo resolution machinery.
> 
> Patch #1 adds some testcases for cbcmac(aes), which will be introduced later.
> 
> Patch #2 replaces the open coded CBC MAC hashing routines in the CCM driver
> with calls to a cbcmac() hash, and implements a template for producing such
> cbcmac transforms. This eliminates all the fuzzy scatterwalk code as well.
> 
> Patch #3 implements cbcmac(aes) using NEON on arm64, and CMAC/XCBC at the
> same time, since it is trivially implemented reusing the same core transform

All applied.  Please send any fixups on top of these patches.
Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
