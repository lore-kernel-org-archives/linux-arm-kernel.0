Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75B1C10F0B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:07:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 944792075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KyYJkmZw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mx3wimwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944792075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Bs5JmerjwZ+QGXbiBxwKBztI/DmVkDDR56eqT/ziRpE=; b=KyYJkmZwT9kAg7
	Nf2mztdiooU4oc/4LCvz91AjgelqHuiJGk7xOF+6AlWnFuaJBMp5mxFiKzUrdiv/0K+Rmq0dQk1i+
	BD8ejRiciTBeUfJTD/r6Dq0odxCkKnYQhp+OY+HdeQtm+0pF69T6ALwFSw/Sh96E35cCUmUhcS7hF
	6WmhGqHMiCzyV+GsYZbmnG95WYzVHlY52fA0dGDTeU6lzSIt2ZhHXXbEgXOimbvY66L0uSpvjJfqQ
	r6LFVTSwWMsADaRU7sZ5yrVeOPnFjXbYFuEGWRmnD+verasSGsEsWh7fGlK0mYjG0XVw2Z9zWAK5q
	c/DR5nscRGCRU1+v/uNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxEIc-0001PH-TM; Fri, 22 Feb 2019 17:07:46 +0000
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxEIX-0001OH-J0
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 17:07:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmZYJ52f8EPIpBW+1IdRIM2u0ne8iMlhbAAqAEFdto8=;
 b=Mx3wimwEYKFuabBG9odXtOXPTCApF4D463gvAXaOaFv4UO9xZkh1S3xMzME4h4mPoIN68gn3hDAZGODnZih0hmxk0fZkrYBezrMOXZIeEIA9Nfc9up9VoeCKnW+9hTCIGWGpPskBET28dVpfIeVQLhgF65PYdl2BdY+PYChf6js=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4321.eurprd04.prod.outlook.com (52.134.126.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Fri, 22 Feb 2019 17:07:32 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1622.018; Fri, 22 Feb 2019
 17:07:32 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Fabio
 Estevam <fabio.estevam@nxp.com>, Anson Huang <anson.huang@nxp.com>, Lucas
 Stach <l.stach@pengutronix.de>, Jacky Bai <ping.bai@nxp.com>, Aisheng Dong
 <aisheng.dong@nxp.com>
Subject: [PATCH v2] clk: imx: Refactor entire sccg pll clk
Thread-Topic: [PATCH v2] clk: imx: Refactor entire sccg pll clk
Thread-Index: AQHUytEZ0gNCfcsGj0q44zlYEICsNA==
Date: Fri, 22 Feb 2019 17:07:32 +0000
Message-ID: <1550855235-31528-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P195CA0027.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::40) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39c2806f-106d-4ee5-1422-08d698e83bcf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4321; 
x-ms-traffictypediagnostic: AM0PR04MB4321:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; AM0PR04MB4321;
 23:TbZxr53aVz0X8q4BoacKa0SGonQZ4R9098oaJ22?=
 =?iso-8859-1?Q?+ve3WmclOxAZQTeukdvYya+b4vxqk0w2x+NefA16bPhgDv5Ln5VQ05cZXD?=
 =?iso-8859-1?Q?3q0Q81ssuAbZ9jHJCB1bGCtI6BGvjJ3V07H9XrfxBWUqRT1Q9ThcBzm0M8?=
 =?iso-8859-1?Q?3EihfGMVxQCDJi59ASbdbjdPZEJ7Z/GKz+kKKi4li7T/SDcGC7strNoEJE?=
 =?iso-8859-1?Q?0EIpV5CpVm7GxkkPICUNG4QGiRdamK7zViZk/Wu9pQ+U69B1WDaAZ8/xh+?=
 =?iso-8859-1?Q?//ORSZHs6GCeB+WdB5LtX0gJiOYhuj1KznIV57SfyubHgvXb9TEOcxzsMW?=
 =?iso-8859-1?Q?KjfEnV5ZwMQbRI40Nl/1qEvgt0M+FMsKPmNa8CaxNJ7IhkXJgVPZ5N1sN2?=
 =?iso-8859-1?Q?DYw6E/O7ReiTVvzTwpKIJe3SqMmKpAqPBpKCuiw3TtHw8RKacEE7/rhztX?=
 =?iso-8859-1?Q?h7CV43cLhSDtVl4GevnnXNyg+5Vmr/UXp8UofxiZzvRIT9inU8vKzMGwJL?=
 =?iso-8859-1?Q?cSi4K7J7+0DARAQts5znpLNaSiaR/CcexlJhBjsW3YUKiaQKcYDP8v6fzf?=
 =?iso-8859-1?Q?fqlYvRh0o8376GM7YPcEx2NqOhBDWDbSmDf0hw3e1FT//SZW9DWd5Dvwt3?=
 =?iso-8859-1?Q?uOfQGjRaottHXari0SjmP9eQig/vIc0E2lcQlDlI0HMEV6KG2R4ruLGvx1?=
 =?iso-8859-1?Q?rtVlROVmt51Gi6tBLurCk3wZJikTl6LJrH6estOscHUsN8kZZnPkEP1IwE?=
 =?iso-8859-1?Q?7hedq57jQEc6LfBxiZJuIXzpoPxa9D6P7cDda8D5Hn+9Z/+856HhesLogP?=
 =?iso-8859-1?Q?lNhK5KgQXy2RbGb+nqYMagI/wREFKe3jV9yO/J8QAu40mKH/78UaFgdO6M?=
 =?iso-8859-1?Q?K2KXMQA2rAcA+29dsHMR9Vq32AuSN/0QJLQNxeY4aI/IOEGqpxO078ZbZp?=
 =?iso-8859-1?Q?8NBcAj1I+sYwQBidUQFC948SbUI0OB9WE2mcxcgs+8eGhVUiiR9D7LcFQn?=
 =?iso-8859-1?Q?RgW83Hs3J1bOIbaqeGTMMF6pULBQPD+XhvCxpqjRECwMecyolsaS6GH+KR?=
 =?iso-8859-1?Q?qR+FTe7+pjz+l86t49ktYNjrGz/wd8AzrGuBonp0pqFl/FmFXtXEGgNGiz?=
 =?iso-8859-1?Q?cpZhcQ8AJ7T+ESXgWwPPYzF5xr0a9zctxJGxYFtVyVVj+W1w+zsH1Ttsd+?=
 =?iso-8859-1?Q?BLI7n+Jua2SLvBlMLNy7DILZwoMk9I/8rpAFq9uhcScy7WMDU6oRRNamTk?=
 =?iso-8859-1?Q?TgdzRZY+OkmG5CJvlY00mSPdC5xES/GYURQS2uWw1iWTrEBKC6VDMTIRBA?=
 =?iso-8859-1?Q?dTWdAHg4Vk2ieh58+3dqlbKSOKTRbuxGeqmEJ8v8nE20A=3D=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB4321825FB116295D312D2179F67F0@AM0PR04MB4321.eurprd04.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(346002)(376002)(136003)(39860400002)(199004)(189003)(256004)(14444005)(86362001)(4326008)(25786009)(99286004)(386003)(6506007)(6346003)(30864003)(110136005)(54906003)(316002)(97736004)(5660300002)(66066001)(2906002)(102836004)(71190400001)(71200400001)(81166006)(186003)(53936002)(26005)(50226002)(8936002)(6512007)(106356001)(478600001)(6116002)(105586002)(3846002)(6436002)(6636002)(2616005)(14454004)(476003)(81156014)(44832011)(486006)(8676002)(68736007)(52116002)(53946003)(305945005)(7736002)(36756003)(6486002)(579004)(559001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4321;
 H:AM0PR04MB5779.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F3dSpaj9bPwJSWM3aDHLzAwg5YN6QvExRe81QG9inXla8PMlwRDVEBXPl9+k/SCAAZJglXJQpRJmWflmG0E2wmNLQ/tRSuLCk4jwW6VA+gxkmJb2glUSVbdb0/KyAb+7UWfN4hZsocZ25BfdFkITUtcW7zje9hVsxQvP9GWtoM/S6eTkGvx00A18kTyd0SoFVZedZWItY/T8NWcv5EYKNCnwXIrP0Kfg/gKp0LcbVB4kcJaf0PysdzH3BmlRV9vX9QawcgvXXN6c4kA3gHGZxfR2wmfSB/Qnp0vpItxnhVdEQkGgJv577f5x6+i0JW9EG+lNYnHIgeQi/b+11qrVEjvvupOU/IO9QyPwf7dZ7OqFZ7Cmk1OV2xnWCh94Lm7fxE80aNqSl79k2qrE1/njyx4HHU3PCp8HV+S4WUYC7bo=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c2806f-106d-4ee5-1422-08d698e83bcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 17:07:31.6150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4321
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_090741_901773_87E8D190 
X-CRM114-Status: GOOD (  12.33  )
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Abel Vesa <abel.vesa@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Make the entire combination of plls to be one single clock. The parents used
for bypasses are specified each as an index in the parents list.
The determine_rate does a lookup throughout all the possible combinations
for all the divs and returns the best possible 'setup' which in turn is used
by set_rate later to set up all the divs and bypasses.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Tested-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Lucas Stach <l.stach@pengutronix.de>
---

Changes since v1:                                          
 * fixed all the warnings and errors for arm32
 * removed the explicit reparenting from clk-imx8mq leaving
   that work to be done by each clock driver explicitly

 drivers/clk/imx/clk-imx8mq.c   |  53 +----
 drivers/clk/imx/clk-sccg-pll.c | 514 ++++++++++++++++++++++++++++++++---------
 drivers/clk/imx/clk.h          |   9 +-
 3 files changed, 417 insertions(+), 159 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 01c771f..081dc2d 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -34,15 +34,10 @@ static const char * const audio_pll1_bypass_sels[] = {"audio_pll1", "audio_pll1_
 static const char * const audio_pll2_bypass_sels[] = {"audio_pll2", "audio_pll2_ref_sel", };
 static const char * const video_pll1_bypass_sels[] = {"video_pll1", "video_pll1_ref_sel", };
 
-static const char * const sys1_pll1_out_sels[] = {"sys1_pll1", "sys1_pll1_ref_sel", };
-static const char * const sys2_pll1_out_sels[] = {"sys2_pll1", "sys1_pll1_ref_sel", };
-static const char * const sys3_pll1_out_sels[] = {"sys3_pll1", "sys3_pll1_ref_sel", };
-static const char * const dram_pll1_out_sels[] = {"dram_pll1", "dram_pll1_ref_sel", };
-
-static const char * const sys1_pll2_out_sels[] = {"sys1_pll2_div", "sys1_pll1_ref_sel", };
-static const char * const sys2_pll2_out_sels[] = {"sys2_pll2_div", "sys2_pll1_ref_sel", };
-static const char * const sys3_pll2_out_sels[] = {"sys3_pll2_div", "sys2_pll1_ref_sel", };
-static const char * const dram_pll2_out_sels[] = {"dram_pll2_div", "dram_pll1_ref_sel", };
+static const char * const sys1_pll_out_sels[] = {"sys1_pll1_ref_sel", };
+static const char * const sys2_pll_out_sels[] = {"sys1_pll1_ref_sel", "sys2_pll1_ref_sel", };
+static const char * const sys3_pll_out_sels[] = {"sys3_pll1_ref_sel", "sys2_pll1_ref_sel", };
+static const char * const dram_pll_out_sels[] = {"dram_pll1_ref_sel", };
 
 /* CCM ROOT */
 static const char * const imx8mq_a53_sels[] = {"osc_25m", "arm_pll_out", "sys2_pll_500m", "sys2_pll_1000m",
@@ -313,10 +308,6 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	clks[IMX8MQ_AUDIO_PLL1_REF_DIV] = imx_clk_divider("audio_pll1_ref_div", "audio_pll1_ref_sel", base + 0x0, 5, 6);
 	clks[IMX8MQ_AUDIO_PLL2_REF_DIV] = imx_clk_divider("audio_pll2_ref_div", "audio_pll2_ref_sel", base + 0x8, 5, 6);
 	clks[IMX8MQ_VIDEO_PLL1_REF_DIV] = imx_clk_divider("video_pll1_ref_div", "video_pll1_ref_sel", base + 0x10, 5, 6);
-	clks[IMX8MQ_SYS1_PLL1_REF_DIV]	= imx_clk_divider("sys1_pll1_ref_div", "sys1_pll1_ref_sel", base + 0x38, 25, 3);
-	clks[IMX8MQ_SYS2_PLL1_REF_DIV]	= imx_clk_divider("sys2_pll1_ref_div", "sys2_pll1_ref_sel", base + 0x44, 25, 3);
-	clks[IMX8MQ_SYS3_PLL1_REF_DIV]	= imx_clk_divider("sys3_pll1_ref_div", "sys3_pll1_ref_sel", base + 0x50, 25, 3);
-	clks[IMX8MQ_DRAM_PLL1_REF_DIV]	= imx_clk_divider("dram_pll1_ref_div", "dram_pll1_ref_sel", base + 0x68, 25, 3);
 
 	clks[IMX8MQ_ARM_PLL] = imx_clk_frac_pll("arm_pll", "arm_pll_ref_div", base + 0x28);
 	clks[IMX8MQ_GPU_PLL] = imx_clk_frac_pll("gpu_pll", "gpu_pll_ref_div", base + 0x18);
@@ -324,25 +315,6 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	clks[IMX8MQ_AUDIO_PLL1] = imx_clk_frac_pll("audio_pll1", "audio_pll1_ref_div", base + 0x0);
 	clks[IMX8MQ_AUDIO_PLL2] = imx_clk_frac_pll("audio_pll2", "audio_pll2_ref_div", base + 0x8);
 	clks[IMX8MQ_VIDEO_PLL1] = imx_clk_frac_pll("video_pll1", "video_pll1_ref_div", base + 0x10);
-	clks[IMX8MQ_SYS1_PLL1] = imx_clk_sccg_pll("sys1_pll1", "sys1_pll1_ref_div", base + 0x30, SCCG_PLL1);
-	clks[IMX8MQ_SYS2_PLL1] = imx_clk_sccg_pll("sys2_pll1", "sys2_pll1_ref_div", base + 0x3c, SCCG_PLL1);
-	clks[IMX8MQ_SYS3_PLL1] = imx_clk_sccg_pll("sys3_pll1", "sys3_pll1_ref_div", base + 0x48, SCCG_PLL1);
-	clks[IMX8MQ_DRAM_PLL1] = imx_clk_sccg_pll("dram_pll1", "dram_pll1_ref_div", base + 0x60, SCCG_PLL1);
-
-	clks[IMX8MQ_SYS1_PLL2] = imx_clk_sccg_pll("sys1_pll2", "sys1_pll1_out_div", base + 0x30, SCCG_PLL2);
-	clks[IMX8MQ_SYS2_PLL2] = imx_clk_sccg_pll("sys2_pll2", "sys2_pll1_out_div", base + 0x3c, SCCG_PLL2);
-	clks[IMX8MQ_SYS3_PLL2] = imx_clk_sccg_pll("sys3_pll2", "sys3_pll1_out_div", base + 0x48, SCCG_PLL2);
-	clks[IMX8MQ_DRAM_PLL2] = imx_clk_sccg_pll("dram_pll2", "dram_pll1_out_div", base + 0x60, SCCG_PLL2);
-
-	/* PLL divs */
-	clks[IMX8MQ_SYS1_PLL1_OUT_DIV] = imx_clk_divider("sys1_pll1_out_div", "sys1_pll1_out", base + 0x38, 19, 6);
-	clks[IMX8MQ_SYS2_PLL1_OUT_DIV] = imx_clk_divider("sys2_pll1_out_div", "sys2_pll1_out", base + 0x44, 19, 6);
-	clks[IMX8MQ_SYS3_PLL1_OUT_DIV] = imx_clk_divider("sys3_pll1_out_div", "sys3_pll1_out", base + 0x50, 19, 6);
-	clks[IMX8MQ_DRAM_PLL1_OUT_DIV] = imx_clk_divider("dram_pll1_out_div", "dram_pll1_out", base + 0x68, 19, 6);
-	clks[IMX8MQ_SYS1_PLL2_DIV] = imx_clk_divider("sys1_pll2_div", "sys1_pll2", base + 0x38, 1, 6);
-	clks[IMX8MQ_SYS2_PLL2_DIV] = imx_clk_divider("sys2_pll2_div", "sys2_pll2", base + 0x44, 1, 6);
-	clks[IMX8MQ_SYS3_PLL2_DIV] = imx_clk_divider("sys3_pll2_div", "sys3_pll2", base + 0x50, 1, 6);
-	clks[IMX8MQ_DRAM_PLL2_DIV] = imx_clk_divider("dram_pll2_div", "dram_pll2", base + 0x68, 1, 6);
 
 	/* PLL bypass out */
 	clks[IMX8MQ_ARM_PLL_BYPASS] = imx_clk_mux_flags("arm_pll_bypass", base + 0x28, 14, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_SET_RATE_PARENT);
@@ -352,15 +324,6 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	clks[IMX8MQ_AUDIO_PLL2_BYPASS] = imx_clk_mux("audio_pll2_bypass", base + 0x8, 14, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypass_sels));
 	clks[IMX8MQ_VIDEO_PLL1_BYPASS] = imx_clk_mux("video_pll1_bypass", base + 0x10, 14, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass_sels));
 
-	clks[IMX8MQ_SYS1_PLL1_OUT] = imx_clk_mux("sys1_pll1_out", base + 0x30, 5, 1, sys1_pll1_out_sels, ARRAY_SIZE(sys1_pll1_out_sels));
-	clks[IMX8MQ_SYS2_PLL1_OUT] = imx_clk_mux("sys2_pll1_out", base + 0x3c, 5, 1, sys2_pll1_out_sels, ARRAY_SIZE(sys2_pll1_out_sels));
-	clks[IMX8MQ_SYS3_PLL1_OUT] = imx_clk_mux("sys3_pll1_out", base + 0x48, 5, 1, sys3_pll1_out_sels, ARRAY_SIZE(sys3_pll1_out_sels));
-	clks[IMX8MQ_DRAM_PLL1_OUT] = imx_clk_mux("dram_pll1_out", base + 0x60, 5, 1, dram_pll1_out_sels, ARRAY_SIZE(dram_pll1_out_sels));
-	clks[IMX8MQ_SYS1_PLL2_OUT] = imx_clk_mux("sys1_pll2_out", base + 0x30, 4, 1, sys1_pll2_out_sels, ARRAY_SIZE(sys1_pll2_out_sels));
-	clks[IMX8MQ_SYS2_PLL2_OUT] = imx_clk_mux("sys2_pll2_out", base + 0x3c, 4, 1, sys2_pll2_out_sels, ARRAY_SIZE(sys2_pll2_out_sels));
-	clks[IMX8MQ_SYS3_PLL2_OUT] = imx_clk_mux("sys3_pll2_out", base + 0x48, 4, 1, sys3_pll2_out_sels, ARRAY_SIZE(sys3_pll2_out_sels));
-	clks[IMX8MQ_DRAM_PLL2_OUT] = imx_clk_mux("dram_pll2_out", base + 0x60, 4, 1, dram_pll2_out_sels, ARRAY_SIZE(dram_pll2_out_sels));
-
 	/* PLL OUT GATE */
 	clks[IMX8MQ_ARM_PLL_OUT] = imx_clk_gate("arm_pll_out", "arm_pll_bypass", base + 0x28, 21);
 	clks[IMX8MQ_GPU_PLL_OUT] = imx_clk_gate("gpu_pll_out", "gpu_pll_bypass", base + 0x18, 21);
@@ -368,11 +331,11 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	clks[IMX8MQ_AUDIO_PLL1_OUT] = imx_clk_gate("audio_pll1_out", "audio_pll1_bypass", base + 0x0, 21);
 	clks[IMX8MQ_AUDIO_PLL2_OUT] = imx_clk_gate("audio_pll2_out", "audio_pll2_bypass", base + 0x8, 21);
 	clks[IMX8MQ_VIDEO_PLL1_OUT] = imx_clk_gate("video_pll1_out", "video_pll1_bypass", base + 0x10, 21);
-	clks[IMX8MQ_SYS1_PLL_OUT] = imx_clk_gate("sys1_pll_out", "sys1_pll2_out", base + 0x30, 9);
-	clks[IMX8MQ_SYS2_PLL_OUT] = imx_clk_gate("sys2_pll_out", "sys2_pll2_out", base + 0x3c, 9);
-	clks[IMX8MQ_SYS3_PLL_OUT] = imx_clk_gate("sys3_pll_out", "sys3_pll2_out", base + 0x48, 9);
-	clks[IMX8MQ_DRAM_PLL_OUT] = imx_clk_gate("dram_pll_out", "dram_pll2_out", base + 0x60, 9);
 
+	clks[IMX8MQ_SYS1_PLL_OUT] = imx_clk_sccg_pll("sys1_pll_out", sys1_pll_out_sels, ARRAY_SIZE(sys1_pll_out_sels), 0, 0, 0, base + 0x30, CLK_IS_CRITICAL);
+	clks[IMX8MQ_SYS2_PLL_OUT] = imx_clk_sccg_pll("sys2_pll_out", sys2_pll_out_sels, ARRAY_SIZE(sys2_pll_out_sels), 0, 0, 1, base + 0x3c, CLK_IS_CRITICAL);
+	clks[IMX8MQ_SYS3_PLL_OUT] = imx_clk_sccg_pll("sys3_pll_out", sys3_pll_out_sels, ARRAY_SIZE(sys3_pll_out_sels), 0, 0, 1, base + 0x48, CLK_IS_CRITICAL);
+	clks[IMX8MQ_DRAM_PLL_OUT] = imx_clk_sccg_pll("dram_pll_out", dram_pll_out_sels, ARRAY_SIZE(dram_pll_out_sels), 0, 0, 0, base + 0x60, CLK_IS_CRITICAL);
 	/* SYS PLL fixed output */
 	clks[IMX8MQ_SYS1_PLL_40M] = imx_clk_fixed_factor("sys1_pll_40m", "sys1_pll_out", 1, 20);
 	clks[IMX8MQ_SYS1_PLL_80M] = imx_clk_fixed_factor("sys1_pll_80m", "sys1_pll_out", 1, 10);
diff --git a/drivers/clk/imx/clk-sccg-pll.c b/drivers/clk/imx/clk-sccg-pll.c
index ee7752b..9dfd03a 100644
--- a/drivers/clk/imx/clk-sccg-pll.c
+++ b/drivers/clk/imx/clk-sccg-pll.c
@@ -25,87 +25,292 @@
 #define PLL_DIVF2_MASK		GENMASK(12, 7)
 #define PLL_DIVR1_MASK		GENMASK(27, 25)
 #define PLL_DIVR2_MASK		GENMASK(24, 19)
+#define PLL_DIVQ_MASK           GENMASK(6, 1)
 #define PLL_REF_MASK		GENMASK(2, 0)
 
 #define PLL_LOCK_MASK		BIT(31)
 #define PLL_PD_MASK		BIT(7)
 
-#define OSC_25M			25000000
-#define OSC_27M			27000000
+/* These are the specification limits for the SSCG PLL */
+#define PLL_REF_MIN_FREQ		25000000UL
+#define PLL_REF_MAX_FREQ		235000000UL
 
-#define PLL_SCCG_LOCK_TIMEOUT	70
+#define PLL_STAGE1_MIN_FREQ		1600000000UL
+#define PLL_STAGE1_MAX_FREQ		2400000000UL
+
+#define PLL_STAGE1_REF_MIN_FREQ		25000000UL
+#define PLL_STAGE1_REF_MAX_FREQ		54000000UL
+
+#define PLL_STAGE2_MIN_FREQ		1200000000UL
+#define PLL_STAGE2_MAX_FREQ		2400000000UL
+
+#define PLL_STAGE2_REF_MIN_FREQ		54000000UL
+#define PLL_STAGE2_REF_MAX_FREQ		75000000UL
+
+#define PLL_OUT_MIN_FREQ		20000000UL
+#define PLL_OUT_MAX_FREQ		1200000000UL
+
+#define PLL_DIVR1_MAX			7
+#define PLL_DIVR2_MAX			63
+#define PLL_DIVF1_MAX			63
+#define PLL_DIVF2_MAX			63
+#define PLL_DIVQ_MAX			63
+
+#define PLL_BYPASS_NONE			0x0
+#define PLL_BYPASS1			0x2
+#define PLL_BYPASS2			0x1
+
+#define SSCG_PLL_BYPASS1_MASK           BIT(5)
+#define SSCG_PLL_BYPASS2_MASK           BIT(4)
+#define SSCG_PLL_BYPASS_MASK		GENMASK(5, 4)
+
+#define PLL_SCCG_LOCK_TIMEOUT		70
+
+struct clk_sccg_pll_setup {
+	int divr1, divf1;
+	int divr2, divf2;
+	int divq;
+	int bypass;
+
+	uint64_t vco1;
+	uint64_t vco2;
+	uint64_t fout;
+	uint64_t ref;
+	uint64_t ref_div1;
+	uint64_t ref_div2;
+	uint64_t fout_request;
+	int fout_error;
+};
 
 struct clk_sccg_pll {
 	struct clk_hw	hw;
-	void __iomem	*base;
+	const struct clk_ops  ops;
+
+	void __iomem *base;
+
+	struct clk_sccg_pll_setup setup;
+
+	u8 parent;
+	u8 bypass1;
+	u8 bypass2;
 };
 
 #define to_clk_sccg_pll(_hw) container_of(_hw, struct clk_sccg_pll, hw)
 
-static int clk_pll_wait_lock(struct clk_sccg_pll *pll)
+static int clk_sccg_pll_wait_lock(struct clk_sccg_pll *pll)
 {
 	u32 val;
 
-	return readl_poll_timeout(pll->base, val, val & PLL_LOCK_MASK, 0,
-					PLL_SCCG_LOCK_TIMEOUT);
+	val = readl_relaxed(pll->base + PLL_CFG0);
+
+	/* don't wait for lock if all plls are bypassed */
+	if (!(val & SSCG_PLL_BYPASS2_MASK))
+		return readl_poll_timeout(pll->base, val, val & PLL_LOCK_MASK,
+						0, PLL_SCCG_LOCK_TIMEOUT);
+
+	return 0;
 }
 
-static int clk_pll1_is_prepared(struct clk_hw *hw)
+static int clk_sccg_pll2_check_match(struct clk_sccg_pll_setup *setup,
+					struct clk_sccg_pll_setup *temp_setup)
 {
-	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
-	u32 val;
+	int new_diff = temp_setup->fout - temp_setup->fout_request;
+	int diff = temp_setup->fout_error;
 
-	val = readl_relaxed(pll->base + PLL_CFG0);
-	return (val & PLL_PD_MASK) ? 0 : 1;
+	if (abs(diff) > abs(new_diff)) {
+		temp_setup->fout_error = new_diff;
+		memcpy(setup, temp_setup, sizeof(struct clk_sccg_pll_setup));
+
+		if (temp_setup->fout_request == temp_setup->fout)
+			return 0;
+	}
+	return -1;
 }
 
-static unsigned long clk_pll1_recalc_rate(struct clk_hw *hw,
-					 unsigned long parent_rate)
+static int clk_sccg_divq_lookup(struct clk_sccg_pll_setup *setup,
+				struct clk_sccg_pll_setup *temp_setup)
 {
-	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
-	u32 val, divf;
+	int ret = -EINVAL;
+
+	for (temp_setup->divq = 0; temp_setup->divq <= PLL_DIVQ_MAX;
+	     temp_setup->divq++) {
+		temp_setup->vco2 = temp_setup->vco1;
+		do_div(temp_setup->vco2, temp_setup->divr2 + 1);
+		temp_setup->vco2 *= 2;
+		temp_setup->vco2 *= temp_setup->divf2 + 1;
+		if (temp_setup->vco2 >= PLL_STAGE2_MIN_FREQ &&
+				temp_setup->vco2 <= PLL_STAGE2_MAX_FREQ) {
+			temp_setup->fout = temp_setup->vco2;
+			do_div(temp_setup->fout, 2 * (temp_setup->divq + 1));
+
+			ret = clk_sccg_pll2_check_match(setup, temp_setup);
+			if (!ret) {
+				temp_setup->bypass = PLL_BYPASS1;
+				return ret;
+			}
+		}
+	}
 
-	val = readl_relaxed(pll->base + PLL_CFG2);
-	divf = FIELD_GET(PLL_DIVF1_MASK, val);
+	return ret;
+}
+
+static int clk_sccg_divf2_lookup(struct clk_sccg_pll_setup *setup,
+					struct clk_sccg_pll_setup *temp_setup)
+{
+	int ret = -EINVAL;
+
+	for (temp_setup->divf2 = 0; temp_setup->divf2 <= PLL_DIVF2_MAX;
+	     temp_setup->divf2++) {
+		ret = clk_sccg_divq_lookup(setup, temp_setup);
+		if (!ret)
+			return ret;
+	}
 
-	return parent_rate * 2 * (divf + 1);
+	return ret;
 }
 
-static long clk_pll1_round_rate(struct clk_hw *hw, unsigned long rate,
-			       unsigned long *prate)
+static int clk_sccg_divr2_lookup(struct clk_sccg_pll_setup *setup,
+				struct clk_sccg_pll_setup *temp_setup)
 {
-	unsigned long parent_rate = *prate;
-	u32 div;
+	int ret = -EINVAL;
+
+	for (temp_setup->divr2 = 0; temp_setup->divr2 <= PLL_DIVR2_MAX;
+	     temp_setup->divr2++) {
+		temp_setup->ref_div2 = temp_setup->vco1;
+		do_div(temp_setup->ref_div2, temp_setup->divr2 + 1);
+		if (temp_setup->ref_div2 >= PLL_STAGE2_REF_MIN_FREQ &&
+		    temp_setup->ref_div2 <= PLL_STAGE2_REF_MAX_FREQ) {
+			ret = clk_sccg_divf2_lookup(setup, temp_setup);
+			if (!ret)
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int clk_sccg_pll2_find_setup(struct clk_sccg_pll_setup *setup,
+					struct clk_sccg_pll_setup *temp_setup,
+					uint64_t ref)
+{
+
+	int ret = -EINVAL;
 
-	if (!parent_rate)
-		return 0;
+	if (ref < PLL_STAGE1_MIN_FREQ || ref > PLL_STAGE1_MAX_FREQ)
+		return ret;
 
-	div = rate / (parent_rate * 2);
+	temp_setup->vco1 = ref;
 
-	return parent_rate * div * 2;
+	ret = clk_sccg_divr2_lookup(setup, temp_setup);
+	return ret;
 }
 
-static int clk_pll1_set_rate(struct clk_hw *hw, unsigned long rate,
-			    unsigned long parent_rate)
+static int clk_sccg_divf1_lookup(struct clk_sccg_pll_setup *setup,
+				struct clk_sccg_pll_setup *temp_setup)
 {
-	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
-	u32 val;
-	u32 divf;
+	int ret = -EINVAL;
 
-	if (!parent_rate)
-		return -EINVAL;
+	for (temp_setup->divf1 = 0; temp_setup->divf1 <= PLL_DIVF1_MAX;
+	     temp_setup->divf1++) {
+		uint64_t vco1 = temp_setup->ref;
 
-	divf = rate / (parent_rate * 2);
+		do_div(vco1, temp_setup->divr1 + 1);
+		vco1 *= 2;
+		vco1 *= temp_setup->divf1 + 1;
 
-	val = readl_relaxed(pll->base + PLL_CFG2);
-	val &= ~PLL_DIVF1_MASK;
-	val |= FIELD_PREP(PLL_DIVF1_MASK, divf - 1);
-	writel_relaxed(val, pll->base + PLL_CFG2);
+		ret = clk_sccg_pll2_find_setup(setup, temp_setup, vco1);
+		if (!ret) {
+			temp_setup->bypass = PLL_BYPASS_NONE;
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int clk_sccg_divr1_lookup(struct clk_sccg_pll_setup *setup,
+				struct clk_sccg_pll_setup *temp_setup)
+{
+	int ret = -EINVAL;
+
+	for (temp_setup->divr1 = 0; temp_setup->divr1 <= PLL_DIVR1_MAX;
+	     temp_setup->divr1++) {
+		temp_setup->ref_div1 = temp_setup->ref;
+		do_div(temp_setup->ref_div1, temp_setup->divr1 + 1);
+		if (temp_setup->ref_div1 >= PLL_STAGE1_REF_MIN_FREQ &&
+		    temp_setup->ref_div1 <= PLL_STAGE1_REF_MAX_FREQ) {
+			ret = clk_sccg_divf1_lookup(setup, temp_setup);
+			if (!ret)
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int clk_sccg_pll1_find_setup(struct clk_sccg_pll_setup *setup,
+					struct clk_sccg_pll_setup *temp_setup,
+					uint64_t ref)
+{
+
+	int ret = -EINVAL;
+
+	if (ref < PLL_REF_MIN_FREQ || ref > PLL_REF_MAX_FREQ)
+		return ret;
+
+	temp_setup->ref = ref;
+
+	ret = clk_sccg_divr1_lookup(setup, temp_setup);
+
+	return ret;
+}
+
+static int clk_sccg_pll_find_setup(struct clk_sccg_pll_setup *setup,
+					uint64_t prate,
+					uint64_t rate, int try_bypass)
+{
+	struct clk_sccg_pll_setup temp_setup;
+	int ret = -EINVAL;
+
+	memset(&temp_setup, 0, sizeof(struct clk_sccg_pll_setup));
+	memset(setup, 0, sizeof(struct clk_sccg_pll_setup));
+
+	temp_setup.fout_error = PLL_OUT_MAX_FREQ;
+	temp_setup.fout_request = rate;
+
+	switch (try_bypass) {
 
-	return clk_pll_wait_lock(pll);
+	case PLL_BYPASS2:
+		if (prate == rate) {
+			setup->bypass = PLL_BYPASS2;
+			setup->fout = rate;
+			ret = 0;
+		}
+		break;
+
+	case PLL_BYPASS1:
+		ret = clk_sccg_pll2_find_setup(setup, &temp_setup, prate);
+		break;
+
+	case PLL_BYPASS_NONE:
+		ret = clk_sccg_pll1_find_setup(setup, &temp_setup, prate);
+		break;
+	}
+
+	return ret;
+}
+
+
+static int clk_sccg_pll_is_prepared(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+
+	u32 val = readl_relaxed(pll->base + PLL_CFG0);
+
+	return (val & PLL_PD_MASK) ? 0 : 1;
 }
 
-static int clk_pll1_prepare(struct clk_hw *hw)
+static int clk_sccg_pll_prepare(struct clk_hw *hw)
 {
 	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
 	u32 val;
@@ -114,10 +319,10 @@ static int clk_pll1_prepare(struct clk_hw *hw)
 	val &= ~PLL_PD_MASK;
 	writel_relaxed(val, pll->base + PLL_CFG0);
 
-	return clk_pll_wait_lock(pll);
+	return clk_sccg_pll_wait_lock(pll);
 }
 
-static void clk_pll1_unprepare(struct clk_hw *hw)
+static void clk_sccg_pll_unprepare(struct clk_hw *hw)
 {
 	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
 	u32 val;
@@ -125,121 +330,208 @@ static void clk_pll1_unprepare(struct clk_hw *hw)
 	val = readl_relaxed(pll->base + PLL_CFG0);
 	val |= PLL_PD_MASK;
 	writel_relaxed(val, pll->base + PLL_CFG0);
-
 }
 
-static unsigned long clk_pll2_recalc_rate(struct clk_hw *hw,
+static unsigned long clk_sccg_pll_recalc_rate(struct clk_hw *hw,
 					 unsigned long parent_rate)
 {
 	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
-	u32 val, ref, divr1, divf1, divr2, divf2;
+	u32 val, divr1, divf1, divr2, divf2, divq;
 	u64 temp64;
 
-	val = readl_relaxed(pll->base + PLL_CFG0);
-	switch (FIELD_GET(PLL_REF_MASK, val)) {
-	case 0:
-		ref = OSC_25M;
-		break;
-	case 1:
-		ref = OSC_27M;
-		break;
-	default:
-		ref = OSC_25M;
-		break;
-	}
-
 	val = readl_relaxed(pll->base + PLL_CFG2);
 	divr1 = FIELD_GET(PLL_DIVR1_MASK, val);
 	divr2 = FIELD_GET(PLL_DIVR2_MASK, val);
 	divf1 = FIELD_GET(PLL_DIVF1_MASK, val);
 	divf2 = FIELD_GET(PLL_DIVF2_MASK, val);
-
-	temp64 = ref * 2;
-	temp64 *= (divf1 + 1) * (divf2 + 1);
-
-	do_div(temp64, (divr1 + 1) * (divr2 + 1));
+	divq = FIELD_GET(PLL_DIVQ_MASK, val);
+
+	temp64 = parent_rate;
+
+	val = clk_readl(pll->base + PLL_CFG0);
+	if (val & SSCG_PLL_BYPASS2_MASK) {
+		temp64 = parent_rate;
+	} else if (val & SSCG_PLL_BYPASS1_MASK) {
+		temp64 *= divf2;
+		do_div(temp64, (divr2 + 1) * (divq + 1));
+	} else {
+		temp64 *= 2;
+		temp64 *= (divf1 + 1) * (divf2 + 1);
+		do_div(temp64, (divr1 + 1) * (divr2 + 1) * (divq + 1));
+	}
 
 	return temp64;
 }
 
-static long clk_pll2_round_rate(struct clk_hw *hw, unsigned long rate,
-			       unsigned long *prate)
+static int clk_sccg_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
 {
-	u32 div;
-	unsigned long parent_rate = *prate;
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	struct clk_sccg_pll_setup *setup = &pll->setup;
+	u32 val;
 
-	if (!parent_rate)
-		return 0;
+	/* set bypass here too since the parent might be the same */
+	val = clk_readl(pll->base + PLL_CFG0);
+	val &= ~SSCG_PLL_BYPASS_MASK;
+	val |= FIELD_PREP(SSCG_PLL_BYPASS_MASK, setup->bypass);
+	clk_writel(val, pll->base + PLL_CFG0);
 
-	div = rate / parent_rate;
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	val &= ~(PLL_DIVF1_MASK | PLL_DIVF2_MASK);
+	val &= ~(PLL_DIVR1_MASK | PLL_DIVR2_MASK | PLL_DIVQ_MASK);
+	val |= FIELD_PREP(PLL_DIVF1_MASK, setup->divf1);
+	val |= FIELD_PREP(PLL_DIVF2_MASK, setup->divf2);
+	val |= FIELD_PREP(PLL_DIVR1_MASK, setup->divr1);
+	val |= FIELD_PREP(PLL_DIVR2_MASK, setup->divr2);
+	val |= FIELD_PREP(PLL_DIVQ_MASK, setup->divq);
+	writel_relaxed(val, pll->base + PLL_CFG2);
 
-	return parent_rate * div;
+	return clk_sccg_pll_wait_lock(pll);
 }
 
-static int clk_pll2_set_rate(struct clk_hw *hw, unsigned long rate,
-			    unsigned long parent_rate)
+static u8 clk_sccg_pll_get_parent(struct clk_hw *hw)
 {
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
 	u32 val;
-	u32 divf;
+	u8 ret = pll->parent;
+
+	val = clk_readl(pll->base + PLL_CFG0);
+	if (val & SSCG_PLL_BYPASS2_MASK)
+		ret = pll->bypass2;
+	else if (val & SSCG_PLL_BYPASS1_MASK)
+		ret = pll->bypass1;
+	return ret;
+}
+
+static int clk_sccg_pll_set_parent(struct clk_hw *hw, u8 index)
+{
 	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
 
-	if (!parent_rate)
-		return -EINVAL;
+	val = clk_readl(pll->base + PLL_CFG0);
+	val &= ~SSCG_PLL_BYPASS_MASK;
+	val |= FIELD_PREP(SSCG_PLL_BYPASS_MASK, pll->setup.bypass);
+	clk_writel(val, pll->base + PLL_CFG0);
 
-	divf = rate / parent_rate;
+	return clk_sccg_pll_wait_lock(pll);
+}
 
-	val = readl_relaxed(pll->base + PLL_CFG2);
-	val &= ~PLL_DIVF2_MASK;
-	val |= FIELD_PREP(PLL_DIVF2_MASK, divf - 1);
-	writel_relaxed(val, pll->base + PLL_CFG2);
+static int __clk_sccg_pll_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req,
+					uint64_t min,
+					uint64_t max,
+					uint64_t rate,
+					int bypass)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	struct clk_sccg_pll_setup *setup = &pll->setup;
+	struct clk_hw *parent_hw = NULL;
+	int bypass_parent_index;
+	int ret = -EINVAL;
+
+	req->max_rate = max;
+	req->min_rate = min;
+
+	switch (bypass) {
+	case PLL_BYPASS2:
+		bypass_parent_index = pll->bypass2;
+		break;
+	case PLL_BYPASS1:
+		bypass_parent_index = pll->bypass1;
+		break;
+	default:
+		bypass_parent_index = pll->parent;
+		break;
+	}
+
+	parent_hw = clk_hw_get_parent_by_index(hw, bypass_parent_index);
+	ret = __clk_determine_rate(parent_hw, req);
+	if (!ret) {
+		ret = clk_sccg_pll_find_setup(setup, req->rate,
+						rate, bypass);
+	}
+
+	req->best_parent_hw = parent_hw;
+	req->best_parent_rate = req->rate;
+	req->rate = setup->fout;
 
-	return clk_pll_wait_lock(pll);
+	return ret;
 }
 
-static const struct clk_ops clk_sccg_pll1_ops = {
-	.is_prepared	= clk_pll1_is_prepared,
-	.recalc_rate	= clk_pll1_recalc_rate,
-	.round_rate	= clk_pll1_round_rate,
-	.set_rate	= clk_pll1_set_rate,
-};
+static int clk_sccg_pll_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	struct clk_sccg_pll_setup *setup = &pll->setup;
+	uint64_t rate = req->rate;
+	uint64_t min = req->min_rate;
+	uint64_t max = req->max_rate;
+	int ret = -EINVAL;
+
+	if (rate < PLL_OUT_MIN_FREQ || rate > PLL_OUT_MAX_FREQ)
+		return ret;
+
+	ret = __clk_sccg_pll_determine_rate(hw, req, req->rate, req->rate,
+						rate, PLL_BYPASS2);
+	if (!ret)
+		return ret;
+
+	ret = __clk_sccg_pll_determine_rate(hw, req, PLL_STAGE1_REF_MIN_FREQ,
+						PLL_STAGE1_REF_MAX_FREQ, rate,
+						PLL_BYPASS1);
+	if (!ret)
+		return ret;
+
+	ret = __clk_sccg_pll_determine_rate(hw, req, PLL_REF_MIN_FREQ,
+						PLL_REF_MAX_FREQ, rate,
+						PLL_BYPASS_NONE);
+	if (!ret)
+		return ret;
+
+	if (setup->fout >= min && setup->fout <= max)
+		ret = 0;
+
+	return ret;
+}
 
-static const struct clk_ops clk_sccg_pll2_ops = {
-	.prepare	= clk_pll1_prepare,
-	.unprepare	= clk_pll1_unprepare,
-	.recalc_rate	= clk_pll2_recalc_rate,
-	.round_rate	= clk_pll2_round_rate,
-	.set_rate	= clk_pll2_set_rate,
+static const struct clk_ops clk_sccg_pll_ops = {
+	.prepare	= clk_sccg_pll_prepare,
+	.unprepare	= clk_sccg_pll_unprepare,
+	.is_prepared	= clk_sccg_pll_is_prepared,
+	.recalc_rate	= clk_sccg_pll_recalc_rate,
+	.set_rate	= clk_sccg_pll_set_rate,
+	.set_parent	= clk_sccg_pll_set_parent,
+	.get_parent	= clk_sccg_pll_get_parent,
+	.determine_rate	= clk_sccg_pll_determine_rate,
 };
 
 struct clk *imx_clk_sccg_pll(const char *name,
-				const char *parent_name,
+				const char * const *parent_names,
+				u8 num_parents,
+				u8 parent, u8 bypass1, u8 bypass2,
 				void __iomem *base,
-				enum imx_sccg_pll_type pll_type)
+				unsigned long flags)
 {
 	struct clk_sccg_pll *pll;
 	struct clk_init_data init;
 	struct clk_hw *hw;
 	int ret;
 
-	switch (pll_type) {
-	case SCCG_PLL1:
-		init.ops = &clk_sccg_pll1_ops;
-		break;
-	case SCCG_PLL2:
-		init.ops = &clk_sccg_pll2_ops;
-		break;
-	default:
-		return ERR_PTR(-EINVAL);
-	}
-
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
 	if (!pll)
 		return ERR_PTR(-ENOMEM);
 
+	pll->parent = parent;
+	pll->bypass1 = bypass1;
+	pll->bypass2 = bypass2;
+
+	pll->base = base;
 	init.name = name;
-	init.flags = 0;
-	init.parent_names = &parent_name;
-	init.num_parents = 1;
+	init.ops = &clk_sccg_pll_ops;
+
+	init.flags = flags;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
 
 	pll->base = base;
 	pll->hw.init = &init;
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 0aa48d3..5748ec8 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -60,9 +60,12 @@ struct clk *imx_clk_pllv2(const char *name, const char *parent,
 struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
 			     void __iomem *base);
 
-struct clk *imx_clk_sccg_pll(const char *name, const char *parent_name,
-			     void __iomem *base,
-			     enum imx_sccg_pll_type pll_type);
+struct clk *imx_clk_sccg_pll(const char *name,
+				const char * const *parent_names,
+				u8 num_parents,
+				u8 parent, u8 bypass1, u8 bypass2,
+				void __iomem *base,
+				unsigned long flags);
 
 enum imx_pllv3_type {
 	IMX_PLLV3_GENERIC,
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
