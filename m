From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 15 Feb 2014 11:20:09 +0100
Subject: [PATCH v2 11/23] ARM: Kirkwood: Instantiate L2 cache from DT.
In-Reply-To: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
Message-ID: <1392459621-24003-12-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the Ferocean L2 cache has a DT binding, make use of it.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
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
