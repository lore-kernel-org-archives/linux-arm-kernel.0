From: vagrantc@aikidev.net (Vagrant Cascadian)
Date: Mon, 29 Aug 2016 08:18:13 -0700
Subject: [PATCH] ARM: dts: rockchip: temporarily remove emmc hs200 speed from
 rk3288-veyron-speedy.
Message-ID: <87inujbo3u.fsf@aikidev.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This essentially mimics what was done with rk3288-veyron-minnie in
commit 984926781122f034d5bc9962815d135b6c4a8e1d.

The eMMC of the speedy Chromebook also appears to need the same tuning
workaround, as it frequently fails to recognize the eMMC without it.

---
 arch/arm/boot/dts/rk3288-veyron-speedy.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-speedy.dts b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
index a0d033f..500fd18 100644
--- a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
@@ -124,6 +124,11 @@
 			&sdmmc_bus4>;
 };
 
+
+&emmc {
+       /delete-property/mmc-hs200-1_8v;
+};
+
 &vcc_5v {
 	enable-active-high;
 	gpio = <&gpio7 21 GPIO_ACTIVE_HIGH>;
-- 
2.9.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160829/2b89593f/attachment.sig>
