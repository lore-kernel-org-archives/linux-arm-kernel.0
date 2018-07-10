From: ray.jui@broadcom.com (Ray Jui)
Date: Tue, 10 Jul 2018 14:25:31 -0700
Subject: [PATCH 2/2] arm64: dts: stingray: add bcm958802a802x dts
In-Reply-To: <1531257931-11591-1-git-send-email-ray.jui@broadcom.com>
References: <1531257931-11591-1-git-send-email-ray.jui@broadcom.com>
Message-ID: <1531257931-11591-3-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>

Add bcm958802a802x dts to be used on all Stingray smart NIC PS225 board
variants

Signed-off-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/stingray/Makefile     |  2 ++
 .../boot/dts/broadcom/stingray/bcm958802a802x.dts  | 26 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958802a802x.dts

diff --git a/arch/arm64/boot/dts/broadcom/stingray/Makefile b/arch/arm64/boot/dts/broadcom/stingray/Makefile
index c4d06cf..20c7d0a 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/Makefile
+++ b/arch/arm64/boot/dts/broadcom/stingray/Makefile
@@ -1,3 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_BCM_IPROC) += bcm958742k.dtb
 dtb-$(CONFIG_ARCH_BCM_IPROC) += bcm958742t.dtb
+
+dtb-$(CONFIG_ARCH_BCM_IPROC) += bcm958802a802x.dtb
diff --git a/arch/arm64/boot/dts/broadcom/stingray/bcm958802a802x.dts b/arch/arm64/boot/dts/broadcom/stingray/bcm958802a802x.dts
new file mode 100644
index 0000000..a41facd
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/stingray/bcm958802a802x.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0 or BSD-3-Clause)
+/*
+ *Copyright(c) 2018 Broadcom
+ */
+
+/dts-v1/;
+
+#include "stingray-board-base.dtsi"
+
+/ {
+	compatible = "brcm,bcm958802a802x", "brcm,stingray";
+	model = "Stingray PS225xx (BCM958802A802x)";
+};
+
+&enet {
+	status = "disabled";
+};
+
+&sdio0 {
+	no-1-8-v;
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.1.4
