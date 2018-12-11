Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C582C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:14:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E85692081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="adixj6S9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YeOGqtYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85692081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Feafw8u5fcRo0coEQbpDHyiaEbGKd8l7QCRUXAg7Qi0=; b=adixj6S9cMgCt9
	xr6RK8NpFuOgg32KoVXuNb+SeTaVNBZDcMRfAbmq2oZKD1cyaABQu4pZw0grzPggXS2cXt6b+K6aP
	ayDVH35tXjp69JXbd5ArL8WDtd4p1gMU2Fy9A2NtZCUBsqbOb5YK5XI/YCB/a8g92fW7hIAlO7hO5
	yMOpN21/y4CxRJ6jQ0iDR4x/TCm7NFh6F3Su/xE+rDb7j4F0AMV0s6DP07VlO7d/HLnekaBnw4Ypw
	y8wakVJJ6xQ0A3CH060RmhoGueHCSkiLNZ+Cd93WdXGBKMWMAgJ72oa3Vc95dFH9ofp3TakHM18pD
	XCebuXzqwGBHNv/kfj5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWjjs-0008Kl-At; Tue, 11 Dec 2018 15:14:24 +0000
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWjjC-0007Vk-6E
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 15:13:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4Rbyynk+kiYbZ8PxMnkrTJXknDpIONuLpdpgUAv2i0=;
 b=YeOGqtYXQLMm0xye25o/Vucs1aF9mVBOLq6ggE0nWXknhnzCkBBeRJk5+ntSFalxGWciPF6qAnPEmbCOuuTK8+FG9pGb8OuOa7asAH65x2gBKX1HU5jvUFxyUDlmcoeO7abP+J5B/2/nGhI7p0h2WbuRz0eaAqGuXzTsFuZ9Tkw=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4291.eurprd04.prod.outlook.com (52.134.126.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Tue, 11 Dec 2018 15:13:31 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 15:13:31 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V10 3/7] dt-bindings: clock: imx8qxp: add SCU clock IDs
Thread-Topic: [PATCH V10 3/7] dt-bindings: clock: imx8qxp: add SCU clock IDs
Thread-Index: AQHUkWQT8f31C/QqQkaQewUO9nLZAg==
Date: Tue, 11 Dec 2018 15:13:30 +0000
Message-ID: <1544540867-6342-4-git-send-email-aisheng.dong@nxp.com>
References: <1544540867-6342-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1544540867-6342-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0081.apcprd03.prod.outlook.com
 (2603:1096:203:72::21) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4291;
 6:4wpRBBiBLNJSfMM2X+cefFwfSkw5wLuSq476fvg88/EuNxtMdWg2/awvJbLfwV06nuamwc8YTtAxlqehdMoDcJn0hOUXclJWicHf6VyHNNQ4MwtKlRcDHnjd4/YJ6bwgXdAETCGTz5YHRVYkXR0X/qHsqyzFOeg4px4HquO0cw4x7zWT4JXydpi/hDxMrtbHqumwDSMdJGh1xR3gc/ZhMO8CLm/qkpdL3JY3DW54co7LJkBOSagOYugciQqgozdEFtTBAPxwS/xxiq9bvj6BR2gRhMWsF4AMbrAJLHZ01xwD+qseKskwbO8Klq+GoWjDkTde3lTxHgseR8MVEbgASSQcx10Rs1D6oWRGS2Ds+Lij33VEHhGm+NXDwBc4CkY4brvGqhtMS3kkUa7q5CyBYeT6+TvOanXbeesBuUu7dudppbeHI95E9ObRu64NNA8MF+Bh60lGKQw4l3T1IZTxYw==;
 5:c2ccGyzkOfuJtmCoeBsZbQYHabBd96a6Ahwlghusoj+uMvciuoZ3VThlvuwkP+16F40fodR9RswDqfzqTo/2sWF7CKwPI659/8ZuubwTj7RJ7NC50P4laSnEuOoxUIeTm74x77NL86zAvHXVGdj1tQyzjvJBTa3hCJ0BXgL6i7Y=;
 7:IYyVLVKYHTKpmGci/e1I+CHFooZ5y2ej3j1o6G5V7dqa+hcQnT3mKtyU8plcyV3S8EPjdVRARp3g7EKE86s+Xf7bzPTcPVkZgdqcU8O/3qgs5/HI8DkDWup9AHLvtCbkX2uRxKbipOVzNg3z/G3vpA==
