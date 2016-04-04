From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  5 Apr 2016 00:22:34 +0800
Subject: [PATCH RFC 5/5] ARM: dts: sun8i: Enable Ethernet controller on the
 Orange PI PC
In-Reply-To: <1459786954-12649-1-git-send-email-wens@csie.org>
References: <1459786954-12649-1-git-send-email-wens@csie.org>
Message-ID: <1459786954-12649-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Orange PI PC uses the H3's internal Ethernet PHY with the EMAC
Ethernet controller.

Set a proper address for the PHY and enable the EMAC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This patch depends on "ARM: dts: sun8i-h3: Add Ethernet controller device",
which uses an binding still in development.

Do not merge.

---
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index daf50b9a6657..f01e10df812a 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -102,6 +102,20 @@
 	status = "okay";
 };
 
+&ephy {
+	allwinner,ephy-addr = <0x1>;
+};
+
+&emac {
+	phy = <&phy1>;
+	phy-mode = "mii";
+	status = "okay";
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
+
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ir_pins_a>;
-- 
2.7.0
