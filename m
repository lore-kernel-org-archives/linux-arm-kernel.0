Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BCEC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:32:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 580792086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L5+RzEgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580792086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1BaDDlVlEF/8YNxewJtwKRyA6/f9lX0Mv3VT8OYG3/0=; b=L5+RzEgi6PvC8y
	ymfm1AlpJDk73fXTnMXBdCipbb6R6cmp8nZkHXtsQwbylYEjlUt2R8e/Wq80poQ0Iut6lc4oYooWO
	Lbq4US4f1/dLWMOdowMTxnTh/jY4B1dym+c4w6pQZ0rYKQZPd/STxfFNMi4s9/ABFvvT6r2pba3KC
	Tfp/qIcMaK9cREGU3Nc7+eELJ6mjyFOFUCSBk30lKKqatLMzmxsSV4/vLdBTYnJBxYSYKleA9UAzB
	53wC7+saWjsWeUU69badaJ0o4HCSm13FvoOJw2kVn66zH/RQtt7u8wwER8LBC7kc0ZiAn3nN/IvTE
	Iuq4U1fDMJyey+Sbh0Qg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwR2j-0008Ux-EE; Wed, 20 Feb 2019 12:32:05 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwR2S-0008B4-BT; Wed, 20 Feb 2019 12:31:49 +0000
X-UUID: 4de1e0bad94c4d2eac985e1b8dec8ebc-20190220
X-UUID: 4de1e0bad94c4d2eac985e1b8dec8ebc-20190220
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <michael.kao@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1269086854; Wed, 20 Feb 2019 04:31:45 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 04:31:43 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 20:31:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Wed, 20 Feb 2019 20:31:35 +0800
From: <michael.kao@mediatek.com>
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>
Subject: [PATCH v2,2/7] thermal: mediatek: add common index of vts settings.
Date: Wed, 20 Feb 2019 20:31:28 +0800
Message-ID: <1550665893-22561-3-git-send-email-michael.kao@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550665893-22561-1-git-send-email-michael.kao@mediatek.com>
References: <1550665893-22561-1-git-send-email-michael.kao@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_043148_404353_E3CE549B 
X-CRM114-Status: GOOD (  12.78  )
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

Each project has different number of vts settings.
For the MT2701 just have to set three vts, but the
original code flow add five unnecessary vts.
Add common index of vts settings for scalablity,
and reduce the setting of unnecessary vts.

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
---
 drivers/thermal/mtk_thermal.c | 93 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 69 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index f646436..07f8ad7 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -112,17 +112,26 @@
  * MT2701 has 3 sensors and needs 3 VTS calibration data.
  * MT2712 has 4 sensors and needs 4 VTS calibration data.
  */
-#define MT8173_CALIB_BUF0_VALID		BIT(0)
-#define MT8173_CALIB_BUF1_ADC_GE(x)	(((x) >> 22) & 0x3ff)
-#define MT8173_CALIB_BUF0_VTS_TS1(x)	(((x) >> 17) & 0x1ff)
-#define MT8173_CALIB_BUF0_VTS_TS2(x)	(((x) >> 8) & 0x1ff)
-#define MT8173_CALIB_BUF1_VTS_TS3(x)	(((x) >> 0) & 0x1ff)
-#define MT8173_CALIB_BUF2_VTS_TS4(x)	(((x) >> 23) & 0x1ff)
-#define MT8173_CALIB_BUF2_VTS_TSABB(x)	(((x) >> 14) & 0x1ff)
-#define MT8173_CALIB_BUF0_DEGC_CALI(x)	(((x) >> 1) & 0x3f)
-#define MT8173_CALIB_BUF0_O_SLOPE(x)	(((x) >> 26) & 0x3f)
-#define MT8173_CALIB_BUF0_O_SLOPE_SIGN(x)	(((x) >> 7) & 0x1)
-#define MT8173_CALIB_BUF1_ID(x)	(((x) >> 9) & 0x1)
+#define CALIB_BUF0_VALID		BIT(0)
+#define CALIB_BUF1_ADC_GE(x)		(((x) >> 22) & 0x3ff)
+#define CALIB_BUF0_VTS_TS1(x)		(((x) >> 17) & 0x1ff)
+#define CALIB_BUF0_VTS_TS2(x)		(((x) >> 8) & 0x1ff)
+#define CALIB_BUF1_VTS_TS3(x)		(((x) >> 0) & 0x1ff)
+#define CALIB_BUF2_VTS_TS4(x)		(((x) >> 23) & 0x1ff)
+#define CALIB_BUF2_VTS_TSABB(x)		(((x) >> 14) & 0x1ff)
+#define CALIB_BUF0_DEGC_CALI(x)		(((x) >> 1) & 0x3f)
+#define CALIB_BUF0_O_SLOPE(x)		(((x) >> 26) & 0x3f)
+#define CALIB_BUF0_O_SLOPE_SIGN(x)	(((x) >> 7) & 0x1)
+#define CALIB_BUF1_ID(x)		(((x) >> 9) & 0x1)
+
+enum {
+	VTS1,
+	VTS2,
+	VTS3,
+	VTS4,
+	VTSABB,
+	MAX_NUM_VTS,
+};
 
 /* MT2701 thermal sensors */
 #define MT2701_TS1	0
