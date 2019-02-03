Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FE1C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:52:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B116E217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pwYCxxBs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ggZEe2YB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B116E217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=USkvz7IT/UbOgwd2/0QMEn4wUvhSdTSFBbhluVprG9g=; b=pwYCxxBsJOlZjG
	zcprSgFWKmyZU5sIXI5gxydDDBJywMDdzCOPcLBqs5NtQFFgcApH89SypMgqPqMzruDwVjo267aku
	Yth2/Xb4VfFzfxDuhiRPbfIa0DYlz8WxCkB5JoD/nwm0O9oXw7b0+zhkX3T1YFc1qZ178K8Sa7UdW
	9jQGOcQp2HUreef684jOj0OKDzKnKFJiQukQApHb8rj3Grf3RxFA7E+nIZsvf1m9ALgpPUVFS9h7W
	qg7RrEFA4TkTIWTwaeozRkr1NOsVxdsm1eaqIvUHfesTabWNi/gMJsJG/sfv6CnZ41Oh7v/8JZtUX
	zYOrY9P5oZjxIpUkEz9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqERl-0008M6-8a; Sun, 03 Feb 2019 09:52:17 +0000
Received: from mail-oln040092255060.outbound.protection.outlook.com
 ([40.92.255.60] helo=APC01-HK2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqERY-00089U-HA; Sun, 03 Feb 2019 09:52:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsOGHoZCBHKeLioDqBuJWhdrggR2B4Ru5mb/y4c3Dn0=;
 b=ggZEe2YBK1qMqEWHyn2oCGmUwl5r96tZtPY1wsgam/Ya0pzDYAD6xfObVZgEnFVTDcDtKWkMpV6LtM2znnuWFcgfbNTY8c4K6P739KgP01EYY5fA7w4DDXMQILyWMBV1pwxFeLJNb0/Ket6Ux993I1tgn0Bn+qWVsZlHRoAedw4JNjowxgIBaiihCCYoCDJQdquyPJePkfJNFqAsH3ZI5qwgnNwvrP+95GZ7WWH+24ohSJy45MjWlonlMukQpV2k5cHqLziHaYVv+cgFdGgiM4tkXy/Akq8qZ8a23zjKEh77+FwEusRAITHS+XYR1YlrHVTTY0ZD19qZ4vWrUKTXlA==
Received: from SG2APC01FT007.eop-APC01.prod.protection.outlook.com
 (10.152.250.57) by SG2APC01HT012.eop-APC01.prod.protection.outlook.com
 (10.152.250.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Sun, 3 Feb
 2019 09:37:32 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.250.60) by
 SG2APC01FT007.mail.protection.outlook.com (10.152.250.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Sun, 3 Feb 2019 09:37:32 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1580.019; Sun, 3 Feb 2019
 09:37:32 +0000
From: wen yang <yellowriver2010@hotmail.com>
To: "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
 "bbrezillon@kernel.org" <bbrezillon@kernel.org>, "miquel.raynal@bootlin.com"
 <miquel.raynal@bootlin.com>, "richard@nod.at" <richard@nod.at>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "computersforpeace@gmail.com"
 <computersforpeace@gmail.com>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>
Subject: [PATCH] mtd: nand: fix object reference leaks in
 atmel_pmecc_get_by_node
Thread-Topic: [PATCH] mtd: nand: fix object reference leaks in
 atmel_pmecc_get_by_node
Thread-Index: AQHUu6QW1hp5GxOqlU6hrzuVnOgjPw==
Date: Sun, 3 Feb 2019 09:37:31 +0000
Message-ID: <HK0PR02MB363421DE59A282A65E86E589B26C0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:203:2e::19) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:AD436C5779D63736AE9FEA071DFAF7B63881ABD2A802EB24CA101EC4042B8151;
 UpperCasedChecksum:FB9ECEE4A450C254388C9C8B3C68D44E322089F58F0725D3E6717EA0E65F03E6;
 SizeAsReceived:9226; Count:63
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [NsFHbQ3kPTWZ7whdhR7X3rTgQAZzsYFd]
x-microsoft-original-message-id: <1549186481-31235-1-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SG2APC01HT012;
 6:XP+py1XSqFsc8KXEW6SK+7xyyqlm4xXVLc3p2JV4WuAzLimUUmDXwcT1i6KX7CcGKi6lrLFyGDZPEx5iiMFQTkTq9ABqkxPhQiemSvfdVvouDmEfRuiXpkp2Y+xA8U4J7RSGmQIGJgsI0kFiu6X+/6bg/waT7FD/Yc91VyZobY4MZQ1tuWq7x3u3VpU1Er05keS+vKCH6Qpcr71iS7Y1FwPzUi+midD7OCPmK8bYTjXGrqzl06VjzJ8SVqP+rw8cUwEiWZH8M7z/gqlNk2LgW11KfU2hWsFKL9/371b7D5PJHmDlDJPiAdRAUxJp9l06J7lppn88fSw6R2nfJtvrBqE+fuD4Ee6pAnx2kGnvCm5it7htkLhdEVDBoqrcOvLc5+iozTtgKhBnhiCmlqdojj2+aCG71cyCpNiZyA56LDpkq1q3mnYdayIfg5fJN5VBK1tkz2t2tBtlRHaW+CCSyA==;
 5:Jt1WksaaXdKSoatYnjV/ClKPAz4g7xzQ9gzawvvFcEf0IAPMuW+j+mWkDlPlCDRQzmmkc1j6/+pNUVSC/ZjlZTUceCcLG0B1RJhFeaJcoluHHab/OaxfrjM75qgZ4KaAZUVaQ7oESBYYFSomXzXsT1J5X6xglTho7UfwejTgcoRKUFq1qmAESVdOfOt8BXJM5Zu+AT4H/pE01on8kvCRvg==;
 7:YquqLJXB2Bc2ShJzRHEn8eqbRgS0RlLm7Wv8RjSVBI/KU+5aX3yKvpkoE02mWB84Xvf/Y1xGfX3ZCQUgEShHSPkEA3e/c08q0M/gmCZ8uf3guVHpcolBFYxo5KvHglsWDnFSrFgKC2j6kg+koEOqcg==
x-incomingheadercount: 63
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: 7MJMDUNTCtxkjFtUxgCqo8gi/CJsqRdX2SaDzWJSJPKVggcx59wNIq7/u2Nvk4ERFykMFbvUleNIXh35u1iaXPW7pAs6l2Q0MXN/sxrctCxl1w/AMNr5oCk18bqjfAL1YIorlfccwkXrlwAjJ1Flp+TZkNA3cVZdPuWGQEZAlB15Q+MJl5ZiwfrvFoDxEOlX1jhsKTDo9UTcTzko6JGM24f1YAhVRvfo1XCaPeyZf5MJSHDGwv37pZB1HeNDgkQeUtGpAOtrl+Gc8UOgAqFS4ZRhmHtZhusUbgQBgAZ0gSHg7eS+KgZynP5mGblyF9NqJGU5e38EyeIolamYz5ElglDRDuv4hX/0wuRZ/IeM2u63tITiabwxSZqa+1wqmju4ZTYtfPadma7Mc4VZuxJy9a24bKWb6agq03LQqY1Ke/4egaeTt5tAOTO3HUj66sctPyrmKufNVuyTdPeyihN50rmpjcY08j2lZ3+bHhnKRjomPUxO1pEZdxqQJ/H3t38X7XWI5sWTSJAoV/zsJjjuhLcOMiwQ6xWdzf12wKTzZcI1X2lJ1EyMlJdPxt8YCDitvk5b0X3+6jfc2aOVW1SEiOlrp3uw8d9MXN7P2CSglGOqf/xeRyHTWkw6dSGQdLg/RehWAT0nd+UAwnJWdjSz/lNKvaf5CHQh+F7PV4YcgwpNRULivdqkXR1/QoeaVyO+BRz7hNvW/CqrTHSQ9H2jb/kSQpzzseFSqtICX09pD8dXUOK1cnQE4A==
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(20181119070)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:SG2APC01HT012; 
x-ms-traffictypediagnostic: SG2APC01HT012:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:SG2APC01HT012; BCL:0; PCL:0; RULEID:; SRVR:SG2APC01HT012; 
x-microsoft-antispam-message-info: AmyBA4ztjPFqEWM23ffIKckyZLHXPfLgyCn/lsBLNkTx7/lMW+LWoVY+jRbFNFbY
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f0245e-cb10-442f-886e-08d689bb3824
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2019 09:37:30.4405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_015204_637893_3BD68AD5 
X-CRM114-Status: GOOD (  13.93  )
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

Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
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
 drivers/mtd/nand/raw/atmel/pmecc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
index 555a74e..bee6551 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.c
+++ b/drivers/mtd/nand/raw/atmel/pmecc.c
@@ -878,14 +878,17 @@ static struct atmel_pmecc *atmel_pmecc_get_by_node(struct device *userdev,
 	struct atmel_pmecc *pmecc, **ptr;
 
 	pdev = of_find_device_by_node(np);
-	if (!pdev || !platform_get_drvdata(pdev))
+	if (!pdev)
 		return ERR_PTR(-EPROBE_DEFER);
+	if (!platform_get_drvdata(pdev)) {
+		put_device(&pdev->dev);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
 
 	ptr = devres_alloc(devm_atmel_pmecc_put, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	get_device(&pdev->dev);
 	pmecc = platform_get_drvdata(pdev);
 
 	*ptr = pmecc;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
