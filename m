From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 24 Mar 2018 00:03:27 +0800
Subject: [PATCH] crypto: arm,arm64 - Fix random regeneration of S_shipped
In-Reply-To: <db77e20709db11b951a28c3303feb63990ef82d7.1520972030.git.leonard.crestez@nxp.com>
Message-ID: <20180323160327.GA2414@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Leonard Crestez <leonard.crestez@nxp.com> wrote:
> The decision to rebuild .S_shipped is made based on the relative
> timestamps of .S_shipped and .pl files but git makes this essentially
> random. This means that the perl script might run anyway (usually at
> most once per checkout), defeating the whole purpose of _shipped.
> 
> Fix by skipping the rule unless explicit make variables are provided:
> REGENERATE_ARM_CRYPTO or REGENERATE_ARM64_CRYPTO.
> 
> This can produce nasty occasional build failures downstream, for example
> for toolchains with broken perl. The solution is minimally intrusive to
> make it easier to push into stable.
> 
> Another report on a similar issue here: https://lkml.org/lkml/2018/3/8/1379
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: <stable@vger.kernel.org>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
