From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Fri, 15 Feb 2013 11:52:02 +0530
Subject: [PATCH v4 5/5] ARM: davinci: da850: override mmc DT node device name
In-Reply-To: <1360909322-1858-1-git-send-email-prakash.pm@ti.com>
References: <1360909322-1858-1-git-send-email-prakash.pm@ti.com>
Message-ID: <1360909322-1858-6-git-send-email-prakash.pm@ti.com>
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
Since v2:
Rebased on top of v3.9/dt-2 branch of linux_davinci and reordered this patch.

 arch/arm/mach-davinci/da8xx-dt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 5404e92..2b740a9 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -40,6 +40,8 @@ static void __init da8xx_init_irq(void)
 struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,davinci-i2c", 0x01c22000, "i2c_davinci.1", NULL),
 	OF_DEV_AUXDATA("ti,davinci-wdt", 0x01c21000, "watchdog", NULL),
+	OF_DEV_AUXDATA("ti,davinci-mmc-da830", 0x01c40000, "davinci-mmc-da830.0",
+			NULL),
 	{}
 };
 
-- 
1.7.4.1
