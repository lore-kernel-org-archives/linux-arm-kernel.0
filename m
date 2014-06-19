From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 19 Jun 2014 18:40:43 +0200
Subject: [PATCH v2] ARM: mvebu: Fix missing binding documentation for Armada
 38x
Message-ID: <1403196043-6317-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the Armada 380 and Armada 385 SoCs, the common bindings for those
2 SoCs, was forgotten. This patch add the documentation for the
marvell,aramda38x property.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
--
Hi,

This fix should be merged in 3.16. For 3.15 I am not sure as it is not
a regression.

Changelog:
v1->v2

- Reformulate to make clear that we will need marvell,armada38x _and_ a
SoC specific string. For consistency I duplicated what we have done in
armada-370-xp.txt


Thanks,
Gregory


 Documentation/devicetree/bindings/arm/armada-38x.txt | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/armada-38x.txt b/Documentation/devicetree/bindings/arm/armada-38x.txt
index 11f2330a6554..fa08760046df 100644
--- a/Documentation/devicetree/bindings/arm/armada-38x.txt
+++ b/Documentation/devicetree/bindings/arm/armada-38x.txt
@@ -6,5 +6,18 @@ following property:
 
 Required root node property:
 
- - compatible: must contain either "marvell,armada380" or
-   "marvell,armada385" depending on the variant of the SoC being used.
+compatible: must contain "marvell,armada38x"
+
+In addition, boards using the Marvell Armada 380 SoC shall have the
+following property:
+
+Required root node property:
+
+compatible: must contain "marvell,armada380"
+
+In addition, boards using the Marvell Armada 385 SoC shall have the
+following property:
+
+Required root node property:
+
+compatible: must contain "marvell,armada385"
-- 
1.8.1.2
