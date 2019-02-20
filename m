Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FAEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:10:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 825EF20449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IisbYtmM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qqJ0fv7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825EF20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wQ0m2x8H6BgEjVMph0arJ2ANndLTw9GCm6vWTSPwpZE=; b=IisbYtmMwIVYTq
	PJ39+WMd2qwX7VRmgUnu4QbPoYHJFqo4WK/cgf8Kh1kRREvByeThpvOmig/V9vtHXq/m+MomKeXO0
	ZLwS8OGFaCei9N+psyyZj4oxQhuIcIRx5Y9fSPoC/UxoxTMTcfW3G2jc1Dc+c8qV8/xOOyBmSLH2c
	5YDqdUGkHzyx2kLgNEwUzJDGkY3jSGXW+SDNxeQNnNbC88PEyL05OuOo/NmKXKFsf37ctHKylxvD5
	9pABXy8KqT/QVBlk12aqJy2BVyYhRYyfKS3rtgzED39ZeEpJCMhZ6a1rMV8QNrXcFBgd79Wcfuj97
	leMollMbtEtqZ8an7Uyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwM17-0004Dm-C1; Wed, 20 Feb 2019 07:10:05 +0000
Received: from mail-eopbgr50059.outbound.protection.outlook.com ([40.107.5.59]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwM13-0003pi-4B
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 07:10:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmOzQca3tPK0tGdfERz1GYqr9YRwNyH5+x/flxAoz00=;
 b=qqJ0fv7uJZmEa0+AItxWOBS9ExCFW33jNAL7V8YdBIt9WLvo31HOkBOVR1yU0M6+QAQGn0AnWv3Qtp3DRXrCCdDoHjG1P+ddFBBJPatcrOwKeHn1nRRrfBUFO++YOq9jN6SDP3/UJwVIQywv6Sw4OQAAaQBJmoa4MtH3Go17M0A=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB4888.eurprd04.prod.outlook.com (20.177.33.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 07:09:57 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 07:09:57 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Stephen Boyd
 <sboyd@codeaurora.org>
Subject: RE: [PATCH V3 5/5] clk: imx: scu: add fallback compatible string
 support
Thread-Topic: [PATCH V3 5/5] clk: imx: scu: add fallback compatible string
 support
Thread-Index: AQHUs+fmr9q1T9UkF0qCpEHsfoSQ+6Xobkbg
Date: Wed, 20 Feb 2019 07:09:57 +0000
Message-ID: <AM6PR04MB42151CA6852C4EEA0FECC93C807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
References: <1548335800-6438-1-git-send-email-aisheng.dong@nxp.com>
 <1548335800-6438-6-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1548335800-6438-6-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 577f2371-3f5f-4fd5-266a-08d697026c18
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4888; 
x-ms-traffictypediagnostic: AM6PR04MB4888:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; AM6PR04MB4888;
 23:b/6Z5gvVF5wogOhA/Wsaq6wKebhaP+VGyM1/xmu2z?=
 =?us-ascii?Q?8mYOF2wpE2R3kGkriDM6Vg9o3vnQI5gxN2km0pLxd9OGPLIRx4W0vsP9B524?=
 =?us-ascii?Q?U7il1Y+FXj/lkHpdFEDfu9MIXewPuyHqWvCXK+bjweNgFy27X8rD4PowdtvR?=
 =?us-ascii?Q?ZyKKizQQxL6XAPJ7306MwMrXNulapui0jU0bBCdQdHa4VqbXinc1ZewKJWUL?=
 =?us-ascii?Q?64p8bwAJdVRsUuYWITmcR3Kaz7ioVyUNYfKI+cevDP1QASekE0wlcuAQKOub?=
 =?us-ascii?Q?0RyCynaB5P7dnDdczRYfvkVoBudpR3q5NTZv83PJgD1PEk60NgKZZjMLJDH9?=
 =?us-ascii?Q?TwTb88KzIfQgdgh4MVqXs1ijjTrygEfU2r/aD6wXiiGGPrvPm2BS7sftzHuH?=
 =?us-ascii?Q?iCoT6Q3LgQwDngHtZx2RvakXQrsh495MubzWQH2oTjxp8/nslNYeSYcLImVb?=
 =?us-ascii?Q?XCdD1RpGhpNoLf11Zjsbp5v34IYIxg8hJnP3y3qx5PvUwafMtcz99xgGGAor?=
 =?us-ascii?Q?ZNSwl3JeT/IyLfU7ZhfHtrzkM378FQyEzSYtunjo/TJQ1N1pBS2tB6XT0UPy?=
 =?us-ascii?Q?fgrxLmXn+mKqH7jAx8tLBkRttwf7hZlz5VKMp6mdE+DJ0cQfmFuJBh+4WhRM?=
 =?us-ascii?Q?bgvDkwQ0RiLskQBc9J+KpxQrDbvy3IW/wQo8MlXbxdDL5E7tgghGjtCIkUFv?=
 =?us-ascii?Q?BVYvI+tsA/ClCFOAGKOpJrJGOtwuK+8PgwVTthUZyHLfrHfUyZ5drok5aRko?=
 =?us-ascii?Q?cNVkQk7f9CrED7QFIqCQoaAM9PRP5Wk/0jPKDjyqeqYHgZZMm100yWQePP/r?=
 =?us-ascii?Q?svFgB0GeislA45zkWJSpvmFBqN7CUCUM4L4FICdA8Hg+20PrMdOeoeMFW1hI?=
 =?us-ascii?Q?vm/a+npoH5+QFUE9c0Z1PapSSxEPIRgDs4gYg1IchTl6vM4Hpg10xntQ54fV?=
 =?us-ascii?Q?UxjW8UbhxqraRRWMU6YHp+WdR2H9No5LzqECmduJvQOkUvJjb3Ou2KAZ1kx8?=
 =?us-ascii?Q?h1jwk8yyB+vM2C8UT1VwnZoVY2x9271GF2TprGO5KsMT7pE7nl6/KPqwl/Lh?=
 =?us-ascii?Q?LRySjx2SSSMy6xM+VQapa+o9VX6Wv26/Fb2AlhWo1n4jpj+qPJdPRq3PC1aS?=
 =?us-ascii?Q?W0d2X29dwrS3rzTtRKiWV9A6ac5d+iNYimPW2bN/0Hpj4Iyi37uaXcy/FCN2?=
 =?us-ascii?Q?cn4CzpNpZ6g6zGG1o+cJjN8QVQm4UH+M21eVFXdgVxH4q9pVeSjRjOzoDm95?=
 =?us-ascii?Q?vgmoPvnZ+WYUVs68TUAzC/Uu0bCzKXV5Bhqxoj4?=
x-microsoft-antispam-prvs: <AM6PR04MB488885E4ACA1A95BA23E9B89807D0@AM6PR04MB4888.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(13464003)(81156014)(6246003)(25786009)(81166006)(305945005)(256004)(2906002)(97736004)(66066001)(74316002)(53936002)(8936002)(8676002)(9686003)(7736002)(6436002)(5660300002)(7696005)(99286004)(76176011)(55016002)(33656002)(71200400001)(71190400001)(478600001)(14454004)(3846002)(6116002)(26005)(102836004)(53546011)(6506007)(186003)(44832011)(316002)(4326008)(476003)(446003)(11346002)(110136005)(105586002)(2501003)(106356001)(229853002)(68736007)(86362001)(54906003)(486006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4888;
 H:AM6PR04MB4215.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: avDywCM/GIrRLpq7xCQYdT46h4ceRMEBjF7mFP7CbeqrgqewiPsPnHFQZ0nzfwxgpH2IgQeGapb3zuqyt7Dxhg4olwdHok6Q7hVpuZhiAT6ptQRCSb9yKpJy6v1OJ6QDJZ2kDKKUp4XX2eXrtr3rHSCjHzPmhyh/GJNbvvhQRJ1Hzgyijf1sRrGF7BmIA0CI4LvW+wifGqP5xTob9xg1bvWe6R6mUVuqtsI/WJHm0J6QLKTsp9m7xP0vVAsH1F201Rff2p1OwNwByRjEaOOcH39z/cjvbk4kut/ZKBVhnewOwB+VDLkuJMx6hVt10UQUC0Qdrsak0j1/coMr/vRHJVJ1RcLmmCrihpQbAwcHQCts+jmJx9N4vJnF6mlUq1msx4E3oC2qmLsj4ecHFzZ+SlcTgpRGKSXitTWE7Q7rquI=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 577f2371-3f5f-4fd5-266a-08d697026c18
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 07:09:57.7433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4888
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_231001_163303_C9594727 
X-CRM114-Status: GOOD (  16.24  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stephen,

Can you help picked this one?
SCU clock is likely to be common, so we add a common
compatible string to handle it.

BTW Patch 1~2 already picked up by Shawn.
Patch 3~4 dropped.

Regards
Dong Aisheng

> -----Original Message-----
> From: Aisheng Dong
> Sent: Thursday, January 24, 2019 9:23 PM
> To: linux-clk@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; sboyd@kernel.org;
> mturquette@baylibre.com; shawnguo@kernel.org; Fabio Estevam
> <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> kernel@pengutronix.de; robh+dt@kernel.org; devicetree@vger.kernel.org;
> Aisheng Dong <aisheng.dong@nxp.com>
> Subject: [PATCH V3 5/5] clk: imx: scu: add fallback compatible string support
> 
> SCU clock can be used in a similar way by IMX8QXP and IMX8QM SoCs.
> Make the driver support "fsl,scu-clk" fallback compatible string to allow other
> SoCs to reuse the common part.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8qxp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c index
> 83e2ef9..5e2903e 100644
> --- a/drivers/clk/imx/clk-imx8qxp.c
> +++ b/drivers/clk/imx/clk-imx8qxp.c
> @@ -138,6 +138,7 @@ static int imx8qxp_clk_probe(struct platform_device
> *pdev)  }
> 
>  static const struct of_device_id imx8qxp_match[] = {
> +	{ .compatible = "fsl,scu-clk", },
>  	{ .compatible = "fsl,imx8qxp-clk", },
>  	{ /* sentinel */ }
>  };
> --
> 2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
