Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEED4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:08:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 902F22173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HYrOWd6P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cNr51Ekg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902F22173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x4+VQNu3HJJlnS8NGl58SP/QIau66hOFF61NOwQx7r4=; b=HYrOWd6PW4+evD
	SSfw1FjvJSCOwPZP/LusMewLOLbUgxM2olJjWFM3HLaNW66JnInD5K4c8XPheux097ezW+y0IS2pw
	NvhI7BFzDOTVmS8s8njT5y46uUMEi2ZrdU1I1aUxR7K68yjuTzWcBAqcbjDYhhgByXKPrdTuHjctq
	Rhaz9uZNkRxCMvJQL5EMg4Txf6/Athr76WcESzL0bjE/I8T/pwaROWSyHR7fdMCW+RQoVbTiC1ckE
	ZYXJHlbNJ97UBVneP0TTaZxvdC44A7LePJ/YTmXphaVyN4f+OgMU9l/AF62E5wE2fDV143UqaISvY
	g3WFN9ghp055jchBeM8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyWr8-0007s5-70; Tue, 26 Feb 2019 07:08:46 +0000
Received: from mail-eopbgr40080.outbound.protection.outlook.com ([40.107.4.80]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyWqj-0007Lv-9r
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 07:08:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWftcf8SrJsOU5X4AznxrONSgEEntkz25eTzgABEEhY=;
 b=cNr51Ekgs9cN99gwx8ntHm+SVD0M48uwVPRQ+sH+jhNYr7EeTAF3QkCM9HjX57ymq288rYM301WxuEsC8WuX0mL5i/PdnGx338rllT9OY0+jIzvqDGuml8g/7g986EK06fKZVLcR2gVjH+yv13EBGorVtKQ6CL7rZHHWPS+mYig=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3741.eurprd04.prod.outlook.com (52.134.15.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Tue, 26 Feb 2019 07:08:13 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 07:08:13 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: [PATCH v3 2/5] arm64: dts: imx8mq: Add SAI2 node
Thread-Topic: [PATCH v3 2/5] arm64: dts: imx8mq: Add SAI2 node
Thread-Index: AQHUzaIJ1x8W2IPFh0K4Q70rZZrQpg==
Date: Tue, 26 Feb 2019 07:08:13 +0000
Message-ID: <20190226070742.30551-3-daniel.baluta@nxp.com>
References: <20190226070742.30551-1-daniel.baluta@nxp.com>
In-Reply-To: <20190226070742.30551-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0102.eurprd04.prod.outlook.com
 (2603:10a6:803:64::37) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c76fc8ea-20d9-49cf-53fd-08d69bb92c22
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3741; 
x-ms-traffictypediagnostic: VI1PR0402MB3741:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR0402MB3741;
 23:x5uCGz0a7Sekfs2kyaHi8RroeadRoa+y8iv5u?=
 =?iso-8859-1?Q?eI/hLUgentMKCbLv3S1cXWAhR/IHJjvgkttxT6/8h/N953RQTNzmj5oL1i?=
 =?iso-8859-1?Q?T7Rodcyq7V3E8WcZ8D9UDBCnIQSgufgN6vDmfnHUVBigeu5ytJBdV7GIAI?=
 =?iso-8859-1?Q?9EXzZp3lgvY7+O27v76Rsq6LmUR2OOL01PXeJUZp5qlP1Lsi4X8qIGADc8?=
 =?iso-8859-1?Q?fmmnbY2mVC2iW6HHTRLiqi92BSjJlVPHKEwYY8AE5BgaSlkQGXzsq9VLgF?=
 =?iso-8859-1?Q?w7IcHOXS2iCYsP7huiLGlod18HVf1V+lCmugrXUKlqX6CeMA4AfGC9pfNx?=
 =?iso-8859-1?Q?pTmLBbnv+lfXfbNp+YJq9kec+JgDgL1qxP5d9ICgJdR/xurdY4S0J7WToj?=
 =?iso-8859-1?Q?5kuJlSDsRLqO+2ApTc/kMJhmT2LMvKxK6ex5x2ysqI5cUM+BehwAaYT68d?=
 =?iso-8859-1?Q?4GjPvbHGJNEJDZAzZlqVcjzgBWkdzW2c4gKilsKLzqxV8JWfMEAe+T4zHb?=
 =?iso-8859-1?Q?urANpc3XleV0Rw9XaCQWeHoX69Kvn3Jai/XkbXzW/k9/uMGWa2jjgdtG0i?=
 =?iso-8859-1?Q?PwclVhmEANRtUssMb9H+K+XP3q439lDT5NaPulWJccb7UvhER0mPxCoJRG?=
 =?iso-8859-1?Q?HlJg+gUstxDEgWUKcWu0bcMhslIR9plFEpJG/fJEIUGZfVRUeAoNhFv8Tc?=
 =?iso-8859-1?Q?/eUjsTNWNj7UN9G132B44z4eKeXW8uFzN6NA5YDr6Ms8o14GKXPryQqxYa?=
 =?iso-8859-1?Q?0wMqOVGh3lObme98nvi+LdQ/o+iBBXpQlFGASdSfZLvGW7S6o0DrkjTGPR?=
 =?iso-8859-1?Q?b7wHRfnwJPqy3jbURViL8OEKZaPdy3JxHiyXQ8QVdSPTLg4tdATYABogEd?=
 =?iso-8859-1?Q?RYJYEFnq4wCZTGA2uwxQHxYKrK5FeCYuNtcvBjwsHMb/sqMO6uDsSlpuMo?=
 =?iso-8859-1?Q?Ofyt1+c+a8EnojVF/Fflvj2Qi59c/6xtvUdYDZd8slRFdigCdRAkVh0pcX?=
 =?iso-8859-1?Q?9w9WHLt2w4dGCnGbHD4Pyhiz1Uqwp43Y05mkvoaPukhz4KcfAfn7wUIu0v?=
 =?iso-8859-1?Q?qC2KwM3dTM+hDLVlVdVRO2uNtIqQlT1KL0Uf3LXLF5RCJWClQJ/irJvYPg?=
 =?iso-8859-1?Q?vrZRFn/8C+0iq0pHNQmMd9RwnZE2k8LwbB7i2sxGDcErnUYg5favtrlV/g?=
 =?iso-8859-1?Q?/KWuFAwE22PxiGoyHXoeByRqNiZYhzHpdm0C73WFdfF+SQRIQv6bTCMoFC?=
 =?iso-8859-1?Q?CZ6t0WwX1tslsI9jNnbyKuAJ5u5Zs+3Jw5zcdsefU9k+Fxd2uuVDVLMsj8?=
 =?iso-8859-1?Q?cDe7BtumfCO1sgSNMC0LOsnrdNeZN/vXi1DDWrO1ott1RuIsu47v2MQaaq?=
 =?iso-8859-1?Q?RWazPXaoEKcTaxW0+ZKbRiqAA7sbuw6vEfJ5pKie1RH6l+5KsouZ8t/ZJM?=
 =?iso-8859-1?Q?P779yWa9W/to7Ml4=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB374146F3D26F5A4FC29D49C8F97B0@VI1PR0402MB3741.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(366004)(376002)(396003)(136003)(346002)(189003)(199004)(3846002)(6116002)(305945005)(7736002)(6486002)(6436002)(1076003)(2906002)(71200400001)(71190400001)(54906003)(8676002)(1730700003)(50226002)(316002)(8936002)(81156014)(81166006)(6512007)(53936002)(5640700003)(66066001)(478600001)(76176011)(486006)(7416002)(14444005)(68736007)(6916009)(6506007)(5660300002)(2616005)(386003)(11346002)(476003)(2501003)(2351001)(97736004)(36756003)(86362001)(99286004)(4326008)(186003)(106356001)(44832011)(105586002)(26005)(256004)(14454004)(25786009)(52116002)(102836004)(446003)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3741;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NU7Pqo7ywLGWUoFhdKjq9fGZLpFBxBkp9bLb0QHWTuh6F82/zmuhI4Be7wGWWauAeLKsTWHO0O+bVJueiBkp0HZ83Vx8hx/bgRTlmOuVfxBTYmGQkFwxVKbdTLpIcgZ3PVSna31r82nQgGMaOTuYe7Qyvbe3p7tPMA0qAFwxB4+MSwOhP+oV3GXqN70qVLGjSVCDIqWRyU9p4o7Yo3Ke7HxO0SOuDftioQk1VB0u5y6YBYZk5xKHAsNvC82ijnebLDD4V53Kv6N0c693ucZpjM9hwsH7Rhiv5kxOLMKuWL8KkxmK366cD7NFsP4HHTe0Cowzhdyrr2K8eZWL7QH4A66qvbGSeUiLrPxAxY2rROMe8Qf6i6qtKyT7ao1mX4zocOAJ7IoGdX+s5oUz5yMB3VVnG+23jAbDtyH9k4JPk+I=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76fc8ea-20d9-49cf-53fd-08d69bb92c22
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 07:08:12.3400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3741
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_230821_527284_E8EC7E62 
X-CRM114-Status: UNSURE (   9.80  )
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
 "baruch@tkos.co.il" <baruch@tkos.co.il>, Abel Vesa <abel.vesa@nxp.com>,
 "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
 "ccaione@baylibre.com" <ccaione@baylibre.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "angus@akkea.ca" <angus@akkea.ca>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Aisheng Dong <aisheng.dong@nxp.com>, "agx@sigxcpu.org" <agx@sigxcpu.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SAI2 is part of AIPS-3 memory region and it's the DAI through
which the wm8524 codec gets its data.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 8cafec17726b..6fe5798afd2d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -489,6 +489,22 @@
 				status = "disabled";
 			};
 
+			sai2: sai@308b0000 {
+				#sound-dai-cells = <0>;
+				compatible = "fsl,imx8mq-sai",
+					     "fsl,imx6sx-sai";
+				reg = <0x308b0000 0x10000>;
+				interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_SAI2_IPG>,
+					 <&clk IMX8MQ_CLK_DUMMY>,
+					 <&clk IMX8MQ_CLK_SAI2_ROOT>,
+					 <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
+				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+				dmas = <&sdma1 10 24 0>, <&sdma1 11 24 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
 			i2c1: i2c@30a20000 {
 				compatible = "fsl,imx8mq-i2c", "fsl,imx21-i2c";
 				reg = <0x30a20000 0x10000>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
