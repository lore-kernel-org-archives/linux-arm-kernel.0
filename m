From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:16:03 +0900
Subject: [PATCH 23/29] ARM: shmobile: r8a7778: Don't set plat_sci_port
 scbrr_algo_id field
In-Reply-To: <cover.1387888861.git.horms+renesas@verge.net.au>
References: <cover.1387888861.git.horms+renesas@verge.net.au>
Message-ID: <938ed60f7a0698a27f40369f3f89e0f07f570959.1387888861.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The field will be removed from the sh-sci driver. Don't set it and let
the driver handle baud rate calculation internally.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7778.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 3e583cd..6d69452 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -48,7 +48,6 @@
 static struct plat_sci_port scif##index##_platform_data = {	\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,	\
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,	\
-	.scbrr_algo_id	= SCBRR_ALGO_2,				\
 	.type		= PORT_SCIF,				\
 };								\
 								\
-- 
1.8.4
