From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 2 Mar 2015 23:19:18 +1300
Subject: [PATCH] ARM: crypto: update NEON AES module to latest OpenSSL
 version
In-Reply-To: <1424935325-14437-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1424935325-14437-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150302101918.GA23965@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 07:22:05AM +0000, Ard Biesheuvel wrote:
> This updates the bit sliced AES module to the latest version in the
> upstream OpenSSL repository (e620e5ae37bc). This is needed to fix a
> bug in the XTS decryption path, where data chunked in a certain way
> could trigger the ciphertext stealing code, which is not supposed to
> be active in the kernel build (The kernel implementation of XTS only
> supports round multiples of the AES block size of 16 bytes, whereas
> the conformant OpenSSL implementation of XTS supports inputs of
> arbitrary size by applying ciphertext stealing). This is fixed in
> the upstream version by adding the missing #ifndef XTS_CHAIN_TWEAK
> around the offending instructions.
> 
> The upstream code also contains the change applied by Russell to
> build the code unconditionally, i.e., even if __LINUX_ARM_ARCH__ < 7,
> but implemented slightly differently.
> 
> Fixes: e4e7f10bfc40 ("ARM: add support for bit sliced AES using NEON instructions")
> Reported-by: Adrian Kotelba <adrian.kotelba@gmail.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Patch applied with cc to stable.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
