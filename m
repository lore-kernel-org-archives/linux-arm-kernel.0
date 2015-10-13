From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 13 Oct 2015 14:37:45 +0200
Subject: [PATCH resend] ARM: dts: sun6i: Turn on gmac on Colombus
In-Reply-To: <1444739865-26497-1-git-send-email-hdegoede@redhat.com>
References: <1444739865-26497-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1444739865-26497-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We've everything we need to support the gmac on Colombus, turn it on.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31-colombus.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
index 813f715..f9cf368 100644
--- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
+++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
@@ -76,6 +76,18 @@
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
