Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0B5C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:42:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BB9D2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hii+UCIz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="d43G9O3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB9D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uzhq1VCEncfRrGHBNkv4ZuDgou4IsdBnIJw0nuhwi/I=; b=Hii+UCIzu5pSb4
	pPDi5KVxCe18IDMFKUNr39louRBGBIl6XYR0BHZoCOLrnIVC3JBl5VCkYHmI8PldfbPnN5iBFMtmn
	C+KI+4KXs8ssTF2l6wFhgcjsC7Y13WI713aDF8jMP61e7sOTB58LTMSX1kK7avI2TxFikY8ufxRHo
	GzzubTHaswbH6cfMb4t/9W0GVnkLOSDdzL3GPtKRObhHfeFrOzUyUfbr3LGyY62E86AzeQpQg2+Vz
	MynVJXYyzdyuLRXp5/n/dCxSPEHOJPrxXwtpeSxnA4O9ob+O4Llbn9yo5RjeQqUGumMDSjD/f5GL/
	5Y/hknsB0LdgIPv68JQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqH65-0004tQ-Ru; Sun, 03 Feb 2019 12:42:05 +0000
Received: from mail-oln040092255017.outbound.protection.outlook.com
 ([40.92.255.17] helo=APC01-HK2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqH5t-0004ke-Qh; Sun, 03 Feb 2019 12:41:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAwzpoYuxG2G3e65QplGFobJhw+valuMV3YWg8idst8=;
 b=d43G9O3TJULXDMFu8JQnIEQxAZ4C7YisNqHhizTicH9xG4pXX1eNKZJZNI2JCvToe0Sz1RZg8CV+/gb7lc+CJP3asMzsu47cEGAZbpdzEDn9FMRtismt7btOVZboaKhcXJ5A1JIaQ+k6K62qwD15mn7I1Z8kR+Ub1hRv1SwlGcsfcY62zCedxKgUPyOkWR2Z5sdQ9U/j/LJhANJC4ZhXLqATqOT0HfXPmsMiSa3BWDe7zk2Tvfi7d/c8h8uptTvXcP2neejeBv91i7dpacLS0oTzvmnIJAufwFsRSWAAuWuiLo31Xsp2bXTR4wcxehn2BYgVI+z9e6rfjFeCP0x3xA==
Received: from HK2APC01FT022.eop-APC01.prod.protection.outlook.com
 (10.152.248.59) by HK2APC01HT012.eop-APC01.prod.protection.outlook.com
 (10.152.248.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Sun, 3 Feb
 2019 12:41:45 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.248.59) by
 HK2APC01FT022.mail.protection.outlook.com (10.152.248.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10 via Frontend Transport; Sun, 3 Feb 2019 12:41:44 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1580.019; Sun, 3 Feb 2019
 12:41:44 +0000
From: wen yang <yellowriver2010@hotmail.com>
To: "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
 "bbrezillon@kernel.org" <bbrezillon@kernel.org>, "miquel.raynal@bootlin.com"
 <miquel.raynal@bootlin.com>, "richard@nod.at" <richard@nod.at>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "computersforpeace@gmail.com"
 <computersforpeace@gmail.com>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>
Subject: [PATCH v2] mtd: nand: fix object reference leaks in
 atmel_pmecc_get_by_node
Thread-Topic: [PATCH v2] mtd: nand: fix object reference leaks in
 atmel_pmecc_get_by_node
Thread-Index: AQHUu73SCSNSSggsN0aLoXq1/0IpPA==
Date: Sun, 3 Feb 2019 12:41:44 +0000
Message-ID: <HK0PR02MB36342EEC848C39F479D0063CB26C0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0P153CA0043.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::31) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:5B33B7C22535DE7FBEC6C36AD1F0DB1E8C0AB4AE66C0E1872E5F4044693493CD;
 UpperCasedChecksum:7C3406CF91BBE766A2002B3DDF0EB1FF56A1ABDE9A653AD962AE9DEB077FFB25;
 SizeAsReceived:9232; Count:63
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [3kRbE5HLcoim73qXtlEPIMk+2EShImWA]
x-microsoft-original-message-id: <1549197543-9360-1-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HK2APC01HT012;
 6:gOJaXddIuK1eLb/dM9u91TdE/heGNnNo14Vxu2OrsnlFJHgxTCLCgy72vUaFnGTX6XklrlT29V51ggMSrwwT5mDkzb/7WVRvCkd/hg/CmVAzMuHsImiMu+GlMkStyz7yV7/GYhRp3dZJsMdaLnXupGCgJkIKTbb2QFsFW5iVEyTZ42wQ8pbssvijgETGodZ1plsFR5DbKOtaxLcbMIjQo+Y7sSnGBwHZwpyOxXsBhXK2ibOub6ociXnhI5EHIy/PI++RlIIoIlGxD8jtv0Ehj005/QHq9JN6qoNrfMmmIrCk0fSmfDpRcRJ/HYFwgYTrsXXXCZVfer59pDfqxxG6YB/IMewCglUA8jvRUV79sCHCpcinWmjmJn74nKb1hST3v7pxoV2gQyl2+XEo+GZiAOFODK28CDCKfPQAYB+0EVO9tFrLwKk4WGrkx5SAbBIUObHRiwPoFRWxFxF2549n2A==;
 5:JtqOjOAWBIZDH52LqXx1My+956hVK0NfMiZ1XxeeSh6lFmG0gsFJIYka79MjKhhi2ScBPYLZQlaqfoPPEzmFwzgxalXBdFidk5tbxqYL7eVz4lzJbPuLTwSkfCpl5OKpNRSziDCKejKVN1U5TOGr46OhPXpgWLCVZ9hrIdFt+kVbXY/7N148AVLp2a1QSqk3ZPVu8OkFaRdCCXoM5eKaDQ==;
 7:OoE0AqhqcZ03AmI2RvhTUFQkOEs+pJeXCd/6VuO6VyBJphota4EbZqrcjhGtUwuT20rT1PmYavWsSv3ispoEMXvecbmVwWWVebLhP1+jomcsmwwScrfNNhR8UhwFSfQ/pV+MbUKweI0LKPOAMMlsxQ==
x-incomingheadercount: 63
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: b0omxY8GwpaAecEcUGxGpUaKsh1rCi9Ll3wAJSk8ROwxE5AO4L6djOqmo9AGLVvvMqJDFwBQyaIRBM1ZeZ4wPS/si+NDrfjd+cUWUhv/PVKCWVVz8PH764IiDNZIe0lT7RrkB/mJHK+as66gIkliQAe3K5crPtX2UWlKmgdEV6fiuhCuqvwyBB/4BdDrvhv/evrPGxfUwB8COGC9oZ8b4bCZz3v69CnEatoCPFG/OydZ8dlf24H5d/Sv7PmzfZqqRNjwgI/Xwda4ASbPfFkr0v0SyGauPAJWEhtnIBYvtorsWXi4ccq0afV4zAp1NNCK51K/9y2gvulz8p7+mOd8eyT3iLlwRwWacCnF+D3/HGUB7pVm4ITZ6+JU8EqN+FfCdygYN9Sm1ewv+nR2g3w9Qvvbb4Zh/s/PF7i303Zcq2koeQSmhDW/aPpzaxUAFya3IPO4JG7/Q9dBKHY5p8ggspZmaJLef+bQvYfxaH4988NPMsT16CvvRpA2t42IP0XllyCjLH5EFe4mwWQverWBxiFwy8p/RI4VNNGDYwgXVNn4cOKIyP1RwVU0bq+ksgiUcBMy+Pgn4+2sAeCdTdGtwrtrr2pe/PeEp4b3yHCGj1ln7OjP4iGOCs59Jd6DpD3C/kLUSe8o+vJGqiZI+DewyYnyYFj//ZQ9eIDvKHQ2UGSaDQ/3/KyuCtcaWBwwTCLKfvjP0Ix+QEYD5ln3sv5Xrj3ZcPUWkMUp1hjmIbWEgG25VDvgAMe+70tI9jmIjuXP
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:HK2APC01HT012; 
x-ms-traffictypediagnostic: HK2APC01HT012:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:HK2APC01HT012; BCL:0; PCL:0; RULEID:; SRVR:HK2APC01HT012; 
x-microsoft-antispam-message-info: fI/y5d0UEVaCAY7TPYy0J4WDJd28a43X9GPU5VRJkX4jZKC+Iaov+vDwxuwoxO8W
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e7575b-c36e-473c-1ceb-08d689d4f440
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2019 12:41:43.5622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_044153_956024_86444EA3 
X-CRM114-Status: GOOD (  15.41  )
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
Cc: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 wen yang <yellowriver2010@hotmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

of_find_device_by_node() takes a reference to the struct device
when it finds a match via get_device, there is no need to call
get_device() twice.
We also should make sure to drop the reference to the device
taken by of_find_device_by_node() on driver unbind.

Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/mtd/nand/raw/atmel/pmecc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
index 555a74e..1477368 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.c
+++ b/drivers/mtd/nand/raw/atmel/pmecc.c
@@ -876,16 +876,22 @@ static struct atmel_pmecc *atmel_pmecc_get_by_node(struct device *userdev,
 {
 	struct platform_device *pdev;
 	struct atmel_pmecc *pmecc, **ptr;
+	int ret;
 
 	pdev = of_find_device_by_node(np);
-	if (!pdev || !platform_get_drvdata(pdev))
+	if (!pdev)
 		return ERR_PTR(-EPROBE_DEFER);
+	if (!platform_get_drvdata(pdev)) {
+		ret = -EPROBE_DEFER;
+		goto err_put_device;
+	}
 
 	ptr = devres_alloc(devm_atmel_pmecc_put, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
+	if (!ptr) {
+		ret = -ENOMEM;
+		goto err_put_device;
+	}
 
-	get_device(&pdev->dev);
 	pmecc = platform_get_drvdata(pdev);
 
 	*ptr = pmecc;
@@ -893,6 +899,10 @@ static struct atmel_pmecc *atmel_pmecc_get_by_node(struct device *userdev,
 	devres_add(userdev, ptr);
 
 	return pmecc;
+
+err_put_device:
+	put_device(&pdev->dev);
+	return ERR_PTR(ret);
 }
 
 static const int atmel_pmecc_strengths[] = { 2, 4, 8, 12, 24, 32 };
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
