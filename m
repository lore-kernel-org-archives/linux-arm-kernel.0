From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Feb 2016 16:14:21 +0100
Subject: [PATCH v2 1/6] dt-bindings: arm/marvell: add DT bindings for AP806
 DFX Server
In-Reply-To: <1456326866-30854-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1456326866-30854-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1456326866-30854-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch adds a Device Tree binding documentation for the
AP806 DFX Server register area found in Marvell Armada 7K/8K SOCs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../bindings/arm/marvell/marvell,ap806-dfx-server.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,ap806-dfx-server.txt

diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,ap806-dfx-server.txt b/Documentation/devicetree/bindings/arm/marvell/marvell,ap806-dfx-server.txt
new file mode 100644
index 0000000..44eb3f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/marvell,ap806-dfx-server.txt
@@ -0,0 +1,19 @@
+Marvell AP806 DFX Server
+------------------------
+
+The Marvell AP806 HW block (which is a core component of the Marvell
+Armada 7K and 8K SOCs) has a set of registers called "DFX
+Server". This set of registers contains miscellaneous registers, most
+of them being used for silicon fine-tuning and manufacturing testing,
+and as such are not publicly documented. However, this DFX server
+register range also contains a few documented and useful registers,
+for example for clock control.
+
+This Device Tree binding allows to represent the entire DFX server
+register space as one single DT node.
+
+Required properties:
+- compatible: the first and second values must be:
+	"simple-mfd", "syscon"
+- reg: address and length of following register sets for the DFX
+  server
-- 
2.6.4
