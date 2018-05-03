From: peron.clem@gmail.com (=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?=)
Date: Thu,  3 May 2018 11:56:18 +0200
Subject: [PATCH] ARM: dts: cygnus: add ethernet0 alias
Message-ID: <20180503095618.2312-1-peron.clem@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to avoid Linux generating a random mac address on every boot,
add an ethernet0 alias that will allow u-boot to patch the dtb with
the MAC address.

Signed-off-by: Cl?ment P?ron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 9fe4f5a6379e..1a05b8f48b54 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -41,6 +41,10 @@
 	model = "Broadcom Cygnus SoC";
 	interrupt-parent = <&gic>;
 
+	aliases {
+		ethernet0 = &eth0;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.17.0
