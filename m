From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 12:29:14 +0900
Subject: [PATCH 2/9] ARM: shmobile: r8a7740: Add pin control device in device
 tree
In-Reply-To: <1360726161-16072-1-git-send-email-horms+renesas@verge.net.au>
References: <1360726161-16072-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1360726161-16072-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add a pfc node in the r8a7740 device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 798fa35..9d7800a 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -18,4 +18,12 @@
 			compatible = "arm,cortex-a9";
 		};
 	};
+
+	gpio: pfc at e6050000 {
+		compatible = "renesas,pfc-r8a7740";
+		reg = <0xe6050000 0x8000>,
+		      <0xe605800c 0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
-- 
1.7.10.4
