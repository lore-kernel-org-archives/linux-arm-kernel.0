Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68100C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:11:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38CFA207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LlDbO7hB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fcfQ03kP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="02HQzjLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CFA207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1mXj57sps7FqBE5/7qE/Fty3Ha/Izcu7ynKF5cjj1Mk=; b=LlDbO7hBPF6VK4
	y1haW/gWMerW/Nh0AC4MhAX5AmcVSrZzzDkc9lxZ9dVUXqYHmAIiBne88tBTgaOKaU6PM2CvY3/DV
	yjAjoZkqlMVxsZBinI1rhJbUSA8v/W2XRMhS5bklVRqb5v50QH/mywgUYq4zy+aDoa10F/6z5O80U
	Icb8y2ye0fQHOR17HfHH66VJBhUMaAwvlhgtP85886e5GwY9AXuM/D1zCx+9mJXjwNPs7zv7mkdEe
	/v59foVWNjIzUVgBkDSfVuGZNYKgdRb02jMO1EkiLIjKUPlnYTRjWhsRgL2Wo1reDHNhgSqEnzdtV
	eY8Esrf9BICoJkpBn5Jw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqcA4-0002yN-2C; Mon, 04 Feb 2019 11:11:36 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqc9E-0001nl-0o; Mon, 04 Feb 2019 11:10:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+GMoqgJFQa/jKumXZfHSYRYKKo6zPy1dMCHs1UqgtXo=; b=fcfQ03kPPhw3+kMLv5Q1uUbFgN
 Xa0gM2A3h+5M5g/5uQpKZ2cLf0pgAzXSDkOrDGv+tKNi6gKtbxFUC4nrm4FLDMRqOqUgQrfxNUm0J
 +D345zI/WN+dyZ4N3GNfKn9MpETk10EPGiZTurgDD7WKjLmbaa1Ud8gtH/kP7HkARu/D1JxcqWHpG
 vbKqSXcNgkE35NiqtzYPhuuwxVufxGX8HJi84dOFHdfAJ5pdeAZlevPszFOUqoGapkpBPwLSjaJvl
 JNNaWU+zby42mRbJH/EAIxuMYfFYIN47UalQKTafz23vWU5lXiLLvKgG0l1YVqJ5izWGDnBxHWJfF
 PRoFuQAQ==;
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqbCT-00083q-Qn; Mon, 04 Feb 2019 10:10:02 +0000
X-IronPort-AV: E=Sophos;i="5.56,559,1539673200"; d="scan'208";a="23387576"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 04 Feb 2019 03:09:55 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 4 Feb 2019 03:09:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GMoqgJFQa/jKumXZfHSYRYKKo6zPy1dMCHs1UqgtXo=;
 b=02HQzjLQ4T8bIKyOqaBtXKnRU7qM8rMJ8camAH/MOC44le0og3apfCCpHHr+mBViZ57ZAwVI1aqa06+1uc44FEPGn1yXjmP9FXY8QRcl2gBY8EC8ilj4qgLb/SiREZAZQD9wfRbByC/1ars0+tPS5dx3HL6pXVjWk1BGua0LmOs=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1508.namprd11.prod.outlook.com (10.172.21.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 10:09:53 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 10:09:53 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Subject: [PATCH v4 08/13] spi: atmel-quadspi: rework transfer macros
Thread-Topic: [PATCH v4 08/13] spi: atmel-quadspi: rework transfer macros
Thread-Index: AQHUvHHFjtXlWvSHX0eyX0SBDZrtmg==
Date: Mon, 4 Feb 2019 10:09:53 +0000
Message-ID: <20190204100910.26701-9-tudor.ambarus@microchip.com>
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
 6:Y+jQ0nvrJ/KRZS1B16tmmaWprtV2zg6wkxonvTMF0uTiE0HMjsLCgMninXFeHrFvVeUaB+4iX2ih7/aI2f/3JJmx6cD86CLz+VG3j8yqGFIWbFnrh9QNiGNfariUEYlPexVrT78zDbMhOkgvRjUlPaSB8ewpOEddAOqUH3ZkMHeeKGPEyUO+gu6e9ydNTNVuoIGxjlrP0WFMIC4ddXLIMiD4Y51cuKNWRm0y7ZJezxNO4I/TRUY/IsHhul+PKkobtZEke2cDf7+4bvF82EUSuT/m+deoXtZmlx6Wl6VcDl322/xu6Z+ZzYKDnsWnbGIRWx6FZn1F+kaPadzReLjIWgBFXwFbJ3wkkENLwWmYFLNOzB18lqelL/+JA56piNmt5DLmEUlXFdqnK9aed7IR2u2spHwLa5y1UHYUaigcxnsg84Q/J7xMQ4Qw/M7iT8i2AOxpVh5JSdAyJW4w/pL2AQ==;
 5:rfJhucNzX7Gw40YkLCgSdbnugU4aXk0uH9p2myTOfuuGAPbpZjX6Oe6RlLNkKtxOWGatSSrd+wy5s9boWYatajRvhjQapItPO5U7RhynOUqvtC9jcUZ5b9U+WG4sHYEwlSDBh2zq4F67WaMdUPQBMvjpkY6HusxxtSvMRXlyPRfdsDlP9WI0G4NNQniVsITlzg0Lmj3Ent3Yv9xfc2KXFA==;
 7:2gE9Dq4AOY9UQBSf4ixIQSjbA5/hiA+lI8o1TFdhpAgKqH9ZfFlGuVUtx3hZGF7kCSM858Kxxb/znNJ0Sv2TScKNFuhM9fvp6BkxS7oaY0issSBBvuWCFDoose/gguL4/l5f3CXba/1sW97R60QIOA==
x-ms-office365-filtering-correlation-id: 7606e48c-1a90-4e6f-5a82-08d68a88e80a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1508; 
x-ms-traffictypediagnostic: BN6PR11MB1508:
x-microsoft-antispam-prvs: <BN6PR11MB150879FDCC0205700F5A4D2AF06D0@BN6PR11MB1508.namprd11.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(6486002)(11346002)(446003)(2616005)(486006)(106356001)(99286004)(6436002)(4326008)(105586002)(478600001)(476003)(76176011)(186003)(53936002)(305945005)(3846002)(6116002)(7736002)(81156014)(102836004)(26005)(81166006)(6512007)(107886003)(8676002)(25786009)(68736007)(39060400002)(52116002)(50226002)(110136005)(8936002)(2906002)(386003)(54906003)(6506007)(86362001)(1076003)(36756003)(71190400001)(71200400001)(316002)(97736004)(7416002)(14454004)(256004)(2501003)(14444005)(72206003)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1508;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wGHtUvbULyOCLFoRyl8Tbf/V8TZ8MVw4SGsF71yVA3lj2f/uFn0FAfGSsVAe2XinRwzj0v7MzK3CHf/qrfzN8cI/bGItfHqX9kM5diEqNd2N/6Dde1dsNqBYHG3jz1iuDwRbbi06mR4pNe4KgP+1g5TnVmjVBSyjIwPw7NNSNXP6SJDVHjVgTsp+SQ9TLLMkG3Wa5J/rLeivg7nZI+EjAloZ5YPaoySO8z205l+A5zdSjV3ViB0ITe8tDayTb/kSVLWDxW4uR5qlXsuawNjRMvH/06Efjj9SzftSs2fuiqXKw5qTytFuMipqakuwjXpKA11w/5Zas+Ls9oX1cFjEK8i5vAa6K6ZBDZNHtLS7G2FP4e1JdkWvNs46Q2QKrDJZjJb5MdK6Oqctjjq/WO23EDleiRDn2p37JTTAeqRGPyM=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7606e48c-1a90-4e6f-5a82-08d68a88e80a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 10:09:51.0543 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1508
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_051002_046566_0D8F4EA1 
X-CRM114-Status: UNSURE (   7.89  )
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

Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
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
