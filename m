Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C9AC282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:26:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD9920B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TwwA6npQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="NJFMH0Sj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD9920B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6DLGbTyp23mFNCd9Vmb+1FF0f4gTYr+nVG9iGGMIrzs=; b=TwwA6npQtn/a8b
	NfquTK6wkKtsk1tDc/UJQiw/kyeqI/yX8FKlLQlMg5+X0xxQ0/sZLgoHaHPG4Zv6bK55sS74WhtL/
	bRlyULbR2HQgnfynS44T5qpu5rIBO1o6F+ykvfwLyL1taYx2zNHgfkbzDeDHJgnBwlKzlIvH/b7Xt
	zYgw0IpRJpZwemji+ZrFxTWOcGeqa1RPT//LdufRHR/qrgc7E7JWx63gz7vFQmYX1zcSv2cEA2bg0
	gfFvj4WuZqIhDBWFjaK0Jg6pZTvOD9BWmWntd3sFsTxDBW6YA124DEO7ndoa7bM7maIaaRtxlY356
	hVBeKScBnjfCMzvnm81Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpFA0-0005As-GI; Thu, 31 Jan 2019 16:25:52 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpF0C-000341-Ud; Thu, 31 Jan 2019 16:15:49 +0000
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; d="scan'208";a="26148213"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 09:15:43 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:15:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnm0Ix2qZTFlK+yyhthyBJnay1ftPjIohP/CngqClso=;
 b=NJFMH0SjO/qHbBZO+y6bnMQ7Lo488QB0tSo1AjWUubHpQaD95hcwEvDzdzEM3Je8cnToYYmtam+oPHDCLi3jAQyBSA9WGOgYbLRaMqz1CnJJ8iNAJc4xnWmFCReg1kIZ1GhqCVszU/r/2URRGjZ0zUkAsDTwLW1YgVKpraX9OWk=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB0004.namprd11.prod.outlook.com (10.161.155.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Thu, 31 Jan 2019 16:15:39 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 16:15:39 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>
Subject: [PATCH v2 05/10] spi: atmel-quadspi: remove unnecessary cast
Thread-Topic: [PATCH v2 05/10] spi: atmel-quadspi: remove unnecessary cast
Thread-Index: AQHUuYA0NCso3fwOiUe6LPiLrInzfw==
Date: Thu, 31 Jan 2019 16:15:38 +0000
Message-ID: <20190131161515.21605-6-tudor.ambarus@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190131161515.21605-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR02CA0046.eurprd02.prod.outlook.com
 (2603:10a6:802:14::17) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB0004;
 6:+TSqhdPclHMHE1OjChv3q1YI7fG+zR/8gdk2nOAJ6GcuxJ2pZUZbeJyvRR9Je57TTBOyLNJwsBSwpY7DWJgUmlwOdcb8+m646OIKhGWS+rUZmCl8Qo8kqrhIjSJvxqK0D7xhbpbYcltMNbeEs3bYdlARUYlL8noBuJ0BiunOTBDoawDbx8ZebTcO+W1t3olR0Aag9Eq95V9vbeONAQht5tEkBTPvvZ/bdgH/Qffu48xDt9jVhvPDmnBAQh3V708zyQAGnV1oxF2FSSASZn7uX5EcmSgsXIsW2mFyYziIxM4MPf5doQZX1g8k3IauqvytQtMmJ80J88n6R5MIkmOn+fDoEdn/q/vbd9Ecuich8zEqGOoQyvoGkwykhlY1ffehafVao10xI18FpP135HNdk13RBvNx5V1ZYpBPZQ56P70N+R0Q4PQQOpUFsUQxMCcgCD6cYWrorek5VFO819pdHQ==;
 5:YAwo25diRUN0TCyfhxqzZpCUVspCBDQuMdZ9N5qSzy3nSgFn7NTQ85YhojHbtXAax0ssGwlaISmJsMnf+welhasaGhZ0cOmKfhE89dq7rGxG9z2OKQtbMA69nEuSLb5YE2gN6XnPV8QR8QNYd2p1P8FVs5WHCHNh/28fCeTdkoMhI4M31AYNcGexUU9Qnfy3LQaN0rQSjp5RYnKUWRuQww==;
 7:XICLIMRP4bJNkY+rp8Q1Z0v1BAwL1ZoAO+4uHIZ+flI4Icqqz0VJZRD8qjbhbyhqqJvF8xw1zdZ3n64k74MFn0lltat5aemzMKuj/cG5p4ahwWbV6qv8lTgSxvM/Mpamo50edlV9roemNwjYi6khMA==
x-ms-office365-filtering-correlation-id: 2715e26f-5819-44fc-9db9-08d6879756c8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB0004; 
x-ms-traffictypediagnostic: BN6PR11MB0004:
x-microsoft-antispam-prvs: <BN6PR11MB0004BCD96288D94963F954BEF0910@BN6PR11MB0004.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(8676002)(81156014)(14454004)(186003)(86362001)(36756003)(1076003)(4744005)(76176011)(68736007)(81166006)(256004)(7416002)(8936002)(72206003)(14444005)(52116002)(6486002)(386003)(6506007)(305945005)(11346002)(2906002)(2616005)(102836004)(50226002)(6436002)(66066001)(71190400001)(486006)(316002)(6512007)(4326008)(446003)(107886003)(71200400001)(476003)(97736004)(26005)(6116002)(3846002)(105586002)(478600001)(25786009)(53936002)(54906003)(99286004)(7736002)(2501003)(106356001)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB0004;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +BipufEDubzaNeILkGBKQlfeDUG83ybVRyqnZbBTLWLGKpUNw9zRgJT9IZpZB2itAPQ4kNfDFHyWRLuKqXjk1/W9IDXHn9bjf3CLazSPjvqAvIXK4QBezgsVNhu/9qWkp4F+QCFlrl7FflSQNtbQXsRzwONKysrcUeKKmZlT78FJBea5msf1L3vnF8TU6LQIkXdeWoet7VqNEGVUHRXTLZ/TYZkEb9CeUjZ68OcRo0kHLurE6upNJZRuPZ75lJsokEMSRHIz4el5jaF5zM1Nqwbl3WuYRYw6HHz6VdKB//ovmyV5AU3BYAUG3YpJ+jdhZ/2GFR3Zu4N46+lmm7y2PnMiOMW1nFkSPOy2uXsuiqsGvgu19WHfhIQfxqRvj0yazM6gTYnLXHLIE6tBmoO0yLz3iNgm/cFgFS/dg8amJJo=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2715e26f-5819-44fc-9db9-08d6879756c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:15:36.2114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0004
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_081545_640424_8FD3579E 
X-CRM114-Status: UNSURE (   8.97  )
X-CRM114-Notice: Please train this message.
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

The cast is done implicitly.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v2: collect R-b

 drivers/spi/atmel-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 4105ded68f44..2db935488270 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -383,7 +383,7 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
 
 static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
 {
-	struct atmel_qspi *aq = (struct atmel_qspi *)dev_id;
+	struct atmel_qspi *aq = dev_id;
 	void __iomem *base = aq->regs;
 	u32 status, mask, pending;
 
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
