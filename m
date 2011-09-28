From: tony@atomide.com (Tony Lindgren)
Date: Wed, 28 Sep 2011 14:48:21 -0700
Subject: [PATCH 3/4] ARM: OMAP4: Keyboard: Fix section mismatch in the board
	file
In-Reply-To: <20110928214707.29263.58095.stgit@kaulin.local>
References: <20110928214707.29263.58095.stgit@kaulin.local>
Message-ID: <20110928214821.29263.29309.stgit@kaulin.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjarne Steinsbo <bsteinsbo@gmail.com>

`keypad_pads' is referred to by `keypad_data' which is
not __initdata, so `keypad_pads' should not be __initdata either.

Signed-off-by: Bjarne Steinsbo <bsteinsbo@gmail.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index c7cef44..9e423ac 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -129,7 +129,7 @@ static const int sdp4430_keymap[] = {
 	KEY(7, 6, KEY_OK),
 	KEY(7, 7, KEY_DOWN),
 };
-static struct omap_device_pad keypad_pads[] __initdata = {
+static struct omap_device_pad keypad_pads[] = {
 	{	.name   = "kpd_col1.kpd_col1",
 		.enable = OMAP_WAKEUP_EN | OMAP_MUX_MODE1,
 	},
