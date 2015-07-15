From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 15 Jul 2015 19:00:01 -0400
Subject: [PATCH] ARM: keystone: dts: disable pcie dt bindings by default
Message-ID: <1437001202-19582-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the status of PCIe DT bindings in the SoC specific DTS to
"disabled" so that it can be enabled on a specific board by
setting the status to "Ok" in the board specific DTS.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/boot/dts/k2e.dtsi      | 1 +
 arch/arm/boot/dts/keystone.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/k2e.dtsi b/arch/arm/boot/dts/k2e.dtsi
index 50e555e..ecb9cd6 100644
--- a/arch/arm/boot/dts/k2e.dtsi
+++ b/arch/arm/boot/dts/k2e.dtsi
@@ -96,6 +96,7 @@
 			ranges = <0x81000000 0 0 0x23260000 0x4000 0x4000
 				0x82000000 0 0x60000000 0x60000000 0 0x10000000>;
 
+			status = "disabled";
 			device_type = "pci";
 			num-lanes = <2>;
 
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index c06542b..0d6be74 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -296,6 +296,7 @@
 			ranges = <0x81000000 0 0 0x23250000 0 0x4000
 				0x82000000 0 0x50000000 0x50000000 0 0x10000000>;
 
+			status = "disabled";
 			device_type = "pci";
 			num-lanes = <2>;
 
-- 
1.9.1
