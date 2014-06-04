From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Wed,  4 Jun 2014 18:03:43 +0200
Subject: [PATCH v2 2/5] Documentation: bindings: add the Berlin CPU control doc
In-Reply-To: <1401897826-11711-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1401897826-11711-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1401897826-11711-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the CPU control compatible, needed for the SMP support on
Marvell Berlin SoCs.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/marvell,berlin.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell,berlin.txt b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
index 0677003e1476..7f9b3ccdf25b 100644
--- a/Documentation/devicetree/bindings/arm/marvell,berlin.txt
+++ b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
@@ -23,3 +23,19 @@ SoC and board used. Currently known SoC compatibles are:
 
 	...
 }
+
+* Marvell Berlin CPU control bindings
+
+CPU control register allows various operations on CPUs, like resetting them
+independently.
+
+Required properties:
+- compatible: should be "marvell,berlin-cpu-ctrl"
+- reg: address and length of the register set
+
+Example:
+
+cpu-ctrl at f7dd0000 {
+	compatible = "marvell,berlin-cpu-ctrl";
+	reg = <0xf7dd0000 0x10000>;
+};
-- 
1.9.1
