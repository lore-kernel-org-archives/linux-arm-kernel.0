Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7879AC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:53:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B0D2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NnpIAWAF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="AD3WO2Yw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B0D2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2kyG3032u5dNZ/P6PBKJWEqA4Tyr9GvYdJqMJrrxPrc=; b=NnpIAWAFl/12Dr
	4EWm4rk+1fvtDwF2lo6VV1dfHIuVwqT9b7MI6B171U47w+8+ZimkSYpw5BezbnuX5dFoNLEVeHIOb
	AZ7TcilAqvBXFkOYkgw/cOdfK1VfmMMuYn1o3rAVwjBpN/T8czDvquoLS1o7SI55BkXaiCzMmupzO
	hj087sfgooF5LcYmx+EHAL8JFrm8JYCz86g72n7VEEMA1aPYc4GFmw+MLAkd4C8ivrjUyDQEraHNp
	tf1r8rB+5ThY1HAcpuZzvDksegQbE3Ai/iv9h5c8ghZyUqFzBQCNvPWMHHSY4+ICMS+WlCMr+eFHb
	cqtP5ItEpbKTbg6FUvSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grakB-0002NM-Gw; Thu, 07 Feb 2019 03:52:55 +0000
Received: from mail-oln040092253048.outbound.protection.outlook.com
 ([40.92.253.48] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grajy-0002D3-7E; Thu, 07 Feb 2019 03:52:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/mOpTOHc6sHxOe1fGdHPZBgJK5+YVUC2BBnz++s3pU=;
 b=AD3WO2YwVKeXR/FTKVnjKaX8cqgvZ+jhc+1ykZWRPj8WPcVIKSbpslSutXUvxk9m8YwHXEOm48P9/Jaf9nj/fSMMOYFQ2LOnyLANUh586108EYTjnXk1Z28MAY3VsLwoAtp73TUQ4/UsyWTqoz+fQIGcCvWyYzwLA94fNCRDRSCL37wuFu5gGYigHWuHSasTLoOdnwlWaqx1j2zGk7xLxvyAT7V4XxV2wGVUYTRfxrmjZf7laVby6GnbdoVR+aG6qq2XS2M2kcdETWzeaq6Fzdp9KVTVaFVvLnvCd8DnelBR3Dp0NO1YJNXU5NJuDT/xd8cAFX2f0Dv4BhkNK3nSzw==
Received: from PU1APC01FT039.eop-APC01.prod.protection.outlook.com
 (10.152.252.56) by PU1APC01HT091.eop-APC01.prod.protection.outlook.com
 (10.152.253.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Thu, 7 Feb
 2019 03:52:31 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.252.59) by
 PU1APC01FT039.mail.protection.outlook.com (10.152.253.127) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Thu, 7 Feb 2019 03:52:31 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1580.019; Thu, 7 Feb 2019
 03:52:31 +0000
From: Wen Yang <yellowriver2010@hotmail.com>
To: "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
 "bbrezillon@kernel.org" <bbrezillon@kernel.org>, "miquel.raynal@bootlin.com"
 <miquel.raynal@bootlin.com>, "richard@nod.at" <richard@nod.at>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "computersforpeace@gmail.com"
 <computersforpeace@gmail.com>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>
Subject: [PATCH v3 2/3] mtd: rawnand: jz4780: fix possible object reference
 leak
Thread-Topic: [PATCH v3 2/3] mtd: rawnand: jz4780: fix possible object
 reference leak
Thread-Index: AQHUvpiNjvvHcFETJk6ZDu2Hv+MqPA==
Date: Thu, 7 Feb 2019 03:52:31 +0000
Message-ID: <HK0PR02MB36344D1C4321EA844316EEAEB2680@HK0PR02MB3634.apcprd02.prod.outlook.com>
References: <1549511278-7735-1-git-send-email-yellowriver2010@hotmail.com>
In-Reply-To: <1549511278-7735-1-git-send-email-yellowriver2010@hotmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR06CA0022.apcprd06.prod.outlook.com
 (2603:1096:202:2e::34) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:F9A676279358872DB67E4E458995487A20655766AEB1C76E011F39E01D00334C;
 UpperCasedChecksum:6258203BFB8D8173B62AB72CF640D597FBCE1DD319622E0DD3E5159221D3790C;
 SizeAsReceived:9417; Count:65
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [U81r9HGwCICxmTqhgLDqB6GsSrr/D06q]
x-microsoft-original-message-id: <1549511278-7735-2-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; PU1APC01HT091;
 6:hRs2tKhL3NyexlRYxcy3BO+qvquHn108ilOxNMvRiJPHN9wW0rng+UBcR0vs1wkVM9Qtzgzcg51GABcaZRqjDvj9MueHvKh9WTQxlbhDkfWFkadTPRuJhJAiCq07212iYTzdSxE361zFYcaIYY7To5vKpxhU0G/WGO3D7NLTvHjZtQTPGsZGbAPzplKDF9dOnaZKfF3cKkMA+4wHj1c4JxsqwdRne1OAvzPMxdAXmfXhypPCCWaCFD8x0MXbWTLYvLHK84mX8mMEYP1bU2CTfV1D7oj1kzNacnxn4aBsyoPoI8FfGsPYFewJiWQFR1eOgAxuIlgBDPNkhUOoRP+3Cn4Pxn61d1IUblLl8CDbDtcqMRKv6LN1mG0o4W0kfJfZYbAJOwXYIlAVGUvLlJyIZ3CF8kImW9BGfPQIVjjozwwsQloa5LC774RZz0DZ3jLORiIRGorHyArBRQ0lzZ/qhA==;
 5:GK0+Jp/4UnWk0XtEswbFnFznFrqkimuiSYtTEACZ8iQXwXKy55MviUFxbDKdoZkydlN1N3Td8oyDRzzk26SbjfFNbhAHZbOg6AfgvHV/1DLZDBEOgKJQ12KF0sztSu0HuOPJuqA4RV7wofV2PE9bhF6Vi9xa/2LcpXwpLK7SNw6jnup2IIXc3WU5FZ5BVZYqH1HlG6aB/nRyBemZnT3Zug==;
 7:LeERfQ5EmQIMC6960I9p6eaUWENGD5y1vsxANk3El6mWQQ5cA061Q6Hamume16YRRCnr3pPNq7XI/8g5BcoPpDLdtfdT4tI3YkJxVNiKhWD/uJJDy4EuT+Y5f2l8ASCkZdSYeUEY9je8Xid5z5nWHQ==
x-incomingheadercount: 65
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: DJLbvgWm8MaxudWSkncYhwGFHEpKdsaEIlO+NWFgau/NQHKRwArcYav8ugiRk5+INxYCpzExpjANsNGx29yiBejfL14I+RBjgUGQg+lnOj/gmRVPcDky1bh2R58FLhO2PSMrEz9xFqESn6wgW6x+lXojVrxy1+/6RuBx9sbWq3tXnwoikTAbOgT4jAgg1wLwlJxq1on3FvD/Z68zaM3DgmavELoAxKtt+q8sCMpAkDn9Ed95dGL7QHzx0RqMaeyxSMD1yvoFYGceCqIbGv5VNmbogJMbHWBQTHPoy+3lIGy0vpEjHjN8V5w5pzMrhAoPH1CNcXLt15SIkkmxPrf8XVkvNwIIyS+NiZVcW88hUWNGhA/T8dXikyALRtk/5qEfn2LXdaQin/m9ehMp4I+iRW83R+QiM/veNPK2JoBYzo7x7DyJmnb+km/zVipWBMd1N5Vc1izfRVu3KNgfnNkQNXZMs8KtpwQomSYKogiZwRm7+0SFAxAGZdpW5giRDgr5bKG8WqFa6IIZa4g3Tb9CvzsZbsM/cZBqMSTY8fSEBh+cXYg64fGrxwam9td5DNTnGLmoJ4ygDskTQv5mNfszAJcMt2GqSv3Y2+JmlaDPwlSZ9D9ivNrbZoHke/L7cOPvamqKvXD+0Oaeoqy2zSgyD73Neq+5duUsLPkvhhny/9cTu+dT5lUNBUsym6glA+tqX42T04mbKe8ywAZsArsP6g==
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:PU1APC01HT091; 
x-ms-traffictypediagnostic: PU1APC01HT091:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:PU1APC01HT091; BCL:0; PCL:0; RULEID:; SRVR:PU1APC01HT091; 
x-microsoft-antispam-message-info: VPjsln6DS9atbrjxzyDGOXwDF4dlFO6dz0JVUtfNo2TyINn61KuCR5BCQbrXJ3sz
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d24773-4b6d-44a3-6025-08d68cafaf7b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 03:51:32.7772 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT091
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_195242_264873_733E7DB7 
X-CRM114-Status: GOOD (  14.57  )
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
 Wen Yang <yellowriver2010@hotmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
 Harvey Hunt <harveyhuntnexus@gmail.com>,
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

Fixes: ae02ab00aa3c ("mtd: nand: jz4780: driver for NAND devices on JZ4780 SoCs")
Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Harvey Hunt <harveyhuntnexus@gmail.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
v3->v2: Avoid two times of calling grtform_get_drvdata()
v2->v1: Since there is the only one user, let's remove the err_put_device label.

 drivers/mtd/nand/raw/jz4780_bch.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/jz4780_bch.c b/drivers/mtd/nand/raw/jz4780_bch.c
index 7201827..7aab851 100644
--- a/drivers/mtd/nand/raw/jz4780_bch.c
+++ b/drivers/mtd/nand/raw/jz4780_bch.c
@@ -281,12 +281,14 @@ static struct jz4780_bch *jz4780_bch_get(struct device_node *np)
 	struct jz4780_bch *bch;
 
 	pdev = of_find_device_by_node(np);
-	if (!pdev || !platform_get_drvdata(pdev))
+	if (!pdev)
 		return ERR_PTR(-EPROBE_DEFER);
-
-	get_device(&pdev->dev);
-
 	bch = platform_get_drvdata(pdev);
+	if (!bch) {
+		put_device(&pdev->dev);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
 	clk_prepare_enable(bch->clk);
 
 	return bch;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
