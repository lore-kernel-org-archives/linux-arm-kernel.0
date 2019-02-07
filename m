Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA10C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:51:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26982175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mdi0Ubar";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="fy5pdXLA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26982175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=B2kvMYcPL4aVvnCJbq/69577kh3q3wN+MBk88M5uWaU=; b=mdi0UbarLA7lb+
	nlylLT847gCdC2TLgjBTnveEcC+Y+tXQjmIBwULCd64m642NSssR28iQEDhf7mXG+yoy4cCAMS1os
	67G0WoCujcKHOucgA5vXiFxFdSYXGbq53leNTm0MjB8OAnRibDIml38EcrIxsw4wVrO3wE79o1CS0
	D4iVzXJmGtLfdubVp/E2bYnd+sCX61JAAmVl91d3DSvzmcYdV0oXJufzOwYW3UXOzFfhZfo8lh9dG
	XdRyUpZfyB4KSoZ4v9gNz1pXh4CI/EYA8Drm1Q4wlh9oh7SjXBOGwM3WyY+6DzyyPkUMKJQgEWyKj
	yGGlplYpgc42d9d3nlfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1graic-0001qo-D4; Thu, 07 Feb 2019 03:51:18 +0000
Received: from mail-oln040092253057.outbound.protection.outlook.com
 ([40.92.253.57] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1graiO-0001gh-25; Thu, 07 Feb 2019 03:51:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAgNr3AnAs8uRDokOWBe82bcTepke1seB00KqldPKKA=;
 b=fy5pdXLAHxdleMeOyBBbZZNiSftVkkKvj9wUPrMz59URiBZLcy2QNQIIuWzRnco+b+sg2MFOHuU61bRb6K+IYSuH/Z5anReMrAW5F0TNGDsFnq3Aj61LdiWXYFV0Lp3uXV2qWVKnoml9LNT1jxI/f/0H4eIyj6G3Sg2kFqpiiVTMvQ0Ttqh8N8GNRfndZH1V4Nlwc6nuXgaVhVMhL6AjZBMNC+B9DMQ83KuMrKo7nZmczY+hBXQCQWSUBPEeslPhUZgZ/DfbbxZJWh82+8DYgi5xzlWrHJc0yIx8uHqI9RpQ7vGGfQv47xrfqBHoTt6hcWa//wrc6FPoE3LwYSO8LQ==
Received: from PU1APC01FT039.eop-APC01.prod.protection.outlook.com
 (10.152.252.58) by PU1APC01HT082.eop-APC01.prod.protection.outlook.com
 (10.152.253.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Thu, 7 Feb
 2019 03:50:55 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com (10.152.252.59) by
 PU1APC01FT039.mail.protection.outlook.com (10.152.253.127) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Thu, 7 Feb 2019 03:50:55 +0000
Received: from HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735]) by HK0PR02MB3634.apcprd02.prod.outlook.com
 ([fe80::d582:b3ef:f46a:4735%3]) with mapi id 15.20.1580.019; Thu, 7 Feb 2019
 03:50:55 +0000
From: Wen Yang <yellowriver2010@hotmail.com>
To: "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
 "bbrezillon@kernel.org" <bbrezillon@kernel.org>, "miquel.raynal@bootlin.com"
 <miquel.raynal@bootlin.com>, "richard@nod.at" <richard@nod.at>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "computersforpeace@gmail.com"
 <computersforpeace@gmail.com>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>
Subject: [PATCH v4 1/3] mtd: rawnand: atmel: fix possible object reference leak
Thread-Topic: [PATCH v4 1/3] mtd: rawnand: atmel: fix possible object
 reference leak
Thread-Index: AQHUvphUN4OyaheCt0SC9MTXo7xEhQ==
Date: Thu, 7 Feb 2019 03:50:55 +0000
Message-ID: <HK0PR02MB363495256F9ADB049C795D7DB2680@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR06CA0022.apcprd06.prod.outlook.com
 (2603:1096:202:2e::34) To HK0PR02MB3634.apcprd02.prod.outlook.com
 (2603:1096:203:97::14)
