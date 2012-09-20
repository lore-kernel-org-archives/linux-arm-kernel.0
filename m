From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 20 Sep 2012 22:18:18 +0200
Subject: [PATCH 4/10] IXP4xx: ixp4xx_crypto driver requires Queue Manager and
 NPE drivers.
In-Reply-To: <m3txus4hgm.fsf@intrepid.localdomain> (Krzysztof Halasa's message
 of "Thu, 20 Sep 2012 21:33:45 +0200")
References: <m3txus4hgm.fsf@intrepid.localdomain>
Message-ID: <m3k3vo30tx.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -224,7 +224,7 @@ config CRYPTO_DEV_TALITOS
 
 config CRYPTO_DEV_IXP4XX
 	tristate "Driver for IXP4xx crypto hardware acceleration"
-	depends on ARCH_IXP4XX
+	depends on ARCH_IXP4XX && IXP4XX_QMGR && IXP4XX_NPE
 	select CRYPTO_DES
 	select CRYPTO_ALGAPI
 	select CRYPTO_AUTHENC

-- 
Krzysztof Halasa
