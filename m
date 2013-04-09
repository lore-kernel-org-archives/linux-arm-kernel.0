From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Tue, 9 Apr 2013 18:01:02 +0530
Subject: [PATCH 2/4] ARM: davinci: da850: override device name of UART in DT
 kernel
In-Reply-To: <1365510481-32129-1-git-send-email-prakash.pm@ti.com>
References: <1365510481-32129-1-git-send-email-prakash.pm@ti.com>
Message-ID: <1365510664-1394-3-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Populate OF_DEV_AUXDATA with desired device name so as to prevent
clk_get failures.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 arch/arm/mach-davinci/da8xx-dt.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 6b7a0a2..fff78a1 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -40,6 +40,9 @@ static void __init da8xx_init_irq(void)
 struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,davinci-i2c", 0x01c22000, "i2c_davinci.1", NULL),
 	OF_DEV_AUXDATA("ti,davinci-wdt", 0x01c21000, "watchdog", NULL),
+	OF_DEV_AUXDATA("ns16550a", 0x01c42000, "serial8250.0", NULL),
+	OF_DEV_AUXDATA("ns16550a", 0x01d0c000, "serial8250.1", NULL),
+	OF_DEV_AUXDATA("ns16550a", 0x01d0d000, "serial8250.2", NULL),
 	{}
 };
 
-- 
1.7.4.1
