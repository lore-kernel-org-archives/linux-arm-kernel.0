Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC465C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:16:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C5C92082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k7rSh7t2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="rmksHg1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5C92082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XqwVXFXXTXT27CWEnfpX9PIIaVegbnLobG1Uw922w3w=; b=k7rSh7t2jdBcx9
	gqqkNH9ej9yzqyWW6FUXf89Ks/EGnSQjXYqlANbYB18c21k5l+d1VXuXt/cIbJ+VFhy0y8iCsAfW8
	ljdmYIPaxcYLB5IwTcNc9l3GcBqZ3j8zxEtpfSiAS2PQwoCT/r1OITld/tzIOW4c8bs/sSlpDF8da
	s/qY1x9EVAuAZng4dsZwiLcPuiXXUC8gnaY9WCtyCNTuhju7kRRn9LBhjKED1bBNo7r8turbRxBnn
	+3qg9QyV+D+8Vmls7U8P9okF8+p+KZpW2VQAN/hFZd7IU4kBM0Mw+3NZYXaNBkFJ+dl9CK+tFOae6
	klCoZ/NvdZX4djn3UGKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWP9z-0004DJ-W0; Mon, 10 Dec 2018 17:16:00 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWP9m-000423-7t; Mon, 10 Dec 2018 17:15:48 +0000
X-IronPort-AV: E=Sophos;i="5.56,339,1539673200"; d="scan'208";a="25064723"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 10 Dec 2018 10:15:34 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Mon, 10 Dec 2018 10:15:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XNrmeOL+ZjYS/P/wlQ3EdM9OocCB16TWniZLAaI+9M=;
 b=rmksHg1NSLObVTGb056pbUmOwgwBWI5P+VG77VSEGgT4GZZkHF6eC495/rBDdKlGDaDJ+tRUuyU42Ye6WqbkGbBdgFRfrK5k1gFybHISxoDAO3DBqVNMRywYZU10Rx/Zrw1f3D9MTeqwQhcGUjayoPBoOhQIq69yhniz7olO03E=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1282.namprd11.prod.outlook.com (10.173.32.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Mon, 10 Dec 2018 17:15:29 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 17:15:29 +0000
From: <Tudor.Ambarus@microchip.com>
To: <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <robh+dt@kernel.org>,
 <mark.rutland@arm.com>, <Cyrille.Pitchen@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR memory
 nodes
Thread-Topic: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR
 memory nodes
Thread-Index: AQHUkKvzXXGQaMBmgEiVjL0m4mUE4w==
Date: Mon, 10 Dec 2018 17:15:29 +0000
Message-ID: <20181210171511.21002-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::17) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1282;
 6:UGrae/y90LV0en2YRmBfZBSm+e6Hgj96pB9wIerFuvPWk5MNFWcK/nZTLhIjlYbvOBEGu1/vPe4BSPwsXU1SvX6eMtJ5tVOyvcebUucH5jmc9dPmbKVYbQjNbGc8u7Xv5pchuL/Rx9/ufw1K+g3RSuE4dTTWhmUJQ9P67jOQsMQbXVHp+synzLzXS0Yat9TsnuOsTJhMwsZC+haZdyvSdtCbJvUYlQVxIwYaLfsSL9aafKnEvHslvIuoMZG/6FUc8Q+K5PtU7Sort8tn2M+DxKC+didAiYrbEbNj+iDbxW1XHGc6V6AdHyB61iV6emejwg9uvt4UWl0ntPMSteVpkUYySaR13hz49P+c74kx0ONjfJuActkQMFgAXtEQaHB3WPa5dLo/0WhciSUxtulCZMqROOuY6nnAzQUaU2wvvymfspJ4wLu5r+NAbmyqgDZ4jdEbp4uoIo/47EFwL1TKXA==;
 5:W9KyeZGXMYEz+Abo3iwvj7Nksh/Bb/RED/ynuald6LKDTjlErs75DoSapRk73xil32EKeCZiv5Mfuq6eIOOQYmf9eCXBQAxCPEyT2c5G0H6fuQ+ZOOD/RgLBrDvaS5w7WA8QyZQkH4i7F2EErvEessJAEhDbTYXGDCpowLKn+4g=;
 7:W5HT1ARSXFspC8IwT5z8dkTeIzR/0FNikReDSYn/CpQZ0u5I0NrctEHIjGW7hatojpNWGq9IY7FLmKjC31uYMWSfphTG/k7KZodRIBA2VtYxxhZFUgvOkCAM+oJDcZ/iYia4ZnOys2tRn0Bz5qGTsQ==
