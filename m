From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 30 Jun 2017 10:56:07 +0100
Subject: [PATCH 7/8] arm64: dts: allwinner: a64: add SCPI power domain support
In-Reply-To: <20170630095608.24943-1-andre.przywara@arm.com>
References: <20170630095608.24943-1-andre.przywara@arm.com>
Message-ID: <20170630095608.24943-8-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SCPI protocol allows controlling device power domains, which
abstracts the various ways of providing voltage to devices like Ethernet
PHYs or on-board WiFi chips.
Provide the power domain provider DT node, which can be referenced by
a power domain consumer device.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 7cb1b04..30cad44 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -168,6 +168,12 @@
 			compatible = "arm,scpi-sensors";
 			#thermal-sensor-cells = <1>;
 		};
+
+		scpi_devpd: scpi-power-domains {
+			compatible = "arm,scpi-power-domains";
+			num-domains = <2>;
+			#power-domain-cells = <1>;
+		};
 	};
 
 	soc {
-- 
2.9.0
