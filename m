From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 08 Feb 2012 16:39:30 +0000
Subject: [PATCH 11/16] ARM: omap: fix section mismatch error for
 omap_4430sdp_display_init()
In-Reply-To: <20120208163546.GA15849@n2100.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Message-ID: <E1RvAYM-0006HW-IG@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xb798): Section mismatch in reference from the function omap_4430sdp_display_init() to the function .init.text:omap_display_init()
The function omap_4430sdp_display_init() references
the function __init omap_display_init().
This is often because omap_4430sdp_display_init lacks a __init
annotation or the annotation of omap_display_init is wrong.

Fix this by adding __init to omap_4430sdp_display_init().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/board-4430sdp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 49a5aab..3d820bb 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -808,7 +808,7 @@ static struct omap_dss_board_info sdp4430_dss_data = {
 	.default_device	= &sdp4430_lcd_device,
 };
 
-static void omap_4430sdp_display_init(void)
+static void __init omap_4430sdp_display_init(void)
 {
 	int r;
 
-- 
1.7.4.4
