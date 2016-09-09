From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri,  9 Sep 2016 10:01:07 -0400
Subject: [PATCH 6/8] ARM: dts: rockchip: Add missing unit name to memory nodes
 in rk322x boards
In-Reply-To: <1473429669-6185-1-git-send-email-javier@osg.samsung.com>
References: <1473429669-6185-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1473429669-6185-7-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following DTC warnings:

"Node /memory has a reg or ranges property, but no unit name"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/rk3228-evb.dts | 2 +-
 arch/arm/boot/dts/rk3229-evb.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3228-evb.dts b/arch/arm/boot/dts/rk3228-evb.dts
index 904668e2e666..58834330a5ba 100644
--- a/arch/arm/boot/dts/rk3228-evb.dts
+++ b/arch/arm/boot/dts/rk3228-evb.dts
@@ -46,7 +46,7 @@
 	model = "Rockchip RK3228 Evaluation board";
 	compatible = "rockchip,rk3228-evb", "rockchip,rk3228";
 
-	memory {
+	memory at 60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/rk3229-evb.dts b/arch/arm/boot/dts/rk3229-evb.dts
index b6a12035a6bb..dcdd0cee619e 100644
--- a/arch/arm/boot/dts/rk3229-evb.dts
+++ b/arch/arm/boot/dts/rk3229-evb.dts
@@ -46,7 +46,7 @@
 	model = "Rockchip RK3229 Evaluation board";
 	compatible = "rockchip,rk3229-evb", "rockchip,rk3229";
 
-	memory {
+	memory at 60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x40000000>;
 	};
-- 
2.7.4
