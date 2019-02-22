Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58898C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:04:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1938120878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="txyFhmOb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ah9blGU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1938120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9ppYepqNh1PzLMMCxNUr8BUIHlDB5wVlJbuNt8vTPgI=; b=txyFhmObdQx/Ta
	zos0XCXv609yATU/cgfHSkYO/4p2jYoAtQWamJapdvRqz1dsjkl6xQw1Q+jrWT/QJki8h0s1wvhza
	ZPmDE2NLHb9mTphhOn1ASSr2tyPKt0LtMkERDOjjfg9B8sZ55Wb6cfVIZKG4JCjW/hdwwhPfKvCjI
	oj6DK3ItXv0S/cMMzJipTBOmu3MBxDsO+zhhjs1zRlUn3uquEAtSmMw+FkSC+XoTxHOTr0yqXCSXe
	6+1P2ZNLBuz/KFl1gJ98fnuzIfUOkKXb5kGINkyy7d/zkW4NIGHCt1JOQ3ump9e4sekKiuaPIR6Fn
	1vgAeD4TL/MPnF1mLzWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx7gt-00051S-QD; Fri, 22 Feb 2019 10:04:23 +0000
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx7gq-000517-B5
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 10:04:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHdnjqxtTxmMkWpUMQPL3pdMJc5IKmfpaqZ9Ru74NDc=;
 b=ah9blGU7PiuYvRszM4E8vuhH9ct6DRe/pytTO26QEKaEZ7ydPOi1NzMjVj8GLkAMJOJaWlmQNBHGzD79ZMGVZlEab7qrhURjgvBLriS0YwxHhyjGdwAvlRZZwFf7K7KF6iK10ZXcYbUtGaLtE1EU85vBnp5Vx5ENdONnGpG8UBM=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB5632.eurprd04.prod.outlook.com (20.178.125.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 22 Feb 2019 10:04:16 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.018; Fri, 22 Feb 2019
 10:04:16 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Anson Huang <anson.huang@nxp.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>, "mturquette@baylibre.com"
 <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>, Abel Vesa
 <abel.vesa@nxp.com>, "ccaione@baylibre.com" <ccaione@baylibre.com>,
 "agx@sigxcpu.org" <agx@sigxcpu.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: RE: [PATCH 1/3] clk: imx8mq: initialize clock tree earlier
Thread-Topic: [PATCH 1/3] clk: imx8mq: initialize clock tree earlier
Thread-Index: AQHUypLopgE4RdwU6k2TGErI1f+TZ6Xrli5A
Date: Fri, 22 Feb 2019 10:04:16 +0000
Message-ID: <VI1PR04MB42229593C69A7AE3D6469E8F807F0@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <1550828264-9962-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550828264-9962-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36555116-2fea-4d8d-ce69-08d698ad1ae0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5632; 
x-ms-traffictypediagnostic: VI1PR04MB5632:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; VI1PR04MB5632;
 23:YCEyvlp4aL1RIL5/lhMCmRZ7RIOfF/WpQaNwbe3sB?=
 =?us-ascii?Q?Igh2PQNE5v/Jm/f9mjnKKNDNKGSbdQ+/WTaQyNWTZEKQ1vjfRtIaY5ShH+3Y?=
 =?us-ascii?Q?5Y4jeRQ4AQuuvIW4HvDJbUkfyId08Eyy2WC3WGzbnHF0U4mmSLKGBhhlIUSC?=
 =?us-ascii?Q?s71SlWCa7H2PLxp3tPRLcDsfVGhJFdPVIuWTNvGNm/BzoKSRq5D+5N13nJvM?=
 =?us-ascii?Q?OGXAO0R7Q3dgYbglXWugGO1L2n/lVIHMm3AI0KqRUfSJtjaYGGblPxU+c3mD?=
 =?us-ascii?Q?RV8z2LLaIAoRmz5w8MCDcZxdUXXq9jZfd0aAc7b19TlqlHhBvPxFXZuwE0LU?=
 =?us-ascii?Q?fT2kaHI8RUItgelji64C2oTCzwGoP6vBSOAyBSXzp2nNUtD6hIZzQw8cyLfs?=
 =?us-ascii?Q?EQTlnukZ1rXB97oQP4OklbtgfbKeqOgwaoyQ9oHeVB73wHuGM2aQPHgViIX9?=
 =?us-ascii?Q?7PjGNowNsk/tC5cxrXU+vgiM4BrTT74CmxqFmOvL/WxMEA6mWc3LwF7sXSdw?=
 =?us-ascii?Q?VsT+OmNPSk2EOFB4QjRFLVOuuDjFv3xVRs2NdqgZur4rvxmMKA8PwF6VtqIS?=
 =?us-ascii?Q?4U9TdwpqBVv0JsWPn+8njG+zlnJTMm684esGyYvvZobECN7q9SSVOJCoVNxT?=
 =?us-ascii?Q?dN2HnDnr7nV5MMfoC/bRgNRs0ZRHmowSUcTqEf+hPS8zrT4tzNUppzAMNzbu?=
 =?us-ascii?Q?MP5NcEdKHfyiqTla2nLkT04Sd0YS6hoPX5VscAJempnKBVL/bkq3xyja1Hwi?=
 =?us-ascii?Q?jzYcshaq0En3kQJJK4B608FO2qM6+bcw/VGefTgwnLZjVrDdp900ZIH/7cjw?=
 =?us-ascii?Q?exQ9JeVbDs4E/kg/I/tcldLWFJJcBh/UccL/8iamLntnLvM4GKN+GcH05Xdf?=
 =?us-ascii?Q?4n/fAaQH/+OnG3lBGRBoC/TU/nQYgJq5vSVcIG1DzAg10rFydFWz0Fbp4DgH?=
 =?us-ascii?Q?/eIuiBA/kcdEM7NYnvE4Y9wPB5KT/pihrothPdHef4kpuYfTD3Btegw+ev93?=
 =?us-ascii?Q?xbBKVCkTBZVfoua//6Urqd7y9lIX5gyl0mFhK+GGsmNW2ew/pVCRsw9togzd?=
 =?us-ascii?Q?AdOAkA817erX5k88r4Iz8Nf8jxvAdhzP5WbFqMGC9vosvqtOQQvkuf5f24L8?=
 =?us-ascii?Q?7HPVs2mby4gS0o0lO738X6yOliG4sPVMNx4NpzC4XrV+U6Rn5G9B0xqPOcfr?=
 =?us-ascii?Q?aOHbYOF2F4EQFb1uZB6n97RuuLTYTusf37lVAN8oiKUm1fa1LJ4R8T+ASRwY?=
 =?us-ascii?Q?nmXQgc6VHDFj6fWbX8rNDv0w7fgDVnrfM3guuceplHYetYo7ahc1QbRDnkMU?=
 =?us-ascii?Q?HhGfO2hQt98it2N6VaDt54=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB5632D13CEC1DCA46C069F319807F0@VI1PR04MB5632.eurprd04.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(9686003)(102836004)(99286004)(486006)(446003)(11346002)(68736007)(6506007)(316002)(44832011)(476003)(53936002)(55016002)(110136005)(229853002)(76176011)(71200400001)(478600001)(7696005)(71190400001)(2906002)(8936002)(6436002)(7416002)(5660300002)(2201001)(256004)(86362001)(33656002)(106356001)(105586002)(6246003)(4326008)(26005)(25786009)(81156014)(186003)(66066001)(305945005)(3846002)(81166006)(8676002)(7736002)(74316002)(97736004)(6116002)(2501003)(14454004)(921003)(32563001)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5632;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yuZw1ldE+E66NLqW5HYmZ07em0rrJxrScx3tBDaaDYRpPy8MBykdpuCFspwvmqNXZ24oJbSThguHQwNYiiYx34SPDP9XaITfupN8dBkoYIQqdLt0M8+BOCg3qNOm/zlYLAbXDbixFU5P66rwrZI4OboqlvTTOOolgx890Y4MMM2z31jF3NP/obnLzpYKZGtVlGTU0cU0K49Ovkx5PFBDlqUV4010qnYCreK+QQOJx4v4OmxBxUQRZlhkk+IMortoCiy4hBIcwka90d+606tqrAH1qfZ5mvHUPdt6oLsC9aQ3+415BZYogmsKTe7sKNKKspndHlaoCSRrbxQgREhOl7gfH0ty5YEFDri65Sj5pO/OYajSF7Eev5DU6qDYMauQK1SfjE47sJn/aBocQyxtbXtkBwp8h7wHgxPqhQwkaVY=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36555116-2fea-4d8d-ce69-08d698ad1ae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 10:04:16.6127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5632
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_020420_393923_1BB5FD96 
X-CRM114-Status: GOOD (  18.74  )
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

Hi Anson,

> From: Anson Huang
> Sent: Friday, February 22, 2019 5:42 PM
> 
> Currently on i.MX8MQ platform, clock driver is probed later than GPIO driver,
> and GPIO driver does NOT have defer probe mechanism since the GPIO clock is
> optional, some platforms have GPIO clocks and some are NOT. So it is an issue
> that on i.MX8MQ platform, there are GPIO clocks defined, but due to clock
> tree is NOT ready during GPIO driver probe, the GPIO clock management will
> fail and cause system hang if GPIO clocks are OFF by default.
> 
> This patch changes the i.MX8MQ clock tree initialization using
> CLK_OF_DECLARE instead of platform driver model to make clock tree ready
> earlier than GPIO driver.

Please double check why GPIO driver can't handle PROBE_DEFER well.
Maintainers suggested us to use platform driver unless there is strong reason.

Regards
Dong Aisheng

> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mq.c | 33 +++++++--------------------------
>  1 file changed, 7 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c index
> 26b57f4..2df1575 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -269,10 +269,9 @@ static const char *imx8mq_clko2_sels[] = {"osc_25m",
> "sys2_pll_200m", "sys1_pll_
> 
>  static struct clk_onecell_data clk_data;
> 
> -static int imx8mq_clocks_probe(struct platform_device *pdev)
> +static void __init imx8mq_clocks_init(struct device_node *np)
>  {
> -	struct device *dev = &pdev->dev;
> -	struct device_node *np = dev->of_node;
> +	struct device_node *anatop_np;
>  	void __iomem *base;
>  	int err;
>  	int i;
> @@ -286,10 +285,10 @@ static int imx8mq_clocks_probe(struct
> platform_device *pdev)
>  	clks[IMX8MQ_CLK_EXT3] = of_clk_get_by_name(np, "clk_ext3");
>  	clks[IMX8MQ_CLK_EXT4] = of_clk_get_by_name(np, "clk_ext4");
> 
> -	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-anatop");
> -	base = of_iomap(np, 0);
> +	anatop_np = of_find_compatible_node(NULL, NULL,
> "fsl,imx8mq-anatop");
> +	base = of_iomap(anatop_np, 0);
>  	if (WARN_ON(!base))
> -		return -ENOMEM;
> +		return;
> 
>  	clks[IMX8MQ_ARM_PLL_REF_SEL] = imx_clk_mux("arm_pll_ref_sel", base
> + 0x28, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>  	clks[IMX8MQ_GPU_PLL_REF_SEL] = imx_clk_mux("gpu_pll_ref_sel", base
> + 0x18, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)); @@ -389,10 +388,9 @@
> static int imx8mq_clocks_probe(struct platform_device *pdev)
>  	clks[IMX8MQ_SYS2_PLL_500M] = imx_clk_fixed_factor("sys2_pll_500m",
> "sys2_pll_out", 1, 2);
>  	clks[IMX8MQ_SYS2_PLL_1000M] =
> imx_clk_fixed_factor("sys2_pll_1000m", "sys2_pll_out", 1, 1);
> 
> -	np = dev->of_node;
>  	base = of_iomap(np, 0);
>  	if (WARN_ON(!base))
> -		return -ENOMEM;
> +		return;
> 
>  	/* CORE */
>  	clks[IMX8MQ_CLK_A53_SRC] = imx_clk_mux2("arm_a53_src", base +
> 0x8000, 24, 3, imx8mq_a53_sels, ARRAY_SIZE(imx8mq_a53_sels)); @@
> -568,22 +566,5 @@ static int imx8mq_clocks_probe(struct platform_device
> *pdev)
> 
>  	err = of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
>  	WARN_ON(err);
> -
> -	return err;
>  }
> -
> -static const struct of_device_id imx8mq_clk_of_match[] = {
> -	{ .compatible = "fsl,imx8mq-ccm" },
> -	{ /* Sentinel */ },
> -};
> -MODULE_DEVICE_TABLE(of, imx8mq_clk_of_match);
> -
> -
> -static struct platform_driver imx8mq_clk_driver = {
> -	.probe = imx8mq_clocks_probe,
> -	.driver = {
> -		.name = "imx8mq-ccm",
> -		.of_match_table = of_match_ptr(imx8mq_clk_of_match),
> -	},
> -};
> -module_platform_driver(imx8mq_clk_driver);
> +CLK_OF_DECLARE(imx8mq, "fsl,imx8mq-ccm", imx8mq_clocks_init);
> --
> 2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
