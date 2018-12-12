Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAA0C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:32:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A0FE20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f1j+VP8o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="yfuvupym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0FE20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LdU0RaEF2Y0tJ1EF+7KkVA2B85FQBKbP8XXGg2h5w8k=; b=f1j+VP8oBTeWTI
	/QMBnr6A0ngYD1unG6DUQInEglHo8lGZ0l5FpNz/j0A7QvJV7VRwzx7EmaY9RSL8PNOnZMFOLFOWf
	FsI4DM55sdt2s3C0IzFtg1knwOnUINUBfflrjIONYMAFO6aB7mrSq6zQ+Eb4FT/6Rm0KtA+i3FLlq
	GfRM1NYMetvsONwW/wYA5GpCMs2KEr7vcFjWN8gyS1p0b6cEkXoUpEcdVKBY2FD6dxd91iT/8BMmQ
	mIJmlIqDew8aAuicyAiunoD/HaqxKLn3jiX6ZOWKO4c2Zlu+P8LSpMoYKpOBZapy2i5DF4HB/Wi9h
	F4kIyMRtFUhKivwiWWzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX7Qe-0004yl-BK; Wed, 12 Dec 2018 16:32:08 +0000
Received: from esa5.microchip.iphmx.com ([216.71.150.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX7Px-0004JA-IO; Wed, 12 Dec 2018 16:31:28 +0000
X-IronPort-AV: E=Sophos;i="5.56,344,1539673200"; d="scan'208";a="22187189"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 12 Dec 2018 09:31:13 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Wed, 12 Dec 2018 09:31:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGWWOuTRarlTqDUeZFadjUS0edqT9Ih2KhDYb4sqUnk=;
 b=yfuvupymkFuj3EvN74SBNvNGsRqO/fmNE95yu85qT2z2fiH3D9Y1COC8oTV3hKrH4EnfK29INpbka8be10IvIrvyRfMgn1GJ8ZRG58Rx7wgTYvkdV4VA2Px3fTSmLyY4kNTzBPY1KJhIJwI9GsRBW2T4Al2TLj/ffGxmNFhf3Rg=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1683.namprd11.prod.outlook.com (10.173.27.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 12 Dec 2018 16:31:09 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::8155:7276:d66a:e239]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::8155:7276:d66a:e239%8]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 16:31:09 +0000
From: <Tudor.Ambarus@microchip.com>
To: <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <robh+dt@kernel.org>,
 <mark.rutland@arm.com>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 1/2] ARM: dts: at91: at91-sama5d27_som1: add QSPI1 + SPI NOR
 memory nodes
Thread-Topic: [PATCH 1/2] ARM: dts: at91: at91-sama5d27_som1: add QSPI1 + SPI
 NOR memory nodes
Thread-Index: AQHUkjgW0EZIpR8U80WmEyyY7b75UQ==
Date: Wed, 12 Dec 2018 16:31:08 +0000
Message-ID: <20181212163057.22183-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR10CA0088.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::17) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1683;
 6:S7EOnoKCp5L8+vvPLi+/9ndDu+s2PPpW764BtNcdxXH0k/6M3v2AT/kUMjgqrbEnHIJ4yjm99JLrtRdV0oXc83DC0onx2i2RFmgCKg8+Q6H3NS/JS6KqtJ3edoFLfm9EpNgtQHqIcQ3P3e6wEga19FmGLccsXl12DqG6Sd/LK83Uclp5JixAkp32jyIFO3A61bGDCQZCRljqOTn1o9for4YEF6dGIstpYPGaUuTmPdL7rm0e0unMPYH+I6cktW/KnVZftdmscrW9FXt1qK3PmoOl8Ym4kbmD8DUfvBSgRQRV3YefN7d7C7nSrHrGoczMRc8AjCpqoD2tJMr9dUkXA7mbMQ0dn/TP16ssQ3FL3j2wzkusgsNn/5vBUz2PL5x6QgHuu2yDhjhp4CkfAUJtD0OdJNFQ8b6Dlj1be0zPuGUNJGX+oeTLb2QRfTpvm2MBtYLKH19Wwcpz0EzzeSGzEw==;
 5:woYEUbPWJYF6A7mkMnpdJhGV6kcLSlmUD7dCA5HDEQIOQAhNg4X3BW56KefPoC+mrmZnq1ZGQwRFAFPBd4xRUhzXMhclSpZqi+rNNqbgqZMK0SLZ4y8JQElcDgsEOZhC7xX2Dx8egB4Rd5G39Ny3xJrIjRYbnbPqBOOm52GZ8JE=;
 7:WC0KwXyxlCsbkYhnBWuhauY/IpggrdCqDzUtZMZwN/cBcsJd0y1SrvmKb65HvgETBBNQzo9+Aev+2ANgSfHpayBwGVyzY5pqfhbeE+TK1wMnl7BC3WMmFspM+tkiPzE17TQsCyRHQXjCDh7i5LdHAQ==
