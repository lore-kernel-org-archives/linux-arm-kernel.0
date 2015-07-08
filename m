From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  8 Jul 2015 17:02:36 +0200
Subject: [PATCHv2 7/8] ARM: mvebu: add suspend/resume DT information for
 Armada 388 GP
In-Reply-To: <1436367757-14202-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1436367757-14202-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1436367757-14202-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit improves the Armada 388 GP Device Tree description to
describe the 3 GPIOs that are used to connect the SoC to the PIC
micro-controller that we talk to shutdown the SoC when entering
suspend to RAM.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-388-gp.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index fd4f6fd..31e5ede 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -56,6 +56,14 @@
 		reg = <0x00000000 0x80000000>; /* 2 GB */
 	};
 
+	cpus {
+		pm_pic {
+			ctrl-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>,
+				     <&gpio1 2 GPIO_ACTIVE_LOW>,
+				     <&gpio1 3 GPIO_ACTIVE_LOW>;
+		};
+	};
+
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
@@ -406,8 +414,16 @@
 };
 
 &pinctrl {
+	pinctrl-0 = <&pic_pins>;
+	pinctrl-names = "default";
+
 	pca0_pins: pca0_pins {
 		marvell,pins = "mpp18";
 		marvell,function = "gpio";
 	};
+
+	pic_pins: pic-pins-0 {
+		marvell,pins = "mpp33", "mpp34", "mpp35";
+		marvell,function = "gpio";
+	};
 };
-- 
2.4.5
