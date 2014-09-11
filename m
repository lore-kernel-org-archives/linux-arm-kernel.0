From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 11 Sep 2014 09:57:23 +0900
Subject: [PATCH 1/5] ARM: shmobile: mackerel: Make domain_devices[] static
 __initdata
In-Reply-To: <cover.1410395620.git.horms+renesas@verge.net.au>
References: <cover.1410395620.git.horms+renesas@verge.net.au>
Message-ID: <d6dc6ed8540ab8802c6ba31b4292204dd3cb0fee.1410395620.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Make the domain_devices[] array static and __initdata, to reduce kernel
size:
  - Making it static gets rid of the code to copy the data to the stack,
  - Marking it __initdata allows more init memory to be freed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 79f448e..d47b262 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1420,7 +1420,7 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 #define USCCR1		IOMEM(0xE6058144)
 static void __init mackerel_init(void)
 {
-	struct pm_domain_device domain_devices[] = {
+	static struct pm_domain_device domain_devices[] __initdata = {
 		{ "A4LC", &lcdc_device, },
 		{ "A4LC", &hdmi_lcdc_device, },
 		{ "A4LC", &meram_device, },
-- 
2.0.1
