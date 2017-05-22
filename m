From: ricardo.salveti@linaro.org (Ricardo Salveti)
Date: Mon, 22 May 2017 11:51:38 -0300
Subject: [PATCH] arm: dts: boneblack-wireless: add WL1835 Bluetooth device node
Message-ID: <1495464701-12046-1-git-send-email-ricardo.salveti@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the serial slave device for the WL1835 Bluetooth interface.

Signed-off-by: Ricardo Salveti <ricardo.salveti@linaro.org>
---
 arch/arm/boot/dts/am335x-boneblack-wireless.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblack-wireless.dts b/arch/arm/boot/dts/am335x-boneblack-wireless.dts
index 105bd10..83f49f6 100644
--- a/arch/arm/boot/dts/am335x-boneblack-wireless.dts
+++ b/arch/arm/boot/dts/am335x-boneblack-wireless.dts
@@ -97,6 +97,11 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins &bt_pins>;
 	status = "okay";
+
+	bluetooth {
+		compatible = "ti,wl1835-st";
+		enable-gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &gpio3 {
-- 
2.7.4
