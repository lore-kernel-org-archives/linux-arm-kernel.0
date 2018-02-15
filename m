From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 15 Feb 2018 16:54:39 +0100
Subject: [PATCH 2/3] ARM: dts: stm32: select otg mode for usbotg_hs on
 stm32746g_eval
In-Reply-To: <1518710080-18164-1-git-send-email-amelie.delaunay@st.com>
References: <1518710080-18164-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1518710080-18164-3-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure USB OTG HS in OTG (DRD) mode on STM32746G_eval.
The USB connector used will determine the role of USB OTG controller.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32746g-eval.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
index 2d4e717..90a4056 100644
--- a/arch/arm/boot/dts/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -119,7 +119,7 @@
 };
 
 &usbotg_hs {
-	dr_mode = "host";
+	dr_mode = "otg";
 	phys = <&usbotg_hs_phy>;
 	phy-names = "usb2-phy";
 	pinctrl-0 = <&usbotg_hs_pins_a>;
-- 
2.7.4
