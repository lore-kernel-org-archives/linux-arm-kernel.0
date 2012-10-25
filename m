From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Oct 2012 10:57:09 +0100
Subject: [PATCH 6/8] ARM: ux500: Change the type of interrupt to something
 compatible
In-Reply-To: <1351159031-25391-1-git-send-email-lee.jones@linaro.org>
References: <1351159031-25391-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1351159031-25391-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On boot the Nomadik GPIO controller complains that an IRQ can't be
configured as active high level-sensitive, so this patch converts
it to be low-to-high edge triggered instead.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stuib.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stuib.dtsi b/arch/arm/boot/dts/stuib.dtsi
index 6c7e492..39446a2 100644
--- a/arch/arm/boot/dts/stuib.dtsi
+++ b/arch/arm/boot/dts/stuib.dtsi
@@ -15,7 +15,7 @@
 			stmpe1601: stmpe1601 at 40 {
 				compatible = "st,stmpe1601";
 				reg = <0x40>;
-				interrupts = <26 0x4>;
+				interrupts = <26 0x1>;
 				interrupt-parent = <&gpio6>;
 				interrupt-controller;
 
-- 
1.7.9.5
