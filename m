From: philippe.retornaz@epfl.ch (=?UTF-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Tue, 15 May 2012 13:53:49 +0200
Subject: [PATCH 1/4] mc13xxx: add codec platform data
In-Reply-To: <1337082832-9764-1-git-send-email-philippe.retornaz@epfl.ch>
References: <1337082832-9764-1-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <1337082832-9764-2-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
---
 drivers/mfd/mc13xxx-core.c  |    3 ++-
 include/linux/mfd/mc13xxx.h |   11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index 9fd4f63..738722c 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -813,7 +813,8 @@ err_revision:
 		mc13xxx_add_subdevice(mc13xxx, "%s-adc");
 
 	if (mc13xxx->flags & MC13XXX_USE_CODEC)
-		mc13xxx_add_subdevice(mc13xxx, "%s-codec");
+		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-codec",
+					pdata->codec, sizeof(*pdata->codec));
 
 	if (mc13xxx->flags & MC13XXX_USE_RTC)
 		mc13xxx_add_subdevice(mc13xxx, "%s-rtc");
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index 10e038b..bf07075 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -170,6 +170,16 @@ struct mc13xxx_ts_platform_data {
 	bool atox;
 };
 
+enum mc13783_ssi_port {
+	MC13783_SSI1_PORT,
+	MC13783_SSI2_PORT,
+};
+
+struct mc13xxx_codec_platform_data {
+	enum mc13783_ssi_port adc_ssi_port;
+	enum mc13783_ssi_port dac_ssi_port;
+};
+
 struct mc13xxx_platform_data {
 #define MC13XXX_USE_TOUCHSCREEN (1 << 0)
 #define MC13XXX_USE_CODEC	(1 << 1)
@@ -181,6 +191,7 @@ struct mc13xxx_platform_data {
 	struct mc13xxx_leds_platform_data *leds;
 	struct mc13xxx_buttons_platform_data *buttons;
 	struct mc13xxx_ts_platform_data touch;
+	struct mc13xxx_codec_platform_data *codec;
 };
 
 #define MC13XXX_ADC_MODE_TS		1
-- 
1.7.0.4
