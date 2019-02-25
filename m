Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36278C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:23:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E8320578
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FMUx8kEr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kmSM8G0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E8320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rf/jQtA1uyy4VvdjI+7ziW/NbAIu68h+GFerbpE+aRM=; b=FMUx8kErshfl07
	Et1RCuJX9zO9qcTmdx1UbGCIYIu3LjyKym/7kIbuRxd5t0VoIPtsBWez1DvYQxNbvUoAWfAakNHJd
	jKMZvM0ai4m1XD0I1esxAQozeIEQk7jvgIRJ9HTbxZm/spvzh/HbazqE3SmB7uH/osVMi9J9GZEVL
	MNO1GRkuHAP1xgBDH6JmgWVW5EznGPRMIkxMXVCaqjk5NX4YpuY/Z95fXKwkYLEok1+uh6TrRwFrJ
	/NAFCxkgI7nxwHaTy3xG65Tqo75hddfZHBglQ0n8gT99mUqKHOkAMdAMT6hK4h5vZHpJA83dQM+H/
	JBrl/XVqWJ89jlnumWOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyGEZ-0002Fm-6Q; Mon, 25 Feb 2019 13:23:51 +0000
Received: from mail-eopbgr10087.outbound.protection.outlook.com ([40.107.1.87]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyGEV-0002FP-90
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 13:23:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7xv7X1v+iBMPE2PuYgIImz6PdGMc4CineF7pCcqrSI=;
 b=kmSM8G0jLlnnUnE/eTzoe7M2ZoXM96c6+NuDsq8Mhw/FikzrqqYAxi3EA9qS7gDwWJ0q67cD9Vxukzb7dyRPg2l0o/7+zTKj371m1uF9eAlJrHa1Oaf8XgZiW1x5rr01a/VRnaLxSgettyTbDX2AcAwdaMI9BYEOai5feuL1YUg=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Mon, 25 Feb 2019 13:23:41 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 13:23:41 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH 1/5] arm64: dts: imx8mq: Add SDMA nodes
