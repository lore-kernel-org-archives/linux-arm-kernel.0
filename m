From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 12 Jun 2013 00:22:41 +0200
Subject: [PATCH v5 12/22] ARM: shmobile: sh7372: Add pin control device to
 device tree
In-Reply-To: <1370989371-30846-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1370989371-30846-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1370989371-30846-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a pfc node to the sh7372 device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/sh7372.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sh7372.dtsi b/arch/arm/boot/dts/sh7372.dtsi
index 677fc60..ce19398 100644
--- a/arch/arm/boot/dts/sh7372.dtsi
+++ b/arch/arm/boot/dts/sh7372.dtsi
@@ -18,4 +18,12 @@
 			compatible = "arm,cortex-a8";
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
1.8.1.5
