From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Tue, 12 Mar 2013 13:40:26 +0530
Subject: [PATCH v3 4/5] ARM: davinci: da850: override SPI DT node device name
In-Reply-To: <1363075827-31053-1-git-send-email-prakash.pm@ti.com>
References: <1363075827-31053-1-git-send-email-prakash.pm@ti.com>
Message-ID: <1363075827-31053-5-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Populate OF_DEV_AUXDATA with desired device name expected by spi-davinci
driver. Without this clk_get of spi-davinci DT driver fails.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 arch/arm/mach-davinci/da8xx-dt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 5404e92..e049f07 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -40,6 +40,7 @@ static void __init da8xx_init_irq(void)
 struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,davinci-i2c", 0x01c22000, "i2c_davinci.1", NULL),
 	OF_DEV_AUXDATA("ti,davinci-wdt", 0x01c21000, "watchdog", NULL),
+	OF_DEV_AUXDATA("ti,da830-spi", 0x01f0e000, "spi_davinci.1", NULL),
 	{}
 };
 
-- 
1.7.4.1
