Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E85C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:04:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8CE220836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oEDlr+mg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NZSq3n7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8CE220836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D+wIXIn59hN++Hx9XbeZufFQ0zw7AoI/09XhyI6vHeI=; b=oEDlr+mgoZiDyf
	eevgOKjgSK0TKK/oYyPhoJ37f8XSSubrU+vB8L3YRgBp+jA5f0YucCFnSnLjwOMPbqjACSmcm2zm/
	zBceX39xDDOYUqDUo6wAuIxywkr4n0QCi16ZjIl5VsWWlNB1TDlZsDzJ2LcI/xDrnHK4E98HcMrw8
	+moYvr3gWbng9JojB3mNg9mWFZv4rlz2v0j+td278XU93wJRot8HGvueCkU8RfXCjuW95wW4b5AvU
	eYBsIeV86uwg9Ny64hljfqbhRqZVmIFffHas1sfK0ws6O9MIc3YKUY5XI/Vle7Ss9/76nmlPCyNKJ
	OLUEHNOlmFfMURbV4QWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwshu-00076D-8g; Thu, 21 Feb 2019 18:04:26 +0000
Received: from mail-db5eur03on062e.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::62e]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwshR-0006Mm-6v
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 18:03:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4SO+A1BXfvLtvNqz7MHtp5rJIQDpE2V70yBtLw0FfU=;
 b=NZSq3n7Nqv8eqTIH7esFF+YpleK/YlrVX4CVbWqfJKgNuK1d5eufwoUasnNhM45rvyUx1eXUUlbfFexIxDWEuGkHW0aCZH03v2rQ8i58sv4LOWT1H0geUcci9n7w6Kfg0VjlDLf7YzGQ5HOPzbeJz1zUtqCc+gYFs+BtC8uH4G4=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB1663.eurprd04.prod.outlook.com (10.164.85.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Thu, 21 Feb 2019 18:03:51 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 18:03:51 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH 3/4] clk: imx: imx8qxp: add parsing clocks from device tree
Thread-Topic: [PATCH 3/4] clk: imx: imx8qxp: add parsing clocks from device
 tree
