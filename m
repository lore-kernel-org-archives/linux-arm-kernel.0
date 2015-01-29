From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 29 Jan 2015 14:08:19 +0100
Subject: [PATCH 9/9] dts: versatile: Add sysregs node
In-Reply-To: <1422536899-16609-1-git-send-email-daniel.lezcano@linaro.org>
References: <54CA3044.6070501@linaro.org>
 <1422536899-16609-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1422536899-16609-9-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

The Versatile boards have the same sysregs as other ARM Ltd boards. Add
the nodes in order to enable support for 24MHz counter as sched_clock.

This is a minimal node definition as the existing sub node definition
used on VExpress has some issues raised by Linus W.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: devicetree at vger.kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/boot/dts/versatile-ab.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index 27d0d9c..01f4019 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -252,6 +252,11 @@
 			#size-cells = <1>;
 			ranges = <0 0x10000000 0x10000>;
 
+			sysreg at 0 {
+				compatible = "arm,versatile-sysreg", "syscon";
+				reg = <0x00000 0x1000>;
+			};
+
 			aaci at 4000 {
 				compatible = "arm,primecell";
 				reg = <0x4000 0x1000>;
-- 
1.9.1
