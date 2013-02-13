From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 12:29:16 +0900
Subject: [PATCH 4/9] ARM: shmobile: sh73a0: Add pin control device in device
 tree
In-Reply-To: <1360726161-16072-1-git-send-email-horms+renesas@verge.net.au>
References: <1360726161-16072-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1360726161-16072-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add a pfc node in the sh73a0 device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[horms+renesas at verge.net.au: resolved conflict in sh73a0.dtsi]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 721f486..fc7f0fd 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -22,6 +22,14 @@
 		};
 	};
 
+	gpio: pfc at e6050000 {
+		compatible = "renesas,pfc-sh73a0";
+		reg = <0xe6050000 0x8000>,
+		      <0xe605801c 0x1c>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gic: interrupt-controller at f0001000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
-- 
1.7.10.4
