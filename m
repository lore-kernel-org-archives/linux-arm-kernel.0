Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63669C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:28:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D40521873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uC4VFBwW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RtmLua2b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qu3fOdnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D40521873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JVTUoWIyvzYZE7cV3CYoW247Zj6+N+OZ74C2h8hi+rE=; b=uC4VFBwWy+1/Cv
	OfLmNjagrzz5VL+hZxNNhdoIVOJSYrZb8mRD4kJ3TgzQfZ4ErjSWmGvmneCzi7XAQw3gItgkLoOjt
	91rqOVoBahtXYmC41DH/V4dl3ylio907LTtfCcOP9JiNDCGoPadTpuDLwJKUZe8nQ7jmk9H9pjPRy
	TxJUOPfrwl14KbRiyWDuaZ7wlHylN+a/IcRZDl7bCDSt4Hr7qtLAXERbsvvzGDuhzhiTaT4UTB5vo
	GeN4GV5WCCA9wWwCKY9mBIMqbDdzocKyJL0ujE4h0cCpHQufjQUKutiSoU+dqu/cYcg5sjdhEUbmc
	YCzt/SNUlGmxpoHZIFjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZZ5q-0001h7-MX; Wed, 19 Dec 2018 10:28:46 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZZ5d-0001PG-DR; Wed, 19 Dec 2018 10:28:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qQMdJRuZhrf3FPGVR1Fda+dT8eND4c5hppQNjlgocd0=; b=RtmLua2bfzV1UtUbxwEdq4H70A
 e/0QzaCVw9nr6HZok0Z2eC2e6ZSixJI176C813QrXecUFq7/uH+KuGRV/9ujmCMk6RcMDbk8lH4jb
 xzJsGB8XYVGtdug6SWPYVuaYPXmr6FfxGOHwCa+RDMBuaIpdM1i0EBP1ji3NLqUlGO3/8Po/vetwY
 mmcG6cWSDR4VRGGZJ600wv4wqIG7hFMwzSmaUQYNy9osEuqZdmCWZYz5ActzrARy2+B+eo7jZ26lE
 FCyRFIFIT266zTIKb+MzS84ce3SktheaV6S7ORq17us6DYlgb8nHShgk1Btfjqz5o4f64XCqGGfFW
 9m47QBDg==;
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZYqo-0007SG-Oq; Wed, 19 Dec 2018 10:13:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQMdJRuZhrf3FPGVR1Fda+dT8eND4c5hppQNjlgocd0=;
 b=qu3fOdnH0GBih5tSOfUY0Zk4uUVpDStVoChJ2fgQsIyS0ugONCKzc6qAmHkNtv79f9sNjAPr2hEaEvd+csD/IOr7JhgOkw1f9i6euOh84PRC8z52zK4r8EWMp8sYPvl5u1SvE4mF7/NCxHwWS6NXHJ81dfOlanlvUYCq84zuFrI=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB6141.eurprd04.prod.outlook.com (20.179.27.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Wed, 19 Dec 2018 10:12:20 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175%3]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 10:12:20 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v6 6/7] spi: nxp-fspi: add octal mode flag bit for octal
 support
Thread-Topic: [PATCH v6 6/7] spi: nxp-fspi: add octal mode flag bit for octal
 support
