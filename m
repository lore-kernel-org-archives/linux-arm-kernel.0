From: christianshewitt@gmail.com (Christian Hewitt)
Date: Tue,  4 Sep 2018 22:30:43 +0400
Subject: [PATCH] ARM64: dts: meson-gx: increase default shared CMA pool size
Message-ID: <1536085844-29328-1-git-send-email-christianshewitt@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Devices using the new V4L2 mem2mem vdec require a larger CMA pool. As
nearly all GX* devices are video/media focused and will use it, set a
larger (256MB) default value.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index b8dc4db..ef43922 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -44,7 +44,7 @@
 		linux,cma {
 			compatible = "shared-dma-pool";
 			reusable;
-			size = <0x0 0xbc00000>;
+			size = <0x0 0x10000000>;
 			alignment = <0x0 0x400000>;
 			linux,cma-default;
 		};
-- 
2.7.4
