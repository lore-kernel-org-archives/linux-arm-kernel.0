Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC2AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:06:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1717920651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OahY4S12";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fV5cxcoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1717920651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FZ2C5tlgrpWt9XSABghsF1epC8mW01272vNlaCQ2Sjs=; b=OahY4S12d1cduR
	0vQihoy2lM7w/v2TiDh5Ii22ezSdMKJOgv3kOCrqBzF/fMJVQMiNCJrh7U+zL1NAI64d+dxjg0+Te
	h/TptUcH8iMVBvkfR0k768OG1YgmQhtI+G5Db5aVvXvZYQolMZlVShuW/VAXEYKr0DiSMXse0viBY
	ikvMlFdlSKuwCeuWKFxI0cIKTMoM2cxP1t16xtPpfVPz4ez1k0COARXQjb2En1bUSidQVOjhGMIAs
	o2C/hVKn1zwAU9J1+2MuDsLoaxMYLgrNYO2lNoxJyxiXj7AMt6rahY9918tKAhWQ5nkcgeshdB1W+
	YYXg9YMza2hJUsDZso8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjLc5-0004qv-Ow; Tue, 15 Jan 2019 10:06:29 +0000
Received: from mail-he1eur02on061c.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::61c]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjLaz-0003ht-T8; Tue, 15 Jan 2019 10:05:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXGCWNDxM8RawqSl8SpvNauvyjgeoRTco8+iqiQVGsQ=;
 b=fV5cxcoLOkcR3KvbTiv8xrVVfITeguBHdt0BWMwhn1ccGX1Jl5AZ2H5KtGEQt+vMpECHRz75BlKMvzbxOSlkzyEl1vKtoD6wUsG6FpyZt9+bSgd84Pz9mBhIn8dalLxfXjpglUzIf42/Wsm8x7p5jRC6X2/R4uaN+QzltdXwevM=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1SPR01MB10.eurprd04.prod.outlook.com (10.170.239.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Tue, 15 Jan 2019 10:05:16 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 10:05:16 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "marek.vasut@gmail.com"
 <marek.vasut@gmail.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v7 2/5] mtd: spi-nor: add octal read flag for flash
 mt35xu512aba
Thread-Topic: [PATCH v7 2/5] mtd: spi-nor: add octal read flag for flash
 mt35xu512aba
Thread-Index: AQHUrLnQgJgrUdZwrUut3L5z4nyOUQ==
Date: Tue, 15 Jan 2019 10:05:16 +0000
Message-ID: <1547546584-5254-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0123.apcprd06.prod.outlook.com
 (2603:1096:1:1d::25) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1SPR01MB10;
 6:HKIo2rKDCzsGWT8/5toYFJCzaGL8IHeGb70tWJnKibq/TwyKxVK9HylsoCQlt5a/HbLHgGg2SvBEUOXWNvRprOODZLXumXKMDCBLtUbq4XY+zh2ziXkG7IAUYOrG/nxpjBJL1bzuoQag3ONAaBp5DSHVgQUllsYIz/YEUsL/oMgrw2gC7IgKCyXW2uDleEn19VloPxMj3vxlxUJuhhtl/nbLA3hNBZQdKLWau4Vp2M2oTY0JGJXdQDAFE4G3xXiOCuDZ02ds6Hw3S4XlGiSzruMZmkndc61vCoNlQyJAtYh8n+aHUwT/FRAz/tSSmAt5sb1u/Iotr08DAvRWRDcvlm9G6hvFdyE5ahmWmYeOQEt8L5JWH3u0tmmXC7EfnU8QlPzFmDK9Rx8K74h0am0xFptb1wadJq0QOz+wSqric6lX+yd9vep+YWnIQlNpPpWb0doiEy2lScAk1ofd6iGszg==;
 5:rJypuP3J7Y6O7Cr0yfT3i+K0wQ3NWhtKGuIHI3Zwzx4Ss3oR3OLnxeMnATpge8RIQz7G4uRVRds3YuWXBiZ1ifnuVaTrTMOaHeC3qtm60Sd6I62LnvRPTHgXOBHOrtRPrVvVSN+S6gee/7fEJYtfLRu3AwjV3Ac/1MxuYLIOeeFXiK9YA1Dxi+7wvk+R/589jjX9a+cYUDuuJTcnBUhg+w==;
 7:7eZ+5Vf3aPpAUDxIRwgFd9vrrJXok91K4rmxwFH+gJ4XP7RVSepl4B+0VRogJ5zw03tIBTPDpfEtgSmJ3VHBbOTcQThwza49EQe5iLFYNcXHUwknz/izLbXM2KLEeyAe5cu2302kpLCrYnBw53bXKg==
x-ms-office365-filtering-correlation-id: 970eebdf-4930-4835-63d2-08d67ad0f2ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1SPR01MB10; 
x-ms-traffictypediagnostic: VI1SPR01MB10:
x-microsoft-antispam-prvs: <VI1SPR01MB105EB7E5480FDC245F611499810@VI1SPR01MB10.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(366004)(136003)(396003)(346002)(199004)(189003)(6486002)(97736004)(2501003)(6506007)(386003)(316002)(53936002)(55236004)(102836004)(5660300001)(106356001)(4744005)(105586002)(68736007)(52116002)(36756003)(76176011)(86362001)(11346002)(71200400001)(3846002)(71190400001)(2906002)(446003)(6512007)(256004)(486006)(14454004)(2616005)(476003)(7416002)(78486014)(99286004)(25786009)(8676002)(6346003)(81166006)(81156014)(186003)(4326008)(2201001)(14444005)(6436002)(8936002)(26005)(478600001)(66066001)(54906003)(305945005)(39060400002)(6116002)(110136005)(50226002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1SPR01MB10;
 H:VI1PR04MB5726.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8enKZ8NK0Iebp5efXrx/8WyQ4gFG9QY2CU/Vd0x2JRZD53YqD5iyFMkBoQxK0MU78tLD315InKUBuibTUd7IKbC4W//waEOQVxUo3ENLdoXizcjfwvTclUoopD+LsESABct9U0aUFsPJthZzChJRIz7NKHphKGVmDGa8k5a3m0qpuhsov4WQ4p9esBRW2Zo7/AMSl6Wu5UHXqquUWtUqD7C5Pie0jmEp1XAgWMmSPNanaownSNxX6v+a0/6lhZDdmDDxd4/u4y5Ca3XvBDCJLmwol+nQ7Nv1AK7LGFYRuqwOFctsB5cqXBh2hLczwgUL1G9IgeQFv+/RYrsqTHSho0D2x/LaSWLCTbWv9zRImvkI+4kOyU7av+qGaLrk+Imw8K7esofXQuOCXOTnvDTBHGdKD+lcxFb76n7r38epZxQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970eebdf-4930-4835-63d2-08d67ad0f2ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 10:05:10.7894 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR01MB10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_020522_717238_D6F549BB 
X-CRM114-Status: GOOD (  13.52  )
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

Add octal read flag for flash mt35xu512aba.
This flash, mt35xu512aba, is only complaint to SFDP JESD216B and does
not seem to support newer JESD216C standard that provides auto
detection of Octal mode capabilities and opcodes. Therefore, this
capability is manually added using new SPI_NOR_OCTAL_READ flag.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 872d70722672..53a3bcc6a55b 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1877,7 +1877,8 @@ static const struct flash_info spi_nor_ids[] = {
 	/* Micron */
 	{
 		"mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512,
-			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES)
+			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
+			SPI_NOR_4B_OPCODES)
 	},
 
 	/* PMC */
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
