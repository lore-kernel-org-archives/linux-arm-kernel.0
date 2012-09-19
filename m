From: anilkumar@ti.com (AnilKumar Ch)
Date: Thu, 20 Sep 2012 02:49:26 +0530
Subject: [PATCH RESEND v7 1/5] ARM: dts: AM33XX: Add basic pinctrl device tree
 data
In-Reply-To: <1348089570-16161-1-git-send-email-anilkumar@ti.com>
References: <1348089570-16161-1-git-send-email-anilkumar@ti.com>
Message-ID: <1348089570-16161-2-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds basic pinctrl device tree data for AM33XX family of devices.
This patch is based on the pinctrl-single driver.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index b4e3e47..894fec6 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -55,6 +55,15 @@
 		};
 	};
 
+	am33xx_pinmux: pinmux at 44e10800 {
+		compatible = "pinctrl-single";
+		reg = <0x44e10800 0x0238>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x7f>;
+	};
+
 	/*
 	 * XXX: Use a flat representation of the AM33XX interconnect.
 	 * The real AM33XX interconnect network is quite complex.Since
-- 
1.7.9.5
