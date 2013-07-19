From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 19 Jul 2013 13:37:03 +0900
Subject: [PATCH 09/19] ARM: shmobile: sh7372: Add pin control device to device
 tree
In-Reply-To: <cover.1374208262.git.horms+renesas@verge.net.au>
References: <cover.1374208262.git.horms+renesas@verge.net.au>
Message-ID: <ed3dcde41b77aa23ef04ea12c46ed78a816c2a50.1374208262.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add a pfc node to the sh7372 device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh7372.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sh7372.dtsi b/arch/arm/boot/dts/sh7372.dtsi
index 7bf020e..249f65be2 100644
--- a/arch/arm/boot/dts/sh7372.dtsi
+++ b/arch/arm/boot/dts/sh7372.dtsi
@@ -23,4 +23,12 @@
 			reg = <0x0>;
 		};
 	};
+
+	pfc: pfc at e6050000 {
+		compatible = "renesas,pfc-sh7372";
+		reg = <0xe6050000 0x8000>,
+		      <0xe605801c 0x1c>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
-- 
1.7.10.4
