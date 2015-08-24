From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Mon, 24 Aug 2015 09:26:19 +0800
Subject: [RFC PATCH v7 03/10] Documentation: synopsys-dw-mshc: add bindings
 for idmac and edmac
In-Reply-To: <1440379479-24308-1-git-send-email-shawn.lin@rock-chips.com>
References: <1440379479-24308-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1440379579-24485-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

synopsys-dw-mshc supports three types of transfer mode. We add
bindings and description for how to use them at runtime.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index 346c609..8636f5a 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
@@ -75,6 +75,12 @@ Optional properties:
 * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
   specified we'll defer probe until we can find this regulator.
 
+* dmas: List of DMA specifiers with the controller specific format as described
+  in the generic DMA client binding. Refer to dma.txt for details.
+
+* dma-names: request names for generic DMA client binding. Must be "rx-tx".
+  Refer to dma.txt for details.
+
 Aliases:
 
 - All the MSHC controller nodes should be represented in the aliases node using
@@ -95,6 +101,23 @@ board specific portions as listed below.
 		#size-cells = <0>;
 	};
 
+[board specific internal DMA resources]
+
+	dwmmc0 at 12200000 {
+		clock-frequency = <400000000>;
+		clock-freq-min-max = <400000 200000000>;
+		num-slots = <1>;
+		broken-cd;
+		fifo-depth = <0x80>;
+		card-detect-delay = <200>;
+		vmmc-supply = <&buck8>;
+		bus-width = <8>;
+		cap-mmc-highspeed;
+		cap-sd-highspeed;
+	};
+
+[board specific generic DMA request binding]
+
 	dwmmc0 at 12200000 {
 		clock-frequency = <400000000>;
 		clock-freq-min-max = <400000 200000000>;
@@ -106,4 +129,6 @@ board specific portions as listed below.
 		bus-width = <8>;
 		cap-mmc-highspeed;
 		cap-sd-highspeed;
+		dmas = <&pdma 12>;
+		dma-names = "rx-tx";
 	};
-- 
2.3.7
