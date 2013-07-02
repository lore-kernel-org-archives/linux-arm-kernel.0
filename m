From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue,  2 Jul 2013 13:03:39 +0200
Subject: [PATCH v4 3/7] ARM: orion5x: update intc device tree node to new reg
 layout
In-Reply-To: <1372763023-12374-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1372763023-12374-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1372763023-12374-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Future irqchip driver for Orion SoCs has a modified reg layout starting
from CAUSE register. The former DT irq driver stub just used what the
non-DT driver wants. Currently, orion5x is not ready for irqchip driver
because of legacy timer and missing DT clk provider. To ease future
conversion and just because orion-intc binding documentation already
reflects new reg layout, we convert orion5x DT now.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
--- 
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/orion5x.dtsi |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index 2d241fc..ede6c3b 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -16,11 +16,12 @@
 	aliases {
 		gpio0 = &gpio0;
 	};
+
 	intc: interrupt-controller {
-		compatible = "marvell,orion-intc", "marvell,intc";
+		compatible = "marvell,orion-intc";
 		interrupt-controller;
 		#interrupt-cells = <1>;
-		reg = <0xf1020204 0x04>;
+		reg = <0xf1020200 0x08>;
 	};
 
 	ocp at f1000000 {
-- 
1.7.2.5
