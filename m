From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 30 Mar 2015 16:17:08 +0100
Subject: [PATCH v2 2/6] ahci: st: Update the DT example for how to obtain the
 PHY.
In-Reply-To: <1427728632-10846-1-git-send-email-peter.griffin@linaro.org>
References: <1427728632-10846-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1427728632-10846-3-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The example is wrong in that the phys property should take a
phandle to the phy port.

Also with the changing over to generic PHY type constants we also
update that as well.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/ata/ahci-st.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-st.txt b/Documentation/devicetree/bindings/ata/ahci-st.txt
index 0574a77..1331202 100644
--- a/Documentation/devicetree/bindings/ata/ahci-st.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-st.txt
@@ -11,7 +11,7 @@ Required properties:
  - reset-names	   :   Associated names must be; "pwr-dwn" and "sw-rst"
  - clocks	   : The phandle for the clock
  - clock-names	   :   Associated name must be; "ahci_clk"
- - phys		   : The phandle for the PHY device
+ - phys		   : The phandle for the PHY port
  - phy-names	   :   Associated name must be; "ahci_phy"
 
 Example:
@@ -21,7 +21,7 @@ Example:
 		reg             = <0xfe380000 0x1000>;
 		interrupts      = <GIC_SPI 157 IRQ_TYPE_NONE>;
 		interrupt-names = "hostc";
-		phys	        = <&miphy365x_phy MIPHY_PORT_0 MIPHY_TYPE_SATA>;
+		phys	        = <&phy_port0 PHY_TYPE_SATA>;
 		phy-names       = "ahci_phy";
 		resets	        = <&powerdown STIH416_SATA0_POWERDOWN>,
 				  <&softreset STIH416_SATA0_SOFTRESET>;
-- 
1.9.1
