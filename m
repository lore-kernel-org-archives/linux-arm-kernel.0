From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Mar 2014 18:00:00 +0900
Subject: [PATCH v4 17/19] ARM: shmobile: Let Marzen multiplatform boot with
 Marzen DTB
In-Reply-To: <1394701202-25823-1-git-send-email-horms+renesas@verge.net.au>
References: <1394701202-25823-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1394701202-25823-18-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the multiplatform Marzen support boot with the legacy DTS for
Marzen as well as the Marzen reference DTS.

Based on work for the Koelsch board by Laurent Pinchart.

Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile                      | 2 +-
 arch/arm/mach-shmobile/board-marzen-reference.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 69cd6b7..cbec54c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -262,7 +262,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r7s72100-genmai-reference.dtb \
 	r8a7791-koelsch.dtb \
 	r8a7790-lager.dtb \
-	r8a7779-marzen-reference.dtb
+	r8a7779-marzen.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
 	socfpga_cyclone5_socdk.dtb \
 	socfpga_cyclone5_sockit.dtb \
diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 5823c83..741a076 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -68,6 +68,7 @@ static void __init marzen_init(void)
 }
 
 static const char *marzen_boards_compat_dt[] __initdata = {
+	"renesas,marzen",
 	"renesas,marzen-reference",
 	NULL,
 };
-- 
1.8.5.2
