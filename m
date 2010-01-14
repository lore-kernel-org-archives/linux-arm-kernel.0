From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 14 Jan 2010 11:24:14 +0200
Subject: [PATCH 2/3] mx25: add NAND support
In-Reply-To: <cover.1263460321.git.baruch@tkos.co.il>
References: <cover.1263460321.git.baruch@tkos.co.il>
Message-ID: <adbbcd2564fc70155fabca32218cf3a913af9fe1.1263460321.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/mach-mx25/devices.c          |   20 ++++++++++++++++++++
 arch/arm/mach-mx25/devices.h          |    1 +
 arch/arm/plat-mxc/include/mach/mx25.h |    2 ++
 3 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index 9fdeea1..dd40697 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -438,3 +438,23 @@ struct platform_device mx25_fec_device = {
 	.num_resources	= ARRAY_SIZE(mx25_fec_resources),
 	.resource	= mx25_fec_resources,
 };
+
+static struct resource mxc_nand_resources[] = {
+	{
+		.start	= MX25_NFC_BASE_ADDR,
+		.end	= MX25_NFC_BASE_ADDR + 0x1fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= MX25_INT_NANDFC,
+		.end	= MX25_INT_NANDFC,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device mxc_nand_device = {
+	.name		= "mxc_nand",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(mxc_nand_resources),
+	.resource	= mxc_nand_resources,
+};
diff --git a/arch/arm/mach-mx25/devices.h b/arch/arm/mach-mx25/devices.h
index fe5420f..8f55300 100644
--- a/arch/arm/mach-mx25/devices.h
+++ b/arch/arm/mach-mx25/devices.h
@@ -18,3 +18,4 @@ extern struct platform_device mxc_i2c_device0;
 extern struct platform_device mxc_i2c_device1;
 extern struct platform_device mxc_i2c_device2;
 extern struct platform_device mx25_fec_device;
+extern struct platform_device mxc_nand_device;
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 854e2dc..58e0bd3 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -42,7 +42,9 @@
 #define UART2_BASE_ADDR			0x43f94000
 
 #define MX25_FEC_BASE_ADDR		0x50038000
+#define MX25_NFC_BASE_ADDR		0xbb000000
 
 #define MX25_INT_FEC	57
+#define MX25_INT_NANDFC	33
 
 #endif /* __MACH_MX25_H__ */
-- 
1.6.5
