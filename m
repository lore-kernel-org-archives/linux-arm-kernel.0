From: joelf@ti.com (Joel Fernandes)
Date: Mon, 30 Sep 2013 10:13:03 -0500
Subject: [PATCH v2 6/9] ARM: am437x: dts: Add AES node for am437x
In-Reply-To: <1380553986-15910-1-git-send-email-joelf@ti.com>
References: <1380553986-15910-1-git-send-email-joelf@ti.com>
Message-ID: <1380553986-15910-7-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM437x SoC has AES module similar to the one on OMAP4.
Add DT node for the same.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 0fe393a..7e9ff75 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -411,5 +411,12 @@
 			ti,hwmods = "epwmss5";
 			status = "disabled";
 		};
+
+		aes: aes at 53501000 {
+			compatible = "ti,omap4-aes";
+			ti,hwmods = "aes";
+			reg = <0x53501000 0xa0>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };
-- 
1.8.1.2
