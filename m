From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 18 Jun 2013 09:51:57 +0100
Subject: [PATCH 1/3] ARM: ux500: Provide a AB8500 GPIO Device Tree node
In-Reply-To: <1371545519-27119-1-git-send-email-lee.jones@linaro.org>
References: <1371545519-27119-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1371545519-27119-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we're adding a node for the AB8500 GPIO device. This will allow
other DT:ed components to obtain GPIOs for use within their drivers.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index a082f0b..a152945 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -360,6 +360,11 @@
 				interrupt-controller;
 				#interrupt-cells = <2>;
 
+				ab8500_gpio: ab8500-gpio {
+					gpio-controller;
+					#gpio-cells = <2>;
+				};
+
 				ab8500-rtc {
 					compatible = "stericsson,ab8500-rtc";
 					interrupts = <17 IRQ_TYPE_LEVEL_HIGH
-- 
1.8.1.2
