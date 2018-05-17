From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 17 May 2018 16:36:52 +0200
Subject: [PATCH] ARM: dts: stm32: enable USB Host (USBH) EHCI controller on
 stm32mp157c-ev1
Message-ID: <1526567812-6458-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables USB Host (USBH) EHCI controller on stm32mp157c-ev1.
As a hub is used between USBH and USB connectors, no need to enable
USBH OHCI controller: all low- and full-speed traffic is managed by the
hub.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 9382d80..933036b 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -103,6 +103,12 @@
 	};
 };
 
+&usbh_ehci {
+	phys = <&usbphyc_port0>;
+	phy-names = "usb";
+	status = "okay";
+};
+
 &usbphyc {
 	status = "okay";
 };
-- 
2.7.4