x-incomingtopheadermarker: OriginalChecksum:8826EEFA6AF9565CAF1D57CE604C76ACFD2D8FE52A6A1AB0DD05DFC585994469;
 UpperCasedChecksum:94F998B745EE8A0E68ACC7CB33DCEA9773B0C0E9CE2B4FE987919EDD16B8248E;
 SizeAsReceived:9203; Count:63
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn: [NV9FuxyvFimDwnD1dmuLKDgSPmrwv1/s]
x-microsoft-original-message-id: <1549511278-7735-1-git-send-email-yellowriver2010@hotmail.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; PU1APC01HT082;
 6:sFweAFoDw4SR4ATGTCxsJ9W+a031SmdiB867ZPggPHNQc/+4t/SsFvxCXODtILVlY87mlZmlh9nnLOuNkVXs/ePPu+8IU3/2MlpTLD079AUxwechc1A89yJMY9+0EISyiQqtjTTcXw2YxCjlirkKu11Ku90lPx2sIDTk/D92bAoTYACYbMjXgJo8cW0zew4/fY8pIeKNIUmFQp6svFoI83hxbVyICRYuz4v+dwP362gbcVpBsyArWQWexsXEE83H5Q8TrbHXwErFUOqcGI9wfF/FWzEmykrOOS3f06E38dH7IGkRPBz3ZdcrLVG4Py6rm+/61wUSU4buk+1H69blb+VlMeSbDzZ8bINp551Co0L1Jnfom8sSnJR4T0B9kX2v6GOnsM2IG51fuuWGTr6LYYrPceGo8bf2HO72UHpMt20yGm/EhWKQGnXuEG27myuj5EoDWTfEMmanAX0Y+3fqxQ==;
 5:TQb7PRFtIv38rMKhRgRMLMhW+f0ZF0jg/cKjK5xtn7kp1KiMWKaUsCt7NTbe+ZK42FMDDcIz9i/teTXWk4u55V+8/m/1HB78JQFvUuiLzxS20uQQC9ui18PfU4/b853FLDwh/MKWhg36rC+pkvrDqo1q62067lLnSY+qLFBG683+8FAaj6f6h3x2mi9evBTa9lcN6+A0xDxhYoH4EpLJqg==;
 7:Qri1tEI5iSoennWbgRlWj7g2cYj07HJVHaAcU7PLo76n5O2TSk9mlf5vfAQF/wsUNtjhL537QnzzjOADqm9acm/neg18cjQI0yau9i6pGV066k2iahNd2lbwSH3DK8dxirJ1iWZ012Ggpv+oD42PqQ==
x-incomingheadercount: 63
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: b0omxY8GwpZtOL5FmEVprcShgOktBSYZhzsJHgWxUBcWJl4g7fgyqM1ZBbvIR+f1cl6ROY8qPfw56IbqyOAW8HP7szP30yfdunHgaI/NQlwfBsqCle3Lwy4ptXLVuXpAsKlcpQCMZGpKG0g7K+dIYzI2i+o6Ef3rEp+YUPxpRNlQT36RL+KKZS7g2WjyrSBnW3Q+CfC3rcMU8Ho+R3bvho1+mTEpUf2Kkups5F6HU81wvhVyIrf7HIwQkEakuFgSKNiH5RgVzbPSfjqRDEc3bji8Wh+zzPi4BVS7M44ek41eqtlSvPMrpa5SidUrYqTlm3Lxy/o1ySZJsrShm7swXlZyzhp2XcWOfNv+wLhU9t/a2w2vRUm1z56Ql0uhGo9x8OGZioHgJiGvzS0GANMflCsSTzs14EJ35etZ/oeoBExzemSKdhObJM4IdHz2no4iP65J4qkxIvISF660vOxIm4ym6S63WglXneBa+Fv7Wzhjo4bOulTBuUkMV1QCbQTbsjUf/iNEJ31C/HPKeZXsucdng/rtB5dP7+wRMFUSQQBaCZkZympZwRikmtSRXN7Rl4w8xhYYprfGH6oFb5Szz3qdRytVXYLa40lAwjY6yi9nhlOHn/UjeyPw/efKFhGWhibgDhNGt2dpy1FEOAOpE0DRrMxJNZozfVFFXNGZNVgnDKC5AEh/2zoSBkK2MwXPF92EPJvQTdiBfHVtAt++LzkJLgp5/lXHrakfE4qwDePSFz/ej5YzLWKuSufXWoe+
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:PU1APC01HT082; 
x-ms-traffictypediagnostic: PU1APC01HT082:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:PU1APC01HT082; BCL:0; PCL:0; RULEID:; SRVR:PU1APC01HT082; 
x-microsoft-antispam-message-info: bcWvzUBmtXNf/F647lGi0um9EhWAfD7U9oivkwD9BHx7MfTeKa6BHYvPf8pssC8Y
MIME-Version: 1.0
X-OriginatorOrg: hotmail.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ba58a3-1b46-4594-c631-08d68caf7604
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 03:50:47.3891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_195104_194333_B1817A0F 
X-CRM114-Status: GOOD (  15.29  )
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
v4->v3: Avoid two times of calling grtform_get_drvdata()
v3->v2: Change the commit message.
v2->v1: Add missing Fixes tag

 drivers/mtd/nand/raw/atmel/pmecc.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
index 555a74e..9d39978 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.c
+++ b/drivers/mtd/nand/raw/atmel/pmecc.c
@@ -876,23 +876,32 @@ static struct atmel_pmecc *atmel_pmecc_get_by_node(struct device *userdev,
 {
 	struct platform_device *pdev;
 	struct atmel_pmecc *pmecc, **ptr;
+	int ret;
 
 	pdev = of_find_device_by_node(np);
-	if (!pdev || !platform_get_drvdata(pdev))
+	if (!pdev)
 		return ERR_PTR(-EPROBE_DEFER);
+	pmecc = platform_get_drvdata(pdev);
+	if (!pmecc) {
+		ret = -EPROBE_DEFER;
+		goto err_put_device;
+	}
 
 	ptr = devres_alloc(devm_atmel_pmecc_put, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
-
-	get_device(&pdev->dev);
-	pmecc = platform_get_drvdata(pdev);
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
