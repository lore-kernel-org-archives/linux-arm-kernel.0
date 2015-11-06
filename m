From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Fri,  6 Nov 2015 11:46:37 +0100
Subject: [PATCH v2] ARM: dts: rockchip: Setup ethernet0 alias for u-boot
Message-ID: <1446806797-20912-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an ethernet0 alias for the RK3288 mac interface so
that u-boot can find the device-node and fill in the mac address on
board that support a wired network interface.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

Changes in v2:
  - Move alias from a board specific dts to the general rk3288.dtsi
  - Don't define an all-zero mac-address property, u-boot will always
    add the local-mac-address property which linux also uses.

 arch/arm/boot/dts/rk3288.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index b905cf6..f7d4c6f 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -52,6 +52,7 @@
 	interrupt-parent = <&gic>;
 
 	aliases {
+		ethernet0 = &gmac;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
-- 
2.6.2
