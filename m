Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F71C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:33:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F3E20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tj9kNg82";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V0EEzeEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F3E20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O+TyX9WSR3vcHCPxQ7wZgl2abEW2aA2fTV8NLr6/MF0=; b=tj9kNg827i3UOH
	Snu0cPVVrs6F+KPCoxSyQxg+1KZxNHJKECvt8iolxT9m3EMMSYs/of/+8GUFPD9QCnO+iR4nvVopr
	ckSkrz4XzG9Rl30iKrMjwbEyTVUgA9PB8thuJK1NKwUfTi3wnBOLiQ9Qw9Ip7DlH+1ZEf+lipQ3WK
	4Yz/CVUyR5bBoR7EKVXnr8gpTiU6GLzTdD2IBOrwMwheSgYxDEgQUC/Jt1FAnADd0fQCoq8yk+00k
	drAMqf04mDKLp24mAuOkuY7wy55T6LqHnoZiCmcZEcMy+eqIfP/NVhw3oF1UxEIHtMhSvcj/QR4Ub
	rpcjbHDIN5vMh03jZX2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp6qm-0000fm-Tm; Thu, 31 Jan 2019 07:33:28 +0000
Received: from mail-am5eur03on0628.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::628]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp6qj-0000f9-4W
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 07:33:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNxwZZSrUIaJr+erOSLN/Q9PaXYNVysAlewc4V70i0k=;
 b=V0EEzeEUku+G7XYD9725DvSTPaK6rrxNQAK9nFDT3AZXTRqQAApsey9n3KyVlbBSYQtcbcfY4q2P3i70JCvEm2IPQU9OGJtAA3SyLfjScHjTwnR03D+I4OWkMyVWsN22P6jbgg6YMwX74StgMpNMxypKv4Pwk1iGVoXk1s6xPRY=
Received: from VI1PR04MB5008.eurprd04.prod.outlook.com (20.177.49.225) by
 VI1PR04MB5344.eurprd04.prod.outlook.com (52.134.123.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Thu, 31 Jan 2019 07:33:18 +0000
Received: from VI1PR04MB5008.eurprd04.prod.outlook.com
 ([fe80::2d2c:455a:16e9:cd4f]) by VI1PR04MB5008.eurprd04.prod.outlook.com
 ([fe80::2d2c:455a:16e9:cd4f%2]) with mapi id 15.20.1558.025; Thu, 31 Jan 2019
 07:33:18 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] clk: imx8mq: Add support for the CLKO1 clock
Thread-Topic: [PATCH] clk: imx8mq: Add support for the CLKO1 clock
Thread-Index: AQHUuPrfJwsyV+Y/+E+X0mJVuu2CrKXI/ICA
Date: Thu, 31 Jan 2019 07:33:18 +0000
Message-ID: <20190131073317.zk746ynrse2dbps5@fsr-ub1664-175>
References: <20190131002056.12024-1-festevam@gmail.com>
In-Reply-To: <20190131002056.12024-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5344;
 6:fRza+YPmZ61ZdaDtvViRg6kuDa2yMzr4zN4NzLyvHhHpG9Y5yefMG7+j8sBN+DEE3hvIVXgBZy3eMI7FcjPeGywubPexUTp4y3X0AzqXUw1s57YG7B7Yk7eU2uqiDVj5JCHH3GDaEVXzpuFQtzt9TI9HBtqiCbVLg9uC/WygV/YH420hbY/KkXnUud/2CodnYQP3g+Cy7UO40rn7JuNuGIxvl3Lm4WKIUhJiZ4ZkJsqAOYJspepi+ffHHEAnHIUawsNJvPSaEWLz5tI0qkkYyonp1sNu6nVnFps6+vP6FiRLRKYssy4hQQelEBIWiKhUVwkDBtutUsrBRHN+Ij2kJ6GU3rpLdcw5j94tUyL6iTJ3Mw/3CANSNJHEWWxN9oAiOtnE4b4WChqVqpWfBJOYFu42Vyne7oPfGK5BtnAgPjEUquTx0Gowizr9mN3xWcDpmGk0NBkFG0HjzHatojuS9w==;
 5:kZxy8nq0fvwLMYZFMUG9+XexGxKzZmxWbK3r6c4GS+U1EMWAyj5BFsFUgxw/sFhbPRU1nI+IxEr7/qELOQHMxrBnDg18giRAN8+tQYBmiT0Kvewy+b7sAoChLD5UtoV8wIostAAn2EqYezHd6lHvQ9hFNn+kftwUnfjL4tew03IROVp0ej1/Ocaw1wQcaz/6DY8bDhOrv5GLdHACkWb/oQ==;
 7:ztsdl/ZY3kBwuZlzn7aMfiI1FDVb8J3kDCYkpVBTz+MHDtizFwGzIQMQXJJ7+HSGD6Z+01iGcQ7+TPd09shkZhkuY8Z52vN+U0w1f5QKqgsbl97dP1ISu11V2KXI12ukqYmBh4F17F08Q0O2Bynswg==
