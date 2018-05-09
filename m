From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Wed, 9 May 2018 17:18:14 +0200
Subject: [PATCH 2/2] ARM: dts: stm32: update rtc st,
 syscfg property on stm32f746
In-Reply-To: <1525879094-19562-1-git-send-email-amelie.delaunay@st.com>
References: <1525879094-19562-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1525879094-19562-3-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To fit with latest rtc driver updates, rtc st,syscfg property must contain
the control register offset of pwrcfg and the mask corresponding to the
DBP (Disable Backup Protection) bit.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32f746.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index 1479e3e..f48d06a 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -297,7 +297,7 @@
 			interrupt-parent = <&exti>;
 			interrupts = <17 1>;
 			interrupt-names = "alarm";
-			st,syscfg = <&pwrcfg>;
+			st,syscfg = <&pwrcfg 0x00 0x100>;
 			status = "disabled";
 		};
 
-- 
2.7.4
