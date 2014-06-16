From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 16 Jun 2014 20:24:29 +0200
Subject: [PATCH 2/2] ARM: dts: sunxi: Adjust touchscreen compatible for sun5i
 and later
In-Reply-To: <1402943069-19420-1-git-send-email-hdegoede@redhat.com>
References: <1402943069-19420-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1402943069-19420-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The touchscreen controller in the A13 and later has a different temperature
resulution compated to the one in the original A10, change the compatible
for the A13 and later so that the kernel will use the correct resolution.

Reported-by: Tong Zhang <lovewilliam@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi  | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 6835b88..25549c1 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -519,7 +519,7 @@
 		};
 
 		rtp: rtp at 01c25000 {
-			compatible = "allwinner,sun4i-a10-ts";
+			compatible = "allwinner,sun5i-a13-ts";
 			reg = <0x01c25000 0x100>;
 			interrupts = <29>;
 		};
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 206b6f8..be28b3b 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -467,7 +467,7 @@
 		};
 
 		rtp: rtp at 01c25000 {
-			compatible = "allwinner,sun4i-a10-ts";
+			compatible = "allwinner,sun5i-a13-ts";
 			reg = <0x01c25000 0x100>;
 			interrupts = <29>;
 		};
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 8029a75..87c7d33 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -823,7 +823,7 @@
 		};
 
 		rtp: rtp at 01c25000 {
-			compatible = "allwinner,sun4i-a10-ts";
+			compatible = "allwinner,sun5i-a13-ts";
 			reg = <0x01c25000 0x100>;
 			interrupts = <0 29 4>;
 		};
-- 
2.0.0
