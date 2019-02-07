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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCC7C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:03:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F7721902
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tFMsf7yO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="h6eQrfgJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F7721902
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qQv+jNBFLwq/Ba1WN8eO+A8SnrDmTt1Eh4Q1BNWVAjM=; b=tFMsf7yO1l/TIU
	mp4Q+mnzLTP9pP+S5CMVL9xMBmNbDHjhfya6CAc3PH7e+pJeI4LmQNI4RA5Qv1pJhTXTUe80c9HaG
	A/Ta9MM2MjGW4krGQkL1rbRYwtiVH17aQa/nsO6p+fokmJTg1f9neoG5rZUBXuaT1dGUZwN+F6i1K
	4KIYVjQf6DBxu709Yny6CnUqBE0swBlJdnN4aRwkD2n+MOww8Q048TnwuMyaDAPqfegB5wQ2c2D/D
	gdENlmCv5N+uotZSa7iiQYyJ/IufCn2yr5PTOtCCKfIXb1Lj1N1n8/+3vtIT9mIgxWQbOo8LqcaFD
	lPz+he1B0uI6Ujd45sqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1griOe-0004Jz-4u; Thu, 07 Feb 2019 12:03:12 +0000
Received: from mail-oln040092255014.outbound.protection.outlook.com
 ([40.92.255.14] helo=APC01-HK2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1griOQ-00048s-TD; Thu, 07 Feb 2019 12:03:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlRtGmlMeO04rl6IXpPYU/ERNKgJzhXggPlxIi0mAqI=;
 b=h6eQrfgJ8Q9rQwcyUXAEi7F4nsFYAvB+On9qrFH7DoF42qvqfYzoG/tmoRDr+1rrrH8yhiAZo2dtLBu/t30r7wg8bWIptuLdz1kqbyCTGWu8MBVkKRzQ2iwajUJMfuHD9ku7zsgSR0kfsKVk/i5UIBaoMkpyMUZ1aVDTV76N1vXOzLpdMokfAneZDWtdhEbyd1cS0D4dcpMT3zKqhI7DWlMXXCl+0DY+p7JdZwpOe697lIRx90aRa6pCe47cT7z+TMbl1Io29j5pAjMtVxGxeTVxSzZ+AraFSs2GJ+w2f+sWPBfkqhYIVBlxWLwj17aO+uJJIv7PF8WZBx6KJrQH/A==
Received: from HK2APC01FT044.eop-APC01.prod.protection.outlook.com
 (10.152.248.59) by HK2APC01HT077.eop-APC01.prod.protection.outlook.com
 (10.152.249.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Thu, 7 Feb
 2019 12:02:52 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.248.60) by
 HK2APC01FT044.mail.protection.outlook.com (10.152.249.115) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10 via Frontend Transport; Thu, 7 Feb 2019 12:02:52 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1580.019; Thu, 7 Feb 2019
 12:02:52 +0000
From: Wen Yang <yellowriver2010@hotmail.com>
To: "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>, "richard@nod.at"
 <richard@nod.at>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>
Subject: [PATCH v4 3/3] mtd: rawnand: mtk: fix possible object reference leak
Thread-Topic: [PATCH v4 3/3] mtd: rawnand: mtk: fix possible object reference
 leak
Thread-Index: AQHUvt0NR4D3q6yT0EC6btoPU9owCg==
Date: Thu, 7 Feb 2019 12:02:52 +0000
Message-ID: <HK0PR02MB36348C5317C4DDC7C3262FF5B2680@HK0PR02MB3634.apcprd02.prod.outlook.com>
References: <1549540786-12196-1-git-send-email-yellowriver2010@hotmail.com>
In-Reply-To: <1549540786-12196-1-git-send-email-yellowriver2010@hotmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0085.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::26) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:20711C5A04AF1C2CDD6830050E986AE7BB047610DF1F663679BEBA23F49C2501;
 UpperCasedChecksum:2D7C35A5EC47F9DC57C6991804147F98C80426EC35435D611F1E925A6D9ABC15;
 SizeAsReceived:9358; Count:65
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [GKplGarwoKbuY3zLUKrXli/yxibu54nO]
x-microsoft-original-message-id: <1549540786-12196-2-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HK2APC01HT077;
 6:Inzb1gy3mHElrbnG50gOfKR/NGiAwT9L8GQF5iAVjxT4gCOzETqczPQ85JfN9fSuivgtbZvpWs7DldNP1GeWway6o+MqZRjmlUlE9fMoW8YG5GdNkMAcSGYgrQZB7kCuNdzJ2eDnV38Ef4btWRmOlRnNh28AdeuLZ2i1RYI0CauI7RRSV5AiuG5oB5BW47eXCF1JX3RAwU/114tipyAG81eHZr8mFrrMFaNDm0P660otEY1m2BmDKwzQi3eMPxqrtyEUUzsLZhftn63sSbVFauU1xmdIsKlps5w4lHCaD8W2NrtODtiCUY0fqNSxIN6Ltj03eSE9Xv7n/nESVwszfZcFUXSE1HGAKumuz7oaLU7xRRAesYRfRUYPJDHpVTRhb7CwFmJpOorIs0rBteRXVFK7+TUJpbRaQGZo6XHTKjeXuRXY8AyOdhbL3lEDI1A8FvCtaJCCqoBgmc1KuxXTkw==;
 5:bQTAk77tLisoQnPoc6+niuoayBE66TTmqIogNGGwtINbqQDJleIedjTZSiCT6aTFZgm5ZswX7jSSKp1UXqG35UyRdc0k7OHQjjfbXdg+hTh3/HalwrlFz6sOXEhkTwcyGbgU01urC6MCNLHqIxiRS/H9lPeYuNGVmkEopddTt2srnCKzA5+xzvs6vATOazD9GG+eWtQ69Qae7yUmaI3TRw==;
 7:3+mdOF+8xx/1LPDxLyGt3AIT9TH89PsJzTtxnPNZpb+k11Mu58+f5okMIRP+Wk1jGttQQICuHca2H76NEgzNqFL3z3ppdfqZy3QOimzJvwJrc26DDdvxiIKCIrAhWUVOlHaNyoXppIhbrvUhQzsBGw==
