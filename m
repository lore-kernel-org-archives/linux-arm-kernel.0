From: kbeldan@baylibre.com (Karl Beldan)
Date: Tue,  9 Aug 2016 17:15:16 +0000
Subject: [PATCH 2/4] ARM: dts: da850: Add an aemif node
In-Reply-To: <20160809171518.22690-1-kbeldan@baylibre.com>
References: <20160809171518.22690-1-kbeldan@baylibre.com>
Message-ID: <20160809171518.22690-3-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the davinci da8xx boards use the mach-davinci aemif code.
Instantiating an aemif node into the DT allows to use the ti-aemif
memory driver and is another step to better DT support.
Also it will allow to properly pass the emif timings via DT.

Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index bc10e7e..f62928c 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -411,6 +411,16 @@
 			dma-names = "tx", "rx";
 		};
 	};
+	aemif: aemif at 68000000 {
+		compatible = "ti,da850-aemif";
+		#address-cells = <2>;
+		#size-cells = <1>;
+
+		reg = <0x68000000 0x00008000>;
+		ranges = <0 0 0x60000000 0x08000000
+			  1 0 0x68000000 0x00008000>;
+		status = "disabled";
+	};
 	nand_cs3 at 62000000 {
 		compatible = "ti,davinci-nand";
 		reg = <0x62000000 0x807ff
-- 
2.9.2
