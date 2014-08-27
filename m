From: pramod.gurav@smartplayin.com (Pramod Gurav)
Date: Wed, 27 Aug 2014 15:13:54 +0530
Subject: [PATCH 4/4] ARM: DT: APQ8064: Add node for ps_hold function in pinctrl
In-Reply-To: <1409132634-15208-1-git-send-email-pramod.gurav@smartplayin.com>
References: <1409132634-15208-1-git-send-email-pramod.gurav@smartplayin.com>
Message-ID: <1409132634-15208-2-git-send-email-pramod.gurav@smartplayin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DT support to configure GPIO_78 as function ps_hold
on apq8064.

CC: Rob Herring <robh+dt@kernel.org>
CC: Pawel Moll <pawel.moll@arm.com>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
CC: Kumar Gala <galak@codeaurora.org>
CC: devicetree at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org

Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 681e194..0873b24 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -82,6 +82,16 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			interrupts = <0 32 0x4>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&ps_hold>;
+
+			ps_hold: ps_hold {
+				mux {
+					pins = "gpio78";
+					function = "ps_hold";
+				};
+			};
 		};
 
 		intc: interrupt-controller at 2000000 {
-- 
1.7.9.5
