From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 23 Aug 2013 18:23:47 -0300
Subject: [PATCH for v3.12] ARM: dove: Declare symbol __init to avoid section
 mismatch
Message-ID: <1377293027-443-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare dove_mpp_gpio_mode() symbol as __init, since it's only called
from __init functions. This removes the following warning:

vmlinux.o(.text.unlikely+0x894): Section mismatch in reference from the
function dove_mpp_gpio_mode() to the function .init.text:orion_gpio_set_valid()

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-dove/mpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-dove/mpp.c b/arch/arm/mach-dove/mpp.c
index 60bd729..8a433a5 100644
--- a/arch/arm/mach-dove/mpp.c
+++ b/arch/arm/mach-dove/mpp.c
@@ -47,7 +47,7 @@ static const struct dove_mpp_grp dove_mpp_grp[] = {
 
 /* Enable gpio for a range of pins. mode should be a combination of
    GPIO_OUTPUT_OK | GPIO_INPUT_OK */
-static void dove_mpp_gpio_mode(int start, int end, int gpio_mode)
+static void __init dove_mpp_gpio_mode(int start, int end, int gpio_mode)
 {
 	int i;
 
-- 
1.8.1.5
