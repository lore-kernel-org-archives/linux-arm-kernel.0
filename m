From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Thu,  9 Feb 2017 00:31:05 +0100 (CET)
Subject: [PATCH v2 2/5] dts: mfd: axp20x: Add binding for the AXP808
In-Reply-To: <cover.1486592470.git.rask@formelder.dk>
References: <cover.1486592470.git.rask@formelder.dk>
Message-ID: <6c4741c2cf30693bd204ac71d76bae2734eeead1.1486592471.git.rask@formelder.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP808 does not support address space extension, but is otherwise
identical to the AXP806, including the chip ID, so add a compatible
string for it to the binding.

Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---

No changes in v2.

 Documentation/devicetree/bindings/mfd/axp20x.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index 86ae540..8195b06 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -7,12 +7,13 @@ axp209 (X-Powers)
 axp221 (X-Powers)
 axp223 (X-Powers)
 axp806 (X-Powers)
+axp808 (X-Powers)
 axp809 (X-Powers)
 
 Required properties:
 - compatible: "x-powers,axp152", "x-powers,axp202", "x-powers,axp209",
 	      "x-powers,axp221", "x-powers,axp223", "x-powers,axp806",
-	      "x-powers,axp809"
+	      "x-powers,axp808", "x-powers,axp809"
 - reg: The I2C slave address or RSB hardware address for the AXP chip
 - interrupt-parent: The parent interrupt controller
 - interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
@@ -87,7 +88,7 @@ LDO_IO1		: LDO		: ips-supply		: GPIO 1
 RTC_LDO		: LDO		: ips-supply		: always on
 DRIVEVBUS	: Enable output	: drivevbus-supply	: external regulator
 
-AXP806 regulators, type, and corresponding input supply names:
+AXP806/AXP808 regulators, type, and corresponding input supply names:
 
 Regulator	  Type		  Supply Name		  Notes
 ---------	  ----		  -----------		  -----
@@ -108,7 +109,7 @@ CLDO2		: LDO		: cldoin-supply		: shared supply
 CLDO3		: LDO		: cldoin-supply		: shared supply
 SW		: On/Off Switch : swin-supply
 
-Additionally, the AXP806 DC-DC regulators support poly-phase arrangements
+Additionally, the AXP806/AXP808 DC-DC regulators support poly-phase arrangements
 for higher output current. The possible groupings are: A+B, A+B+C, D+E.
 
 AXP809 regulators, type, and corresponding input supply names:
-- 
2.10.2
