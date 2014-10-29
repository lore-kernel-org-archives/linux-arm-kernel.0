From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 29 Oct 2014 13:59:51 +0900
Subject: [PATCH 1/4] ARM: shmobile: r8a73a4: Add CMT1 node
In-Reply-To: <cover.1414557047.git.horms+renesas@verge.net.au>
References: <cover.1414557047.git.horms+renesas@verge.net.au>
Message-ID: <f7b65230019b9dacd69922f925933c8bde1f9ec2.1414557047.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This describes all of the CMT1 hardware of the r8a73a4.
The node is disabled and may be enabled as necessary by board DTS files.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index c17afef..8093967 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -109,6 +109,17 @@
 		compatible = "renesas,rmobile-iic";
 		reg = <0 0xe60b0000 0 0x428>;
 		interrupts = <0 179 IRQ_TYPE_LEVEL_HIGH>;
+
+		status = "disabled";
+	};
+
+	cmt1: timer at e6130000 {
+		compatible = "renesas,cmt-48-gen2";
+		reg = <0 0xe6130000 0 0x1004>;
+		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>;
+
+		renesas,channels-mask = <0xff>;
+
 		status = "disabled";
 	};
 
-- 
2.1.1