x-ms-office365-filtering-correlation-id: e8183fb3-3164-41bf-3226-08d65f7b3228
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4291; 
x-ms-traffictypediagnostic: AM0PR04MB4291:
x-microsoft-antispam-prvs: <AM0PR04MB42915578FCE05695E57730C880A60@AM0PR04MB4291.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231472)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4291; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4291; 
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(396003)(39860400002)(366004)(346002)(136003)(199004)(189003)(102836004)(3846002)(386003)(6506007)(66066001)(486006)(26005)(6512007)(8676002)(186003)(6116002)(4326008)(476003)(2616005)(446003)(97736004)(11346002)(54906003)(316002)(25786009)(36756003)(76176011)(53936002)(6486002)(99286004)(6436002)(106356001)(44832011)(105586002)(5640700003)(5660300001)(2351001)(52116002)(7736002)(6916009)(68736007)(71200400001)(71190400001)(86362001)(50226002)(305945005)(2906002)(14444005)(2501003)(8936002)(478600001)(81156014)(256004)(81166006)(14454004)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4291;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aTOqVuOcIIjDVbtAy4U6qZ+bl7/hfLZybHFcoWrVg8nzGvNEFMowBeL0Z4h4uxB6pe1kdseBQnbWO0oGkvXBrDNM9gxky9stJlcTaMpaCEjrq+aY9TqkRQmCTtQGzJXXj7jQ6+OkbIYjgj1eTk8+dlLHm06E/XljMjaaLBx0FG3FQ8ca9DEY64K6UVS1XUTQVNqmScYpv/sdBa6un3qAiDAc9vT2GuY3OA0XiB9Gu5QBsI7ytGNqnAJZp3CNNHFat3Iu4Quf59TrACl5CAOulGlOKPf0kk4Tl2/fGxLXRuVGej2wkXHzBC9DU1G3RTnE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8183fb3-3164-41bf-3226-08d65f7b3228
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 15:13:30.9328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4291
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_071342_866310_B7E8F34A 
X-CRM114-Status: GOOD (  13.01  )
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
 "sboyd@kernel.org" <sboyd@kernel.org>,
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

Add IMX8QXP SCU clock IDs.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: devicetree@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v6->v10:
 * no changes
v6: new patch, separate from driver changes to avoid a checkpatch warning
    IDs are changed a lot due to SCU divider/gate/mux are merged into
    one general SCU clock and LPCG clocks are moved out.
---
 include/dt-bindings/clock/imx8qxp-clock.h | 136 ++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100644 include/dt-bindings/clock/imx8qxp-clock.h

