From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 19 Jun 2013 23:54:38 +0400
Subject: [PATCH v2 7/7] drivers: bus: imx-weim: Change compatible string for
 i.MX6Q
In-Reply-To: <1371671678-6345-1-git-send-email-shc_work@mail.ru>
References: <1371671678-6345-1-git-send-email-shc_work@mail.ru>
Message-ID: <1371671678-6345-7-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes compatible string for i.MX6Q to "fsl,imx50-weim"
since this is a lowest CPU type with same bus.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 Documentation/devicetree/bindings/bus/imx-weim.txt | 2 +-
 drivers/bus/imx-weim.c                             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/imx-weim.txt b/Documentation/devicetree/bindings/bus/imx-weim.txt
index 99406e4..b134811 100644
--- a/Documentation/devicetree/bindings/bus/imx-weim.txt
+++ b/Documentation/devicetree/bindings/bus/imx-weim.txt
@@ -33,7 +33,7 @@ Timing property for child nodes. It is mandatory, not optional.
 Example for an imx6q-sabreauto board, the NOR flash connected to the WEIM:
 
 	weim: weim at 021b8000 {
-		compatible = "fsl,imx6q-weim";
+		compatible = "fsl,imx6q-weim", "fsl,imx50-weim";
 		reg = <0x021b8000 0x4000>;
 		clocks = <&clks 196>;
 		#address-cells = <2>;
diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 77fa1d4..3f665f8 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -47,7 +47,7 @@ static const struct of_device_id weim_id_table[] = {
 	/* i.MX25/27/31/35 */
 	{ .compatible = "fsl,imx25-weim", .data = &imx25_weim_devtype, },
 	/* i.MX50/53/6Q */
-	{ .compatible = "fsl,imx6q-weim", .data = &imx50_weim_devtype, },
+	{ .compatible = "fsl,imx50-weim", .data = &imx50_weim_devtype, },
 	/* i.MX51 */
 	{ .compatible = "fsl,imx51-weim", .data = &imx51_weim_devtype, },
 	{ }
-- 
1.8.1.5
