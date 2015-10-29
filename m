From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Thu, 29 Oct 2015 21:44:57 +0100
Subject: [PATCH] ARM: dts: rockchip: Setup ethernet0 alias for u-boot
Message-ID: <1446151497-29833-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an ethernet0 alias for the wired network card and an all 0 default
mac address so that u-boot can find the device-node and fill in the
mac address.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---

 arch/arm/boot/dts/rk3288-rock2-square.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rk3288-rock2-square.dts
index 0ef065d..a029ebf 100644
--- a/arch/arm/boot/dts/rk3288-rock2-square.dts
+++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
@@ -45,6 +45,10 @@
 	model = "Radxa Rock 2 Square";
 	compatible = "radxa,rock2-square", "rockchip,rk3288";
 
+	aliases {
+		ethernet0 = &gmac;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
@@ -130,6 +134,8 @@
 };
 
 &gmac {
+	/* To be filled in by U-Boot */
+	mac-address = [00 00 00 00 00 00];
 	status = "ok";
 };
 
-- 
2.6.2
