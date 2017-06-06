From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  6 Jun 2017 02:54:23 +0200
Subject: [PATCH v4 25/28] ARM: dts: s500: Add SPS node
In-Reply-To: <20170606005426.26446-1-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
Message-ID: <20170606005426.26446-26-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Smart Power System node for PM domains.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3 -> v4:
 * Extended commit message
 * Split off association of power-domains (avoids include/dt-bindings/ dependency)
 
 v3: new
 
 arch/arm/boot/dts/s500.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/s500.dtsi b/arch/arm/boot/dts/s500.dtsi
index 6d6024027ee2..51a48741d4c0 100644
--- a/arch/arm/boot/dts/s500.dtsi
+++ b/arch/arm/boot/dts/s500.dtsi
@@ -176,5 +176,11 @@
 			             <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "2hz0", "2hz1", "timer0", "timer1";
 		};
+
+		sps: power-controller at b01b0100 {
+			compatible = "actions,s500-sps";
+			reg = <0xb01b0100 0x100>;
+			#power-domain-cells = <1>;
+		};
 	};
 };
-- 
2.12.3
