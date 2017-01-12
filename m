From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 13 Jan 2017 00:39:53 +0800
Subject: [PATCH] crypto: mediatek: don't return garbage err on successful
 return
In-Reply-To: <20170103132122.26900-1-colin.king@canonical.com>
References: <20170103132122.26900-1-colin.king@canonical.com>
Message-ID: <20170112163953.GD20085@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 01:21:22PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where keylen <= bs mtk_sha_setkey returns an uninitialized
> return value in err.  Fix this by returning 0 instead of err.
> 
> Issue detected by static analysis with cppcheck.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