x-incomingheadercount: 65
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: b0omxY8GwpZtOL5FmEVprVixbmp3zFeA/X3DMB9dduFRetOGFgucCI1PdmiY5ct8utm714/6636jCIVJ/hi2DtGpCf5wxputlpTTbPy3Uh/DQ4/IcTkMvjdAgfUq6e2jkggUFQCdRQHMumtiNsnLmRxrtE7+y7yMK1cahJlsr5owGp/PtfffyOgL1gtl9eJiYvb+SOhF07QLeMptxR7P4N1JXdGmvrtDX3+r5SaSK6n25FWq4pKbHvGeUVqjEee5s8m72xdb93RC+XWrOyIaQYlQiPGb8k9tRyNRPHhKaEdesH0coDjT9oo9RUhKBlTIl4xgyDjUJ4hXA0hK1llKaF0rOncUxTMf1wz4k1Vv9Zz4Rcug1E/TNmnRemXG+gL8qE1JPsudYT9U0HmIBDhbyon7vuZj5x3m1tz7Zy4+OSUZ2dBq6XypCHzacRcZAvj1NROoStLnZudqznMBxDVhRKHmfQHDo+u8GxBfBrQV5Bhh68GJtF+KkI1DOBmFZzX0qbu2cK3cnn8HDfHXnJtQ/I4986qvEGJONTNBLsuDoi217fq2BjByalt5qSAVaAs4ujnqNgjM9BQ4ZwiAXYrFIqXBkdYvyhVwK3l1MKjdQyK2f6rWbsWOuGB1y99ev4ohmmo/N6li4rnK6wGtgZ4ApVDRNtzXYzT2+lGJQPE+ZRbAYlmD9LuTaZ2py6FdLhBarsHGZFmlR/WdfRbDma4SDXDh01qVs49M7hUhwJqsO1KkY/q4h3hTOZG8a5fiLnYN
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:HK2APC01HT077; 
x-ms-traffictypediagnostic: HK2APC01HT077:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:HK2APC01HT077; BCL:0; PCL:0; RULEID:; SRVR:HK2APC01HT077; 
x-microsoft-antispam-message-info: VY2OKy5QAM2q1rH/z9vr3/6Ysaik40iR6D2AOCliDWVfzLGXNVQlPJWycO/6wbdf
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: dd358e44-15dd-4a83-c348-08d68cf42fa2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 12:02:46.0037 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT077
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_040258_946368_9FB90C18 
X-CRM114-Status: GOOD (  12.86  )
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

Fixes: 1d6b1e464950 ("mtd: mediatek: driver for MTK Smart Device")
Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
---
v4->v3: Add people in Cc and remove all lines.
v3->v2: Avoid two times of calling grtform_get_drvdata()
v2->v1: Since there is the only one user, let's remove the err_put_device label.

 drivers/mtd/nand/raw/mtk_ecc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/mtk_ecc.c b/drivers/mtd/nand/raw/mtk_ecc.c
index 6432bd7..db804fe 100644
--- a/drivers/mtd/nand/raw/mtk_ecc.c
+++ b/drivers/mtd/nand/raw/mtk_ecc.c
@@ -267,11 +267,14 @@ static struct mtk_ecc *mtk_ecc_get(struct device_node *np)
 	struct mtk_ecc *ecc;
 
 	pdev = of_find_device_by_node(np);
-	if (!pdev || !platform_get_drvdata(pdev))
+	if (!pdev)
 		return ERR_PTR(-EPROBE_DEFER);
-
-	get_device(&pdev->dev);
 	ecc = platform_get_drvdata(pdev);
+	if (!ecc) {
+		put_device(&pdev->dev);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
 	clk_prepare_enable(ecc->clk);
 	mtk_ecc_hw_init(ecc);
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
