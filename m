From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 22 Sep 2016 18:46:24 +0800
Subject: [PATCH] hwrng: omap - Only fail if pm_runtime_get_sync returns < 0
In-Reply-To: <20160920152540.3004-1-d-gerlach@ti.com>
References: <20160920152540.3004-1-d-gerlach@ti.com>
Message-ID: <20160922104624.GK5884@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2016 at 10:25:40AM -0500, Dave Gerlach wrote:
> Currently omap-rng checks the return value of pm_runtime_get_sync and
> reports failure if anything is returned, however it should be checking
> if ret < 0 as pm_runtime_get_sync return 0 on success but also can return
> 1 if the device was already active which is not a failure case. Only
> values < 0 are actual failures.
> 
> Fixes: 61dc0a446e5d ("hwrng: omap - Fix assumption that runtime_get_sync will always succeed")
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
