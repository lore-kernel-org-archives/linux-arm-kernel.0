Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21281C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:33:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64882147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="miyamghI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64882147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rB4/rVN5bGbvljbNov8/JOH/1VntIDKUjxXMGAGRAHU=; b=miyamghIkI+6LK
	8xluLtEo8kdhojJboMLXMK2dCxfzUEs68z36HaYEXfDJYB6Yjv91FhWLLFrLmb53sKvQT+VB3Kw8D
	IF7A3FFjQ4/V9OhIXbcIRMQsPbO9OUBlAbkyyRuLV4xziZUvnMrwM5OY2NI0+/B/7e3Jwl3TTvH/A
	k2Zq6v/Ljp27DFGyqqeKCXqjXnKJx2eJT3lT7k6l5RabwfX7ZzBkDL/5qsSn8RcDD0V8y/PQ9Sf/0
	x6a4oeDRdQks2VlIr69ooxKDdXEeMNQSBbNBVLiUETMrFCQIPC+XGl0O6VzKNnty0IFM19SaRcI0I
	skTdlt55rl6+h10P/dEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwR4H-0001g5-8r; Wed, 20 Feb 2019 12:33:41 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwR3d-0000rr-G6; Wed, 20 Feb 2019 12:33:12 +0000
X-UUID: f52d3f0a09694213aa18a7637b0859b6-20190220
X-UUID: f52d3f0a09694213aa18a7637b0859b6-20190220
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <michael.kao@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1969218810; Wed, 20 Feb 2019 04:31:45 -0800
Received: from MTKMBS01N2.mediatek.inc (172.21.101.79) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 04:31:44 -0800
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
Subject: [PATCH v2,3/7] thermal: mediatek: add calibration item
Date: Wed, 20 Feb 2019 20:31:29 +0800
Message-ID: <1550665893-22561-4-git-send-email-michael.kao@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550665893-22561-1-git-send-email-michael.kao@mediatek.com>
References: <1550665893-22561-1-git-send-email-michael.kao@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: A680BDA5DBE42D0DF397EB212030EB7EF88D2FAEE9FBF70178385BBFADECA3752000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_043302_295657_00345B22 
X-CRM114-Status: GOOD (  11.46  )
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

Add calibration item in thermal_data to support
the project with different calibration coefficient.

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
---
 drivers/thermal/mtk_thermal.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 07f8ad7..45c6587 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -105,6 +105,9 @@
 /* The number of sensing points per bank */
 #define MT8173_NUM_SENSORS_PER_ZONE	4
 
+/* The calibration coefficient of sensor  */
+#define MT8173_CALIBRATION	165
+
 /*
  * Layout of the fuses providing the calibration data
  * These macros could be used for MT8173, MT2701, and MT2712.
@@ -147,6 +150,9 @@ enum {
 /* The number of sensing points per bank */
 #define MT2701_NUM_SENSORS_PER_ZONE	3
 
+/* The calibration coefficient of sensor  */
+#define MT2701_CALIBRATION	165
+
 /* MT2712 thermal sensors */
 #define MT2712_TS1	0
 #define MT2712_TS2	1
@@ -162,12 +168,18 @@ enum {
 /* The number of sensing points per bank */
 #define MT2712_NUM_SENSORS_PER_ZONE	4
 
+/* The calibration coefficient of sensor  */
+#define MT2712_CALIBRATION	165
+
 #define MT7622_TEMP_AUXADC_CHANNEL	11
 #define MT7622_NUM_SENSORS		1
 #define MT7622_NUM_ZONES		1
 #define MT7622_NUM_SENSORS_PER_ZONE	1
 #define MT7622_TS1	0
 
+/* The calibration coefficient of sensor  */
+#define MT7622_CALIBRATION	165
+
 struct mtk_thermal;
 
 struct thermal_bank_cfg {
@@ -188,6 +200,7 @@ struct mtk_thermal_data {
 	const int *sensor_mux_values;
 	const int *msr;
 	const int *adcpnp;
+	const int cali_val;
 	struct thermal_bank_cfg bank_data[];
 };
 
@@ -295,6 +308,7 @@ struct mtk_thermal {
 	.num_banks = MT8173_NUM_ZONES,
 	.num_sensors = MT8173_NUM_SENSORS,
 	.vts_index = mt8173_vts_index,
+	.cali_val = MT8173_CALIBRATION,
 	.bank_data = {
 		{
 			.num_sensors = 2,
@@ -330,6 +344,7 @@ struct mtk_thermal {
 	.num_banks = 1,
 	.num_sensors = MT2701_NUM_SENSORS,
 	.vts_index = mt2701_vts_index,
+	.cali_val = MT2701_CALIBRATION,
 	.bank_data = {
 		{
 			.num_sensors = 3,
@@ -356,6 +371,7 @@ struct mtk_thermal {
 	.num_banks = 1,
 	.num_sensors = MT2712_NUM_SENSORS,
 	.vts_index = mt2712_vts_index,
+	.cali_val = MT2712_CALIBRATION,
 	.bank_data = {
 		{
 			.num_sensors = 4,
@@ -376,6 +392,7 @@ struct mtk_thermal {
 	.num_banks = MT7622_NUM_ZONES,
 	.num_sensors = MT7622_NUM_SENSORS,
 	.vts_index = mt7622_vts_index,
+	.cali_val = MT7622_CALIBRATION,
 	.bank_data = {
 		{
 			.num_sensors = 1,
@@ -402,7 +419,7 @@ static int raw_to_mcelsius(struct mtk_thermal *mt, int sensno, s32 raw)
 	raw &= 0xfff;
 
 	tmp = 203450520 << 3;
-	tmp /= 165 + mt->o_slope;
+	tmp /= mt->conf->cali_val + mt->o_slope;
 	tmp /= 10000 + mt->adc_ge;
 	tmp *= raw - mt->vts[sensno] - 3350;
 	tmp >>= 3;
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
