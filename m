From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 8 Nov 2013 16:08:16 +0100
Subject: [PATCH RESEND 7/7] crypto: atmel-sha - add sha information to the log
In-Reply-To: <cover.1383922546.git.nicolas.ferre@atmel.com>
References: <cover.1383922546.git.nicolas.ferre@atmel.com>
Message-ID: <e8be86b81611f75ff961d93bd448996fcb5b51ef.1383922546.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depending on peripheral capabilities, print SHA information at the end
of the probe function.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/crypto/atmel-sha.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index ecfdf72..0618be0 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -1469,7 +1469,9 @@ static int atmel_sha_probe(struct platform_device *pdev)
 	if (err)
 		goto err_algs;
 
-	dev_info(dev, "Atmel SHA1/SHA256\n");
+	dev_info(dev, "Atmel SHA1/SHA256%s%s\n",
+			sha_dd->caps.has_sha224 ? "/SHA224" : "",
+			sha_dd->caps.has_sha_384_512 ? "/SHA384/SHA512" : "");
 
 	return 0;
 
-- 
1.8.2.2
