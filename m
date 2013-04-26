From: cb@sgoc.de (Christoph G. Baumann)
Date: Fri, 26 Apr 2013 13:20:15 +0200
Subject: [PATCH 2/2] crypto: added support for fsl-dcp on iMX23,28,50
In-Reply-To: <1366975215-5420-1-git-send-email-cb@sgoc.de>
References: <1366975215-5420-1-git-send-email-cb@sgoc.de>
Message-ID: <1366975215-5420-3-git-send-email-cb@sgoc.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Christoph G. Baumann" <cb@sgoc.de>

This patch contains modified files.

Signed-off-by: "Christoph G. Baumann" <cb@sgoc.de>
---
 arch/arm/boot/dts/imx28.dtsi |    2 +-
 drivers/staging/Kconfig      |    2 ++
 drivers/staging/Makefile     |    1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 7ba4966..2bec573 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -664,9 +664,9 @@
 			};
 
 			dcp at 80028000 {
+                                compatible = "fsl,fsl-dcp";
 				reg = <0x80028000 0x2000>;
 				interrupts = <52 53 54>;
-				status = "disabled";
 			};
 
 			pxp at 8002a000 {
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 093f10c..b3cf08b 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -140,4 +140,6 @@ source "drivers/staging/zcache/Kconfig"
 
 source "drivers/staging/goldfish/Kconfig"
 
+source "drivers/staging/crypto/Kconfig"
+
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index fa41b04..6875e3e 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -62,3 +62,4 @@ obj-$(CONFIG_SB105X)		+= sb105x/
 obj-$(CONFIG_FIREWIRE_SERIAL)	+= fwserial/
 obj-$(CONFIG_ZCACHE)		+= zcache/
 obj-$(CONFIG_GOLDFISH)		+= goldfish/
+obj-$(CONFIG_CRYPTO_HW)		+= crypto/
-- 
1.7.9.5
