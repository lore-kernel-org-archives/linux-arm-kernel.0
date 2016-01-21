From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Thu, 21 Jan 2016 17:01:45 +0800
Subject: [PATCH] ARM: zx296702-ad1: remove deprecated supports-highspeed
Message-ID: <1453366905-3964-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

supports-highspeed property is deprecated for dw_mmc,
this patch replace it with cap-sd-highspeed and cap-mmc-highspeed.

Cc: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 arch/arm/boot/dts/zx296702-ad1.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zx296702-ad1.dts b/arch/arm/boot/dts/zx296702-ad1.dts
index 081f980..bfbcd805d 100644
--- a/arch/arm/boot/dts/zx296702-ad1.dts
+++ b/arch/arm/boot/dts/zx296702-ad1.dts
@@ -19,7 +19,8 @@
 
 &mmc0 {
 	num-slots = <1>;
-	supports-highspeed;
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
 	non-removable;
 	disable-wp;
 	status = "okay";
@@ -32,7 +33,8 @@
 
 &mmc1 {
 	num-slots = <1>;
-	supports-highspeed;
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
 	non-removable;
 	disable-wp;
 	status = "okay";
-- 
2.3.7
