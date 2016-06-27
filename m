From: alex@digriz.org.uk (Alexander Clouter)
Date: Mon, 27 Jun 2016 07:49:43 +0100
Subject: [PATCH 4/5] rtc: m48t86: move m48t86.h to platform_data
In-Reply-To: <1466978583-13310-4-git-send-email-alexandre.belloni@free-electrons.com>
References: <1466978583-13310-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1466978583-13310-4-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160627064943.GA5125@quatermain.digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Alexander Clouter <alex@digriz.org.uk>

On Mon, Jun 27, 2016 at 12:03:02AM +0200, Alexandre Belloni wrote:
>m48t86.h belongs to include/linux/platform_data/
>
>Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>---
>Cc: Hartley Sweeten <hsweeten@visionengravers.com>
>Cc: Ryan Mallon <rmallon@gmail.com>
>Cc: Alexander Clouter <alex@digriz.org.uk>
>Cc: Jason Cooper <jason@lakedaemon.net>
>Cc: Andrew Lunn <andrew@lunn.ch>
>Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>Cc: Gregory Clement <gregory.clement@free-electrons.com>
>Cc: linux-arm-kernel at lists.infradead.org
>
> arch/arm/mach-ep93xx/ts72xx.c                          | 2 +-
> arch/arm/mach-orion5x/ts78xx-setup.c                   | 2 +-
> drivers/rtc/rtc-m48t86.c                               | 2 +-
> include/linux/{m48t86.h => platform_data/rtc-m48t86.h} | 0
> 4 files changed, 3 insertions(+), 3 deletions(-)
> rename include/linux/{m48t86.h => platform_data/rtc-m48t86.h} (100%)
>
>diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
>index 45b81a2bcd4b..3b39ea353d30 100644
>--- a/arch/arm/mach-ep93xx/ts72xx.c
>+++ b/arch/arm/mach-ep93xx/ts72xx.c
>@@ -16,7 +16,7 @@
> #include <linux/init.h>
> #include <linux/platform_device.h>
> #include <linux/io.h>
>-#include <linux/m48t86.h>
>+#include <linux/platform_data/rtc-m48t86.h>
> #include <linux/mtd/nand.h>
> #include <linux/mtd/partitions.h>
>
>diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
>index 3a58a5d4a28a..8d597267d0c4 100644
>--- a/arch/arm/mach-orion5x/ts78xx-setup.c
>+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
>@@ -16,7 +16,7 @@
> #include <linux/platform_device.h>
> #include <linux/mv643xx_eth.h>
> #include <linux/ata_platform.h>
>-#include <linux/m48t86.h>
>+#include <linux/platform_data/rtc-m48t86.h>
> #include <linux/mtd/nand.h>
> #include <linux/mtd/partitions.h>
> #include <linux/timeriomem-rng.h>
>diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
>index f72b91f2501f..0eeb5714c00f 100644
>--- a/drivers/rtc/rtc-m48t86.c
>+++ b/drivers/rtc/rtc-m48t86.c
>@@ -16,7 +16,7 @@
> #include <linux/module.h>
> #include <linux/rtc.h>
> #include <linux/platform_device.h>
>-#include <linux/m48t86.h>
>+#include <linux/platform_data/rtc-m48t86.h>
> #include <linux/bcd.h>
>
> #define M48T86_REG_SEC		0x00
>diff --git a/include/linux/m48t86.h b/include/linux/platform_data/rtc-m48t86.h
>similarity index 100%
>rename from include/linux/m48t86.h
>rename to include/linux/platform_data/rtc-m48t86.h
