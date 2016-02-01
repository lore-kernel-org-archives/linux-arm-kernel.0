From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 1 Feb 2016 16:22:13 +0800
Subject: [PATCH] crypto: atmel-aes - remove calls of clk_prepare() from
 atomic contexts
In-Reply-To: <f8f0ac52fcfbbef5cbddb2a189128b253df7d678.1454086302.git.cyrille.pitchen@atmel.com>
References: <f8f0ac52fcfbbef5cbddb2a189128b253df7d678.1454086302.git.cyrille.pitchen@atmel.com>
Message-ID: <20160201082213.GF5818@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 05:53:33PM +0100, Cyrille Pitchen wrote:
> clk_prepare()/clk_unprepare() must not be called within atomic context.
> 
> This patch calls clk_prepare() once for all from atmel_aes_probe() and
> clk_unprepare() from atmel_aes_remove().
> 
> Then calls of clk_prepare_enable()/clk_disable_unprepare() were replaced
> by calls of clk_enable()/clk_disable().
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> Reported-by: Matthias Mayr <matthias.mayr@student.kit.edu>

Applied to crypto.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
