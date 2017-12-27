From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 27 Dec 2017 23:14:46 +0100
Subject: [PATCH net-next 6/6] arm64: dts: marvell: add Ethernet aliases
In-Reply-To: <20171227221446.18459-1-antoine.tenart@free-electrons.com>
References: <20171227221446.18459-1-antoine.tenart@free-electrons.com>
Message-ID: <20171227221446.18459-7-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yan Markman <ymarkman@marvell.com>

This patch adds Ethernet aliases in the Marvell Aramada 7040 DB, 8040 DB
and 8040 mcbin device trees so that the bootloader setup the MAC
addresses correctly.

Signed-off-by: Yan Markman <ymarkman@marvell.com>
[Antoine: commit message, small fixes]
Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts    | 6 ++++++
 arch/arm64/boot/dts/marvell/armada-8040-db.dts    | 7 +++++++
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 7 +++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 52b5341cb270..62b83416b30c 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -61,6 +61,12 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
+	aliases {
+		ethernet0 = &cpm_eth0;
+		ethernet1 = &cpm_eth1;
+		ethernet2 = &cpm_eth2;
+	};
+
 	cpm_reg_usb3_0_vbus: cpm-usb3-0-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb3h0-vbus";
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index d97b72bed662..d9fffde64c44 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -61,6 +61,13 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
+	aliases {
+		ethernet0 = &cpm_eth0;
+		ethernet1 = &cpm_eth2;
+		ethernet2 = &cps_eth0;
+		ethernet3 = &cps_eth1;
+	};
+
 	cpm_reg_usb3_0_vbus: cpm-usb3-0-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "cpm-usb3h0-vbus";
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index c51efd511324..7a23bb279e1c 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -62,6 +62,13 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
+	aliases {
+		ethernet0 = &cpm_eth0;
+		ethernet1 = &cps_eth0;
+		ethernet2 = &cps_eth1;
+		ethernet3 = &cps_eth2;
+	};
+
 	/* Regulator labels correspond with schematics */
 	v_3_3: regulator-3-3v {
 		compatible = "regulator-fixed";
-- 
2.14.3
