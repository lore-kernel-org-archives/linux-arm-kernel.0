From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Tue, 12 Jul 2011 22:02:09 +0530
Subject: [PATCH] OMAP4: 4430SDP: Keypad: Make keypad_data initdata
Message-ID: <1310488329-16139-1-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The keypad data is accessed only at init so making it initdata.
This removes the section mismatch warning.

Reported-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 47e6ab9..2b28c7e 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -195,7 +195,7 @@ static struct omap4_keypad_platform_data sdp4430_keypad_data = {
 	.cols			= 8,
 };
 
-static struct omap_board_data keypad_data = {
+static struct omap_board_data keypad_data __initdata = {
 	.id	    = 1,
 	.pads	 = keypad_pads,
 	.pads_cnt       = ARRAY_SIZE(keypad_pads),
-- 
1.7.1
