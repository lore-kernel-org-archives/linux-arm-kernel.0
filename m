From: florian@openwrt.org (Florian Fainelli)
Date: Thu,  4 Apr 2013 12:27:12 +0200
Subject: [PATCH 2/5] mv643xx_eth: update Device Tree bindings documentation
In-Reply-To: <1365071235-11611-1-git-send-email-florian@openwrt.org>
References: <1365071235-11611-1-git-send-email-florian@openwrt.org>
Message-ID: <1365071235-11611-3-git-send-email-florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the Device Tree bindings documentation for the
Marvell MV643xx ethernet controller node and makes the
"local-mac-address" and "phy" properties optional instead of required.
The absence of a "phy" node is legal and describes a MAC to switch
configuration, while not specifying the "local-mac-address" allows for
reuse of the MAC address already programmed into the Ethernet
controller.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 Documentation/devicetree/bindings/marvell.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/marvell.txt b/Documentation/devicetree/bindings/marvell.txt
index e70a013..994b933 100644
--- a/Documentation/devicetree/bindings/marvell.txt
+++ b/Documentation/devicetree/bindings/marvell.txt
@@ -141,11 +141,11 @@ prefixed with the string "marvell,", for Marvell Technology Group Ltd.
      - interrupts : <a> where a is the interrupt number for the port.
      - interrupt-parent : the phandle for the interrupt controller
        that services interrupts for this device.
+
+   Optional properties:
      - phy : the phandle for the PHY connected to this ethernet
        controller.
      - local-mac-address : 6 bytes, MAC address
-
-   Optional properties:
      - clocks : Phandle to the clock control device and gate bit
      - clock-names : String describing the clock gate bit
      - speed : Speed to force the link (10, 100, 1000), used when no
-- 
1.7.10.4
