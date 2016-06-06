From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Mon,  6 Jun 2016 09:43:50 +0200
Subject: [PATCH 2/2] ARM: BCM5301X: Fix NAND ECC parameters for D-Link DIR-885L
In-Reply-To: <1465199036-24366-1-git-send-email-zajec5@gmail.com>
References: <1465199036-24366-1-git-send-email-zajec5@gmail.com>
Message-ID: <1465199036-24366-2-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This device uses BCH-1 instead of BCH-8. This fixes ECC errors and makes
NAND usable with brcmnand.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
As suggested recently, the new file uses BSD-compatible license. I was
considering BSD [23]-clause license and Hauke said he likes ISC which is
even simpler, so I picked this one.
---
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts |  2 +-
 arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi

diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
index 50cf804..c8c0b36 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
@@ -10,7 +10,7 @@
 /dts-v1/;
 
 #include "bcm4708.dtsi"
-#include "bcm5301x-nand-cs0-bch8.dtsi"
+#include "bcm5301x-nand-cs0-bch1.dtsi"
 
 / {
 	compatible = "dlink,dir-885l", "brcm,bcm47094", "brcm,bcm4708";
diff --git a/arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi b/arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi
new file mode 100644
index 0000000..24b099c
--- /dev/null
+++ b/arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi
@@ -0,0 +1,15 @@
+/*
+ * Broadcom Northstar NAND.
+ *
+ * Copyright (C) 2016 Rafa? Mi?ecki <rafal.milecki@gmail.com>
+ *
+ * Licensed under the ISC license.
+ */
+
+#include "bcm5301x-nand-cs0.dtsi"
+
+&nandcs {
+	nand-ecc-algo = "bch";
+	nand-ecc-strength = <1>;
+	nand-ecc-step-size = <512>;
+};
-- 
1.8.4.5
