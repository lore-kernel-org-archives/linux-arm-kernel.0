From: adrian.hunter@nokia.com (Adrian Hunter)
Date: Thu,  5 May 2011 14:51:16 +0300
Subject: [PATCH 16/22] OMAP: board-rm680: set MMC nomux flag
In-Reply-To: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Message-ID: <1304596282-4095-17-git-send-email-adrian.hunter@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the bootloader do all the pad configuration.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/board-rm680.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 2af8b05..2dba9d0 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -125,6 +125,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_MMC_HIGHSPEED,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.nomux		= true,
 	},
 	{ /* Terminator */ }
 };
-- 
1.7.0.4
