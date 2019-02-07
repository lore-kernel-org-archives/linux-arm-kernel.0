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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5B9C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:01:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E21B2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="okplDaYu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="VDu1abiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E21B2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=RIFlvXDrkXLvxwRCbcrey5ImJWKabfCt6eTkW7N7gAw=; b=okplDaYuqkQ+N2
	w2DxonTXjRtw6jqGmVjvv7/z1921QgTN9CVKBvMIxW5neIRsVybOfhazo0COEAXclTC6oh7Mt7EEu
	B7QH5/a3P/bbND17OsKuO3eD1iu7E92jOvGBczEwy50LXTyF2tQPbf+ggLjQEsTbHmDvF/qy2FRkq
	MCWhd/S8UO6xh9SbVv7O6OtXsv2r9249E1CeOnuZl3gmZSvIlnpETP7Z8fkkF9u7WzqKRrSk3Muk9
	IWUDETvdfW5tQBta6zTDA2T7F+0Fuwx7ImDE3BWFVaASeAs48bQUQ6KKsG51FaY16OUx4u/xm3BgS
	z+bg0TmOlAyCVsosbxNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grkFP-0007M7-BB; Thu, 07 Feb 2019 14:01:47 +0000
Received: from mail-oln040092253103.outbound.protection.outlook.com
 ([40.92.253.103] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grkF7-0007Cm-ME; Thu, 07 Feb 2019 14:01:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUt6HsXjjmapMG+j38OW4BJW0kBZKrv+UsE2TsCsc5g=;
 b=VDu1abiH+YzqjncB7aIU3BIGXcAqkmugaKSU4q14xl/LDVAsRHF2lBN0GnefjuB8Fl33KoXggDxkfsyvAEhP3tV4JWtohyg0cpxNj+wUPfsZY99PM6KhGxxOVWtn/M8uQ2flcwq2nogr9T2Hw15QbOnCSTPdpMbD2wAj74OzBygo57wcwogHk+u9ftBUC0+FWyfSKn+0kx19YU4NmELu9NQNGuilUIUg4daSV7Rzf1lRdvEq7PGEzVbDAOie43PCqos58B5Gc4Zd5fjoxWkq5Ie5v+fW6bVFdfGX1QB1LJmlW39gRIAQKNQA5pdoboF70OuDgvOxp2ZVk4PmGKxBtQ==
Received: from HK2APC01FT048.eop-APC01.prod.protection.outlook.com
 (10.152.248.57) by HK2APC01HT206.eop-APC01.prod.protection.outlook.com
 (10.152.249.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Thu, 7 Feb
 2019 14:01:23 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.248.54) by
 HK2APC01FT048.mail.protection.outlook.com (10.152.249.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Thu, 7 Feb 2019 14:01:23 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1580.019; Thu, 7 Feb 2019
 14:01:23 +0000
From: Wen Yang <yellowriver2010@hotmail.com>
To: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
 "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>, "richard@nod.at"
 <richard@nod.at>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>
Subject: [PATCH v5 1/2] mtd: rawnand: jz4780: fix possible object reference
 leak
Thread-Topic: [PATCH v5 1/2] mtd: rawnand: jz4780: fix possible object
 reference leak
Thread-Index: AQHUvu2cGmiaK825skeQVY9t+8hdhA==
Date: Thu, 7 Feb 2019 14:01:23 +0000
Message-ID: <HK0PR02MB3634836E65E2B8354FCF6E64B2680@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0079.apcprd03.prod.outlook.com
 (2603:1096:203:72::19) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:4B80A6C61A81F30EE68759F7C2917054939A50D88BF8FF140AE9FB5DE485FD21;
 UpperCasedChecksum:C8AE111C1A30CAC3AA23956B6EC5688D57ABB747E56BC40EB3A2FFA6E33D2BF2;
 SizeAsReceived:9214; Count:63
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [mfqlSYc2I42uP14CfkjpzFWDlraq1RmH]
x-microsoft-original-message-id: <1549548020-24018-1-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HK2APC01HT206;
 6:CEUw4X7Qo/zVTiYzDyKLqTgu01Z17q1UlZOYp2spNCEnNi9e4YJhBl5waUu3vt8iqsu6zCaYGDurKKkndyaBsL97Eec/1wIhmCX4/hBRY2HS8X6ObFq4YnjjdkWSUkWAMv/LjSylkRCVg//Zsmeqxis967he2UmkxvL9UwD4/lU5MItybz9c8emabfIcYCK19MK1HFEID9b+W8YxHJ+t/NBpBbiY/+XL+BrdrCDBztLOsrfO0Pe62zgNS9tpzp3MaXaLdA95U3g8+URZbnQ14YBdd8ZauY8p48+08goLK98kxIPDXxVzZzIQ2z6FpNWi+p5135CSaWNDA667HzdtAvHHYldv09Yf3Xb5RP/iVf7BPtQLbkWXrpfvZ224Ei3uehAsjNNqkgDC2OlADu2gK1hUgY/6dIcOc3sBpXuazp7bRBzuypWsZSUGxmQ0DzVdMfF4Ej4uWokXAIiGYNbHNA==;
 5:IJPUJNJknZr+ZXAIci2CAmr0WOavtbhcRiko8Z0x9mYSwTgtfYJlRkx1RXFZU9B6PDPCJQMw4hgFX/5lXlGheYqGmXn2JadRqILk3HFmzV9YGCVsw9Cu5yeLcJU4awCKQrZtWAy1f2nnvHf5a3v6CAKro7Ij1Qc0Aa7mxGKMYd55elOsE9ecEARy+Cm3U2WWJePohibqbiZeYy/iv51upg==;
 7:RUW1XRdmZ1FDtupLrdiSnGDu2yk/wuZFQuOTVZeFae+ljMemQCMeRnsyEzmuQMcf+3UongzCLbGZIJykcRPvMQwafuJLVx6vgDajXmqfERVnCOrt9Qb8/tBj3Cg5RTpnl3IN8WuMlBNQQ6xq7U2inQ==
x-incomingheadercount: 63
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: 2/KQAEfz20HXCNfxt8lAT5VR1ozCCpBL1BwJjJKvB/bV72KkET6kvY7V10XmGA0KuDhEdNb1bFrThe/2rb+5H78tDogTq3P7L56pxAjMiH5MJO/tPWG5fAh1hIrDtvAWPCfmVFgHi9t33G0XRvy1wd5QN6Tv2C8IIKPf4kXDDlVJkCGhNPPX8U2ZdQ55bwoETlEx9tGBRqfXwdXXg6b3woR62ezcNEYKkA/GzLxelYEMb4WzlDHnyY+L4Pq2Ufkg797GSJgDdxNMJ/UoeS5ES6hKCZPlGXS3geuvN6jQtNcvN9mVIbcjE0/0cVm1wWIxcDBwKG9Cak6jYVXp+6VGNOn6VnKvh496mNmT7WVlwYA3EyqX9IVTJzI4GohXruS2WZIyCGD23QdZOAJ7GzfFndkLjvoaghNCqLdCDfR29x5lQd61fqCuztyStDFnhWtsOdzgkvGyJeeEkNMdrp7pXywXkcmnZT7reRXE7sCOF12JihKnGtWOG5CFZZdBGUzW0dwpPcSHmjz9nTjk3d1EcQRfePSeCyQDNj252ugSqv58Qb6bss9AKlle2L9L4vafnMVJPNDLS/vu7jFnALTBt+0DA2xeBHeO6MnxKf1uIzPXPlA6Hk3spaxdGIhrLDoAwKQ7S0HbRwAGMzvpr2Ak2vQYAkJ6FL3MhbVRVCFO40PUcNpu5vhS3Rujoe35LuyKPQPRJ2AjHps=
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);
 SRVR:HK2APC01HT206; 
x-ms-traffictypediagnostic: HK2APC01HT206:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:HK2APC01HT206; BCL:0; PCL:0; RULEID:; SRVR:HK2APC01HT206; 
x-microsoft-antispam-message-info: RD6KGcupi96yPZbbRJW3grNwRKy9WfqyUqyD9G2rbxSK2y4/XB7t1qqVDLw4ePSt
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: f66476fb-f8e6-4121-71b0-08d68d04be74
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 14:01:22.0432 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT206
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_060131_752805_FCCB6420 
X-CRM114-Status: GOOD (  12.18  )
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
v5->v4: Keep one blank line.
v4->v3: Add people in Cc and remove all lines.
v3->v2: Avoid two times of calling grtform_get_drvdata()
v2->v1: Since there is the only one user, let's remove the err_put_device label.

 drivers/mtd/nand/raw/jz4780_bch.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/jz4780_bch.c b/drivers/mtd/nand/raw/jz4780_bch.c
index 7201827..c5f74ed 100644
--- a/drivers/mtd/nand/raw/jz4780_bch.c
+++ b/drivers/mtd/nand/raw/jz4780_bch.c
@@ -281,12 +281,15 @@ static struct jz4780_bch *jz4780_bch_get(struct device_node *np)
 	struct jz4780_bch *bch;
 
 	pdev = of_find_device_by_node(np);
-	if (!pdev || !platform_get_drvdata(pdev))
+	if (!pdev)
 		return ERR_PTR(-EPROBE_DEFER);
 
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
