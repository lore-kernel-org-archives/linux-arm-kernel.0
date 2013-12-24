From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:16:02 +0900
Subject: [PATCH 22/29] ARM: shmobile: r7s72100: Don't set plat_sci_port
 scbrr_algo_id field
In-Reply-To: <cover.1387888861.git.horms+renesas@verge.net.au>
References: <cover.1387888861.git.horms+renesas@verge.net.au>
Message-ID: <79fb5b4c6fc2222e5cf3899454b8c669a9f5c485.1387888861.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The field will be removed from the sh-sci driver. Don't set it and let
the driver handle baud rate calculation internally.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r7s72100.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
index 81b995b..9c0b3a9 100644
--- a/arch/arm/mach-shmobile/setup-r7s72100.c
+++ b/arch/arm/mach-shmobile/setup-r7s72100.c
@@ -33,7 +33,6 @@ static const struct plat_sci_port scif##index##_platform_data = {	\
 	.type		= PORT_SCIF,					\
 	.regtype	= SCIx_SH2_SCIF_FIFODATA_REGTYPE,		\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,		\
-	.scbrr_algo_id	= SCBRR_ALGO_2,					\
 	.scscr		= SCSCR_RIE | SCSCR_TIE | SCSCR_RE | SCSCR_TE |	\
 			  SCSCR_REIE,					\
 };									\
-- 
1.8.4
