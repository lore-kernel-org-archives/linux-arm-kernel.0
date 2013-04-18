From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 18 Apr 2013 11:27:01 +0100
Subject: [PATCH 5/9] crypto: ux500/cryp - Fix compile error
In-Reply-To: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
References: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1366280825-31136-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clearly this driver hasn't been tested, or even enabled in a while.

drivers/crypto/ux500/cryp/cryp_core.c:1771:3:
	error: request for member ?pm? in something not a structure or union

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Cc: Andreas Westin <andreas.westin@stericsson.com>
Cc: linux-crypto at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/ux500/cryp/cryp_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ux500/cryp/cryp_core.c b/drivers/crypto/ux500/cryp/cryp_core.c
index a56cbc4..444deaf 100644
--- a/drivers/crypto/ux500/cryp/cryp_core.c
+++ b/drivers/crypto/ux500/cryp/cryp_core.c
@@ -1750,7 +1750,7 @@ static struct platform_driver cryp_driver = {
 	.shutdown = ux500_cryp_shutdown,
 	.driver = {
 		.owner = THIS_MODULE,
-		.name  = "cryp1"
+		.name  = "cryp1",
 		.pm    = &ux500_cryp_pm,
 	}
 };
-- 
1.7.10.4
