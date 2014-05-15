From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 May 2014 20:32:10 +0900
Subject: [PATCH v6 15/17] ARM: shmobile: Let Marzen multiplatform boot with
 Marzen DTB
In-Reply-To: <1400153532-23675-1-git-send-email-horms+renesas@verge.net.au>
References: <1400153532-23675-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1400153532-23675-16-git-send-email-horms+renesas@verge.net.au>
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
index 0d05589..840a922 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -316,7 +316,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r8a7791-henninger.dtb \
 	r8a7791-koelsch.dtb \
 	r8a7790-lager.dtb \
-	r8a7779-marzen-reference.dtb
+	r8a7779-marzen.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
 	socfpga_cyclone5_socdk.dtb \
 	socfpga_cyclone5_sockit.dtb \
diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index d09e850..21c8cee 100644
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
1.8.5.2