@@ -175,6 +184,7 @@ struct mtk_thermal_data {
 	s32 num_banks;
 	s32 num_sensors;
 	s32 auxadc_channel;
+	const int *vts_index;
 	const int *sensor_mux_values;
 	const int *msr;
 	const int *adcpnp;
@@ -194,7 +204,7 @@ struct mtk_thermal {
 	s32 adc_ge;
 	s32 degc_cali;
 	s32 o_slope;
-	s32 vts[MT8173_NUM_SENSORS];
+	s32 vts[MAX_NUM_VTS];
 
 	const struct mtk_thermal_data *conf;
 	struct mtk_thermal_bank banks[];
@@ -218,6 +228,10 @@ struct mtk_thermal {
 
 static const int mt8173_mux_values[MT8173_NUM_SENSORS] = { 0, 1, 2, 3, 16 };
 
+static const int mt8173_vts_index[MT8173_NUM_SENSORS] = {
+	VTS1, VTS2, VTS3, VTS4, VTSABB
+};
+
 /* MT2701 thermal sensor data */
 static const int mt2701_bank_data[MT2701_NUM_SENSORS] = {
 	MT2701_TS1, MT2701_TS2, MT2701_TSABB
@@ -233,6 +247,10 @@ struct mtk_thermal {
 
 static const int mt2701_mux_values[MT2701_NUM_SENSORS] = { 0, 1, 16 };
 
+static const int mt2701_vts_index[MT2701_NUM_SENSORS] = {
+	VTS1, VTS2, VTS3
+};
+
 /* MT2712 thermal sensor data */
 static const int mt2712_bank_data[MT2712_NUM_SENSORS] = {
 	MT2712_TS1, MT2712_TS2, MT2712_TS3, MT2712_TS4
@@ -248,11 +266,16 @@ struct mtk_thermal {
 
 static const int mt2712_mux_values[MT2712_NUM_SENSORS] = { 0, 1, 2, 3 };
 
+static const int mt2712_vts_index[MT2712_NUM_SENSORS] = {
+	VTS1, VTS2, VTS3, VTS4
+};
+
 /* MT7622 thermal sensor data */
 static const int mt7622_bank_data[MT7622_NUM_SENSORS] = { MT7622_TS1, };
 static const int mt7622_msr[MT7622_NUM_SENSORS_PER_ZONE] = { TEMP_MSR0, };
 static const int mt7622_adcpnp[MT7622_NUM_SENSORS_PER_ZONE] = { TEMP_ADCPNP0, };
 static const int mt7622_mux_values[MT7622_NUM_SENSORS] = { 0, };
+static const int mt7622_vts_index[MT7622_NUM_SENSORS] = { VTS1 };
 
 /**
  * The MT8173 thermal controller has four banks. Each bank can read up to
@@ -271,6 +294,7 @@ struct mtk_thermal {
 	.auxadc_channel = MT8173_TEMP_AUXADC_CHANNEL,
 	.num_banks = MT8173_NUM_ZONES,
 	.num_sensors = MT8173_NUM_SENSORS,
+	.vts_index = mt8173_vts_index,
 	.bank_data = {
 		{
 			.num_sensors = 2,
@@ -305,6 +329,7 @@ struct mtk_thermal {
 	.auxadc_channel = MT2701_TEMP_AUXADC_CHANNEL,
 	.num_banks = 1,
 	.num_sensors = MT2701_NUM_SENSORS,
+	.vts_index = mt2701_vts_index,
 	.bank_data = {
 		{
 			.num_sensors = 3,
@@ -330,6 +355,7 @@ struct mtk_thermal {
 	.auxadc_channel = MT2712_TEMP_AUXADC_CHANNEL,
 	.num_banks = 1,
 	.num_sensors = MT2712_NUM_SENSORS,
+	.vts_index = mt2712_vts_index,
 	.bank_data = {
 		{
 			.num_sensors = 4,
@@ -349,6 +375,7 @@ struct mtk_thermal {
 	.auxadc_channel = MT7622_TEMP_AUXADC_CHANNEL,
 	.num_banks = MT7622_NUM_ZONES,
 	.num_sensors = MT7622_NUM_SENSORS,
+	.vts_index = mt7622_vts_index,
 	.bank_data = {
 		{
 			.num_sensors = 1,
@@ -629,19 +656,37 @@ static int mtk_thermal_get_calibration_data(struct device *dev,
 		goto out;
 	}
 
-	if (buf[0] & MT8173_CALIB_BUF0_VALID) {
-		mt->adc_ge = MT8173_CALIB_BUF1_ADC_GE(buf[1]);
-		mt->vts[MT8173_TS1] = MT8173_CALIB_BUF0_VTS_TS1(buf[0]);
-		mt->vts[MT8173_TS2] = MT8173_CALIB_BUF0_VTS_TS2(buf[0]);
-		mt->vts[MT8173_TS3] = MT8173_CALIB_BUF1_VTS_TS3(buf[1]);
-		mt->vts[MT8173_TS4] = MT8173_CALIB_BUF2_VTS_TS4(buf[2]);
-		mt->vts[MT8173_TSABB] = MT8173_CALIB_BUF2_VTS_TSABB(buf[2]);
-		mt->degc_cali = MT8173_CALIB_BUF0_DEGC_CALI(buf[0]);
-		if (MT8173_CALIB_BUF1_ID(buf[1]) &
-		    MT8173_CALIB_BUF0_O_SLOPE_SIGN(buf[0]))
-			mt->o_slope = -MT8173_CALIB_BUF0_O_SLOPE(buf[0]);
+	if (buf[0] & CALIB_BUF0_VALID) {
+		mt->adc_ge = CALIB_BUF1_ADC_GE(buf[1]);
+
+		for (i = 0; i < mt->conf->num_sensors; i++) {
+			switch (mt->conf->vts_index[i]) {
+			case VTS1:
+				mt->vts[VTS1] = CALIB_BUF0_VTS_TS1(buf[0]);
+				break;
+			case VTS2:
+				mt->vts[VTS2] = CALIB_BUF0_VTS_TS2(buf[0]);
+				break;
+			case VTS3:
+				mt->vts[VTS3] = CALIB_BUF1_VTS_TS3(buf[1]);
+				break;
+			case VTS4:
+				mt->vts[VTS4] = CALIB_BUF2_VTS_TS4(buf[2]);
+				break;
+			case VTSABB:
+				mt->vts[VTSABB] = CALIB_BUF2_VTS_TSABB(buf[2]);
+				break;
+			default:
+				break;
+			}
+		}
+
+		mt->degc_cali = CALIB_BUF0_DEGC_CALI(buf[0]);
+		if (CALIB_BUF1_ID(buf[1]) &
+		    CALIB_BUF0_O_SLOPE_SIGN(buf[0]))
+			mt->o_slope = -CALIB_BUF0_O_SLOPE(buf[0]);
 		else
-			mt->o_slope = MT8173_CALIB_BUF0_O_SLOPE(buf[0]);
+			mt->o_slope = CALIB_BUF0_O_SLOPE(buf[0]);
 	} else {
 		dev_info(dev, "Device not calibrated, using default calibration values\n");
 	}
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
