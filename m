From: dmurphy@ti.com (Dan Murphy)
Date: Wed, 2 Oct 2013 12:58:33 -0500
Subject: [PATCH] ARM: dts: AM33XX: add ethernet alias's for am33xx
Message-ID: <1380736713-24678-1-git-send-email-dmurphy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the alias for ethernet0 and ethernet1 so that uBoot
can set the MAC address appropriately.

Currently uBoot cannot find the alias and there for does not set the
MAC address.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 553adc6..8aabaa0 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -30,6 +30,8 @@
 		usb1 = &usb1;
 		phy0 = &usb0_phy;
 		phy1 = &usb1_phy;
+		ethernet0 = &cpsw_emac0;
+		ethernet1 = &cpsw_emac1;
 	};
 
 	cpus {
-- 
1.7.9.5
