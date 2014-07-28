From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 28 Jul 2014 15:05:03 +0200
Subject: [PATCH v3] Documentation: devicetree: Fix ADI AXI SPDIF specification
Message-ID: <1406552704-6736-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The specification requires compatible = "adi,axi-spdif-1.00.a" but
driver and example and file name indicate "adi,axi-spdif-tx-1.00.a".
Change the specification to match the implementation.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Fixes: d7b528eff927 ("dt: Add bindings documentation for the ADI AXI-SPDIF audio controller")
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2 -> v3:
 * Added Fixes header
 * CC broonie (Mark Brown)
 
 v2: New
 
 Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt b/Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt
index 46f344965313..4eb7997674a0 100644
--- a/Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt
+++ b/Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt
@@ -1,7 +1,7 @@
 ADI AXI-SPDIF controller
 
 Required properties:
- - compatible : Must be "adi,axi-spdif-1.00.a"
+ - compatible : Must be "adi,axi-spdif-tx-1.00.a"
  - reg : Must contain SPDIF core's registers location and length
  - clocks : Pairs of phandle and specifier referencing the controller's clocks.
    The controller expects two clocks, the clock used for the AXI interface and
-- 
1.9.3
