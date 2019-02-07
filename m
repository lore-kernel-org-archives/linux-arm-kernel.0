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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BFEC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:53:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F1AD2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VPK8RjlL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="IQaphxE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1AD2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ayyNy7GVCJc4+XdTRL6kimM5osdezr21yqFjHcwWoZk=; b=VPK8RjlLgRN+CN
	kCZfWoZkdfQ2hG1pauC6SZCU07j/D65KojFnOohE1gpJMsFudPGL4sgSM7sulKN8Xg1fu9l6epsCb
	Yj64ecrI7u1Vf94xY9XMqaA8RjZGf1Kfe0CrpiXGh9XipOaSbieHSCucaz+rhF0PqScoj9qdB4CFb
	cXfROsYBZngpmGI3bVrEFJ1RvaOra9aITY/sPDwgg6Ys7Yrp47EGqwQkd/7rAJGjk3MXyGOP21Ny+
	l1ax2vkEdIsUyrtRAVYCX+1w6aQj2YYMPA7+uqISQYVF7BrqOWsWMP+cWA5ZL93S0zcj7FNioW3UW
	o7KTHkOffBxdWfM5TMrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grako-00030U-NV; Thu, 07 Feb 2019 03:53:34 +0000
Received: from mail-oln040092253105.outbound.protection.outlook.com
 ([40.92.253.105] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grak4-0002Ec-Pe; Thu, 07 Feb 2019 03:52:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkZMwuPzKdN5R8UcT7Nk9+VpsvWIElZZzEFty4Z1bM8=;
 b=IQaphxE2WSmJLkSO+E/2ZiyjYkdDD2YLcj3EhIK5RYM7DSqTd+qMEa35v9sYfFa7qm8LGsUkIbANfQEVTMMWin2t4pVCH+ZdS4tah1Q6RBFveh97+5Yz0X0+EZa+7lrij/B8B8e5ew3rA/T6+AwhZrcE9DYWgg2FuSotKjdR92gJNOZzaXIzpdxe/h8LsDURjuZUINAlRQBrh1fzt8ZhtRPS/auVwnElHWfmR7ZGTPoon1zE5a9lrnfJqoTE6A6i3eD6F6kYktGIbyjisXcDJNCp4lueqZOXP4li554KZteWvuUHOnX/A1XDqJ71zmlnFZDvcpuhIrTvrxB0qdrCXg==
Received: from PU1APC01FT039.eop-APC01.prod.protection.outlook.com
 (10.152.252.60) by PU1APC01HT108.eop-APC01.prod.protection.outlook.com
 (10.152.253.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Thu, 7 Feb
 2019 03:52:42 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.252.59) by
 PU1APC01FT039.mail.protection.outlook.com (10.152.253.127) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Thu, 7 Feb 2019 03:52:42 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1580.019; Thu, 7 Feb 2019
 03:52:42 +0000
From: Wen Yang <yellowriver2010@hotmail.com>
To: "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
 "bbrezillon@kernel.org" <bbrezillon@kernel.org>, "miquel.raynal@bootlin.com"
 <miquel.raynal@bootlin.com>, "richard@nod.at" <richard@nod.at>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "computersforpeace@gmail.com"
 <computersforpeace@gmail.com>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>
Subject: [PATCH v3 3/3] mtd: rawnand: mtk: fix possible object reference leak
Thread-Topic: [PATCH v3 3/3] mtd: rawnand: mtk: fix possible object reference
 leak
Thread-Index: AQHUvpiT+gkconwcbkWrejekCB9OlA==
Date: Thu, 7 Feb 2019 03:52:42 +0000
Message-ID: <HK0PR02MB363405B62123937DC17F33B6B2680@HK0PR02MB3634.apcprd02.prod.outlook.com>
References: <1549511278-7735-1-git-send-email-yellowriver2010@hotmail.com>
In-Reply-To: <1549511278-7735-1-git-send-email-yellowriver2010@hotmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR06CA0022.apcprd06.prod.outlook.com
 (2603:1096:202:2e::34) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:361AA1EB720F0733318E5CD7056265887E0520BE2086C4999FBC86236F781A22;
 UpperCasedChecksum:A0808C66A0B291309FC5B80425C088053D2CC236DDE14E614059F819840114E0;
 SizeAsReceived:9511; Count:65
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [QGLXG1TyMlNYWTx4lK+rJ4UI6mBmMBFS]
x-microsoft-original-message-id: <1549511278-7735-3-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; PU1APC01HT108;
 6:iuGVgwt7fzvK8oiMVWhLpYRi5JgO7bQRNwtMxPzCDXPWV8qnumXTcq/8APFvdOmg5lZUh1eDzzhsxRnIP5R4RAwJ4AnfElL7JL0E28dWp6IU6DhVZg/jgo10UgFjfzrnDbJge+zChlOkQg/FzjkKq/x7+tA4Vvv4vDHtbWP+MOcIIyXPolQfFErmdHWLOneD67F0yRm0aBLRV2DDiLBkDSXybuOAz81QaPuINnqyXomKtqO4wPR6GLFGDKcIPro6kz6zo5CjhBM1qd9yDFxCyLo8DIbu77hsvbSOZIMzoEk5/Bn08AHQY4ZvxPdM/ElJNVKVbgsxu5Kbd8C9yM1bPz7GsQE1tvmcBGnYCrs/Y5FhIFA0C7vHrJo0axFZg8ppIjhh/RZ+GnAM1eEZ1VGqXpq2B/hodUc3dHeWJeXJyRivLQu7CwJqBePS5fvDDDojyq0j5x9pJ8ttMPdx1pA2YA==;
 5:kuMM0ud7sGG8j8AMGGxaumJhXfG04pW1/hrjzyPOIu/duxswgqAQX5nDVCQmj8QXLRSShSr0vJfEIbw6B49RC+rQnvQ6W29rfKXnSvUjp6E3WOCVIWSJndO2Kn7D+kXDI5cwW1FCjKg/jJvxUQpYOHMK9RHZzv+zoyU59Fyx4jpq7Xl0+gr9BknrkUzo1Oh1IBQK4w+XjHKW9MQRpbTTgw==;
 7:c6ev/aGc4fGSY/kRz9x+Lw22VHQV6MvvHpik7mR5fg3m+2G6zbu8mxBqIqSo2dXeUs7zAdJLxaHCu+sQYxHdlkuPKlgx7HVI5Iz/3AioRyiDvgTLMzTmVUsca7Yxcg6e7glLnElDbwi7jsmDkW8vyQ==
x-incomingheadercount: 65
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: b0omxY8GwpZtOL5FmEVprcShgOktBSYZhzsJHgWxUBcl6hp5DuB1KqnEwQT/8+7WAdkZdcHLwsD77b6i1UUB29G664+axEa5FWKVfkb+V6ACkpPGg7aww84cVz11ukPbdus3y5FjM4eqZ54KJiqI4q+91dENDz3oXeHoh2ORXW2REE0ls+NUasuFkuL+CXaSuBBnYazG2x+9yC9RJC3DLcIewbREjTjH+g+2mXatx0ES4CB03dxl1Dxgds/mG/K6tI7h4kFiw6AFmXjchqiwcYVugwmi0vUkbGwKK1pjUu9J+IwGlgwmlmV+5Sd/oqteIFLbCiFggF6xlIr/+yRJ6htsMS04LxyiYd4jSF7tnktYNZar/LIOzj0u2yO48jX8EGletC6DchEPYK704yawoihh3JTCWKb7DsmBJSj3fKGBpu+LR6traAyKubPASgppuLcAv84oQ9VmDSr4Ezqry7mVQ2+clHI4Q7Y3aPk3SqKtsL3FgqzgyLiMFProYslUI1H6eGgBjx4/FwuiiNywskDDRssYUgTR01UaCZwmEXqaB53TJNt1vuQOJMQV2/IAMRv4uhL5sexejOgOGyYWxeywSIK95P6Oxqz8OFx7wby6zCDU2RMAcWceymzLW8YpXyG6Sfgtyu9/IyaflzWXal7MNWsrv9P5mzlfQLkIpKufBraOCxXhUlH5HB9H6uOuQt1yZdUg+nDuvt6jziDjqE/YePCa1CuPBqi2CfTa4MF9R+skH5nAKJ3XKGVPla8K
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);
 SRVR:PU1APC01HT108; 
x-ms-traffictypediagnostic: PU1APC01HT108:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:PU1APC01HT108; BCL:0; PCL:0; RULEID:; SRVR:PU1APC01HT108; 
x-microsoft-antispam-message-info: nGX87+Af1EaC0RQYf9b8AHqKBarSjFsBS4Rm5hGlf7zGv0GakdI0LPw3k+yaNPop
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f0d5b7-bc82-4f09-5762-08d68cafb5ad
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 03:52:34.8852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_195249_297539_2AD7EAE0 
X-CRM114-Status: GOOD (  14.89  )
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
 Matthias Brugger <matthias.bgg@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Xiaolei Li <xiaolei.li@mediatek.com>,
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
