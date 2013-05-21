From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 21 May 2013 14:14:24 +0200
Subject: [PATCH v4 03/21] ARM: shmobile: r8a73a4: Add pin control device to
 device tree
In-Reply-To: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1369138482-5871-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a pfc node to the r8a73a4 device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index fde2a33..358898c 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -91,4 +91,11 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 69 4>;
 	};
+
+	pfc: pfc at e6050000 {
+		compatible = "renesas,pfc-r8a73a4";
+		reg = <0xe6050000 0x9000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
-- 
1.8.1.5
