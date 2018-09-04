From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 4 Sep 2018 13:20:29 +0800
Subject: [PATCH v2] crypto: arm64/aes-modes - get rid of literal load of
 addend vector
In-Reply-To: <20180823164845.20055-1-ard.biesheuvel@linaro.org>
References: <20180823164845.20055-1-ard.biesheuvel@linaro.org>
Message-ID: <20180904052029.fktlxcxtrowuvkh4@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2018 at 05:48:45PM +0100, Ard Biesheuvel wrote:
> Replace the literal load of the addend vector with a sequence that
> performs each add individually. This sequence is only 2 instructions
> longer than the original, and 2% faster on Cortex-A53.
> 
> This is an improvement by itself, but also works around a Clang issue,
> whose integrated assembler does not implement the GNU ARM asm syntax
> completely, and does not support the =literal notation for FP registers
> (more info at https://bugs.llvm.org/show_bug.cgi?id=38642)
> 
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v2: replace convoluted code involving a SIMD add to increment four BE counters
>     at once with individual add/rev/mov instructions
> 
>  arch/arm64/crypto/aes-modes.S | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
