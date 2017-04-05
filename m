From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Wed,  5 Apr 2017 16:06:11 +0200
Subject: [PATCH 2/3] ARM: dts: rockchip: rock2: Setup usb vbus-supply
In-Reply-To: <20170405140613.4444-1-sjoerd.simons@collabora.co.uk>
References: <20170405140613.4444-1-sjoerd.simons@collabora.co.uk>
Message-ID: <20170405140613.4444-3-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the rockchip usb phy has a vbus-supply property use that to
control the vbus regulator on rock2.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---

 arch/arm/boot/dts/rk3288-rock2-square.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rk3288-rock2-square.dts
index a23a94811be8..8ed25e9f60bc 100644
--- a/arch/arm/boot/dts/rk3288-rock2-square.dts
+++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
@@ -125,10 +125,6 @@
 		gpio = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&host_vbus_drv>;
-		/* Always on as the rockchip usb phy doesn't have a vbus-supply
-		 * property
-		 */
-		regulator-always-on;
 		regulator-name = "vcc_host";
 	};
 
@@ -279,6 +275,10 @@
 	status = "okay";
 };
 
+&usbphy1 {
+	vbus-supply = <&vcc_usb_host>;
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
-- 
2.11.0
