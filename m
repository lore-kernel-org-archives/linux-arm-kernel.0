From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 22 Apr 2014 13:01:32 +0200
Subject: [PATCH v8 12/17] ARM: dts: sun6i: Add pin-muxing info for the mmc
 controllers
In-Reply-To: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1398164497-14212-13-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds  pin-muxing info for the mmc controller / port combinations which
are known to be used on actual boards.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index a27afc8..0939fc1 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -370,6 +370,13 @@
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
