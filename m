From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed,  7 Jun 2017 10:38:09 +0200
Subject: [PATCH 8/9] dt-bindings: orion-mdio: document the new xmdio compatible
In-Reply-To: <20170607083810.30922-1-antoine.tenart@free-electrons.com>
References: <20170607083810.30922-1-antoine.tenart@free-electrons.com>
Message-ID: <20170607083810.30922-9-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new compatible for Marvell xMDIO interfaces was added into the Marvell
MDIO driver. Document this new compatible.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 Documentation/devicetree/bindings/net/marvell-orion-mdio.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/marvell-orion-mdio.txt b/Documentation/devicetree/bindings/net/marvell-orion-mdio.txt
index ccdabdcc8618..315036ff8fed 100644
--- a/Documentation/devicetree/bindings/net/marvell-orion-mdio.txt
+++ b/Documentation/devicetree/bindings/net/marvell-orion-mdio.txt
@@ -1,12 +1,12 @@
 * Marvell MDIO Ethernet Controller interface
 
 The Ethernet controllers of the Marvel Kirkwood, Dove, Orion5x,
-MV78xx0, Armada 370 and Armada XP have an identical unit that provides
-an interface with the MDIO bus. This driver handles this MDIO
-interface.
+MV78xx0, Armada 370, Armada XP, Armada 7k and Armada 8k have an
+identical unit that provides an interface with the MDIO bus or to
+the xMDIO bus. This driver handles these interfaces.
 
 Required properties:
-- compatible: "marvell,orion-mdio"
+- compatible: "marvell,orion-mdio" or "marvell,xmdio"
 - reg: address and length of the MDIO registers.  When an interrupt is
   not present, the length is the size of the SMI register (4 bytes)
   otherwise it must be 0x84 bytes to cover the interrupt control
-- 
2.9.4
