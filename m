From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 30 Nov 2014 01:02:03 +0300
Subject: [PATCH v2 1/3] ARM: pxa: lubbock: add declaration of vbus tranceiver
In-Reply-To: <1417298525-5587-1-git-send-email-dbaryshkov@gmail.com>
References: <1417298525-5587-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1417298525-5587-2-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a declaration of lubbock-vbus device, used as UDC transceiver on
Lubbock platform.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/lubbock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index d8a1be6..5e2dcf7 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -383,11 +383,17 @@ static struct platform_device lubbock_flash_device[2] = {
 	},
 };
 
+static struct platform_device lubbock_vbus = {
+	.name	= "lubbock-vbus",
+	.id	= -1,
+};
+
 static struct platform_device *devices[] __initdata = {
 	&sa1111_device,
 	&smc91x_device,
 	&lubbock_flash_device[0],
 	&lubbock_flash_device[1],
+	&lubbock_vbus,
 };
 
 static struct pxafb_mode_info sharp_lm8v31_mode = {
-- 
2.1.3
