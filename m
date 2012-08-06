From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Aug 2012 11:46:39 +0100
Subject: [PATCH 3/6] ARM: ux500: Force AB8500 to use the GIC as its interrupt
 controller
In-Reply-To: <1344250002-6011-1-git-send-email-lee.jones@linaro.org>
References: <1344250002-6011-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1344250002-6011-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's understood that the AB8500 should be subordinate to the DB8500;
however, the AB8500 uses the GIC as it's interrupt controller. If
we do not specify which IRQ controller to use the default is to use
the next encountered IRQ controller as we climb the tree. This would
be the DB8500. This patch ensures the AB8500 makes use of the correct
interrupt controller.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index f236bb7..83229f7 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -313,6 +313,7 @@
 			ab8500 at 5 {
 				compatible = "stericsson,ab8500";
 				reg = <5>; /* mailbox 5 is i2c */
+				interrupt-parent = <&intc>;
 				interrupts = <0 40 0x4>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-- 
1.7.9.5
