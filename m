From: frank.wang@rock-chips.com (Frank Wang)
Date: Wed,  5 Jul 2017 16:30:18 +0800
Subject: [PATCH v2 3/6] ARM: dts: rockchip: enable io-domain for rk3229-evb
In-Reply-To: <1499243421-21460-1-git-send-email-frank.wang@rock-chips.com>
References: <1499243421-21460-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1499243421-21460-4-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Wu <david.wu@rock-chips.com>

This patch enables io-domain support for rk3229-evb board.

The power domain of VCCIO3 is selected from maskrom, so we do not
need to configure it.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk3229-evb.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rk3229-evb.dts b/arch/arm/boot/dts/rk3229-evb.dts
index 17385d8..78a3ea1 100644
--- a/arch/arm/boot/dts/rk3229-evb.dts
+++ b/arch/arm/boot/dts/rk3229-evb.dts
@@ -161,6 +161,14 @@
 	status = "okay";
 };
 
+&io_domains {
+	status = "okay";
+
+	vccio1-supply = <&vccio_3v3>;
+	vccio2-supply = <&vccio_1v8>;
+	vccio4-supply = <&vccio_3v3>;
+};
+
 &pinctrl {
 	usb {
 		host_vbus_drv: host-vbus-drv {
-- 
2.0.0
