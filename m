From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon,  1 Jul 2013 16:56:12 +0200
Subject: [PATCH] ARM: dove: fix missing __init section of dove_mpp_gpio_mode
Message-ID: <1372690572-2184-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Legacy dove_mpp_gpio_mode calls orion_gpio_set_valid which is in
__init section. Offending function is not, so this causes a section
mismatch. To fix the mismatch, also move dove_mpp_gpio_mode to
__init section.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-dove/mpp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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
1.7.2.5
