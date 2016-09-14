From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 14 Sep 2016 14:27:45 +0100
Subject: [PATCH 07/19] ahci: st: Remove STiH416 dt example
In-Reply-To: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1473859677-9231-8-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform is being removed from the kernel so remove
the dt example.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: <tj@kernel.org>
Cc: <robh+dt@kernel.org>
Cc: <linux-ide@vger.kernel.org>
---
 Documentation/devicetree/bindings/ata/ahci-st.txt | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-st.txt b/Documentation/devicetree/bindings/ata/ahci-st.txt
index e1d01df..909c993 100644
--- a/Documentation/devicetree/bindings/ata/ahci-st.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-st.txt
@@ -18,21 +18,6 @@ Optional properties:
 
 Example:
 
-	/* Example for stih416 */
-	sata0: sata at fe380000 {
-		compatible	= "st,ahci";
-		reg		= <0xfe380000 0x1000>;
-		interrupts	= <GIC_SPI 157 IRQ_TYPE_NONE>;
-		interrupt-names	= "hostc";
-		phys		= <&phy_port0 PHY_TYPE_SATA>;
-		phy-names	= "ahci_phy";
-		resets		= <&powerdown STIH416_SATA0_POWERDOWN>,
-				  <&softreset STIH416_SATA0_SOFTRESET>;
-		reset-names	= "pwr-dwn", "sw-rst";
-		clocks		= <&clk_s_a0_ls CLK_ICN_REG>;
-		clock-names	= "ahci_clk";
-	};
-
 	/* Example for stih407 family silicon */
 	sata0: sata at 9b20000 {
 		compatible	= "st,ahci";
-- 
1.9.1
