From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon, 26 Jan 2015 11:49:55 -0800
Subject: [PATCH 1/2] ARM: zynq: Remove bogus value from 'bias-disable' property
Message-ID: <1422301796-22888-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In one pinctrl node, a 'bias-disable' property is erroneously assigned a
value.

Fixes: ARM: zynq: DT: Add pinctrl information
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
Feel free to squash this into the mentioned patch. I don't see it in any
stable branch yet.

	S?ren
---
 arch/arm/boot/dts/zynq-zc702.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index 365bdd407eb4..4f8835be4874 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -309,7 +309,7 @@
 
 		conf-tx {
 			pins = "MIO48";
-			bias-disable = <0>;
+			bias-disable;
 		};
 	};
 };
-- 
2.2.2.1.g63c5777
