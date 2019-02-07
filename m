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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDBBC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:57:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547FE21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="et9c6+8i";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="dVp9D/ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547FE21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=M2YnzqqW1jD9+j1JxWGMtKTQqJQCZ6R3ZjvXwkUX0aE=; b=et9c6+8iOrFJeW
	c4HlSOULdRQvhRNrbVLVRrxVn456F6Glp4v6cS0FAGJ1nsnP/kCFUnwZb7ufVKaqVsQ1m8dFCRTjO
	atDEXSgkCYWx5D2hnEL8N1khrcv+Ww0KJop2U/QGIpbAqioBaf71tGsJiSnAeQezhSILIb1dHNP5u
	aCNf9V2esmVO+3mdbbk23rQ4JIiXhyfmJsqElMVXn+FMqK0sbt4KppAzptGZQJjE2i6QmjtKAVznj
	gkdZ4IlB2yWTg1qqXvpN+S5AssaZvi26ryWYae5fX3pd4I0WueehWDgi+kvJIHpLsKwmiW33qZhpM
	GF2//KYx5McVewpkiLAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1griIm-0001u3-Hk; Thu, 07 Feb 2019 11:57:08 +0000
Received: from mail-oln040092253052.outbound.protection.outlook.com
 ([40.92.253.52] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1griIY-0001it-F9; Thu, 07 Feb 2019 11:56:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vClQ928zIDAaubkoLf41c5wafx8MVFit1v2x0Dlu72A=;
 b=dVp9D/bajLki6g1WfEGp5AizFz/fMKI+mYQxoN+c5llQiBYpgy/GklfHWjqEqsvs+fCKuB8UN/u0FhOhUP4ADP/OAjhwPZcYYaEvLP3OXzr6XjyXzB/ceiKEYtpdCPslf1MCc1cF/d+VgbF+ujx0l+HF1iylOeJ1gsKWIhgQH3EI5iMChvTuVAEOTfNOvueAlmFlXGMAVCvWhdZpARj4xMqFepITwc3savEdgXWnxCHNAHOyY7lfoiuWRziE6huxiCkoq0xTFX+1UceCalKFrg/a8kTP5mcCBOSMuJIpxhVxcBQCAQx8EH+/ZrCL6iM7IRmyQj2BIu68rSzA3Sb4VA==
Received: from HK2APC01FT044.eop-APC01.prod.protection.outlook.com
 (10.152.248.52) by HK2APC01HT213.eop-APC01.prod.protection.outlook.com
 (10.152.249.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Thu, 7 Feb
 2019 11:56:48 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.248.60) by
 HK2APC01FT044.mail.protection.outlook.com (10.152.249.115) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10 via Frontend Transport; Thu, 7 Feb 2019 11:56:48 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1580.019; Thu, 7 Feb 2019
 11:56:48 +0000
From: Wen Yang <yellowriver2010@hotmail.com>
To: "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>, "richard@nod.at"
 <richard@nod.at>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>
Subject: [PATCH v5 1/3] mtd: rawnand: atmel: fix possible object reference leak
Thread-Topic: [PATCH v5 1/3] mtd: rawnand: atmel: fix possible object
 reference leak
Thread-Index: AQHUvtw0v7Pv1b4EOkC03ETDhiROkg==
Date: Thu, 7 Feb 2019 11:56:48 +0000
Message-ID: <HK0PR02MB3634B38A3D04DCFFC09BDCB0B2680@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:6D0DBA86AFA54E5543D27035A49F6BF91403A2AB165BC584CF30FB44C4EC9838;
 UpperCasedChecksum:24F654D9E8572B8E014AAB3B60655DE07547F0A7615F12FD9D4750AF9A24EFE3;
 SizeAsReceived:9212; Count:63
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [3AMYTsrulyhhvIl7TkbrX584OONqY83s]
x-microsoft-original-message-id: <1549540447-11704-1-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HK2APC01HT213;
 6:hlpgZQLuovtVSnLVkxHLcGcoYH2xXJcRPGWlqD6DUVFjK3iFlL8bXuhAgt59+pMmav++XXH/f17JchNjV2J7ys7AawEYKs84OYiWMBaXqKUNcg+knI2PWUPY11o9rnSgAweDS1InzL3AN5RSHNky9uRtQbwUXJmg3C2+EM1/W3Fb4SEjdrKB4k65EjSFYBh0mBdjoobsk9p0fgXC5e5VTOH1jR81lYHmYCRa7pJUkzdjosifmmxUtPuB3uuQU772Y1oxhMDA8CU1/fdHq2c95wCs0ROIJmwFMqfJ5ubTRKft6uwNSqNkLq+p8Xau7wwhe3C1T0hhQJOx+Bh42n+B/OCjlXWg0mIQYZK29dSykluLOLqEEpel/RJXO+XGmglIdR/Bo/NdKEoI8zfhSk5AcvowU4nRQkp+m4n9lqSW3owURMAzevF67XmwEqP+WVpKK6084fxGSkmTZyYyQ25EuQ==;
 5:mmgk1E6JXtwrWA/z+u77e1ZtOUHVTkn/UPCKe3oeKNG8wTphYYPFaLW2JoxP7msrQF/SJBO2h5AtG+lKP5Ee5DfB1e7xqua2uVe/Lb3baeJK5bdNPZpvVr9ZgLVcP+TURUvIHaoTL3KJUdw5W5fF0pSEDFStmUxxFrp1XC+FjQuDyYGpHQO473/pTtQGJ+DWBvPqPCZiyfKRqKqHz4f6xA==;
 7:hKFvJNQIMGea2a9g4iHWCg1T5pEilLCUuirMn8/s4FnMEL3wn82L1rfxvY337ywm5KSd6VOdcMSqAfp1AbFWqBI/eI9Y5PY3OI0HqtkpRUJ6h9EVlSwFv0lFoWqJtQuF6knAiTui/LPgdtcY/v1Igg==
x-incomingheadercount: 63
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: b0omxY8GwpZtOL5FmEVprVixbmp3zFeANWKwPYN6H+eu+GO7Pe3DBklKPGinX+glAe5nxall2k64j1uf469voB3R2+JNMcEgx1vnEuABkdbB2xf2iJwvx1BaMyGAws61S4wSdST9p7B5uq28wqllkuijPANeEhceM1QrYhcfnA0kVVLkTYSkyTzxGvrX5I9HgRS8sSOSW2K0KBV4tRsII/ejewii5iA0j9LhISdkyKZ/vdgUVy8i6feqf9V+vDjOGN4HTE7b8COrOJnKSsciXNaqTcbIHA58oVrw9VIrAxiUT9G8MMp+BBMX7TqnqNZObI6yoSyQ7tGl5J+2oNS3GLg+GMwTCL9zacyzrQe7I9cma3X+i2txh0HrFSY3dA1g36ZwytFaK7Lr6pa8Iz+cqJkTvM57JDWHcDCcmxSMlHplY4LbwholpxYzZ6etXwnDkvFqLG7/QLWYhqpovNlMq95h78RavBzVbznLpK7JZP4a3zx3PRDkCBawVkas2UgMqSpYpgw74WSRtI+X1mSIiXPf9w5xWU5zPkpENex0j+bHB7G0/pVre7pzF6pR2KQGuNRvlSBrgKyqrxIY55+STopNphIHhYcSmFyDPHJgvrYXt3Vj5LsK0/34QGbaVGc88PSk8zBo0vAuF9olC4UMExZ60Ix8DOgJRHGSnSByYjWpZvehoBpP/Lxe7a/XzVnbKZe7fAAtek+wn/SGkAjk4Stq1woqdjjZlzO0g3uQJ14urbVn6VkeC1LbfgR0W9g8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(20181119070)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);
 SRVR:HK2APC01HT213; 
