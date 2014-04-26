From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 26 Apr 2014 12:16:16 +0200
Subject: [PATCH v9 12/17] ARM: dts: sun6i: Add pin-muxing info for the mmc
 controllers
In-Reply-To: <1398507381-5614-1-git-send-email-hdegoede@redhat.com>
References: <1398507381-5614-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1398507381-5614-13-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds  pin-muxing info for the mmc controller / port combinations which
are known to be used on actual boards.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index fc6bce1..cf1e967 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -362,6 +362,13 @@
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
 
 		ahb1_rst: reset at 01c202c0 {
-- 
1.9.0
