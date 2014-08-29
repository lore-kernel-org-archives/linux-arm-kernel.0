From: pramod.gurav@smartplayin.com (Pramod Gurav)
Date: Fri, 29 Aug 2014 20:00:56 +0530
Subject: [PATCH v3 1/4] ARM: DT: APQ8064: Add pinctrl support
In-Reply-To: <1409322659-17693-1-git-send-email-pramod.gurav@smartplayin.com>
References: <1409322659-17693-1-git-send-email-pramod.gurav@smartplayin.com>
Message-ID: <1409322659-17693-2-git-send-email-pramod.gurav@smartplayin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree nodes to support pinctrl for apq8064 SOC

CC: Rob Herring <robh+dt@kernel.org>
CC: Pawel Moll <pawel.moll@arm.com>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
CC: Kumar Gala <galak@codeaurora.org>
CC: devicetree at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org

Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index d66fb25..e23303e 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -73,6 +73,17 @@
 		ranges;
 		compatible = "simple-bus";
 
+		tlmm_pinmux: pinctrl at 800000 {
+			compatible = "qcom,apq8064-pinctrl";
+			reg = <0x800000 0x4000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <0 16 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		intc: interrupt-controller at 2000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
-- 
1.7.0.4
