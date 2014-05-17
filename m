From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 17 May 2014 10:24:53 +0900
Subject: [PATCH 4/5] ARM: shmobile: Let Genmai multiplatform boot with Genmai
 DTB
In-Reply-To: <cover.1400289483.git.horms+renesas@verge.net.au>
References: <cover.1400289483.git.horms+renesas@verge.net.au>
Message-ID: <23f679fa6de3b3f7e1d9e1d8eaeafa5167a55a17.1400289483.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Let the multiplatform Genmai support boot with the unified DTS.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile                      | 2 +-
 arch/arm/mach-shmobile/board-genmai-reference.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4ede75e..1329d4d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -320,7 +320,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	r8a73a4-ape6evm-reference.dtb \
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
-	r7s72100-genmai-reference.dtb \
+	r7s72100-genmai.dtb \
 	r8a7791-koelsch.dtb \
 	r8a7790-lager.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
diff --git a/arch/arm/mach-shmobile/board-genmai-reference.c b/arch/arm/mach-shmobile/board-genmai-reference.c
index 968bbba..2ff6ad6 100644
--- a/arch/arm/mach-shmobile/board-genmai-reference.c
+++ b/arch/arm/mach-shmobile/board-genmai-reference.c
@@ -42,7 +42,7 @@ static void __init genmai_add_standard_devices(void)
 }
 
 static const char * const genmai_boards_compat_dt[] __initconst = {
-	"renesas,genmai-reference",
+	"renesas,genmai",
 	NULL,
 };
 
-- 
1.8.4