Thread-Topic: [PATCH 1/5] arm64: dts: imx8mq: Add SDMA nodes
Thread-Index: AQHUzQx/QeEbizeFI0O2BFE6xP8gsqXwgIsA
Date: Mon, 25 Feb 2019 13:23:41 +0000
Message-ID: <f02865a5b9cd3cde711d818ccbb25f6b7b95a4cf.camel@nxp.com>
References: <20190225131722.10253-1-daniel.baluta@nxp.com>
In-Reply-To: <20190225131722.10253-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71287ff5-2c38-4645-6aa7-08d69b24759b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3485; 
x-ms-traffictypediagnostic: VI1PR0402MB3485:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0MDJNQjM0ODU7MjM6TWN2R0FjWnQ4UzZCWnhxcjQ2cHNSbHBM?=
 =?utf-8?B?VnJUdjkzYmhweVc3eVRrNEVYRXhyT0oyS1FlOXN0RHd3RWVXcmN2ZlpKS2p1?=
 =?utf-8?B?VE42RmFKN2ZxVFRNVXlMSWR0RzRjZEVGaUlwWmM4SEd3OEtCVDJIcTRPdzU2?=
 =?utf-8?B?SnBhWnIyYTFkd2RMTW5CNDVBNE9pYXNXdGJpUysxM2NSUkRxYnNGYk5JK0dl?=
 =?utf-8?B?R2xjKy82U0gwbVBmZGU2ZUpnOHZScjNLaXlZRHBXMmxNV1ZYRlhPNytrMEtT?=
 =?utf-8?B?U2tDU1ZwMTUyZjdZWGZrTGhHeDVkZFFCWXF2TmVYdmEzQ1ZGaUhNYjRzVmRs?=
 =?utf-8?B?Q2lxSCs3NVp2TFZETnZsR1g0TjJIUHFTSFRPS0xOYXNqQVRGMGNmNWpRL2dP?=
 =?utf-8?B?elJlaHZGYW4veVU3dzFQNStqdFc4TzF4djB2Umk3SVh5RTV1dTc0aGpVK3hr?=
 =?utf-8?B?VWMwRnlzNFZIekUwcEFPdnppRW4zK2FnbnlPd2JUQWt3QWt6K05EWkw0aVYw?=
 =?utf-8?B?TWQyU1FqSFpXWkhLK2pDWXlVM1ozUklsNWluWEp5WUdSRmZPUjhibjhhTEd0?=
 =?utf-8?B?SnppcUJOVmZLVGVzNmVjREM2UUUyR2E5ZjgwVlpDRE1Dak00VkhQRWQ4em9Q?=
 =?utf-8?B?QnVIZG1PV0lrZ2k5bEdSRXBmRVl3Qm5HaHpDQTB3TEgySVprOVZndGtYNjhP?=
 =?utf-8?B?amIvTHFpNVlaZjYyS3FHLzBKVnh5Wmc5UktYazlmT2t5YWwrbTNZZmFURkNI?=
 =?utf-8?B?LzdES1diZ1VxbWFmd2hOMnRmSDF5ZWdoWU9SazFCVzgzVGlBRW43UWp5VlA0?=
 =?utf-8?B?M2R1V0VYb3hWZ1lBV2pNVTA3Tkd1TXpHeDdBR1JPbktjM0VtMHBxbXNUWEVD?=
 =?utf-8?B?ZzJYUFNoNDBKRVpwQ3BJa0VkM1pTcDY3RGVwU1BWMmVoN1FYbEFrRjZ1NitM?=
 =?utf-8?B?MDNrb0lueWtIdzA0T3psb0k1U1IwczQvblZIdERtd2d5WGRjRVlNVlZ2N2xV?=
 =?utf-8?B?SVRDeisreHlRT0ZPcy9yemgzOGFlanRvQ0l1Z3lUeWFDYnVGc1pmWUVXVElr?=
 =?utf-8?B?NmNDWGRWaGdDWVYydVg5S0F0b3pSTmxocFg1RlZMV2FFLzFzSVdHcG01ZEEx?=
 =?utf-8?B?OHZRcFhvenR4a2d5ZCtaY3NlUE9lQmlvRVZDTXEybUVVZWxvQmFNaUQxbVpN?=
 =?utf-8?B?Q3dwcittQ3Y3NDNweE53UlNwQUFhUmlES0VHZHRERUZualMzakN4Sy81N2ZX?=
 =?utf-8?B?TTJvaEY5OFc5NVZUVnBLSjlRdStVV2pKcUt1RXZJWE1rcWVxT3o4L09Xa3M3?=
 =?utf-8?B?aGpaWEh1SUZFd0ExcGxrRXlUR1VZSTdpaEJWT1M2aGJ3SXIyeExEWlpUVktP?=
 =?utf-8?B?WTNtRzZYeDRzcS9oM2NqWktVa2grYmNvTXZlYThsOHNHYmpJZDVpSDhjajdD?=
 =?utf-8?B?REhMS3hmTlR0TGRCcWJXMUpPK0U1ZjFjU01uMXpvaTZ5Mld2M0hlcGZkaWd2?=
 =?utf-8?B?SHpYMDF0WU9lUWpGYlg4cHlSRGxxRFRwUElTMVc0WERqeGxKVFVHcitCOFds?=
 =?utf-8?B?eGRWdldHVjZnMWJVUmZLQ2k5OTVyV3k1S2NJcGlyRmZ4NUdrd0xhTlo0WFVo?=
 =?utf-8?B?aG1TS0hXTStoTGlJUjFCY2R1c25FMHh2OXpIU1dSdnRiVDYvTHNUWWpxR3Q1?=
 =?utf-8?B?NjF3MXdFNVc5Q1NFZVo0MzE5K1N5d0dlZVFnVVlwOTliTXpEZDVoWkxqVHF4?=
 =?utf-8?B?V3hVS0JGZE9jRFczOGRGWTJ5ZFZsNXErK2tJRERDYTAwNFFsTlhSU25kZW1R?=
 =?utf-8?B?YWI5OHZ2SlNWQ2crMWluSXM1VGkyRU5oUDZlWUltS2xWRi9iQT09?=
