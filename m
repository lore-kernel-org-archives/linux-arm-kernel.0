Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE41C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:09:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD93820870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i0HIbrod";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="UqAg2BlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD93820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YDkHOoQ623iwQu7kHN1v+qgQTMPW5GQiLazqDjZ08T8=; b=i0HIbrodBEycO9
	dY+uHpE3YFdTuoo+dZJEshx6SoCaB+gUDRzk2ZyJ5w95mI7bIL4nu+ER+KCfg/L9aWoNmEI8P8Q67
	sQ964YEEk0r1D14jSkxW7bAzSuaC+USvlu0GexmpopJmWKlQ9E1IYFMS1l/xUu/kJmckpoZ841Uld
	F/GVE2/TtnDW7IkYMqGP94vB59iL6vqufQ/OyBw9vusiNSJ5Pm18Tp//EaMXSsrK6jJ3zAgsZVRZs
	pvX4/UyyeZq2GxTMx5W9bQh2j+DoF4sgkuaqOWYNP1E/otzeMA5IgwhdDcDyYw8lGRWuVLPqCh0lv
	/+CGDAj/JIxwQIo9jotg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpmcY-0002P6-1a; Sat, 02 Feb 2019 04:09:34 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpmaZ-0000Pu-0z; Sat, 02 Feb 2019 04:07:35 +0000
X-IronPort-AV: E=Sophos;i="5.56,550,1539673200"; d="scan'208";a="26219230"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 01 Feb 2019 21:07:23 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 1 Feb 2019 21:07:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92djvqjrljFwDc2mR2BUsSiiFrnnqT+LjXGHj5YUxW8=;
 b=UqAg2BlImYB9hxEJwUVTAYbrgdyAnHLWul3SWIFtJxZ+NyM5+j7+1yQpzeSZC7xOH+dgIs2N3kwr7ErLomoNxUcb4uXgo5epT/EqXCsKAdlqR9CuPP1YvQ90pmE1MIoHmiXCoT6u3EwU9r8sSTlBhExEqwj8MWyK3oX5LxrY7is=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1300.namprd11.prod.outlook.com (10.173.26.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 04:07:22 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 04:07:22 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Subject: [PATCH v3 04/13] spi: atmel-quadspi: fix naming scheme
Thread-Topic: [PATCH v3 04/13] spi: atmel-quadspi: fix naming scheme
Thread-Index: AQHUuqzMH50aknQd3kGkG3IJcminQA==
Date: Sat, 2 Feb 2019 04:07:22 +0000
Message-ID: <20190202040653.1217-5-tudor.ambarus@microchip.com>
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
 6:/icsmTXY2EUWbJNUozqFfFpO0uofqF7SJnkivtnFJrOcBW4ponjnrUYzamo830aqhkHvuveJL6PVuWTTxIGFeQrpw546Pu4E4vT8U1OEDrgYWhM6gZ5E/PaFmxK87OvA7US/5G7mNgPHyRcoiVYHEimd8YmGHAUE+/WUk0lo235lJsSaRt9jdNoobarBNsgeFQPfV1E49jGCfBndwXMKPnXC7jlU5cHiMc0SCWu36PsF0JV8qE/Lx8m/SeNUtpcDURvvfVfXyvNjxvtW9I/UHHr5u1rm5wDrRJCfsnG0HuLAWIvSKXxWu63QCv6r/4qfOkfUnRLfdoRepYFjlJOVc46fiyyuba70ohlCXKjh9rq20x2m+bKivKThK8ih1DXzsgYyfueYhhtnSF1PPQEQmLvZS5o5Rw7ROjp0NNu1BefbY9x/s7W/hazvlhJmQMhDNPRxA7OBmCnfmoOv8sAuSw==;
 5:zTgf5tJ4RXuvletiqRVGMjtvBJptRsQWLTJlV5MC2/LN86Hnhv5dP+rtzCEs0VqsPoqDESnI1EfV2Zy66lXWeb5vTPO1y9t7u2KnlTqE/F7RDoWIJJXgI3N8+tbbSekMROx336kfw8sQap7MtoYgLdABGktTgf+Htnt4HX4oywpjDgXM+Mmy4TRnf+OJJyh5o5baSlf+/IPcIs6ywzrDqQ==;
 7:dIt2/oY8i4zh4Dwuj9OTXsp76GqI5EEQs6AkusQIG0EaXhkU5oLdsHzCleYTHCjJFiSaVYwytu5OiqE9CZP+AqMg+yiWXP2TuT1vdgTBwk03pJMH9nCDSPSPP75maM8XomOAHuS/U9iyiwY0AI7puQ==
x-ms-office365-filtering-correlation-id: de2d4e66-f3bc-4195-78e4-08d688c3ee4b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1300; 
x-ms-traffictypediagnostic: BN6PR11MB1300:
x-microsoft-antispam-prvs: <BN6PR11MB1300C2BDC34475C214549753F0930@BN6PR11MB1300.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(14454004)(52116002)(50226002)(105586002)(6436002)(102836004)(72206003)(81156014)(81166006)(2906002)(26005)(7736002)(478600001)(3846002)(6116002)(53936002)(256004)(14444005)(106356001)(8936002)(68736007)(36756003)(97736004)(76176011)(107886003)(4326008)(39060400002)(2616005)(99286004)(476003)(446003)(86362001)(66066001)(71200400001)(11346002)(7416002)(71190400001)(6486002)(6512007)(316002)(110136005)(1076003)(305945005)(186003)(8676002)(2501003)(25786009)(486006)(54906003)(386003)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1300;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mddVmu95POtp0xBSQUjULk89Rgw0B9ZpZLNxIKA7CDS89MYsQ4JWe3tMCdL8mZUidYvMahJs68JY92eLPpQnd0m7+nTYvDkGch8Q3132UiUbx7mLuSkyscdKjQUtze7nApvn9+p65Eq3krYdj/f7rso9m9mVBZIrP/N0C0mVTepCzvhH2bcGwHgAU3Nzvkj5P8SXcB7xFhHdMbX8GkEuz1IqUO8j3C97xhRrh8Wv3su0FoO4ZVUOgGdZatL5sF3xZko85qLsfIHPJI8DihqjRcQzwahaeS9VrxdtLgm3obvY16jhENzFyJsNpkUx2fkqaQ8rH4XxyBoz+m7Lvg61t2/xXYcroIZ2xk7va1C2lJmVKrcIYZg7ljwvC2n1HPKkhZs+dMqIzJfsbWq5fKpXlTqvUw+PD7AfzRUOUyYH4qQ=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: de2d4e66-f3bc-4195-78e4-08d688c3ee4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 04:07:19.6009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1300
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_200732_037564_4CC0ED75 
X-CRM114-Status: GOOD (  10.15  )
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
---
v3: no change
v2: update after the removing of iomem access wrappers

 drivers/spi/atmel-quadspi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 131374db0db4..47ed751a91e7 100644
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
@@ -234,7 +234,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		aq->smm = QSPI_MR_SMM;
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