x-ms-traffictypediagnostic: HK2APC01HT213:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:HK2APC01HT213; BCL:0; PCL:0; RULEID:; SRVR:HK2APC01HT213; 
x-microsoft-antispam-message-info: PSNkHPErkCZCTbUWj8g0sO0ms+vMHieTM8ddYpPT4Njf7W1KzPuhymcKwxrhoOb4
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: 009f4fd4-5f8f-4f5f-9e66-08d68cf356f7
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 11:56:47.3937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT213
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_035654_603184_2AE39DB1 
X-CRM114-Status: GOOD (  13.52  )
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

Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
---
v5->v4: Add new line, add people in Cc and remove all Cc lines.
v4->v3: Avoid two times of calling grtform_get_drvdata()
v3->v2: Change the commit message.
v2->v1: Add missing Fixes tag.

 drivers/mtd/nand/raw/atmel/pmecc.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
index 555a74e..97e47ea 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.c
+++ b/drivers/mtd/nand/raw/atmel/pmecc.c
@@ -876,23 +876,33 @@ static struct atmel_pmecc *atmel_pmecc_get_by_node(struct device *userdev,
 {
 	struct platform_device *pdev;
 	struct atmel_pmecc *pmecc, **ptr;
+	int ret;
 
 	pdev = of_find_device_by_node(np);
-	if (!pdev || !platform_get_drvdata(pdev))
+	if (!pdev)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	ptr = devres_alloc(devm_atmel_pmecc_put, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
-
-	get_device(&pdev->dev);
 	pmecc = platform_get_drvdata(pdev);
+	if (!pmecc) {
+		ret = -EPROBE_DEFER;
+		goto err_put_device;
+	}
+
+	ptr = devres_alloc(devm_atmel_pmecc_put, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr) {
+		ret = -ENOMEM;
+		goto err_put_device;
+	}
 
 	*ptr = pmecc;
 
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
