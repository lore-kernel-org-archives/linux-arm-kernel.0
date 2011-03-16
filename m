From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 16 Mar 2011 21:40:28 +0100
Subject: [PATCH] ARM: mxs: fix naming of struct holding info for mxs-i2c
	devices
In-Reply-To: <1298911205-3070-2-git-send-email-w.sang@pengutronix.de>
References: <1298911205-3070-2-git-send-email-w.sang@pengutronix.de>
Message-ID: <1300308028-8922-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For consistency mxs has to be repeated, one for the name space and
another one for the device name.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mxs/devices-mx28.h                |    2 +-
 arch/arm/mach-mxs/devices/platform-mxs-i2c.c    |    5 +++--
 arch/arm/mach-mxs/include/mach/devices-common.h |    4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index c473edd..79b9452 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -34,7 +34,7 @@ extern const struct mxs_flexcan_data mx28_flexcan_data[] __initconst;
 #define mx28_add_flexcan0(pdata)	mx28_add_flexcan(0, pdata)
 #define mx28_add_flexcan1(pdata)	mx28_add_flexcan(1, pdata)
 
-extern const struct mxs_i2c_data mx28_mxs_i2c_data[] __initconst;
+extern const struct mxs_mxs_i2c_data mx28_mxs_i2c_data[] __initconst;
 #define mx28_add_mxs_i2c(id)		mxs_add_mxs_i2c(&mx28_mxs_i2c_data[id])
 
 extern const struct mxs_mxs_mmc_data mx28_mxs_mmc_data[] __initconst;
diff --git a/arch/arm/mach-mxs/devices/platform-mxs-i2c.c b/arch/arm/mach-mxs/devices/platform-mxs-i2c.c
index eab3a06..79222ec 100644
--- a/arch/arm/mach-mxs/devices/platform-mxs-i2c.c
+++ b/arch/arm/mach-mxs/devices/platform-mxs-i2c.c
@@ -22,13 +22,14 @@
 	[_id] = mxs_i2c_data_entry_single(soc, _id)
 
 #ifdef CONFIG_SOC_IMX28
-const struct mxs_i2c_data mx28_mxs_i2c_data[] __initconst = {
+const struct mxs_mxs_i2c_data mx28_mxs_i2c_data[] __initconst = {
 	mxs_i2c_data_entry(MX28, 0),
 	mxs_i2c_data_entry(MX28, 1),
 };
 #endif
 
-struct platform_device *__init mxs_add_mxs_i2c(const struct mxs_i2c_data *data)
+struct platform_device *__init mxs_add_mxs_i2c(
+		const struct mxs_mxs_i2c_data *data)
 {
 	struct resource res[] = {
 		{
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
index c5137f1..7590866 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -65,13 +65,13 @@ struct platform_device *__init mxs_add_flexcan(
 		const struct flexcan_platform_data *pdata);
 
 /* i2c */
-struct mxs_i2c_data {
+struct mxs_mxs_i2c_data {
 	int id;
 	resource_size_t iobase;
 	resource_size_t errirq;
 	resource_size_t dmairq;
 };
-struct platform_device * __init mxs_add_mxs_i2c(const struct mxs_i2c_data *data);
+struct platform_device * __init mxs_add_mxs_i2c(const struct mxs_mxs_i2c_data *data);
 
 /* mmc */
 #include <mach/mmc.h>
-- 
1.7.2.3
