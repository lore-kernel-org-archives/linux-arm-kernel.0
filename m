From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 27 Aug 2013 11:34:38 -0300
Subject: [PATCH 14/15] ARM: mvebu: system-controller: Add second reg cell
 devicetree specification
In-Reply-To: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377614079-10000-15-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Specify an optional second reg property cell to system-controller's DT
node. This cell must be used to specify the watchdog RSTOUT register base
address.

Cc: devicetree at vger.kernel.org
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/mvebu-system-controller.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/mvebu-system-controller.txt b/Documentation/devicetree/bindings/arm/mvebu-system-controller.txt
index 081c6a7..95a75b3 100644
--- a/Documentation/devicetree/bindings/arm/mvebu-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/mvebu-system-controller.txt
@@ -9,9 +9,14 @@ Required properties:
 	- "marvell,armada-370-xp-system-controller"
 - reg: Should contain system controller registers location and length.
 
+Optional properties:
+
+- reg: An optional second cell must be used to specify the watchdog RSTOUT
+       register base address, available in Armada 370/XP SoC.
+
 Example:
 
 	system-controller at d0018200 {
 		compatible = "marvell,armada-370-xp-system-controller";
-		reg = <0xd0018200 0x500>;
+		reg = <0xd0018200 0x500>, <0xd0020704 0x4>;
 	};
-- 
1.8.1.5
