Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8F2C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:19:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1928A20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h2/q+S2T";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="N9I1aBPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1928A20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hpVrqSe+dPfZmI3pJCI8gIWSeyKRL6g/o4YI2IRnoX4=; b=h2/q+S2TYGApGV
	seJm5bVU8u5p/lOTtICPRUeug6UVBcySEqfrk3yq2Y82VkATnpc2rs0NoIO9U2+GSsBiDaBXiYnGA
	w+4On/ADSuDEhAeFu//W+MewdGHUMgWggRNefr9pooqA2hnn2nvm7TqrX+O1LMrgmWmaZXaSqSyld
	SjUDaIR6ZjjPyP20jdGaBhY38ZvXcl+B0VpfMohCQJfmy0+3Mdj/e4yUL3y28mK5Gq9+7D6S4DuUK
	Q5zUi/NblgCnunXjiup5eDIouJTAG58A4ttWQTaCnYyB/Whh5vpp6jq/UhOPbjxRBxDv9IN9OIX5R
	/hfevf30gCXhWCOMryFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr3R4-0008II-T2; Tue, 05 Feb 2019 16:18:58 +0000
Received: from mail-oln040092253087.outbound.protection.outlook.com
 ([40.92.253.87] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr3Qs-00088e-DF; Tue, 05 Feb 2019 16:18:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhpRd1Rmhf0oeqiFPlhqnFFXs17mJfkUysmv0mdUJHk=;
 b=N9I1aBPkTWGlr8ibpdO0GExkIPscIFytwCLMLhsnkTTMQqG51tLz8nxHLWVu2SnlxEBUXq+VEjnId5N6PJaSDBH4tTYtBeV9rt8jtWOdoQR92/RoYIG7I6RGuZk7Pia6nWGTuPuRPywso3yuad0vqY1Z4k1g6i4UP6mdtBh2I0nU95DDX5g7V3/pCu1TXq5Yd1RXx5zbkWJTgsk+n8O7UitYVlxvKZqcWe0L49EeKh6Q4nF8pb361POkp8VNEK1E1gCoUxiAPdyDzDP7JxtNOCuyujRlLuJx5W8IgDlDf7nb6IyNe0CTS4IxtEkpB9Gk9ukbMVPEP0IF1fDgiVhrdQ==
Received: from HK2APC01FT013.eop-APC01.prod.protection.outlook.com
 (10.152.248.55) by HK2APC01HT028.eop-APC01.prod.protection.outlook.com
 (10.152.249.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.10; Tue, 5 Feb
 2019 16:18:38 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.248.51) by
 HK2APC01FT013.mail.protection.outlook.com (10.152.248.160) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10 via Frontend Transport; Tue, 5 Feb 2019 16:18:38 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 16:18:38 +0000
From: Wen Yang <yellowriver2010@hotmail.com>
To: "xiaolei.li@mediatek.com" <xiaolei.li@mediatek.com>,
 "bbrezillon@kernel.org" <bbrezillon@kernel.org>, "miquel.raynal@bootlin.com"
 <miquel.raynal@bootlin.com>, "richard@nod.at" <richard@nod.at>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "computersforpeace@gmail.com"
 <computersforpeace@gmail.com>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>
Subject: [PATCH v2] mtd: rawnand: mtk: fix possible object reference leak
Thread-Topic: [PATCH v2] mtd: rawnand: mtk: fix possible object reference leak
Thread-Index: AQHUvW5zFYgcdwVWMUitJrk3iaUStQ==
Date: Tue, 5 Feb 2019 16:18:38 +0000
Message-ID: <HK0PR02MB3634CBC7B86B207D150CA010B26E0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0151.apcprd02.prod.outlook.com
 (2603:1096:201:1f::11) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:8FDEFA9DD1DBEF63FFA0B3FA31CA4E0A920A547DDE26CAAC3EB098B56CA225B5;
 UpperCasedChecksum:64311E56B1BE3F1C47DA2FED7E34B8F4856AC62C0F8F769803B85E388DB36A73;
 SizeAsReceived:9179; Count:63
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [ec7b5rdWpkue1rKQHKIEP74W0ocT3ClP]
x-microsoft-original-message-id: <1549383347-23876-1-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HK2APC01HT028;
 6:XLoYfnLKQ3gJkUR6QaUzqxCWrgmfI9JNbY6FMr39mr3HkKwxiLA6APDVBLE8aRhLSaQ/AbKMWBNrdFGJaBGCp7nohVg2VHCoWwELYtoXKAt3Bc01gd0HnGDHifdtYSA8DDy6ET/i/7WpD+ncY+suFDbjDxrZ+zhnYU0xMSbDs2fWJE5AHLZSkGZV+se7doD4t7392Osy7ntoLyBahVFRclQ7YlJFdnaaM4holSk7G7LHAWjvY9jruVrq10peHrK7nldULeXWilRlmm4g2j8E5nj8uznSoIqy0Neia5CRxLbc2mozEtS5SvJpfUxkcdg12JKIBDPuZbCppB/AWFhKW10e0eker2Y9kxVpQWIoSIyW159eVDwTb8t1WWpKhFMFjsGCjwujAR0Kxdmd5bLdnC1vt3ipINs5GU+LwFLTbQHVXHqpfbgg4XsVBnO+5Em7Ft2sfc+c1TmiQtVHoZmmug==;
 5:pDBorCsaGUdjxA+f3+Eb4LVHcSokCEpI6xW9QhDlQZRRKysoZRy9wwNC29BXlzTZxy4tpnSUJ+K5HDLiiIQJku08vqsOAHxM6ksZUYi5rw/8tpe7nVOP0mW5oJLFDq674vOTz004mQan02lkW4eqMPgI2zx/MThDsB6xZ8xAs3pT4rJZPAJNThzLCJE4VUL1qdaO9w8tLfYba+1SlVwNLQ==;
 7:8MoLXBxP/9XvLfHt7iGSE7mRZvXtqdyLUOOkJAQNL/4mimjwtcNQJDfA5H69i0sI9LgbrygVXG3Qx/TT06/B9OuWzuCCP9f1ym3yhhQkLxAY8t8UanferG9ktcf2nDyy5e3mHf9BTflFuQ47cZVy2A==
x-incomingheadercount: 63
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: b0omxY8GwpakhZQne8YdzZ1d6kZpGUpugSg35BgWSOVakBGzLPUTiWHgKlaXhZ/srFsOdAENlgOUrJ6bbr5U1uFrG4X5ysL6qEiVzhVVbsYd89JBBVVjNGdbsnRKVgXfzPRflYv5OsV2d3dJpW/DDHsoyGssT47cNGzeJJO1sNZz/m8cDzbx2hV2Hn+FqaCB0N6a/+GM8c8isguiAjyCXpEy+rMXq01FecZDu5jYrEjsqu353dA4B2NCgYD8jps1MOMezOQvqQSQSVDIhSDd8r4MfnQ3n9lA4pB6HImxiUFnHheIMBXhOxqG6oOO+prVBhWaj/m/rCWVeUycf5H1Oh8uPfpVGxfk0jjqYcMmeYBJHB/Y+JhObQ+5vc1Z9H2v9DEQAIFAzgw/RSNkoEbAKN+nDIX7LLPQEiTYPH4Hbrsi416mWLK1CYga8HzM1ipAtnREKk/QkF8yEdcITk0TjAx5yZ0fbto/5ND6dNGfj9KiKl1q/8E0qV/jxz4hK4GMlia/7phpbv5QOzYLZ3nfIedyf3lXZsv8DIQV1B6Uheud39BEiv5L9H4QZoDWy+eecoX9fecd8jH+e9japKt/JgcNdx/I0+6+s9nq9VbD2XgtQ5SgiqCvrvs9WFj4yWJGutULv7eH8r/orKyMQ0xq0nIxr9GXEk+XhjkSMByrg/JpQpzzCx8WstB1NKnnvN4Y+xlRUXNBa+rRl60ImX/6ghDQFfdntN6EQvxnvn8pCYatD1SPQpYMArWaHNTnQRAx
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(20181119070)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:HK2APC01HT028; 
x-ms-traffictypediagnostic: HK2APC01HT028:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:HK2APC01HT028; BCL:0; PCL:0; RULEID:; SRVR:HK2APC01HT028; 
x-microsoft-antispam-message-info: wWbgYw3lzTcsPeHtz+2pMgAKWmdWIo4Gk9qyjNU3em2p1dUDBgo13GBsc7a6ys4H
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: 2355d197-f567-4893-89c2-08d68b85962f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 16:18:37.8527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT028
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_081846_540016_AF436DF6 
X-CRM114-Status: GOOD (  14.14  )
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
Cc: Wen Yang <yellowriver2010@hotmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
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

Fixes: 1d6b1e464950 ("mtd: mediatek: driver for MTK Smart Device")
Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Xiaolei Li <xiaolei.li@mediatek.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
v2->v1: Since there is the only one user, let's remove the err_put_device label.

 drivers/mtd/nand/raw/mtk_ecc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/mtk_ecc.c b/drivers/mtd/nand/raw/mtk_ecc.c
index 6432bd7..83a05b4 100644
--- a/drivers/mtd/nand/raw/mtk_ecc.c
+++ b/drivers/mtd/nand/raw/mtk_ecc.c
@@ -267,10 +267,13 @@ static struct mtk_ecc *mtk_ecc_get(struct device_node *np)
 	struct mtk_ecc *ecc;
 
 	pdev = of_find_device_by_node(np);
-	if (!pdev || !platform_get_drvdata(pdev))
+	if (!pdev)
 		return ERR_PTR(-EPROBE_DEFER);
+	if (!platform_get_drvdata(pdev)) {
+		put_device(&pdev->dev);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
 
-	get_device(&pdev->dev);
 	ecc = platform_get_drvdata(pdev);
 	clk_prepare_enable(ecc->clk);
 	mtk_ecc_hw_init(ecc);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
