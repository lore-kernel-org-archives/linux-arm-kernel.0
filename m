Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD1DC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:41:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2ED2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ug8Q1Yyk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tBwy2PKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2ED2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tytYLishdOUMJw21EFSicJg6eQ6hHQnQyIymEolJZKY=; b=Ug8Q1YykoNENNk
	bXDI4rZUKsP2sKfFt7TuAf2DNNfmQM1NoPyX4bT8VASk9QFuXOnI2mh/wM6VgG702CCAMm8dWmO6q
	qzWV0xWfW5PX5HE4NnT57PVz9+Ya8SqJIGpS9k+NjRDhmVq/R1vSx5xMex4h5tbx5OBHTh3GYkwq/
	OKLaVuhUmA9dJGKOSLBJP6H5vMx4jBO071dmm1PhTPdHQK7fEzxuYAcu8igyWbrY7ACFTilnT+vwn
	V/soSFUxMbA7HxuveW/rhXNSKw1Oj0/ufWqytICrHbbrYZUl4lqF5D079P11IkyruFkoVqw0A1b5L
	i3siBzn6egWA9NDVx5Lg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTjml-0007BO-5r; Mon, 03 Dec 2018 08:40:59 +0000
Received: from mail-eopbgr140043.outbound.protection.outlook.com
 ([40.107.14.43] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTjla-0004hk-QC; Mon, 03 Dec 2018 08:39:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVb917QJ421eqGqalMUSYshHGI+tMy1pGRkQ0aFbBQA=;
 b=tBwy2PKW2SdXoN12djdMAbF0OLkD2o9advJK3PPPa5RhShUzIvEfVNo65TOGkK+x9mssANQF5eJ+geDfPlO7iJt13eXkb69I+HnMnNIlTMysBThAj53gowQhGuryw1SrHJimgn9OkbNUcXv4DJzb2jtMktQfCFKuZ94396GqNPM=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB1470.eurprd04.prod.outlook.com (10.163.166.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Mon, 3 Dec 2018 08:39:31 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 08:39:31 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v5 5/7] mtd: m25p80: add support of octal mode I/O transfer
Thread-Topic: [PATCH v5 5/7] mtd: m25p80: add support of octal mode I/O
 transfer
Thread-Index: AQHUiuO17akHSyxjLkG7oUtpm1hInw==
Date: Mon, 3 Dec 2018 08:39:31 +0000
Message-ID: <1543826226-30898-6-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0143.apcprd04.prod.outlook.com
 (2603:1096:3:16::27) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB1470;
 6:/0VRiW/IjdpPKECuDYGm4K8s0vRstHfK4l7LMCgcqGqp1xxRQcspjxfAwoSw5fuPAzrs2++e7pHSoItmYIjLMgoYDLCgbpx1IO/dlGs38hJEWSyoyx/VL+m744g9BZ+TIaEIcRupGlfmMzt8UsHjLiha7D682ydVj7N+VStzwYQdWfTvEQa9uoRI7JuBijMfb+IF/Tt6BFXAfM8eopc3ELwrL6dNdFp9sg1l+zCqMxVZLrwimOUuIUnIYoON8HhBScktFU1ePIf4SDAKs9Cj356JhDKuDjd/8FOANB2MwlobbSrhuWDCs78JORnFaKWM0pqELuWkXIHsM5rvwMgPQxPLM047k3Rs3ygWGwgWKetIQ+uDcc+5a5S/2fBucWWUutVeDU2/Xku9RVAnBRFsIfyjFYhPqZiqi3mydXQ8PZx8t7+XW0D3+sTcRwmn/DpGdPTZT0qp1I7uzpOEbuKXeQ==;
 5:DaYsxwCmqwXymW903NyVmnEMljcHOYCT2hFdx5UUtqWYJU8poh+va4aP25PpjxA0ua5OWwpvm3Dfrnn9wo8PpMP3HHYB3Z2hLxK4eCH8+f4p2ngFtkC1pz7ow10Mhw5F6ejrnqBEH1T0YmGUV9Qg0YrAHE3EVrVKXfOlD8RgYeE=;
 7:OxVGbq7a38koMzjKtPIKCsb0hOY2DKjN7d6iJGLTVY9K+dJoGSmL9nJigwCMj+P7+gR3Y6w7TnKwSna2wJM1Xax1QqACSepheSvghX/zTiIpf1qsCZ2AYotD06SYWCh6pkBW1RQE5cwG2fd6YgLMZg==
x-ms-office365-filtering-correlation-id: aab57540-8599-4c36-68c8-08d658fad7dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB1470; 
x-ms-traffictypediagnostic: VI1PR04MB1470:
x-microsoft-antispam-prvs: <VI1PR04MB14701FDE771A9A7CB1A3342A99AE0@VI1PR04MB1470.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231455)(999002)(944501493)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB1470; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB1470; 
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(346002)(376002)(39860400002)(366004)(396003)(136003)(189003)(199004)(55236004)(2501003)(105586002)(76176011)(5660300001)(7736002)(54906003)(14454004)(6116002)(110136005)(386003)(6506007)(99286004)(2906002)(52116002)(7416002)(316002)(3846002)(305945005)(68736007)(25786009)(2201001)(478600001)(97736004)(86362001)(14444005)(256004)(36756003)(66066001)(81156014)(81166006)(8676002)(78486014)(8936002)(6512007)(53936002)(6486002)(6436002)(476003)(446003)(106356001)(486006)(2616005)(186003)(11346002)(71200400001)(26005)(102836004)(4326008)(71190400001)(39060400002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB1470;
 H:VI1PR04MB5726.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VLzuT13e0+XwLU+f1EJPbltVLxKBrOOLQakWZC2a6t32LeWhWsBOaln0yXY6BBewVsvu0l7xJ0Ae3hIfoJvW2cOBY9ep07vF6meC6sVC+yJZ+xhmhXKKHLQ1bd2R9IW5i4wRrCsJ05RLL+BtSa9igHckS7VPgQXZac8cES7PxwFJ87d8MWBMJpizGYfHNuwAsE043FDC4ltIAI5BQXxHoj3qIFuewX1Cl31wP6QORa9x3vi2h0EitsRxy2JWegDh0pofbFO0v0kJ5hoyEh0zoZLJ0J5rDpMaFcY9o52Onr/bcMWvJbp+jnDcKe8fJOCRScBkcZhpaEn5YIGC+n6NyJeWcydx1IlVP5z9Lp/RWzc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab57540-8599-4c36-68c8-08d658fad7dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 08:39:31.0931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1470
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_003947_543150_9CFFC57F 
X-CRM114-Status: GOOD (  13.45  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "robh@kernel.org" <robh@kernel.org>,
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add support for octal mode I/O data transfer based on the controller (spi)
mode.
Assign hw-capability mask bits for octal transfer.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v5:
- Modified string 'octo' with 'octal'.
Changes for v4:
- None
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- Incorporated review comments of Boris.

 drivers/mtd/devices/m25p80.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index c4a1d04..651bab6 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -195,7 +195,14 @@ static int m25p_probe(struct spi_mem *spimem)
 	spi_mem_set_drvdata(spimem, flash);
 	flash->spimem = spimem;
 
-	if (spi->mode & SPI_RX_QUAD) {
+	if (spi->mode & SPI_RX_OCTAL) {
+		hwcaps.mask |= SNOR_HWCAPS_READ_1_1_8;
+
+		if (spi->mode & SPI_TX_OCTAL)
+			hwcaps.mask |= (SNOR_HWCAPS_READ_1_8_8 |
+					SNOR_HWCAPS_PP_1_1_8 |
+					SNOR_HWCAPS_PP_1_8_8);
+	} else if (spi->mode & SPI_RX_QUAD) {
 		hwcaps.mask |= SNOR_HWCAPS_READ_1_1_4;
 
 		if (spi->mode & SPI_TX_QUAD)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
