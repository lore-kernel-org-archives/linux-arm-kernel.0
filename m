Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E476DC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:02:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE2B2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U56ciJnM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Ux8yZH7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE2B2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L0cst0GaIRuhaZnaAR2Cr1GHZdJvzmNBD/gpwhSrWLw=; b=U56ciJnMf7YJ9G
	oL2NyFosVfLq4O6zkmwyHciakbGkPmONTiOnhtbADSrihScjAr7x4c9Gc1mB8OPeFWEosjbBRMsOA
	Dj3fMRhxre24KZqa234vXUf9Nb4OS8VNID3/74khADrobSQ9lzLmNEtfh6wE8cs4ZraLU6U6O4dpB
	rg5++NMbb024BFHUGGNvzSZyBOkjo1VHJgMF1CotB1NiCjeG58NK4CrB8e79sZaE41b5dypsyZxlD
	VznaqA/XIlB6jfhXfKC0OhaDM3DTQolly40wrS68UUblR2vi8PWt4xO1U7HObyPNF75gWTVKkYknY
	8I5auTuGSNJB4+VIhnLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grkFs-0007wT-5D; Thu, 07 Feb 2019 14:02:16 +0000
Received: from mail-oln040092253049.outbound.protection.outlook.com
 ([40.92.253.49] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grkFH-0007Di-Lg; Thu, 07 Feb 2019 14:01:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ivip0Pjae1e1buCWLIa0HR0gOJOn17Dw4d/7y9SFgs=;
 b=Ux8yZH7D0gKo5XOrhDqX47+JCpYa/SS+zqKdYGF5ckG55YrjQyLGfx+hEeJ2er2iyZ2+8TuvJZgkBTJrepLDBU/ZJrDU3ggE32pzShvjnMIyJDVsxfrZu9YJddnsbLU+gjmRLeRAvnSK6x20C47gKp9qrfGJ8Ykt6oiBzhjvPeXu5v4QeYL8CPwjax9gjXj1yVVLRj9Ei+j1jXTLX5YNexd+X6Swh0E8YYEim1k/9ZY9ne6XNntar3JWxLGVwFg+ZQ3vilycSUuiK8sw47gtgWJvGT4k9vkV62dQim5MfnvqK1db4nnMP4+W/w1DaKkLwdrDVNBnFST5gnnyTpj/Rw==
Received: from HK2APC01FT048.eop-APC01.prod.protection.outlook.com
 (10.152.248.51) by HK2APC01HT140.eop-APC01.prod.protection.outlook.com
 (10.152.249.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Thu, 7 Feb
 2019 14:01:32 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.248.54) by
 HK2APC01FT048.mail.protection.outlook.com (10.152.249.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Thu, 7 Feb 2019 14:01:32 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1580.019; Thu, 7 Feb 2019
 14:01:32 +0000
From: Wen Yang <yellowriver2010@hotmail.com>
To: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
 "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>, "richard@nod.at"
 <richard@nod.at>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>
Subject: [PATCH v5 2/2] mtd: rawnand: mtk: fix possible object reference leak
Thread-Topic: [PATCH v5 2/2] mtd: rawnand: mtk: fix possible object reference
 leak
Thread-Index: AQHUvu2hTsT4zNKrzk+ili1MMDmBvQ==
Date: Thu, 7 Feb 2019 14:01:32 +0000
Message-ID: <HK0PR02MB3634AFAD97346DE3324844D8B2680@HK0PR02MB3634.apcprd02.prod.outlook.com>
References: <1549548020-24018-1-git-send-email-yellowriver2010@hotmail.com>
In-Reply-To: <1549548020-24018-1-git-send-email-yellowriver2010@hotmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0079.apcprd03.prod.outlook.com
 (2603:1096:203:72::19) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:CC02829C83442EC8847D0A7325BBB8E1CDACA096A97281AA2123C567E3D5BC65;
 UpperCasedChecksum:91D72069C824D2ED084EA2D3DBB47179AD13887F9DB08FF2E8410AFF70084810;
 SizeAsReceived:9353; Count:65
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [SfrzlmW/XIeCUwuBB14Pc2/Wr7stzyY2]
x-microsoft-original-message-id: <1549548020-24018-2-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HK2APC01HT140;
 6:k8jJ1GSwNm7Sk5POsBb1PtNEoyRwgSmSo7BkfvSMIi+2n2ljFoffWL298sM9Gk4Q7eqd0MvJbjKo77UkVhX1E1cXkGUdgK+9DLCcO7Eez8ylc/PxgPXdaGvCMjlCFaR1lKoAmnWXqprxaxQ+3jED+pw+AbFHZR9JOcH+BAMvlGwYdP0xLxu7TMdZkl0qUSslgcLyP3vv4fJuc5NVh5WiO6BVIbcbUwvguO+ChbKAntOFIBQ2R4CApWHPt7k43VZEe/WsOAX6YJkOj7VQthgOAy/6rjfXdQScJqQ9rMKwaBDi5QU8nC2sQnEjyyM6TQBn5R0SI1mvxPBkdMsSYTjqpQyabhbmik0x1KJSjJtstriEFNYKLYWxyhUwROFx2u0lFau83xj7d8C3LgHM+BrFIsB3+AA03iXVmTceNayZRUF/Kp+zfW1lmfooj9A8OKbMY3v5SqGFnPRlVMkURTDYmw==;
 5:KS3DDrCp1+naqSJRhddeiQsal4jeZnPaYC7jHjMijfXrP0Hs+MkKkaLbW85TvvHH9hWs9WzTckYUaS1GSwdNKsIsBXprK5cN66R43EiB7tHOJ+unOzVcCAXy+I9SxOVUj/JdPjb4usb1VRAAwWqgJqPsMzHU2eXFjGFVStIggzjeqc8XLxnpuqSmfE6sZRxcfk3ZrsMYOdRiJfP8E+AkPg==;
 7:T4Pggcpghum3+IQB1fDQKrzmb4HYkJEyVGu7jwG5K6DQ1lIkVuw/epjmuTVfjouga6INZuf+nbwUFniv8wJjYY5mcXcyeJbWMCVFFS+iQ4/m5P6o5AoNkLb1QRRaC7ElMuTz4eZcXHTypE7OS8Jc7w==
x-incomingheadercount: 65
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: b0omxY8GwpZtOL5FmEVprWTMJNLvSu4PiN3el9EnAyLpk3+1HjUQNg7525hfgZ1uX/oJeZq7rf6Z3g4KuN+eer2ha+n96Unh+/PhB3wT3i8AX7gzbmimWJwXxzNwzGdTqP/1CBVhQb9N5P2PJyCSFxevx/N3JobjMsSKfG3L3mTdKoXayqnfyXxRJYsBpe//5qXK0O0i+A6CRvdbKg+83HbxZA2KJF9oOuSPsDpLEUOHBZC2tllpo25/mys2OZL/gO1kdDjO1EiXP5/2Aq7BVYXa5gv2THwia3nI0RbNW5iZ85TxNU9RyMdb9fpkbptYYZsmlyibdcw+vLHo02ptWracztgeOQLW4zNgsBmr471jFWO+G4Z64rVcwuLyEXya/b789k1a+33luET2LQApDPBqOyy/3oXtz9PjrEfoQhrd6RYw6T87TPEPhi1N2nCnFWehQhaM4c4rhFpT+F8mPzURwRU2lzTAThNgu9iLZOfk7sj8KdAYaKowDVucghp2MTIEFFPPQPF4AFnnMUfejuAB3Ag2uB/+cZUbDU0/linIXCgbMqnxhtrSJqS0+5/ywMUzNIXXqYHz+cr09YykM27GFfb03LEU4rIo0zI4EmMykAqsR/rxFK3N1hnMPg5pjja/QFI19pjIndjatilwgLKMmR+/jZm/+S7Ig+0MelTs3v24NRAxiA4Kre3ST8dsPk5qkd7RbLUs9leNvGnYWe1VZiGYiiRUIe151WE8s+xUa1OXLWQHUtnUhX+Pe0hr
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);
 SRVR:HK2APC01HT140; 
x-ms-traffictypediagnostic: HK2APC01HT140:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:HK2APC01HT140; BCL:0; PCL:0; RULEID:; SRVR:HK2APC01HT140; 
x-microsoft-antispam-message-info: wa6IycPzcjsgpRYFKa8qpxvt+CnMERutmJ/mUORC8/vEHcUin8MkBIi2hdTlV+a8
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: 716db868-4e13-4d05-b1d9-08d68d04c3c9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 14:01:30.9735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT140
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_060140_193506_D70DEC7C 
X-CRM114-Status: GOOD (  12.78  )
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
v5->v4: Keep one blank line.
v4->v3: Add people in Cc and remove all lines.
v3->v2: Avoid two times of calling grtform_get_drvdata()
v2->v1: Since there is the only one user, let's remove the err_put_device label.

 drivers/mtd/nand/raw/mtk_ecc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/mtk_ecc.c b/drivers/mtd/nand/raw/mtk_ecc.c
index 6432bd7..05b0c19 100644
--- a/drivers/mtd/nand/raw/mtk_ecc.c
+++ b/drivers/mtd/nand/raw/mtk_ecc.c
@@ -267,11 +267,15 @@ static struct mtk_ecc *mtk_ecc_get(struct device_node *np)
 	struct mtk_ecc *ecc;
 
 	pdev = of_find_device_by_node(np);
-	if (!pdev || !platform_get_drvdata(pdev))
+	if (!pdev)
 		return ERR_PTR(-EPROBE_DEFER);
 
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
