From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 20 Sep 2012 22:21:13 +0200
Subject: [PATCH 8/10] IXP4xx crypto: MOD_AES{128, 192,
 256} already include key size.
In-Reply-To: <m3txus4hgm.fsf@intrepid.localdomain> (Krzysztof Halasa's message
 of "Thu, 20 Sep 2012 21:33:45 +0200")
References: <m3txus4hgm.fsf@intrepid.localdomain>
Message-ID: <m3ehlw30p2.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- a/drivers/crypto/ixp4xx_crypto.c
+++ b/drivers/crypto/ixp4xx_crypto.c
@@ -750,12 +750,12 @@ static int setup_cipher(struct crypto_tfm *tfm, int encrypt,
 	}
 	if (cipher_cfg & MOD_AES) {
 		switch (key_len) {
-			case 16: keylen_cfg = MOD_AES128 | KEYLEN_128; break;
-			case 24: keylen_cfg = MOD_AES192 | KEYLEN_192; break;
-			case 32: keylen_cfg = MOD_AES256 | KEYLEN_256; break;
-			default:
-				*flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
-				return -EINVAL;
+		case 16: keylen_cfg = MOD_AES128; break;
+		case 24: keylen_cfg = MOD_AES192; break;
+		case 32: keylen_cfg = MOD_AES256; break;
+		default:
+			*flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
+			return -EINVAL;
 		}
 		cipher_cfg |= keylen_cfg;
 	} else if (cipher_cfg & MOD_3DES) {

-- 
Krzysztof Halasa
