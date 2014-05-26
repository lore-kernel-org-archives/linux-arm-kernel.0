From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 26 May 2014 09:48:05 +0200
Subject: [PATCH 10/11] ARM: dts: sun7i: Add #interrupt-cells to pinctrl node
In-Reply-To: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1401090486-4414-11-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen-Yu Tsai <wens@csie.org>

The pinctrl device is also an interrupt controller for external
interrupts. Add the missing #interrupt-cells property.

Also remove the unused #address-cells property.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index b82642c..19b1ced 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -594,7 +594,7 @@
 			clocks = <&apb0_gates 5>;
 			gpio-controller;
 			interrupt-controller;
-			#address-cells = <1>;
+			#interrupt-cells = <2>;
 			#size-cells = <0>;
 			#gpio-cells = <3>;
 
-- 
1.9.3
