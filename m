From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 26 Nov 2013 16:32:18 +0900
Subject: [PATCH RFC v2 16/17] ARM: shmobile: Let Marzen multiplatform boot
 with Marzen DTB
In-Reply-To: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
References: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1385451139-29686-17-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the multiplatform Marzen support boot with the legacy DTS for
Marzen as well as the Marzen reference DTS.

Based on work for the Koelsch board by Laurent Pinchart.

Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* Remove spurious change to board-koelsch-reference.c
---
 arch/arm/boot/dts/Makefile                      | 2 +-
 arch/arm/mach-shmobile/board-marzen-reference.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 166e3dd..2812344 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -216,7 +216,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r7s72100-genmai-reference.dtb \
-	r8a7779-marzen-reference.dtb \
+	r8a7779-marzen.dtb \
 	r8a7791-koelsch-reference.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb \
 	socfpga_vt.dtb
diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 1a2fac1..476fd7e 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -73,6 +73,7 @@ static void __init marzen_init(void)
 }
 
 static const char *marzen_boards_compat_dt[] __initdata = {
+	"renesas,marzen",
 	"renesas,marzen-reference",
 	NULL,
 };
-- 
1.8.4
