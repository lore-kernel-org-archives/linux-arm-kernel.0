Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E28C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:21:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 154FE2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VkM/LoHN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BsrQtWeg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="MtJPNFFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154FE2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R4znw3Yx8MF6w5M0oshpRP/fgjcPTz4RsNdgy/JCSYE=; b=VkM/LoHNdFp43Q
	I7M9JePVyj+FfSNzcGyKmsw6iOB09vROD2fz2GDXEiOU1nz9Lkbbsvpss703F7cHXS+te81MWHKkX
	0nNeMNlOEQqi4yT40Fg3qXlUjRQf0QdPFukJBUuTlI91qYqDqNw9ME1mYEGKtG7Vs02PaXNWy/Ueq
	udRah5QHYP2C8/qTYHtWBspx7kvqBd6ojq36JFiL3rS0fPCl+qoMnPv0hVHMXZWskdP1vwRu/p/Sh
	gMVgZp1EA0T3yyrF4NrGQMmSFFhGvDbh0d+vRJtdFR6nYMu9Scggd7fsdS8hJTmEJ/uNBMOVIjw8v
	tJU9f2zGMhUppMTGIqpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqbNG-0005ey-9Q; Mon, 04 Feb 2019 10:21:10 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqbMo-00053r-H1; Mon, 04 Feb 2019 10:20:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+28Y2aJ8lIMlNQDPgbnkcqOqn5q0Pm2UPftgTWFysnk=; b=BsrQtWegDjKUuVIm3FgF4gW2kk
 eaMbAH1e8oAjzmEPi9LpO8bfUcXPnwHsBoEdVtJGn1ewnh2Ygfl6HbWY370RKGtv9w7rrtZ/VKOnt
 o1JnvOXPAgOh/fLva1puaZXROANKuaukKV0Sbe4i6+NzdWQbgQ6Vc+oV7/RLRPH6eSkL4Q8g867U+
 cKegCBjOps2wuXQ6cu2P7GIYghtpBMjRNh4ayUIzur9Zi5C2stPLlauSeCRthS0ciRtGR2UbraePc
 QB+1BPJcJ8xXOpqAACf111MfAK1Cit8HRiZNEAh9WrALwvKBXfAnqS2/6ZwmerSQin7IONxC4ibzM
 qh00cBqg==;
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqbCb-0005Te-1m; Mon, 04 Feb 2019 10:10:11 +0000
X-IronPort-AV: E=Sophos;i="5.56,559,1539673200"; d="scan'208";a="26269144"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 04 Feb 2019 03:10:06 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 4 Feb 2019 03:10:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+28Y2aJ8lIMlNQDPgbnkcqOqn5q0Pm2UPftgTWFysnk=;
 b=MtJPNFFhItlI1W4e2/kbk5eimMNwaH6+MqC2gN5Y/aPEVOIN3ngd9tVnt/soEP+1Ef4dNtP1hLWmYnwr38jVYL1nT6lEG2gT8myhhvHHpxDFwvBVYjfVhhz3/kbuxUAU1p6dX92Ru10sJn/1/SjTLeGSqXkBXLb1a2ZlZmSH6is=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1508.namprd11.prod.outlook.com (10.172.21.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 10:10:04 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 10:10:04 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Subject: [PATCH v4 11/13] spi: atmel-quadspi: add support for named peripheral
 clock
Thread-Topic: [PATCH v4 11/13] spi: atmel-quadspi: add support for named
 peripheral clock
Thread-Index: AQHUvHHMdbu+8gPxv02aD+K9PloJHQ==
Date: Mon, 4 Feb 2019 10:10:04 +0000
Message-ID: <20190204100910.26701-12-tudor.ambarus@microchip.com>
References: <20190204100910.26701-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190204100910.26701-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0270.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::43) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1508;
 6:y/rRzrmttsHLtWSgHgm9pNIC2o9JzK3eWQn+l4wja+cakrGomV3rTHe7LBH5ZSZbjcJiTuQi7dMEOsu5mpeaWWnjRllD0hEDo5cNtzRH4oEPjSrHKeBXLpyrjx2BKaHyg8KJnQNkjGMm/CceqFEgw/gxLBwv/1ReBfDQiMQnPMHOCcdazBhH2YMJq1wnrwLiXahE3dgcRczaiqImkgjsyMjyj6tKlstX34QK6B6XVk2j2k6+3LGktKIhW1DQNCKxBvv8QTIzm/mtuaymm7FRXgjtVA/r4B/Ue9cCyAGJIbNdFBvwmgacwzuGGlipWuTuzKvuCAPLFY3liUruVWnsnl/OgD1ew/aKYOw0w+NDaUCyGAl/Kf1leBuSoQPRPvPgsoUthgCMLJxQ5RKPhjzFnUxWpYHBBPA777nOTtNB2vRAMZsEtIb9IedYYeNuA1+Q+S436Hly1wFKYmo4/fuO/g==;
 5:+F+fWhsuzDAGQLehqbZK1K/4M51Q/4/lun0LWJNuzMTeKNABH5zSIICrYa18HwcRBle3xzsvYt/M6X58ePK0pZrRZirJnBk792YKpdMPifWHNh+lt6LJ6us4l+4+zIFZ9zRSDOvs9cP8TtNsH6O6xP97LBDuaf6nFOvQ2C0ykEQ80jnIbjxqVNjX1jrQEtQZLagDHA84v6EbTqzaOy1Lyw==;
 7:w802giGm6RycDJ3lwSW2b4oXug3Ge4CEUwOD58X8PCt3VQvI4wxAUb8E5RXC9KoRCCwr2HpYrBNjbdZ/mxLF0NRhInFbFUdzgjICL7tl9SsHCxf+wqnpaxW8d8Dqx4xbSMT/MZb5dPnHuc/4AUCNeg==