x-microsoft-antispam-prvs: <VI1PR0402MB348583A573668B834D0688DEF97A0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(6116002)(105586002)(106356001)(5660300002)(81166006)(71190400001)(81156014)(2351001)(97736004)(1730700003)(71200400001)(66066001)(478600001)(8676002)(14444005)(2906002)(3846002)(305945005)(86362001)(14454004)(7416002)(7736002)(6486002)(6436002)(316002)(5640700003)(6916009)(6246003)(6512007)(36756003)(256004)(26005)(476003)(54906003)(229853002)(4326008)(486006)(2501003)(446003)(68736007)(11346002)(44832011)(99286004)(76176011)(2616005)(8936002)(53936002)(102836004)(6506007)(186003)(118296001)(25786009)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3485;
 H:VI1PR0402MB3357.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4REqXvo+YqqM1u/Sxm/LrBmZX3BO2ynsY81FSsYltSUOILTGpkAl8MK/y3jHbDnTRBVk1cV5J7GfyG7zcgEBJnleNOuuySH/TwyDVWCYjx07x+G/wMknsBNU2HY85QJrJi5rpak91EL9Gt61iRdbx1nkb8rEMkV70TSyqTT0KO2WeX1ekXDkQdsg83pGWg+ijiO+TUy9FSZNXuJPOkhylO9n93/V8XCE5qm4lnVk5fwdMtmg14KX339YgoK2F4ZM0o8zWOJEF2W5r4EJbtnY0b7AoOK7tenaIllFGpaEYya1u9wOKkqCAG+VAE6QqIQ0VCZFtU4MCVW8R6avBELOySU6BJ06orcbJxEm5W2u2yvoBXnKlswYgVG4agBd7mSq8VERwjeUfNUDvTwG1MEZpc7LhHQ+ZLAulqCSdDBKIKY=
Content-ID: <75BE431F1FB38E41A58EBC99CA645D39@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71287ff5-2c38-4645-6aa7-08d69b24759b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 13:23:41.2270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3485
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_052347_316089_4A656299 
X-CRM114-Status: GOOD (  15.81  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "baruch@tkos.co.il" <baruch@tkos.co.il>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>,
 "ccaione@baylibre.com" <ccaione@baylibre.com>,
 "agx@sigxcpu.org" <agx@sigxcpu.org>, "angus@akkea.ca" <angus@akkea.ca>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Please ignore this, I sent it from the wrong repo. I swear that I
double checked.

Will sent v2 with correct base.


On Mon, 2019-02-25 at 13:17 +0000, Daniel Baluta wrote:
> SDMA1 is part of AIPS-3 region and SDMA2 is part
> of AIPS-1 region.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> [initial submit in i.MX internal tree]
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> [adaptation for linux-next]
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 22
> ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 9155bd4784eb..87839c5c8a7f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -234,6 +234,17 @@
>  				status = "disabled";
>  			};
>  
> +			sdma2: sdma@302c0000 {
> +				compatible = "fsl,imx8mq-sdma",
> "fsl,imx7d-sdma";
> +				reg = <0x302c0000 0x10000>;
> +				interrupts = <GIC_SPI 103
> IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_SDMA2_ROOT>,
> +					 <&clk IMX8MQ_CLK_SDMA2_ROOT>;
> +				clock-names = "ipg", "ahb";
> +				#dma-cells = <3>;
> +				fsl,sdma-ram-script-name =
> "imx/sdma/sdma-imx7d.bin";
> +			};
> +
>  			iomuxc: iomuxc@30330000 {
>  				compatible = "fsl,imx8mq-iomuxc";
>  				reg = <0x30330000 0x10000>;
> @@ -575,6 +586,17 @@
>  				status = "disabled";
>  			};
>  
> +			sdma1: sdma@30bd0000 {
> +				compatible = "fsl,imx8mq-sdma",
> "fsl,imx7d-sdma";
> +				reg = <0x30bd0000 0x10000>;
> +				interrupts = <GIC_SPI 2
> IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_SDMA1_ROOT>,
> +					 <&clk IMX8MQ_CLK_SDMA1_ROOT>;
> +				clock-names = "ipg", "ahb";
> +				#dma-cells = <3>;
> +				fsl,sdma-ram-script-name =
> "imx/sdma/sdma-imx7d.bin";
> +			};
> +
>  			fec1: ethernet@30be0000 {
>  				compatible = "fsl,imx8mq-fec",
> "fsl,imx6sx-fec";
>  				reg = <0x30be0000 0x10000>;
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
