From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sat, 17 Mar 2018 16:47:50 +0100
Subject: ARM: dts: armada-385-linksys: Disable internal RTC
Message-ID: <20180317154750.32560-1-hauke@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The internal RTC does not work correctly on these Linksys boards based
on Marvell SoCs. For me it only shows Wed Dec 31 23:59:59 1969 and for
others it is off by 3 minutes in 10 minutes running, this was reported
by multiple users. On the Linksys Mamba device the device tree comment
says that no crystal is connected to the internal RTC, this is probably
also true for the other devices.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/arm/boot/dts/armada-385-linksys.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index 434dc9aaa5e4..b7bbf15571c5 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -282,3 +282,8 @@
 	status = "okay";
 	usb-phy = <&usb3_1_phy>;
 };
+
+&rtc {
+	/* No crystal connected to the internal RTC */
+	status = "disabled";
+};
-- 
2.11.0