x-ms-office365-filtering-correlation-id: 79908c6a-6ee0-4ba2-4a60-08d68a88ee90
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1508; 
x-ms-traffictypediagnostic: BN6PR11MB1508:
x-microsoft-antispam-prvs: <BN6PR11MB150801C301FBB6D06C7D951EF06D0@BN6PR11MB1508.namprd11.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(6486002)(11346002)(446003)(2616005)(486006)(106356001)(99286004)(6436002)(4326008)(105586002)(478600001)(476003)(76176011)(186003)(53936002)(305945005)(3846002)(6116002)(7736002)(81156014)(102836004)(26005)(81166006)(6512007)(107886003)(8676002)(25786009)(68736007)(39060400002)(52116002)(50226002)(110136005)(8936002)(2906002)(386003)(54906003)(6506007)(86362001)(1076003)(36756003)(71190400001)(71200400001)(316002)(97736004)(7416002)(14454004)(256004)(2501003)(14444005)(72206003)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1508;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xmrPJRi2JAxbkkFjW8L/UWrNYJ2tRui/EF/jTKb4MENKJuSmgWfuHHwBrgv1r0wZKOkZcnlI3a/+wb2ZT7Ow863PCY7BYuNDRPSi9eY44/1bieC+eA0rDF7cf7Y0ejPXr8/vaGQz63z6zpKAzWUSrwCs6QHv9CP6NaINUCKbyqxxoH71AqHIAAghGDlFPrHBCkRI2jjKxSg5YgBlVC+y+zirgdkfbvLRpRXE/xTwZPjPRWTZ1EMgiyAgobVEjw62xcrFJ31bcD6NT2frYnYbFSdo8wPlRvvDvZVd/JdozyvtQM2WXDOeLWqegt7e0t6Q222bm6InDVuQvq5yh/3DIUUtaem3D/qYLk/00HfrIpORn0QZ/BpvcNYMd4Q6P3AP1pW/N5aohzG7XuNpRUkLD2laR8MKDr/vD2iHxzdfUKo=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 79908c6a-6ee0-4ba2-4a60-08d68a88ee90
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 10:10:01.6411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1508
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_101009_503033_21E97B82 
X-CRM114-Status: GOOD (  13.04  )
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
