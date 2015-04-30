From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 30 Apr 2015 14:30:47 +0100
Subject: [PATCH v3 1/6] ARM: DT: STi: STiH407: Update picophyreset for the
 usb3 controllers usb2 phy
In-Reply-To: <1430400652-3366-1-git-send-email-peter.griffin@linaro.org>
References: <1430400652-3366-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1430400652-3366-2-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ths picophyreset is incorrectly defined, which stops the usb2 phy being
taken out of reset.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index c06a546..186412d 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -280,7 +280,7 @@
 			#phy-cells = <0>;
 			st,syscfg = <&syscfg_core 0x100 0xf4>;
 			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
-				 <&picophyreset STIH407_PICOPHY0_RESET>;
+				 <&picophyreset STIH407_PICOPHY2_RESET>;
 			reset-names = "global", "port";
 		};
 
-- 
1.9.1
