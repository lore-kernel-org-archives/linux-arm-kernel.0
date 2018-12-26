Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B739C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:17:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496C92087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W0yvFJL6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZvuVzA3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496C92087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=azDvrVJddb5MHyo3p2YfFML1MxflaT+qc5cpg151SXQ=; b=W0yvFJL6JQwkhS
	AjUusHBpqkTi0W5rO9qm65FeSycon3lhOpu6jPa9dgPv9XStbSb2MbxMz+SHbD0738uK1rh5sCjr3
	xqROiWu4fz7FiDQxCKWRjB0ho7pHMGJn0OYNcUhnJNBDy+gbQU3E09/8jWMWqrEqzzM1wGpmfHDD5
	CMWfNxrlWFJnE86FGc2/RQz3EpUFCjbV5/9i8BuV0Jivn86zI5nSfrn/hl4EOA4RlNJYwhlyT8a5W
	HbxCwbm7ftsIk+Hq98ziNGsdk/aiVdjOwkZr7oR+LbvY0B9TXPuPRR9dbWtBuJz8vsNzdUkpkb5hR
	L2oBT5UXYlVGMos3X6VQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcCo3-00060Z-HR; Wed, 26 Dec 2018 17:17:19 +0000
Received: from mail-ve1eur02on0605.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::605]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcCnw-0005zQ-Fv
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 17:17:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYYH8B6K5T/5/5+W0ipzk3429wQwD5EmNA42+4V7jjw=;
 b=ZvuVzA3cODTzu4Pho5oWjzDK6FBGVaEzT7aJFPHOXRC45iIzofIECFK3ngr7+o2Vp0uSwNbId4B/PUsyM6Uz756i5LrvdF+RRPJSzni5Wa1ITW6/JMOtyowDp3a45MzMG8zoP2Z6awTVptLBoa9QpRH1GNbJq2yVdIQeCKULsCU=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4420.eurprd04.prod.outlook.com (52.135.148.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Wed, 26 Dec 2018 17:16:53 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%7]) with mapi id 15.20.1446.027; Wed, 26 Dec 2018
 17:16:53 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>
Subject: RE: [PATCH 1/2] dt-bindings: arm: fsl-scu: add imx8qm pinctrl support
Thread-Topic: [PATCH 1/2] dt-bindings: arm: fsl-scu: add imx8qm pinctrl support
Thread-Index: AQHUluWMylPswmd+mkW+sLQSPRoGM6WRS2oA
Date: Wed, 26 Dec 2018 17:16:53 +0000
Message-ID: <AM0PR04MB421156FD02FF6853707049CC80B50@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1545146239-30993-1-git-send-email-aisheng.dong@nxp.com>
 <1545146239-30993-2-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1545146239-30993-2-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4420;
 6:CFmW1n3DfiDvPGEwqPZjcPR0dOhR28MAFGrmzef5lD+T016jIizs8998lvescNrev4TXEqux/0PX165cUmegTge5m6XY7GzVGdRf28nXA2YZGAyNgHJa2xf1SGZy2Drr95399qdbsnup9FQteF3SRjopD5fMF0KIa+FDXF7E62lbT73vnLFVv5uOHGNcMekbLSZhinUd0MUaNPtWzcl06Bh810byyuWoBg4ZYKwpOSbjMb7m3vy8eIYwmg3of3NCTSGiQcSLquw0eRM7yd/BY2kd61FlAToeEbeRQH3oltTYUnTG1UXExFDXOU6C8REJgA3UnXplIxXDPeGB0kHzdkx8EOGxpe9LXyOCmlFbW/IkG5NiAeqaQUvSeXURsfiXD4H8OKNuCVuztoI7AhOTkliPfhSfphBYculjTBq8/tApTNW+VueckruP11UI0DccBRFlX1b3AHg/I/+i4hw1QA==;
 5:DxjhKxrQjiaG0KRnbmk8F3x8R/0Q/I6DY/ncCZYzMh3KvMkZrOSNtRq+F2mZ7d19A+1oT4QmbbTddQhbXVkTDtsO7AVWYC7XNDDWGejzomeIUaEpqkDqJqchwpcunujs9Q4O+sdg2C3MGc+62iw/zUxBFFHsI0EJlb338Ip6VaY=;
 7:/jqpR0DCot9H5ukuDd1JH3eHGm6tY1bn2vldl1i/iH6G3o2xFDrrWgr5OJ22m1k2OkXroscj31ySHQGPkbJVJGbY+Q+pDwGtCbNR+dt1cNY1caYzj4UvYA1QAFTq9uiUXxpa0SE7YzXdF+dLam+TYg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cf59be14-bf37-40e5-d9b2-08d66b55ee3c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4420; 
