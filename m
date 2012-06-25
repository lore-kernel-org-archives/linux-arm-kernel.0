From: svenkatr@ti.com (Venkatraman S)
Date: Mon, 25 Jun 2012 15:56:40 +0530
Subject: [PATCH 2/2] ARM: OMAP2+: use proper type for keymap data in
 boardfiles.
In-Reply-To: <1340620000-27074-1-git-send-email-svenkatr@ti.com>
References: <1340620000-27074-1-git-send-email-svenkatr@ti.com>
Message-ID: <1340620000-27074-2-git-send-email-svenkatr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the sparse warnings...
arch/arm/mach-omap2/board-igep0020.c:482:14:
 warning: incorrect type in initializer (different signedness)
arch/arm/mach-omap2/board-4430sdp.c:200:14:
 warning: incorrect type in initializer (different signedness)

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c  |    2 +-
 arch/arm/mach-omap2/board-igep0020.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 8e17284..af7be39 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -64,7 +64,7 @@
 #define GPIO_WIFI_PMENA		54
 #define GPIO_WIFI_IRQ		53
 
-static const int sdp4430_keymap[] = {
+static const uint32_t sdp4430_keymap[] = {
 	KEY(0, 0, KEY_E),
 	KEY(0, 1, KEY_R),
 	KEY(0, 2, KEY_T),
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 7491529..c138944 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -459,7 +459,7 @@ static struct platform_device *igep_devices[] __initdata = {
 	&igep_vwlan_device,
 };
 
-static int igep2_keymap[] = {
+static const uint32_t igep2_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
 	KEY(0, 2, KEY_A),
-- 
1.7.0.4
