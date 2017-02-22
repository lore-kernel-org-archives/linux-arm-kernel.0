From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Wed, 22 Feb 2017 20:41:02 +0100 (CET)
Subject: [PATCH v2 1/2] dts: mfd: axp20x: Add "xpowers,master-mode" property
 for AXP806 PMICs
In-Reply-To: <cover.1487791328.git.rask@formelder.dk>
References: <cover.1487791328.git.rask@formelder.dk>
Message-ID: <396866a490b6056c60e93d862656bb90daedab98.1487791328.git.rask@formelder.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit b101829a029a ("mfd: axp20x: Fix AXP806 access errors on cold boot")
was intended to fix the case where a board uses an AXP806 in slave mode,
but the boot loader leaves it in master mode for lack of AXP806 support.
But now the driver breaks on boards where the PMIC is operating in master
mode. To let the device tree describe which mode of operation is needed,
this patch introduces a new property "xpowers,master-mode".

Fixes: 204ae2963e10 ("mfd: axp20x: Add bindings for AXP806 PMIC")
Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
Changes from v1 to v2:
Changed the commit message such that Fixes: points to the commit which
introduced the bindings for the AXP806 because the property should have been
included from the beginning of the AXP806 support.

 Documentation/devicetree/bindings/mfd/axp20x.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index 8f3ad9a..b41d260 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -28,6 +28,9 @@ Optional properties:
 		  regulator to drive the OTG VBus, rather then as an input pin
 		  which signals whether the board is driving OTG VBus or not.
 
+- x-powers,master-mode: Boolean (axp806 only). Set this when the PMIC is
+			wired for master mode. The default is slave mode.
+
 - <input>-supply: a phandle to the regulator supply node. May be omitted if
 		  inputs are unregulated, such as using the IPSOUT output
 		  from the PMIC.
-- 
2.10.2
