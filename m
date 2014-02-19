From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 19 Feb 2014 15:12:42 +0100
Subject: [Patch v3 11/23] ARM: Kirkwood: Instantiate L2 cache from DT.
In-Reply-To: <1392819174-11634-1-git-send-email-andrew@lunn.ch>
References: <1392819174-11634-1-git-send-email-andrew@lunn.ch>
Message-ID: <1392819174-11634-12-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the Ferocean L2 cache has a DT binding, make use of it.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/kirkwood.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 6abf44d257df..02c551ee31e5 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -161,6 +161,11 @@
 			#clock-cells = <1>;
 		};
 
+		l2: l2-cache at 20128 {
+			compatible = "marvell,kirkwood-cache";
+			reg = <0x20128 0x4>;
+		};
+
 		intc: main-interrupt-ctrl at 20200 {
 			compatible = "marvell,orion-intc";
 			interrupt-controller;
-- 
1.8.5.3
