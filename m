From: linux@baker-net.org.uk (Adam Baker)
Date: Sat,  5 Mar 2016 15:34:57 +0000
Subject: [PATCH v4 3/3] ARM: mvebu: Add the hardware monitor to the NSA320
 device tree
In-Reply-To: <1457192097-32538-1-git-send-email-linux@baker-net.org.uk>
References: <1457192097-32538-1-git-send-email-linux@baker-net.org.uk>
Message-ID: <1457192097-32538-4-git-send-email-linux@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an entry for the hardware monitoring MCU

Signed-off-by: Adam Baker <linux@baker-net.org.uk>
---
This patch is unchanged from the version Gregory CLEMENT said
he would apply once the hwmon maintainers accept 2/3
---
 arch/arm/boot/dts/kirkwood-nsa320.dts | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-nsa320.dts b/arch/arm/boot/dts/kirkwood-nsa320.dts
index 24f686d..2a935e9 100644
--- a/arch/arm/boot/dts/kirkwood-nsa320.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa320.dts
@@ -193,10 +193,19 @@
 		};
 	};
 
+	hwmon {
+		compatible = "zyxel,nsa320-mcu";
+		pinctrl-0 = <&pmx_mcu_data &pmx_mcu_clk &pmx_mcu_act>;
+		pinctrl-names = "default";
+
+		data-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+		clk-gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
+		act-gpios = <&gpio0 17 GPIO_ACTIVE_LOW>;
+	};
+
 	/* The following pins are currently not assigned to a driver,
 	   some of them should be configured as inputs.
-	pinctrl-0 = <&pmx_mcu_data &pmx_mcu_clk &pmx_mcu_act
-		     &pmx_htp &pmx_vid_b1
+	pinctrl-0 = <&pmx_htp &pmx_vid_b1
 		     &pmx_power_resume_data &pmx_power_resume_clk>; */
 };
 
-- 
2.1.4
