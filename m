From: mporter@konsulko.com (Matt Porter)
Date: Wed, 25 Feb 2015 13:52:41 -0500
Subject: [PATCH v2] ARM: dts: am335x-bone-common: enable aes and sham
Message-ID: <1424890361-31848-1-git-send-email-mporter@konsulko.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Beaglebone Black doesn't have AES and SHAM enabled like the
original Beaglebone White dts. This breaks applications that
leverage the crypto blocks so fix this by enabling these nodes
in the am335x-bone-common.dtsi. With this change, enabling the
nodes in am335x-bone.dts is no longer required so remove them.

Signed-off-by: Matt Porter <mporter@konsulko.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 8 ++++++++
 arch/arm/boot/dts/am335x-bone.dts         | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 6cc25ed..12cdb2b 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -300,3 +300,11 @@
 	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
 	cd-inverted;
 };
+
+&aes {
+	status = "okay";
+};
+
+&sham {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 83d40f7..6b849372 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -24,11 +24,3 @@
 &mmc1 {
 	vmmc-supply = <&ldo3_reg>;
 };
-
-&sham {
-	status = "okay";
-};
-
-&aes {
-	status = "okay";
-};
-- 
1.8.4