x-ms-office365-filtering-correlation-id: 4a167f8c-3180-4a22-9853-08d6874e5ed0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5344; 
x-ms-traffictypediagnostic: VI1PR04MB5344:
x-microsoft-antispam-prvs: <VI1PR04MB53442EDAF152B70519452697F6910@VI1PR04MB5344.eurprd04.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(7916004)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(6246003)(4326008)(76176011)(11346002)(26005)(33716001)(54906003)(33896004)(53936002)(186003)(316002)(39060400002)(1411001)(229853002)(446003)(106356001)(86362001)(105586002)(6436002)(102836004)(476003)(66066001)(53546011)(6486002)(25786009)(6506007)(14454004)(8676002)(256004)(81166006)(486006)(81156014)(14444005)(3846002)(305945005)(97736004)(6916009)(6116002)(44832011)(2906002)(68736007)(1076003)(478600001)(99286004)(6512007)(9686003)(71190400001)(71200400001)(8936002)(7736002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5344;
 H:VI1PR04MB5008.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Fa3fUoz6zUj+7m/y6dd66kIle7dFngOQGE96z4sQkD8waBatjfRd1PmC2Rp+MRJoe23f5+Ahf2Mf7k6QjQ8JdlW8/wc0Chkg84ky9fPxHsqZOFvqvzbAX8gvu8MGyQD2h1qWGKQluAF+4rD77VIMXc4tzARoZI7N+XzcEvue9oUVV9hyRiGBikJ+4DOpk7SzkWwzoEXYOr8+FAK8aaDDAjR8P/GVdCUqWkUE+Fi5gJ1OeSrkKO2ylhbbyq1AULY9agsN/LOErrcfIgw4b1GgSLrsUABCKeTTLhT5JLBfElJQO9pIqfC4zUSjMQkcXuhKDt9/yTNLN61EXtKE3qZl64uyvNo7WYF3Uq9ZkT/OdYPJZlRqqVvycBWb+PvDKHblmLA1vhEp9lKQeUzm1tS6eR9MStc7B9bxtM6Pr8tG2JI=
Content-ID: <1C9CA31C7190A545BC8BB4CAF551DC8D@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a167f8c-3180-4a22-9853-08d6874e5ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 07:33:18.6181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5344
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_233325_260574_FC6CA2A4 
X-CRM114-Status: GOOD (  13.04  )
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
Cc: "sboyd@kernel.org" <sboyd@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 19-01-30 22:20:56, Fabio Estevam wrote:
> Add the entry for the CLKO1 clock.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/clk/imx/clk-imx8mq.c             | 3 +++
>  include/dt-bindings/clock/imx8mq-clock.h | 4 +++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> index 63001bc891d4..a2f8a8d3585c 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -264,6 +264,8 @@ static const char * const imx8mq_ecspi3_sels[] = {"osc_25m", "sys2_pll_200m", "s
>  					   "sys1_pll_800m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll2_out", };
>  static const char * const imx8mq_dram_core_sels[] = {"dram_pll_out", "dram_alt_root", };
>  
> +static const char * const imx8mq_clko1_sels[] = {"osc_25m", "sys1_pll_800m", "osc_27m", "sys1_pll_200m",
> +					  "audio_pll2_out", "sys2_pll_500m", "vpu_pll_out", "sys1_pll_80m", };
>  static const char * const imx8mq_clko2_sels[] = {"osc_25m", "sys2_pll_200m", "sys1_pll_400m", "sys2_pll_166m",
>  					  "sys3_pll2_out", "audio_pll1_out", "video_pll1_out", "ckil", };
>  
> @@ -479,6 +481,7 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
>  	clks[IMX8MQ_CLK_GPT1] = imx8m_clk_composite("gpt1", imx8mq_gpt1_sels, base + 0xb580);
>  	clks[IMX8MQ_CLK_WDOG] = imx8m_clk_composite("wdog", imx8mq_wdog_sels, base + 0xb900);
>  	clks[IMX8MQ_CLK_WRCLK] = imx8m_clk_composite("wrclk", imx8mq_wrclk_sels, base + 0xb980);
> +	clks[IMX8MQ_CLK_CLKO1] = imx8m_clk_composite("clko1", imx8mq_clko1_sels, base + 0xba00);
>  	clks[IMX8MQ_CLK_CLKO2] = imx8m_clk_composite("clko2", imx8mq_clko2_sels, base + 0xba80);
>  	clks[IMX8MQ_CLK_DSI_CORE] = imx8m_clk_composite("dsi_core", imx8mq_dsi_core_sels, base + 0xbb00);
>  	clks[IMX8MQ_CLK_DSI_PHY_REF] = imx8m_clk_composite("dsi_phy_ref", imx8mq_dsi_phy_sels, base + 0xbb80);
> diff --git a/include/dt-bindings/clock/imx8mq-clock.h b/include/dt-bindings/clock/imx8mq-clock.h
> index 04f7ac345984..74f80b26f679 100644
> --- a/include/dt-bindings/clock/imx8mq-clock.h
> +++ b/include/dt-bindings/clock/imx8mq-clock.h
> @@ -391,5 +391,7 @@
>  
>  #define IMX8MQ_CLK_NAND_USDHC_BUS_RAWNAND_CLK	267
>  
> -#define IMX8MQ_CLK_END				268
> +#define IMX8MQ_CLK_CLKO1			268
> +
> +#define IMX8MQ_CLK_END				269
>  #endif /* __DT_BINDINGS_CLOCK_IMX8MQ_H */
> -- 
> 2.17.1
> 

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
