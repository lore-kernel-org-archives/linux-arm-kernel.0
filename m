From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 20 Mar 2011 11:17:59 +0800
Subject: [PATCH] ARM: mxc: fix buggy '.end' of IORESOURCE_MEM in device codes
Message-ID: <1300591079-1675-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/plat-mxc/devices/platform-fec.c       |    2 +-
 arch/arm/plat-mxc/devices/platform-imxdi_rtc.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-fec.c b/arch/arm/plat-mxc/devices/platform-fec.c
index 6561c9d..ccc789e 100644
--- a/arch/arm/plat-mxc/devices/platform-fec.c
+++ b/arch/arm/plat-mxc/devices/platform-fec.c
@@ -53,7 +53,7 @@ struct platform_device *__init imx_add_fec(
 	struct resource res[] = {
 		{
 			.start = data->iobase,
-			.end = data->iobase + SZ_4K,
+			.end = data->iobase + SZ_4K - 1,
 			.flags = IORESOURCE_MEM,
 		}, {
 			.start = data->irq,
diff --git a/arch/arm/plat-mxc/devices/platform-imxdi_rtc.c b/arch/arm/plat-mxc/devices/platform-imxdi_rtc.c
index 10653cc..805336f 100644
--- a/arch/arm/plat-mxc/devices/platform-imxdi_rtc.c
+++ b/arch/arm/plat-mxc/devices/platform-imxdi_rtc.c
@@ -27,7 +27,7 @@ struct platform_device *__init imx_add_imxdi_rtc(
 	struct resource res[] = {
 		{
 			.start = data->iobase,
-			.end = data->iobase + SZ_16K,
+			.end = data->iobase + SZ_16K - 1,
 			.flags = IORESOURCE_MEM,
 		}, {
 			.start = data->irq,
-- 
1.7.1
