From: michael.heimpold@i2se.com (Michael Heimpold)
Date: Mon, 10 Apr 2017 11:08:55 +0200
Subject: [PATCH] ARM: mxs: add support for I2SE Duckbill 2 boards
In-Reply-To: <20170410082400.GA1872@dragon>
Message-ID: <1491815335-26469-1-git-send-email-michael.heimpold@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Duckbill devices are small, pen-drive sized boards based on
NXP's i.MX28 SoC. While the initial variants (Duckbill series)
were equipped with a micro SD card slot only, the latest generation
(Duckbill 2 series) have an additional internal eMMC onboard.

To distinguish between both generations, a new device tree
compatible string was introduced. To get the MAC address fixup
applied, we need to check for this new string here, too.

Signed-off-by: Michael Heimpold <michael.heimpold@i2se.com>
---
 arch/arm/mach-mxs/mach-mxs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index e4f2108..1c6062d 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -419,7 +419,8 @@ static void __init mxs_machine_init(void)
 		crystalfontz_init();
 	else if (of_machine_is_compatible("eukrea,mbmx283lc"))
 		eukrea_mbmx283lc_init();
-	else if (of_machine_is_compatible("i2se,duckbill"))
+	else if (of_machine_is_compatible("i2se,duckbill") ||
+		 of_machine_is_compatible("i2se,duckbill-2"))
 		duckbill_init();
 	else if (of_machine_is_compatible("msr,m28cu3"))
 		m28cu3_init();
-- 
2.6.1
