From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 20 May 2018 19:23:52 +0200
Subject: [PATCH 1/2] ARM: dts: meson: build the Meson8b .dtbs with MACH_MESON8
In-Reply-To: <20180520172353.19256-1-martin.blumenstingl@googlemail.com>
References: <20180520172353.19256-1-martin.blumenstingl@googlemail.com>
Message-ID: <20180520172353.19256-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently there are two identical Kconfig options where only differences
are the Kconfig help text and the list of .dtbs that are built:
- MACH_MESON8
- MACH_MESON8B

Build the Meson8b .dtbs when MACH_MESON8 is selected to get rid of the
latter Kconfig symbol later.

Suggested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4300e86049ee..b7f0b55e0dc5 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -313,14 +313,13 @@ dtb-$(CONFIG_MACH_MESON6) += \
 	meson6-atv1200.dtb
 dtb-$(CONFIG_MACH_MESON8) += \
 	meson8-minix-neo-x8.dtb \
+	meson8b-mxq.dtb \
+	meson8b-odroidc1.dtb \
 	meson8m2-mxiii-plus.dtb
 dtb-$(CONFIG_ARCH_MMP) += \
 	pxa168-aspenite.dtb \
 	pxa910-dkb.dtb \
 	mmp2-brownstone.dtb
-dtb-$(CONFIG_MACH_MESON8B) += \
-	meson8b-mxq.dtb \
-	meson8b-odroidc1.dtb
 dtb-$(CONFIG_ARCH_MPS2) += \
 	mps2-an385.dtb \
 	mps2-an399.dtb
-- 
2.17.0
