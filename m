From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 26 May 2017 01:44:43 +0200
Subject: [PATCH 1/2] net: dsa: mv88e6xxx: Add eeprom-length to binding
In-Reply-To: <1495755884-31341-1-git-send-email-andrew@lunn.ch>
References: <1495755884-31341-1-git-send-email-andrew@lunn.ch>
Message-ID: <1495755884-31341-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The binding documentation for the mv88e6xxx switch is missing the
eeprom-length property, which has been implemented since May 2016,
commit f8cd8753def0 ("dsa: mv88e6xxx: Handle eeprom-length property")

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/net/dsa/marvell.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/marvell.txt b/Documentation/devicetree/bindings/net/dsa/marvell.txt
index 7ef9dbb08957..1d4d0f49c9d0 100644
--- a/Documentation/devicetree/bindings/net/dsa/marvell.txt
+++ b/Documentation/devicetree/bindings/net/dsa/marvell.txt
@@ -26,6 +26,10 @@ Optional properties:
 - interrupt-controller	: Indicates the switch is itself an interrupt
 			  controller. This is used for the PHY interrupts.
 #interrupt-cells = <2>	: Controller uses two cells, number and flag
+- eeprom-length		: Set to the length of an EEPROM connected to the
+			  switch. Must be set if the switch can not detect
+			  the presence and/or size of a connected EEPROM,
+			  otherwise optional.
 - mdio			: Container of PHY and devices on the switches MDIO
 			  bus.
 - mdio?		: Container of PHYs and devices on the external MDIO
-- 
2.11.0
