From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 15 Feb 2014 11:20:15 +0100
Subject: [PATCH v2 17/23] ARM: MVEBU: Instantiate system controller in
 kirkwood.dtsi
In-Reply-To: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
Message-ID: <1392459621-24003-18-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of the mvebu system controller, by placing a node into the
dtsi file.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 02c551ee31e5..ba06124d8f35 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -145,6 +145,11 @@
 			reg = <0x20000 0x80>, <0x1500 0x20>;
 		};
 
+		system-controller at 20000 {
+			compatible = "marvell,orion-system-controller";
+			reg = <0x20000 0x120>;
+		};
+
 		bridge_intc: bridge-interrupt-ctrl at 20110 {
 			compatible = "marvell,orion-bridge-intc";
 			interrupt-controller;
-- 
1.8.5.3
