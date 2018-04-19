From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 19 Apr 2018 16:59:55 +0200
Subject: [PATCH 2/3] ARM: dts: stm32: add supplies to usbphyc ports on
 stm32mp157c-ed1
In-Reply-To: <1524149996-27809-1-git-send-email-amelie.delaunay@st.com>
References: <1524149996-27809-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1524149996-27809-3-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USBPHYC ports require 3 supplies: 3v3, 1v1 and 1v8.
This patch adds the corresponding properties on stm32mp157c-ed1 board.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 9f90337a..78b2686 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -30,3 +30,15 @@
 	pinctrl-0 = <&uart4_pins_a>;
 	status = "okay";
 };
+
+&usbphyc_port0 {
+	phy-supply = <&vdd_usb>;
+	vdda1v1-supply = <&reg11>;
+	vdda1v8-supply = <&reg18>;
+};
+
+&usbphyc_port1 {
+	phy-supply = <&vdd_usb>;
+	vdda1v1-supply = <&reg11>;
+	vdda1v8-supply = <&reg18>;
+};
-- 
2.7.4
