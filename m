From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Wed, 19 May 2010 18:46:06 +0200
Subject: [PATCH 11/13] MX2X: Add Keypad device definition for MX2X arch
In-Reply-To: <1274287568-30253-10-git-send-email-eric@eukrea.com>
References: <1274287568-30253-1-git-send-email-eric@eukrea.com>
	<1274287568-30253-2-git-send-email-eric@eukrea.com>
	<1274287568-30253-3-git-send-email-eric@eukrea.com>
	<1274287568-30253-4-git-send-email-eric@eukrea.com>
	<1274287568-30253-5-git-send-email-eric@eukrea.com>
	<1274287568-30253-6-git-send-email-eric@eukrea.com>
	<1274287568-30253-7-git-send-email-eric@eukrea.com>
	<1274287568-30253-8-git-send-email-eric@eukrea.com>
	<1274287568-30253-9-git-send-email-eric@eukrea.com>
	<1274287568-30253-10-git-send-email-eric@eukrea.com>
Message-ID: <1274287568-30253-11-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on work from Alberto Panizzo for MX3X

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx2/devices.c |   18 ++++++++++++++++++
 arch/arm/mach-mx2/devices.h |    1 +
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx2/devices.c b/arch/arm/mach-mx2/devices.c
index a9377ce..6455935 100644
--- a/arch/arm/mach-mx2/devices.c
+++ b/arch/arm/mach-mx2/devices.c
@@ -501,3 +501,21 @@ struct platform_device mx21_usbhc_device = {
 };
 #endif
 
+static struct resource imx_kpp_resources[] = {
+	{
+		.start  = MX2x_KPP_BASE_ADDR,
+		.end    = MX2x_KPP_BASE_ADDR + 0xf,
+		.flags  = IORESOURCE_MEM
+	}, {
+		.start  = MX2x_INT_KPP,
+		.end    = MX2x_INT_KPP,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device imx_kpp_device = {
+	.name = "imx-keypad",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(imx_kpp_resources),
+	.resource = imx_kpp_resources,
+};
diff --git a/arch/arm/mach-mx2/devices.h b/arch/arm/mach-mx2/devices.h
index 84ed513..cd49779 100644
--- a/arch/arm/mach-mx2/devices.h
+++ b/arch/arm/mach-mx2/devices.h
@@ -40,3 +40,4 @@ extern struct platform_device mxc_spi_device2;
 extern struct platform_device mx21_usbhc_device;
 extern struct platform_device imx_ssi_device0;
 extern struct platform_device imx_ssi_device1;
+extern struct platform_device imx_kpp_device;
-- 
1.6.3.3
