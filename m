From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  7 Aug 2015 17:22:34 +0200
Subject: [PATCH 2/3] ARM: dts: sun6i: Turn on gmac on Colombus
In-Reply-To: <1438960955-6551-1-git-send-email-hdegoede@redhat.com>
References: <1438960955-6551-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1438960955-6551-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We've everything we need to support the gmac on Colombus, turn it on.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31-colombus.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
index 0cf9926..0d0b6f2 100644
--- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
+++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
@@ -66,6 +66,18 @@
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
2.4.3
