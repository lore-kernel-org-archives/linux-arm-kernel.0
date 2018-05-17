From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 17 May 2018 17:47:32 +0200
Subject: [PATCH 2/2] ARM: dts: stm32: enable USB OTG HS on stm32mp157c-ev1
In-Reply-To: <1526572052-17155-1-git-send-email-amelie.delaunay@st.com>
References: <1526572052-17155-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1526572052-17155-3-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables USB OTG HS on stm32mp157c-ev1 in Peripheral mode.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 9382d80..5a0b77e 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -103,6 +103,13 @@
 	};
 };
 
+&usbotg_hs {
+	dr_mode = "peripheral";
+	phys = <&usbphyc_port1 0>;
+	phy-names = "usb2-phy";
+	status = "okay";
+};
+
 &usbphyc {
 	status = "okay";
 };
-- 
2.7.4
