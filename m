From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Mon, 25 Feb 2013 16:14:09 +0530
Subject: [PATCH 3/4] ARM: davinci: da850: override SPI DT node device name
In-Reply-To: <1361789050-637-1-git-send-email-prakash.pm@ti.com>
References: <1361789050-637-1-git-send-email-prakash.pm@ti.com>
Message-ID: <1361789050-637-4-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Populate OF_DEV_AUXDATA with desired device name expected by spi-davinci
driver. Without this clk_get of spi-davinci DT driver fails.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 arch/arm/mach-davinci/da8xx-dt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 2b740a9..d9c76009 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -42,6 +42,7 @@ struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("ti,davinci-wdt", 0x01c21000, "watchdog", NULL),
 	OF_DEV_AUXDATA("ti,davinci-mmc-da830", 0x01c40000, "davinci-mmc-da830.0",
 			NULL),
+	OF_DEV_AUXDATA("ti,da8xx-spi", 0x01f0e000, "spi_davinci.1", NULL),
 	{}
 };
 
-- 
1.7.4.1
