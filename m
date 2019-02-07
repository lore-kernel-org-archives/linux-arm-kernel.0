Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD1FC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:35:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D4D21907
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BL7eVgks";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="n0zIam/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D4D21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vTohbpLDN0ZFoYyykBJldAN9KyBVf/hLsL1oBcw9p0U=; b=BL7eVgksDyT5os
	Zy0rkFiMCV4DXnfUe1aB0cDuVBbtYWFqKqOBjfefbq+SsFxjrHlDn+llHhdMkMSuRSzRmUe07jPnf
	uQchMVVfUkVi4Wqga2HewiEwkv7gJfGsiX9d2997LnzUYkHL/1uMaRu2qnHC3uO2pRhwyY0u47Fz0
	QmP/Kd0MDklsW3e9jo1qMwBU6X58JBrtVqNCNRu6O2QNdN7VFajnljk78VFqxeTB/HPHlZ8djstOu
	8i9J1o4NQnRYEggLWFl5gCkciDeHWmVsRAhPEm2Kcor+5NRqg+jOuKwtWiph5cU76gAKRehMoCnhc
	yIImjTa4OKrOOdp3O64w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gritb-0008JF-Th; Thu, 07 Feb 2019 12:35:11 +0000
Received: from mail-sg2apc01olkn082d.outbound.protection.outlook.com
 ([2a01:111:f400:febd::82d]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gritM-0007jx-8V; Thu, 07 Feb 2019 12:34:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lzpf32m/9f3fW4nlg0xIKLYFx29efJKPCIX0S/0UxJQ=;
 b=n0zIam/enRJfwr/CPq4i9vrlZHTCfH/rYYEKu7V+o9D8Igow55sNipdlEKaQP3xabPQY/1cA3ghlvYRbhr2CTLb/T4xzNGmpEcebXJzcIUYPsL3oZfqaFntHP2KQAHjPGhNiGlG/wBlWi+rzkwL5F/MigGkEq6dxPu87/QBinFbKGQFfVX9f+bCeqyz73/J3emixjtlhyUQ8Qon/I58yXIRNilZRfjGlPrcJOwzQ9s+GsyJXM8wJe+sELCrUFPch1zN8ISSu+sKaJegUKZ4+BpSpXKyk221vg/bq+zDOF45piEaazXuLqd92FzTEm4gzTn9GvT0/fT8HFnaE2Seq7Q==
Received: from HK2APC01FT044.eop-APC01.prod.protection.outlook.com
 (10.152.248.54) by HK2APC01HT177.eop-APC01.prod.protection.outlook.com
 (10.152.249.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Thu, 7 Feb
 2019 12:02:45 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.248.60) by
 HK2APC01FT044.mail.protection.outlook.com (10.152.249.115) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10 via Frontend Transport; Thu, 7 Feb 2019 12:02:45 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1580.019; Thu, 7 Feb 2019
 12:02:45 +0000
From: Wen Yang <yellowriver2010@hotmail.com>
To: "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>, "richard@nod.at"
 <richard@nod.at>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>
Subject: [PATCH v4 2/3] mtd: rawnand: jz4780: fix possible object reference
 leak
Thread-Topic: [PATCH v4 2/3] mtd: rawnand: jz4780: fix possible object
 reference leak
Thread-Index: AQHUvt0J96rvaNo3TE6LMpRtXiJFjw==
Date: Thu, 7 Feb 2019 12:02:45 +0000
Message-ID: <HK0PR02MB363417B2E91D8D6D7D31B1D6B2680@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0085.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::26) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:88098E8751C5AF91A6261678D7F47845D25B84ADC64DD71B9B2A9C9C57C855FD;
 UpperCasedChecksum:46A6DDE9AB84E472DED7FB1A1911B1CBF63AA01C133D0FA052DF0F8E646449BA;
 SizeAsReceived:9219; Count:63
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [YPF7PtKzroP2FQgOipseTjQjs1FGIh5W]
x-microsoft-original-message-id: <1549540786-12196-1-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HK2APC01HT177;
 6:1aJIcJuTBQF6tB7/Ei9jJOcudzu7KpDevIFfszth4gjN6tGUjTsMq4bQLsDCp1sreDcdsFN44P2SIyvKJUAGg3UszHINUgj/v0YNv3rxRkgZGKdpKjDZL5N3epUTNKHRkecHST+LU70+Eib1ygkU02rkjl51rq0JagqGQNqjljmJVFDjW0K4D20uVrGqJe4qv0U39bX9XBWZ5ezMM076iQ3/mC+UsIFpnxJPIsEkJo3SAeFVz6FvKQPw9IH9xe2Mgvm6FepMFJpta/2f+2Fvt2UX6QD3Ot0Ozmo8BhmJ/1eyGtaQnMWqrCfmPEfh7nFztIOvRyALv25OafkOMXANuXGPxh01oZoW76aoBVoUWC9kodr+2KvBDB7Bf4rO6ISH7QWEX0t4DUt14FupWCo1/SbQQky4ZRwWFgKj9iNzU69l7L04gzp2kNfzt+AtlnPeT6cIynO5tfWDlT3YeI0Psg==;
 5:TRRIv+ZHBvKHh3W/K/tm1uf7vaUqM8IEufMn2ubnwp5v9kbRd/xwU3qrmTEq2Pe41xl06MVaMYh55gbtHozZQMbJAz2973zufoABK4SZSeLJcOfcfs/6kdf+Y+Lskt8P+Uoh0tdHU+d5+GOE5G2YLN94KEBopjbS9lnV30Q8CA40ta/u/HXmlwju7UpzaxKroajTukq3DTqI+fjVNXuSiw==;
 7:ynYl5Id4TpGh3aPzjTqCYKCzaFWih7eVv60AP92akWj5vSNtpkjBfiTZhSIe6TXluKML0m9bFjYZIGmNQWGGMuA3K70od2NbEguB1vnSjuleE1UCs+sT2MLVesOdGtcUbOi047J7WucSKotuZVD0rw==
