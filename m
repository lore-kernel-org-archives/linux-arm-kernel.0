From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon,  8 Nov 2010 20:37:44 +0800
Subject: [PATCH 3/9] ARM: pxa: fix typo error in pxa3xx
In-Reply-To: <1289219870-17807-2-git-send-email-haojian.zhuang@marvell.com>
References: <1289219870-17807-1-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1289219870-17807-3-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

common_io_desc is already used in generic.c. At here, we should use
pxa3xx_io_desc instead.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/pxa3xx.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index e7942ca..e36d836 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -49,9 +49,6 @@
 #define PECR_IE(n)	((1 << ((n) * 2)) << 28)
 #define PECR_IS(n)	((1 << ((n) * 2)) << 29)
 
-/* crystal frequency to static memory controller multiplier (SMCFS) */
-static unsigned char smcfs_mult[8] = { 6, 0, 8, 0, 0, 16, };
-
 /* crystal frequency to HSIO bus frequency multiplier (HSS) */
 static unsigned char hss_mult[4] = { 8, 12, 16, 24 };
 
@@ -593,7 +590,7 @@ static struct map_desc pxa3xx_io_desc[] __initdata = {
 void __init pxa3xx_map_io(void)
 {
 	pxa_map_io();
-	iotable_init(ARRAY_AND_SIZE(common_io_desc));
+	iotable_init(ARRAY_AND_SIZE(pxa3xx_io_desc));
 	pxa3xx_get_clk_frequency_khz(1);
 }
 
-- 
1.5.6.5
