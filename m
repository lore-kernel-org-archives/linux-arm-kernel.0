Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C270DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:21:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9298921738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LZjzDyR0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z8EOAIb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9298921738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=OsoAT58kU0NkgfGo0yOJJMqJdFRnY/cATmUf1Bu6L2g=; b=LZjzDyR0cRAANc
	RsL8QDK18QN38Pe3JjUNcxSWXbU3mjyN2EfqgMAKJlec9oopSIStSUd47YzbWnUGdwYHtY04YXDsU
	DmiDiGzPUtX4GSIbM9sy452eMau6zl9MMohk6wCgv257HL92OC2HA8nJN0iHQ7XOfWaafdVUsP60C
	VTB3AHk9x90hs6a9ZFocX6Db0VMV98QX0h3AAoupqKfko65iZ+3uTpNUJb3/ILCHMS6uGmxZ5kmKX
	jH1tb8TjWMMie/I5PaKZqfr71AidaFMh2AaJVjrpriYBFFC8XGkWWXiFVP6oqdGaiTNzOSTK7866w
	1OjJv0LRU2+rgRtplxjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvqLZ-00065P-Gl; Mon, 18 Feb 2019 21:21:05 +0000
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvqLV-00064a-Lj
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 21:21:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocVdmxGq+3uMoW82LIAp0u+QNDvIXBxs74LK1gW4RaY=;
 b=Z8EOAIb2M/J2pUTkgbzktr+elR9do7S5DgKWKXUCKogPoAl7Vh1NdbabtY4BPc+P/6n8JibVH6HrkWVuotX9GsQ4nVQGv+6SIQdnD1Mw+95koAZT4OxBhOseHsxS530eOq5jTcRqMInYBgQApG0L7yhqkcb5xf093EYaHGFHHCc=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3616.eurprd04.prod.outlook.com (52.134.7.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 21:20:56 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::2d83:eb90:f977:f649%3]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 21:20:56 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: [PATCH] arm64: dts: imx8mq: Add SDMA nodes
