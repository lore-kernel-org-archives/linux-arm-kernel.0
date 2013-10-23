From: tharvey@gateworks.com (Tim Harvey)
Date: Tue, 22 Oct 2013 21:51:27 -0700
Subject: [PATCH 3/4] ARM: dts: disable flexcan by default
In-Reply-To: <1382503888-3962-1-git-send-email-tharvey@gateworks.com>
References: <1382503888-3962-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1382503888-3962-4-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Typically nodes are disabled by default and enabled when needed.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index caa88f9..226ce75 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -331,6 +331,7 @@
 				interrupts = <0 110 0x04>;
 				clocks = <&clks 108>, <&clks 109>;
 				clock-names = "ipg", "per";
+				status = "disabled";
 			};
 
 			can2: flexcan at 02094000 {
@@ -339,6 +340,7 @@
 				interrupts = <0 111 0x04>;
 				clocks = <&clks 110>, <&clks 111>;
 				clock-names = "ipg", "per";
+				status = "disabled";
 			};
 
 			gpt: gpt at 02098000 {
-- 
1.7.9.5