x-ms-office365-filtering-correlation-id: ec007223-fa55-47f3-3b87-08d65ec31555
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1282; 
x-ms-traffictypediagnostic: BN6PR11MB1282:
x-microsoft-antispam-prvs: <BN6PR11MB12824574E1795CE19F82D3EBF0A50@BN6PR11MB1282.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231472)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:BN6PR11MB1282; BCL:0; PCL:0; RULEID:; SRVR:BN6PR11MB1282; 
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(376002)(136003)(346002)(39860400002)(199004)(189003)(106356001)(25786009)(53936002)(66066001)(71200400001)(81166006)(6436002)(110136005)(6486002)(99286004)(52116002)(1076002)(256004)(14444005)(54906003)(8676002)(8936002)(81156014)(6636002)(316002)(26005)(68736007)(7416002)(305945005)(6506007)(386003)(7736002)(2906002)(6116002)(86362001)(4326008)(5660300001)(3846002)(71190400001)(6512007)(186003)(102836004)(107886003)(2616005)(2501003)(97736004)(14454004)(217873002)(36756003)(72206003)(478600001)(105586002)(486006)(476003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1282;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lyuWmiDuJ/aDtrOacE5OudXmy1a9cKez97GOo6aXJINRvA8+9U4+BtwyyxPXsWIy+LQELZhllI58HIgPfabsx+4+Uf/pDx5tgzS//P3Xmor9XmAKaQHRb2fanIBpCqiHfIOU2+WH4rSXcfhqGMZ6xZVgQxF3kAYFQ+39GyvgrIPIb1gQyOsTHyYaJLRNbHkTGHsMgGOJR6B72HMDT8S9q0l0aIUshjfell3lJmu/cKLvOWqLp6ts97MBVrb8mRrrsCFAJ7B96oyVUil0jPe3BuTGgWMULqeay3xmSDc+sJ6US/tehKpX+kLM0tVooENu
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ec007223-fa55-47f3-3b87-08d65ec31555
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 17:15:29.5039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1282
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_091546_296884_4873ECCE 
X-CRM114-Status: GOOD (  10.39  )
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

From: Cyrille Pitchen <cyrille.pitchen@microchip.com>

This patch configures the QSPI0 controller pin muxing and declares
a jedec,spi-nor memory.

sama5d2 Xplained RevB and RevC use the Macronix MX25L25673G flash
memory which advertises a maximum frequency of 80MHz for Quad IO
Fast Read. Set the spi-max-frequency to 80MHz knowing that actually
the QSPI drver will set the SPI bus clock to 166MHz / 3 = 55.3MHz.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
[tudor.ambarus@microchip.com:
- drop partitions,
- add spi-rx/tx-bus-width
- change spi-max-frequency to match the 80MHz limit advertised by
  MX25L25673G for Quad IO Fast Read,
- reword commit message and subject.]
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 31 +++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 518e2b095ccf..171bc82cfbbf 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -108,6 +108,21 @@
 		};
 
 		apb {
+			qspi0: spi@f0020000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_qspi0_default>;
+				/* status = "okay"; */ /* conflict with sdmmc1 */
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
 			spi0: spi@f8000000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_spi0_default>;
@@ -485,6 +500,22 @@
 					bias-disable;
 				};
 
+				pinctrl_qspi0_default: qspi0_default {
+					sck_cs {
+						pinmux = <PIN_PA22__QSPI0_SCK>,
+							 <PIN_PA23__QSPI0_CS>;
+						bias-disable;
+					};
+
+					data {
+						pinmux = <PIN_PA24__QSPI0_IO0>,
+							 <PIN_PA25__QSPI0_IO1>,
+							 <PIN_PA26__QSPI0_IO2>,
+							 <PIN_PA27__QSPI0_IO3>;
+						bias-pull-up;
+					};
+				};
+
 				pinctrl_sdmmc0_default: sdmmc0_default {
 					cmd_data {
 						pinmux = <PIN_PA1__SDMMC0_CMD>,
-- 
2.9.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
