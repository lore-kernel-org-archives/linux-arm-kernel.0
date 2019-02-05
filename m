Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21621C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:45:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC3F2217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IB1AHWZ3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="uCDAwrxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3F2217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NlxItiOwu0iThYE+FfZRSc2QdzvIUE+N+EbRzZcaZNw=; b=IB1AHWZ3p6NvAy
	L4g7dDN/8HbCES7/3NoNPROiHMdX6aOmZ0WX3tWLzhf4L/gGjna4afbtm8ExlufFM6qDvL9+CL/3o
	Y4e1PKS4xIA+s73CjhfoQFuwoH7jLiAExktsr/fG7TWNAaZEgoflny08Fja2ffgyrknsp4GXL9ORT
	4vItuVgXhYA+34W3H+QTSos/hBTXyfvG0uFE0tCbbmuUqRcNPiaHkNBH5wa13mYdiGd4WVMdrUTzP
	BGixwN25ztnvhJTSlRtiutah3k+dMt3XZloT2EqIWqUXKnK2eqArU7ZE447U9MiS2gr+0VygiEU3K
	ufzGL12SEa6K/jVAAivw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr2ux-0007QX-TB; Tue, 05 Feb 2019 15:45:47 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr2tF-000418-MP; Tue, 05 Feb 2019 15:44:26 +0000
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; d="scan'208";a="25876508"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 05 Feb 2019 08:44:01 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Feb 2019 08:44:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Mf14YKJhbUP5xf2IwFWWlU1YAl+n1e+fZ+kgdJGKEQ=;
 b=uCDAwrxb5Ld8Mamz1QvmVLwflgApRfo0GTaQKXvo8fFKuwn/1Yo3Zx3AvbCO/r+lTxY0irvqdjbf4F4vOfPPFVB4ADLprTHJcfzuvykpzUNaxhnyAMVjMHblxi6qkKOoWR+lJan2AMgfTPj8AUIqSNKME9ZcOYyd30LX3T4Us54=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1235.namprd11.prod.outlook.com (10.173.26.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Tue, 5 Feb 2019 15:43:58 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 15:43:58 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Subject: [PATCH v5 11/13] spi: atmel-quadspi: add support for named peripheral
 clock
Thread-Topic: [PATCH v5 11/13] spi: atmel-quadspi: add support for named
 peripheral clock
Thread-Index: AQHUvWmbpiZvRBAaJka9NvhpH9wfAQ==
Date: Tue, 5 Feb 2019 15:43:58 +0000
Message-ID: <20190205154257.29529-12-tudor.ambarus@microchip.com>
References: <20190205154257.29529-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190205154257.29529-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1235;
 6:4UiCp5lm3AgRZQq5HW6ioREFEImwagVzudIPAHLJ1sSctoDa1BUb7Ni0CjGBPO2dafi6rg/E3tetJJ3rTBthcJQrpjcU7o+MBpCoD86i9Eu1STCUKkDgcuGfFjkZu9NR63NEqToBCwjZWSSUsM7ZNRcGfVmnzSZIpbnnjSIXSWp9CJDnNLuDlt7+DbZg7qUDRdwOBhrQAHUBMvgoP/5kB8rrWJFgcpjhh2JFhYvJBnzBYvusNKTjsnDJ5kWn6bjHmPSdv9sOg5PBE2h6KrmD3p98Jcxn4+mqudQjWoABeQHD1jqmY55POYjrKXbxwBveUWeujHXd3o6ISNEy6iLnZj+cPgQikKgpILZGD4hqI07LtNkzWlmEaWQnU6eCKtsTgKcjbfrZmO6MmNxb+RP1nNKUSPb2f2iIpLFEuyDNs+1d5gIWM/YRH3PLpF5i/JPgny1Y18RoanbAtMP8ZxwvZQ==;
 5:B8UL9Mmwau3b6Yy09WY5Zhbh4/3mYVTQlDSTj5XnEz1HIUaoQelX6DF6uVIz/xXKfSbsbbc/NhyG+yY+52/erU8LfnAgnXytny0v0BE/qreTpHnJmwARFkMgFAwMTbtrHhRjipYiBe3XoBCMLJuWyAfJa4dXjw+akPlXvi/JCjuCytJdhB/2XNqoMDqi9rAgidfEMidvqPcGCU8xemkC8w==;
 7:wZHkIbpU9DWlOQKRcFQr0p7EbyIPJVS0DiwaTt9LILFJo4nN+zCaw9fX1UgZoi3nMzi462CgTWbKRNOktFR4+7+GfMSmH99pRYuu2Mhpl+m42rsrcFMA62uSdAEMDwD0XUTcLhT0M3ZSnGN4lodmYw==
x-ms-office365-filtering-correlation-id: e26e3df7-ec33-4e4e-0e96-08d68b80bdf9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1235; 
x-ms-traffictypediagnostic: BN6PR11MB1235:
x-microsoft-antispam-prvs: <BN6PR11MB1235170A94B3198454AD945FF06E0@BN6PR11MB1235.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(376002)(396003)(346002)(136003)(199004)(189003)(14454004)(7416002)(486006)(305945005)(11346002)(7736002)(2501003)(6506007)(186003)(102836004)(26005)(68736007)(71190400001)(2906002)(476003)(2616005)(106356001)(97736004)(105586002)(71200400001)(86362001)(54906003)(72206003)(446003)(36756003)(4326008)(6486002)(6436002)(386003)(478600001)(25786009)(1076003)(316002)(110136005)(8676002)(81156014)(52116002)(81166006)(8936002)(50226002)(66066001)(6512007)(256004)(53936002)(107886003)(14444005)(99286004)(6116002)(3846002)(76176011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1235;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +2JCekksgYIuhDYGXXhKdunFDqhynJGEPNAEWVdvccU/pkwFFSgbCZxp4aBHe0upquRT+7X5o8GXWPvNZfmBLITfXOJr8tQl09JspfswVIxoSFW0rz1Dj+aml4o8JSFYakzpRvaakZ6bvCYfUv+qYGxfW6ruztHAI6rXXGGZY7dWfXzeIOWjgaLt2ZQ/VE2kb/52iqrUxIkjb5eOYUp+VbcvaeECj227+Zi4LXP4YleYszByzrGvM35875N43tewVOsZwtNUn9FiEjDS/7as7JpxCaXiSW9t66Awu5Pb0xfpXJ0BB0pXBscgPjpwXWLyBEXAUDHcbcgK4wt5kfmnIpUWCcKmtIgwN0uSvuJfipXqN6Ze81Uuv2NKUhUC3o4BULJsE6+vODItpo8AnwtBgn4j4qkUXqMGH/bpYhtU17I=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e26e3df7-ec33-4e4e-0e96-08d68b80bdf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 15:43:54.8988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1235
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_074401_991238_C0E96A61 
X-CRM114-Status: GOOD (  10.80  )
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
Cc: devicetree@vger.kernel.org, Tudor.Ambarus@microchip.com,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Naming clocks is a good practice. Keep supporting unnamed
peripheral clock, to be backward compatible with old DTs.
While here, rename clk to pclk, to indicate that it is a
peripheral clock.

Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v5: no change
v4: collect R-b
v3: new patch

 drivers/spi/atmel-quadspi.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 19a3980775ad..336501d962e5 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -137,7 +137,7 @@
 struct atmel_qspi {
 	void __iomem		*regs;
 	void __iomem		*mem;
-	struct clk		*clk;
+	struct clk		*pclk;
 	struct platform_device	*pdev;
 	u32			pending;
 	u32			mr;
@@ -341,7 +341,7 @@ static int atmel_qspi_setup(struct spi_device *spi)
 	if (!spi->max_speed_hz)
 		return -EINVAL;
 
-	src_rate = clk_get_rate(aq->clk);
+	src_rate = clk_get_rate(aq->pclk);
 	if (!src_rate)
 		return -EINVAL;
 
@@ -433,15 +433,18 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	}
 
 	/* Get the peripheral clock */
-	aq->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(aq->clk)) {
+	aq->pclk = devm_clk_get(&pdev->dev, "pclk");
+	if (IS_ERR(aq->pclk))
+		aq->pclk = devm_clk_get(&pdev->dev, NULL);
+
+	if (IS_ERR(aq->pclk)) {
 		dev_err(&pdev->dev, "missing peripheral clock\n");
-		err = PTR_ERR(aq->clk);
+		err = PTR_ERR(aq->pclk);
 		goto exit;
 	}
 
 	/* Enable the peripheral clock */
-	err = clk_prepare_enable(aq->clk);
+	err = clk_prepare_enable(aq->pclk);
 	if (err) {
 		dev_err(&pdev->dev, "failed to enable the peripheral clock\n");
 		goto exit;
@@ -452,25 +455,25 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	if (irq < 0) {
 		dev_err(&pdev->dev, "missing IRQ\n");
 		err = irq;
-		goto disable_clk;
+		goto disable_pclk;
 	}
 	err = devm_request_irq(&pdev->dev, irq, atmel_qspi_interrupt,
 			       0, dev_name(&pdev->dev), aq);
 	if (err)
-		goto disable_clk;
+		goto disable_pclk;
 
 	err = atmel_qspi_init(aq);
 	if (err)
-		goto disable_clk;
+		goto disable_pclk;
 
 	err = spi_register_controller(ctrl);
 	if (err)
-		goto disable_clk;
+		goto disable_pclk;
 
 	return 0;
 
-disable_clk:
-	clk_disable_unprepare(aq->clk);
+disable_pclk:
+	clk_disable_unprepare(aq->pclk);
 exit:
 	spi_controller_put(ctrl);
 
@@ -484,7 +487,7 @@ static int atmel_qspi_remove(struct platform_device *pdev)
 
 	spi_unregister_controller(ctrl);
 	writel_relaxed(QSPI_CR_QSPIDIS, aq->regs + QSPI_CR);
-	clk_disable_unprepare(aq->clk);
+	clk_disable_unprepare(aq->pclk);
 	return 0;
 }
 
@@ -492,7 +495,7 @@ static int __maybe_unused atmel_qspi_suspend(struct device *dev)
 {
 	struct atmel_qspi *aq = dev_get_drvdata(dev);
 
-	clk_disable_unprepare(aq->clk);
+	clk_disable_unprepare(aq->pclk);
 
 	return 0;
 }
@@ -501,7 +504,7 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
 {
 	struct atmel_qspi *aq = dev_get_drvdata(dev);
 
-	clk_prepare_enable(aq->clk);
+	clk_prepare_enable(aq->pclk);
 
 	return atmel_qspi_init(aq);
 }
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
