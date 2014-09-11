From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 11 Sep 2014 09:57:24 +0900
Subject: [PATCH 2/5] ARM: shmobile: sh7372: Make domain_devices[] static
 __initdata
In-Reply-To: <cover.1410395620.git.horms+renesas@verge.net.au>
References: <cover.1410395620.git.horms+renesas@verge.net.au>
Message-ID: <9eda01b2f665d8bf29f6ac93e3db403290e0f3cf.1410395620.git.horms+renesas@verge.net.au>
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
 arch/arm/mach-shmobile/setup-sh7372.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 9cdfcdfd..a04fa5f 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -927,7 +927,7 @@ static struct platform_device *sh7372_late_devices[] __initdata = {
 
 void __init sh7372_add_standard_devices(void)
 {
-	struct pm_domain_device domain_devices[] = {
+	static struct pm_domain_device domain_devices[] __initdata = {
 		{ "A3RV", &vpu_device, },
 		{ "A4MP", &spu0_device, },
 		{ "A4MP", &spu1_device, },
-- 
2.0.1
