From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 23 Feb 2011 02:29:10 +0300
Subject: [PATCH 2/3] tosa: register wm9712 codec device
In-Reply-To: <1298417351-24727-1-git-send-email-dbaryshkov@gmail.com>
References: <1298417351-24727-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1298417351-24727-2-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since f0fba2ad1b it's required to register platform devices even for
AC'97 codecs. Register one on tosa (wm9712-codec).

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/tosa.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 88b2329..7753d22 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -884,6 +884,11 @@ static struct platform_device sharpsl_rom_device = {
 	.dev.platform_data = &sharpsl_rom_data,
 };
 
+static struct platform_device wm9712_device = {
+	.name	= "wm9712-codec",
+	.id	= -1,
+};
+
 static struct platform_device *devices[] __initdata = {
 	&tosascoop_device,
 	&tosascoop_jc_device,
@@ -895,6 +900,7 @@ static struct platform_device *devices[] __initdata = {
 	&tosa_bt_device,
 	&sharpsl_rom_device,
 	&tosa_gpio_vbus,
+	&wm9712_device,
 };
 
 static void tosa_poweroff(void)
-- 
1.7.2.3
