Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F952C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:21:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C4520861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mb1jYwgN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DqW6ASRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C4520861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pR5jpYMPdm21OZ0G4ycc1Rl4r3znl3JpgUKAyZz0p/M=; b=mb1jYwgNi+BpRF
	VztZ5wexf9Af+QU9eSvRFRfesbPtTWRra/BPcmIg+JrrD1tQDBxTdIDluSsyOBIoUGNl2dxKvEk8A
	DRQErNSp4Dht+MRSruQfT4lKLpqB7b37YNVy6RiqVnNi2I0Qs7MnWJVkVwZv7O8cpzCcZwkK2fZ+1
	vvDBkNmVmiLw2cmo37xYVTALcAZeJevBbHAH2ZZ9hODk2SO0C/gBN7C917QEIPEw3/iCn1+P/02hi
	3yACkRQWifwBztG0htZ69hy9/0M3U8uKG/bnEp37kfRD+c4h99Ji6Eyc2yTEjkjUFh7p7AyLg2wd/
	Gi9EKigYQcvELNuCpP7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjLqb-0003kx-CF; Tue, 15 Jan 2019 10:21:29 +0000
Received: from mail-eopbgr130054.outbound.protection.outlook.com
 ([40.107.13.54] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjLbB-0003ow-I9; Tue, 15 Jan 2019 10:05:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ktx1GRcHi1eYSge/SiHdvLAqiZpoEsriXHWfa3f58Mw=;
 b=DqW6ASRd74gV6eTHyQqLOiNzogWLVcw6FSf+LKyROhHEcOiNoUt4/3PP9La3YyrldP4Q4gfvsJUX5ssUZZlHFz0getWTCIv0E5mlYLeydIpgjYdCxb0XP/dsl8X9NsIXNi6zODRYaZlBjprpybNOe9g3vr5rvPywY1fxjM7tw9A=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5822.eurprd04.prod.outlook.com (20.178.204.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Tue, 15 Jan 2019 10:05:29 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 10:05:29 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v7 4/5] spi: nxp-fspi: add octal mode flag bit for octal
 support
Thread-Topic: [PATCH v7 4/5] spi: nxp-fspi: add octal mode flag bit for octal
 support
Thread-Index: AQHUrLnXO6XkhNwsbkOmcWHevEJc4A==
Date: Tue, 15 Jan 2019 10:05:29 +0000
Message-ID: <1547546584-5254-5-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0123.apcprd06.prod.outlook.com
 (2603:1096:1:1d::25) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5822;
 6:0q1+Zvgcx8BLycQTLx8u8om9fFK6Ocmqh2G07b+cKcmKgywS65jADKvtKB8UxylmLBwfm2AvJDikf0aCFqDPG6szZ0eIwwQQR7UQeZpjSGtUkQew2uM512p4c9vNH7P4LRaW+Qzy7V+pl61gBZqZZnhY82PPRJuLj+waiSsvag3Ktr2URfqZ6y3fD0fbWvffmmqohye22sbm4BXmLM/S2Wf0EKEsZK7wNoiA/AsIndQttvCCwmyh+aKo/jC9Caa2gZ0iblnYxsZhB4GZbBzywnPACwDnXL1reWaurfQHUNxq8HKWr471UmbALP4e/9sftsenE2UzImHdw+USVxNz0RxpjGMGdGox8zVxkOWCjdBAQX/kBgapskYsuIn61V4eWz4cCMeOgFIoWfYeZ57diT2AjQArfL6DbMNisfA/jKEPB7rFC222NBCngW32dBmj9IZbTVcb6oAYyjgnfd4qfQ==;
 5:AkITVbbdEvUYQ7aX3In8IEF++wW7+OSZ06OE4rjcbrGcD0MAPyZK+s8WeZ1gklV6xYdrZi5FFxqKzv2bJWK2yzdsco9kIf7/85c5kFUOvIoppzaz1I8tUdo8AM4ytxQGSFYNszCBPoWO/xnP7cyNNBrqIrvBfeIscywDp2aocXFZUa1Fe4CfCffDe/RLL1wvIhngjkZHp3ViRxCoV/95jw==;
 7:M02TcNhv6qLLM5m8agZii6CV+0lmjQ9hN53OEZMbRZ69z8xAoV89RQeDAqYPFk4p0UKkU4sZ08FuRgbuop7Agt3YtbIo42xX4fEoyJTbrnN84/h4Kn+pLsxDvj/klgFTQX+PFadETFtRGeK88Oj9tw==
x-ms-office365-filtering-correlation-id: 3bc83343-de8f-4a30-52ae-08d67ad0fa2a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5822; 
x-ms-traffictypediagnostic: VI1PR04MB5822:
x-microsoft-antispam-prvs: <VI1PR04MB58224F0DED219913A8949A9099810@VI1PR04MB5822.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(396003)(39860400002)(136003)(376002)(189003)(199004)(36756003)(305945005)(14454004)(6512007)(81166006)(486006)(446003)(2201001)(81156014)(2501003)(4326008)(105586002)(8936002)(386003)(7736002)(86362001)(102836004)(2616005)(26005)(186003)(6506007)(54906003)(50226002)(97736004)(316002)(5660300001)(110136005)(2906002)(6116002)(8676002)(256004)(71190400001)(6486002)(7416002)(66066001)(3846002)(99286004)(6436002)(106356001)(478600001)(76176011)(55236004)(71200400001)(78486014)(11346002)(39060400002)(53936002)(52116002)(68736007)(476003)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5822;
 H:VI1PR04MB5726.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EATlUiWocJvqTUr2CzcKne6iyIcSipjF/4J/6wdjf6jF/5LWcenAWLgUe0rT/gE9NDkucgP0PlN3EPUWSZhvnn++LR9B2V90Nz8npplMqMyEgERGkgjvdhEtXOnWrplp8KM1IZloIVkuP/90YBljrV/UCHOS8Zw7Qi96gar30YRptHL622Gb6Xxb8218AW82ORKyeRqPIzFK/TXfaPOwC615URgRELYtxS/9GBFumHHDo8sqHe8NrBALiN9csAYvBvidoZf2Eb5OO4CP/6V5YjHyA66BxTLNhIXuJ7DgNJxSBIPIYl/3n5Fv4AwyB8EYhLCyQxupALQaEty1PV0P1aSbPhQCvS6B5m2tsS2yAw8gkiKjTcO3ihSnCeFP9pIfzVCvHE+jptmIehjFLkshifvzOMQjsugk7XB4d/neZpg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc83343-de8f-4a30-52ae-08d67ad0fa2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 10:05:23.3366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5822
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_020534_057259_B55B0C94 
X-CRM114-Status: GOOD (  12.34  )
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
 "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add octal mode flags for octal I/O data transfer support.
NXP FlexSPI controller supports 8 lines Rx/Tx data transfer.

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index e23ad9ef028e..adc3c0e14f38 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -952,8 +952,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	if (!ctlr)
 		return -ENOMEM;
 
-	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD |
-			  SPI_TX_DUAL | SPI_TX_QUAD;
+	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL |
+			  SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL;
 
 	f = spi_controller_get_devdata(ctlr);
 	f->dev = dev;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