Thread-Index: AQHUyg/MD67g7uqnCE2saCOKw8+KDA==
Date: Thu, 21 Feb 2019 18:03:51 +0000
Message-ID: <1550771836-10014-4-git-send-email-aisheng.dong@nxp.com>
References: <1550771836-10014-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1550771836-10014-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To VI1PR04MB4222.eurprd04.prod.outlook.com
 (2603:10a6:803:3e::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9c43c61-7b6f-4d08-f68c-08d69826ef35
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB1663; 
x-ms-traffictypediagnostic: VI1PR04MB1663:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB1663;
 23:f3lgCKkz5T+tVWh+N4qFW6+nRXmz1EJHbQXpUPY?=
 =?iso-8859-1?Q?Qw4vx2u03qw48kuF+v5vVFetNvVo/xoC7ekgr8rjC9c7H1aJlhkVYn/H7r?=
 =?iso-8859-1?Q?w0MXK+p4E6DUEh4mgUNheGnh0+ul8ke/jo/BowCUy+aYmGHnPGAMfKGK5S?=
 =?iso-8859-1?Q?JZlzXmS1lbtkRzfihQtQyMM22sX6IP+BgtudVLdBnsIJ4Z2k+12OHKjrjO?=
 =?iso-8859-1?Q?GYFtdKqVA7TR1Oe6H3Iyc9t7k8AtqXsgdjicMOJsxpIpKO2vIO6Rc/BD8u?=
 =?iso-8859-1?Q?YsdsyaoPc++m35/yENfuH4nwTm69mExMhQjJh39fNP8WHlMiNxWZ0fquTq?=
 =?iso-8859-1?Q?nUuaDXiLMcPh4jtcjUQpcPH4uXx6R4TubuQrUMNfdXp3PQ6J62cPX0gAEw?=
 =?iso-8859-1?Q?+Wh/Im10b/ZlHHRGDZ6LXB/VtUnjfQVpR0QjDBElAy7rgNbQ1+MUwgBR1e?=
 =?iso-8859-1?Q?BfkKBsQB9xOAEuzT33/JE0g5kex8iZgnp5Fr9Ipfpwg8kgevuWZU1Ki/Kx?=
 =?iso-8859-1?Q?cDLkLv3nlsibj2tkndCinTi5xJzwp8ixYs3BWfI97IimYY2z156VO/idZG?=
 =?iso-8859-1?Q?hKIzT3e6ttV3kTDIdihkfpBlSc2MqakIkhn8p5N96TgIcODv1VxPnKW6az?=
 =?iso-8859-1?Q?u2yYAyF7GPjcOEoGG0J+kY9cw1Zi5eWPMLjSZA4yNmhEl3rJU3o7BYL0jq?=
 =?iso-8859-1?Q?FvW2ixmQTm/htcPIsNf1d7S9pB6A3shvzBpPf5GMng6+8WflsOOoFaurEK?=
 =?iso-8859-1?Q?6ZJuGXjVpaSX4BbBQRHCSStK+Y4gLBTTJfcQ2nB4rt+Wm/eMfwqBZ0L6BC?=
 =?iso-8859-1?Q?nK8/WFoW92MnECe6ZM0BHbu24V96KBfNqsBcpcVa4BPAfkOACMTWWCcz5S?=
 =?iso-8859-1?Q?Qegw6eWesm70FJCuxcoHU7hRROgzbi++fCiqxqw3vBAHMVZAcbkm997N3R?=
 =?iso-8859-1?Q?nbYBd0Su67ERweS/kz6AQmzREeStxN71Jhm01Q5v5dqAdBaMtETOcUzzsK?=
 =?iso-8859-1?Q?zRRM5YiHfk9WjyEtu0kqgESRMrgWcn1vWq5dRIl12dq6h/ZGf8L9q5c5bk?=
 =?iso-8859-1?Q?tYTfo+KzKoLvOOfutTKJXdiXdEXzPd3TtJN2eyrDgJYOxStulmkmYizHZX?=
 =?iso-8859-1?Q?WDlvVwk2Nyfy7ynmPWA9Ma8QbO6t0f1S3L7rSRkTNj9wuqwqscKwbTIUdH?=
 =?iso-8859-1?Q?Yvyj1NoMMR/PlkRzRxn+9VNWuCejtQ6zuO9d4fOMXLrM+mbiczTiisJ7a6?=
 =?iso-8859-1?Q?uCSFRf4NqDFlmrcmBEs+NLVSF6qymsnW0hc+VvWw3lXXc/YfExJ4wLnEnE?=
 =?iso-8859-1?Q?Q+T5YA0AlN1QUmuTOHf+k5R/JrzHN0LYTPEti8IQdMYVQ=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB16634F60D76EDAC5D79FA37A807E0@VI1PR04MB1663.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(2906002)(8936002)(186003)(81156014)(4326008)(71200400001)(71190400001)(6506007)(97736004)(99286004)(102836004)(26005)(50226002)(2351001)(6512007)(68736007)(81166006)(386003)(3846002)(14454004)(6116002)(476003)(316002)(8676002)(5660300002)(478600001)(54906003)(2616005)(25786009)(44832011)(36756003)(305945005)(446003)(105586002)(106356001)(6486002)(486006)(76176011)(7736002)(53936002)(66066001)(52116002)(256004)(2501003)(6436002)(5640700003)(11346002)(6916009)(86362001)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB1663;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HIlT1084QzVrH6k2yfq6f8ZcAQEwzUTp1PhGZ+B4qf3aUyMYQd5nfXbDIv8JJCvTYUmJpVAkHC0KdY3JBkaIPa0NTY4dCSJRYoehg8eXiarDV3DROP3OinBkzHfzmez1uESLZOShdmQRj7Tb5O8c54yASv0xKT6QIUtoA3qrjZVqS4F7i3D8OlMebfP6c1WAVdutxbk2iYetEa3IoCekYJk++jhhz6xmvtYZdPfSd610N9hohbJYC5BP3a/1Y3u6v7Z+rUj/ChTmHFCZvNJAnB9RrvXDcqDWC+dCqMWSJ7VRyEMAzMUHNLgnzm68cylZGH4E41NpXknAZC2yZRz27ywE2DuHSkkIAoLmZbwAQUzYdyLjhaf58fGaNkgISN6kVtuANnhB7fofI41EYVWX2JESxPWqoobr/StZYYUHpE4=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c43c61-7b6f-4d08-f68c-08d69826ef35
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 18:03:48.0344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1663
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_100357_661077_D8E3D59C 
X-CRM114-Status: GOOD (  11.37  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

add parsing clocks from device tree

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 83e2ef9..7c5f8c6 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -17,17 +17,60 @@
 #include <dt-bindings/clock/imx8-clock.h>
 #include <dt-bindings/firmware/imx/rsrc.h>
 
+static int imx_scu_parse_clks_from_dt(struct device *dev,
+				      const struct device_node *np)
+{
+	struct clk_hw *hw;
+	const char *name;
+	int clk_type;
+	int rsrc_id;
+	int ret;
+
+	ret = of_property_read_u32(np, "rsrc-id", &rsrc_id);
+	if (ret) {
+		dev_err(dev, "failed to parse rsrc-id\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(np, "clk-type", &clk_type);
+	if (ret) {
+		dev_err(dev, "failed to parse clk-type\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_string(np, "clock-output-names", &name);
+	if (ret) {
+		dev_err(dev, "failed to parse clock-output-names\n");
+		return -EINVAL;
+	}
+
+	hw = imx_clk_scu(name, rsrc_id, clk_type);
+	if (IS_ERR(hw)) {
+		dev_err(dev, "failed to register clock\n");
+		return -EINVAL;
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
+}
+
 static int imx8qxp_clk_probe(struct platform_device *pdev)
 {
 	struct device_node *ccm_node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data;
 	struct clk_hw **clks;
+	u32 clock_cells;
 	int ret, i;
 
 	ret = imx_clk_scu_init();
 	if (ret)
 		return ret;
 
+	/* try new binding to parse clocks from device tree first */
+	of_property_read_u32(ccm_node, "#clock-cells", &clock_cells);
+
+	if (clock_cells == 0)
+		return imx_scu_parse_clks_from_dt(&pdev->dev, ccm_node);
+
 	clk_data = devm_kzalloc(&pdev->dev, struct_size(clk_data, hws,
 				IMX_SCU_CLK_END), GFP_KERNEL);
 	if (!clk_data)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
