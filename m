From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 27 Sep 2013 19:42:33 -0400
Subject: [PATCH 1/4] ARM: dts: keystone: Add i2c device nodes
In-Reply-To: <1380325356-2100-1-git-send-email-santosh.shilimkar@ti.com>
References: <1380325356-2100-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1380325356-2100-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keystone2 based SOCs supports 3 instances of i2c controllers. Add
the device nodes for them. The i2c0 child device AT24C1024 EEPROM node
is also added. When different board variants are added in future, it
can be moved to the supported boards from common SOC file.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/keystone.dts |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dts b/arch/arm/boot/dts/keystone.dts
index 7d576b5..3f56556 100644
--- a/arch/arm/boot/dts/keystone.dts
+++ b/arch/arm/boot/dts/keystone.dts
@@ -124,5 +124,35 @@
 			interrupts = <GIC_SPI 280 IRQ_TYPE_EDGE_RISING>;
 		};
 
+		i2c0: i2c at 2530000 {
+			compatible = "ti,davinci-i2c";
+			reg = <0x02530000 0x400>;
+			clock-frequency = <100000>;
+			clocks = <&clki2c>;
+			interrupts = <GIC_SPI 283 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dtt at 50 {
+				compatible = "at,24c1024";
+				reg = <0x50>;
+			};
+		};
+
+		i2c1: i2c at 2530400 {
+			compatible = "ti,davinci-i2c";
+			reg = <0x02530400 0x400>;
+			clock-frequency = <100000>;
+			clocks = <&clki2c>;
+			interrupts = <GIC_SPI 286 IRQ_TYPE_EDGE_RISING>;
+		};
+
+		i2c2: i2c at 2530800 {
+			compatible = "ti,davinci-i2c";
+			reg = <0x02530800 0x400>;
+			clock-frequency = <100000>;
+			clocks = <&clki2c>;
+			interrupts = <GIC_SPI 289 IRQ_TYPE_EDGE_RISING>;
+		};
 	};
 };
-- 
1.7.9.5
