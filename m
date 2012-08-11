From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 11 Aug 2012 14:56:44 +0200
Subject: [PATCH 06/11] ARM: mvebu: add pinctrl device in DT for Armada 370/XP
 SoCs
In-Reply-To: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1344689809-6223-7-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

The Armada 370 and XP SoCs have configurable muxing for a certain
number of their pins, controlled through a pinctrl driver.

The 'compatible' property is defined in the SoC-specific .dtsi files,
since the compatible string identifies the number of pins and other
SoC-specific properties.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Rob Landley <rob@landley.net>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lior Amsalem <alior@marvell.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-doc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/armada-370-xp.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 6b6b932..7c72a70 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -63,6 +63,13 @@
 			       reg = <0xd0020300 0x30>;
 			       interrupts = <37>, <38>, <39>, <40>;
 		};
+
+                pinctrl at d0018000 {
+                               reg = <0xd0018000 0x38>;
+                               #address-cells = <1>;
+                               #size-cells = <1>;
+                               ranges;
+                };
 	};
 };
 
-- 
1.7.10.4
