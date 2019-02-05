Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB9EC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:38:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCC48217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uHUG6hcm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="S/06xTI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC48217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cLGUgVXTa3H7UJZX2l2OQ7o6tEA08k3XTv+1jc95Qpc=; b=uHUG6hcmrXa8pc
	b9lp8mk1IRelJ+EZZITWwJaiPh9+RTty+BQnd4IX5oUwlCDMHx3HojOu7q+EfoJC3DFTRJ2LrIdMa
	d3A+Cvp+TvpIvkHEifcAOhvqYbHmR3qVnidonA3Z54XLh9XcIfxcJbEyRJRvlisfG1nLavzXGYmWA
	NofglE0cKgkXoqvPHmAZ0wJIvpHMn3hy6UZdPOA/xM273ZlnuoQXeC8YwLGO9Q3rcfT245za1EycK
	Ffln1WkrHzoQ889fQUvIwYO8CA4W/Rdbm0cIF86nh/+nPHbJft7kOHCQFo99LsZQ6k/16As9YOxqZ
	FT0lKXxQVgf46Mo2HGmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr4fb-0008Tm-Ml; Tue, 05 Feb 2019 17:38:03 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr4bC-0002pz-Av; Tue, 05 Feb 2019 17:33:46 +0000
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; d="scan'208";a="26340137"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 05 Feb 2019 10:33:28 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Feb 2019 10:33:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwVggtJ1QTryUz/2CC34Onhb9QKLVzjHCqUtO1f+FRo=;
 b=S/06xTI4JWzKRjpc0qpGyMh/KPp5+vH7RJlPnisGhQ6kr/rSDkY5PBOs9zsfWvDG8AVLC/EGEfjFUArl8gFElE1P8l4exV53YABNCRTi83d8Vo4CRMJ1Mz1gXFadqj+y2GzUkP7BB5TynWD/9r9Kc6MlnQQtuZFUQv4fLUB9nLQ=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1539.namprd11.prod.outlook.com (10.172.23.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Tue, 5 Feb 2019 17:33:25 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 17:33:25 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Subject: [PATCH v6 08/13] spi: atmel-quadspi: rework transfer macros
Thread-Topic: [PATCH v6 08/13] spi: atmel-quadspi: rework transfer macros
Thread-Index: AQHUvXjlLDX82obY1kidqcTofvU6Mw==
Date: Tue, 5 Feb 2019 17:33:25 +0000
Message-ID: <20190205173254.16388-9-tudor.ambarus@microchip.com>
References: <20190205173254.16388-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190205173254.16388-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0128.eurprd07.prod.outlook.com
 (2603:10a6:802:16::15) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1539;
 6:nBfv3N2ZBcHqmLbWBjWOjXqLfFfyPudAvbI+6TwTjW4J3ht31YgTk+YbruNy3xGUWChGMKSSOo5rZeJ4tJfCWPmCkcfxc/L2NBVs7H/iFseBWaP6Ov3fLuiwMNBK6gKUj8Vth2t3CzivEfWUxq2DYpBoDncsnEehRNVZzybCfTgbSib9hlSD+UJM/419EmF7zJ957f+uAbS7OVxmujsUbGstMKAeXo9yq3IKvpNyZa1xLznVZ/eQn+X6jYuQJX4pqPWtXZceq6yZy8Y81WMeip55Lqwy0DhsIB/7QpvD+NUjkwl/4Hm1ViEbhrtWIgo3E+Om3kkPWRln/UkiosZH8ri/iOkCI72ceufkR3aI4iIygo7s3qwzZ/f5PzkM6EakkaNl60vnvpf1cPTfSWohgbf0iAYxPdTl4emfEKowWuxcE2irR5UmFlS6HYdtJZ6BLIUkJ8oJNijSaQAPq7qjHQ==;
 5:Fj6MKvHvO6obFWYka5cceQtzaVJPrg4m1/3XJk27fTzlaeC/TAigRdQJom29wDx8OWh+fQP6xJtZd5/5Y5s6iK83ZTCwpInTZw8KROD2DVQT+6wGN6vw6h8cNKeoSbHQ4rIA87aOCnhvc27diXgNkH3IjeD6kGCigNZk3CCmEzBczvzzE/NbSh7DdjFL0jjTV5jHT5S/y8oere+FE7Hc7A==;
 7:LrpCKyYk53xYolTQfdYccIBRB2P4s7cWPTku7kNDly6uryQAylC2kEjvzNmEIir17iSr2iGSLSsSlG6QLRUSpwbiCHI1tfbaFxx8QJquV88Uj5R0SGSgfnfwy5jDa/AJktLB1tRrnxreub3S60YRmg==
x-ms-office365-filtering-correlation-id: ddd44fa2-acdf-42cd-79a1-08d68b90084c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1539; 
x-ms-traffictypediagnostic: BN6PR11MB1539:
x-microsoft-antispam-prvs: <BN6PR11MB15394CE7ABA614D910008D39F06E0@BN6PR11MB1539.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(386003)(6506007)(7736002)(4326008)(71200400001)(71190400001)(99286004)(72206003)(2906002)(110136005)(14454004)(316002)(305945005)(76176011)(8936002)(8676002)(52116002)(7416002)(3846002)(478600001)(6116002)(54906003)(2501003)(50226002)(1076003)(36756003)(106356001)(53936002)(105586002)(25786009)(81156014)(6486002)(68736007)(81166006)(256004)(86362001)(102836004)(26005)(486006)(6512007)(11346002)(14444005)(66066001)(476003)(97736004)(107886003)(6436002)(186003)(2616005)(446003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1539;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TcL5AfFhC54on1wSmgMKK3EVF2XQqWe9w/c34cwH9YQcoCcxB4CcYmTnnRofYkM4x7exstJpXqd4NoJ0MW+7umnj5UQfsy1riidWhas4Ln/v3ZpWKZzsON2WIfMXIFfmSrvK3GmH0W/FlKi4xnYG0T/XLoSMAKLkwnTUdQHKeo8ZGDmmsAa34V4FigOYwYFAg215D27of/hjIKF8nwSswbUrYZeAyGiE9L5YVr9BEWntj1wVwiImZICp7FIH8gA5JEOuVO+lyMI2Xvn17G4ndiJtYdXDAsuMU94jWkOBKuqt/wERnAHdwmVmUWtOO2R9/OFu0cOMnMgkEsO3HrE/gCl4YsuhhBBDyDqRAEoRh3LYjIfBICV2Q3OaqQZf96DyBuq7JSh/tS8nhwv1wGNiL6ubEX3IXgB74ocSc6vsxQw=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd44fa2-acdf-42cd-79a1-08d68b90084c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 17:33:22.8345 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1539
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_093331_254369_74C780AA 
X-CRM114-Status: UNSURE (   6.95  )
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

Split the TFRTYP_TRSFR_ bitfields in 2: one bit encoding the
mem/reg transfer type and one bit encoding the direction of
the transfer (read/write).

Remove NOP when setting read transfer type. Remove useless
setting of write transfer type when
op->data.dir == SPI_MEM_DATA_IN && !op->data.nbytes.

QSPI_IFR_TFRTYP_TRSFR_WRITE is specific just to sama5d2 qspi,
rename it to QSPI_IFR_SAMA5D2_WRITE_TRSFR.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v6: no change
v5: collect R-b
v4: introduce QSPI_IFR_TFRTYP_MEM, reword commit
v3: new patch

 drivers/spi/atmel-quadspi.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index ce4f8a648f45..19a3980775ad 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -113,11 +113,8 @@
 #define QSPI_IFR_OPTL_4BIT              (2 << 8)
 #define QSPI_IFR_OPTL_8BIT              (3 << 8)
 #define QSPI_IFR_ADDRL                  BIT(10)
-#define QSPI_IFR_TFRTYP_MASK            GENMASK(13, 12)
-#define QSPI_IFR_TFRTYP_TRSFR_READ      (0 << 12)
-#define QSPI_IFR_TFRTYP_TRSFR_READ_MEM  (1 << 12)
-#define QSPI_IFR_TFRTYP_TRSFR_WRITE     (2 << 12)
-#define QSPI_IFR_TFRTYP_TRSFR_WRITE_MEM (3 << 13)
+#define QSPI_IFR_TFRTYP_MEM		BIT(12)
+#define QSPI_IFR_SAMA5D2_WRITE_TRSFR	BIT(13)
 #define QSPI_IFR_CRM                    BIT(14)
 #define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
 #define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK)
@@ -275,10 +272,8 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (op->data.nbytes)
 		ifr |= QSPI_IFR_DATAEN;
 
-	if (op->data.dir == SPI_MEM_DATA_IN && op->data.nbytes)
-		ifr |= QSPI_IFR_TFRTYP_TRSFR_READ;
-	else
-		ifr |= QSPI_IFR_TFRTYP_TRSFR_WRITE;
+	if (op->data.dir == SPI_MEM_DATA_OUT)
+		ifr |= QSPI_IFR_SAMA5D2_WRITE_TRSFR;
 
 	/* Clear pending interrupts */
 	(void)readl_relaxed(aq->regs + QSPI_SR);
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
