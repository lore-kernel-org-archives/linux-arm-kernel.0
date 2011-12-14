From: robherring2@gmail.com (Rob Herring)
Date: Wed, 14 Dec 2011 09:28:58 -0600
Subject: [PATCH 9/9] ARM: highbank: add interrupt properties to gpio nodes
In-Reply-To: <1323876538-20406-1-git-send-email-robherring2@gmail.com>
References: <1323876538-20406-1-git-send-email-robherring2@gmail.com>
Message-ID: <1323876538-20406-10-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add interrupt-controller properties to pl061 gpio nodes so gpio lines can
function as interrupts.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/highbank.dts |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/highbank.dts b/arch/arm/boot/dts/highbank.dts
index aeb1a75..dfe2b49 100644
--- a/arch/arm/boot/dts/highbank.dts
+++ b/arch/arm/boot/dts/highbank.dts
@@ -89,7 +89,6 @@
 			#size-cells = <0>;
 			#address-cells = <1>;
 			interrupt-controller;
-			interrupt-parent;
 			reg = <0xfff11000 0x1000>,
 			      <0xfff10100 0x100>;
 		};
@@ -129,6 +128,8 @@
 			#gpio-cells = <2>;
 			compatible = "arm,pl061", "arm,primecell";
 			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			reg = <0xfff30000 0x1000>;
 			interrupts = <0 14 4>;
 		};
@@ -137,6 +138,8 @@
 			#gpio-cells = <2>;
 			compatible = "arm,pl061", "arm,primecell";
 			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			reg = <0xfff31000 0x1000>;
 			interrupts = <0 15 4>;
 		};
@@ -145,6 +148,8 @@
 			#gpio-cells = <2>;
 			compatible = "arm,pl061", "arm,primecell";
 			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			reg = <0xfff32000 0x1000>;
 			interrupts = <0 16 4>;
 		};
@@ -153,6 +158,8 @@
 			#gpio-cells = <2>;
 			compatible = "arm,pl061", "arm,primecell";
 			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			reg = <0xfff33000 0x1000>;
 			interrupts = <0 17 4>;
 		};
-- 
1.7.5.4
