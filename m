From: anilkumar@ti.com (AnilKumar Ch)
Date: Tue, 28 Aug 2012 13:40:52 +0530
Subject: [PATCH RESEND v4 1/3] arm/dts: AM33XX: Add basic pinctrl device tree
 data
In-Reply-To: <1346141454-18786-1-git-send-email-anilkumar@ti.com>
References: <1346141454-18786-1-git-send-email-anilkumar@ti.com>
Message-ID: <1346141454-18786-2-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds basic pinctrl device tree data for AM33XX family of devices.
This patch is based on the pinctrl-single driver.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index dde76f7..dfe9c559 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -40,6 +40,15 @@
 		};
 	};
 
+	am3358_pinmux: pinmux at 44E10800 {
+		compatible = "pinctrl-single";
+		reg = <0x44E10800 0x0238>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x7F>;
+	};
+
 	/*
 	 * XXX: Use a flat representation of the AM33XX interconnect.
 	 * The real AM33XX interconnect network is quite complex.Since
-- 
1.7.9.5
