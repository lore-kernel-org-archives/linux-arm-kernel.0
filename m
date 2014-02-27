From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 27 Feb 2014 22:28:02 +0100
Subject: [PATCH 1/4] ARM: dove: add system controller node
In-Reply-To: <1393536486-3827-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1393536486-3827-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1393536486-3827-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a DT node for the system-controller found on Marvell Dove
SoCs.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/dove.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 187fd46b7b5e..bd63452b18c0 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -186,6 +186,11 @@
 				reg = <0x20000 0x80>, <0x800100 0x8>;
 			};
 
+			sysc: system-ctrl at 20000 {
+				compatible = "marvell,orion-system-controller";
+				reg = <0x20000 0x110>;
+			};
+
 			bridge_intc: bridge-interrupt-ctrl at 20110 {
 				compatible = "marvell,orion-bridge-intc";
 				interrupt-controller;
-- 
1.8.5.3
