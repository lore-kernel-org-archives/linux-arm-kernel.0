From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed, 16 Aug 2017 15:52:23 +0800
Subject: [RFC PATCH 2/3] dt-bindings: PCI: rockchip: Add support for pcie wake
 irq
In-Reply-To: <20170816075224.31734-1-jeffy.chen@rock-chips.com>
References: <20170816075224.31734-1-jeffy.chen@rock-chips.com>
Message-ID: <20170816075224.31734-3-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an optional interrupt for PCIE_WAKE pin.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 Documentation/devicetree/bindings/pci/rockchip-pcie.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
index 1453a734c2f5..6ef9903567db 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
@@ -22,10 +22,13 @@ Required properties:
 - phys: From PHY bindings: Phandle for the Generic PHY for PCIe.
 - phy-names:  MUST be "pcie-phy".
 - interrupts: Three interrupt entries must be specified.
-- interrupt-names: Must include the following names
-	- "sys"
-	- "legacy"
-	- "client"
+- interrupt-names: Include the following names
+	Required:
+		- "sys"
+		- "legacy"
+		- "client"
+	Optional:
+		- "wake"
 - resets: Must contain seven entries for each entry in reset-names.
 	   See ../reset/reset.txt for details.
 - reset-names: Must include the following names
-- 
2.11.0
