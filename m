Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C46C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:47:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0FD2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CifqUQb4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="adokA4UX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0FD2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HpjatPgoL/pmPs72slQpFeKHvAmbONmzL2Y+wFao2lQ=; b=CifqUQb4MkZN6A
	bSou7Nj52OF/x6YVCLd2wPFaMbGvnrXX89NOY/0qBraDfk3RkQ5rTmXVgh6eSJ6aUR1ggeCn79fo5
	ULScv7N7nBBldN0eF5SzB1OsFEPeP+Y3t49VFcCB3rySFYsaKseAxN2M6PZCEfV4WeVph/crK/wiB
	HySsbKOb9HKjAO8X+9HCCv/74FnfwLQaIHONfzZxIVJgZBt8zzZ+J5k0k0Sn733hSts3TfKHb47qb
	zo/bNiifFskBKq4ZN0Dvq6/7AfU8AwAzWaWc1MNY4e6FMQ/IwFIHRx0XarjLXYm9nJ4sQ7gVapuis
	rCX/83paVyfxchUwEOGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr20S-0007FN-Px; Tue, 05 Feb 2019 14:47:24 +0000
Received: from mail-oln040092255079.outbound.protection.outlook.com
 ([40.92.255.79] helo=APC01-HK2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr20G-00075R-3J; Tue, 05 Feb 2019 14:47:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9HnpVItEYHYJqrFtuBf1r+In2WsgLBgVLV2JnssktY=;
 b=adokA4UX/rWrTaNBZtao5AcYTy5LoBcQdT3GGI/4lLAgkK+8APBB+ka3zI/LFwq1YpFoqOBaEd/3bki5Ys6hp0/fIRmY6umW2FwIfKxY8X/MyqdHZADnkW4+IAxfAZBEmEQMDhmrfaMavfe2om1txnFDa1Q8zH9uoAc4V/6Cbbexr4PmT9I7+deBPdG2SrVUDvByFQbPwSM//3kjrweKNGqnYma62bSQNLZSCM3zRZUXGQW7AYedFWQqf0dNk5lEbcDyWkOl30gtYmjcHuXI9bUpjhoUlpw6j5b+ogyXQvZrhquYMEng8WJUoFsdZdHSeBYL5czhZxEst1MP1oOrHQ==
Received: from SG2APC01FT029.eop-APC01.prod.protection.outlook.com
 (10.152.250.52) by SG2APC01HT183.eop-APC01.prod.protection.outlook.com
 (10.152.251.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Tue, 5 Feb
 2019 14:32:41 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.250.55) by
 SG2APC01FT029.mail.protection.outlook.com (10.152.250.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10 via Frontend Transport; Tue, 5 Feb 2019 14:32:41 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 14:32:41 +0000
From: Wen Yang <yellowriver2010@hotmail.com>
To: "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
 "bbrezillon@kernel.org" <bbrezillon@kernel.org>, "miquel.raynal@bootlin.com"
 <miquel.raynal@bootlin.com>, "richard@nod.at" <richard@nod.at>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "computersforpeace@gmail.com"
 <computersforpeace@gmail.com>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>
Subject: [PATCH v3] mtd: rawnand: atmel: fix possible object reference leak
Thread-Topic: [PATCH v3] mtd: rawnand: atmel: fix possible object reference
 leak
Thread-Index: AQHUvV+m1re+sbN8CUyeyZ1eIQZc2A==
Date: Tue, 5 Feb 2019 14:32:41 +0000
Message-ID: <HK0PR02MB36344D81C6E66666EB60849DB26E0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::16) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:B4C0E8A233F2D8D0DE2C6EA4B0FAA25EBA5A13D381CE9EC180357306F62F8937;
 UpperCasedChecksum:9A4CEAE0CEC97D30EE15055BFB0629725377F9AF780B3B4F2F1B2EF5ED71023A;
 SizeAsReceived:9201; Count:63
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [qS0A176wWwfB8thTCP8r02C2T6egk0C9]
x-microsoft-original-message-id: <1549377099-4851-1-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SG2APC01HT183;
 6://gSrP+55bBVVBov9+s4j2ZlxD+TDwN4nF9V+bEz4Da3yPgx4QJvS6zL0d0wM3sfSDCPHgIqqLrkjyMgfGBw5bPLuZqmCgFwAnJbFMQAvUni3czLFD+FekpYLv1up8nE3TJ8H7yazs6OdwAzAeVjCEHVyJOj7o0GCoSH2SmJSA4uwWGEwl2mbR3hy/3kbA4NH66+a3pDcvvZNFQJQXUttQUUcjLQ44zd9ovRy9vlHn/IiBlxcGaa4Wgn+HekLs1yR72Ixfjznh4xk5h6Hoq+oCxl2Y/HH8RKlCTsIgV/tRSNHu2lcTn43aBCwtk/JLaoDzB41XxNfuH+TwSKFh6CuYuF763mTMHR0tftBC/95TSuEYSF+cU6fJju1rzeU6bti6NLrJWV/tq5tTs5owLEZ/tTAuUK3s+lSV3umZ654IRN6PKfZPI9LZb+0gzKHonTJMe0pKfndarCV2PADzAlwA==;
 5:AUrST+jGW/nFWf3CJb0LNh6Y30oCLrbO1bK1/mKIgx6cb5l7emIptlOyZ2XHWHs8Tdqx7yRL18/7KSYXi1iNuiICbJeykTv53tf8RjjhNYXnjfOrzGKVn3du+kWWsRbpmURTnpLD/J3vkRisIOg/YgEZ/DQ7NbltCBhFrWoyROQtuLKLQ80PZt1iJMMx2PJ9PU8QENTR/M/XTYl9FgYJzw==;
 7:v4D6XSIP/BImCAcOC5LPIZn+XCqBXksxaYEFKRfQBgbLUMKHz1cFfLfq6fwLTWC5MaT84QeV5UudLph4h1ArFjoWXEx9z1d4gOOhbkgksZuNr3HNyrkZ2FZ7IiUDgJYXlhCPgDwpsXGPaq/dqIRFJQ==
x-incomingheadercount: 63
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: b0omxY8GwpakhZQne8YdzZ1d6kZpGUpuepEVxBWybAmi5yBnWkDNauLyUBa155M5QmisQWNIY5w0T1zJogjIhk9t2y1kfizhtfGeAjZxE6hHcoEF4y7FCvh/YmF2lPEquGBR0ZyWB3sYeiJfh1sAnUo30VZOSaGcdW8delDW9dCrolPXNsZS0JDHnE9grNTm3ebchKcONIJlB8j9hudOrIqX1h9ZwmXuXp6Xj6bLoItueHMQbmykj+WrqV+lgR1r/biukYdqhgRHf0a7O0il67Do1ECwMQ43EzZYbmG203GMhZzqOtSoxtD3NUQxC7D7VBDZiGAHbAykUolk5f71JmWx/ZlKlwBfvslsT8o0XGFwO3o1ELd/N+ImiILsgVIFOq+Q4fXNCZovok9a7wPgkS/xuD9CioNYe7xOZQPnXmwZbfN1s1AhlisQexemIwLrbqpjT4scr54GkY2q1KkSQTOVaIidMoSqTl6Y44O6i4Zqy7/sxrHTbouTUR2+gXBbhDOcxwaCmaqh8FHs6SSWM5SyfmHiPsKq4EZst2jbqPF2uqne3xi4+cZBMxhIyhoQP0b/BMkv7OtMhiay+NiXiicbCUNm/zKdrDl24v2xcYaG3Fa08FICQ8Fej20DxyMcLD5UOASW+rfaTtjHCBRN2oc2uLM/wRJXeK7ktIHxnc9d59y/SmE4+rkqwq/MowrXcIngYPYvszKucmsgKpSH7BTJ8f6mxylfxZ6oO0NrOKN813AvXbHydHxdsARVIIWv
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:SG2APC01HT183; 
x-ms-traffictypediagnostic: SG2APC01HT183:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:SG2APC01HT183; BCL:0; PCL:0; RULEID:; SRVR:SG2APC01HT183; 
x-microsoft-antispam-message-info: jacz8MV3PpodC9fXzNxya869SQIb049f8+YhAiZLqMPInAwiiLfs+5ZtORsHnXJh
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6e241d-d490-4590-2bf8-08d68b76c888
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 14:32:34.4960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT183
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_064712_209163_E0F2A2DB 
X-CRM114-Status: GOOD (  15.79  )
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
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
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