x-incomingheadercount: 63
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: mmMLu+WorSyPNTlVaAqNPlkb+GWRLMOe9FAuwZEUmefngDuc9mDArFWFHoUwDep25QPQtWyHdALgI6JGRpvr9RpSgDZFi1a8yUH5eH8TaPKY246i578plXPMjFbdli6PbimVLd/SqeJ1nkR7+9GO62qXzW7RInTKVC2H5vIsneMWkjkYLh8jZWgcNL3eGhiOsTuKQGp4Mv13tUk4QHOZ41lC5J8ZUYRD8TFPyNX2qWognNm+bZxmzJqWfDojN4fc73S1CwZyH0OEe0hNo7l4hSBTBZ2n2p20I6hTbxLZrOZteVDUDm7veXVJlkcGkfkh/GGc1KSMAIgNfRmqrpLDOLBqGpCgvyXcgRNZTwFWnWrhsC903xD7E2R64asir3X9H/lHj58ej+q+XJ2hAFyt0OpA4pETiGdt0LFLSDRThq4UPnogy4wQ+npQIjMbDt3M61DUTb6dOmJ0eklJS+S43ZblnApt/wM2DUD0TIKtfJiHgCqN1qahsb8Fr4n6E25fPCzSR14Cm+aCEPZH7MsUuWXolGLx8MI0Knx0bBoex4KD4yxQo4rBBoIbm1CABPcqXXwZhaP7m3GYdonjxzzXPymMHQfF/OL3CW/nCXHdmOYYGY+qJs5cx8fGg5uVY8BjnaS0lzxEdegKmBvOe7wA20urChx+7EnwHQL6Y2BhNY6BfzCvRWLH2ymQd1wy2AWmR2xVDXgpT/c+uRhViaT7AwlNfF0VXsDH
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:HK2APC01HT177; 
x-ms-traffictypediagnostic: HK2APC01HT177:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:HK2APC01HT177; BCL:0; PCL:0; RULEID:; SRVR:HK2APC01HT177; 
x-microsoft-antispam-message-info: jTjqLQs8Q0Qm38VpvFtNyRdk4i2R9OMBucmzo2vYPfFGggiphsZWkFBAlz+gqZYU
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: 892bc856-f2c4-49b6-5ab4-08d68cf42ba9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 12:02:39.2630 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT177
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_043456_369125_9C65FFEA 
X-CRM114-Status: GOOD (  12.25  )
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
---
v4->v3: Add people in Cc and remove all lines.
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
