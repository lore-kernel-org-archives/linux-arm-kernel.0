From: marex@denx.de (Marek Vasut)
Date: Tue, 10 Dec 2013 20:26:23 +0100
Subject: [PATCH V2 5/5] crypto: Sort drivers/crypto/Makefile
In-Reply-To: <1386703583-8386-1-git-send-email-marex@denx.de>
References: <1386703583-8386-1-git-send-email-marex@denx.de>
Message-ID: <1386703583-8386-5-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The order in the Makefile was a mess, sort it.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-crypto at vger.kernel.org
---
 drivers/crypto/Makefile | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

V2: Align with latest next/master.

diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 94a8aa5..0bc6aa0 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -1,25 +1,25 @@
-obj-$(CONFIG_CRYPTO_DEV_PADLOCK_AES) += padlock-aes.o
-obj-$(CONFIG_CRYPTO_DEV_PADLOCK_SHA) += padlock-sha.o
+obj-$(CONFIG_CRYPTO_DEV_ATMEL_AES) += atmel-aes.o
+obj-$(CONFIG_CRYPTO_DEV_ATMEL_SHA) += atmel-sha.o
+obj-$(CONFIG_CRYPTO_DEV_ATMEL_TDES) += atmel-tdes.o
+obj-$(CONFIG_CRYPTO_DEV_BFIN_CRC) += bfin_crc.o
+obj-$(CONFIG_CRYPTO_DEV_CCP) += ccp/
+obj-$(CONFIG_CRYPTO_DEV_FSL_CAAM) += caam/
 obj-$(CONFIG_CRYPTO_DEV_GEODE) += geode-aes.o
-obj-$(CONFIG_CRYPTO_DEV_NIAGARA2) += n2_crypto.o
-n2_crypto-y := n2_core.o n2_asm.o
 obj-$(CONFIG_CRYPTO_DEV_HIFN_795X) += hifn_795x.o
-obj-$(CONFIG_CRYPTO_DEV_MV_CESA) += mv_cesa.o
-obj-$(CONFIG_CRYPTO_DEV_TALITOS) += talitos.o
-obj-$(CONFIG_CRYPTO_DEV_FSL_CAAM) += caam/
 obj-$(CONFIG_CRYPTO_DEV_IXP4XX) += ixp4xx_crypto.o
-obj-$(CONFIG_CRYPTO_DEV_PPC4XX) += amcc/
-obj-$(CONFIG_CRYPTO_DEV_OMAP_SHAM) += omap-sham.o
+obj-$(CONFIG_CRYPTO_DEV_MV_CESA) += mv_cesa.o
+obj-$(CONFIG_CRYPTO_DEV_MXS_DCP) += mxs-dcp.o
+obj-$(CONFIG_CRYPTO_DEV_NIAGARA2) += n2_crypto.o
+n2_crypto-y := n2_core.o n2_asm.o
+obj-$(CONFIG_CRYPTO_DEV_NX) += nx/
 obj-$(CONFIG_CRYPTO_DEV_OMAP_AES) += omap-aes.o
+obj-$(CONFIG_CRYPTO_DEV_OMAP_SHAM) += omap-sham.o
+obj-$(CONFIG_CRYPTO_DEV_PADLOCK_AES) += padlock-aes.o
+obj-$(CONFIG_CRYPTO_DEV_PADLOCK_SHA) += padlock-sha.o
 obj-$(CONFIG_CRYPTO_DEV_PICOXCELL) += picoxcell_crypto.o
-obj-$(CONFIG_CRYPTO_DEV_SAHARA) += sahara.o
+obj-$(CONFIG_CRYPTO_DEV_PPC4XX) += amcc/
 obj-$(CONFIG_CRYPTO_DEV_S5P) += s5p-sss.o
+obj-$(CONFIG_CRYPTO_DEV_SAHARA) += sahara.o
+obj-$(CONFIG_CRYPTO_DEV_TALITOS) += talitos.o
 obj-$(CONFIG_CRYPTO_DEV_TEGRA_AES) += tegra-aes.o
 obj-$(CONFIG_CRYPTO_DEV_UX500) += ux500/
-obj-$(CONFIG_CRYPTO_DEV_BFIN_CRC) += bfin_crc.o
-obj-$(CONFIG_CRYPTO_DEV_NX) += nx/
-obj-$(CONFIG_CRYPTO_DEV_ATMEL_AES) += atmel-aes.o
-obj-$(CONFIG_CRYPTO_DEV_ATMEL_TDES) += atmel-tdes.o
-obj-$(CONFIG_CRYPTO_DEV_ATMEL_SHA) += atmel-sha.o
-obj-$(CONFIG_CRYPTO_DEV_CCP) += ccp/
-obj-$(CONFIG_CRYPTO_DEV_MXS_DCP) += mxs-dcp.o
-- 
1.8.4.3
