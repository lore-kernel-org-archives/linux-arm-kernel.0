Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC827C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:11:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7415D21479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mmv9+vEq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="d9VRCrBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7415D21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UDAGwlM6IbcO9bi6EXDMTgkHL++4CzYzllZMWaO1lrg=; b=Mmv9+vEqL2P5ux
	yo9xavrPqcmaG9gekM9aIiA5+MllB0aRGoqQyFisXvmz+wUVMNGfsEdkAspaDX3oNkAivPmkLayAo
	wxiFzVOaE5+jCCn0VJBzxUX2elb425JfKOlxlUCzD5PG8g5iBEII2QpKiAWSpXcbDrJbQd2X1meBL
	eJrKkVR+zu3rdaM54f45CRLQoa6BzM5sUpISVP7qA7BymMqWrwsTBE/PrrZ27jFTv6h++y3c+ZNzZ
	dbQT2x9C+WBtgFzhefkJdTonM9F60sb/bMVp/PknUx288vF2zkgCt+B24ZaaFMMsmgj8EEnEMsD2r
	cHp2+WKADtI7/rrZ7vlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpmeb-0005zI-5s; Sat, 02 Feb 2019 04:11:41 +0000
Received: from esa5.microchip.iphmx.com ([216.71.150.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpmae-0000f5-R6; Sat, 02 Feb 2019 04:07:45 +0000
X-IronPort-AV: E=Sophos;i="5.56,550,1539673200"; d="scan'208";a="24146378"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 01 Feb 2019 21:07:36 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Fri, 1 Feb 2019 21:07:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFRKwjffpX+Irk7YmX6PsJuVxXPeXhl0e0TFr/Y/OPE=;
 b=d9VRCrBr163Pes7WvdxoGxXYKQyguaEzCPexEBdQ40s7JNeZ/oYGl29PYf4rA47QAQM2k1NNIQaO0FHoNozgxJKE6b35Mjet68W4qwnL7QBwwSLpY6O3p8ZasotuttSXmgSGJZkolllFx9Q/tZWFMfSYCHQj9F5CbIdIEEF23cc=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1300.namprd11.prod.outlook.com (10.173.26.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 04:07:33 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 04:07:33 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Subject: [PATCH v3 08/13] spi: atmel-quadspi: drop unused and NOP transfer
 macros
Thread-Topic: [PATCH v3 08/13] spi: atmel-quadspi: drop unused and NOP
 transfer macros
Thread-Index: AQHUuqzSq101Byua1EaKHaxmofM37g==
Date: Sat, 2 Feb 2019 04:07:33 +0000
Message-ID: <20190202040653.1217-9-tudor.ambarus@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190202040653.1217-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0062.eurprd09.prod.outlook.com
 (2603:10a6:802:28::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [188.25.201.137]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1300;
 6:bd1rnVvbvJgTmsLgnIsRFstxnhI+pYIOEqkmWSv2DJ/Y7ZMqiw9DCvxl5mAhvgnscz0EOGAENWSUqhk+TWJiuReYqj6OuCkx2CTFp2eU0u4GNjAWEj6rUZQotXJwYGX69yZ68mRH9clgeHY4YXwpUsB7bFAdE9JZSXiLScoNlEomvYFBMTd+6SG1Goa8FK8hOoKR8pL+BXemWAJP3cJznu5cz6o0PERheYHj2lnZeB1g80g7vQpJqMFoFsqLvdWa6jOiO5ZzmE+n1btSKpVlDulIYKj+xu1tuAFkspyQRg/5pAHJ2ZQHLYhulpCTVlWFtm71OoSvOVzC6mGGxUjPkiGNa55HaMD1QDb3OUB8MjbdQV9ZQ99BQ7cU38hHVtjqYiYfqeB4SJUmslCrQYAKZT5hm5iKY5+KdFXpNp/gv+jhz3UiNcZiJQfoyZ86uwTqTdOQ12+8FJ5tLQ44j23Zrg==;
 5:cdW6tVoA4NrdLaOTHpXQZWc1DRLZ6dF+EhBKl4ZmW+QJ1655AkfVXRc3cdZtIa0UNMSgBIP8DgVUrZnWy/5PLSOxwRdAvYYmf4zZrP70hEwtPtkAsO9hOcnq0HGSsvMpjA5sLfypVGALbeIYerf1Gl8m1TOJZhW2dVohEZwL/QG+qsJZg1ROFVctO5xLoIE6GNWocNgE6hVNye0C12OW0w==;
 7:5VsxWZM9IfqomhBIXKzQJwQ3fkeVvCxlg3k/ajcPJLZcM1/lpjHlHnQxmLsZG1H996k+lctI2WQ84WQaMll2GA2l0S64ShcL2sGYpdEv3FudAHdvcoY1Uj+Qmm8gbMnxv4waW9NiuLw5mcMcNQZLQg==
x-ms-office365-filtering-correlation-id: 0459dabc-6e85-4e82-f777-08d688c3f50e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1300; 
x-ms-traffictypediagnostic: BN6PR11MB1300:
x-microsoft-antispam-prvs: <BN6PR11MB1300B1F4F1AC938228FE2802F0930@BN6PR11MB1300.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(14454004)(52116002)(50226002)(105586002)(6436002)(102836004)(72206003)(81156014)(81166006)(2906002)(26005)(7736002)(478600001)(3846002)(6116002)(53936002)(256004)(14444005)(106356001)(8936002)(68736007)(36756003)(97736004)(76176011)(107886003)(4326008)(39060400002)(2616005)(99286004)(476003)(446003)(86362001)(66066001)(71200400001)(11346002)(7416002)(71190400001)(6486002)(6512007)(316002)(110136005)(1076003)(305945005)(186003)(8676002)(2501003)(25786009)(486006)(54906003)(386003)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1300;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Jyu5Y6mdM1/mNlhJu2CMZgug/BV8wc5zG7zVEnzt1wYVHPK9kKBA3wOSaME+rezMBOp+qTzzb5cb64fOw9XEMwCCxZaG6Xq0d/oh7uTUgRHgOYNzsQb9HQ6OpxH0el+hhxKOjU1LhWtwuIL6E5GNuW/IlEKmDAQM+K/nbAUgNQkQgqt23V5maxBMM/GA4Z2iknjW5SdV5xoE//ZqbKd1RcLCGab7YB31HbnbiaCfy3meqE3I2kvCD+RWjtLXjmS+CJ21hQE+fADWht7UgcQvIuTSYeHE4m/0nfBjDPBufx6V5X0w8fnyhgydTZRSvAzod6ZnG7afON5XppZSy/ZRvT3pfN1u3lzXJVducHf+dfMIQWSbngkt1RRqO4FYcxN1wJ7VXC3zDMSOf+cie2hRzEvW/xnV7f9+AcuczeT9kB0=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0459dabc-6e85-4e82-f777-08d688c3f50e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 04:07:31.0595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1300
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_200738_042345_C9D28E45 
X-CRM114-Status: UNSURE (   8.74  )
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

Remove NOP when setting read transfer type. Remove useless
setting of write transfer type when
op->data.dir == SPI_MEM_DATA_IN && !op->data.nbytes.

QSPI_IFR_TFRTYP_TRSFR_WRITE is specific just to sama5d2 qspi,
rename it to QSPI_IFR_SAMA5D2_WRITE_TRSFR.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v3: new patch

 drivers/spi/atmel-quadspi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index d26d4cd0e36b..bfa5f5e92d96 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -113,11 +113,7 @@
 #define QSPI_IFR_OPTL_4BIT              (2 << 8)
 #define QSPI_IFR_OPTL_8BIT              (3 << 8)
 #define QSPI_IFR_ADDRL                  BIT(10)
-#define QSPI_IFR_TFRTYP_MASK            GENMASK(13, 12)
-#define QSPI_IFR_TFRTYP_TRSFR_READ      (0 << 12)
-#define QSPI_IFR_TFRTYP_TRSFR_READ_MEM  (1 << 12)
-#define QSPI_IFR_TFRTYP_TRSFR_WRITE     (2 << 12)
-#define QSPI_IFR_TFRTYP_TRSFR_WRITE_MEM (3 << 13)
+#define QSPI_IFR_SAMA5D2_WRITE_TRSFR	BIT(13)
 #define QSPI_IFR_CRM                    BIT(14)
 #define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
 #define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK)
@@ -273,10 +269,8 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (op->data.nbytes)
 		ifr |= QSPI_IFR_DATAEN;
 
-	if (op->data.dir == SPI_MEM_DATA_IN && op->data.nbytes)
-		ifr |= QSPI_IFR_TFRTYP_TRSFR_READ;
-	else
-		ifr |= QSPI_IFR_TFRTYP_TRSFR_WRITE;
+	if (op->data.dir == SPI_MEM_DATA_OUT)
+		ifr |= QSPI_IFR_SAMA5D2_WRITE_TRSFR;
 
 	/* Clear pending interrupts */
 	(void)readl_relaxed(base + QSPI_SR);
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
