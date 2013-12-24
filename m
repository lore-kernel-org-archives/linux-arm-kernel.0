From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:16:07 +0900
Subject: [PATCH 27/29] ARM: shmobile: r8a7779: Don't set plat_sci_port
 scbrr_algo_id field
In-Reply-To: <cover.1387888861.git.horms+renesas@verge.net.au>
References: <cover.1387888861.git.horms+renesas@verge.net.au>
Message-ID: <0bb075cea8b527a1f33d965f6c891cea9261e9bf.1387888861.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The field will be removed from the sh-sci driver. Don't set it and let
the driver handle baud rate calculation internally.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 35c2268..339292e 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -193,7 +193,6 @@ void __init r8a7779_pinmux_init(void)
 static struct plat_sci_port scif##index##_platform_data = {	\
 	.type		= PORT_SCIF,				\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,	\
-	.scbrr_algo_id	= SCBRR_ALGO_2,				\
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,	\
 };								\
 								\
-- 
1.8.4