diff --git a/include/dt-bindings/clock/imx8qxp-clock.h b/include/dt-bindings/clock/imx8qxp-clock.h
new file mode 100644
index 0000000..d72a39c
--- /dev/null
+++ b/include/dt-bindings/clock/imx8qxp-clock.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2018 NXP
+ *   Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMX8QXP_H
+#define __DT_BINDINGS_CLOCK_IMX8QXP_H
+
+/* SCU Clocks */
+
+#define IMX8QXP_CLK_DUMMY				0
+
+/* CPU */
+#define IMX8QXP_A35_CLK					1
+
+/* LSIO SS */
+#define IMX8QXP_LSIO_MEM_CLK				2
+#define IMX8QXP_LSIO_BUS_CLK				3
+#define IMX8QXP_LSIO_PWM0_CLK				10
+#define IMX8QXP_LSIO_PWM1_CLK				11
+#define IMX8QXP_LSIO_PWM2_CLK				12
+#define IMX8QXP_LSIO_PWM3_CLK				13
+#define IMX8QXP_LSIO_PWM4_CLK				14
+#define IMX8QXP_LSIO_PWM5_CLK				15
+#define IMX8QXP_LSIO_PWM6_CLK				16
+#define IMX8QXP_LSIO_PWM7_CLK				17
+#define IMX8QXP_LSIO_GPT0_CLK				18
+#define IMX8QXP_LSIO_GPT1_CLK				19
+#define IMX8QXP_LSIO_GPT2_CLK				20
+#define IMX8QXP_LSIO_GPT3_CLK				21
+#define IMX8QXP_LSIO_GPT4_CLK				22
+#define IMX8QXP_LSIO_FSPI0_CLK				23
+#define IMX8QXP_LSIO_FSPI1_CLK				24
+
+/* Connectivity SS */
+#define IMX8QXP_CONN_AXI_CLK_ROOT			30
+#define IMX8QXP_CONN_AHB_CLK_ROOT			31
+#define IMX8QXP_CONN_IPG_CLK_ROOT			32
+#define IMX8QXP_CONN_SDHC0_CLK				40
+#define IMX8QXP_CONN_SDHC1_CLK				41
+#define IMX8QXP_CONN_SDHC2_CLK				42
+#define IMX8QXP_CONN_ENET0_ROOT_CLK			43
+#define IMX8QXP_CONN_ENET0_BYPASS_CLK			44
+#define IMX8QXP_CONN_ENET0_RGMII_CLK			45
+#define IMX8QXP_CONN_ENET1_ROOT_CLK			46
+#define IMX8QXP_CONN_ENET1_BYPASS_CLK			47
+#define IMX8QXP_CONN_ENET1_RGMII_CLK			48
+#define IMX8QXP_CONN_GPMI_BCH_IO_CLK			49
+#define IMX8QXP_CONN_GPMI_BCH_CLK			50
+#define IMX8QXP_CONN_USB2_ACLK				51
+#define IMX8QXP_CONN_USB2_BUS_CLK			52
+#define IMX8QXP_CONN_USB2_LPM_CLK			53
+
+/* HSIO SS */
+#define IMX8QXP_HSIO_AXI_CLK				60
+#define IMX8QXP_HSIO_PER_CLK				61
+
+/* Display controller SS */
+#define IMX8QXP_DC_AXI_EXT_CLK				70
+#define IMX8QXP_DC_AXI_INT_CLK				71
+#define IMX8QXP_DC_CFG_CLK				72
+#define IMX8QXP_DC0_PLL0_CLK				80
+#define IMX8QXP_DC0_PLL1_CLK				81
+#define IMX8QXP_DC0_DISP0_CLK				82
+#define IMX8QXP_DC0_DISP1_CLK				83
+
+/* MIPI-LVDS SS */
+#define IMX8QXP_MIPI_IPG_CLK				90
+#define IMX8QXP_MIPI0_PIXEL_CLK				100
+#define IMX8QXP_MIPI0_BYPASS_CLK			101
+#define IMX8QXP_MIPI0_LVDS_PIXEL_CLK			102
+#define IMX8QXP_MIPI0_LVDS_BYPASS_CLK			103
+#define IMX8QXP_MIPI0_LVDS_PHY_CLK			104
+#define IMX8QXP_MIPI0_I2C0_CLK				105
+#define IMX8QXP_MIPI0_I2C1_CLK				106
+#define IMX8QXP_MIPI0_PWM0_CLK				107
+#define IMX8QXP_MIPI1_PIXEL_CLK				108
+#define IMX8QXP_MIPI1_BYPASS_CLK			109
+#define IMX8QXP_MIPI1_LVDS_PIXEL_CLK			110
+#define IMX8QXP_MIPI1_LVDS_BYPASS_CLK			111
+#define IMX8QXP_MIPI1_LVDS_PHY_CLK			112
+#define IMX8QXP_MIPI1_I2C0_CLK				113
+#define IMX8QXP_MIPI1_I2C1_CLK				114
+#define IMX8QXP_MIPI1_PWM0_CLK				115
+
+/* IMG SS */
+#define IMX8QXP_IMG_AXI_CLK				120
+#define IMX8QXP_IMG_IPG_CLK				121
+#define IMX8QXP_IMG_PXL_CLK				122
+
+/* MIPI-CSI SS */
+#define IMX8QXP_CSI0_CORE_CLK				130
+#define IMX8QXP_CSI0_ESC_CLK				131
+#define IMX8QXP_CSI0_PWM0_CLK				132
+#define IMX8QXP_CSI0_I2C0_CLK				133
+
+/* PARALLER CSI SS */
+#define IMX8QXP_PARALLEL_CSI_DPLL_CLK			140
+#define IMX8QXP_PARALLEL_CSI_PIXEL_CLK			141
+#define IMX8QXP_PARALLEL_CSI_MCLK_CLK			142
+
+/* VPU SS */
+#define IMX8QXP_VPU_ENC_CLK				150
+#define IMX8QXP_VPU_DEC_CLK				151
+
+/* GPU SS */
+#define IMX8QXP_GPU0_CORE_CLK				160
+#define IMX8QXP_GPU0_SHADER_CLK				161
+
+/* ADMA SS */
+#define IMX8QXP_ADMA_IPG_CLK_ROOT			165
+#define IMX8QXP_ADMA_UART0_CLK				170
+#define IMX8QXP_ADMA_UART1_CLK				171
+#define IMX8QXP_ADMA_UART2_CLK				172
+#define IMX8QXP_ADMA_UART3_CLK				173
+#define IMX8QXP_ADMA_SPI0_CLK				174
+#define IMX8QXP_ADMA_SPI1_CLK				175
+#define IMX8QXP_ADMA_SPI2_CLK				176
+#define IMX8QXP_ADMA_SPI3_CLK				177
+#define IMX8QXP_ADMA_CAN0_CLK				178
+#define IMX8QXP_ADMA_CAN1_CLK				179
+#define IMX8QXP_ADMA_CAN2_CLK				180
+#define IMX8QXP_ADMA_I2C0_CLK				181
+#define IMX8QXP_ADMA_I2C1_CLK				182
+#define IMX8QXP_ADMA_I2C2_CLK				183
+#define IMX8QXP_ADMA_I2C3_CLK				184
+#define IMX8QXP_ADMA_FTM0_CLK				185
+#define IMX8QXP_ADMA_FTM1_CLK				186
+#define IMX8QXP_ADMA_ADC0_CLK				187
+#define IMX8QXP_ADMA_PWM_CLK				188
+#define IMX8QXP_ADMA_LCD_CLK				189
+
+#define IMX8QXP_SCU_CLK_END				190
+
+#endif /* __DT_BINDINGS_CLOCK_IMX8QXP_H */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
