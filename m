From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 20 Oct 2015 22:19:54 +0800
Subject: [PATCH] hwrng: exynos - Fix unbalanced PM runtime get/puts
In-Reply-To: <1445011311-32142-1-git-send-email-daniel.thompson@linaro.org>
References: <1445011311-32142-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20151020141954.GB7625@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 05:01:51PM +0100, Daniel Thompson wrote:
> Currently this driver calls pm_runtime_get_sync() rampantly
> but never puts anything back. This makes it impossible for the
> device to autosuspend properly; it will remain fully active
> after the first use.
> 
> Fix in the obvious way.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
