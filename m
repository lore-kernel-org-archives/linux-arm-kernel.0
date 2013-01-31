From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Thu, 31 Jan 2013 16:03:05 +0530
Subject: [PATCH 1/3] ARM: davinci: da850: override mmc DT node device name
In-Reply-To: <1359628387-14437-1-git-send-email-prakash.pm@ti.com>
References: <1359628387-14437-1-git-send-email-prakash.pm@ti.com>
Message-ID: <1359628387-14437-2-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Populate OF_DEV_AUXDATA with desired device name expected by
davinci_mmc driver. Without this clk_get of davinci_mmc DT driver
fails.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
Cc: linux-mmc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Cc: davinci-linux-open-source at linux.davincidsp.com
Cc: devicetree-discuss at lists.ozlabs.org
Cc: cjb at laptop.org
Cc: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/da8xx-dt.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 37c27af..c623db0 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -39,9 +39,15 @@ static void __init da8xx_init_irq(void)
 
 #ifdef CONFIG_ARCH_DAVINCI_DA850
 
+static const struct of_dev_auxdata da8xx_auxdata[] __initconst = {
+	OF_DEV_AUXDATA("ti,davinci_mmc", 0x01c40000, "davinci_mmc.0", NULL),
+	{},
+};
+
 static void __init da850_init_machine(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, da8xx_auxdata,
+			NULL);
 
 	da8xx_uart_clk_enable();
 }
-- 
1.7.4.1
