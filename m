Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDAAC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:34:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58D720821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UJbkgs7z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="yUb+q7NM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58D720821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ogMWKSbQzs4GHWNUU4N8tkW2x25sLdc3DpPQ2/q63j4=; b=UJbkgs7zRnbQRt
	ZuEIkllX0gT/m6s1eqVNKEPrxLUxWisXnoaObVunwcOO4e/z9pQo/FmZ0LcCtVUvn2qdEUhiQ6vrg
	bYf+0/406lR4/51m4hPB6r+ra8fjxSUWIh8v3sQH+wa80bZssg/uBxChWINRBHTA5ZM+WNOtH0Rf0
	2e5BXDnoEoXZnoTGwdBzEGI/G7PPXoW7tzUrn+O4KAhWb8vk1DpJcYyX8/RwVI7005azQIPu3rT5b
	Fi1vJnoZoae5ladvkyZxmg6d59ZaUqL2iyRbJEWCqJFzbpu4y1PE/Pbxnspf7i/HGX+oPA38GU8Zu
	hKvxS+/7+xbGctUmSebA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr4cM-0003yh-26; Tue, 05 Feb 2019 17:34:42 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr4b0-0002bj-AG; Tue, 05 Feb 2019 17:33:22 +0000
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; d="scan'208";a="23466286"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 05 Feb 2019 10:33:17 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 5 Feb 2019 10:33:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6c9NZf9oXUsk3YKA+7J+ISU54YoNkI5ixnDQIFx6pjI=;
 b=yUb+q7NMLH6jctz1r8k4EfPu1Et2/UthVw4MEWGMljb3ij+xMrmGFmq4W4lRaAQO1kaVHVKtZj13WyUr8lcV4Ae1tvJ0VhNh1Cldw04PgGLcv0VZ/3c0XLSHdEWJreaJwiepg2kgdoE63FSkIihWNRydiubn0yJywiqn5CxX0Ek=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1539.namprd11.prod.outlook.com (10.172.23.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Tue, 5 Feb 2019 17:33:14 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 17:33:14 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Subject: [PATCH v6 04/13] spi: atmel-quadspi: fix naming scheme
Thread-Topic: [PATCH v6 04/13] spi: atmel-quadspi: fix naming scheme
Thread-Index: AQHUvXjfj1K/ID5q10WA4l8z4XzioQ==
Date: Tue, 5 Feb 2019 17:33:14 +0000
Message-ID: <20190205173254.16388-5-tudor.ambarus@microchip.com>
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
 6:IFfcwbojajrnax+l4yy9PsFecnUxveVSezBRyXeJGqnijKlZhvBIzztob795+soqA1TV94rNCgsoLS2r9H77LNsapFJ03r1KzR2vmCmv0nQ+Ko+2tWNwF+obNLwJdXVCraciUIUZUDU33QTJ/luuAIdWJvCGQx/i0CNSwSEhjtzAvQXgWKw+D9NetMWSFbFTX99bCloJGNF2EarG982IHzWGzQIDvZUlI0fV8308K6jA+wVmMsOsQddtpYNJQcewXJ/HMGC5Hj3Af0vipE0PahPVyVGDHjEAUclJHAF5ICGcNVdsAnermHFohiVx3DYf4E3CUT+/RKqRXWEVHLTc78XCNFIfxgOt3fHtXni5TTLaIH6z0G8FOCcRtekW76VAutN1+UgxsVBrNiGUGU8qydd4pj4lGS54wa+UH4RZrHd+lClZADt5rMBfCsmaQaOa6jCXUoJ/OL9p7Yw77aCalA==;
 5:LWcODmq0zNe1x/o8DbVWawQWw+1+9gs5UJpxX1gcbzRfFyJ/s6yFUY7+3fRXLv5daL/qgQXsKxYjtaQiBeMC1neJdgMJxB6nSyyfBpPSSUz+2K3ETsKwnaFnWktHW0A2+rx2AOb5xUOy/Pu8M3a33bcOaHr/hmDtp1i+33f9S22A71wsc/6GcmXNGa74fuQ/ocbNdzc0553/eg5sxR+JGQ==;
 7:DvvgsczzC7Uxhd9myQtTN+WIEMX/Pqicl1V+/oiftAPUqk2tCh9PrTN+jQP2LCyQ6AphaxJR+mlsDzerOqYAZBL/N0Q3So+tn+uJB6NN/uu7E9Gxvmn/FP1/nKtaHUNaZoco0TinXsr675Qddo4wJg==
x-ms-office365-filtering-correlation-id: 09279811-169d-46cb-921a-08d68b9001c3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1539; 
x-ms-traffictypediagnostic: BN6PR11MB1539:
x-microsoft-antispam-prvs: <BN6PR11MB15390B61A38AF2CF35AE1F12F06E0@BN6PR11MB1539.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(386003)(6506007)(7736002)(4326008)(71200400001)(71190400001)(99286004)(72206003)(2906002)(110136005)(14454004)(316002)(305945005)(76176011)(8936002)(8676002)(52116002)(7416002)(3846002)(478600001)(6116002)(54906003)(2501003)(50226002)(1076003)(36756003)(106356001)(53936002)(105586002)(25786009)(81156014)(6486002)(68736007)(81166006)(256004)(86362001)(102836004)(26005)(486006)(6512007)(11346002)(14444005)(66066001)(476003)(97736004)(107886003)(6436002)(186003)(2616005)(446003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1539;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BFhOe89zNmZG3IKX7lA+Q9XueooK3U15jDv9b6nRzAr02Ba12YdlAA82qK1zSyZI/JPZx452BrkNci+Ty/bKu/fNiaBoBnvNK6OQ2+TcyuR+eXj5JMeQv77G2GZaKDSPh+b1KqSmvsV6b3ghVF6TFTbmgp1GbwvuC4MXD2wmqtntS7CvL++gyCZvxZrE7/8xOTIHTfR/K2o2IZ9iU+yccI7sX+BFScZ+2vWeB3jBDizt9SeSsIw819VeuVxqe4ZHbxntTK5tyQLaGoVhaCCzsNlL26eRlZsyloqmKRr18AtWv2oX53kDtAks/0D1Keh8MronbDspUpFzG4WCLjvJDbn+aS5KJYNIzc/nF1UbjFmXsWGyY+8JimXMiwAaHnPSnJKv6VROveY8Xv28dyeATMYPR6MhrWKSuZSsmClhy5Y=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 09279811-169d-46cb-921a-08d68b9001c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 17:33:11.7168 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1539
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_093319_069321_8D6D42D6 
X-CRM114-Status: UNSURE (   9.07  )
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

Let general names to core drivers.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v6: no change
v5: no change
v4: collect R-b
v3: no change
v2: update after the removing of iomem access wrappers

 drivers/spi/atmel-quadspi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index c745e75b755e..be1d1ba7898c 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -158,14 +158,14 @@ struct atmel_qspi {
 	struct completion	cmd_completion;
 };
 
-struct qspi_mode {
+struct atmel_qspi_mode {
 	u8 cmd_buswidth;
 	u8 addr_buswidth;
 	u8 data_buswidth;
 	u32 config;
 };
 
-static const struct qspi_mode sama5d2_qspi_modes[] = {
+static const struct atmel_qspi_mode sama5d2_qspi_modes[] = {
 	{ 1, 1, 1, QSPI_IFR_WIDTH_SINGLE_BIT_SPI },
 	{ 1, 1, 2, QSPI_IFR_WIDTH_DUAL_OUTPUT },
 	{ 1, 1, 4, QSPI_IFR_WIDTH_QUAD_OUTPUT },
@@ -175,8 +175,8 @@ static const struct qspi_mode sama5d2_qspi_modes[] = {
 	{ 4, 4, 4, QSPI_IFR_WIDTH_QUAD_CMD },
 };
 
-static inline bool is_compatible(const struct spi_mem_op *op,
-				 const struct qspi_mode *mode)
+static inline bool atmel_qspi_is_compatible(const struct spi_mem_op *op,
+					    const struct atmel_qspi_mode *mode)
 {
 	if (op->cmd.buswidth != mode->cmd_buswidth)
 		return false;
@@ -190,12 +190,12 @@ static inline bool is_compatible(const struct spi_mem_op *op,
 	return true;
 }
 
-static int find_mode(const struct spi_mem_op *op)
+static int atmel_qspi_find_mode(const struct spi_mem_op *op)
 {
 	u32 i;
 
 	for (i = 0; i < ARRAY_SIZE(sama5d2_qspi_modes); i++)
-		if (is_compatible(op, &sama5d2_qspi_modes[i]))
+		if (atmel_qspi_is_compatible(op, &sama5d2_qspi_modes[i]))
 			return i;
 
 	return -1;
@@ -204,7 +204,7 @@ static int find_mode(const struct spi_mem_op *op)
 static bool atmel_qspi_supports_op(struct spi_mem *mem,
 				   const struct spi_mem_op *op)
 {
-	if (find_mode(op) < 0)
+	if (atmel_qspi_find_mode(op) < 0)
 		return false;
 
 	/* special case not supported by hardware */
@@ -236,7 +236,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		aq->mr = QSPI_MR_SMM;
 	}
 
-	mode = find_mode(op);
+	mode = atmel_qspi_find_mode(op);
 	if (mode < 0)
 		return -ENOTSUPP;
 
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
