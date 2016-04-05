From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 5 Apr 2016 20:44:29 +0800
Subject: [PATCH v2 1/4] hwrng: exynos - Runtime suspend device after init
In-Reply-To: <1457914035-26856-1-git-send-email-k.kozlowski@samsung.com>
References: <1457914035-26856-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160405124429.GC13048@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2016 at 09:07:12AM +0900, Krzysztof Kozlowski wrote:
> The driver uses pm_runtime_put_noidle() after initialization so the
> device might remain in active state if the core does not read from it
> (the read callback contains regular runtime put). The put_noidle() was
> chosen probably to avoid unneeded suspend and resume cycle after the
> initialization.
> 
> However for this purpose autosuspend is enabled so it is safe to runtime
> put just after the initialization.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

All applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
