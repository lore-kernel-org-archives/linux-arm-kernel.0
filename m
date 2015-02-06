From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  6 Feb 2015 16:57:47 +0100
Subject: [PATCH 01/10] devicetree: bindings: add DT binding for the Marvell
 Armada 39x SoC family
In-Reply-To: <1423238276-9206-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1423238276-9206-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1423238276-9206-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 39x is a family of two SoCs: the Armada 390 and the
Armada 398, with a slightly different number of interfaces. This
commit introduces the Device Tree binding that documents the top-level
compatible strings for Armada 39x based platforms.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/armada-39x.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-39x.txt

diff --git a/Documentation/devicetree/bindings/arm/armada-39x.txt b/Documentation/devicetree/bindings/arm/armada-39x.txt
new file mode 100644
index 0000000..53d4ff9
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/armada-39x.txt
@@ -0,0 +1,20 @@
+Marvell Armada 39x Platforms Device Tree Bindings
+-------------------------------------------------
+
+Boards with a SoC of the Marvell Armada 39x family shall have the
+following property:
+
+Required root node property:
+
+ - compatible: must contain "marvell,armada390"
+
+In addition, boards using the Marvell Armada 398 SoC shall have the
+following property before the previous one:
+
+Required root node property:
+
+compatible: must contain "marvell,armada398"
+
+Example:
+
+compatible = "marvell,a398-db", "marvell,armada398", "marvell,armada390";
-- 
2.1.0
