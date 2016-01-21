From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Thu, 21 Jan 2016 19:16:51 +0800
Subject: [PATCH v2] ARM: zx296702-ad1: remove deprecated usage of mmc
Message-ID: <1453375011-548-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

supports-highspeed property and slot are deprecated for dw_mmc,
this patch remove slot node and replace supports-highspeed with
cap-sd-highspeed and cap-mmc-highspeed.

Cc: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- remove slot suggested by Jaehoon

 arch/arm/boot/dts/zx296702-ad1.dts | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/zx296702-ad1.dts b/arch/arm/boot/dts/zx296702-ad1.dts
index 081f980..c2ffa9d 100644
--- a/arch/arm/boot/dts/zx296702-ad1.dts
+++ b/arch/arm/boot/dts/zx296702-ad1.dts
@@ -19,28 +19,22 @@
 
 &mmc0 {
 	num-slots = <1>;
-	supports-highspeed;
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
 	non-removable;
 	disable-wp;
 	status = "okay";
-
-	slot at 0 {
-		reg = <0>;
-		bus-width = <4>;
-	};
 };
 
 &mmc1 {
 	num-slots = <1>;
-	supports-highspeed;
+	bus-width = <8>;
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
 	non-removable;
 	disable-wp;
 	status = "okay";
-
-	slot at 0 {
-		reg = <0>;
-		bus-width = <8>;
-	};
 };
 
 &uart0 {
-- 
2.3.7