Thread-Topic: [PATCH] arm64: dts: imx8mq: Add SDMA nodes
Thread-Index: AQHUx8/Vo+C+OLGhTkaUZo5T58EuvA==
Date: Mon, 18 Feb 2019 21:20:55 +0000
Message-ID: <20190218212037.902-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0248.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::21) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3566d24-ec47-4201-aea2-08d695e6f827
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3616; 
x-ms-traffictypediagnostic: VI1PR0402MB3616:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR0402MB3616;
 23:R1XvjvE+mu9aWC9n/66B5Zm0TwNN8G9ouW135?=
 =?iso-8859-1?Q?eBCn1TmoO+28E2GOrsbfZTi/CRFLNHh1zfKovzsa0/fZRC15AtLBKb6VXk?=
 =?iso-8859-1?Q?s3dGutjGAc9sbw1rTLEssSIt6Sh2JmrfDXOsHGgFWllk5fzl1C+6ZAsE+Q?=
 =?iso-8859-1?Q?j9VeBApXhQ5xUepiyQ397tSdF6WeTdR7Ov3b3RPruUuHr46BLgzfII6/3O?=
 =?iso-8859-1?Q?YydY+vOKWyUt4mGMApbugXp6hoHVH53fdAyVpgQSIQ9Johzz12qGpPAfCd?=
 =?iso-8859-1?Q?vtWJ63nHQ8Qa+LcdimJmdbsavmc8JCnMEDn136/8HrmC2h2loQHhSjaN9i?=
 =?iso-8859-1?Q?1TIIL+v3/GcdLIWhuA58AwV4p5mrcVvdrmN5jdJe+S/qrB2EScdFQBKDnE?=
 =?iso-8859-1?Q?n3KCifFaWwV3mscgihO3WzabZIzjbExDU7YZHc+Gw+g0OkSKMwob036fsZ?=
 =?iso-8859-1?Q?4OYVs6nreRwIiSc9SpiLMLtG2C2liiUCUD68xEY37sPsGckHuZNL74a2AF?=
 =?iso-8859-1?Q?v4rKRy4lQ0bsrvowr9g7Gg6o12CZOytZspcJvKkB5N+Rz6dGBJlAYoWBpn?=
 =?iso-8859-1?Q?QtsdW8/dNhi/c5+Os64GRed1ZOJ6X7pAfLehXrj8Ir/HTUYIdgSzRpQGi8?=
 =?iso-8859-1?Q?aZvav3UYXvIXutK3G/aFN5gicBW9G4T/FyOk4hY2f3fd+kNWoNVl6ZfQ5Q?=
 =?iso-8859-1?Q?hb68R3THAIa1U0NGXDc7NPJG0W36nfnmMhSQ9PgbdsRBqZrL+w25w9Pq3w?=
 =?iso-8859-1?Q?i+gNMVxpXoiseMsTFeoprK9ATtjuIC0hhybVjMO5bylJuXR5ntt/1VzDWs?=
 =?iso-8859-1?Q?i/1h5Nrz/qjTBdUXoM9GIsJQlyC8J6CizFGSYA6tz5WJtSGe/c89OWxm3u?=
 =?iso-8859-1?Q?l8FBuWeArvMV0+2USyEGlDA8AfxsHEVy/4uTlI8cssHm/6cLTPyqu5KFL6?=
 =?iso-8859-1?Q?/if87+lTrxRo69xVjuMwp2IQkoYp1RsV7lauTLcwWr3tmPcGaILCEkbbTh?=
 =?iso-8859-1?Q?eY6iC3ntClqwGG/vpfgGLvN4SCg9khsejyR2EnIuVpUhdfCxcE2JXKWyIi?=
 =?iso-8859-1?Q?pJ7LGoHqi75uqvx+FRS6P+SP8su8if3hBEsWKIdw1VNGto3S5NV7df2SV7?=
 =?iso-8859-1?Q?FYzRv6QM6qr6KOwdhVVr83F9hQu6dxbohZTJpDynonajZvHVovjp8C4HZ5?=
 =?iso-8859-1?Q?TVrHSTrEy8Ix/j4fZRpQMuWGmLXx8xvoJktKG0UesoQlO/mjMJshyzW4EX?=
 =?iso-8859-1?Q?e40g5YZ652gL9DI6LLQJ99LsD85BHDGqJEbfHjRHVuUwRJPChvB0Fopx2y?=
 =?iso-8859-1?Q?rmkQSH9RwTjG4TkOcnYKwKwrRLHIdwqvUOCqbZp0W/oZW6Q=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB3616077FD7D4F51F869D42E0F9630@VI1PR0402MB3616.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(376002)(396003)(366004)(39860400002)(189003)(199004)(71190400001)(478600001)(2906002)(106356001)(6512007)(25786009)(105586002)(6436002)(6506007)(386003)(53936002)(26005)(3846002)(186003)(476003)(2616005)(14454004)(71200400001)(102836004)(6916009)(4326008)(6116002)(54906003)(6486002)(2351001)(486006)(5640700003)(256004)(305945005)(52116002)(14444005)(1730700003)(7736002)(36756003)(68736007)(81166006)(81156014)(2501003)(50226002)(8676002)(44832011)(5660300002)(66066001)(97736004)(316002)(99286004)(86362001)(1076003)(8936002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3616;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9YuUugVpfHAAGNgOpj8PDxRP0smQ3xBzsrbXbofT/71oWIbaFi9OxZ+rxuIZYzHoSpt2w46/Mor6L+iyOlCB5AYiaDofYC7uCEyOnUU6x7qG3z7KF/xv1A9vvmWueNFbQ6oF8v2F3oXogNhVIlHT03GPKtUgDSnmzggHlIkRR1s7Lv+UVUg0UovzF4wMMZoo9jPr2CdQBdk4pEvJsIV/IPg3uRhN2WDP/IWA+0wlRSZkKr3bwSNs3aDIXiV11RHJ9TbgYRaPQbpr/V4RofotjLeD6IgUJGsk4BolKw1Ur7bFF8hRsyot9hAdQgVe8H/dEbGxi71dq/1L5NlnDksc5Bt61ajjtNRVuogK/n3TilJe68LiQ26TvNfHUvTaysd5N+k0HEBv7NKqb4z6/L59DOU11VxZ2ovJf2plyF2xFeY=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3566d24-ec47-4201-aea2-08d695e6f827
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 21:20:55.2907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3616
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_132101_708309_2681665A 
X-CRM114-Status: UNSURE (   8.96  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Anson Huang <anson.huang@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "S.j. Wang" <shengjiu.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SDMA1 is part of AIPS-3 region and SDMA2 is part
of AIPS-1 region.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
[initial submit in i.MX internal tree]
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
[adaptation for linux-next]
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 9155bd4784eb..9c72e5adef86 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -234,6 +234,18 @@
 				status = "disabled";
 			};
 
+			sdma2: sdma@302c0000 {
+				compatible = "fsl,imx8mq-sdma", "fsl,imx7d-sdma";
+				reg = <0x302c0000 0x10000>;
+				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_SDMA2_ROOT>,
+					 <&clk IMX8MQ_CLK_SDMA2_ROOT>;
+				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
+				status = "disabled";
+			};
+
 			iomuxc: iomuxc@30330000 {
 				compatible = "fsl,imx8mq-iomuxc";
 				reg = <0x30330000 0x10000>;
@@ -575,6 +587,18 @@
 				status = "disabled";
 			};
 
+			sdma1: sdma@30bd0000 {
+				compatible = "fsl,imx8mq-sdma", "fsl,imx7d-sdma";
+				reg = <0x30bd0000 0x10000>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_SDMA1_ROOT>,
+					<&clk IMX8MQ_CLK_SDMA1_ROOT>;
+				clock-names = "ipg", "ahb";
+				#dma-cells = <3>;
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
+				status = "disabled";
+			};
+
 			fec1: ethernet@30be0000 {
 				compatible = "fsl,imx8mq-fec", "fsl,imx6sx-fec";
 				reg = <0x30be0000 0x10000>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
