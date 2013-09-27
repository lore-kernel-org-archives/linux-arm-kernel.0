From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 27 Sep 2013 19:42:34 -0400
Subject: [PATCH 2/4] ARM: dts: keystone: Add the SPI nodes
In-Reply-To: <1380325356-2100-1-git-send-email-santosh.shilimkar@ti.com>
References: <1380325356-2100-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1380325356-2100-3-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keystone2 based SOCs supports 3 instances of SPI controllers. Add
the device nodes for them.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/keystone.dts |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dts b/arch/arm/boot/dts/keystone.dts
index 3f56556..8203da5 100644
--- a/arch/arm/boot/dts/keystone.dts
+++ b/arch/arm/boot/dts/keystone.dts
@@ -154,5 +154,32 @@
 			clocks = <&clki2c>;
 			interrupts = <GIC_SPI 289 IRQ_TYPE_EDGE_RISING>;
 		};
+
+		spi0: spi at 21000400 {
+			compatible = "ti,dm6441-spi";
+			reg = <0x21000400 0x200>;
+			num-cs = <4>;
+			ti,davinci-spi-intr-line = <0>;
+			interrupts = <GIC_SPI 292 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&clkspi>;
+		};
+
+		spi1: spi at 21000600 {
+			compatible = "ti,dm6441-spi";
+			reg = <0x21000600 0x200>;
+			num-cs = <4>;
+			ti,davinci-spi-intr-line = <0>;
+			interrupts = <GIC_SPI 296 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&clkspi>;
+		};
+
+		spi2: spi at 21000800 {
+			compatible = "ti,dm6441-spi";
+			reg = <0x21000800 0x200>;
+			num-cs = <4>;
+			ti,davinci-spi-intr-line = <0>;
+			interrupts = <GIC_SPI 300 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&clkspi>;
+		};
 	};
 };
-- 
1.7.9.5
