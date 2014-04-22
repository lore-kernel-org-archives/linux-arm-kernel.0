From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 22 Apr 2014 13:01:28 +0200
Subject: [PATCH v8 08/17] ARM: dts: sun5i: Add pin-muxing info for the mmc
 controllers
In-Reply-To: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1398164497-14212-9-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds  pin-muxing info for the mmc controller / port combinations which
are known to be used on actual boards.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi  |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 12113f9..fb345c2 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -478,6 +478,20 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			mmc0_pins_a: mmc0 at 0 {
+				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
+				allwinner,function = "mmc0";
+				allwinner,drive = <2>;
+				allwinner,pull = <0>;
+			};
+
+			mmc1_pins_a: mmc1 at 0 {
+				allwinner,pins = "PG3","PG4","PG5","PG6","PG7","PG8";
+				allwinner,function = "mmc1";
+				allwinner,drive = <2>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		timer at 01c20c00 {
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index a0e55e8..48ffa51 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -433,6 +433,13 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			mmc0_pins_a: mmc0 at 0 {
+				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
+				allwinner,function = "mmc0";
+				allwinner,drive = <2>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
1.9.0
