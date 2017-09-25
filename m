From: marco.franchi@nxp.com (Marco Franchi)
Date: Mon, 25 Sep 2017 15:55:59 -0300
Subject: [PATCH 4/4] ARM: imx: mach-mx31lite: Make mx31lite_map_io static
In-Reply-To: <1506365759-28768-1-git-send-email-marco.franchi@nxp.com>
References: <1506365759-28768-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <1506365759-28768-4-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following build warning is seen with W=1:

warning: no previous prototype for ?mx31lite_map_io? 
[-Wmissing-prototypes] void __init mx31lite_map_io(void)

This function is only used in this file so make it "static".

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
 arch/arm/mach-imx/mach-mx31lite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
index f033a57..a3250bc 100644
--- a/arch/arm/mach-imx/mach-mx31lite.c
+++ b/arch/arm/mach-imx/mach-mx31lite.c
@@ -245,7 +245,7 @@ static struct map_desc mx31lite_io_desc[] __initdata = {
 /*
  * Set up static virtual mappings.
  */
-void __init mx31lite_map_io(void)
+static void __init mx31lite_map_io(void)
 {
 	mx31_map_io();
 	iotable_init(mx31lite_io_desc, ARRAY_SIZE(mx31lite_io_desc));
-- 
2.7.4
