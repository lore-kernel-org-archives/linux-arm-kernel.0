From: huangdaode@hisilicon.com (huangdaode)
Date: Wed, 18 Nov 2015 10:08:00 +0800
Subject: [PATCH v3 net-next] net: hisilicon: fix binding document of mdio
Message-ID: <1447812480-190001-1-git-send-email-huangdaode@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch explains the occasion of "hisilcon,mdio" and
"hisilicon,hns-mdio" according to Arnd's comments.
and reformat it according to comments from Rob<robh@kernel.org>.

Signed-off-by: huangdaode <huangdaode@hisilicon.com>
---
change log:
v3:
  1)move change log under '---' line.
  2)change minor syntax error on description.

v2:
  1) reformat the style.
  2) make it more clearity.

v1:
  initial version.

v2 patch reference:https://lkml.org/lkml/2015/11/16/88
v1 patch reference:https://lkml.org/lkml/2015/11/12/913

 Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt b/Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt
index 9c23fdf..4a7ede9 100644
--- a/Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt
+++ b/Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt
@@ -1,7 +1,12 @@
 Hisilicon MDIO bus controller
 
 Properties:
-- compatible: "hisilicon,mdio","hisilicon,hns-mdio".
+- compatible: can be one of:
+	"hisilicon,hns-mdio"
+	"hisilicon,mdio"
+  "hisilicon,hns-mdio" is recommended to be used for hip05 and later SOCs,
+  while "hisilicon,mdio" is optional for backwards compatibility only on
+  hip04 Soc.
 - reg: The base address of the MDIO bus controller register bank.
 - #address-cells: Must be <1>.
 - #size-cells: Must be <0>.  MDIO addresses have no size component.
-- 
1.9.1
