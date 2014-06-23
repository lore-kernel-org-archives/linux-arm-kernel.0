From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:26:25 +0900
Subject: [PATCH 12/24] ARM: shmobile: Let Marzen multiplatform boot with
 Marzen DTB
In-Reply-To: <cover.1403487423.git.horms+renesas@verge.net.au>
References: <cover.1403487423.git.horms+renesas@verge.net.au>
Message-ID: <04d3e8a0b150f1931d48ed9168672a971fc4c761.1403487423.git.horms+renesas@verge.net.au>
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
index e666d13..4ebc4ca 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -339,7 +339,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r8a7791-henninger.dtb \
 	r8a7791-koelsch.dtb \
 	r8a7790-lager.dtb \
-	r8a7779-marzen-reference.dtb
+	r8a7779-marzen.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
 	socfpga_cyclone5_socdk.dtb \
 	socfpga_cyclone5_sockit.dtb \
diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 3017040..46936ff 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -66,6 +66,7 @@ static void __init marzen_init(void)
 }
 
 static const char *marzen_boards_compat_dt[] __initdata = {
+	"renesas,marzen",
 	"renesas,marzen-reference",
 	NULL,
 };
-- 
2.0.0.rc2
