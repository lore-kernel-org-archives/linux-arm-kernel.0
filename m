From: saeed@marvell.com (Saeed Bishara)
Date: Tue,  8 Jun 2010 14:30:37 +0300
Subject: [PATCH] [ARM] Kirkwood: configure NAND mpp's for db88f6281
Message-ID: <1275996637-25273-1-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case the board is configured to boot from spi flash, the mpps
will not be configured to select the NAND I/Os. This patch makes
sure to select the NAND I/O's regardless to the boot device type.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
index c428348..16f6691 100644
--- a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
+++ b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
@@ -51,6 +51,14 @@ static struct mvsdio_platform_data db88f6281_mvsdio_data = {
 };
 
 static unsigned int db88f6281_mpp_config[] __initdata = {
+	MPP0_NF_IO2,
+	MPP1_NF_IO3,
+	MPP2_NF_IO4,
+	MPP3_NF_IO5,
+	MPP4_NF_IO6,
+	MPP5_NF_IO7,
+	MPP18_NF_IO0,
+	MPP19_NF_IO1,
 	MPP37_GPIO,
 	MPP38_GPIO,
 	0
-- 
1.6.0.4
