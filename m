Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24184C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:32:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4722086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BHz7mwLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4722086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lEFSibwksQouZu2Rdp6zxR84n0eQ8nrOW3PHxlhMQT0=; b=BHz7mwLk47IQQp
	oRhvVVFYj+K54Hkm+pm9dTcIATOrxVzisGzrCvN0Mx6nK66QAQ/gsfYF8vLzoHCZBy7WWQIuEHTTr
	wr4lC+kgSGXELeMhVwmCP0k+kz4PP8oQw5Ts/5bqyvaYr3DqMWXuhuCjDr8aQV9/fny353LhkMgty
	qfcEnFfC+EcT/ilOIXnErjr4PeMuVxip3O4K0d3KAXwyY2PxaLslYFlwhGeOG4W3OQpW4StkYdqQe
	kckgdhVO0nkur//nxQgibnyeQfR4KAJc47yDXz7dW76oFc8Uwq3jJNiAK6mjkMkFRnX2gA1I3Dvlh
	G6wvQHhLNGRTAfFXIS5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwR2v-0000HN-4q; Wed, 20 Feb 2019 12:32:17 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwR2T-0008BL-BT; Wed, 20 Feb 2019 12:31:51 +0000
X-UUID: c854b6a2f9db4fa7aeb067f2c133a886-20190220
X-UUID: c854b6a2f9db4fa7aeb067f2c133a886-20190220
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <michael.kao@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1189881583; Wed, 20 Feb 2019 04:31:46 -0800
Received: from MTKMBS01N2.mediatek.inc (172.21.101.79) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 04:31:45 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 20:31:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Wed, 20 Feb 2019 20:31:36 +0800
From: <michael.kao@mediatek.com>
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>
Subject: [PATCH v2,7/7] thermal: mediatek: add support for MT8183
Date: Wed, 20 Feb 2019 20:31:33 +0800
Message-ID: <1550665893-22561-8-git-send-email-michael.kao@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550665893-22561-1-git-send-email-michael.kao@mediatek.com>
References: <1550665893-22561-1-git-send-email-michael.kao@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 688FE9BF678E2A169D97ED39A20A0CCE927401784CA4B148DDC9AFEE784712612000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_043149_401477_84AD3B53 
X-CRM114-Status: GOOD (  14.58  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Kao <michael.kao@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Michael Kao <michael.kao@mediatek.com>

MT8183 has two built-in thermal controllers with total six thermal
sensors. And it doesn't have bank, so doesn't need to select bank.
This patch adds support for mt8183.

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
---
 drivers/thermal/mtk_thermal.c | 99 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 0a3944e..5c07a61 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -71,6 +71,15 @@
 
 #define TEMP_SPARE0		0x0f0
 
+#define TEMP_ADCPNP0_1          0x148
+#define TEMP_ADCPNP1_1          0x14c
+#define TEMP_ADCPNP2_1          0x150
+#define TEMP_MSR0_1             0x190
+#define TEMP_MSR1_1             0x194
+#define TEMP_MSR2_1             0x198
+#define TEMP_ADCPNP3_1          0x1b4
+#define TEMP_MSR3_1             0x1B8
+
 #define PTPCORESEL		0x400
 
 #define TEMP_MONCTL1_PERIOD_UNIT(x)	((x) & 0x3ff)
@@ -113,7 +122,8 @@
 
 /*
  * Layout of the fuses providing the calibration data
- * These macros could be used for MT8173, MT2701, and MT2712.
+ * These macros could be used for MT8183, MT8173, MT2701, and MT2712.
+ * MT8183 has 6 sensors and needs 6 VTS calibration data.
  * MT8173 has 5 sensors and needs 5 VTS calibration data.
  * MT2701 has 3 sensors and needs 3 VTS calibration data.
  * MT2712 has 4 sensors and needs 4 VTS calibration data.
@@ -124,6 +134,7 @@
 #define CALIB_BUF0_VTS_TS2(x)		(((x) >> 8) & 0x1ff)
 #define CALIB_BUF1_VTS_TS3(x)		(((x) >> 0) & 0x1ff)
 #define CALIB_BUF2_VTS_TS4(x)		(((x) >> 23) & 0x1ff)
+#define CALIB_BUF2_VTS_TS5(x)		(((x) >> 5) & 0x1ff)
 #define CALIB_BUF2_VTS_TSABB(x)		(((x) >> 14) & 0x1ff)
 #define CALIB_BUF0_DEGC_CALI(x)		(((x) >> 1) & 0x3f)
 #define CALIB_BUF0_O_SLOPE(x)		(((x) >> 26) & 0x3f)
@@ -135,6 +146,7 @@ enum {
 	VTS2,
 	VTS3,
 	VTS4,
+	VTS5,
 	VTSABB,
 	MAX_NUM_VTS,
 };
@@ -190,6 +202,29 @@ enum {
 /* The calibration coefficient of sensor  */
 #define MT7622_CALIBRATION	165
 
+/* MT8183 thermal sensors */
+#define MT8183_TS1	0
+#define MT8183_TS2	1
+#define MT8183_TS3	2
+#define MT8183_TS4	3
+#define MT8183_TS5	4
+#define MT8183_TSABB	5
+
+/* AUXADC channel  is used for the temperature sensors */
+#define MT8183_TEMP_AUXADC_CHANNEL	11
+
+/* The total number of temperature sensors in the MT8183 */
+#define MT8183_NUM_SENSORS	6
+
+/* The number of sensing points per bank */
+#define MT8183_NUM_SENSORS_PER_ZONE	 6
+
+/* The number of controller in the MT8183 */
+#define MT8183_NUM_CONTROLLER		2
+
+/* The calibration coefficient of sensor  */
+#define MT8183_CALIBRATION	153
+
 struct mtk_thermal;
 
 struct thermal_bank_cfg {
@@ -236,6 +271,27 @@ struct mtk_thermal {
 	struct mtk_thermal_bank banks[];
 };
 
+/* MT8183 thermal sensor data */
+static const int mt8183_bank_data[MT8183_NUM_SENSORS] = {
+	MT8183_TS1, MT8183_TS2, MT8183_TS3, MT8183_TS4, MT8183_TS5, MT8183_TSABB
+};
+
+static const int mt8183_msr[MT8183_NUM_SENSORS_PER_ZONE] = {
+	TEMP_MSR0_1, TEMP_MSR1_1, TEMP_MSR2_1, TEMP_MSR1, TEMP_MSR0, TEMP_MSR3_1
+};
+
+static const int mt8183_adcpnp[MT8183_NUM_SENSORS_PER_ZONE] = {
+	TEMP_ADCPNP0_1, TEMP_ADCPNP1_1, TEMP_ADCPNP2_1,
+	TEMP_ADCPNP1, TEMP_ADCPNP0, TEMP_ADCPNP3_1
+};
+
+static const int mt8183_mux_values[MT8183_NUM_SENSORS] = { 0, 1, 2, 3, 4, 0 };
+static const int mt8183_tc_offset[MT8183_NUM_CONTROLLER] = {0x0, 0x100};
+
+static const int mt8183_vts_index[MT8183_NUM_SENSORS] = {
+	VTS1, VTS2, VTS3, VTS4, VTS5, VTSABB
+};
+
 /* MT8173 thermal sensor data */
 static const int mt8173_bank_data[MT8173_NUM_ZONES][3] = {
 	{ MT8173_TS2, MT8173_TS3 },
@@ -434,6 +490,39 @@ struct mtk_thermal {
 };
 
 /**
+ * The MT8183 thermal controller has one bank for the current SW framework.
+ * The MT8183 has a total of 6 temperature sensors.
+ * There are two thermal controller to control the six sensor.
+ * The first one bind 2 sensor, and the other bind 4 sensors.
+ * The thermal core only gets the maximum temperature of all sensor, so
+ * the bank concept wouldn't be necessary here. However, the SVS (Smart
+ * Voltage Scaling) unit makes its decisions based on the same bank
+ * data, and this indeed needs the temperatures of the individual banks
+ * for making better decisions.
+ */
+
+static const struct mtk_thermal_data mt8183_thermal_data = {
+	.auxadc_channel = MT8183_TEMP_AUXADC_CHANNEL,
+	.num_banks = MT8183_NUM_SENSORS_PER_ZONE,
+	.num_sensors = MT8183_NUM_SENSORS,
+	.vts_index = mt8183_vts_index,
+	.cali_val = MT8183_CALIBRATION,
+	.num_controller = MT8183_NUM_CONTROLLER,
+	.controller_offset = mt8183_tc_offset,
+	.need_switch_bank = false,
+	.bank_data = {
+		{
+			.num_sensors = 6,
+			.sensors = mt8183_bank_data,
+		},
+	},
+
+	.msr = mt8183_msr,
+	.adcpnp = mt8183_adcpnp,
+	.sensor_mux_values = mt8183_mux_values,
+};
+
+/**
  * raw_to_mcelsius - convert a raw ADC value to mcelsius
  * @mt:		The thermal controller
  * @raw:	raw ADC value
@@ -726,6 +815,9 @@ static int mtk_thermal_get_calibration_data(struct device *dev,
 			case VTS4:
 				mt->vts[VTS4] = CALIB_BUF2_VTS_TS4(buf[2]);
 				break;
+			case VTS5:
+				mt->vts[VTS5] = CALIB_BUF2_VTS_TS5(buf[2]);
+				break;
 			case VTSABB:
 				mt->vts[VTSABB] = CALIB_BUF2_VTS_TSABB(buf[2]);
 				break;
@@ -766,6 +858,10 @@ static int mtk_thermal_get_calibration_data(struct device *dev,
 	{
 		.compatible = "mediatek,mt7622-thermal",
 		.data = (void *)&mt7622_thermal_data,
+	},
+	{
+		.compatible = "mediatek,mt8183-thermal",
+		.data = (void *)&mt8183_thermal_data,
 	}, {
 	},
 };
@@ -898,6 +994,7 @@ static int mtk_thermal_remove(struct platform_device *pdev)
 
 module_platform_driver(mtk_thermal_driver);
 
+MODULE_AUTHOR("Michael Kao <michael.kao@mediatek.com>");
 MODULE_AUTHOR("Louis Yu <louis.yu@mediatek.com>");
 MODULE_AUTHOR("Dawei Chien <dawei.chien@mediatek.com>");
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
