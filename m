From: robherring2@gmail.com (Rob Herring)
Date: Wed,  7 Dec 2011 09:26:46 -0600
Subject: [PATCH] ARM: highbank: add xgmac ethernet devices to dts
Message-ID: <1323271606-11837-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add device nodes for xgmac ethernet block in Calxeda Highbank.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/highbank.dts |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/highbank.dts b/arch/arm/boot/dts/highbank.dts
index aeb1a75..305635b 100644
--- a/arch/arm/boot/dts/highbank.dts
+++ b/arch/arm/boot/dts/highbank.dts
@@ -194,5 +194,17 @@
 			reg = <0xfff3d000 0x1000>;
 			interrupts = <0 92 4>;
 		};
+
+		ethernet at fff50000 {
+			compatible = "calxeda,hb-xgmac";
+			reg = <0xfff50000 0x1000>;
+			interrupts = <0 77 4  0 78 4  0 79 4>;
+		};
+
+		ethernet at fff51000 {
+			compatible = "calxeda,hb-xgmac";
+			reg = <0xfff51000 0x1000>;
+			interrupts = <0 80 4  0 81 4  0 82 4>;
+		};
 	};
 };
-- 
1.7.5.4
