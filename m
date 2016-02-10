From: linux@baker-net.org.uk (Adam Baker)
Date: Wed, 10 Feb 2016 23:33:44 +0000
Subject: [PATCH 3/3] ARM: mvebu: Add the hardware monitor to the NSA320 device
 tree
In-Reply-To: <1455147224-6742-1-git-send-email-linux@baker-net.org.uk>
References: <1455147224-6742-1-git-send-email-linux@baker-net.org.uk>
Message-ID: <1455147224-6742-4-git-send-email-linux@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an entry for the hardware monitoring MCU

Signed-off-by: Adam Baker <linux@baker-net.org.uk>
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