x-ms-office365-filtering-correlation-id: 634861d5-857b-4952-4e9c-08d6604f384f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1683; 
x-ms-traffictypediagnostic: BN6PR11MB1683:
x-microsoft-antispam-prvs: <BN6PR11MB16830EA16E3287CC28DEC21EF0A70@BN6PR11MB1683.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231472)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:BN6PR11MB1683; BCL:0; PCL:0; RULEID:; SRVR:BN6PR11MB1683; 
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(366004)(39860400002)(136003)(189003)(199004)(8936002)(81156014)(81166006)(8676002)(7416002)(105586002)(68736007)(106356001)(110136005)(99286004)(54906003)(5660300001)(316002)(476003)(2616005)(486006)(26005)(97736004)(102836004)(186003)(2501003)(52116002)(6486002)(6436002)(6506007)(386003)(1076002)(6636002)(256004)(6116002)(36756003)(217873002)(305945005)(2906002)(3846002)(72206003)(25786009)(478600001)(14454004)(6512007)(66066001)(107886003)(71200400001)(86362001)(4326008)(71190400001)(53936002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1683;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Nm8F2YTfRmVshNNZY2aqfBysWPIKnDYPVWot2PRukQ5PoTNhkHaXUJgleNuEWppB1VqO6pwdd1S9ggv5fr61y9r1BfjRKpWO98RO9UiHuHNfjgEUynYgUmCf5bhdXvw0uDZUM/YF9T0za7D844ssnjZmdhWVoIyYQz4SQniE/CU14CUZGOemFgfA08QSPtxds42b/X9DXR8MpmpvGZ8/RVk50Qv5wO2Yw58rJkQl7jph0Pe2EFiqVI3a7pw7CrzYnuOfhLMpSf6titQ4fcu7NIAqOKJ/hXrsA4Nmqhh9ZJttwBJzwPTnMRWF2CAZIHTU
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 634861d5-857b-4952-4e9c-08d6604f384f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 16:31:09.0408 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1683
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_083125_722861_8316F414 
X-CRM114-Status: UNSURE (   9.33  )
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
 boris.brezillon@bootlin.com, broonie@kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Configure the QSPI1 controller pin muxing and declare the
jedec,spi-nor memory (SST26VF064).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
[tudor.ambarus@microchip.com: add spi-rx/tx-bus-width, drop partitions,
reword commit.]
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
index cf0087b4c9e1..33a159c0163f 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
@@ -62,6 +62,20 @@
 
 	ahb {
 		apb {
+			qspi1: spi@f0024000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_qspi1_default>;
+
+				flash@0 {
+					compatible = "jedec,spi-nor";
+					reg = <0>;
+					spi-max-frequency = <80000000>;
+					spi-tx-bus-width = <4>;
+					spi-rx-bus-width = <4>;
+					m25p,fast-read;
+				};
+			};
+
 			macb0: ethernet@f8008000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_macb0_default>;
@@ -78,6 +92,22 @@
 
 			pinctrl@fc038000 {
 
+				pinctrl_qspi1_default: qspi1_default {
+					sck_cs {
+						pinmux = <PIN_PB5__QSPI1_SCK>,
+							 <PIN_PB6__QSPI1_CS>;
+						bias-disable;
+					};
+
+					data {
+						pinmux = <PIN_PB7__QSPI1_IO0>,
+							 <PIN_PB8__QSPI1_IO1>,
+							 <PIN_PB9__QSPI1_IO2>,
+							 <PIN_PB10__QSPI1_IO3>;
+						bias-pull-up;
+					};
+				};
+
 				pinctrl_macb0_default: macb0_default {
 					pinmux = <PIN_PD9__GTXCK>,
 						 <PIN_PD10__GTXEN>,
-- 
2.9.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
