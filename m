Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10499C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:29:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D051F2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lwIaYWho";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rLMZGDBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D051F2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kj3mB6tl6sJpQaPvPIuz68jLz3yS4dDkhVVXhDijc0M=; b=lwIaYWho4uIlpG
	9VbNOt6L5tuNGgQgK/qzRtZwG6+1dxsOCms2IJAlaa3OuL86AS69CgaQVQOEVEjrl1YalpxGjwnts
	4QO40PmUKXeqnnzaT7DFyOoXxkyVASVbblZwa19dZtL8JdSMBtGwiHbrRYUiCyDBUejb+eGH5ibHP
	uVQL4mk3HjUepvBHlyrAq1l3n1myzHAvlgs8Gha257hP4B5cUTfWb/Cpdsr9vJt7KzDvRHx7dkg+Q
	tTHDRuqfetOujNdcF1KsIMp10dzbd2dsZlUQ3s8fpAkFM0+34sbhDPxg5ZZVHmdmHogE7026NMoWw
	bpZerPmjIGr8bGwFDTjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwIZj-0005qh-J9; Wed, 20 Feb 2019 03:29:35 +0000
Received: from mail-eopbgr00043.outbound.protection.outlook.com ([40.107.0.43]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwIZg-0005pz-Bs
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 03:29:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY+Qmo0EUC+bdnjnSPh2PgQf7cgLd3LDjrswYpUuoU8=;
 b=rLMZGDBjWwznUF1g/GNBmzhV0IdmWGMWcnbQ40T4BLuYft2oiGNenoZvEMMnlfDt1rqnbxzkio+8G9A8K4ya1hIinsXVT1l2P5jvfOBpA9eUQ1S7Hf7s8gn/u7AAZwEMmt2veSHk/fM4reZhggbl/YT5+TT1ZP7H/FDXDN2eZME=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB5127.eurprd04.prod.outlook.com (20.177.34.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 03:29:29 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 03:29:29 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Anson Huang <anson.huang@nxp.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>, "ulf.hansson@linaro.org"
 <ulf.hansson@linaro.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: imx: update scu resource id headfile
Thread-Topic: [PATCH] dt-bindings: imx: update scu resource id headfile
Thread-Index: AQHUyDGr6JcuNwk39kK74/kE/Vm176XoB/yA
Date: Wed, 20 Feb 2019 03:29:29 +0000
Message-ID: <AM6PR04MB421521095AEEC7530E97998A807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
References: <1550566601-11497-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550566601-11497-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3693e1e0-87d4-40a3-442c-08d696e39f4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB5127; 
x-ms-traffictypediagnostic: AM6PR04MB5127:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; AM6PR04MB5127;
 23:z7DUbA5lougY6qwXdqiwOmujPKVzhs7KbKHwtW7Rc?=
 =?us-ascii?Q?pNHK84nnZ104NLOyYjuYD4mv1OMDylu6RtOIrTDxvIJpls2hJOX0z5dCowag?=
 =?us-ascii?Q?LIugluzF8kyTAT3jRK3SuIoyyDQ28c4xMldSKAOjki05JEExYjJNoVjePUnd?=
 =?us-ascii?Q?WNt91mO6KpifCIU7on4GhyN+KzTt90/6qKUJ5/8y7l64ceN52n7ALsp5IljO?=
 =?us-ascii?Q?775P2q4UJqVPOdLPWbx8FSirBVq5VOTybAi8jM6DfetT1a+I3cVeWUC2Xjjh?=
 =?us-ascii?Q?1HObDWlx7b3m/juRUjCIm2FQrSuWeZ65i7gmTbTw/lHLjgyOLxn3v2DFFR36?=
 =?us-ascii?Q?Fihok3IZQbNbgyQT1VPhdXISH76veyr4mJqyzpaya99uJcQaN7nVO5Beohlz?=
 =?us-ascii?Q?DF1Psx6TbQ6QbZ73F7wtUS2g2vQNauNe2Z9hj4wwSk2mtyNv+I44x9iRyH8t?=
 =?us-ascii?Q?wCaGJDNVujYqr4H5S+s9CgTmAd57qMJh9YN9AvD+3zOC6VQSU4ikdR1a7WlZ?=
 =?us-ascii?Q?fFO6CTBac1I5wFtUEy0VgzjdQYB+iPIRp1evrXrYGxUNFS/MTgTOJgIFx+C1?=
 =?us-ascii?Q?Vd0cnB3Gw18JEx+NSfC75+Z46dTL9KMaF1ore9na2S1pKWckiwgin/Jj4scU?=
 =?us-ascii?Q?NJCmyCSeCAz/9OjlMVbQWDwB/if1c14G0P0fcBLA42nHT4EkgmPC/H8otY7g?=
 =?us-ascii?Q?ap1iYwzw3VgvbpFOZvwHhzBbqGerqpnfJXSBMwvAqsaSNCZ1DrZodLCSeatQ?=
 =?us-ascii?Q?tycD97xm0NCezdq8g622/7lXXGLBPrWORbv2yc0ijmom1K3oE2YOLFZ+QDTZ?=
 =?us-ascii?Q?aTCzlXb7vnwZT7oIIDRw6OAcnp3Ns5LFkE4MJL6GFkP5Jp5zVFybM5W/Gljr?=
 =?us-ascii?Q?WnikxOzAMTFRQx2VKfWakVu0ioyh0Am8Bz849R2YFXsXSzsYQLqb5M7/YGBg?=
 =?us-ascii?Q?bUAnneq0JqGfLGfBX9li0aj5wfoqale4PZjcXXNMd1kduZGQay6vDDoUvtrI?=
 =?us-ascii?Q?qI10r+ngrtiFAft5Yujenccyjbp3TQMhd6JpI+nFRZo8QLhQ84Hpk2FTuEhn?=
 =?us-ascii?Q?p5Mjr18+2ZkpEz5rI8xXts2UrxQSZ2LanJHJFOsfxxvNIluO6DKo/ahS2reZ?=
 =?us-ascii?Q?81RW32fVwJBc5/wFy8m9ia2L85YHqVjFUC5kBuHg9r7YZueleNIyK7so4swR?=
 =?us-ascii?Q?9NeyRTss9GhRx5DXrIV4P3HBAe+ZxptlZA7x/EyuJUER6IHN31scNl4Nw/7F?=
 =?us-ascii?Q?R0QNdjFTsovY1+lfNp/Uln49k4g2nV4glPLkCm1RlCyRSoTG9MvkVSfXfw9U?=
 =?us-ascii?Q?nUIQI1H2OOfHWPusBh2g77l/+7U6GugAWvgR7vQrbvksRRYEbtqT3rF3zcrq?=
 =?us-ascii?Q?NwQ4w=3D=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB5127E346399EDB6869EFF0F5807D0@AM6PR04MB5127.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(2501003)(9686003)(8936002)(44832011)(6436002)(97736004)(8676002)(55016002)(81156014)(486006)(81166006)(76176011)(33656002)(7696005)(229853002)(71190400001)(99286004)(71200400001)(6116002)(476003)(446003)(11346002)(4326008)(3846002)(14444005)(256004)(68736007)(110136005)(74316002)(105586002)(6246003)(5660300002)(305945005)(7736002)(106356001)(26005)(15650500001)(66066001)(86362001)(186003)(7416002)(478600001)(2906002)(316002)(2201001)(6506007)(53936002)(102836004)(14454004)(53546011)(25786009)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB5127;
 H:AM6PR04MB4215.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r9yrOc+pLbETglmWNOBVee4v6QrD65j9UQGOZbMlTDk8+CN+iYjbLSRWHOBYGTqAi8VbnwIC6ZeeXtUAKF+iM6yn0O0jYsU1nvF4rECEa54ljF1NRL2KNHua/thEnP4dG76UhSi1w9rUTY39Cq5ORqxO2i71aTq9ooePb/oJ7+wBDCqHICOQGp5QgvY4mDH8RGKup6VmCuXjDU/rqRgMkxlZscuyui7R2lhAuBMLJgj6F/+gtsCMbTKh36hDAd7W0bGOjdkG0/HANSB5j/Qw1z/k1hTfGcRPzBzGKqgzqIQ4w9WK/55xwcduGsmRvVRhnwNOxCrcYLAbbtmMTCaik1D8bXVf4KeO+MK8mmndvBjdv9OqX4SItbYuE9E0gSrtxlwo5uI8qVxu7JVGi+Jxn/npwuJN5W7/BOTt81DsVYI=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3693e1e0-87d4-40a3-442c-08d696e39f4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 03:29:29.2537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5127
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_192932_411657_CFB64A06 
X-CRM114-Status: GOOD (  11.01  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> From: Anson Huang
> Sent: Tuesday, February 19, 2019 5:01 PM
> Subject: [PATCH] dt-bindings: imx: update scu resource id headfile
> 
> Update i.MX SCU resource ID table according to latest system controller
> firmware.
> 

You need at least explain what changes made like
what new features added? What removed? Side affect if any?

Regards
Dong Aisheng

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  include/dt-bindings/firmware/imx/rsrc.h | 39
> +++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/include/dt-bindings/firmware/imx/rsrc.h
> b/include/dt-bindings/firmware/imx/rsrc.h
> index 4481f2d..ad747a8 100644
> --- a/include/dt-bindings/firmware/imx/rsrc.h
> +++ b/include/dt-bindings/firmware/imx/rsrc.h
> @@ -36,15 +36,15 @@
>  #define IMX_SC_R_DC_0_BLIT1		20
>  #define IMX_SC_R_DC_0_BLIT2		21
>  #define IMX_SC_R_DC_0_BLIT_OUT		22
> -#define IMX_SC_R_DC_0_CAPTURE0		23
> -#define IMX_SC_R_DC_0_CAPTURE1		24
> +#define IMX_SC_R_PERF			23
> +#define IMX_SC_R_UNUSED5		24
>  #define IMX_SC_R_DC_0_WARP		25
> -#define IMX_SC_R_DC_0_INTEGRAL0		26
> -#define IMX_SC_R_DC_0_INTEGRAL1		27
> +#define IMX_SC_R_UNUSED7		26
> +#define IMX_SC_R_UNUSED8		27
>  #define IMX_SC_R_DC_0_VIDEO0		28
>  #define IMX_SC_R_DC_0_VIDEO1		29
>  #define IMX_SC_R_DC_0_FRAC0		30
> -#define IMX_SC_R_DC_0_FRAC1		31
> +#define IMX_SC_R_UNUSED6		31
>  #define IMX_SC_R_DC_0			32
>  #define IMX_SC_R_GPU_2_PID0		33
>  #define IMX_SC_R_DC_0_PLL_0		34
> @@ -53,17 +53,17 @@
>  #define IMX_SC_R_DC_1_BLIT1		37
>  #define IMX_SC_R_DC_1_BLIT2		38
>  #define IMX_SC_R_DC_1_BLIT_OUT		39
> -#define IMX_SC_R_DC_1_CAPTURE0		40
> -#define IMX_SC_R_DC_1_CAPTURE1		41
> +#define IMX_SC_R_UNUSED9		40
> +#define IMX_SC_R_UNUSED10		41
>  #define IMX_SC_R_DC_1_WARP		42
> -#define IMX_SC_R_DC_1_INTEGRAL0		43
> -#define IMX_SC_R_DC_1_INTEGRAL1		44
> +#define IMX_SC_R_UNUSED11		43
> +#define IMX_SC_R_UNUSED12		44
>  #define IMX_SC_R_DC_1_VIDEO0		45
>  #define IMX_SC_R_DC_1_VIDEO1		46
>  #define IMX_SC_R_DC_1_FRAC0		47
> -#define IMX_SC_R_DC_1_FRAC1		48
> +#define IMX_SC_R_UNUSED13		48
>  #define IMX_SC_R_DC_1			49
> -#define IMX_SC_R_GPU_3_PID0		50
> +#define IMX_SC_R_UNUSED14		50
>  #define IMX_SC_R_DC_1_PLL_0		51
>  #define IMX_SC_R_DC_1_PLL_1		52
>  #define IMX_SC_R_SPI_0			53
> @@ -303,8 +303,8 @@
>  #define IMX_SC_R_M4_0_UART		287
>  #define IMX_SC_R_M4_0_I2C		288
>  #define IMX_SC_R_M4_0_INTMUX		289
> -#define IMX_SC_R_M4_0_SIM		290
> -#define IMX_SC_R_M4_0_WDOG		291
> +#define IMX_SC_R_UNUSED15		290
> +#define IMX_SC_R_UNUSED16		291
>  #define IMX_SC_R_M4_0_MU_0B		292
>  #define IMX_SC_R_M4_0_MU_0A0		293
>  #define IMX_SC_R_M4_0_MU_0A1		294
> @@ -323,8 +323,8 @@
>  #define IMX_SC_R_M4_1_UART		307
>  #define IMX_SC_R_M4_1_I2C		308
>  #define IMX_SC_R_M4_1_INTMUX		309
> -#define IMX_SC_R_M4_1_SIM		310
> -#define IMX_SC_R_M4_1_WDOG		311
> +#define IMX_SC_R_UNUSED17		310
> +#define IMX_SC_R_UNUSED18		311
>  #define IMX_SC_R_M4_1_MU_0B		312
>  #define IMX_SC_R_M4_1_MU_0A0		313
>  #define IMX_SC_R_M4_1_MU_0A1		314
> @@ -337,7 +337,7 @@
>  #define IMX_SC_R_IRQSTR_SCU2		321
>  #define IMX_SC_R_IRQSTR_DSP		322
>  #define IMX_SC_R_ELCDIF_PLL		323
> -#define IMX_SC_R_UNUSED6		324
> +#define IMX_SC_R_OCRAM			324
>  #define IMX_SC_R_AUDIO_PLL_0		325
>  #define IMX_SC_R_PI_0			326
>  #define IMX_SC_R_PI_0_PWM_0		327
> @@ -554,6 +554,11 @@
>  #define IMX_SC_R_VPU_MU_3		538
>  #define IMX_SC_R_VPU_ENC_1		539
>  #define IMX_SC_R_VPU			540
> -#define IMX_SC_R_LAST			541
> +#define IMX_SC_R_DMA_5_CH0		541
> +#define IMX_SC_R_DMA_5_CH1		542
> +#define IMX_SC_R_DMA_5_CH2		543
> +#define IMX_SC_R_DMA_5_CH3		544
> +#define IMX_SC_R_ATTESTATION		545
> +#define IMX_SC_R_LAST			546
> 
>  #endif /* __DT_BINDINGS_RSCRC_IMX_H */
> --
> 2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
