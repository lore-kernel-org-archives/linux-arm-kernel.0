From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sun, 22 Jan 2017 23:43:47 -0800
Subject: [PATCH] ARM: tegra: paz00: fix __initdata placement
Message-ID: <20170123074347.GA29804@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To have expected effect the __initdata attribute should go after variable
name and before initializer.`

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-tegra/board-paz00.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 7478f6fb3664..ea6bff404161 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -23,7 +23,7 @@
 
 #include "board.h"
 
-static struct property_entry __initdata wifi_rfkill_prop[] = {
+static struct property_entry wifi_rfkill_prop[] __initdata = {
 	PROPERTY_ENTRY_STRING("name", "wifi_rfkill"),
 	PROPERTY_ENTRY_STRING("type", "wlan"),
 	{ },
-- 
2.11.0.483.g087da7b7c-goog


-- 
Dmitry