x-ms-traffictypediagnostic: AM0PR04MB4420:
x-microsoft-antispam-prvs: <AM0PR04MB4420BE5AF711836CBADEB29580B50@AM0PR04MB4420.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4420; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4420; 
x-forefront-prvs: 0898A6E028
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(396003)(136003)(366004)(346002)(52314003)(199004)(189003)(186003)(6436002)(26005)(76176011)(105586002)(316002)(5660300001)(14444005)(256004)(54906003)(110136005)(53936002)(6246003)(39060400002)(68736007)(106356001)(53946003)(4326008)(74316002)(2501003)(55016002)(7696005)(25786009)(33656002)(7416002)(102836004)(8936002)(6506007)(14454004)(66066001)(4744004)(99286004)(476003)(71190400001)(97736004)(229853002)(81156014)(8676002)(9686003)(2906002)(86362001)(305945005)(11346002)(44832011)(486006)(81166006)(7736002)(71200400001)(575784001)(6116002)(3846002)(478600001)(446003)(32563001)(569006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4420;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r3ieur6a8pbpraj7bCIVVMbfCcWZgnPfLIv3ZD1bZKGlZqkY8fK1A9OpABV/xlNT2WxvRksI5+LGHsd2X6dqbQzyiNyUXrWeFjLJsrcWLlINd2T/+xcwRmrExlMuB0kene2tlRdyQTiRRv8MIbF1zqsTyvcSO911zKzXenDyLajPvQ34nCQAX/hBmVOqFJqFUkGLLuNPDjEZOaCgpsAiRtVCUIc+rxwcgm7lr+xQXL9I0xq73CPUw2NnW/UW6kbl80xu17ctgtNCtcJBe48EbUhcyJdv+7odJ3tBr957zfe9sYcWgiGuyfwMNaayfSqz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf59be14-bf37-40e5-d9b2-08d66b55ee3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2018 17:16:53.1540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4420
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_091713_532064_9D57E113 
X-CRM114-Status: GOOD (  22.80  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "stefan@agner.ch" <stefan@agner.ch>, Rob Herring <robh+dt@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Linus,

Do you think if we have a chance for this one only to catch up 4.21-rc1?
As it includes only binding doc and headfile which will be used by the DTS,
so it will be a big help for the following DTS patches to go through SoC maintainer
tree conveniently after 4.21-rc1 is out.

Anyway, it's also fine if we missed it already.

Regards
Dong Aisheng

> From: Aisheng Dong
> Sent: Tuesday, December 18, 2018 11:23 PM
[...]
> Update binding doc to support imx8qm pinctrl.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt  |   5 +-
>  include/dt-bindings/pinctrl/pads-imx8qm.h          | 960
> +++++++++++++++++++++
>  2 files changed, 964 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/pinctrl/pads-imx8qm.h
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index 46d0af1..831d5df 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -96,13 +96,16 @@ Pinctrl bindings based on SCU Message Protocol
>  This binding uses the i.MX common pinctrl binding[3].
> 
>  Required properties:
> -- compatible:		Should be "fsl,imx8qxp-iomuxc".
> +- compatible:		Should be one of:
> +			"fsl,imx8qm-iomuxc",
> +			"fsl,imx8qxp-iomuxc".
> 
>  Required properties for Pinctrl sub nodes:
>  - fsl,pins:		Each entry consists of 3 integers which represents
>  			the mux and config setting for one pin. The first 2
>  			integers <pin_id mux_mode> are specified using a
>  			PIN_FUNC_ID macro, which can be found in
> +			<dt-bindings/pinctrl/pads-imx8qm.h>,
>  			<dt-bindings/pinctrl/pads-imx8qxp.h>.
>  			The last integer CONFIG is the pad setting value like
>  			pull-up on this pin.
> diff --git a/include/dt-bindings/pinctrl/pads-imx8qm.h
> b/include/dt-bindings/pinctrl/pads-imx8qm.h
> new file mode 100644
> index 0000000..ae7b294
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/pads-imx8qm.h
> @@ -0,0 +1,960 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Copyright 2017~2018 NXP
> + */
> +
> +#ifndef _IMX8QM_PADS_H
> +#define _IMX8QM_PADS_H
> +
> +/* pin id */
> +#define IMX8QM_SIM0_CLK					0
> +#define IMX8QM_SIM0_RST					1
> +#define IMX8QM_SIM0_IO					2
> +#define IMX8QM_SIM0_PD					3
> +#define IMX8QM_SIM0_POWER_EN				4
> +#define IMX8QM_SIM0_GPIO0_00				5
> +#define IMX8QM_COMP_CTL_GPIO_1V8_3V3_SIM		6
> +#define IMX8QM_M40_I2C0_SCL				7
> +#define IMX8QM_M40_I2C0_SDA				8
> +#define IMX8QM_M40_GPIO0_00				9
> +#define IMX8QM_M40_GPIO0_01				10
> +#define IMX8QM_M41_I2C0_SCL				11
> +#define IMX8QM_M41_I2C0_SDA				12
> +#define IMX8QM_M41_GPIO0_00				13
> +#define IMX8QM_M41_GPIO0_01				14
> +#define IMX8QM_GPT0_CLK					15
> +#define IMX8QM_GPT0_CAPTURE				16
> +#define IMX8QM_GPT0_COMPARE				17
> +#define IMX8QM_GPT1_CLK					18
> +#define IMX8QM_GPT1_CAPTURE				19
> +#define IMX8QM_GPT1_COMPARE				20
> +#define IMX8QM_UART0_RX					21
> +#define IMX8QM_UART0_TX					22
> +#define IMX8QM_UART0_RTS_B				23
> +#define IMX8QM_UART0_CTS_B				24
> +#define IMX8QM_UART1_TX					25
> +#define IMX8QM_UART1_RX					26
> +#define IMX8QM_UART1_RTS_B				27
> +#define IMX8QM_UART1_CTS_B				28
> +#define IMX8QM_COMP_CTL_GPIO_1V8_3V3_GPIOLH		29
> +#define IMX8QM_SCU_PMIC_MEMC_ON				30
> +#define IMX8QM_SCU_WDOG_OUT				31
> +#define IMX8QM_PMIC_I2C_SDA				32
> +#define IMX8QM_PMIC_I2C_SCL				33
> +#define IMX8QM_PMIC_EARLY_WARNING			34
> +#define IMX8QM_PMIC_INT_B				35
> +#define IMX8QM_SCU_GPIO0_00				36
> +#define IMX8QM_SCU_GPIO0_01				37
> +#define IMX8QM_SCU_GPIO0_02				38
> +#define IMX8QM_SCU_GPIO0_03				39
> +#define IMX8QM_SCU_GPIO0_04				40
> +#define IMX8QM_SCU_GPIO0_05				41
> +#define IMX8QM_SCU_GPIO0_06				42
> +#define IMX8QM_SCU_GPIO0_07				43
> +#define IMX8QM_SCU_BOOT_MODE0				44
> +#define IMX8QM_SCU_BOOT_MODE1				45
> +#define IMX8QM_SCU_BOOT_MODE2				46
> +#define IMX8QM_SCU_BOOT_MODE3				47
> +#define IMX8QM_SCU_BOOT_MODE4				48
> +#define IMX8QM_SCU_BOOT_MODE5				49
> +#define IMX8QM_LVDS0_GPIO00				50
> +#define IMX8QM_LVDS0_GPIO01				51
> +#define IMX8QM_LVDS0_I2C0_SCL				52
> +#define IMX8QM_LVDS0_I2C0_SDA				53
> +#define IMX8QM_LVDS0_I2C1_SCL				54
> +#define IMX8QM_LVDS0_I2C1_SDA				55
> +#define IMX8QM_LVDS1_GPIO00				56
> +#define IMX8QM_LVDS1_GPIO01				57
> +#define IMX8QM_LVDS1_I2C0_SCL				58
> +#define IMX8QM_LVDS1_I2C0_SDA				59
> +#define IMX8QM_LVDS1_I2C1_SCL				60
> +#define IMX8QM_LVDS1_I2C1_SDA				61
> +#define IMX8QM_COMP_CTL_GPIO_1V8_3V3_LVDSGPIO		62
> +#define IMX8QM_MIPI_DSI0_I2C0_SCL			63
> +#define IMX8QM_MIPI_DSI0_I2C0_SDA			64
> +#define IMX8QM_MIPI_DSI0_GPIO0_00			65
> +#define IMX8QM_MIPI_DSI0_GPIO0_01			66
> +#define IMX8QM_MIPI_DSI1_I2C0_SCL			67
> +#define IMX8QM_MIPI_DSI1_I2C0_SDA			68
> +#define IMX8QM_MIPI_DSI1_GPIO0_00			69
> +#define IMX8QM_MIPI_DSI1_GPIO0_01			70
> +#define IMX8QM_COMP_CTL_GPIO_1V8_3V3_MIPIDSIGPIO	71
> +#define IMX8QM_MIPI_CSI0_MCLK_OUT			72
> +#define IMX8QM_MIPI_CSI0_I2C0_SCL			73
> +#define IMX8QM_MIPI_CSI0_I2C0_SDA			74
> +#define IMX8QM_MIPI_CSI0_GPIO0_00			75
> +#define IMX8QM_MIPI_CSI0_GPIO0_01			76
> +#define IMX8QM_MIPI_CSI1_MCLK_OUT			77
> +#define IMX8QM_MIPI_CSI1_GPIO0_00			78
> +#define IMX8QM_MIPI_CSI1_GPIO0_01			79
> +#define IMX8QM_MIPI_CSI1_I2C0_SCL			80
> +#define IMX8QM_MIPI_CSI1_I2C0_SDA			81
> +#define IMX8QM_HDMI_TX0_TS_SCL				82
> +#define IMX8QM_HDMI_TX0_TS_SDA				83
> +#define IMX8QM_COMP_CTL_GPIO_3V3_HDMIGPIO		84
> +#define IMX8QM_ESAI1_FSR				85
> +#define IMX8QM_ESAI1_FST				86
> +#define IMX8QM_ESAI1_SCKR				87
> +#define IMX8QM_ESAI1_SCKT				88
> +#define IMX8QM_ESAI1_TX0				89
> +#define IMX8QM_ESAI1_TX1				90
> +#define IMX8QM_ESAI1_TX2_RX3				91
> +#define IMX8QM_ESAI1_TX3_RX2				92
> +#define IMX8QM_ESAI1_TX4_RX1				93
> +#define IMX8QM_ESAI1_TX5_RX0				94
> +#define IMX8QM_SPDIF0_RX				95
> +#define IMX8QM_SPDIF0_TX				96
> +#define IMX8QM_SPDIF0_EXT_CLK				97
> +#define IMX8QM_SPI3_SCK					98
> +#define IMX8QM_SPI3_SDO					99
> +#define IMX8QM_SPI3_SDI					100
> +#define IMX8QM_SPI3_CS0					101
> +#define IMX8QM_SPI3_CS1					102
> +#define IMX8QM_COMP_CTL_GPIO_1V8_3V3_GPIORHB		103
> +#define IMX8QM_ESAI0_FSR				104
> +#define IMX8QM_ESAI0_FST				105
> +#define IMX8QM_ESAI0_SCKR				106
> +#define IMX8QM_ESAI0_SCKT				107
> +#define IMX8QM_ESAI0_TX0				108
> +#define IMX8QM_ESAI0_TX1				109
> +#define IMX8QM_ESAI0_TX2_RX3				110
> +#define IMX8QM_ESAI0_TX3_RX2				111
> +#define IMX8QM_ESAI0_TX4_RX1				112
> +#define IMX8QM_ESAI0_TX5_RX0				113
> +#define IMX8QM_MCLK_IN0					114
> +#define IMX8QM_MCLK_OUT0				115
> +#define IMX8QM_COMP_CTL_GPIO_1V8_3V3_GPIORHC		116
> +#define IMX8QM_SPI0_SCK					117
> +#define IMX8QM_SPI0_SDO					118
> +#define IMX8QM_SPI0_SDI					119
> +#define IMX8QM_SPI0_CS0					120
> +#define IMX8QM_SPI0_CS1					121
> +#define IMX8QM_SPI2_SCK					122
> +#define IMX8QM_SPI2_SDO					123
> +#define IMX8QM_SPI2_SDI					124
> +#define IMX8QM_SPI2_CS0					125
> +#define IMX8QM_SPI2_CS1					126
> +#define IMX8QM_SAI1_RXC					127
> +#define IMX8QM_SAI1_RXD					128
> +#define IMX8QM_SAI1_RXFS				129
> +#define IMX8QM_SAI1_TXC					130
> +#define IMX8QM_SAI1_TXD					131
> +#define IMX8QM_SAI1_TXFS				132
> +#define IMX8QM_COMP_CTL_GPIO_1V8_3V3_GPIORHT		133
> +#define IMX8QM_ADC_IN7					134
> +#define IMX8QM_ADC_IN6					135
> +#define IMX8QM_ADC_IN5					136
> +#define IMX8QM_ADC_IN4					137
> +#define IMX8QM_ADC_IN3					138
> +#define IMX8QM_ADC_IN2					139
> +#define IMX8QM_ADC_IN1					140
> +#define IMX8QM_ADC_IN0					141
> +#define IMX8QM_MLB_SIG					142
> +#define IMX8QM_MLB_CLK					143
> +#define IMX8QM_MLB_DATA					144
> +#define IMX8QM_COMP_CTL_GPIO_1V8_3V3_GPIOLHT		145
> +#define IMX8QM_FLEXCAN0_RX				146
> +#define IMX8QM_FLEXCAN0_TX				147
> +#define IMX8QM_FLEXCAN1_RX				148
> +#define IMX8QM_FLEXCAN1_TX				149
> +#define IMX8QM_FLEXCAN2_RX				150
> +#define IMX8QM_FLEXCAN2_TX				151
> +#define IMX8QM_COMP_CTL_GPIO_1V8_3V3_GPIOTHR		152
> +#define IMX8QM_USB_SS3_TC0				153
> +#define IMX8QM_USB_SS3_TC1				154
> +#define IMX8QM_USB_SS3_TC2				155
> +#define IMX8QM_USB_SS3_TC3				156
> +#define IMX8QM_COMP_CTL_GPIO_3V3_USB3IO			157
> +#define IMX8QM_USDHC1_RESET_B				158
> +#define IMX8QM_USDHC1_VSELECT				159
> +#define IMX8QM_USDHC2_RESET_B				160
> +#define IMX8QM_USDHC2_VSELECT				161
> +#define IMX8QM_USDHC2_WP				162
> +#define IMX8QM_USDHC2_CD_B				163
> +#define IMX8QM_COMP_CTL_GPIO_1V8_3V3_VSELSEP		164
> +#define IMX8QM_ENET0_MDIO				165
> +#define IMX8QM_ENET0_MDC				166
> +#define IMX8QM_ENET0_REFCLK_125M_25M			167
> +#define IMX8QM_ENET1_REFCLK_125M_25M			168
> +#define IMX8QM_ENET1_MDIO				169
> +#define IMX8QM_ENET1_MDC				170
> +#define IMX8QM_COMP_CTL_GPIO_1V8_3V3_GPIOCT		171
> +#define IMX8QM_QSPI1A_SS0_B				172
> +#define IMX8QM_QSPI1A_SS1_B				173
> +#define IMX8QM_QSPI1A_SCLK				174
> +#define IMX8QM_QSPI1A_DQS				175
> +#define IMX8QM_QSPI1A_DATA3				176
> +#define IMX8QM_QSPI1A_DATA2				177
> +#define IMX8QM_QSPI1A_DATA1				178
> +#define IMX8QM_QSPI1A_DATA0				179
> +#define IMX8QM_COMP_CTL_GPIO_1V8_3V3_QSPI1		180
> +#define IMX8QM_QSPI0A_DATA0				181
> +#define IMX8QM_QSPI0A_DATA1				182
> +#define IMX8QM_QSPI0A_DATA2				183
> +#define IMX8QM_QSPI0A_DATA3				184
> +#define IMX8QM_QSPI0A_DQS				185
> +#define IMX8QM_QSPI0A_SS0_B				186
> +#define IMX8QM_QSPI0A_SS1_B				187
> +#define IMX8QM_QSPI0A_SCLK				188
> +#define IMX8QM_QSPI0B_SCLK				189
> +#define IMX8QM_QSPI0B_DATA0				190
> +#define IMX8QM_QSPI0B_DATA1				191
> +#define IMX8QM_QSPI0B_DATA2				192
> +#define IMX8QM_QSPI0B_DATA3				193
> +#define IMX8QM_QSPI0B_DQS				194
> +#define IMX8QM_QSPI0B_SS0_B				195
> +#define IMX8QM_QSPI0B_SS1_B				196
> +#define IMX8QM_COMP_CTL_GPIO_1V8_3V3_QSPI0		197
> +#define IMX8QM_PCIE_CTRL0_CLKREQ_B			198
> +#define IMX8QM_PCIE_CTRL0_WAKE_B			199
> +#define IMX8QM_PCIE_CTRL0_PERST_B			200
> +#define IMX8QM_PCIE_CTRL1_CLKREQ_B			201
> +#define IMX8QM_PCIE_CTRL1_WAKE_B			202
> +#define IMX8QM_PCIE_CTRL1_PERST_B			203
> +#define IMX8QM_COMP_CTL_GPIO_1V8_3V3_PCIESEP		204
> +#define IMX8QM_USB_HSIC0_DATA				205
> +#define IMX8QM_USB_HSIC0_STROBE				206
> +#define IMX8QM_CALIBRATION_0_HSIC			207
> +#define IMX8QM_CALIBRATION_1_HSIC			208
> +#define IMX8QM_EMMC0_CLK				209
> +#define IMX8QM_EMMC0_CMD				210
> +#define IMX8QM_EMMC0_DATA0				211
> +#define IMX8QM_EMMC0_DATA1				212
> +#define IMX8QM_EMMC0_DATA2				213
> +#define IMX8QM_EMMC0_DATA3				214
> +#define IMX8QM_EMMC0_DATA4				215
> +#define IMX8QM_EMMC0_DATA5				216
> +#define IMX8QM_EMMC0_DATA6				217
> +#define IMX8QM_EMMC0_DATA7				218
> +#define IMX8QM_EMMC0_STROBE				219
> +#define IMX8QM_EMMC0_RESET_B				220
> +#define IMX8QM_COMP_CTL_GPIO_1V8_3V3_SD1FIX		221
> +#define IMX8QM_USDHC1_CLK				222
> +#define IMX8QM_USDHC1_CMD				223
> +#define IMX8QM_USDHC1_DATA0				224
> +#define IMX8QM_USDHC1_DATA1				225
> +#define IMX8QM_CTL_NAND_RE_P_N				226
> +#define IMX8QM_USDHC1_DATA2				227
> +#define IMX8QM_USDHC1_DATA3				228
> +#define IMX8QM_CTL_NAND_DQS_P_N				229
> +#define IMX8QM_USDHC1_DATA4				230
> +#define IMX8QM_USDHC1_DATA5				231
> +#define IMX8QM_USDHC1_DATA6				232
> +#define IMX8QM_USDHC1_DATA7				233
> +#define IMX8QM_USDHC1_STROBE				234
> +#define IMX8QM_COMP_CTL_GPIO_1V8_3V3_VSEL2		235
> +#define IMX8QM_USDHC2_CLK				236
> +#define IMX8QM_USDHC2_CMD				237
> +#define IMX8QM_USDHC2_DATA0				238
> +#define IMX8QM_USDHC2_DATA1				239
> +#define IMX8QM_USDHC2_DATA2				240
> +#define IMX8QM_USDHC2_DATA3				241
> +#define IMX8QM_COMP_CTL_GPIO_1V8_3V3_VSEL3		242
> +#define IMX8QM_ENET0_RGMII_TXC				243
> +#define IMX8QM_ENET0_RGMII_TX_CTL			244
> +#define IMX8QM_ENET0_RGMII_TXD0				245
> +#define IMX8QM_ENET0_RGMII_TXD1				246
> +#define IMX8QM_ENET0_RGMII_TXD2				247
> +#define IMX8QM_ENET0_RGMII_TXD3				248
> +#define IMX8QM_ENET0_RGMII_RXC				249
> +#define IMX8QM_ENET0_RGMII_RX_CTL			250
> +#define IMX8QM_ENET0_RGMII_RXD0				251
> +#define IMX8QM_ENET0_RGMII_RXD1				252
> +#define IMX8QM_ENET0_RGMII_RXD2				253
> +#define IMX8QM_ENET0_RGMII_RXD3				254
> +#define IMX8QM_COMP_CTL_GPIO_1V8_3V3_ENET_ENETB		255
> +#define IMX8QM_ENET1_RGMII_TXC				256
> +#define IMX8QM_ENET1_RGMII_TX_CTL			257
> +#define IMX8QM_ENET1_RGMII_TXD0				258
> +#define IMX8QM_ENET1_RGMII_TXD1				259
> +#define IMX8QM_ENET1_RGMII_TXD2				260
> +#define IMX8QM_ENET1_RGMII_TXD3				261
> +#define IMX8QM_ENET1_RGMII_RXC				262
> +#define IMX8QM_ENET1_RGMII_RX_CTL			263
> +#define IMX8QM_ENET1_RGMII_RXD0				264
> +#define IMX8QM_ENET1_RGMII_RXD1				265
> +#define IMX8QM_ENET1_RGMII_RXD2				266
> +#define IMX8QM_ENET1_RGMII_RXD3				267
> +#define IMX8QM_COMP_CTL_GPIO_1V8_3V3_ENET_ENETA		268
> +
> +/*
> + * format: <pin_id mux_mode>
> + */
> +#define IMX8QM_SIM0_CLK_DMA_SIM0_CLK
> 	IMX8QM_SIM0_CLK			0
> +#define IMX8QM_SIM0_CLK_LSIO_GPIO0_IO00
> 	IMX8QM_SIM0_CLK			3
> +#define IMX8QM_SIM0_RST_DMA_SIM0_RST
> 	IMX8QM_SIM0_RST			0
> +#define IMX8QM_SIM0_RST_LSIO_GPIO0_IO01
> 	IMX8QM_SIM0_RST			3
> +#define IMX8QM_SIM0_IO_DMA_SIM0_IO				IMX8QM_SIM0_IO
> 		0
> +#define IMX8QM_SIM0_IO_LSIO_GPIO0_IO02
> 	IMX8QM_SIM0_IO			3
> +#define IMX8QM_SIM0_PD_DMA_SIM0_PD
> 	IMX8QM_SIM0_PD			0
> +#define IMX8QM_SIM0_PD_DMA_I2C3_SCL
> 	IMX8QM_SIM0_PD			1
> +#define IMX8QM_SIM0_PD_LSIO_GPIO0_IO03
> 	IMX8QM_SIM0_PD			3
> +#define IMX8QM_SIM0_POWER_EN_DMA_SIM0_POWER_EN
> 	IMX8QM_SIM0_POWER_EN		0
> +#define IMX8QM_SIM0_POWER_EN_DMA_I2C3_SDA
> 	IMX8QM_SIM0_POWER_EN		1
> +#define IMX8QM_SIM0_POWER_EN_LSIO_GPIO0_IO04
> 	IMX8QM_SIM0_POWER_EN		3
> +#define IMX8QM_SIM0_GPIO0_00_DMA_SIM0_POWER_EN
> 	IMX8QM_SIM0_GPIO0_00		0
> +#define IMX8QM_SIM0_GPIO0_00_LSIO_GPIO0_IO05
> 	IMX8QM_SIM0_GPIO0_00		3
> +#define IMX8QM_M40_I2C0_SCL_M40_I2C0_SCL
> 	IMX8QM_M40_I2C0_SCL		0
> +#define IMX8QM_M40_I2C0_SCL_M40_UART0_RX
> 	IMX8QM_M40_I2C0_SCL		1
> +#define IMX8QM_M40_I2C0_SCL_M40_GPIO0_IO02
> 	IMX8QM_M40_I2C0_SCL		2
> +#define IMX8QM_M40_I2C0_SCL_LSIO_GPIO0_IO06
> 	IMX8QM_M40_I2C0_SCL		3
> +#define IMX8QM_M40_I2C0_SDA_M40_I2C0_SDA
> 	IMX8QM_M40_I2C0_SDA		0
> +#define IMX8QM_M40_I2C0_SDA_M40_UART0_TX
> 	IMX8QM_M40_I2C0_SDA		1
> +#define IMX8QM_M40_I2C0_SDA_M40_GPIO0_IO03
> 	IMX8QM_M40_I2C0_SDA		2
> +#define IMX8QM_M40_I2C0_SDA_LSIO_GPIO0_IO07
> 	IMX8QM_M40_I2C0_SDA		3
> +#define IMX8QM_M40_GPIO0_00_M40_GPIO0_IO00
> 	IMX8QM_M40_GPIO0_00		0
> +#define IMX8QM_M40_GPIO0_00_M40_TPM0_CH0
> 	IMX8QM_M40_GPIO0_00		1
> +#define IMX8QM_M40_GPIO0_00_DMA_UART4_RX
> 	IMX8QM_M40_GPIO0_00		2
> +#define IMX8QM_M40_GPIO0_00_LSIO_GPIO0_IO08
> 	IMX8QM_M40_GPIO0_00		3
> +#define IMX8QM_M40_GPIO0_01_M40_GPIO0_IO01
> 	IMX8QM_M40_GPIO0_01		0
> +#define IMX8QM_M40_GPIO0_01_M40_TPM0_CH1
> 	IMX8QM_M40_GPIO0_01		1
> +#define IMX8QM_M40_GPIO0_01_DMA_UART4_TX
> 	IMX8QM_M40_GPIO0_01		2
> +#define IMX8QM_M40_GPIO0_01_LSIO_GPIO0_IO09
> 	IMX8QM_M40_GPIO0_01		3
> +#define IMX8QM_M41_I2C0_SCL_M41_I2C0_SCL
> 	IMX8QM_M41_I2C0_SCL		0
> +#define IMX8QM_M41_I2C0_SCL_M41_UART0_RX
> 	IMX8QM_M41_I2C0_SCL		1
> +#define IMX8QM_M41_I2C0_SCL_M41_GPIO0_IO02
> 	IMX8QM_M41_I2C0_SCL		2
> +#define IMX8QM_M41_I2C0_SCL_LSIO_GPIO0_IO10
> 	IMX8QM_M41_I2C0_SCL		3
> +#define IMX8QM_M41_I2C0_SDA_M41_I2C0_SDA
> 	IMX8QM_M41_I2C0_SDA		0
> +#define IMX8QM_M41_I2C0_SDA_M41_UART0_TX
> 	IMX8QM_M41_I2C0_SDA		1
> +#define IMX8QM_M41_I2C0_SDA_M41_GPIO0_IO03
> 	IMX8QM_M41_I2C0_SDA		2
> +#define IMX8QM_M41_I2C0_SDA_LSIO_GPIO0_IO11
> 	IMX8QM_M41_I2C0_SDA		3
> +#define IMX8QM_M41_GPIO0_00_M41_GPIO0_IO00
> 	IMX8QM_M41_GPIO0_00		0
> +#define IMX8QM_M41_GPIO0_00_M41_TPM0_CH0
> 	IMX8QM_M41_GPIO0_00		1
> +#define IMX8QM_M41_GPIO0_00_DMA_UART3_RX
> 	IMX8QM_M41_GPIO0_00		2
> +#define IMX8QM_M41_GPIO0_00_LSIO_GPIO0_IO12
> 	IMX8QM_M41_GPIO0_00		3
> +#define IMX8QM_M41_GPIO0_01_M41_GPIO0_IO01
> 	IMX8QM_M41_GPIO0_01		0
> +#define IMX8QM_M41_GPIO0_01_M41_TPM0_CH1
> 	IMX8QM_M41_GPIO0_01		1
> +#define IMX8QM_M41_GPIO0_01_DMA_UART3_TX
> 	IMX8QM_M41_GPIO0_01		2
> +#define IMX8QM_M41_GPIO0_01_LSIO_GPIO0_IO13
> 	IMX8QM_M41_GPIO0_01		3
> +#define IMX8QM_GPT0_CLK_LSIO_GPT0_CLK
> 	IMX8QM_GPT0_CLK			0
> +#define IMX8QM_GPT0_CLK_DMA_I2C1_SCL
> 	IMX8QM_GPT0_CLK			1
> +#define IMX8QM_GPT0_CLK_LSIO_KPP0_COL4
> 	IMX8QM_GPT0_CLK			2
> +#define IMX8QM_GPT0_CLK_LSIO_GPIO0_IO14
> 	IMX8QM_GPT0_CLK			3
> +#define IMX8QM_GPT0_CAPTURE_LSIO_GPT0_CAPTURE
> 	IMX8QM_GPT0_CAPTURE		0
> +#define IMX8QM_GPT0_CAPTURE_DMA_I2C1_SDA
> 	IMX8QM_GPT0_CAPTURE		1
> +#define IMX8QM_GPT0_CAPTURE_LSIO_KPP0_COL5
> 	IMX8QM_GPT0_CAPTURE		2
> +#define IMX8QM_GPT0_CAPTURE_LSIO_GPIO0_IO15
> 	IMX8QM_GPT0_CAPTURE		3
> +#define IMX8QM_GPT0_COMPARE_LSIO_GPT0_COMPARE
> 	IMX8QM_GPT0_COMPARE		0
> +#define IMX8QM_GPT0_COMPARE_LSIO_PWM3_OUT
> 	IMX8QM_GPT0_COMPARE		1
> +#define IMX8QM_GPT0_COMPARE_LSIO_KPP0_COL6
> 	IMX8QM_GPT0_COMPARE		2
> +#define IMX8QM_GPT0_COMPARE_LSIO_GPIO0_IO16
> 	IMX8QM_GPT0_COMPARE		3
> +#define IMX8QM_GPT1_CLK_LSIO_GPT1_CLK
> 	IMX8QM_GPT1_CLK			0
> +#define IMX8QM_GPT1_CLK_DMA_I2C2_SCL
> 	IMX8QM_GPT1_CLK			1
> +#define IMX8QM_GPT1_CLK_LSIO_KPP0_COL7
> 	IMX8QM_GPT1_CLK			2
> +#define IMX8QM_GPT1_CLK_LSIO_GPIO0_IO17
> 	IMX8QM_GPT1_CLK			3
> +#define IMX8QM_GPT1_CAPTURE_LSIO_GPT1_CAPTURE
> 	IMX8QM_GPT1_CAPTURE		0
> +#define IMX8QM_GPT1_CAPTURE_DMA_I2C2_SDA
> 	IMX8QM_GPT1_CAPTURE		1
> +#define IMX8QM_GPT1_CAPTURE_LSIO_KPP0_ROW4
> 	IMX8QM_GPT1_CAPTURE		2
> +#define IMX8QM_GPT1_CAPTURE_LSIO_GPIO0_IO18
> 	IMX8QM_GPT1_CAPTURE		3
> +#define IMX8QM_GPT1_COMPARE_LSIO_GPT1_COMPARE
> 	IMX8QM_GPT1_COMPARE		0
> +#define IMX8QM_GPT1_COMPARE_LSIO_PWM2_OUT
> 	IMX8QM_GPT1_COMPARE		1
> +#define IMX8QM_GPT1_COMPARE_LSIO_KPP0_ROW5
> 	IMX8QM_GPT1_COMPARE		2
> +#define IMX8QM_GPT1_COMPARE_LSIO_GPIO0_IO19
> 	IMX8QM_GPT1_COMPARE		3
> +#define IMX8QM_UART0_RX_DMA_UART0_RX
> 	IMX8QM_UART0_RX			0
> +#define IMX8QM_UART0_RX_SCU_UART0_RX
> 	IMX8QM_UART0_RX			1
> +#define IMX8QM_UART0_RX_LSIO_GPIO0_IO20
> 	IMX8QM_UART0_RX			3
> +#define IMX8QM_UART0_TX_DMA_UART0_TX
> 	IMX8QM_UART0_TX			0
> +#define IMX8QM_UART0_TX_SCU_UART0_TX
> 	IMX8QM_UART0_TX			1
> +#define IMX8QM_UART0_TX_LSIO_GPIO0_IO21
> 	IMX8QM_UART0_TX			3
> +#define IMX8QM_UART0_RTS_B_DMA_UART0_RTS_B
> 	IMX8QM_UART0_RTS_B		0
> +#define IMX8QM_UART0_RTS_B_LSIO_PWM0_OUT
> 	IMX8QM_UART0_RTS_B		1
> +#define IMX8QM_UART0_RTS_B_DMA_UART2_RX
> 	IMX8QM_UART0_RTS_B		2
> +#define IMX8QM_UART0_RTS_B_LSIO_GPIO0_IO22
> 	IMX8QM_UART0_RTS_B		3
> +#define IMX8QM_UART0_CTS_B_DMA_UART0_CTS_B
> 	IMX8QM_UART0_CTS_B		0
> +#define IMX8QM_UART0_CTS_B_LSIO_PWM1_OUT
> 	IMX8QM_UART0_CTS_B		1
> +#define IMX8QM_UART0_CTS_B_DMA_UART2_TX
> 	IMX8QM_UART0_CTS_B		2
> +#define IMX8QM_UART0_CTS_B_LSIO_GPIO0_IO23
> 	IMX8QM_UART0_CTS_B		3
> +#define IMX8QM_UART1_TX_DMA_UART1_TX
> 	IMX8QM_UART1_TX			0
> +#define IMX8QM_UART1_TX_DMA_SPI3_SCK
> 	IMX8QM_UART1_TX			1
> +#define IMX8QM_UART1_TX_LSIO_GPIO0_IO24
> 	IMX8QM_UART1_TX			3
> +#define IMX8QM_UART1_RX_DMA_UART1_RX
> 	IMX8QM_UART1_RX			0
> +#define IMX8QM_UART1_RX_DMA_SPI3_SDO
> 	IMX8QM_UART1_RX			1
> +#define IMX8QM_UART1_RX_LSIO_GPIO0_IO25
> 	IMX8QM_UART1_RX			3
> +#define IMX8QM_UART1_RTS_B_DMA_UART1_RTS_B
> 	IMX8QM_UART1_RTS_B		0
> +#define IMX8QM_UART1_RTS_B_DMA_SPI3_SDI
> 	IMX8QM_UART1_RTS_B		1
> +#define IMX8QM_UART1_RTS_B_DMA_UART1_CTS_B
> 	IMX8QM_UART1_RTS_B		2
> +#define IMX8QM_UART1_RTS_B_LSIO_GPIO0_IO26
> 	IMX8QM_UART1_RTS_B		3
> +#define IMX8QM_UART1_CTS_B_DMA_UART1_CTS_B
> 	IMX8QM_UART1_CTS_B		0
> +#define IMX8QM_UART1_CTS_B_DMA_SPI3_CS0
> 	IMX8QM_UART1_CTS_B		1
> +#define IMX8QM_UART1_CTS_B_DMA_UART1_RTS_B
> 	IMX8QM_UART1_CTS_B		2
> +#define IMX8QM_UART1_CTS_B_LSIO_GPIO0_IO27
> 	IMX8QM_UART1_CTS_B		3
> +#define
> IMX8QM_SCU_PMIC_MEMC_ON_SCU_GPIO0_IOXX_PMIC_MEMC_ON
> 	IMX8QM_SCU_PMIC_MEMC_ON		0
> +#define IMX8QM_SCU_WDOG_OUT_SCU_WDOG0_WDOG_OUT
> 	IMX8QM_SCU_WDOG_OUT		0
> +#define IMX8QM_PMIC_I2C_SDA_SCU_PMIC_I2C_SDA
> 	IMX8QM_PMIC_I2C_SDA		0
> +#define IMX8QM_PMIC_I2C_SCL_SCU_PMIC_I2C_SCL
> 	IMX8QM_PMIC_I2C_SCL		0
> +#define IMX8QM_PMIC_EARLY_WARNING_SCU_PMIC_EARLY_WARNING
> 	IMX8QM_PMIC_EARLY_WARNING	0
> +#define IMX8QM_PMIC_INT_B_SCU_DIMX8QMMIC_INT_B
> 	IMX8QM_PMIC_INT_B		0
> +#define IMX8QM_SCU_GPIO0_00_SCU_GPIO0_IO00
> 	IMX8QM_SCU_GPIO0_00		0
> +#define IMX8QM_SCU_GPIO0_00_SCU_UART0_RX
> 	IMX8QM_SCU_GPIO0_00		1
> +#define IMX8QM_SCU_GPIO0_00_LSIO_GPIO0_IO28
> 	IMX8QM_SCU_GPIO0_00		3
> +#define IMX8QM_SCU_GPIO0_01_SCU_GPIO0_IO01
> 	IMX8QM_SCU_GPIO0_01		0
> +#define IMX8QM_SCU_GPIO0_01_SCU_UART0_TX
> 	IMX8QM_SCU_GPIO0_01		1
> +#define IMX8QM_SCU_GPIO0_01_LSIO_GPIO0_IO29
> 	IMX8QM_SCU_GPIO0_01		3
> +#define IMX8QM_SCU_GPIO0_02_SCU_GPIO0_IO02
> 	IMX8QM_SCU_GPIO0_02		0
> +#define IMX8QM_SCU_GPIO0_02_SCU_GPIO0_IOXX_PMIC_GPU0_ON
> 	IMX8QM_SCU_GPIO0_02		1
> +#define IMX8QM_SCU_GPIO0_02_LSIO_GPIO0_IO30
> 	IMX8QM_SCU_GPIO0_02		3
> +#define IMX8QM_SCU_GPIO0_03_SCU_GPIO0_IO03
> 	IMX8QM_SCU_GPIO0_03		0
> +#define IMX8QM_SCU_GPIO0_03_SCU_GPIO0_IOXX_PMIC_GPU1_ON
> 	IMX8QM_SCU_GPIO0_03		1
> +#define IMX8QM_SCU_GPIO0_03_LSIO_GPIO0_IO31
> 	IMX8QM_SCU_GPIO0_03		3
> +#define IMX8QM_SCU_GPIO0_04_SCU_GPIO0_IO04
> 	IMX8QM_SCU_GPIO0_04		0
> +#define IMX8QM_SCU_GPIO0_04_SCU_GPIO0_IOXX_PMIC_A72_ON
> 	IMX8QM_SCU_GPIO0_04		1
> +#define IMX8QM_SCU_GPIO0_04_LSIO_GPIO1_IO00
> 	IMX8QM_SCU_GPIO0_04		3
> +#define IMX8QM_SCU_GPIO0_05_SCU_GPIO0_IO05
> 	IMX8QM_SCU_GPIO0_05		0
> +#define IMX8QM_SCU_GPIO0_05_SCU_GPIO0_IOXX_PMIC_A53_ON
> 	IMX8QM_SCU_GPIO0_05		1
> +#define IMX8QM_SCU_GPIO0_05_LSIO_GPIO1_IO01
> 	IMX8QM_SCU_GPIO0_05		3
> +#define IMX8QM_SCU_GPIO0_06_SCU_GPIO0_IO06
> 	IMX8QM_SCU_GPIO0_06		0
> +#define IMX8QM_SCU_GPIO0_06_SCU_TPM0_CH0
> 	IMX8QM_SCU_GPIO0_06		1
> +#define IMX8QM_SCU_GPIO0_06_LSIO_GPIO1_IO02
> 	IMX8QM_SCU_GPIO0_06		3
> +#define IMX8QM_SCU_GPIO0_07_SCU_GPIO0_IO07
> 	IMX8QM_SCU_GPIO0_07		0
> +#define IMX8QM_SCU_GPIO0_07_SCU_TPM0_CH1
> 	IMX8QM_SCU_GPIO0_07		1
> +#define IMX8QM_SCU_GPIO0_07_SCU_DSC_RTC_CLOCK_OUTPUT_32K
> 	IMX8QM_SCU_GPIO0_07		2
> +#define IMX8QM_SCU_GPIO0_07_LSIO_GPIO1_IO03
> 	IMX8QM_SCU_GPIO0_07		3
> +#define IMX8QM_SCU_BOOT_MODE0_SCU_DSC_BOOT_MODE0
> 	IMX8QM_SCU_BOOT_MODE0		0
> +#define IMX8QM_SCU_BOOT_MODE1_SCU_DSC_BOOT_MODE1
> 	IMX8QM_SCU_BOOT_MODE1		0
> +#define IMX8QM_SCU_BOOT_MODE2_SCU_DSC_BOOT_MODE2
> 	IMX8QM_SCU_BOOT_MODE2		0
> +#define IMX8QM_SCU_BOOT_MODE3_SCU_DSC_BOOT_MODE3
> 	IMX8QM_SCU_BOOT_MODE3		0
> +#define IMX8QM_SCU_BOOT_MODE4_SCU_DSC_BOOT_MODE4
> 	IMX8QM_SCU_BOOT_MODE4		0
> +#define IMX8QM_SCU_BOOT_MODE4_SCU_PMIC_I2C_SCL
> 	IMX8QM_SCU_BOOT_MODE4		1
> +#define IMX8QM_SCU_BOOT_MODE5_SCU_DSC_BOOT_MODE5
> 	IMX8QM_SCU_BOOT_MODE5		0
> +#define IMX8QM_SCU_BOOT_MODE5_SCU_PMIC_I2C_SDA
> 	IMX8QM_SCU_BOOT_MODE5		1
> +#define IMX8QM_LVDS0_GPIO00_LVDS0_GPIO0_IO00
> 	IMX8QM_LVDS0_GPIO00		0
> +#define IMX8QM_LVDS0_GPIO00_LVDS0_PWM0_OUT
> 	IMX8QM_LVDS0_GPIO00		1
> +#define IMX8QM_LVDS0_GPIO00_LSIO_GPIO1_IO04
> 	IMX8QM_LVDS0_GPIO00		3
> +#define IMX8QM_LVDS0_GPIO01_LVDS0_GPIO0_IO01
> 	IMX8QM_LVDS0_GPIO01		0
> +#define IMX8QM_LVDS0_GPIO01_LSIO_GPIO1_IO05
> 	IMX8QM_LVDS0_GPIO01		3
> +#define IMX8QM_LVDS0_I2C0_SCL_LVDS0_I2C0_SCL
> 	IMX8QM_LVDS0_I2C0_SCL		0
> +#define IMX8QM_LVDS0_I2C0_SCL_LVDS0_GPIO0_IO02
> 	IMX8QM_LVDS0_I2C0_SCL		1
> +#define IMX8QM_LVDS0_I2C0_SCL_LSIO_GPIO1_IO06
> 	IMX8QM_LVDS0_I2C0_SCL		3
> +#define IMX8QM_LVDS0_I2C0_SDA_LVDS0_I2C0_SDA
> 	IMX8QM_LVDS0_I2C0_SDA		0
> +#define IMX8QM_LVDS0_I2C0_SDA_LVDS0_GPIO0_IO03
> 	IMX8QM_LVDS0_I2C0_SDA		1
> +#define IMX8QM_LVDS0_I2C0_SDA_LSIO_GPIO1_IO07
> 	IMX8QM_LVDS0_I2C0_SDA		3
> +#define IMX8QM_LVDS0_I2C1_SCL_LVDS0_I2C1_SCL
> 	IMX8QM_LVDS0_I2C1_SCL		0
> +#define IMX8QM_LVDS0_I2C1_SCL_DMA_UART2_TX
> 	IMX8QM_LVDS0_I2C1_SCL		1
> +#define IMX8QM_LVDS0_I2C1_SCL_LSIO_GPIO1_IO08
> 	IMX8QM_LVDS0_I2C1_SCL		3
> +#define IMX8QM_LVDS0_I2C1_SDA_LVDS0_I2C1_SDA
> 	IMX8QM_LVDS0_I2C1_SDA		0
> +#define IMX8QM_LVDS0_I2C1_SDA_DMA_UART2_RX
> 	IMX8QM_LVDS0_I2C1_SDA		1
> +#define IMX8QM_LVDS0_I2C1_SDA_LSIO_GPIO1_IO09
> 	IMX8QM_LVDS0_I2C1_SDA		3
> +#define IMX8QM_LVDS1_GPIO00_LVDS1_GPIO0_IO00
> 	IMX8QM_LVDS1_GPIO00		0
> +#define IMX8QM_LVDS1_GPIO00_LVDS1_PWM0_OUT
> 	IMX8QM_LVDS1_GPIO00		1
> +#define IMX8QM_LVDS1_GPIO00_LSIO_GPIO1_IO10
> 	IMX8QM_LVDS1_GPIO00		3
> +#define IMX8QM_LVDS1_GPIO01_LVDS1_GPIO0_IO01
> 	IMX8QM_LVDS1_GPIO01		0
> +#define IMX8QM_LVDS1_GPIO01_LSIO_GPIO1_IO11
> 	IMX8QM_LVDS1_GPIO01		3
> +#define IMX8QM_LVDS1_I2C0_SCL_LVDS1_I2C0_SCL
> 	IMX8QM_LVDS1_I2C0_SCL		0
> +#define IMX8QM_LVDS1_I2C0_SCL_LVDS1_GPIO0_IO02
> 	IMX8QM_LVDS1_I2C0_SCL		1
> +#define IMX8QM_LVDS1_I2C0_SCL_LSIO_GPIO1_IO12
> 	IMX8QM_LVDS1_I2C0_SCL		3
> +#define IMX8QM_LVDS1_I2C0_SDA_LVDS1_I2C0_SDA
> 	IMX8QM_LVDS1_I2C0_SDA		0
> +#define IMX8QM_LVDS1_I2C0_SDA_LVDS1_GPIO0_IO03
> 	IMX8QM_LVDS1_I2C0_SDA		1
> +#define IMX8QM_LVDS1_I2C0_SDA_LSIO_GPIO1_IO13
> 	IMX8QM_LVDS1_I2C0_SDA		3
> +#define IMX8QM_LVDS1_I2C1_SCL_LVDS1_I2C1_SCL
> 	IMX8QM_LVDS1_I2C1_SCL		0
> +#define IMX8QM_LVDS1_I2C1_SCL_DMA_UART3_TX
> 	IMX8QM_LVDS1_I2C1_SCL		1
> +#define IMX8QM_LVDS1_I2C1_SCL_LSIO_GPIO1_IO14
> 	IMX8QM_LVDS1_I2C1_SCL		3
> +#define IMX8QM_LVDS1_I2C1_SDA_LVDS1_I2C1_SDA
> 	IMX8QM_LVDS1_I2C1_SDA		0
> +#define IMX8QM_LVDS1_I2C1_SDA_DMA_UART3_RX
> 	IMX8QM_LVDS1_I2C1_SDA		1
> +#define IMX8QM_LVDS1_I2C1_SDA_LSIO_GPIO1_IO15
> 	IMX8QM_LVDS1_I2C1_SDA		3
> +#define IMX8QM_MIPI_DSI0_I2C0_SCL_MIPI_DSI0_I2C0_SCL
> 	IMX8QM_MIPI_DSI0_I2C0_SCL	0
> +#define IMX8QM_MIPI_DSI0_I2C0_SCL_LSIO_GPIO1_IO16
> 	IMX8QM_MIPI_DSI0_I2C0_SCL	3
> +#define IMX8QM_MIPI_DSI0_I2C0_SDA_MIPI_DSI0_I2C0_SDA
> 	IMX8QM_MIPI_DSI0_I2C0_SDA	0
> +#define IMX8QM_MIPI_DSI0_I2C0_SDA_LSIO_GPIO1_IO17
> 	IMX8QM_MIPI_DSI0_I2C0_SDA	3
> +#define IMX8QM_MIPI_DSI0_GPIO0_00_MIPI_DSI0_GPIO0_IO00
> 	IMX8QM_MIPI_DSI0_GPIO0_00	0
> +#define IMX8QM_MIPI_DSI0_GPIO0_00_MIPI_DSI0_PWM0_OUT
> 	IMX8QM_MIPI_DSI0_GPIO0_00	1
> +#define IMX8QM_MIPI_DSI0_GPIO0_00_LSIO_GPIO1_IO18
> 	IMX8QM_MIPI_DSI0_GPIO0_00	3
> +#define IMX8QM_MIPI_DSI0_GPIO0_01_MIPI_DSI0_GPIO0_IO01
> 	IMX8QM_MIPI_DSI0_GPIO0_01	0
> +#define IMX8QM_MIPI_DSI0_GPIO0_01_LSIO_GPIO1_IO19
> 	IMX8QM_MIPI_DSI0_GPIO0_01	3
> +#define IMX8QM_MIPI_DSI1_I2C0_SCL_MIPI_DSI1_I2C0_SCL
> 	IMX8QM_MIPI_DSI1_I2C0_SCL	0
> +#define IMX8QM_MIPI_DSI1_I2C0_SCL_LSIO_GPIO1_IO20
> 	IMX8QM_MIPI_DSI1_I2C0_SCL	3
> +#define IMX8QM_MIPI_DSI1_I2C0_SDA_MIPI_DSI1_I2C0_SDA
> 	IMX8QM_MIPI_DSI1_I2C0_SDA	0
> +#define IMX8QM_MIPI_DSI1_I2C0_SDA_LSIO_GPIO1_IO21
> 	IMX8QM_MIPI_DSI1_I2C0_SDA	3
> +#define IMX8QM_MIPI_DSI1_GPIO0_00_MIPI_DSI1_GPIO0_IO00
> 	IMX8QM_MIPI_DSI1_GPIO0_00	0
> +#define IMX8QM_MIPI_DSI1_GPIO0_00_MIPI_DSI1_PWM0_OUT
> 	IMX8QM_MIPI_DSI1_GPIO0_00	1
> +#define IMX8QM_MIPI_DSI1_GPIO0_00_LSIO_GPIO1_IO22
> 	IMX8QM_MIPI_DSI1_GPIO0_00	3
> +#define IMX8QM_MIPI_DSI1_GPIO0_01_MIPI_DSI1_GPIO0_IO01
> 	IMX8QM_MIPI_DSI1_GPIO0_01	0
> +#define IMX8QM_MIPI_DSI1_GPIO0_01_LSIO_GPIO1_IO23
> 	IMX8QM_MIPI_DSI1_GPIO0_01	3
> +#define IMX8QM_MIPI_CSI0_MCLK_OUT_MIPI_CSI0_ACM_MCLK_OUT
> 	IMX8QM_MIPI_CSI0_MCLK_OUT	0
> +#define IMX8QM_MIPI_CSI0_MCLK_OUT_LSIO_GPIO1_IO24
> 	IMX8QM_MIPI_CSI0_MCLK_OUT	3
> +#define IMX8QM_MIPI_CSI0_I2C0_SCL_MIPI_CSI0_I2C0_SCL
> 	IMX8QM_MIPI_CSI0_I2C0_SCL	0
> +#define IMX8QM_MIPI_CSI0_I2C0_SCL_LSIO_GPIO1_IO25
> 	IMX8QM_MIPI_CSI0_I2C0_SCL	3
> +#define IMX8QM_MIPI_CSI0_I2C0_SDA_MIPI_CSI0_I2C0_SDA
> 	IMX8QM_MIPI_CSI0_I2C0_SDA	0
> +#define IMX8QM_MIPI_CSI0_I2C0_SDA_LSIO_GPIO1_IO26
> 	IMX8QM_MIPI_CSI0_I2C0_SDA	3
> +#define IMX8QM_MIPI_CSI0_GPIO0_00_MIPI_CSI0_GPIO0_IO00
> 	IMX8QM_MIPI_CSI0_GPIO0_00	0
> +#define IMX8QM_MIPI_CSI0_GPIO0_00_DMA_I2C0_SCL
> 	IMX8QM_MIPI_CSI0_GPIO0_00	1
> +#define IMX8QM_MIPI_CSI0_GPIO0_00_MIPI_CSI1_I2C0_SCL
> 	IMX8QM_MIPI_CSI0_GPIO0_00	2
> +#define IMX8QM_MIPI_CSI0_GPIO0_00_LSIO_GPIO1_IO27
> 	IMX8QM_MIPI_CSI0_GPIO0_00	3
> +#define IMX8QM_MIPI_CSI0_GPIO0_01_MIPI_CSI0_GPIO0_IO01
> 	IMX8QM_MIPI_CSI0_GPIO0_01	0
> +#define IMX8QM_MIPI_CSI0_GPIO0_01_DMA_I2C0_SDA
> 	IMX8QM_MIPI_CSI0_GPIO0_01	1
> +#define IMX8QM_MIPI_CSI0_GPIO0_01_MIPI_CSI1_I2C0_SDA
> 	IMX8QM_MIPI_CSI0_GPIO0_01	2
> +#define IMX8QM_MIPI_CSI0_GPIO0_01_LSIO_GPIO1_IO28
> 	IMX8QM_MIPI_CSI0_GPIO0_01	3
> +#define IMX8QM_MIPI_CSI1_MCLK_OUT_MIPI_CSI1_ACM_MCLK_OUT
> 	IMX8QM_MIPI_CSI1_MCLK_OUT	0
> +#define IMX8QM_MIPI_CSI1_MCLK_OUT_LSIO_GPIO1_IO29
> 	IMX8QM_MIPI_CSI1_MCLK_OUT	3
> +#define IMX8QM_MIPI_CSI1_GPIO0_00_MIPI_CSI1_GPIO0_IO00
> 	IMX8QM_MIPI_CSI1_GPIO0_00	0
> +#define IMX8QM_MIPI_CSI1_GPIO0_00_DMA_UART4_RX
> 	IMX8QM_MIPI_CSI1_GPIO0_00	1
> +#define IMX8QM_MIPI_CSI1_GPIO0_00_LSIO_GPIO1_IO30
> 	IMX8QM_MIPI_CSI1_GPIO0_00	3
> +#define IMX8QM_MIPI_CSI1_GPIO0_01_MIPI_CSI1_GPIO0_IO01
> 	IMX8QM_MIPI_CSI1_GPIO0_01	0
> +#define IMX8QM_MIPI_CSI1_GPIO0_01_DMA_UART4_TX
> 	IMX8QM_MIPI_CSI1_GPIO0_01	1
> +#define IMX8QM_MIPI_CSI1_GPIO0_01_LSIO_GPIO1_IO31
> 	IMX8QM_MIPI_CSI1_GPIO0_01	3
> +#define IMX8QM_MIPI_CSI1_I2C0_SCL_MIPI_CSI1_I2C0_SCL
> 	IMX8QM_MIPI_CSI1_I2C0_SCL	0
> +#define IMX8QM_MIPI_CSI1_I2C0_SCL_LSIO_GPIO2_IO00
> 	IMX8QM_MIPI_CSI1_I2C0_SCL	3
> +#define IMX8QM_MIPI_CSI1_I2C0_SDA_MIPI_CSI1_I2C0_SDA
> 	IMX8QM_MIPI_CSI1_I2C0_SDA	0
> +#define IMX8QM_MIPI_CSI1_I2C0_SDA_LSIO_GPIO2_IO01
> 	IMX8QM_MIPI_CSI1_I2C0_SDA	3
> +#define IMX8QM_HDMI_TX0_TS_SCL_HDMI_TX0_I2C0_SCL
> 	IMX8QM_HDMI_TX0_TS_SCL		0
> +#define IMX8QM_HDMI_TX0_TS_SCL_DMA_I2C0_SCL
> 	IMX8QM_HDMI_TX0_TS_SCL		1
> +#define IMX8QM_HDMI_TX0_TS_SCL_LSIO_GPIO2_IO02
> 	IMX8QM_HDMI_TX0_TS_SCL		3
> +#define IMX8QM_HDMI_TX0_TS_SDA_HDMI_TX0_I2C0_SDA
> 	IMX8QM_HDMI_TX0_TS_SDA		0
> +#define IMX8QM_HDMI_TX0_TS_SDA_DMA_I2C0_SDA
> 	IMX8QM_HDMI_TX0_TS_SDA		1
> +#define IMX8QM_HDMI_TX0_TS_SDA_LSIO_GPIO2_IO03
> 	IMX8QM_HDMI_TX0_TS_SDA		3
> +#define IMX8QM_ESAI1_FSR_AUD_ESAI1_FSR
> 	IMX8QM_ESAI1_FSR		0
> +#define IMX8QM_ESAI1_FSR_LSIO_GPIO2_IO04
> 	IMX8QM_ESAI1_FSR		3
> +#define IMX8QM_ESAI1_FST_AUD_ESAI1_FST
> 	IMX8QM_ESAI1_FST		0
> +#define IMX8QM_ESAI1_FST_AUD_SPDIF0_EXT_CLK
> 	IMX8QM_ESAI1_FST		1
> +#define IMX8QM_ESAI1_FST_LSIO_GPIO2_IO05
> 	IMX8QM_ESAI1_FST		3
> +#define IMX8QM_ESAI1_SCKR_AUD_ESAI1_SCKR
> 	IMX8QM_ESAI1_SCKR		0
> +#define IMX8QM_ESAI1_SCKR_LSIO_GPIO2_IO06
> 	IMX8QM_ESAI1_SCKR		3
> +#define IMX8QM_ESAI1_SCKT_AUD_ESAI1_SCKT
> 	IMX8QM_ESAI1_SCKT		0
> +#define IMX8QM_ESAI1_SCKT_AUD_SAI2_RXC
> 	IMX8QM_ESAI1_SCKT		1
> +#define IMX8QM_ESAI1_SCKT_AUD_SPDIF0_EXT_CLK
> 	IMX8QM_ESAI1_SCKT		2
> +#define IMX8QM_ESAI1_SCKT_LSIO_GPIO2_IO07
> 	IMX8QM_ESAI1_SCKT		3
> +#define IMX8QM_ESAI1_TX0_AUD_ESAI1_TX0
> 	IMX8QM_ESAI1_TX0		0
> +#define IMX8QM_ESAI1_TX0_AUD_SAI2_RXD
> 	IMX8QM_ESAI1_TX0		1
> +#define IMX8QM_ESAI1_TX0_AUD_SPDIF0_RX
> 	IMX8QM_ESAI1_TX0		2
> +#define IMX8QM_ESAI1_TX0_LSIO_GPIO2_IO08
> 	IMX8QM_ESAI1_TX0		3
> +#define IMX8QM_ESAI1_TX1_AUD_ESAI1_TX1
> 	IMX8QM_ESAI1_TX1		0
> +#define IMX8QM_ESAI1_TX1_AUD_SAI2_RXFS
> 	IMX8QM_ESAI1_TX1		1
> +#define IMX8QM_ESAI1_TX1_AUD_SPDIF0_TX
> 	IMX8QM_ESAI1_TX1		2
> +#define IMX8QM_ESAI1_TX1_LSIO_GPIO2_IO09
> 	IMX8QM_ESAI1_TX1		3
> +#define IMX8QM_ESAI1_TX2_RX3_AUD_ESAI1_TX2_RX3
> 	IMX8QM_ESAI1_TX2_RX3		0
> +#define IMX8QM_ESAI1_TX2_RX3_AUD_SPDIF0_RX
> 	IMX8QM_ESAI1_TX2_RX3		1
> +#define IMX8QM_ESAI1_TX2_RX3_LSIO_GPIO2_IO10
> 	IMX8QM_ESAI1_TX2_RX3		3
> +#define IMX8QM_ESAI1_TX3_RX2_AUD_ESAI1_TX3_RX2
> 	IMX8QM_ESAI1_TX3_RX2		0
> +#define IMX8QM_ESAI1_TX3_RX2_AUD_SPDIF0_TX
> 	IMX8QM_ESAI1_TX3_RX2		1
> +#define IMX8QM_ESAI1_TX3_RX2_LSIO_GPIO2_IO11
> 	IMX8QM_ESAI1_TX3_RX2		3
> +#define IMX8QM_ESAI1_TX4_RX1_AUD_ESAI1_TX4_RX1
> 	IMX8QM_ESAI1_TX4_RX1		0
> +#define IMX8QM_ESAI1_TX4_RX1_LSIO_GPIO2_IO12
> 	IMX8QM_ESAI1_TX4_RX1		3
> +#define IMX8QM_ESAI1_TX5_RX0_AUD_ESAI1_TX5_RX0
> 	IMX8QM_ESAI1_TX5_RX0		0
> +#define IMX8QM_ESAI1_TX5_RX0_LSIO_GPIO2_IO13
> 	IMX8QM_ESAI1_TX5_RX0		3
> +#define IMX8QM_SPDIF0_RX_AUD_SPDIF0_RX
> 	IMX8QM_SPDIF0_RX		0
> +#define IMX8QM_SPDIF0_RX_AUD_MQS_R
> 	IMX8QM_SPDIF0_RX		1
> +#define IMX8QM_SPDIF0_RX_AUD_ACM_MCLK_IN1
> 	IMX8QM_SPDIF0_RX		2
> +#define IMX8QM_SPDIF0_RX_LSIO_GPIO2_IO14
> 	IMX8QM_SPDIF0_RX		3
> +#define IMX8QM_SPDIF0_TX_AUD_SPDIF0_TX
> 	IMX8QM_SPDIF0_TX		0
> +#define IMX8QM_SPDIF0_TX_AUD_MQS_L
> 	IMX8QM_SPDIF0_TX		1
> +#define IMX8QM_SPDIF0_TX_AUD_ACM_MCLK_OUT1
> 	IMX8QM_SPDIF0_TX		2
> +#define IMX8QM_SPDIF0_TX_LSIO_GPIO2_IO15
> 	IMX8QM_SPDIF0_TX		3
> +#define IMX8QM_SPDIF0_EXT_CLK_AUD_SPDIF0_EXT_CLK
> 	IMX8QM_SPDIF0_EXT_CLK		0
> +#define IMX8QM_SPDIF0_EXT_CLK_DMA_DMA0_REQ_IN0
> 	IMX8QM_SPDIF0_EXT_CLK		1
> +#define IMX8QM_SPDIF0_EXT_CLK_LSIO_GPIO2_IO16
> 	IMX8QM_SPDIF0_EXT_CLK		3
> +#define IMX8QM_SPI3_SCK_DMA_SPI3_SCK
> 	IMX8QM_SPI3_SCK			0
> +#define IMX8QM_SPI3_SCK_LSIO_GPIO2_IO17
> 	IMX8QM_SPI3_SCK			3
> +#define IMX8QM_SPI3_SDO_DMA_SPI3_SDO
> 	IMX8QM_SPI3_SDO			0
> +#define IMX8QM_SPI3_SDO_DMA_FTM_CH0
> 	IMX8QM_SPI3_SDO			1
> +#define IMX8QM_SPI3_SDO_LSIO_GPIO2_IO18
> 	IMX8QM_SPI3_SDO			3
> +#define IMX8QM_SPI3_SDI_DMA_SPI3_SDI
> 	IMX8QM_SPI3_SDI			0
> +#define IMX8QM_SPI3_SDI_DMA_FTM_CH1
> 	IMX8QM_SPI3_SDI			1
> +#define IMX8QM_SPI3_SDI_LSIO_GPIO2_IO19
> 	IMX8QM_SPI3_SDI			3
> +#define IMX8QM_SPI3_CS0_DMA_SPI3_CS0
> 	IMX8QM_SPI3_CS0			0
> +#define IMX8QM_SPI3_CS0_DMA_FTM_CH2
> 	IMX8QM_SPI3_CS0			1
> +#define IMX8QM_SPI3_CS0_LSIO_GPIO2_IO20
> 	IMX8QM_SPI3_CS0			3
> +#define IMX8QM_SPI3_CS1_DMA_SPI3_CS1
> 	IMX8QM_SPI3_CS1			0
> +#define IMX8QM_SPI3_CS1_LSIO_GPIO2_IO21
> 	IMX8QM_SPI3_CS1			3
> +#define IMX8QM_ESAI0_FSR_AUD_ESAI0_FSR
> 	IMX8QM_ESAI0_FSR		0
> +#define IMX8QM_ESAI0_FSR_LSIO_GPIO2_IO22
> 	IMX8QM_ESAI0_FSR		3
> +#define IMX8QM_ESAI0_FST_AUD_ESAI0_FST
> 	IMX8QM_ESAI0_FST		0
> +#define IMX8QM_ESAI0_FST_LSIO_GPIO2_IO23
> 	IMX8QM_ESAI0_FST		3
> +#define IMX8QM_ESAI0_SCKR_AUD_ESAI0_SCKR
> 	IMX8QM_ESAI0_SCKR		0
> +#define IMX8QM_ESAI0_SCKR_LSIO_GPIO2_IO24
> 	IMX8QM_ESAI0_SCKR		3
> +#define IMX8QM_ESAI0_SCKT_AUD_ESAI0_SCKT
> 	IMX8QM_ESAI0_SCKT		0
> +#define IMX8QM_ESAI0_SCKT_LSIO_GPIO2_IO25
> 	IMX8QM_ESAI0_SCKT		3
> +#define IMX8QM_ESAI0_TX0_AUD_ESAI0_TX0
> 	IMX8QM_ESAI0_TX0		0
> +#define IMX8QM_ESAI0_TX0_LSIO_GPIO2_IO26
> 	IMX8QM_ESAI0_TX0		3
> +#define IMX8QM_ESAI0_TX1_AUD_ESAI0_TX1
> 	IMX8QM_ESAI0_TX1		0
> +#define IMX8QM_ESAI0_TX1_LSIO_GPIO2_IO27
> 	IMX8QM_ESAI0_TX1		3
> +#define IMX8QM_ESAI0_TX2_RX3_AUD_ESAI0_TX2_RX3
> 	IMX8QM_ESAI0_TX2_RX3		0
> +#define IMX8QM_ESAI0_TX2_RX3_LSIO_GPIO2_IO28
> 	IMX8QM_ESAI0_TX2_RX3		3
> +#define IMX8QM_ESAI0_TX3_RX2_AUD_ESAI0_TX3_RX2
> 	IMX8QM_ESAI0_TX3_RX2		0
> +#define IMX8QM_ESAI0_TX3_RX2_LSIO_GPIO2_IO29
> 	IMX8QM_ESAI0_TX3_RX2		3
> +#define IMX8QM_ESAI0_TX4_RX1_AUD_ESAI0_TX4_RX1
> 	IMX8QM_ESAI0_TX4_RX1		0
> +#define IMX8QM_ESAI0_TX4_RX1_LSIO_GPIO2_IO30
> 	IMX8QM_ESAI0_TX4_RX1		3
> +#define IMX8QM_ESAI0_TX5_RX0_AUD_ESAI0_TX5_RX0
> 	IMX8QM_ESAI0_TX5_RX0		0
> +#define IMX8QM_ESAI0_TX5_RX0_LSIO_GPIO2_IO31
> 	IMX8QM_ESAI0_TX5_RX0		3
> +#define IMX8QM_MCLK_IN0_AUD_ACM_MCLK_IN0
> 	IMX8QM_MCLK_IN0			0
> +#define IMX8QM_MCLK_IN0_AUD_ESAI0_RX_HF_CLK
> 	IMX8QM_MCLK_IN0			1
> +#define IMX8QM_MCLK_IN0_AUD_ESAI1_RX_HF_CLK
> 	IMX8QM_MCLK_IN0			2
> +#define IMX8QM_MCLK_IN0_LSIO_GPIO3_IO00
> 	IMX8QM_MCLK_IN0			3
> +#define IMX8QM_MCLK_OUT0_AUD_ACM_MCLK_OUT0
> 	IMX8QM_MCLK_OUT0		0
> +#define IMX8QM_MCLK_OUT0_AUD_ESAI0_TX_HF_CLK
> 	IMX8QM_MCLK_OUT0		1
> +#define IMX8QM_MCLK_OUT0_AUD_ESAI1_TX_HF_CLK
> 	IMX8QM_MCLK_OUT0		2
> +#define IMX8QM_MCLK_OUT0_LSIO_GPIO3_IO01
> 	IMX8QM_MCLK_OUT0		3
> +#define IMX8QM_SPI0_SCK_DMA_SPI0_SCK
> 	IMX8QM_SPI0_SCK			0
> +#define IMX8QM_SPI0_SCK_AUD_SAI0_RXC
> 	IMX8QM_SPI0_SCK			1
> +#define IMX8QM_SPI0_SCK_LSIO_GPIO3_IO02
> 	IMX8QM_SPI0_SCK			3
> +#define IMX8QM_SPI0_SDO_DMA_SPI0_SDO
> 	IMX8QM_SPI0_SDO			0
> +#define IMX8QM_SPI0_SDO_AUD_SAI0_TXD
> 	IMX8QM_SPI0_SDO			1
> +#define IMX8QM_SPI0_SDO_LSIO_GPIO3_IO03
> 	IMX8QM_SPI0_SDO			3
> +#define IMX8QM_SPI0_SDI_DMA_SPI0_SDI
> 	IMX8QM_SPI0_SDI			0
> +#define IMX8QM_SPI0_SDI_AUD_SAI0_RXD
> 	IMX8QM_SPI0_SDI			1
> +#define IMX8QM_SPI0_SDI_LSIO_GPIO3_IO04
> 	IMX8QM_SPI0_SDI			3
> +#define IMX8QM_SPI0_CS0_DMA_SPI0_CS0
> 	IMX8QM_SPI0_CS0			0
> +#define IMX8QM_SPI0_CS0_AUD_SAI0_RXFS
> 	IMX8QM_SPI0_CS0			1
> +#define IMX8QM_SPI0_CS0_LSIO_GPIO3_IO05
> 	IMX8QM_SPI0_CS0			3
> +#define IMX8QM_SPI0_CS1_DMA_SPI0_CS1
> 	IMX8QM_SPI0_CS1			0
> +#define IMX8QM_SPI0_CS1_AUD_SAI0_TXC
> 	IMX8QM_SPI0_CS1			1
> +#define IMX8QM_SPI0_CS1_LSIO_GPIO3_IO06
> 	IMX8QM_SPI0_CS1			3
> +#define IMX8QM_SPI2_SCK_DMA_SPI2_SCK
> 	IMX8QM_SPI2_SCK			0
> +#define IMX8QM_SPI2_SCK_LSIO_GPIO3_IO07
> 	IMX8QM_SPI2_SCK			3
> +#define IMX8QM_SPI2_SDO_DMA_SPI2_SDO
> 	IMX8QM_SPI2_SDO			0
> +#define IMX8QM_SPI2_SDO_LSIO_GPIO3_IO08
> 	IMX8QM_SPI2_SDO			3
> +#define IMX8QM_SPI2_SDI_DMA_SPI2_SDI
> 	IMX8QM_SPI2_SDI			0
> +#define IMX8QM_SPI2_SDI_LSIO_GPIO3_IO09
> 	IMX8QM_SPI2_SDI			3
> +#define IMX8QM_SPI2_CS0_DMA_SPI2_CS0
> 	IMX8QM_SPI2_CS0			0
> +#define IMX8QM_SPI2_CS0_LSIO_GPIO3_IO10
> 	IMX8QM_SPI2_CS0			3
> +#define IMX8QM_SPI2_CS1_DMA_SPI2_CS1
> 	IMX8QM_SPI2_CS1			0
> +#define IMX8QM_SPI2_CS1_AUD_SAI0_TXFS
> 	IMX8QM_SPI2_CS1			1
> +#define IMX8QM_SPI2_CS1_LSIO_GPIO3_IO11
> 	IMX8QM_SPI2_CS1			3
> +#define IMX8QM_SAI1_RXC_AUD_SAI1_RXC
> 	IMX8QM_SAI1_RXC			0
> +#define IMX8QM_SAI1_RXC_AUD_SAI0_TXD
> 	IMX8QM_SAI1_RXC			1
> +#define IMX8QM_SAI1_RXC_LSIO_GPIO3_IO12
> 	IMX8QM_SAI1_RXC			3
> +#define IMX8QM_SAI1_RXD_AUD_SAI1_RXD
> 	IMX8QM_SAI1_RXD			0
> +#define IMX8QM_SAI1_RXD_AUD_SAI0_TXFS
> 	IMX8QM_SAI1_RXD			1
> +#define IMX8QM_SAI1_RXD_LSIO_GPIO3_IO13
> 	IMX8QM_SAI1_RXD			3
> +#define IMX8QM_SAI1_RXFS_AUD_SAI1_RXFS
> 	IMX8QM_SAI1_RXFS		0
> +#define IMX8QM_SAI1_RXFS_AUD_SAI0_RXD
> 	IMX8QM_SAI1_RXFS		1
> +#define IMX8QM_SAI1_RXFS_LSIO_GPIO3_IO14
> 	IMX8QM_SAI1_RXFS		3
> +#define IMX8QM_SAI1_TXC_AUD_SAI1_TXC
> 	IMX8QM_SAI1_TXC			0
> +#define IMX8QM_SAI1_TXC_AUD_SAI0_TXC
> 	IMX8QM_SAI1_TXC			1
> +#define IMX8QM_SAI1_TXC_LSIO_GPIO3_IO15
> 	IMX8QM_SAI1_TXC			3
> +#define IMX8QM_SAI1_TXD_AUD_SAI1_TXD
> 	IMX8QM_SAI1_TXD			0
> +#define IMX8QM_SAI1_TXD_AUD_SAI1_RXC
> 	IMX8QM_SAI1_TXD			1
> +#define IMX8QM_SAI1_TXD_LSIO_GPIO3_IO16
> 	IMX8QM_SAI1_TXD			3
> +#define IMX8QM_SAI1_TXFS_AUD_SAI1_TXFS
> 	IMX8QM_SAI1_TXFS		0
> +#define IMX8QM_SAI1_TXFS_AUD_SAI1_RXFS
> 	IMX8QM_SAI1_TXFS		1
> +#define IMX8QM_SAI1_TXFS_LSIO_GPIO3_IO17
> 	IMX8QM_SAI1_TXFS		3
> +#define IMX8QM_ADC_IN7_DMA_ADC1_IN3
> 	IMX8QM_ADC_IN7			0
> +#define IMX8QM_ADC_IN7_DMA_SPI1_CS1
> 	IMX8QM_ADC_IN7			1
> +#define IMX8QM_ADC_IN7_LSIO_KPP0_ROW3
> 	IMX8QM_ADC_IN7			2
> +#define IMX8QM_ADC_IN7_LSIO_GPIO3_IO25
> 	IMX8QM_ADC_IN7			3
> +#define IMX8QM_ADC_IN6_DMA_ADC1_IN2
> 	IMX8QM_ADC_IN6			0
> +#define IMX8QM_ADC_IN6_DMA_SPI1_CS0
> 	IMX8QM_ADC_IN6			1
> +#define IMX8QM_ADC_IN6_LSIO_KPP0_ROW2
> 	IMX8QM_ADC_IN6			2
> +#define IMX8QM_ADC_IN6_LSIO_GPIO3_IO24
> 	IMX8QM_ADC_IN6			3
> +#define IMX8QM_ADC_IN5_DMA_ADC1_IN1
> 	IMX8QM_ADC_IN5			0
> +#define IMX8QM_ADC_IN5_DMA_SPI1_SDI
> 	IMX8QM_ADC_IN5			1
> +#define IMX8QM_ADC_IN5_LSIO_KPP0_ROW1
> 	IMX8QM_ADC_IN5			2
> +#define IMX8QM_ADC_IN5_LSIO_GPIO3_IO23
> 	IMX8QM_ADC_IN5			3
> +#define IMX8QM_ADC_IN4_DMA_ADC1_IN0
> 	IMX8QM_ADC_IN4			0
> +#define IMX8QM_ADC_IN4_DMA_SPI1_SDO
> 	IMX8QM_ADC_IN4			1
> +#define IMX8QM_ADC_IN4_LSIO_KPP0_ROW0
> 	IMX8QM_ADC_IN4			2
> +#define IMX8QM_ADC_IN4_LSIO_GPIO3_IO22
> 	IMX8QM_ADC_IN4			3
> +#define IMX8QM_ADC_IN3_DMA_ADC0_IN3
> 	IMX8QM_ADC_IN3			0
> +#define IMX8QM_ADC_IN3_DMA_SPI1_SCK
> 	IMX8QM_ADC_IN3			1
> +#define IMX8QM_ADC_IN3_LSIO_KPP0_COL3
> 	IMX8QM_ADC_IN3			2
> +#define IMX8QM_ADC_IN3_LSIO_GPIO3_IO21
> 	IMX8QM_ADC_IN3			3
> +#define IMX8QM_ADC_IN2_DMA_ADC0_IN2
> 	IMX8QM_ADC_IN2			0
> +#define IMX8QM_ADC_IN2_LSIO_KPP0_COL2
> 	IMX8QM_ADC_IN2			2
> +#define IMX8QM_ADC_IN2_LSIO_GPIO3_IO20
> 	IMX8QM_ADC_IN2			3
> +#define IMX8QM_ADC_IN1_DMA_ADC0_IN1
> 	IMX8QM_ADC_IN1			0
> +#define IMX8QM_ADC_IN1_LSIO_KPP0_COL1
> 	IMX8QM_ADC_IN1			2
> +#define IMX8QM_ADC_IN1_LSIO_GPIO3_IO19
> 	IMX8QM_ADC_IN1			3
> +#define IMX8QM_ADC_IN0_DMA_ADC0_IN0
> 	IMX8QM_ADC_IN0			0
> +#define IMX8QM_ADC_IN0_LSIO_KPP0_COL0
> 	IMX8QM_ADC_IN0			2
> +#define IMX8QM_ADC_IN0_LSIO_GPIO3_IO18
> 	IMX8QM_ADC_IN0			3
> +#define IMX8QM_MLB_SIG_CONN_MLB_SIG
> 	IMX8QM_MLB_SIG			0
> +#define IMX8QM_MLB_SIG_AUD_SAI3_RXC
> 	IMX8QM_MLB_SIG			1
> +#define IMX8QM_MLB_SIG_LSIO_GPIO3_IO26
> 	IMX8QM_MLB_SIG			3
> +#define IMX8QM_MLB_CLK_CONN_MLB_CLK
> 	IMX8QM_MLB_CLK			0
> +#define IMX8QM_MLB_CLK_AUD_SAI3_RXFS
> 	IMX8QM_MLB_CLK			1
> +#define IMX8QM_MLB_CLK_LSIO_GPIO3_IO27
> 	IMX8QM_MLB_CLK			3
> +#define IMX8QM_MLB_DATA_CONN_MLB_DATA
> 	IMX8QM_MLB_DATA			0
> +#define IMX8QM_MLB_DATA_AUD_SAI3_RXD
> 	IMX8QM_MLB_DATA			1
> +#define IMX8QM_MLB_DATA_LSIO_GPIO3_IO28
> 	IMX8QM_MLB_DATA			3
> +#define IMX8QM_FLEXCAN0_RX_DMA_FLEXCAN0_RX
> 	IMX8QM_FLEXCAN0_RX		0
> +#define IMX8QM_FLEXCAN0_RX_LSIO_GPIO3_IO29
> 	IMX8QM_FLEXCAN0_RX		3
> +#define IMX8QM_FLEXCAN0_TX_DMA_FLEXCAN0_TX
> 	IMX8QM_FLEXCAN0_TX		0
> +#define IMX8QM_FLEXCAN0_TX_LSIO_GPIO3_IO30
> 	IMX8QM_FLEXCAN0_TX		3
> +#define IMX8QM_FLEXCAN1_RX_DMA_FLEXCAN1_RX
> 	IMX8QM_FLEXCAN1_RX		0
> +#define IMX8QM_FLEXCAN1_RX_LSIO_GPIO3_IO31
> 	IMX8QM_FLEXCAN1_RX		3
> +#define IMX8QM_FLEXCAN1_TX_DMA_FLEXCAN1_TX
> 	IMX8QM_FLEXCAN1_TX		0
> +#define IMX8QM_FLEXCAN1_TX_LSIO_GPIO4_IO00
> 	IMX8QM_FLEXCAN1_TX		3
> +#define IMX8QM_FLEXCAN2_RX_DMA_FLEXCAN2_RX
> 	IMX8QM_FLEXCAN2_RX		0
> +#define IMX8QM_FLEXCAN2_RX_LSIO_GPIO4_IO01
> 	IMX8QM_FLEXCAN2_RX		3
> +#define IMX8QM_FLEXCAN2_TX_DMA_FLEXCAN2_TX
> 	IMX8QM_FLEXCAN2_TX		0
> +#define IMX8QM_FLEXCAN2_TX_LSIO_GPIO4_IO02
> 	IMX8QM_FLEXCAN2_TX		3
> +#define IMX8QM_USB_SS3_TC0_DMA_I2C1_SCL
> 	IMX8QM_USB_SS3_TC0		0
> +#define IMX8QM_USB_SS3_TC0_CONN_USB_OTG1_PWR
> 	IMX8QM_USB_SS3_TC0		1
> +#define IMX8QM_USB_SS3_TC0_LSIO_GPIO4_IO03
> 	IMX8QM_USB_SS3_TC0		3
> +#define IMX8QM_USB_SS3_TC1_DMA_I2C1_SCL
> 	IMX8QM_USB_SS3_TC1		0
> +#define IMX8QM_USB_SS3_TC1_CONN_USB_OTG2_PWR
> 	IMX8QM_USB_SS3_TC1		1
> +#define IMX8QM_USB_SS3_TC1_LSIO_GPIO4_IO04
> 	IMX8QM_USB_SS3_TC1		3
> +#define IMX8QM_USB_SS3_TC2_DMA_I2C1_SDA
> 	IMX8QM_USB_SS3_TC2		0
> +#define IMX8QM_USB_SS3_TC2_CONN_USB_OTG1_OC
> 	IMX8QM_USB_SS3_TC2		1
> +#define IMX8QM_USB_SS3_TC2_LSIO_GPIO4_IO05
> 	IMX8QM_USB_SS3_TC2		3
> +#define IMX8QM_USB_SS3_TC3_DMA_I2C1_SDA
> 	IMX8QM_USB_SS3_TC3		0
> +#define IMX8QM_USB_SS3_TC3_CONN_USB_OTG2_OC
> 	IMX8QM_USB_SS3_TC3		1
> +#define IMX8QM_USB_SS3_TC3_LSIO_GPIO4_IO06
> 	IMX8QM_USB_SS3_TC3		3
> +#define IMX8QM_USDHC1_RESET_B_CONN_USDHC1_RESET_B
> 	IMX8QM_USDHC1_RESET_B		0
> +#define IMX8QM_USDHC1_RESET_B_LSIO_GPIO4_IO07
> 	IMX8QM_USDHC1_RESET_B		3
> +#define IMX8QM_USDHC1_VSELECT_CONN_USDHC1_VSELECT
> 	IMX8QM_USDHC1_VSELECT		0
> +#define IMX8QM_USDHC1_VSELECT_LSIO_GPIO4_IO08
> 	IMX8QM_USDHC1_VSELECT		3
> +#define IMX8QM_USDHC2_RESET_B_CONN_USDHC2_RESET_B
> 	IMX8QM_USDHC2_RESET_B		0
> +#define IMX8QM_USDHC2_RESET_B_LSIO_GPIO4_IO09
> 	IMX8QM_USDHC2_RESET_B		3
> +#define IMX8QM_USDHC2_VSELECT_CONN_USDHC2_VSELECT
> 	IMX8QM_USDHC2_VSELECT		0
> +#define IMX8QM_USDHC2_VSELECT_LSIO_GPIO4_IO10
> 	IMX8QM_USDHC2_VSELECT		3
> +#define IMX8QM_USDHC2_WP_CONN_USDHC2_WP
> 	IMX8QM_USDHC2_WP		0
> +#define IMX8QM_USDHC2_WP_LSIO_GPIO4_IO11
> 	IMX8QM_USDHC2_WP		3
> +#define IMX8QM_USDHC2_CD_B_CONN_USDHC2_CD_B
> 	IMX8QM_USDHC2_CD_B		0
> +#define IMX8QM_USDHC2_CD_B_LSIO_GPIO4_IO12
> 	IMX8QM_USDHC2_CD_B		3
> +#define IMX8QM_ENET0_MDIO_CONN_ENET0_MDIO
> 	IMX8QM_ENET0_MDIO		0
> +#define IMX8QM_ENET0_MDIO_DMA_I2C4_SDA
> 	IMX8QM_ENET0_MDIO		1
> +#define IMX8QM_ENET0_MDIO_LSIO_GPIO4_IO13
> 	IMX8QM_ENET0_MDIO		3
> +#define IMX8QM_ENET0_MDC_CONN_ENET0_MDC
> 	IMX8QM_ENET0_MDC		0
> +#define IMX8QM_ENET0_MDC_DMA_I2C4_SCL
> 	IMX8QM_ENET0_MDC		1
> +#define IMX8QM_ENET0_MDC_LSIO_GPIO4_IO14
> 	IMX8QM_ENET0_MDC		3
> +#define
> IMX8QM_ENET0_REFCLK_125M_25M_CONN_ENET0_REFCLK_125M_25M
> 	IMX8QM_ENET0_REFCLK_125M_25M	0
> +#define IMX8QM_ENET0_REFCLK_125M_25M_CONN_ENET0_PPS
> 	IMX8QM_ENET0_REFCLK_125M_25M	1
> +#define IMX8QM_ENET0_REFCLK_125M_25M_LSIO_GPIO4_IO15
> 	IMX8QM_ENET0_REFCLK_125M_25M	3
> +#define
> IMX8QM_ENET1_REFCLK_125M_25M_CONN_ENET1_REFCLK_125M_25M
> 	IMX8QM_ENET1_REFCLK_125M_25M	0
> +#define IMX8QM_ENET1_REFCLK_125M_25M_CONN_ENET1_PPS
> 	IMX8QM_ENET1_REFCLK_125M_25M	1
> +#define IMX8QM_ENET1_REFCLK_125M_25M_LSIO_GPIO4_IO16
> 	IMX8QM_ENET1_REFCLK_125M_25M	3
> +#define IMX8QM_ENET1_MDIO_CONN_ENET1_MDIO
> 	IMX8QM_ENET1_MDIO		0
> +#define IMX8QM_ENET1_MDIO_DMA_I2C4_SDA
> 	IMX8QM_ENET1_MDIO		1
> +#define IMX8QM_ENET1_MDIO_LSIO_GPIO4_IO17
> 	IMX8QM_ENET1_MDIO		3
> +#define IMX8QM_ENET1_MDC_CONN_ENET1_MDC
> 	IMX8QM_ENET1_MDC		0
> +#define IMX8QM_ENET1_MDC_DMA_I2C4_SCL
> 	IMX8QM_ENET1_MDC		1
> +#define IMX8QM_ENET1_MDC_LSIO_GPIO4_IO18
> 	IMX8QM_ENET1_MDC		3
> +#define IMX8QM_QSPI1A_SS0_B_LSIO_QSPI1A_SS0_B
> 	IMX8QM_QSPI1A_SS0_B		0
> +#define IMX8QM_QSPI1A_SS0_B_LSIO_GPIO4_IO19
> 	IMX8QM_QSPI1A_SS0_B		3
> +#define IMX8QM_QSPI1A_SS1_B_LSIO_QSPI1A_SS1_B
> 	IMX8QM_QSPI1A_SS1_B		0
> +#define IMX8QM_QSPI1A_SS1_B_LSIO_QSPI1A_SCLK2
> 	IMX8QM_QSPI1A_SS1_B		1
> +#define IMX8QM_QSPI1A_SS1_B_LSIO_GPIO4_IO20
> 	IMX8QM_QSPI1A_SS1_B		3
> +#define IMX8QM_QSPI1A_SCLK_LSIO_QSPI1A_SCLK
> 	IMX8QM_QSPI1A_SCLK		0
> +#define IMX8QM_QSPI1A_SCLK_LSIO_GPIO4_IO21
> 	IMX8QM_QSPI1A_SCLK		3
> +#define IMX8QM_QSPI1A_DQS_LSIO_QSPI1A_DQS
> 	IMX8QM_QSPI1A_DQS		0
> +#define IMX8QM_QSPI1A_DQS_LSIO_GPIO4_IO22
> 	IMX8QM_QSPI1A_DQS		3
> +#define IMX8QM_QSPI1A_DATA3_LSIO_QSPI1A_DATA3
> 	IMX8QM_QSPI1A_DATA3		0
> +#define IMX8QM_QSPI1A_DATA3_DMA_I2C1_SDA
> 	IMX8QM_QSPI1A_DATA3		1
> +#define IMX8QM_QSPI1A_DATA3_CONN_USB_OTG1_OC
> 	IMX8QM_QSPI1A_DATA3		2
> +#define IMX8QM_QSPI1A_DATA3_LSIO_GPIO4_IO23
> 	IMX8QM_QSPI1A_DATA3		3
> +#define IMX8QM_QSPI1A_DATA2_LSIO_QSPI1A_DATA2
> 	IMX8QM_QSPI1A_DATA2		0
> +#define IMX8QM_QSPI1A_DATA2_DMA_I2C1_SCL
> 	IMX8QM_QSPI1A_DATA2		1
> +#define IMX8QM_QSPI1A_DATA2_CONN_USB_OTG2_PWR
> 	IMX8QM_QSPI1A_DATA2		2
> +#define IMX8QM_QSPI1A_DATA2_LSIO_GPIO4_IO24
> 	IMX8QM_QSPI1A_DATA2		3
> +#define IMX8QM_QSPI1A_DATA1_LSIO_QSPI1A_DATA1
> 	IMX8QM_QSPI1A_DATA1		0
> +#define IMX8QM_QSPI1A_DATA1_DMA_I2C1_SDA
> 	IMX8QM_QSPI1A_DATA1		1
> +#define IMX8QM_QSPI1A_DATA1_CONN_USB_OTG2_OC
> 	IMX8QM_QSPI1A_DATA1		2
> +#define IMX8QM_QSPI1A_DATA1_LSIO_GPIO4_IO25
> 	IMX8QM_QSPI1A_DATA1		3
> +#define IMX8QM_QSPI1A_DATA0_LSIO_QSPI1A_DATA0
> 	IMX8QM_QSPI1A_DATA0		0
> +#define IMX8QM_QSPI1A_DATA0_LSIO_GPIO4_IO26
> 	IMX8QM_QSPI1A_DATA0		3
> +#define IMX8QM_QSPI0A_DATA0_LSIO_QSPI0A_DATA0
> 	IMX8QM_QSPI0A_DATA0		0
> +#define IMX8QM_QSPI0A_DATA1_LSIO_QSPI0A_DATA1
> 	IMX8QM_QSPI0A_DATA1		0
> +#define IMX8QM_QSPI0A_DATA2_LSIO_QSPI0A_DATA2
> 	IMX8QM_QSPI0A_DATA2		0
> +#define IMX8QM_QSPI0A_DATA3_LSIO_QSPI0A_DATA3
> 	IMX8QM_QSPI0A_DATA3		0
> +#define IMX8QM_QSPI0A_DQS_LSIO_QSPI0A_DQS
> 	IMX8QM_QSPI0A_DQS		0
> +#define IMX8QM_QSPI0A_SS0_B_LSIO_QSPI0A_SS0_B
> 	IMX8QM_QSPI0A_SS0_B		0
> +#define IMX8QM_QSPI0A_SS1_B_LSIO_QSPI0A_SS1_B
> 	IMX8QM_QSPI0A_SS1_B		0
> +#define IMX8QM_QSPI0A_SS1_B_LSIO_QSPI0A_SCLK2
> 	IMX8QM_QSPI0A_SS1_B		1
> +#define IMX8QM_QSPI0A_SCLK_LSIO_QSPI0A_SCLK
> 	IMX8QM_QSPI0A_SCLK		0
> +#define IMX8QM_QSPI0B_SCLK_LSIO_QSPI0B_SCLK
> 	IMX8QM_QSPI0B_SCLK		0
> +#define IMX8QM_QSPI0B_DATA0_LSIO_QSPI0B_DATA0
> 	IMX8QM_QSPI0B_DATA0		0
> +#define IMX8QM_QSPI0B_DATA1_LSIO_QSPI0B_DATA1
> 	IMX8QM_QSPI0B_DATA1		0
> +#define IMX8QM_QSPI0B_DATA2_LSIO_QSPI0B_DATA2
> 	IMX8QM_QSPI0B_DATA2		0
> +#define IMX8QM_QSPI0B_DATA3_LSIO_QSPI0B_DATA3
> 	IMX8QM_QSPI0B_DATA3		0
> +#define IMX8QM_QSPI0B_DQS_LSIO_QSPI0B_DQS
> 	IMX8QM_QSPI0B_DQS		0
> +#define IMX8QM_QSPI0B_SS0_B_LSIO_QSPI0B_SS0_B
> 	IMX8QM_QSPI0B_SS0_B		0
> +#define IMX8QM_QSPI0B_SS1_B_LSIO_QSPI0B_SS1_B
> 	IMX8QM_QSPI0B_SS1_B		0
> +#define IMX8QM_QSPI0B_SS1_B_LSIO_QSPI0B_SCLK2
> 	IMX8QM_QSPI0B_SS1_B		1
> +#define IMX8QM_PCIE_CTRL0_CLKREQ_B_HSIO_PCIE0_CLKREQ_B
> 	IMX8QM_PCIE_CTRL0_CLKREQ_B	0
> +#define IMX8QM_PCIE_CTRL0_CLKREQ_B_LSIO_GPIO4_IO27
> 	IMX8QM_PCIE_CTRL0_CLKREQ_B	3
> +#define IMX8QM_PCIE_CTRL0_WAKE_B_HSIO_PCIE0_WAKE_B
> 	IMX8QM_PCIE_CTRL0_WAKE_B	0
> +#define IMX8QM_PCIE_CTRL0_WAKE_B_LSIO_GPIO4_IO28
> 	IMX8QM_PCIE_CTRL0_WAKE_B	3
> +#define IMX8QM_PCIE_CTRL0_PERST_B_HSIO_PCIE0_PERST_B
> 	IMX8QM_PCIE_CTRL0_PERST_B	0
> +#define IMX8QM_PCIE_CTRL0_PERST_B_LSIO_GPIO4_IO29
> 	IMX8QM_PCIE_CTRL0_PERST_B	3
> +#define IMX8QM_PCIE_CTRL1_CLKREQ_B_HSIO_PCIE1_CLKREQ_B
> 	IMX8QM_PCIE_CTRL1_CLKREQ_B	0
> +#define IMX8QM_PCIE_CTRL1_CLKREQ_B_DMA_I2C1_SDA
> 	IMX8QM_PCIE_CTRL1_CLKREQ_B	1
> +#define IMX8QM_PCIE_CTRL1_CLKREQ_B_CONN_USB_OTG2_OC
> 	IMX8QM_PCIE_CTRL1_CLKREQ_B	2
> +#define IMX8QM_PCIE_CTRL1_CLKREQ_B_LSIO_GPIO4_IO30
> 	IMX8QM_PCIE_CTRL1_CLKREQ_B	3
> +#define IMX8QM_PCIE_CTRL1_WAKE_B_HSIO_PCIE1_WAKE_B
> 	IMX8QM_PCIE_CTRL1_WAKE_B	0
> +#define IMX8QM_PCIE_CTRL1_WAKE_B_DMA_I2C1_SCL
> 	IMX8QM_PCIE_CTRL1_WAKE_B	1
> +#define IMX8QM_PCIE_CTRL1_WAKE_B_CONN_USB_OTG2_PWR
> 	IMX8QM_PCIE_CTRL1_WAKE_B	2
> +#define IMX8QM_PCIE_CTRL1_WAKE_B_LSIO_GPIO4_IO31
> 	IMX8QM_PCIE_CTRL1_WAKE_B	3
> +#define IMX8QM_PCIE_CTRL1_PERST_B_HSIO_PCIE1_PERST_B
> 	IMX8QM_PCIE_CTRL1_PERST_B	0
> +#define IMX8QM_PCIE_CTRL1_PERST_B_DMA_I2C1_SCL
> 	IMX8QM_PCIE_CTRL1_PERST_B	1
> +#define IMX8QM_PCIE_CTRL1_PERST_B_CONN_USB_OTG1_PWR
> 	IMX8QM_PCIE_CTRL1_PERST_B	2
> +#define IMX8QM_PCIE_CTRL1_PERST_B_LSIO_GPIO5_IO00
> 	IMX8QM_PCIE_CTRL1_PERST_B	3
> +#define IMX8QM_USB_HSIC0_DATA_CONN_USB_HSIC0_DATA
> 	IMX8QM_USB_HSIC0_DATA		0
> +#define IMX8QM_USB_HSIC0_DATA_DMA_I2C1_SDA
> 	IMX8QM_USB_HSIC0_DATA		1
> +#define IMX8QM_USB_HSIC0_DATA_LSIO_GPIO5_IO01
> 	IMX8QM_USB_HSIC0_DATA		3
> +#define IMX8QM_USB_HSIC0_STROBE_CONN_USB_HSIC0_STROBE
> 	IMX8QM_USB_HSIC0_STROBE		0
> +#define IMX8QM_USB_HSIC0_STROBE_DMA_I2C1_SCL
> 	IMX8QM_USB_HSIC0_STROBE		1
> +#define IMX8QM_USB_HSIC0_STROBE_LSIO_GPIO5_IO02
> 	IMX8QM_USB_HSIC0_STROBE		3
> +#define IMX8QM_EMMC0_CLK_CONN_EMMC0_CLK
> 	IMX8QM_EMMC0_CLK		0
> +#define IMX8QM_EMMC0_CLK_CONN_NAND_READY_B
> 	IMX8QM_EMMC0_CLK		1
> +#define IMX8QM_EMMC0_CMD_CONN_EMMC0_CMD
> 	IMX8QM_EMMC0_CMD		0
> +#define IMX8QM_EMMC0_CMD_CONN_NAND_DQS
> 	IMX8QM_EMMC0_CMD		1
> +#define IMX8QM_EMMC0_CMD_AUD_MQS_R
> 	IMX8QM_EMMC0_CMD		2
> +#define IMX8QM_EMMC0_CMD_LSIO_GPIO5_IO03
> 	IMX8QM_EMMC0_CMD		3
> +#define IMX8QM_EMMC0_DATA0_CONN_EMMC0_DATA0
> 	IMX8QM_EMMC0_DATA0		0
> +#define IMX8QM_EMMC0_DATA0_CONN_NAND_DATA00
> 	IMX8QM_EMMC0_DATA0		1
> +#define IMX8QM_EMMC0_DATA0_LSIO_GPIO5_IO04
> 	IMX8QM_EMMC0_DATA0		3
> +#define IMX8QM_EMMC0_DATA1_CONN_EMMC0_DATA1
> 	IMX8QM_EMMC0_DATA1		0
> +#define IMX8QM_EMMC0_DATA1_CONN_NAND_DATA01
> 	IMX8QM_EMMC0_DATA1		1
> +#define IMX8QM_EMMC0_DATA1_LSIO_GPIO5_IO05
> 	IMX8QM_EMMC0_DATA1		3
> +#define IMX8QM_EMMC0_DATA2_CONN_EMMC0_DATA2
> 	IMX8QM_EMMC0_DATA2		0
> +#define IMX8QM_EMMC0_DATA2_CONN_NAND_DATA02
> 	IMX8QM_EMMC0_DATA2		1
> +#define IMX8QM_EMMC0_DATA2_LSIO_GPIO5_IO06
> 	IMX8QM_EMMC0_DATA2		3
> +#define IMX8QM_EMMC0_DATA3_CONN_EMMC0_DATA3
> 	IMX8QM_EMMC0_DATA3		0
> +#define IMX8QM_EMMC0_DATA3_CONN_NAND_DATA03
> 	IMX8QM_EMMC0_DATA3		1
> +#define IMX8QM_EMMC0_DATA3_LSIO_GPIO5_IO07
> 	IMX8QM_EMMC0_DATA3		3
> +#define IMX8QM_EMMC0_DATA4_CONN_EMMC0_DATA4
> 	IMX8QM_EMMC0_DATA4		0
> +#define IMX8QM_EMMC0_DATA4_CONN_NAND_DATA04
> 	IMX8QM_EMMC0_DATA4		1
> +#define IMX8QM_EMMC0_DATA4_LSIO_GPIO5_IO08
> 	IMX8QM_EMMC0_DATA4		3
> +#define IMX8QM_EMMC0_DATA5_CONN_EMMC0_DATA5
> 	IMX8QM_EMMC0_DATA5		0
> +#define IMX8QM_EMMC0_DATA5_CONN_NAND_DATA05
> 	IMX8QM_EMMC0_DATA5		1
> +#define IMX8QM_EMMC0_DATA5_LSIO_GPIO5_IO09
> 	IMX8QM_EMMC0_DATA5		3
> +#define IMX8QM_EMMC0_DATA6_CONN_EMMC0_DATA6
> 	IMX8QM_EMMC0_DATA6		0
> +#define IMX8QM_EMMC0_DATA6_CONN_NAND_DATA06
> 	IMX8QM_EMMC0_DATA6		1
> +#define IMX8QM_EMMC0_DATA6_LSIO_GPIO5_IO10
> 	IMX8QM_EMMC0_DATA6		3
> +#define IMX8QM_EMMC0_DATA7_CONN_EMMC0_DATA7
> 	IMX8QM_EMMC0_DATA7		0
> +#define IMX8QM_EMMC0_DATA7_CONN_NAND_DATA07
> 	IMX8QM_EMMC0_DATA7		1
> +#define IMX8QM_EMMC0_DATA7_LSIO_GPIO5_IO11
> 	IMX8QM_EMMC0_DATA7		3
> +#define IMX8QM_EMMC0_STROBE_CONN_EMMC0_STROBE
> 	IMX8QM_EMMC0_STROBE		0
> +#define IMX8QM_EMMC0_STROBE_CONN_NAND_CLE
> 	IMX8QM_EMMC0_STROBE		1
> +#define IMX8QM_EMMC0_STROBE_LSIO_GPIO5_IO12
> 	IMX8QM_EMMC0_STROBE		3
> +#define IMX8QM_EMMC0_RESET_B_CONN_EMMC0_RESET_B
> 	IMX8QM_EMMC0_RESET_B		0
> +#define IMX8QM_EMMC0_RESET_B_CONN_NAND_WP_B
> 	IMX8QM_EMMC0_RESET_B		1
> +#define IMX8QM_EMMC0_RESET_B_CONN_USDHC1_VSELECT
> 	IMX8QM_EMMC0_RESET_B		2
> +#define IMX8QM_EMMC0_RESET_B_LSIO_GPIO5_IO13
> 	IMX8QM_EMMC0_RESET_B		3
> +#define IMX8QM_USDHC1_CLK_CONN_USDHC1_CLK
> 	IMX8QM_USDHC1_CLK		0
> +#define IMX8QM_USDHC1_CLK_AUD_MQS_R
> 	IMX8QM_USDHC1_CLK		1
> +#define IMX8QM_USDHC1_CMD_CONN_USDHC1_CMD
> 	IMX8QM_USDHC1_CMD		0
> +#define IMX8QM_USDHC1_CMD_AUD_MQS_L
> 	IMX8QM_USDHC1_CMD		1
> +#define IMX8QM_USDHC1_CMD_LSIO_GPIO5_IO14
> 	IMX8QM_USDHC1_CMD		3
> +#define IMX8QM_USDHC1_DATA0_CONN_USDHC1_DATA0
> 	IMX8QM_USDHC1_DATA0		0
> +#define IMX8QM_USDHC1_DATA0_CONN_NAND_RE_N
> 	IMX8QM_USDHC1_DATA0		1
> +#define IMX8QM_USDHC1_DATA0_LSIO_GPIO5_IO15
> 	IMX8QM_USDHC1_DATA0		3
> +#define IMX8QM_USDHC1_DATA1_CONN_USDHC1_DATA1
> 	IMX8QM_USDHC1_DATA1		0
> +#define IMX8QM_USDHC1_DATA1_CONN_NAND_RE_P
> 	IMX8QM_USDHC1_DATA1		1
> +#define IMX8QM_USDHC1_DATA1_LSIO_GPIO5_IO16
> 	IMX8QM_USDHC1_DATA1		3
> +#define IMX8QM_USDHC1_DATA2_CONN_USDHC1_DATA2
> 	IMX8QM_USDHC1_DATA2		0
> +#define IMX8QM_USDHC1_DATA2_CONN_NAND_DQS_N
> 	IMX8QM_USDHC1_DATA2		1
> +#define IMX8QM_USDHC1_DATA2_LSIO_GPIO5_IO17
> 	IMX8QM_USDHC1_DATA2		3
> +#define IMX8QM_USDHC1_DATA3_CONN_USDHC1_DATA3
> 	IMX8QM_USDHC1_DATA3		0
> +#define IMX8QM_USDHC1_DATA3_CONN_NAND_DQS_P
> 	IMX8QM_USDHC1_DATA3		1
> +#define IMX8QM_USDHC1_DATA3_LSIO_GPIO5_IO18
> 	IMX8QM_USDHC1_DATA3		3
> +#define IMX8QM_USDHC1_DATA4_CONN_USDHC1_DATA4
> 	IMX8QM_USDHC1_DATA4		0
> +#define IMX8QM_USDHC1_DATA4_CONN_NAND_CE0_B
> 	IMX8QM_USDHC1_DATA4		1
> +#define IMX8QM_USDHC1_DATA4_AUD_MQS_R
> 	IMX8QM_USDHC1_DATA4		2
> +#define IMX8QM_USDHC1_DATA4_LSIO_GPIO5_IO19
> 	IMX8QM_USDHC1_DATA4		3
> +#define IMX8QM_USDHC1_DATA5_CONN_USDHC1_DATA5
> 	IMX8QM_USDHC1_DATA5		0
> +#define IMX8QM_USDHC1_DATA5_CONN_NAND_RE_B
> 	IMX8QM_USDHC1_DATA5		1
> +#define IMX8QM_USDHC1_DATA5_AUD_MQS_L
> 	IMX8QM_USDHC1_DATA5		2
> +#define IMX8QM_USDHC1_DATA5_LSIO_GPIO5_IO20
> 	IMX8QM_USDHC1_DATA5		3
> +#define IMX8QM_USDHC1_DATA6_CONN_USDHC1_DATA6
> 	IMX8QM_USDHC1_DATA6		0
> +#define IMX8QM_USDHC1_DATA6_CONN_NAND_WE_B
> 	IMX8QM_USDHC1_DATA6		1
> +#define IMX8QM_USDHC1_DATA6_CONN_USDHC1_WP
> 	IMX8QM_USDHC1_DATA6		2
> +#define IMX8QM_USDHC1_DATA6_LSIO_GPIO5_IO21
> 	IMX8QM_USDHC1_DATA6		3
> +#define IMX8QM_USDHC1_DATA7_CONN_USDHC1_DATA7
> 	IMX8QM_USDHC1_DATA7		0
> +#define IMX8QM_USDHC1_DATA7_CONN_NAND_ALE
> 	IMX8QM_USDHC1_DATA7		1
> +#define IMX8QM_USDHC1_DATA7_CONN_USDHC1_CD_B
> 	IMX8QM_USDHC1_DATA7		2
> +#define IMX8QM_USDHC1_DATA7_LSIO_GPIO5_IO22
> 	IMX8QM_USDHC1_DATA7		3
> +#define IMX8QM_USDHC1_STROBE_CONN_USDHC1_STROBE
> 	IMX8QM_USDHC1_STROBE		0
> +#define IMX8QM_USDHC1_STROBE_CONN_NAND_CE1_B
> 	IMX8QM_USDHC1_STROBE		1
> +#define IMX8QM_USDHC1_STROBE_CONN_USDHC1_RESET_B
> 	IMX8QM_USDHC1_STROBE		2
> +#define IMX8QM_USDHC1_STROBE_LSIO_GPIO5_IO23
> 	IMX8QM_USDHC1_STROBE		3
> +#define IMX8QM_USDHC2_CLK_CONN_USDHC2_CLK
> 	IMX8QM_USDHC2_CLK		0
> +#define IMX8QM_USDHC2_CLK_AUD_MQS_R
> 	IMX8QM_USDHC2_CLK		1
> +#define IMX8QM_USDHC2_CLK_LSIO_GPIO5_IO24
> 	IMX8QM_USDHC2_CLK		3
> +#define IMX8QM_USDHC2_CMD_CONN_USDHC2_CMD
> 	IMX8QM_USDHC2_CMD		0
> +#define IMX8QM_USDHC2_CMD_AUD_MQS_L
> 	IMX8QM_USDHC2_CMD		1
> +#define IMX8QM_USDHC2_CMD_LSIO_GPIO5_IO25
> 	IMX8QM_USDHC2_CMD		3
> +#define IMX8QM_USDHC2_DATA0_CONN_USDHC2_DATA0
> 	IMX8QM_USDHC2_DATA0		0
> +#define IMX8QM_USDHC2_DATA0_DMA_UART4_RX
> 	IMX8QM_USDHC2_DATA0		1
> +#define IMX8QM_USDHC2_DATA0_LSIO_GPIO5_IO26
> 	IMX8QM_USDHC2_DATA0		3
> +#define IMX8QM_USDHC2_DATA1_CONN_USDHC2_DATA1
> 	IMX8QM_USDHC2_DATA1		0
> +#define IMX8QM_USDHC2_DATA1_DMA_UART4_TX
> 	IMX8QM_USDHC2_DATA1		1
> +#define IMX8QM_USDHC2_DATA1_LSIO_GPIO5_IO27
> 	IMX8QM_USDHC2_DATA1		3
> +#define IMX8QM_USDHC2_DATA2_CONN_USDHC2_DATA2
> 	IMX8QM_USDHC2_DATA2		0
> +#define IMX8QM_USDHC2_DATA2_DMA_UART4_CTS_B
> 	IMX8QM_USDHC2_DATA2		1
> +#define IMX8QM_USDHC2_DATA2_LSIO_GPIO5_IO28
> 	IMX8QM_USDHC2_DATA2		3
> +#define IMX8QM_USDHC2_DATA3_CONN_USDHC2_DATA3
> 	IMX8QM_USDHC2_DATA3		0
> +#define IMX8QM_USDHC2_DATA3_DMA_UART4_RTS_B
> 	IMX8QM_USDHC2_DATA3		1
> +#define IMX8QM_USDHC2_DATA3_LSIO_GPIO5_IO29
> 	IMX8QM_USDHC2_DATA3		3
> +#define IMX8QM_ENET0_RGMII_TXC_CONN_ENET0_RGMII_TXC
> 	IMX8QM_ENET0_RGMII_TXC		0
> +#define IMX8QM_ENET0_RGMII_TXC_CONN_ENET0_RCLK50M_OUT
> 	IMX8QM_ENET0_RGMII_TXC		1
> +#define IMX8QM_ENET0_RGMII_TXC_CONN_ENET0_RCLK50M_IN
> 	IMX8QM_ENET0_RGMII_TXC		2
> +#define IMX8QM_ENET0_RGMII_TXC_LSIO_GPIO5_IO30
> 	IMX8QM_ENET0_RGMII_TXC		3
> +#define IMX8QM_ENET0_RGMII_TX_CTL_CONN_ENET0_RGMII_TX_CTL
> 	IMX8QM_ENET0_RGMII_TX_CTL	0
> +#define IMX8QM_ENET0_RGMII_TX_CTL_LSIO_GPIO5_IO31
> 	IMX8QM_ENET0_RGMII_TX_CTL	3
> +#define IMX8QM_ENET0_RGMII_TXD0_CONN_ENET0_RGMII_TXD0
> 	IMX8QM_ENET0_RGMII_TXD0		0
> +#define IMX8QM_ENET0_RGMII_TXD0_LSIO_GPIO6_IO00
> 	IMX8QM_ENET0_RGMII_TXD0		3
> +#define IMX8QM_ENET0_RGMII_TXD1_CONN_ENET0_RGMII_TXD1
> 	IMX8QM_ENET0_RGMII_TXD1		0
> +#define IMX8QM_ENET0_RGMII_TXD1_LSIO_GPIO6_IO01
> 	IMX8QM_ENET0_RGMII_TXD1		3
> +#define IMX8QM_ENET0_RGMII_TXD2_CONN_ENET0_RGMII_TXD2
> 	IMX8QM_ENET0_RGMII_TXD2		0
> +#define IMX8QM_ENET0_RGMII_TXD2_DMA_UART3_TX
> 	IMX8QM_ENET0_RGMII_TXD2		1
> +#define IMX8QM_ENET0_RGMII_TXD2_VPU_TSI_S1_VID
> 	IMX8QM_ENET0_RGMII_TXD2		2
> +#define IMX8QM_ENET0_RGMII_TXD2_LSIO_GPIO6_IO02
> 	IMX8QM_ENET0_RGMII_TXD2		3
> +#define IMX8QM_ENET0_RGMII_TXD3_CONN_ENET0_RGMII_TXD3
> 	IMX8QM_ENET0_RGMII_TXD3		0
> +#define IMX8QM_ENET0_RGMII_TXD3_DMA_UART3_RTS_B
> 	IMX8QM_ENET0_RGMII_TXD3		1
> +#define IMX8QM_ENET0_RGMII_TXD3_VPU_TSI_S1_SYNC
> 	IMX8QM_ENET0_RGMII_TXD3		2
> +#define IMX8QM_ENET0_RGMII_TXD3_LSIO_GPIO6_IO03
> 	IMX8QM_ENET0_RGMII_TXD3		3
> +#define IMX8QM_ENET0_RGMII_RXC_CONN_ENET0_RGMII_RXC
> 	IMX8QM_ENET0_RGMII_RXC		0
> +#define IMX8QM_ENET0_RGMII_RXC_DMA_UART3_CTS_B
> 	IMX8QM_ENET0_RGMII_RXC		1
> +#define IMX8QM_ENET0_RGMII_RXC_VPU_TSI_S1_DATA
> 	IMX8QM_ENET0_RGMII_RXC		2
> +#define IMX8QM_ENET0_RGMII_RXC_LSIO_GPIO6_IO04
> 	IMX8QM_ENET0_RGMII_RXC		3
> +#define IMX8QM_ENET0_RGMII_RX_CTL_CONN_ENET0_RGMII_RX_CTL
> 	IMX8QM_ENET0_RGMII_RX_CTL	0
> +#define IMX8QM_ENET0_RGMII_RX_CTL_VPU_TSI_S0_VID
> 	IMX8QM_ENET0_RGMII_RX_CTL	2
> +#define IMX8QM_ENET0_RGMII_RX_CTL_LSIO_GPIO6_IO05
> 	IMX8QM_ENET0_RGMII_RX_CTL	3
> +#define IMX8QM_ENET0_RGMII_RXD0_CONN_ENET0_RGMII_RXD0
> 	IMX8QM_ENET0_RGMII_RXD0		0
> +#define IMX8QM_ENET0_RGMII_RXD0_VPU_TSI_S0_SYNC
> 	IMX8QM_ENET0_RGMII_RXD0		2
> +#define IMX8QM_ENET0_RGMII_RXD0_LSIO_GPIO6_IO06
> 	IMX8QM_ENET0_RGMII_RXD0		3
> +#define IMX8QM_ENET0_RGMII_RXD1_CONN_ENET0_RGMII_RXD1
> 	IMX8QM_ENET0_RGMII_RXD1		0
> +#define IMX8QM_ENET0_RGMII_RXD1_VPU_TSI_S0_DATA
> 	IMX8QM_ENET0_RGMII_RXD1		2
> +#define IMX8QM_ENET0_RGMII_RXD1_LSIO_GPIO6_IO07
> 	IMX8QM_ENET0_RGMII_RXD1		3
> +#define IMX8QM_ENET0_RGMII_RXD2_CONN_ENET0_RGMII_RXD2
> 	IMX8QM_ENET0_RGMII_RXD2		0
> +#define IMX8QM_ENET0_RGMII_RXD2_CONN_ENET0_RMII_RX_ER
> 	IMX8QM_ENET0_RGMII_RXD2		1
> +#define IMX8QM_ENET0_RGMII_RXD2_VPU_TSI_S0_CLK
> 	IMX8QM_ENET0_RGMII_RXD2		2
> +#define IMX8QM_ENET0_RGMII_RXD2_LSIO_GPIO6_IO08
> 	IMX8QM_ENET0_RGMII_RXD2		3
> +#define IMX8QM_ENET0_RGMII_RXD3_CONN_ENET0_RGMII_RXD3
> 	IMX8QM_ENET0_RGMII_RXD3		0
> +#define IMX8QM_ENET0_RGMII_RXD3_DMA_UART3_RX
> 	IMX8QM_ENET0_RGMII_RXD3		1
> +#define IMX8QM_ENET0_RGMII_RXD3_VPU_TSI_S1_CLK
> 	IMX8QM_ENET0_RGMII_RXD3		2
> +#define IMX8QM_ENET0_RGMII_RXD3_LSIO_GPIO6_IO09
> 	IMX8QM_ENET0_RGMII_RXD3		3
> +#define IMX8QM_ENET1_RGMII_TXC_CONN_ENET1_RGMII_TXC
> 	IMX8QM_ENET1_RGMII_TXC		0
> +#define IMX8QM_ENET1_RGMII_TXC_CONN_ENET1_RCLK50M_OUT
> 	IMX8QM_ENET1_RGMII_TXC		1
> +#define IMX8QM_ENET1_RGMII_TXC_CONN_ENET1_RCLK50M_IN
> 	IMX8QM_ENET1_RGMII_TXC		2
> +#define IMX8QM_ENET1_RGMII_TXC_LSIO_GPIO6_IO10
> 	IMX8QM_ENET1_RGMII_TXC		3
> +#define IMX8QM_ENET1_RGMII_TX_CTL_CONN_ENET1_RGMII_TX_CTL
> 	IMX8QM_ENET1_RGMII_TX_CTL	0
> +#define IMX8QM_ENET1_RGMII_TX_CTL_LSIO_GPIO6_IO11
> 	IMX8QM_ENET1_RGMII_TX_CTL	3
> +#define IMX8QM_ENET1_RGMII_TXD0_CONN_ENET1_RGMII_TXD0
> 	IMX8QM_ENET1_RGMII_TXD0		0
> +#define IMX8QM_ENET1_RGMII_TXD0_LSIO_GPIO6_IO12
> 	IMX8QM_ENET1_RGMII_TXD0		3
> +#define IMX8QM_ENET1_RGMII_TXD1_CONN_ENET1_RGMII_TXD1
> 	IMX8QM_ENET1_RGMII_TXD1		0
> +#define IMX8QM_ENET1_RGMII_TXD1_LSIO_GPIO6_IO13
> 	IMX8QM_ENET1_RGMII_TXD1		3
> +#define IMX8QM_ENET1_RGMII_TXD2_CONN_ENET1_RGMII_TXD2
> 	IMX8QM_ENET1_RGMII_TXD2		0
> +#define IMX8QM_ENET1_RGMII_TXD2_DMA_UART3_TX
> 	IMX8QM_ENET1_RGMII_TXD2		1
> +#define IMX8QM_ENET1_RGMII_TXD2_VPU_TSI_S1_VID
> 	IMX8QM_ENET1_RGMII_TXD2		2
> +#define IMX8QM_ENET1_RGMII_TXD2_LSIO_GPIO6_IO14
> 	IMX8QM_ENET1_RGMII_TXD2		3
> +#define IMX8QM_ENET1_RGMII_TXD3_CONN_ENET1_RGMII_TXD3
> 	IMX8QM_ENET1_RGMII_TXD3		0
> +#define IMX8QM_ENET1_RGMII_TXD3_DMA_UART3_RTS_B
> 	IMX8QM_ENET1_RGMII_TXD3		1
> +#define IMX8QM_ENET1_RGMII_TXD3_VPU_TSI_S1_SYNC
> 	IMX8QM_ENET1_RGMII_TXD3		2
> +#define IMX8QM_ENET1_RGMII_TXD3_LSIO_GPIO6_IO15
> 	IMX8QM_ENET1_RGMII_TXD3		3
> +#define IMX8QM_ENET1_RGMII_RXC_CONN_ENET1_RGMII_RXC
> 	IMX8QM_ENET1_RGMII_RXC		0
> +#define IMX8QM_ENET1_RGMII_RXC_DMA_UART3_CTS_B
> 	IMX8QM_ENET1_RGMII_RXC		1
> +#define IMX8QM_ENET1_RGMII_RXC_VPU_TSI_S1_DATA
> 	IMX8QM_ENET1_RGMII_RXC		2
> +#define IMX8QM_ENET1_RGMII_RXC_LSIO_GPIO6_IO16
> 	IMX8QM_ENET1_RGMII_RXC		3
> +#define IMX8QM_ENET1_RGMII_RX_CTL_CONN_ENET1_RGMII_RX_CTL
> 	IMX8QM_ENET1_RGMII_RX_CTL	0
> +#define IMX8QM_ENET1_RGMII_RX_CTL_VPU_TSI_S0_VID
> 	IMX8QM_ENET1_RGMII_RX_CTL	2
> +#define IMX8QM_ENET1_RGMII_RX_CTL_LSIO_GPIO6_IO17
> 	IMX8QM_ENET1_RGMII_RX_CTL	3
> +#define IMX8QM_ENET1_RGMII_RXD0_CONN_ENET1_RGMII_RXD0
> 	IMX8QM_ENET1_RGMII_RXD0		0
> +#define IMX8QM_ENET1_RGMII_RXD0_VPU_TSI_S0_SYNC
> 	IMX8QM_ENET1_RGMII_RXD0		2
> +#define IMX8QM_ENET1_RGMII_RXD0_LSIO_GPIO6_IO18
> 	IMX8QM_ENET1_RGMII_RXD0		3
> +#define IMX8QM_ENET1_RGMII_RXD1_CONN_ENET1_RGMII_RXD1
> 	IMX8QM_ENET1_RGMII_RXD1		0
> +#define IMX8QM_ENET1_RGMII_RXD1_VPU_TSI_S0_DATA
> 	IMX8QM_ENET1_RGMII_RXD1		2
> +#define IMX8QM_ENET1_RGMII_RXD1_LSIO_GPIO6_IO19
> 	IMX8QM_ENET1_RGMII_RXD1		3
> +#define IMX8QM_ENET1_RGMII_RXD2_CONN_ENET1_RGMII_RXD2
> 	IMX8QM_ENET1_RGMII_RXD2		0
> +#define IMX8QM_ENET1_RGMII_RXD2_CONN_ENET1_RMII_RX_ER
> 	IMX8QM_ENET1_RGMII_RXD2		1
> +#define IMX8QM_ENET1_RGMII_RXD2_VPU_TSI_S0_CLK
> 	IMX8QM_ENET1_RGMII_RXD2		2
> +#define IMX8QM_ENET1_RGMII_RXD2_LSIO_GPIO6_IO20
> 	IMX8QM_ENET1_RGMII_RXD2		3
> +#define IMX8QM_ENET1_RGMII_RXD3_CONN_ENET1_RGMII_RXD3
> 	IMX8QM_ENET1_RGMII_RXD3		0
> +#define IMX8QM_ENET1_RGMII_RXD3_DMA_UART3_RX
> 	IMX8QM_ENET1_RGMII_RXD3		1
> +#define IMX8QM_ENET1_RGMII_RXD3_VPU_TSI_S1_CLK
> 	IMX8QM_ENET1_RGMII_RXD3		2
> +#define IMX8QM_ENET1_RGMII_RXD3_LSIO_GPIO6_IO21
> 	IMX8QM_ENET1_RGMII_RXD3		3
> +#define IMX8QM_COMP_CTL_GPIO_1V8_3V3_ENET_ENETB_PAD
> 	IMX8QM_COMP_CTL_GPIO_1V8_3V3_ENET_ENETB		0
> +#define IMX8QM_COMP_CTL_GPIO_1V8_3V3_ENET_ENETA_PAD
> 	IMX8QM_COMP_CTL_GPIO_1V8_3V3_ENET_ENETA		0
> +
> +#endif /* _IMX8QM_PADS_H */
> --
> 2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
