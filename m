From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 20 Dec 2015 12:43:02 +0100
Subject: [PATCH 5/5] ARM: dts: sun7i: Enable gmac on Wits Pro A20 DKT
In-Reply-To: <1450611782-9494-1-git-send-email-hdegoede@redhat.com>
References: <1450611782-9494-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1450611782-9494-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Wits Pro A20 DKT has a gbit ethernet port, enable it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
index 85b500d..dc31d47 100644
--- a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
@@ -80,6 +80,18 @@
 	status = "okay";
 };
 
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_pins_rgmii_a>;
+	phy = <&phy1>;
+	phy-mode = "rgmii";
+	status = "okay";
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins_a>;
-- 
2.5.0
