From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 23 Mar 2015 21:33:09 +0100
Subject: [PATCH] crypto/arm: fix big-endian bug in ghash
Message-ID: <1427142789-13960-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a bug in the new v8 Crypto Extensions GHASH code
that only manifests itself in big-endian mode.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/crypto/ghash-ce-core.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/crypto/ghash-ce-core.S b/arch/arm/crypto/ghash-ce-core.S
index e643a15eadf2..f6ab8bcc9efe 100644
--- a/arch/arm/crypto/ghash-ce-core.S
+++ b/arch/arm/crypto/ghash-ce-core.S
@@ -40,7 +40,7 @@
 	 *			   struct ghash_key const *k, const char *head)
 	 */
 ENTRY(pmull_ghash_update)
-	vld1.8		{SHASH}, [r3]
+	vld1.64		{SHASH}, [r3]
 	vld1.64		{XL}, [r1]
 	vmov.i8		MASK, #0xe1
 	vext.8		SHASH2, SHASH, SHASH, #8
-- 
1.8.3.2
