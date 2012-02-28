From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 28 Feb 2012 23:19:09 +0100
Subject: [PATCH v2 4/5] arm/dts: OMAP3: Add SPI controller nodes
In-Reply-To: <1330467550-20474-1-git-send-email-b-cousson@ti.com>
References: <1330467550-20474-1-git-send-email-b-cousson@ti.com>
Message-ID: <1330467550-20474-5-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the 4 McSPI controller nodes present in an OMAP3 device.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/omap3.dtsi |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 216c331..c47cd59 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -90,5 +90,37 @@
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
 		};
+
+		mcspi1: spi at 48098000 {
+			compatible = "ti,omap2-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi1";
+			ti,spi-num-cs = <4>;
+		};
+
+		mcspi2: spi at 4809a000 {
+			compatible = "ti,omap2-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi2";
+			ti,spi-num-cs = <2>;
+		};
+
+		mcspi3: spi at 480b8000 {
+			compatible = "ti,omap2-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi3";
+			ti,spi-num-cs = <2>;
+		};
+
+		mcspi4: spi at 480ba000 {
+			compatible = "ti,omap2-mcspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi4";
+			ti,spi-num-cs = <1>;
+		};
 	};
 };
-- 
1.7.0.4
