From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 18 Mar 2010 19:37:29 +0100
Subject: [PATCH] ARM: pxa/raumfeld: fix button name
Message-ID: <1268937449-5654-1-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a warning when booting 2.6.34-rc2:

[   26.619814] ------------[ cut here ]------------
[   26.624604] WARNING: at fs/proc/generic.c:316 __xlate_proc_name+0xac/0xc0()
[   26.631555] name 'on/off button'
[   26.634753] Modules linked in:

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Eric Miao <eric.miao@marvell.com>
Cc: Sven Neumann <s.neumann@raumfeld.com>
---
 arch/arm/mach-pxa/raumfeld.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 3184bdc..9bf86b6 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -444,7 +444,7 @@ static struct gpio_keys_button gpio_keys_button[] = {
 		.active_low		= 0,
 		.wakeup			= 0,
 		.debounce_interval	= 5, /* ms */
-		.desc			= "on/off button",
+		.desc			= "on_off button",
 	},
 };
 
-- 
1.6.6.2
