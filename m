From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Apr 2016 09:58:32 +0200
Subject: [PATCH v3 04/11] arm64: dts: marvell: add UART aliases and define
 stdout-path
In-Reply-To: <1461657519-11939-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1461657519-11939-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1461657519-11939-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the necessary UART aliases to the main Armada 7K/8K
.dtsi file, and uses them to define the /chosen/stdout-path property
on the Armada 7040 DB board.

Suggested-by: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts | 4 ++++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi  | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index ee57783..4b01744 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -51,6 +51,10 @@
 	compatible = "marvell,armada7040-db", "marvell,armada7040",
 		     "marvell,armada-ap806-quad", "marvell,armada-ap806";
 
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	memory at 00000000 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index ca42c36..9e2c1f9 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -54,6 +54,11 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
 	psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
-- 
2.6.4
