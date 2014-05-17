From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 17 May 2014 21:11:20 +0800
Subject: [PATCH] ARM: sunxi: dt: build DTs according to new MACH_SUNxI Kconfig
 symbols
Message-ID: <1400332280-5398-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner sunxi support has been split into the various SoCs in Kconfig.
Adapt the new symbols for the device trees.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Hi,

This patch lets us build the DTBs according to the SoCs we selected in
kernel config. This matches the build behavior of the kernel itself
after splitting up sunxi support to various SoCs in Kconfig.

Maxime, could you take this?


Cheers
ChenYu

---
 arch/arm/boot/dts/Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 1d9c50d..9db0b9d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -332,21 +332,24 @@ dtb-$(CONFIG_ARCH_STI)+= stih415-b2000.dtb \
 	stih416-b2000.dtb \
 	stih415-b2020.dtb \
 	stih416-b2020.dtb
-dtb-$(CONFIG_ARCH_SUNXI) += \
+dtb-$(CONFIG_MACH_SUN4I) += \
 	sun4i-a10-a1000.dtb \
 	sun4i-a10-cubieboard.dtb \
 	sun4i-a10-mini-xplus.dtb \
 	sun4i-a10-hackberry.dtb \
 	sun4i-a10-inet97fv2.dtb \
 	sun4i-a10-olinuxino-lime.dtb \
-	sun4i-a10-pcduino.dtb \
+	sun4i-a10-pcduino.dtb
+dtb-$(CONFIG_MACH_SUN5I) += \
 	sun5i-a10s-olinuxino-micro.dtb \
 	sun5i-a10s-r7-tv-dongle.dtb \
 	sun5i-a13-olinuxino.dtb \
-	sun5i-a13-olinuxino-micro.dtb \
+	sun5i-a13-olinuxino-micro.dtb
+dtb-$(CONFIG_MACH_SUN6I) += \
 	sun6i-a31-app4-evb1.dtb \
 	sun6i-a31-colombus.dtb \
-	sun6i-a31-m9.dtb \
+	sun6i-a31-m9.dtb
+dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-cubieboard2.dtb \
 	sun7i-a20-cubietruck.dtb \
 	sun7i-a20-olinuxino-micro.dtb
-- 
2.0.0.rc2
