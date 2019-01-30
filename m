Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322A7C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:10:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F18C420989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SVOP/PxD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="sLODAXn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18C420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JqfeeS0w6jTkqpQJQdlb1h7DBwWiy1V8kPrK8nUsCOc=; b=SVOP/PxDnsI3XU
	keQ3IDpCxemntDw9TvVB2vvXF6m3v5J5HDWfscyY4jod+1cigM0tC1OWwNtCNHTzi+hcCxAX9kG0n
	V/q7lr5v4zsrwvntXSxqnYazg81XynvASQoE8+/qSR+Cwd1l1JnR2UNwXDqzz9KEjgrWePDsZyJk2
	sow7Q5tULy7PDA/ZwI8ER7V+H20+IGFhQ/DajnopV2ItXEAYZAmAzRNkMKuy2on7qmwqXPO9If8NZ
	g/zX4MG8Jcy1KYRkqnS+SrVBbDkkmIm+khSm3mU+yGjzzT7+wntbSvYntPfVO0NcZdwa3u1GWAG6v
	kjsO+skMP4NxqJOZ1ooQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gorVI-0008W8-Lz; Wed, 30 Jan 2019 15:10:16 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gorTe-0006ZI-S2; Wed, 30 Jan 2019 15:08:36 +0000
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; d="scan'208";a="26094008"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 30 Jan 2019 08:08:32 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Wed, 30 Jan 2019 08:08:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSLozwod+1M6y77B+xgZBns+IaC0DyuikaO7LfLkkc8=;
 b=sLODAXn5BDRn8R4FrYxW8afptrrADi59M7WoZMg6OW6vSJXQUCw+Men8xfxcLBy875qQBsUSqUEtxr780FzUGoWI0hevWX82z6t0p5S7B39wuqIEnIsRIfi7xDYzGMrhx+EfCYcbc9Nfz2Jy3x62Ufq12CbgruVXr9ZQuWobeVM=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1796.namprd11.prod.outlook.com (10.175.99.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Wed, 30 Jan 2019 15:08:29 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 15:08:29 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: [PATCH 1/9] spi: atmel-quadspi: optimize qspi init
Thread-Topic: [PATCH 1/9] spi: atmel-quadspi: optimize qspi init
Thread-Index: AQHUuK2oYIgYi2Phc0CCu9Nb5y7hkQ==
Date: Wed, 30 Jan 2019 15:08:29 +0000
Message-ID: <20190130150818.24902-2-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190130150818.24902-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::32) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1796;
 6:mSa7GGHJSNVKZ8jQuUdIkUR6oHTTyvVuPPJAchjF6wYYFU/sZzXbckUdI65WJPkFb6Ig/HlxJP8iV0/bb4v9PbfKkCJXf/LDu+vVMRyR0SHWKOvvSeGv74AtVQtwgVYCy7yuQXdj0MLqDESu+fE/7frx6aWpBQcaoL7SNO6BbXbUpK2KDaOJv3TkmUoUd+LPyx20qARVnGhntGC4gp8RhN2Z1AvvzycLei6mW1S4gXumFJFoylPILLzqjSCsZPaA3zeAaS2qvu+DEPrvpbXOhR/LbHDpA//uQpq2wcaN1n7iNbLqF7Xh/v32Mz1t8jQzdFcbjhX4EasDggg9paCbYB7KvvnVSR6D6khgdPp30QZVUA/+YWEjqDe65feY5izQzpa1xg5Txdlm710E/U8K/4YiPdsF309SVJJT5u/NsWHbkXmqJCcOgiwxMVYpNzlDYaOe5zHsKGTCP0sO1nIGcg==;
 5:76PCBtuXDo7ErjEdW4SeKVSGbQV72biDV+vCMAHsPtDCknUm5HT0eKF6EhMGv79A6DbCwJDZgoxFHwuDGwpLBK/Xoj54w7GlwrBAth8aOfRnJn1QHeGVBrlCtOpMarfh9dNz8nb2nfBjA+q5QGPDdIN2bd4kIFzaK1/7p0YcxlCFEkjIgAtvZNjoaz36REzebBCv2TLt80qnTwiqMN8QcQ==;
 7:dPVIzvcyrzXnlkpHfIidIvIDU6fwTKT9eFKB8RcArA/NMt09S9XU3NNKAo6Po8FCyisBKEoiIWPHLVjvdZCizVzN6G8a/l0XZkkcUx+tXQKEYjYwjz24XemGm+HWE8sUtMiUtNcc1GsekYiHkZJ95A==
x-ms-office365-filtering-correlation-id: a805563f-899b-4bf9-4e7f-08d686c4cac0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1796; 
x-ms-traffictypediagnostic: BN6PR11MB1796:
x-microsoft-antispam-prvs: <BN6PR11MB179649BDE651FBB4400D8769F0900@BN6PR11MB1796.namprd11.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(386003)(316002)(81156014)(2501003)(72206003)(81166006)(4744005)(486006)(14454004)(476003)(110136005)(1076003)(8936002)(6116002)(4326008)(11346002)(50226002)(52116002)(6506007)(2616005)(36756003)(3846002)(68736007)(6486002)(6436002)(53936002)(8676002)(54906003)(66066001)(6512007)(478600001)(99286004)(186003)(71200400001)(97736004)(86362001)(2906002)(256004)(71190400001)(305945005)(446003)(6636002)(102836004)(105586002)(25786009)(7736002)(26005)(106356001)(107886003)(76176011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1796;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9h5KM1DZiUGJ2ISVGtqq0e1p9e76+DLf6HBr2/dJQpcVqoyeU3y/AQrCoqyQWLbyLW2nmhLU1gEnFVq8dr+GHKRbol2J3f4/CTMLUW5Rea7jB7H6wombZXdJ5muVm4tFy0TO7g1xAjSc4taHFATZ/f78EwS5kV7QEw+815vpytbNA4qaVxxHTvOUhlQk2aU281T4TpiLbMHKTA9qzhOOii0zpC8NZt/ICmU2auJLkubf1dRvC8s3RTCB4TA6IrDutmleZe8uzN2Aq4DHVDQltQeMGFoyreJecla1A36AM1zV7PUEEcF02G3SdfQNHDxD0YYied/Z0FlM1XCvXzTTse0BIglYWCdp7gc7l2syX2lWXKUEoxKOApyYw58i0gKglMvgGUeEU0762kVLtXMS0cusbJxQ1J92pupW12xdLM8=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a805563f-899b-4bf9-4e7f-08d686c4cac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 15:08:27.6563 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1796
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_070835_017464_575C0DB6 
X-CRM114-Status: UNSURE (   8.44  )
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
Cc: Tudor.Ambarus@microchip.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Set the QSPI controller in Serial Memory Mode at init and not
at each exec_op() call.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index ddc712410812..f79b17792a11 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -238,8 +238,6 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	icr = QSPI_ICR_INST(op->cmd.opcode);
 	ifr = QSPI_IFR_INSTEN;
 
-	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
-
 	mode = find_mode(op);
 	if (mode < 0)
 		return -ENOTSUPP;
@@ -381,6 +379,9 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
 	/* Reset the QSPI controller */
 	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
 
+	/* Set the QSPI controller in Serial Memory Mode */
+	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+
 	/* Enable the QSPI controller */
 	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
 
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