Thread-Index: AQHUl4NTdJxg/UgGtEeSFbAm/QNYvA==
Date: Wed, 19 Dec 2018 10:12:20 +0000
Message-ID: <1545214186-16987-7-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:3:17::21) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB6141;
 6:0T2OyCirj3fH09WaRIXscM85i9cQEUY4YsmJNRSDf0J9bjDsazRV/Ei9MJKAW79UFdsS132ThEmivCl8jDSijlJfpGeVOPf3sVP7A03uA9QJA2QnhZ2NfUOC3ivLfYylrZVRhjaAII8T8pMeV8PRYyoZ3X5nSgN+9GRoMOUYSJ45SJ32y9Ft7cTkC/r0k+beUF2Z/1Z5m0swwj2NGQkH1WbwwRxOU9xCYcOeUp+qTTyBYRj40VZkC+V/6j98g1u0teZkZVqr2VzGRX+hwM0msKP6cVUWTMHkNF5oAYeWwH5fFWPuscCDK65EuEs0UxwGktGECVqqS9phWMNPNUcSaM63lTr5CQnPzyq6EXa8LKAFMvt8J69RiaKin+vTeRqeKPbVli2r0TZHfrXAYEbnP8MbE54v9L2ZJYodIqsKoUroJt7OhaQHSPVnkp26GfEPEhayMhfDWY4KKizugkzEcw==;
 5:5HuuEd3LPHmHpgYT1ptaWlO4htQMhvfP73EG9FJf+XjpfdR3uk6cjXJW/ZUovDInEhwCz4zwU/5eEHl6wWcuIHga4HQXZuvTUWZEHjiO8zH3TqSPcS7anyUsbiSgUnlt+Fmv4d4ZTBDbiAG0tV3dMUT4XhHUg2OmQvHgZHuMM4U=;
 7:3HH8df3QrqFOJTceRnlURTb1SkfS2kiaRMUnROjhcCxV3f3p31Z5AN2tC+z5/FX4x4ZX9V/AFTjfvEyG1lj6ZWWkRub5cE5kJGVcPX+fZ8JfuVBmi/Qw6fkD6J9EeKSAZvLHUJWVwjNrv9FbOla9wA==
x-ms-office365-filtering-correlation-id: c2c11697-fdeb-49b0-b642-08d6659a7611
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB6141; 
x-ms-traffictypediagnostic: VI1PR04MB6141:
x-microsoft-antispam-prvs: <VI1PR04MB61411ECACF4E593CE78DB2B599BE0@VI1PR04MB6141.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB6141; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB6141; 
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(396003)(366004)(136003)(376002)(189003)(199004)(6506007)(39060400002)(78486014)(386003)(6512007)(6486002)(53936002)(3846002)(97736004)(2201001)(7736002)(6116002)(8676002)(55236004)(4326008)(2501003)(2906002)(66066001)(25786009)(76176011)(52116002)(256004)(486006)(6436002)(102836004)(7416002)(105586002)(106356001)(36756003)(81156014)(476003)(8936002)(186003)(446003)(86362001)(478600001)(26005)(54906003)(2616005)(11346002)(71200400001)(71190400001)(110136005)(81166006)(68736007)(14454004)(5660300001)(305945005)(316002)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6141;
 H:VI1PR04MB5726.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pAE3BqfUd9Ppo2AhqDb5A36s3pVLK58H1QJtZ1ATH2Jr0QeNP0SHTfeMcBtrrU2kE1fpeqLT+hRurag58uq4VuZeB2URFMPmccB5fgktyVz1/IoTK//8YPJCLnzzp097XNyGuQXmaH1HTxjVBsQGauOFscm6wdICLcR+i94VtPgtejZXTl2I7SVqg3zLyNB8nOwhvoKkFv3Jig8O+RBT5MFIBBHOcTPI7yEFyA5qmXJU8GipJbWSdPy03xP38ajsoB/eouAwbpsbSUNLyGB0jIyPjVAEEgKtxL3bDdyj3ANKN0OGZUKI6dy1hT9825Bx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c11697-fdeb-49b0-b642-08d6659a7611
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 10:12:20.3651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_101314_816056_A039D6C7 
X-CRM114-Status: GOOD (  16.11  )
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
Changes for v6:
- Correct S-o-b tag with full author name as 'Yogesh Narayan Gaur'.
Changes for v5:
- Modified string 'octo' with 'octal'.
Changes for v4:
- None
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- None

 drivers/spi/spi-nxp-fspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 6d497f4..cfd3126 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -995,8 +995,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	if (!ctlr)
 		return -ENOMEM;
 
-	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD |
-			  SPI_TX_DUAL | SPI_TX_QUAD;
+	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL |
+			  SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL;
 
 	f = spi_controller_get_devdata(ctlr);
 	f->dev = dev;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
