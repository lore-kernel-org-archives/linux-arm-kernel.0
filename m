Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8AEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:13:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1E320892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UmSBmfru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1E320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/GcIxOc8M5DMPFm1UgtkTJden+dqeAwyKBZTgPGjpVU=; b=UmSBmfrugQZJwu
	FvbA/XymozFrAeUFl5BxDlu0vM+Q4e7B9b8LD+EjP80q+4hEV1Y/9riCM5MtDDytEr413owwuZpZr
	an5aGsHvRKFYQsp3ZcsPB65lICNOqYGVCgKAz5SwlkcakNOQfhgUaCkk4o0SJURd+Eifj4zST0O4T
	f0glQvRreL51YJTMFUvyIv/evKRQ1M4nF/gtAppTYGtRM1Vw+8CiZ1yJgD6e2lvGGKoyk61wcnAn4
	OL4CzkC9TSA6/9poILBP6o8n3tU3gbHYonMIATQTnp2Ai2yqQwcfNHe3RJKLgJSLDiOKsOvl8KYgc
	g7JWGbOfDqTEfztvPiwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUpj6-0002Oa-IE; Thu, 06 Dec 2018 09:13:44 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUpiq-0002OA-DG
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 09:13:30 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wB69BVNx009594; Thu, 6 Dec 2018 10:13:06 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2p53mbaa7n-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 06 Dec 2018 10:13:06 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7EF4E123;
 Thu,  6 Dec 2018 09:12:57 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 425292479;
 Thu,  6 Dec 2018 09:12:57 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 6 Dec
 2018 10:12:56 +0100
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Thu, 6 Dec 2018 10:12:56 +0100
From: David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre TORGUE <alexandre.torgue@st.com>
Subject: [PATCH] thermal: stm32: read factory settings properly
Thread-Topic: [PATCH] thermal: stm32: read factory settings properly
Thread-Index: AQHUjUPg9X1K8GffyUyGZZ5N7LVjEQ==
Date: Thu, 6 Dec 2018 09:12:56 +0000
Message-ID: <1544087575-22242-1-git-send-email-david.hernandezsanchez@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-ID: <1CBBC0193CA97B4DAA00046551B7631A@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-06_02:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_011328_735031_2AF27D81 
X-CRM114-Status: GOOD (  13.18  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Call stm_thermal_read_factory_settings once
internal peripheral is properly clocked.

To avoid wrong initialization of fmt0
(stm_thermal_sensor struct) member add
brackets properly.

Change-Id: I150d00fd50e382df04bfad12f0653b1ed6a1db1b
Signed-off-by: David Hernandez Sanchez <david.hernandezsanchez@st.com>

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 47623da..bbd73c5 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -241,8 +241,8 @@ static int stm_thermal_read_factory_settings(struct stm_thermal_sensor *sensor)
 		sensor->t0 = TS1_T0_VAL1;
 
 	/* Retrieve fmt0 and put it on Hz */
-	sensor->fmt0 = ADJUST * readl_relaxed(sensor->base + DTS_T0VALR1_OFFSET)
-					      & TS1_FMT0_MASK;
+	sensor->fmt0 = ADJUST * (readl_relaxed(sensor->base +
+				 DTS_T0VALR1_OFFSET) & TS1_FMT0_MASK);
 
 	/* Retrieve ramp coefficient */
 	sensor->ramp_coeff = readl_relaxed(sensor->base + DTS_RAMPVALR_OFFSET) &
@@ -532,6 +532,10 @@ static int stm_thermal_prepare(struct stm_thermal_sensor *sensor)
 	if (ret)
 		return ret;
 
+	ret = stm_thermal_read_factory_settings(sensor);
+	if (ret)
+		goto thermal_unprepare;
+
 	ret = stm_thermal_calibration(sensor);
 	if (ret)
 		goto thermal_unprepare;
@@ -636,10 +640,6 @@ static int stm_thermal_probe(struct platform_device *pdev)
 	/* Populate sensor */
 	sensor->base = base;
 
-	ret = stm_thermal_read_factory_settings(sensor);
-	if (ret)
-		return ret;
-
 	sensor->clk = devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(sensor->clk)) {
 		dev_err(&pdev->dev, "%s: failed to fetch PCLK clock\n",
-- 
2.7.4
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
