From: romain.perier@free-electrons.com (Romain Perier)
Date: Fri, 17 Jun 2016 13:24:09 +0200
Subject: [PATCH v2 10/10] crypto: marvell: Increase the size of the crypto
 queue
In-Reply-To: <1466162649-29911-1-git-send-email-romain.perier@free-electrons.com>
References: <1466162649-29911-1-git-send-email-romain.perier@free-electrons.com>
Message-ID: <1466162649-29911-11-git-send-email-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that crypto requests are chained together at the DMA level, we
increase the size of the crypto queue for each engine. The result is
that as the backlog list is reached later, it does not stop the crypto
stack from sending asychronous requests, so more cryptographic tasks
are processed by the engines.

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
---
 drivers/crypto/marvell/cesa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/cesa.c b/drivers/crypto/marvell/cesa.c
index bb91156..5147073 100644
--- a/drivers/crypto/marvell/cesa.c
+++ b/drivers/crypto/marvell/cesa.c
@@ -32,7 +32,7 @@
 #include "cesa.h"
 
 /* Limit of the crypto queue before reaching the backlog */
-#define CESA_CRYPTO_DEFAULT_MAX_QLEN 50
+#define CESA_CRYPTO_DEFAULT_MAX_QLEN 128
 
 static int allhwsupport = !IS_ENABLED(CONFIG_CRYPTO_DEV_MV_CESA);
 module_param_named(allhwsupport, allhwsupport, int, 0444);
-- 
2.7.4
