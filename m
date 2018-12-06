Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA53C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:24:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C20FE20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GCXAa1Uj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ylaD4aM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20FE20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KHCr78/9piuTfjvuLcf+iDfnWEvrULyQJUXzO1EiIPQ=; b=GCXAa1UjNRFfVr
	HQR7zVcbE1Ip7l8udlhwgMNsYpLrogwchqJ6uMCsTG4SfDcknV4ogxS37q6zPmXATl4TSY+eGBlB5
	TqEvau94Uleou0/i66sp3Cf2KIpZzUIjIvwfXXbqWqIsufzzTtOSqOLIgLDsnemK6uMxjnCRiNSM/
	YB8VM1RQrW1MGU9qGQFqOK92uH3qojIbaiWLhnGKQ4mFS5oonfUGQNPubYbm8T5ke+o0iy60/EcT2
	nESVEUpH8uQcsuG6lYSz+1uMclLYJmatG66/fcnZGV+1DIKyQXwnAJph5zKHhPKTtzu7mLumwCzOU
	Rg4Ld8qtzuPWITMRBANg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUtdc-00052g-IR; Thu, 06 Dec 2018 13:24:20 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtdK-0004kU-PZ
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 13:24:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:
 From:Sender:Reply-To:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+UcTH67XWbk9Y/IUYDWID0jdhCfeATeEP+3eC4a0ZJ0=; b=ylaD4aM5G64AsWuyI6vsUrtOZ+
 7BhF6xKPnC8fx1dL6/PapI09aoviTR8/kwZ+1BelaRImaBkrN2ou5QNr7LDaV/XxAtIfYujyGChVH
 EVSzF+M0Py+maIkTjnaOu8z+MNKOkvWpASc+fI1AEYZZPRiMgqeuGrztK3NzCRu46zw4C/Hlp1DiP
 R0yNFmfbRVZDpv0ZzO2S8L9ThOJHQEXAXTr+Oo4w3LFYcSH6uSk3UdWEP9A2hYVb6NhqUQ+c6kqdw
 26jA6LVBiB9uJgBslTQ5YatJYRwwAjv8Btq/mOP6B6ogiFog4sILnrCfnsaG5KuMZojSSllbQgRdA
 RlO5Zf0Q==;
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtdE-0007JS-GR
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 13:24:00 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wB6DLioP003599; Thu, 6 Dec 2018 14:23:34 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2p3w2s46ab-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 06 Dec 2018 14:23:33 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3F75841;
 Thu,  6 Dec 2018 13:23:33 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E4BC92AAF;
 Thu,  6 Dec 2018 13:23:32 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 6 Dec
 2018 14:23:32 +0100
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Thu, 6 Dec 2018 14:23:32 +0100
From: David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre TORGUE <alexandre.torgue@st.com>
Subject: [PATCH] thermal: stm32: read factory settings inside
 stm_thermal_prepare
Thread-Topic: [PATCH] thermal: stm32: read factory settings inside
 stm_thermal_prepare
Thread-Index: AQHUjWbi+FUfeo4eoUu6YgNgwgJR0g==
Date: Thu, 6 Dec 2018 13:23:32 +0000
Message-ID: <1544102603-14899-2-git-send-email-david.hernandezsanchez@st.com>
References: <1544102603-14899-1-git-send-email-david.hernandezsanchez@st.com>
In-Reply-To: <1544102603-14899-1-git-send-email-david.hernandezsanchez@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-ID: <8A51B9C2EFA6614BAFFAA4D04E97DAB8@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-06_04:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_082356_992753_64E34A49 
X-CRM114-Status: GOOD (  15.12  )
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

Calling stm_thermal_read_factory_settings before clocking
internal peripheral causes bad register values and makes
temperature computation wrong.

Calling stm_thermal_read_factory_settings inside
stm_thermal_prepare fixes this problem as internal
peripheral is well clocked at this stage.

Signed-off-by: David Hernandez Sanchez <david.hernandezsanchez@st.com>
Fixes: 1d693155 ("thermal: add stm32 thermal driver")

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 47623da..daa1257 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
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
