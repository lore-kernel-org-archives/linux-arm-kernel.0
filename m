From: mgherzan@gmail.com (Mircea Gherzan)
Date: Thu, 23 Feb 2012 18:52:57 +0100
Subject: [PATCH RESEND] ARM: OMAP: enable Bluetooth on the PandaBoard
Message-ID: <1330019577-2106-1-git-send-email-mgherzan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PandaBoard features a Texas Instruments WiLink7 Bluetooth
chip, supported by the "btwilink" driver.

Signed-off-by: Mircea Gherzan <mgherzan@gmail.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 28fc271..b1d74d6 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -91,9 +91,15 @@ static struct platform_device leds_gpio = {
 	},
 };
 
+static struct platform_device btwilink_device = {
+	.name	= "btwilink",
+	.id	= -1,
+};
+
 static struct platform_device *panda_devices[] __initdata = {
 	&leds_gpio,
 	&wl1271_device,
+	&btwilink_device,
 };
 
 static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
-- 
1.7.9.1
