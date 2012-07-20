From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 20 Jul 2012 13:01:47 +0530
Subject: [PATCH v2 1/2] arm/dts: Add AM33XX basic pinctrl support
In-Reply-To: <1342769508-24810-1-git-send-email-anilkumar@ti.com>
References: <1342769508-24810-1-git-send-email-anilkumar@ti.com>
Message-ID: <1342769508-24810-2-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic pinctrl support for AM33XX family of devices by adding DT
data to am33xx dtsi file. These patches are based on pinctrl-single
driver and tested on am335x-evm & am335x-bone devices.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 59509c4..9b974dc 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -40,6 +40,15 @@
 		};
 	};
 
+	am3358_pinmux: pinmux at 44E10800 {
+		compatible = "pinctrl-single";
+		reg = <0x44E10800 0x0338>;
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
1.7.0.4
