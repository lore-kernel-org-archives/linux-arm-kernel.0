From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:18:16 +0900
Subject: [PATCH 10/12] ARM: shmobile: Let Lager multiplatform boot with Lager
 DTB
In-Reply-To: <cover.1387891831.git.horms+renesas@verge.net.au>
References: <cover.1387891831.git.horms+renesas@verge.net.au>
Message-ID: <1fb68146d5fa7656f48bc5caaa74312b7fc7257e.1387891831.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Let the multiplatform Lager support boot with the legacy DTS for Lager
as well as the Lager reference DTS.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile                     | 2 +-
 arch/arm/mach-shmobile/board-lager-reference.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 37aefa2..f28b4ef 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -234,7 +234,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r7s72100-genmai-reference.dtb \
-	r8a7790-lager-reference.dtb \
+	r8a7790-lager.dtb \
 	r8a7791-koelsch-reference.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
 	socfpga_cyclone5_socdk.dtb \
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 7e3fe37..a6e271d 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -64,6 +64,7 @@ static void __init lager_add_standard_devices(void)
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {
+	"renesas,lager",
 	"renesas,lager-reference",
 	NULL,
 };
-- 
1.8.4
