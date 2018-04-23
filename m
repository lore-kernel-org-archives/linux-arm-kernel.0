From: tony@atomide.com (Tony Lindgren)
Date: Mon, 23 Apr 2018 10:45:47 -0700
Subject: [PATCH 14/16] bus: ti-sysc: Detect UARTs for SYSC_QUIRK_LEGACY_IDLE
 quirk on omap4
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
Message-ID: <20180423174549.57412-15-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Starting with omap4, UARTs have different revision register that we need to
detect to enable SYSC_QUIRK_LEGACY_IDLE. Otherwise UARTs won't idle properly.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -880,6 +880,9 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 		   SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000052, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
+	/* Uarts on omap4 and later */
+	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x50411e03, 0xffffffff,
+		   SYSC_QUIRK_LEGACY_IDLE),
 };
 
 static void sysc_init_revision_quirks(struct sysc *ddata)
-- 
2.17.0
