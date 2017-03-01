From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 1 Mar 2017 19:52:10 +0800
Subject: [PATCH 2/2] crypto: arm - add build time test for CRC
 instruction support
In-Reply-To: <1488292617-27317-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1488292617-27317-1-git-send-email-ard.biesheuvel@linaro.org>
 <1488292617-27317-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170301115210.GB11489@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 02:36:57PM +0000, Ard Biesheuvel wrote:
> The accelerated CRC32 module for ARM may use either the scalar CRC32
> instructions, the NEON 64x64 to 128 bit polynomial multiplication
> (vmull.p64) instruction, or both, depending on what the current CPU
> supports.
> 
> However, this also requires support in binutils, and as it turns out,
> versions of binutils exist that support the vmull.p64 instruction but
> not the crc32 instructions.
> 
> So refactor the Makefile logic so that this module only gets built if
> binutils has support for both.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
