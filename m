Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24C9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:20:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B0821971
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HiQkG6sx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nn7fGd7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B0821971
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=AAjRVflhDSPtxbqV/OiOeVbIy+3EKLuKLMbL+owHCU4=; b=HiQkG6sxkKF2AI
	qMNrvtmRcDf5mZOlxI5UjCv6g662x3oi8VqxBB3FgmDYtHo0M+cI3efixcEYstpLAGcIcEit+2Nn+
	1z81qei+5ZNBRi7kN7O+dAjeQGjNOV61Z6dzlDTq3u5tefFHkiefFtFEF7kwUvUPXS8vSclZgGlCc
	EWTLOOYM6QZIG1/gu+0cWJPI4TSFBc5vEE0DewoLskFKbIv/aja7WN3erIkLt1nWh3hjvFLAYDKl7
	/Wr6+LDES7c2a7LBPbAi4xta1bixYPehQxTECF7YzbvhSgGUpHMccugyRpjVRq66dXLCo6yDe4/Tn
	vuAW3RFHOhtzBZpgzx9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gb6UL-0006Ci-EA; Sun, 23 Dec 2018 16:20:25 +0000
Received: from mail-eopbgr150048.outbound.protection.outlook.com
 ([40.107.15.48] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gb6UE-0005Ra-Gt
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 16:20:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6V6xfuKFNs130Nl3OzWGfNBrQNPlZADyBq777dot4FI=;
 b=nn7fGd7wXdx5tgGeB4E/5qcYDZoiA2Wkc5h9fV/KInzHH23gnEzkUN4+lR8i3CJ7JrCzsS126PYfHZQZRCyMQlj6YJMKq7avrCcWj1v/8p+Dcu0s1AlpgPJUj+wGTFxbzQrpi9J1PYpXBbyL/oMqQ1BsF3mmknH5XX+fq1ow0iQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5380.eurprd04.prod.outlook.com (20.178.115.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Sun, 23 Dec 2018 16:20:03 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%7]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 16:20:03 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V2 1/1] clk: imx8qxp: make the name of clock ID generic
Thread-Topic: [PATCH V2 1/1] clk: imx8qxp: make the name of clock ID generic
Thread-Index: AQHUmttb81cIWccNrEmB4MDcKOs9uA==
Date: Sun, 23 Dec 2018 16:20:02 +0000
Message-ID: <1545581665-15446-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::29) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5380;
 6:a3HuEwHhgagfCl/e1VCEL1WaJbgyrfSq9jH/XdeZ+n0nVwhZDUI113ZWracSFKA9VdzIRYrUKekEw94RQ/4AWNR3b6RuO++SctIpP+XfgoD5le6oCK0FU9PAdZEuGMq9AtkE/UrD+A0Mcl9R2MwFREfdR2WFkI3YpQ+F8394uaXnRCkssEIaA12u6iO0Rs5N/qUvBVvFM/Tjpsl8miGUl0bxWdcujCjuWDX0LND1U2LxziKK6ts6QsV3kuoXBSlAFFEx6YZBkf+EmDxvFTxSjOwvsVYCc5sAUXhpzs3ArBhwR/hEXUaGHGnPTCzmOogTKzf3r7IPUM1G5Oot/AjtenYqaN0X1NFwsJVuSLtpVJoTrwlaoctx8DRnKaGEV3fj8jP4z3c/aix11L1A/eKLiKYyp5mDCqCvdMw5u4oJtcxu1cDvTFX5zoGcizE6YyVae9og0QkhlSWizvxQFj4+7A==;
 5:+AH2DhSng4D23fEiedXbT+D7s0K0rTJdJwgbsWN2DjtzAUtJ+Kx/4yGx45iSdEefbCAP2CvjLKnMksbIcw8zjVBV8IlVBBAlHOkM933kmqST/L/icYKt5IX3Cb+lOccxl1MiSZPrKG0ZDefSGmF7Lc+XcqUkLCNHF5gfvXuca0I=;
 7:Nbp8mo6sc0dbLL9MLAIkk+GI1o720HIIPsV6t9ZbeyHUPPkqhWdYMc/1eKtVX2PTUiuqQmEn970S8A2wcR3r5YFLCOV8aftwzO/Pl+EKtMEb3on1H/XLbDD7haIEOlDGmoLntxZUwiXcvpgiNmbMcg==
x-ms-office365-filtering-correlation-id: 4f31bc45-d119-4016-eac9-08d668f27dfd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5380; 
x-ms-traffictypediagnostic: AM0PR04MB5380:
x-microsoft-antispam-prvs: <AM0PR04MB538080C50ED81E91DAE2468680BA0@AM0PR04MB5380.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5380; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5380; 
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(376002)(136003)(396003)(346002)(189003)(199004)(105586002)(68736007)(26005)(6512007)(186003)(2616005)(486006)(6306002)(106356001)(6916009)(386003)(6506007)(2501003)(66066001)(316002)(476003)(5660300001)(2351001)(4326008)(52116002)(3846002)(102836004)(14454004)(44832011)(6116002)(305945005)(86362001)(97736004)(54906003)(478600001)(99286004)(8936002)(2906002)(50226002)(25786009)(6436002)(8676002)(5640700003)(81166006)(53936002)(81156014)(71200400001)(6486002)(71190400001)(7736002)(4744004)(966005)(53946003)(256004)(36756003)(14444005)(41533002)(32563001)(569006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5380;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NlmU9VSrJoZMV3YgxfH/Q+xGZ9S38PgSagxacV4dfGtKD/MOdR8g6PFc6TLNDLo2+OGpxC8r4rSORHkzubnuGIwkNVi4v+Bu1ys5aVnpkBgackjGULhVd6XHY2Vr1z0Tum8LTlkiMaTQK++yTyvjLu4ICtqvgQhqfuZmPRQuwwA7Z5w7+VzyZ5/kPfrpJXUulkrddIOBOD2zUqP8qK8MOkQZmyJLYhv2s8QoI+J0cN7rkkDkWJab3a0lZ7vt9atAE+8b8dsYr3eHkxUaX3WlX9vjNeVeA+vlR48rAWvlMtw+bA6VQ5Q2NwLcOdHop5Cw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f31bc45-d119-4016-eac9-08d668f27dfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 16:20:02.9624 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5380
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_082018_846064_D2F57CB0 
X-CRM114-Status: GOOD (  15.72  )
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
 Rob Herring <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SCU clock can be used in a similar way by IMX8QXP and IMX8QM SoCs.
Let's make the name of clock ID generic to allow other SoCs to reuse
the common part.

This patch only changes the clock id name and file name, so no
functional change.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
According to Stephen's suggestion[1], resend the needed changes
for 4.21 separately, then we can pick it up and send it as part
of a follow-on fixes PR during the merge window next week.
As there's still no users in kernel and the plan is also to avoid
any using of it, so please help review at an early time.
v1->v2:
 * resend Patch [4/5] which needs to change for v4.21.
 * update headfile name accordingly
[1] https://patchwork.kernel.org/patch/10737463/
---
 drivers/clk/imx/clk-imx8qxp-lpcg.c        | 148 +++++++--------
 drivers/clk/imx/clk-imx8qxp.c             | 154 ++++++++--------
 include/dt-bindings/clock/imx8-clock.h    | 289 ++++++++++++++++++++++++++++++
 include/dt-bindings/clock/imx8qxp-clock.h | 289 ------------------------------
 4 files changed, 440 insertions(+), 440 deletions(-)
 create mode 100644 include/dt-bindings/clock/imx8-clock.h
 delete mode 100644 include/dt-bindings/clock/imx8qxp-clock.h

diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
index dcae1dd..99c2508 100644
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
@@ -16,7 +16,7 @@
 #include "clk-scu.h"
 #include "clk-imx8qxp-lpcg.h"
 
-#include <dt-bindings/clock/imx8qxp-clock.h>
+#include <dt-bindings/clock/imx8-clock.h>
 
 /*
  * struct imx8qxp_lpcg_data - Description of one LPCG clock
@@ -56,100 +56,100 @@ struct imx8qxp_ss_lpcg {
 };
 
 static const struct imx8qxp_lpcg_data imx8qxp_lpcg_adma[] = {
-	{ IMX8QXP_ADMA_LPCG_UART0_IPG_CLK, "uart0_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPUART_0_LPCG, 16, 0, },
-	{ IMX8QXP_ADMA_LPCG_UART0_BAUD_CLK, "uart0_lpcg_baud_clk", "uart0_clk", 0, ADMA_LPUART_0_LPCG, 0, 0, },
-	{ IMX8QXP_ADMA_LPCG_UART1_IPG_CLK, "uart1_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPUART_1_LPCG, 16, 0, },
-	{ IMX8QXP_ADMA_LPCG_UART1_BAUD_CLK, "uart1_lpcg_baud_clk", "uart1_clk", 0, ADMA_LPUART_1_LPCG, 0, 0, },
-	{ IMX8QXP_ADMA_LPCG_UART2_IPG_CLK, "uart2_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPUART_2_LPCG, 16, 0, },
-	{ IMX8QXP_ADMA_LPCG_UART2_BAUD_CLK, "uart2_lpcg_baud_clk", "uart2_clk", 0, ADMA_LPUART_2_LPCG, 0, 0, },
-	{ IMX8QXP_ADMA_LPCG_UART3_IPG_CLK, "uart3_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPUART_3_LPCG, 16, 0, },
-	{ IMX8QXP_ADMA_LPCG_UART3_BAUD_CLK, "uart3_lpcg_baud_clk", "uart3_clk", 0, ADMA_LPUART_3_LPCG, 0, 0, },
-	{ IMX8QXP_ADMA_LPCG_I2C0_IPG_CLK, "i2c0_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPI2C_0_LPCG, 16, 0, },
-	{ IMX8QXP_ADMA_LPCG_I2C0_CLK, "i2c0_lpcg_clk", "i2c0_clk", 0, ADMA_LPI2C_0_LPCG, 0, 0, },
-	{ IMX8QXP_ADMA_LPCG_I2C1_IPG_CLK, "i2c1_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPI2C_1_LPCG, 16, 0, },
-	{ IMX8QXP_ADMA_LPCG_I2C1_CLK, "i2c1_lpcg_clk", "i2c1_clk", 0, ADMA_LPI2C_1_LPCG, 0, 0, },
-	{ IMX8QXP_ADMA_LPCG_I2C2_IPG_CLK, "i2c2_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPI2C_2_LPCG, 16, 0, },
-	{ IMX8QXP_ADMA_LPCG_I2C2_CLK, "i2c2_lpcg_clk", "i2c2_clk", 0, ADMA_LPI2C_2_LPCG, 0, 0, },
-	{ IMX8QXP_ADMA_LPCG_I2C3_IPG_CLK, "i2c3_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPI2C_3_LPCG, 16, 0, },
-	{ IMX8QXP_ADMA_LPCG_I2C3_CLK, "i2c3_lpcg_clk", "i2c3_clk", 0, ADMA_LPI2C_3_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_UART0_IPG_CLK, "uart0_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPUART_0_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_UART0_BAUD_CLK, "uart0_lpcg_baud_clk", "uart0_clk", 0, ADMA_LPUART_0_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_UART1_IPG_CLK, "uart1_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPUART_1_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_UART1_BAUD_CLK, "uart1_lpcg_baud_clk", "uart1_clk", 0, ADMA_LPUART_1_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_UART2_IPG_CLK, "uart2_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPUART_2_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_UART2_BAUD_CLK, "uart2_lpcg_baud_clk", "uart2_clk", 0, ADMA_LPUART_2_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_UART3_IPG_CLK, "uart3_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPUART_3_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_UART3_BAUD_CLK, "uart3_lpcg_baud_clk", "uart3_clk", 0, ADMA_LPUART_3_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_I2C0_IPG_CLK, "i2c0_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPI2C_0_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_I2C0_CLK, "i2c0_lpcg_clk", "i2c0_clk", 0, ADMA_LPI2C_0_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_I2C1_IPG_CLK, "i2c1_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPI2C_1_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_I2C1_CLK, "i2c1_lpcg_clk", "i2c1_clk", 0, ADMA_LPI2C_1_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_I2C2_IPG_CLK, "i2c2_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPI2C_2_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_I2C2_CLK, "i2c2_lpcg_clk", "i2c2_clk", 0, ADMA_LPI2C_2_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_I2C3_IPG_CLK, "i2c3_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPI2C_3_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_I2C3_CLK, "i2c3_lpcg_clk", "i2c3_clk", 0, ADMA_LPI2C_3_LPCG, 0, 0, },
 };
 
 static const struct imx8qxp_ss_lpcg imx8qxp_ss_adma = {
 	.lpcg = imx8qxp_lpcg_adma,
 	.num_lpcg = ARRAY_SIZE(imx8qxp_lpcg_adma),
-	.num_max = IMX8QXP_ADMA_LPCG_CLK_END,
+	.num_max = IMX_ADMA_LPCG_CLK_END,
 };
 
 static const struct imx8qxp_lpcg_data imx8qxp_lpcg_conn[] = {
-	{ IMX8QXP_CONN_LPCG_SDHC0_PER_CLK, "sdhc0_lpcg_per_clk", "sdhc0_clk", 0, CONN_USDHC_0_LPCG, 0, 0, },
-	{ IMX8QXP_CONN_LPCG_SDHC0_IPG_CLK, "sdhc0_lpcg_ipg_clk", "conn_ipg_clk_root", 0, CONN_USDHC_0_LPCG, 16, 0, },
-	{ IMX8QXP_CONN_LPCG_SDHC0_HCLK, "sdhc0_lpcg_ahb_clk", "conn_axi_clk_root", 0, CONN_USDHC_0_LPCG, 20, 0, },
-	{ IMX8QXP_CONN_LPCG_SDHC1_PER_CLK, "sdhc1_lpcg_per_clk", "sdhc1_clk", 0, CONN_USDHC_1_LPCG, 0, 0, },
-	{ IMX8QXP_CONN_LPCG_SDHC1_IPG_CLK, "sdhc1_lpcg_ipg_clk", "conn_ipg_clk_root", 0, CONN_USDHC_1_LPCG, 16, 0, },
-	{ IMX8QXP_CONN_LPCG_SDHC1_HCLK, "sdhc1_lpcg_ahb_clk", "conn_axi_clk_root", 0, CONN_USDHC_1_LPCG, 20, 0, },
-	{ IMX8QXP_CONN_LPCG_SDHC2_PER_CLK, "sdhc2_lpcg_per_clk", "sdhc2_clk", 0, CONN_USDHC_2_LPCG, 0, 0, },
-	{ IMX8QXP_CONN_LPCG_SDHC2_IPG_CLK, "sdhc2_lpcg_ipg_clk", "conn_ipg_clk_root", 0, CONN_USDHC_2_LPCG, 16, 0, },
-	{ IMX8QXP_CONN_LPCG_SDHC2_HCLK, "sdhc2_lpcg_ahb_clk", "conn_axi_clk_root", 0, CONN_USDHC_2_LPCG, 20, 0, },
-	{ IMX8QXP_CONN_LPCG_ENET0_ROOT_CLK, "enet0_ipg_root_clk", "enet0_clk", 0, CONN_ENET_0_LPCG, 0, 0, },
-	{ IMX8QXP_CONN_LPCG_ENET0_TX_CLK, "enet0_tx_clk", "enet0_clk", 0, CONN_ENET_0_LPCG, 4, 0, },
-	{ IMX8QXP_CONN_LPCG_ENET0_AHB_CLK, "enet0_ahb_clk", "conn_axi_clk_root", 0, CONN_ENET_0_LPCG, 8, 0, },
-	{ IMX8QXP_CONN_LPCG_ENET0_IPG_S_CLK, "enet0_ipg_s_clk", "conn_ipg_clk_root", 0, CONN_ENET_0_LPCG, 20, 0, },
-	{ IMX8QXP_CONN_LPCG_ENET0_IPG_CLK, "enet0_ipg_clk", "enet0_ipg_s_clk", 0, CONN_ENET_0_LPCG, 16, 0, },
-	{ IMX8QXP_CONN_LPCG_ENET1_ROOT_CLK, "enet1_ipg_root_clk", "enet1_clk", 0, CONN_ENET_1_LPCG, 0, 0, },
-	{ IMX8QXP_CONN_LPCG_ENET1_TX_CLK, "enet1_tx_clk", "enet1_clk", 0, CONN_ENET_1_LPCG, 4, 0, },
-	{ IMX8QXP_CONN_LPCG_ENET1_AHB_CLK, "enet1_ahb_clk", "conn_axi_clk_root", 0, CONN_ENET_1_LPCG, 8, 0, },
-	{ IMX8QXP_CONN_LPCG_ENET1_IPG_S_CLK, "enet1_ipg_s_clk", "conn_ipg_clk_root", 0, CONN_ENET_1_LPCG, 20, 0, },
-	{ IMX8QXP_CONN_LPCG_ENET1_IPG_CLK, "enet1_ipg_clk", "enet0_ipg_s_clk", 0, CONN_ENET_1_LPCG, 16, 0, },
+	{ IMX_CONN_LPCG_SDHC0_PER_CLK, "sdhc0_lpcg_per_clk", "sdhc0_clk", 0, CONN_USDHC_0_LPCG, 0, 0, },
+	{ IMX_CONN_LPCG_SDHC0_IPG_CLK, "sdhc0_lpcg_ipg_clk", "conn_ipg_clk_root", 0, CONN_USDHC_0_LPCG, 16, 0, },
+	{ IMX_CONN_LPCG_SDHC0_HCLK, "sdhc0_lpcg_ahb_clk", "conn_axi_clk_root", 0, CONN_USDHC_0_LPCG, 20, 0, },
+	{ IMX_CONN_LPCG_SDHC1_PER_CLK, "sdhc1_lpcg_per_clk", "sdhc1_clk", 0, CONN_USDHC_1_LPCG, 0, 0, },
+	{ IMX_CONN_LPCG_SDHC1_IPG_CLK, "sdhc1_lpcg_ipg_clk", "conn_ipg_clk_root", 0, CONN_USDHC_1_LPCG, 16, 0, },
+	{ IMX_CONN_LPCG_SDHC1_HCLK, "sdhc1_lpcg_ahb_clk", "conn_axi_clk_root", 0, CONN_USDHC_1_LPCG, 20, 0, },
+	{ IMX_CONN_LPCG_SDHC2_PER_CLK, "sdhc2_lpcg_per_clk", "sdhc2_clk", 0, CONN_USDHC_2_LPCG, 0, 0, },
+	{ IMX_CONN_LPCG_SDHC2_IPG_CLK, "sdhc2_lpcg_ipg_clk", "conn_ipg_clk_root", 0, CONN_USDHC_2_LPCG, 16, 0, },
+	{ IMX_CONN_LPCG_SDHC2_HCLK, "sdhc2_lpcg_ahb_clk", "conn_axi_clk_root", 0, CONN_USDHC_2_LPCG, 20, 0, },
+	{ IMX_CONN_LPCG_ENET0_ROOT_CLK, "enet0_ipg_root_clk", "enet0_clk", 0, CONN_ENET_0_LPCG, 0, 0, },
+	{ IMX_CONN_LPCG_ENET0_TX_CLK, "enet0_tx_clk", "enet0_clk", 0, CONN_ENET_0_LPCG, 4, 0, },
+	{ IMX_CONN_LPCG_ENET0_AHB_CLK, "enet0_ahb_clk", "conn_axi_clk_root", 0, CONN_ENET_0_LPCG, 8, 0, },
+	{ IMX_CONN_LPCG_ENET0_IPG_S_CLK, "enet0_ipg_s_clk", "conn_ipg_clk_root", 0, CONN_ENET_0_LPCG, 20, 0, },
+	{ IMX_CONN_LPCG_ENET0_IPG_CLK, "enet0_ipg_clk", "enet0_ipg_s_clk", 0, CONN_ENET_0_LPCG, 16, 0, },
+	{ IMX_CONN_LPCG_ENET1_ROOT_CLK, "enet1_ipg_root_clk", "enet1_clk", 0, CONN_ENET_1_LPCG, 0, 0, },
+	{ IMX_CONN_LPCG_ENET1_TX_CLK, "enet1_tx_clk", "enet1_clk", 0, CONN_ENET_1_LPCG, 4, 0, },
+	{ IMX_CONN_LPCG_ENET1_AHB_CLK, "enet1_ahb_clk", "conn_axi_clk_root", 0, CONN_ENET_1_LPCG, 8, 0, },
+	{ IMX_CONN_LPCG_ENET1_IPG_S_CLK, "enet1_ipg_s_clk", "conn_ipg_clk_root", 0, CONN_ENET_1_LPCG, 20, 0, },
+	{ IMX_CONN_LPCG_ENET1_IPG_CLK, "enet1_ipg_clk", "enet0_ipg_s_clk", 0, CONN_ENET_1_LPCG, 16, 0, },
 };
 
 static const struct imx8qxp_ss_lpcg imx8qxp_ss_conn = {
 	.lpcg = imx8qxp_lpcg_conn,
 	.num_lpcg = ARRAY_SIZE(imx8qxp_lpcg_conn),
-	.num_max = IMX8QXP_CONN_LPCG_CLK_END,
+	.num_max = IMX_CONN_LPCG_CLK_END,
 };
 
 static const struct imx8qxp_lpcg_data imx8qxp_lpcg_lsio[] = {
-	{ IMX8QXP_LSIO_LPCG_PWM0_IPG_CLK, "pwm0_lpcg_ipg_clk", "pwm0_clk", 0, LSIO_PWM_0_LPCG, 0, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM0_IPG_HF_CLK, "pwm0_lpcg_ipg_hf_clk", "pwm0_clk", 0, LSIO_PWM_0_LPCG, 4, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM0_IPG_S_CLK, "pwm0_lpcg_ipg_s_clk", "pwm0_clk", 0, LSIO_PWM_0_LPCG, 16, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM0_IPG_SLV_CLK, "pwm0_lpcg_ipg_slv_clk", "lsio_bus_clk_root", 0, LSIO_PWM_0_LPCG, 20, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM0_IPG_MSTR_CLK, "pwm0_lpcg_ipg_mstr_clk", "pwm0_clk", 0, LSIO_PWM_0_LPCG, 24, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM1_IPG_CLK, "pwm1_lpcg_ipg_clk", "pwm1_clk", 0, LSIO_PWM_1_LPCG, 0, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM1_IPG_HF_CLK, "pwm1_lpcg_ipg_hf_clk", "pwm1_clk", 0, LSIO_PWM_1_LPCG, 4, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM1_IPG_S_CLK, "pwm1_lpcg_ipg_s_clk", "pwm1_clk", 0, LSIO_PWM_1_LPCG, 16, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM1_IPG_SLV_CLK, "pwm1_lpcg_ipg_slv_clk", "lsio_bus_clk_root", 0, LSIO_PWM_1_LPCG, 20, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM1_IPG_MSTR_CLK, "pwm1_lpcg_ipg_mstr_clk", "pwm1_clk", 0, LSIO_PWM_1_LPCG, 24, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM2_IPG_CLK, "pwm2_lpcg_ipg_clk", "pwm2_clk", 0, LSIO_PWM_2_LPCG, 0, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM2_IPG_HF_CLK, "pwm2_lpcg_ipg_hf_clk", "pwm2_clk", 0, LSIO_PWM_2_LPCG, 4, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM2_IPG_S_CLK, "pwm2_lpcg_ipg_s_clk", "pwm2_clk", 0, LSIO_PWM_2_LPCG, 16, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM2_IPG_SLV_CLK, "pwm2_lpcg_ipg_slv_clk", "lsio_bus_clk_root", 0, LSIO_PWM_2_LPCG, 20, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM2_IPG_MSTR_CLK, "pwm2_lpcg_ipg_mstr_clk", "pwm2_clk", 0, LSIO_PWM_2_LPCG, 24, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM3_IPG_CLK, "pwm3_lpcg_ipg_clk", "pwm3_clk", 0, LSIO_PWM_3_LPCG, 0, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM3_IPG_HF_CLK, "pwm3_lpcg_ipg_hf_clk", "pwm3_clk", 0, LSIO_PWM_3_LPCG, 4, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM3_IPG_S_CLK, "pwm3_lpcg_ipg_s_clk", "pwm3_clk", 0, LSIO_PWM_3_LPCG, 16, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM3_IPG_SLV_CLK, "pwm3_lpcg_ipg_slv_clk", "lsio_bus_clk_root", 0, LSIO_PWM_3_LPCG, 20, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM3_IPG_MSTR_CLK, "pwm3_lpcg_ipg_mstr_clk", "pwm3_clk", 0, LSIO_PWM_3_LPCG, 24, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM4_IPG_CLK, "pwm4_lpcg_ipg_clk", "pwm4_clk", 0, LSIO_PWM_4_LPCG, 0, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM4_IPG_HF_CLK, "pwm4_lpcg_ipg_hf_clk", "pwm4_clk", 0, LSIO_PWM_4_LPCG, 4, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM4_IPG_S_CLK, "pwm4_lpcg_ipg_s_clk", "pwm4_clk", 0, LSIO_PWM_4_LPCG, 16, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM4_IPG_SLV_CLK, "pwm4_lpcg_ipg_slv_clk", "lsio_bus_clk_root", 0, LSIO_PWM_4_LPCG, 20, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM4_IPG_MSTR_CLK, "pwm4_lpcg_ipg_mstr_clk", "pwm4_clk", 0, LSIO_PWM_4_LPCG, 24, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM5_IPG_CLK, "pwm5_lpcg_ipg_clk", "pwm5_clk", 0, LSIO_PWM_5_LPCG, 0, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM5_IPG_HF_CLK, "pwm5_lpcg_ipg_hf_clk", "pwm5_clk", 0, LSIO_PWM_5_LPCG, 4, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM5_IPG_S_CLK, "pwm5_lpcg_ipg_s_clk", "pwm5_clk", 0, LSIO_PWM_5_LPCG, 16, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM5_IPG_SLV_CLK, "pwm5_lpcg_ipg_slv_clk", "lsio_bus_clk_root", 0, LSIO_PWM_5_LPCG, 20, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM5_IPG_MSTR_CLK, "pwm5_lpcg_ipg_mstr_clk", "pwm5_clk", 0, LSIO_PWM_5_LPCG, 24, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM6_IPG_CLK, "pwm6_lpcg_ipg_clk", "pwm6_clk", 0, LSIO_PWM_6_LPCG, 0, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM6_IPG_HF_CLK, "pwm6_lpcg_ipg_hf_clk", "pwm6_clk", 0, LSIO_PWM_6_LPCG, 4, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM6_IPG_S_CLK, "pwm6_lpcg_ipg_s_clk", "pwm6_clk", 0, LSIO_PWM_6_LPCG, 16, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM6_IPG_SLV_CLK, "pwm6_lpcg_ipg_slv_clk", "lsio_bus_clk_root", 0, LSIO_PWM_6_LPCG, 20, 0, },
-	{ IMX8QXP_LSIO_LPCG_PWM6_IPG_MSTR_CLK, "pwm6_lpcg_ipg_mstr_clk", "pwm6_clk", 0, LSIO_PWM_6_LPCG, 24, 0, },
+	{ IMX_LSIO_LPCG_PWM0_IPG_CLK, "pwm0_lpcg_ipg_clk", "pwm0_clk", 0, LSIO_PWM_0_LPCG, 0, 0, },
+	{ IMX_LSIO_LPCG_PWM0_IPG_HF_CLK, "pwm0_lpcg_ipg_hf_clk", "pwm0_clk", 0, LSIO_PWM_0_LPCG, 4, 0, },
+	{ IMX_LSIO_LPCG_PWM0_IPG_S_CLK, "pwm0_lpcg_ipg_s_clk", "pwm0_clk", 0, LSIO_PWM_0_LPCG, 16, 0, },
+	{ IMX_LSIO_LPCG_PWM0_IPG_SLV_CLK, "pwm0_lpcg_ipg_slv_clk", "lsio_bus_clk_root", 0, LSIO_PWM_0_LPCG, 20, 0, },
+	{ IMX_LSIO_LPCG_PWM0_IPG_MSTR_CLK, "pwm0_lpcg_ipg_mstr_clk", "pwm0_clk", 0, LSIO_PWM_0_LPCG, 24, 0, },
+	{ IMX_LSIO_LPCG_PWM1_IPG_CLK, "pwm1_lpcg_ipg_clk", "pwm1_clk", 0, LSIO_PWM_1_LPCG, 0, 0, },
+	{ IMX_LSIO_LPCG_PWM1_IPG_HF_CLK, "pwm1_lpcg_ipg_hf_clk", "pwm1_clk", 0, LSIO_PWM_1_LPCG, 4, 0, },
+	{ IMX_LSIO_LPCG_PWM1_IPG_S_CLK, "pwm1_lpcg_ipg_s_clk", "pwm1_clk", 0, LSIO_PWM_1_LPCG, 16, 0, },
+	{ IMX_LSIO_LPCG_PWM1_IPG_SLV_CLK, "pwm1_lpcg_ipg_slv_clk", "lsio_bus_clk_root", 0, LSIO_PWM_1_LPCG, 20, 0, },
+	{ IMX_LSIO_LPCG_PWM1_IPG_MSTR_CLK, "pwm1_lpcg_ipg_mstr_clk", "pwm1_clk", 0, LSIO_PWM_1_LPCG, 24, 0, },
+	{ IMX_LSIO_LPCG_PWM2_IPG_CLK, "pwm2_lpcg_ipg_clk", "pwm2_clk", 0, LSIO_PWM_2_LPCG, 0, 0, },
+	{ IMX_LSIO_LPCG_PWM2_IPG_HF_CLK, "pwm2_lpcg_ipg_hf_clk", "pwm2_clk", 0, LSIO_PWM_2_LPCG, 4, 0, },
+	{ IMX_LSIO_LPCG_PWM2_IPG_S_CLK, "pwm2_lpcg_ipg_s_clk", "pwm2_clk", 0, LSIO_PWM_2_LPCG, 16, 0, },
+	{ IMX_LSIO_LPCG_PWM2_IPG_SLV_CLK, "pwm2_lpcg_ipg_slv_clk", "lsio_bus_clk_root", 0, LSIO_PWM_2_LPCG, 20, 0, },
+	{ IMX_LSIO_LPCG_PWM2_IPG_MSTR_CLK, "pwm2_lpcg_ipg_mstr_clk", "pwm2_clk", 0, LSIO_PWM_2_LPCG, 24, 0, },
+	{ IMX_LSIO_LPCG_PWM3_IPG_CLK, "pwm3_lpcg_ipg_clk", "pwm3_clk", 0, LSIO_PWM_3_LPCG, 0, 0, },
+	{ IMX_LSIO_LPCG_PWM3_IPG_HF_CLK, "pwm3_lpcg_ipg_hf_clk", "pwm3_clk", 0, LSIO_PWM_3_LPCG, 4, 0, },
+	{ IMX_LSIO_LPCG_PWM3_IPG_S_CLK, "pwm3_lpcg_ipg_s_clk", "pwm3_clk", 0, LSIO_PWM_3_LPCG, 16, 0, },
+	{ IMX_LSIO_LPCG_PWM3_IPG_SLV_CLK, "pwm3_lpcg_ipg_slv_clk", "lsio_bus_clk_root", 0, LSIO_PWM_3_LPCG, 20, 0, },
+	{ IMX_LSIO_LPCG_PWM3_IPG_MSTR_CLK, "pwm3_lpcg_ipg_mstr_clk", "pwm3_clk", 0, LSIO_PWM_3_LPCG, 24, 0, },
+	{ IMX_LSIO_LPCG_PWM4_IPG_CLK, "pwm4_lpcg_ipg_clk", "pwm4_clk", 0, LSIO_PWM_4_LPCG, 0, 0, },
+	{ IMX_LSIO_LPCG_PWM4_IPG_HF_CLK, "pwm4_lpcg_ipg_hf_clk", "pwm4_clk", 0, LSIO_PWM_4_LPCG, 4, 0, },
+	{ IMX_LSIO_LPCG_PWM4_IPG_S_CLK, "pwm4_lpcg_ipg_s_clk", "pwm4_clk", 0, LSIO_PWM_4_LPCG, 16, 0, },
+	{ IMX_LSIO_LPCG_PWM4_IPG_SLV_CLK, "pwm4_lpcg_ipg_slv_clk", "lsio_bus_clk_root", 0, LSIO_PWM_4_LPCG, 20, 0, },
+	{ IMX_LSIO_LPCG_PWM4_IPG_MSTR_CLK, "pwm4_lpcg_ipg_mstr_clk", "pwm4_clk", 0, LSIO_PWM_4_LPCG, 24, 0, },
+	{ IMX_LSIO_LPCG_PWM5_IPG_CLK, "pwm5_lpcg_ipg_clk", "pwm5_clk", 0, LSIO_PWM_5_LPCG, 0, 0, },
+	{ IMX_LSIO_LPCG_PWM5_IPG_HF_CLK, "pwm5_lpcg_ipg_hf_clk", "pwm5_clk", 0, LSIO_PWM_5_LPCG, 4, 0, },
+	{ IMX_LSIO_LPCG_PWM5_IPG_S_CLK, "pwm5_lpcg_ipg_s_clk", "pwm5_clk", 0, LSIO_PWM_5_LPCG, 16, 0, },
+	{ IMX_LSIO_LPCG_PWM5_IPG_SLV_CLK, "pwm5_lpcg_ipg_slv_clk", "lsio_bus_clk_root", 0, LSIO_PWM_5_LPCG, 20, 0, },
+	{ IMX_LSIO_LPCG_PWM5_IPG_MSTR_CLK, "pwm5_lpcg_ipg_mstr_clk", "pwm5_clk", 0, LSIO_PWM_5_LPCG, 24, 0, },
+	{ IMX_LSIO_LPCG_PWM6_IPG_CLK, "pwm6_lpcg_ipg_clk", "pwm6_clk", 0, LSIO_PWM_6_LPCG, 0, 0, },
+	{ IMX_LSIO_LPCG_PWM6_IPG_HF_CLK, "pwm6_lpcg_ipg_hf_clk", "pwm6_clk", 0, LSIO_PWM_6_LPCG, 4, 0, },
+	{ IMX_LSIO_LPCG_PWM6_IPG_S_CLK, "pwm6_lpcg_ipg_s_clk", "pwm6_clk", 0, LSIO_PWM_6_LPCG, 16, 0, },
+	{ IMX_LSIO_LPCG_PWM6_IPG_SLV_CLK, "pwm6_lpcg_ipg_slv_clk", "lsio_bus_clk_root", 0, LSIO_PWM_6_LPCG, 20, 0, },
+	{ IMX_LSIO_LPCG_PWM6_IPG_MSTR_CLK, "pwm6_lpcg_ipg_mstr_clk", "pwm6_clk", 0, LSIO_PWM_6_LPCG, 24, 0, },
 };
 
 static const struct imx8qxp_ss_lpcg imx8qxp_ss_lsio = {
 	.lpcg = imx8qxp_lpcg_lsio,
 	.num_lpcg = ARRAY_SIZE(imx8qxp_lpcg_lsio),
-	.num_max = IMX8QXP_LSIO_LPCG_CLK_END,
+	.num_max = IMX_LSIO_LPCG_CLK_END,
 };
 
 static int imx8qxp_lpcg_clk_probe(struct platform_device *pdev)
diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 33c9396..83e2ef9 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -14,7 +14,7 @@
 
 #include "clk-scu.h"
 
-#include <dt-bindings/clock/imx8qxp-clock.h>
+#include <dt-bindings/clock/imx8-clock.h>
 #include <dt-bindings/firmware/imx/rsrc.h>
 
 static int imx8qxp_clk_probe(struct platform_device *pdev)
@@ -29,104 +29,104 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 		return ret;
 
 	clk_data = devm_kzalloc(&pdev->dev, struct_size(clk_data, hws,
-				IMX8QXP_SCU_CLK_END), GFP_KERNEL);
+				IMX_SCU_CLK_END), GFP_KERNEL);
 	if (!clk_data)
 		return -ENOMEM;
 
-	clk_data->num = IMX8QXP_SCU_CLK_END;
+	clk_data->num = IMX_SCU_CLK_END;
 	clks = clk_data->hws;
 
 	/* Fixed clocks */
-	clks[IMX8QXP_CLK_DUMMY]			= clk_hw_register_fixed_rate(NULL, "dummy", NULL, 0, 0);
-	clks[IMX8QXP_ADMA_IPG_CLK_ROOT] 	= clk_hw_register_fixed_rate(NULL, "dma_ipg_clk_root", NULL, 0, 120000000);
-	clks[IMX8QXP_CONN_AXI_CLK_ROOT]		= clk_hw_register_fixed_rate(NULL, "conn_axi_clk_root", NULL, 0, 333333333);
-	clks[IMX8QXP_CONN_AHB_CLK_ROOT]		= clk_hw_register_fixed_rate(NULL, "conn_ahb_clk_root", NULL, 0, 166666666);
-	clks[IMX8QXP_CONN_IPG_CLK_ROOT]		= clk_hw_register_fixed_rate(NULL, "conn_ipg_clk_root", NULL, 0, 83333333);
-	clks[IMX8QXP_DC_AXI_EXT_CLK]		= clk_hw_register_fixed_rate(NULL, "dc_axi_ext_clk_root", NULL, 0, 800000000);
-	clks[IMX8QXP_DC_AXI_INT_CLK]		= clk_hw_register_fixed_rate(NULL, "dc_axi_int_clk_root", NULL, 0, 400000000);
-	clks[IMX8QXP_DC_CFG_CLK]		= clk_hw_register_fixed_rate(NULL, "dc_cfg_clk_root", NULL, 0, 100000000);
-	clks[IMX8QXP_MIPI_IPG_CLK]		= clk_hw_register_fixed_rate(NULL, "mipi_ipg_clk_root", NULL, 0, 120000000);
-	clks[IMX8QXP_IMG_AXI_CLK]		= clk_hw_register_fixed_rate(NULL, "img_axi_clk_root", NULL, 0, 400000000);
-	clks[IMX8QXP_IMG_IPG_CLK]		= clk_hw_register_fixed_rate(NULL, "img_ipg_clk_root", NULL, 0, 200000000);
-	clks[IMX8QXP_IMG_PXL_CLK]		= clk_hw_register_fixed_rate(NULL, "img_pxl_clk_root", NULL, 0, 600000000);
-	clks[IMX8QXP_HSIO_AXI_CLK]		= clk_hw_register_fixed_rate(NULL, "hsio_axi_clk_root", NULL, 0, 400000000);
-	clks[IMX8QXP_HSIO_PER_CLK]		= clk_hw_register_fixed_rate(NULL, "hsio_per_clk_root", NULL, 0, 133333333);
-	clks[IMX8QXP_LSIO_MEM_CLK]		= clk_hw_register_fixed_rate(NULL, "lsio_mem_clk_root", NULL, 0, 200000000);
-	clks[IMX8QXP_LSIO_BUS_CLK]		= clk_hw_register_fixed_rate(NULL, "lsio_bus_clk_root", NULL, 0, 100000000);
+	clks[IMX_CLK_DUMMY]		= clk_hw_register_fixed_rate(NULL, "dummy", NULL, 0, 0);
+	clks[IMX_ADMA_IPG_CLK_ROOT] 	= clk_hw_register_fixed_rate(NULL, "dma_ipg_clk_root", NULL, 0, 120000000);
+	clks[IMX_CONN_AXI_CLK_ROOT]	= clk_hw_register_fixed_rate(NULL, "conn_axi_clk_root", NULL, 0, 333333333);
+	clks[IMX_CONN_AHB_CLK_ROOT]	= clk_hw_register_fixed_rate(NULL, "conn_ahb_clk_root", NULL, 0, 166666666);
+	clks[IMX_CONN_IPG_CLK_ROOT]	= clk_hw_register_fixed_rate(NULL, "conn_ipg_clk_root", NULL, 0, 83333333);
+	clks[IMX_DC_AXI_EXT_CLK]	= clk_hw_register_fixed_rate(NULL, "dc_axi_ext_clk_root", NULL, 0, 800000000);
+	clks[IMX_DC_AXI_INT_CLK]	= clk_hw_register_fixed_rate(NULL, "dc_axi_int_clk_root", NULL, 0, 400000000);
+	clks[IMX_DC_CFG_CLK]		= clk_hw_register_fixed_rate(NULL, "dc_cfg_clk_root", NULL, 0, 100000000);
+	clks[IMX_MIPI_IPG_CLK]		= clk_hw_register_fixed_rate(NULL, "mipi_ipg_clk_root", NULL, 0, 120000000);
+	clks[IMX_IMG_AXI_CLK]		= clk_hw_register_fixed_rate(NULL, "img_axi_clk_root", NULL, 0, 400000000);
+	clks[IMX_IMG_IPG_CLK]		= clk_hw_register_fixed_rate(NULL, "img_ipg_clk_root", NULL, 0, 200000000);
+	clks[IMX_IMG_PXL_CLK]		= clk_hw_register_fixed_rate(NULL, "img_pxl_clk_root", NULL, 0, 600000000);
+	clks[IMX_HSIO_AXI_CLK]		= clk_hw_register_fixed_rate(NULL, "hsio_axi_clk_root", NULL, 0, 400000000);
+	clks[IMX_HSIO_PER_CLK]		= clk_hw_register_fixed_rate(NULL, "hsio_per_clk_root", NULL, 0, 133333333);
+	clks[IMX_LSIO_MEM_CLK]		= clk_hw_register_fixed_rate(NULL, "lsio_mem_clk_root", NULL, 0, 200000000);
+	clks[IMX_LSIO_BUS_CLK]		= clk_hw_register_fixed_rate(NULL, "lsio_bus_clk_root", NULL, 0, 100000000);
 
 	/* ARM core */
-	clks[IMX8QXP_A35_CLK]			= imx_clk_scu("a35_clk", IMX_SC_R_A35, IMX_SC_PM_CLK_CPU);
+	clks[IMX_A35_CLK]		= imx_clk_scu("a35_clk", IMX_SC_R_A35, IMX_SC_PM_CLK_CPU);
 
 	/* LSIO SS */
-	clks[IMX8QXP_LSIO_PWM0_CLK]		= imx_clk_scu("pwm0_clk", IMX_SC_R_PWM_0, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_LSIO_PWM1_CLK]		= imx_clk_scu("pwm1_clk", IMX_SC_R_PWM_1, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_LSIO_PWM2_CLK]		= imx_clk_scu("pwm2_clk", IMX_SC_R_PWM_2, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_LSIO_PWM3_CLK]		= imx_clk_scu("pwm3_clk", IMX_SC_R_PWM_3, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_LSIO_PWM4_CLK]		= imx_clk_scu("pwm4_clk", IMX_SC_R_PWM_4, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_LSIO_PWM5_CLK]		= imx_clk_scu("pwm5_clk", IMX_SC_R_PWM_5, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_LSIO_PWM6_CLK]		= imx_clk_scu("pwm6_clk", IMX_SC_R_PWM_6, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_LSIO_PWM7_CLK]		= imx_clk_scu("pwm7_clk", IMX_SC_R_PWM_7, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_LSIO_GPT0_CLK]		= imx_clk_scu("gpt0_clk", IMX_SC_R_GPT_0, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_LSIO_GPT1_CLK]		= imx_clk_scu("gpt1_clk", IMX_SC_R_GPT_1, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_LSIO_GPT2_CLK]		= imx_clk_scu("gpt2_clk", IMX_SC_R_GPT_2, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_LSIO_GPT3_CLK]		= imx_clk_scu("gpt3_clk", IMX_SC_R_GPT_3, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_LSIO_GPT4_CLK]		= imx_clk_scu("gpt4_clk", IMX_SC_R_GPT_4, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_LSIO_FSPI0_CLK]		= imx_clk_scu("fspi0_clk", IMX_SC_R_FSPI_0, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_LSIO_FSPI1_CLK]		= imx_clk_scu("fspi1_clk", IMX_SC_R_FSPI_1, IMX_SC_PM_CLK_PER);
+	clks[IMX_LSIO_PWM0_CLK]		= imx_clk_scu("pwm0_clk", IMX_SC_R_PWM_0, IMX_SC_PM_CLK_PER);
+	clks[IMX_LSIO_PWM1_CLK]		= imx_clk_scu("pwm1_clk", IMX_SC_R_PWM_1, IMX_SC_PM_CLK_PER);
+	clks[IMX_LSIO_PWM2_CLK]		= imx_clk_scu("pwm2_clk", IMX_SC_R_PWM_2, IMX_SC_PM_CLK_PER);
+	clks[IMX_LSIO_PWM3_CLK]		= imx_clk_scu("pwm3_clk", IMX_SC_R_PWM_3, IMX_SC_PM_CLK_PER);
+	clks[IMX_LSIO_PWM4_CLK]		= imx_clk_scu("pwm4_clk", IMX_SC_R_PWM_4, IMX_SC_PM_CLK_PER);
+	clks[IMX_LSIO_PWM5_CLK]		= imx_clk_scu("pwm5_clk", IMX_SC_R_PWM_5, IMX_SC_PM_CLK_PER);
+	clks[IMX_LSIO_PWM6_CLK]		= imx_clk_scu("pwm6_clk", IMX_SC_R_PWM_6, IMX_SC_PM_CLK_PER);
+	clks[IMX_LSIO_PWM7_CLK]		= imx_clk_scu("pwm7_clk", IMX_SC_R_PWM_7, IMX_SC_PM_CLK_PER);
+	clks[IMX_LSIO_GPT0_CLK]		= imx_clk_scu("gpt0_clk", IMX_SC_R_GPT_0, IMX_SC_PM_CLK_PER);
+	clks[IMX_LSIO_GPT1_CLK]		= imx_clk_scu("gpt1_clk", IMX_SC_R_GPT_1, IMX_SC_PM_CLK_PER);
+	clks[IMX_LSIO_GPT2_CLK]		= imx_clk_scu("gpt2_clk", IMX_SC_R_GPT_2, IMX_SC_PM_CLK_PER);
+	clks[IMX_LSIO_GPT3_CLK]		= imx_clk_scu("gpt3_clk", IMX_SC_R_GPT_3, IMX_SC_PM_CLK_PER);
+	clks[IMX_LSIO_GPT4_CLK]		= imx_clk_scu("gpt4_clk", IMX_SC_R_GPT_4, IMX_SC_PM_CLK_PER);
+	clks[IMX_LSIO_FSPI0_CLK]	= imx_clk_scu("fspi0_clk", IMX_SC_R_FSPI_0, IMX_SC_PM_CLK_PER);
+	clks[IMX_LSIO_FSPI1_CLK]	= imx_clk_scu("fspi1_clk", IMX_SC_R_FSPI_1, IMX_SC_PM_CLK_PER);
 
 	/* ADMA SS */
-	clks[IMX8QXP_ADMA_UART0_CLK]		= imx_clk_scu("uart0_clk", IMX_SC_R_UART_0, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_ADMA_UART1_CLK]		= imx_clk_scu("uart1_clk", IMX_SC_R_UART_1, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_ADMA_UART2_CLK]		= imx_clk_scu("uart2_clk", IMX_SC_R_UART_2, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_ADMA_UART3_CLK]		= imx_clk_scu("uart3_clk", IMX_SC_R_UART_3, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_ADMA_SPI0_CLK]		= imx_clk_scu("spi0_clk",  IMX_SC_R_SPI_0, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_ADMA_SPI1_CLK]		= imx_clk_scu("spi1_clk",  IMX_SC_R_SPI_1, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_ADMA_SPI2_CLK]		= imx_clk_scu("spi2_clk",  IMX_SC_R_SPI_2, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_ADMA_SPI3_CLK]		= imx_clk_scu("spi3_clk",  IMX_SC_R_SPI_3, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_ADMA_CAN0_CLK]		= imx_clk_scu("can0_clk",  IMX_SC_R_CAN_0, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_ADMA_I2C0_CLK]		= imx_clk_scu("i2c0_clk",  IMX_SC_R_I2C_0, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_ADMA_I2C1_CLK]		= imx_clk_scu("i2c1_clk",  IMX_SC_R_I2C_1, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_ADMA_I2C2_CLK]		= imx_clk_scu("i2c2_clk",  IMX_SC_R_I2C_2, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_ADMA_I2C3_CLK]		= imx_clk_scu("i2c3_clk",  IMX_SC_R_I2C_3, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_ADMA_FTM0_CLK]		= imx_clk_scu("ftm0_clk",  IMX_SC_R_FTM_0, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_ADMA_FTM1_CLK]		= imx_clk_scu("ftm1_clk",  IMX_SC_R_FTM_1, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_ADMA_ADC0_CLK]		= imx_clk_scu("adc0_clk",  IMX_SC_R_ADC_0, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_ADMA_PWM_CLK]		= imx_clk_scu("pwm_clk",   IMX_SC_R_LCD_0_PWM_0, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_ADMA_LCD_CLK]		= imx_clk_scu("lcd_clk",   IMX_SC_R_LCD_0, IMX_SC_PM_CLK_PER);
+	clks[IMX_ADMA_UART0_CLK]	= imx_clk_scu("uart0_clk", IMX_SC_R_UART_0, IMX_SC_PM_CLK_PER);
+	clks[IMX_ADMA_UART1_CLK]	= imx_clk_scu("uart1_clk", IMX_SC_R_UART_1, IMX_SC_PM_CLK_PER);
+	clks[IMX_ADMA_UART2_CLK]	= imx_clk_scu("uart2_clk", IMX_SC_R_UART_2, IMX_SC_PM_CLK_PER);
+	clks[IMX_ADMA_UART3_CLK]	= imx_clk_scu("uart3_clk", IMX_SC_R_UART_3, IMX_SC_PM_CLK_PER);
+	clks[IMX_ADMA_SPI0_CLK]		= imx_clk_scu("spi0_clk",  IMX_SC_R_SPI_0, IMX_SC_PM_CLK_PER);
+	clks[IMX_ADMA_SPI1_CLK]		= imx_clk_scu("spi1_clk",  IMX_SC_R_SPI_1, IMX_SC_PM_CLK_PER);
+	clks[IMX_ADMA_SPI2_CLK]		= imx_clk_scu("spi2_clk",  IMX_SC_R_SPI_2, IMX_SC_PM_CLK_PER);
+	clks[IMX_ADMA_SPI3_CLK]		= imx_clk_scu("spi3_clk",  IMX_SC_R_SPI_3, IMX_SC_PM_CLK_PER);
+	clks[IMX_ADMA_CAN0_CLK]		= imx_clk_scu("can0_clk",  IMX_SC_R_CAN_0, IMX_SC_PM_CLK_PER);
+	clks[IMX_ADMA_I2C0_CLK]		= imx_clk_scu("i2c0_clk",  IMX_SC_R_I2C_0, IMX_SC_PM_CLK_PER);
+	clks[IMX_ADMA_I2C1_CLK]		= imx_clk_scu("i2c1_clk",  IMX_SC_R_I2C_1, IMX_SC_PM_CLK_PER);
+	clks[IMX_ADMA_I2C2_CLK]		= imx_clk_scu("i2c2_clk",  IMX_SC_R_I2C_2, IMX_SC_PM_CLK_PER);
+	clks[IMX_ADMA_I2C3_CLK]		= imx_clk_scu("i2c3_clk",  IMX_SC_R_I2C_3, IMX_SC_PM_CLK_PER);
+	clks[IMX_ADMA_FTM0_CLK]		= imx_clk_scu("ftm0_clk",  IMX_SC_R_FTM_0, IMX_SC_PM_CLK_PER);
+	clks[IMX_ADMA_FTM1_CLK]		= imx_clk_scu("ftm1_clk",  IMX_SC_R_FTM_1, IMX_SC_PM_CLK_PER);
+	clks[IMX_ADMA_ADC0_CLK]		= imx_clk_scu("adc0_clk",  IMX_SC_R_ADC_0, IMX_SC_PM_CLK_PER);
+	clks[IMX_ADMA_PWM_CLK]		= imx_clk_scu("pwm_clk",   IMX_SC_R_LCD_0_PWM_0, IMX_SC_PM_CLK_PER);
+	clks[IMX_ADMA_LCD_CLK]		= imx_clk_scu("lcd_clk",   IMX_SC_R_LCD_0, IMX_SC_PM_CLK_PER);
 
 	/* Connectivity */
-	clks[IMX8QXP_CONN_SDHC0_CLK]		= imx_clk_scu("sdhc0_clk", IMX_SC_R_SDHC_0, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_CONN_SDHC1_CLK]		= imx_clk_scu("sdhc1_clk", IMX_SC_R_SDHC_1, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_CONN_SDHC2_CLK]		= imx_clk_scu("sdhc2_clk", IMX_SC_R_SDHC_2, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_CONN_ENET0_ROOT_CLK]	= imx_clk_scu("enet0_clk", IMX_SC_R_ENET_0, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_CONN_ENET0_BYPASS_CLK]	= imx_clk_scu("enet0_bypass_clk", IMX_SC_R_ENET_0, IMX_SC_PM_CLK_BYPASS);
-	clks[IMX8QXP_CONN_ENET0_RGMII_CLK]	= imx_clk_scu("enet0_rgmii_clk", IMX_SC_R_ENET_0, IMX_SC_PM_CLK_MISC0);
-	clks[IMX8QXP_CONN_ENET1_ROOT_CLK]	= imx_clk_scu("enet1_clk", IMX_SC_R_ENET_1, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_CONN_ENET1_BYPASS_CLK]	= imx_clk_scu("enet1_bypass_clk", IMX_SC_R_ENET_1, IMX_SC_PM_CLK_BYPASS);
-	clks[IMX8QXP_CONN_ENET1_RGMII_CLK]	= imx_clk_scu("enet1_rgmii_clk", IMX_SC_R_ENET_1, IMX_SC_PM_CLK_MISC0);
-	clks[IMX8QXP_CONN_GPMI_BCH_IO_CLK]	= imx_clk_scu("gpmi_io_clk", IMX_SC_R_NAND, IMX_SC_PM_CLK_MST_BUS);
-	clks[IMX8QXP_CONN_GPMI_BCH_CLK]		= imx_clk_scu("gpmi_bch_clk", IMX_SC_R_NAND, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_CONN_USB2_ACLK]		= imx_clk_scu("usb3_aclk_div", IMX_SC_R_USB_2, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_CONN_USB2_BUS_CLK]		= imx_clk_scu("usb3_bus_div", IMX_SC_R_USB_2, IMX_SC_PM_CLK_MST_BUS);
-	clks[IMX8QXP_CONN_USB2_LPM_CLK]		= imx_clk_scu("usb3_lpm_div", IMX_SC_R_USB_2, IMX_SC_PM_CLK_MISC);
+	clks[IMX_CONN_SDHC0_CLK]	= imx_clk_scu("sdhc0_clk", IMX_SC_R_SDHC_0, IMX_SC_PM_CLK_PER);
+	clks[IMX_CONN_SDHC1_CLK]	= imx_clk_scu("sdhc1_clk", IMX_SC_R_SDHC_1, IMX_SC_PM_CLK_PER);
+	clks[IMX_CONN_SDHC2_CLK]	= imx_clk_scu("sdhc2_clk", IMX_SC_R_SDHC_2, IMX_SC_PM_CLK_PER);
+	clks[IMX_CONN_ENET0_ROOT_CLK]	= imx_clk_scu("enet0_clk", IMX_SC_R_ENET_0, IMX_SC_PM_CLK_PER);
+	clks[IMX_CONN_ENET0_BYPASS_CLK]	= imx_clk_scu("enet0_bypass_clk", IMX_SC_R_ENET_0, IMX_SC_PM_CLK_BYPASS);
+	clks[IMX_CONN_ENET0_RGMII_CLK]	= imx_clk_scu("enet0_rgmii_clk", IMX_SC_R_ENET_0, IMX_SC_PM_CLK_MISC0);
+	clks[IMX_CONN_ENET1_ROOT_CLK]	= imx_clk_scu("enet1_clk", IMX_SC_R_ENET_1, IMX_SC_PM_CLK_PER);
+	clks[IMX_CONN_ENET1_BYPASS_CLK]	= imx_clk_scu("enet1_bypass_clk", IMX_SC_R_ENET_1, IMX_SC_PM_CLK_BYPASS);
+	clks[IMX_CONN_ENET1_RGMII_CLK]	= imx_clk_scu("enet1_rgmii_clk", IMX_SC_R_ENET_1, IMX_SC_PM_CLK_MISC0);
+	clks[IMX_CONN_GPMI_BCH_IO_CLK]	= imx_clk_scu("gpmi_io_clk", IMX_SC_R_NAND, IMX_SC_PM_CLK_MST_BUS);
+	clks[IMX_CONN_GPMI_BCH_CLK]	= imx_clk_scu("gpmi_bch_clk", IMX_SC_R_NAND, IMX_SC_PM_CLK_PER);
+	clks[IMX_CONN_USB2_ACLK]	= imx_clk_scu("usb3_aclk_div", IMX_SC_R_USB_2, IMX_SC_PM_CLK_PER);
+	clks[IMX_CONN_USB2_BUS_CLK]	= imx_clk_scu("usb3_bus_div", IMX_SC_R_USB_2, IMX_SC_PM_CLK_MST_BUS);
+	clks[IMX_CONN_USB2_LPM_CLK]	= imx_clk_scu("usb3_lpm_div", IMX_SC_R_USB_2, IMX_SC_PM_CLK_MISC);
 
 	/* Display controller SS */
-	clks[IMX8QXP_DC0_DISP0_CLK]		= imx_clk_scu("dc0_disp0_clk", IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC0);
-	clks[IMX8QXP_DC0_DISP1_CLK]		= imx_clk_scu("dc0_disp1_clk", IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC1);
+	clks[IMX_DC0_DISP0_CLK]		= imx_clk_scu("dc0_disp0_clk", IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC0);
+	clks[IMX_DC0_DISP1_CLK]		= imx_clk_scu("dc0_disp1_clk", IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC1);
 
 	/* MIPI-LVDS SS */
-	clks[IMX8QXP_MIPI0_I2C0_CLK]		= imx_clk_scu("mipi0_i2c0_clk", IMX_SC_R_MIPI_0_I2C_0, IMX_SC_PM_CLK_MISC2);
-	clks[IMX8QXP_MIPI0_I2C1_CLK]		= imx_clk_scu("mipi0_i2c1_clk", IMX_SC_R_MIPI_0_I2C_1, IMX_SC_PM_CLK_MISC2);
+	clks[IMX_MIPI0_I2C0_CLK]	= imx_clk_scu("mipi0_i2c0_clk", IMX_SC_R_MIPI_0_I2C_0, IMX_SC_PM_CLK_MISC2);
+	clks[IMX_MIPI0_I2C1_CLK]	= imx_clk_scu("mipi0_i2c1_clk", IMX_SC_R_MIPI_0_I2C_1, IMX_SC_PM_CLK_MISC2);
 
 	/* MIPI CSI SS */
-	clks[IMX8QXP_CSI0_CORE_CLK]		= imx_clk_scu("mipi_csi0_core_clk", IMX_SC_R_CSI_0, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_CSI0_ESC_CLK]		= imx_clk_scu("mipi_csi0_esc_clk",  IMX_SC_R_CSI_0, IMX_SC_PM_CLK_MISC);
-	clks[IMX8QXP_CSI0_I2C0_CLK]		= imx_clk_scu("mipi_csi0_i2c0_clk", IMX_SC_R_CSI_0_I2C_0, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_CSI0_PWM0_CLK]		= imx_clk_scu("mipi_csi0_pwm0_clk", IMX_SC_R_CSI_0_PWM_0, IMX_SC_PM_CLK_PER);
+	clks[IMX_CSI0_CORE_CLK]		= imx_clk_scu("mipi_csi0_core_clk", IMX_SC_R_CSI_0, IMX_SC_PM_CLK_PER);
+	clks[IMX_CSI0_ESC_CLK]		= imx_clk_scu("mipi_csi0_esc_clk",  IMX_SC_R_CSI_0, IMX_SC_PM_CLK_MISC);
+	clks[IMX_CSI0_I2C0_CLK]		= imx_clk_scu("mipi_csi0_i2c0_clk", IMX_SC_R_CSI_0_I2C_0, IMX_SC_PM_CLK_PER);
+	clks[IMX_CSI0_PWM0_CLK]		= imx_clk_scu("mipi_csi0_pwm0_clk", IMX_SC_R_CSI_0_PWM_0, IMX_SC_PM_CLK_PER);
 
 	/* GPU SS */
-	clks[IMX8QXP_GPU0_CORE_CLK]		= imx_clk_scu("gpu_core0_clk",	 IMX_SC_R_GPU_0_PID0, IMX_SC_PM_CLK_PER);
-	clks[IMX8QXP_GPU0_SHADER_CLK]		= imx_clk_scu("gpu_shader0_clk", IMX_SC_R_GPU_0_PID0, IMX_SC_PM_CLK_MISC);
+	clks[IMX_GPU0_CORE_CLK]		= imx_clk_scu("gpu_core0_clk",	 IMX_SC_R_GPU_0_PID0, IMX_SC_PM_CLK_PER);
+	clks[IMX_GPU0_SHADER_CLK]	= imx_clk_scu("gpu_shader0_clk", IMX_SC_R_GPU_0_PID0, IMX_SC_PM_CLK_MISC);
 
 	for (i = 0; i < clk_data->num; i++) {
 		if (IS_ERR(clks[i]))
diff --git a/include/dt-bindings/clock/imx8-clock.h b/include/dt-bindings/clock/imx8-clock.h
new file mode 100644
index 0000000..4236818
--- /dev/null
+++ b/include/dt-bindings/clock/imx8-clock.h
@@ -0,0 +1,289 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2018 NXP
+ *   Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMX_H
+#define __DT_BINDINGS_CLOCK_IMX_H
+
+/* SCU Clocks */
+
+#define IMX_CLK_DUMMY				0
+
+/* CPU */
+#define IMX_A35_CLK					1
+
+/* LSIO SS */
+#define IMX_LSIO_MEM_CLK				2
+#define IMX_LSIO_BUS_CLK				3
+#define IMX_LSIO_PWM0_CLK				10
+#define IMX_LSIO_PWM1_CLK				11
+#define IMX_LSIO_PWM2_CLK				12
+#define IMX_LSIO_PWM3_CLK				13
+#define IMX_LSIO_PWM4_CLK				14
+#define IMX_LSIO_PWM5_CLK				15
+#define IMX_LSIO_PWM6_CLK				16
+#define IMX_LSIO_PWM7_CLK				17
+#define IMX_LSIO_GPT0_CLK				18
+#define IMX_LSIO_GPT1_CLK				19
+#define IMX_LSIO_GPT2_CLK				20
+#define IMX_LSIO_GPT3_CLK				21
+#define IMX_LSIO_GPT4_CLK				22
+#define IMX_LSIO_FSPI0_CLK				23
+#define IMX_LSIO_FSPI1_CLK				24
+
+/* Connectivity SS */
+#define IMX_CONN_AXI_CLK_ROOT				30
+#define IMX_CONN_AHB_CLK_ROOT				31
+#define IMX_CONN_IPG_CLK_ROOT				32
+#define IMX_CONN_SDHC0_CLK				40
+#define IMX_CONN_SDHC1_CLK				41
+#define IMX_CONN_SDHC2_CLK				42
+#define IMX_CONN_ENET0_ROOT_CLK				43
+#define IMX_CONN_ENET0_BYPASS_CLK			44
+#define IMX_CONN_ENET0_RGMII_CLK			45
+#define IMX_CONN_ENET1_ROOT_CLK				46
+#define IMX_CONN_ENET1_BYPASS_CLK			47
+#define IMX_CONN_ENET1_RGMII_CLK			48
+#define IMX_CONN_GPMI_BCH_IO_CLK			49
+#define IMX_CONN_GPMI_BCH_CLK				50
+#define IMX_CONN_USB2_ACLK				51
+#define IMX_CONN_USB2_BUS_CLK				52
+#define IMX_CONN_USB2_LPM_CLK				53
+
+/* HSIO SS */
+#define IMX_HSIO_AXI_CLK				60
+#define IMX_HSIO_PER_CLK				61
+
+/* Display controller SS */
+#define IMX_DC_AXI_EXT_CLK				70
+#define IMX_DC_AXI_INT_CLK				71
+#define IMX_DC_CFG_CLK					72
+#define IMX_DC0_PLL0_CLK				80
+#define IMX_DC0_PLL1_CLK				81
+#define IMX_DC0_DISP0_CLK				82
+#define IMX_DC0_DISP1_CLK				83
+
+/* MIPI-LVDS SS */
+#define IMX_MIPI_IPG_CLK				90
+#define IMX_MIPI0_PIXEL_CLK				100
+#define IMX_MIPI0_BYPASS_CLK				101
+#define IMX_MIPI0_LVDS_PIXEL_CLK			102
+#define IMX_MIPI0_LVDS_BYPASS_CLK			103
+#define IMX_MIPI0_LVDS_PHY_CLK				104
+#define IMX_MIPI0_I2C0_CLK				105
+#define IMX_MIPI0_I2C1_CLK				106
+#define IMX_MIPI0_PWM0_CLK				107
+#define IMX_MIPI1_PIXEL_CLK				108
+#define IMX_MIPI1_BYPASS_CLK				109
+#define IMX_MIPI1_LVDS_PIXEL_CLK			110
+#define IMX_MIPI1_LVDS_BYPASS_CLK			111
+#define IMX_MIPI1_LVDS_PHY_CLK				112
+#define IMX_MIPI1_I2C0_CLK				113
+#define IMX_MIPI1_I2C1_CLK				114
+#define IMX_MIPI1_PWM0_CLK				115
+
+/* IMG SS */
+#define IMX_IMG_AXI_CLK					120
+#define IMX_IMG_IPG_CLK					121
+#define IMX_IMG_PXL_CLK					122
+
+/* MIPI-CSI SS */
+#define IMX_CSI0_CORE_CLK				130
+#define IMX_CSI0_ESC_CLK				131
+#define IMX_CSI0_PWM0_CLK				132
+#define IMX_CSI0_I2C0_CLK				133
+
+/* PARALLER CSI SS */
+#define IMX_PARALLEL_CSI_DPLL_CLK			140
+#define IMX_PARALLEL_CSI_PIXEL_CLK			141
+#define IMX_PARALLEL_CSI_MCLK_CLK			142
+
+/* VPU SS */
+#define IMX_VPU_ENC_CLK					150
+#define IMX_VPU_DEC_CLK					151
+
+/* GPU SS */
+#define IMX_GPU0_CORE_CLK				160
+#define IMX_GPU0_SHADER_CLK				161
+
+/* ADMA SS */
+#define IMX_ADMA_IPG_CLK_ROOT				165
+#define IMX_ADMA_UART0_CLK				170
+#define IMX_ADMA_UART1_CLK				171
+#define IMX_ADMA_UART2_CLK				172
+#define IMX_ADMA_UART3_CLK				173
+#define IMX_ADMA_SPI0_CLK				174
+#define IMX_ADMA_SPI1_CLK				175
+#define IMX_ADMA_SPI2_CLK				176
+#define IMX_ADMA_SPI3_CLK				177
+#define IMX_ADMA_CAN0_CLK				178
+#define IMX_ADMA_CAN1_CLK				179
+#define IMX_ADMA_CAN2_CLK				180
+#define IMX_ADMA_I2C0_CLK				181
+#define IMX_ADMA_I2C1_CLK				182
+#define IMX_ADMA_I2C2_CLK				183
+#define IMX_ADMA_I2C3_CLK				184
+#define IMX_ADMA_FTM0_CLK				185
+#define IMX_ADMA_FTM1_CLK				186
+#define IMX_ADMA_ADC0_CLK				187
+#define IMX_ADMA_PWM_CLK				188
+#define IMX_ADMA_LCD_CLK				189
+
+#define IMX_SCU_CLK_END					190
+
+/* LPCG clocks */
+
+/* LSIO SS LPCG */
+#define IMX_LSIO_LPCG_PWM0_IPG_CLK			0
+#define IMX_LSIO_LPCG_PWM0_IPG_S_CLK			1
+#define IMX_LSIO_LPCG_PWM0_IPG_HF_CLK			2
+#define IMX_LSIO_LPCG_PWM0_IPG_SLV_CLK			3
+#define IMX_LSIO_LPCG_PWM0_IPG_MSTR_CLK			4
+#define IMX_LSIO_LPCG_PWM1_IPG_CLK			5
+#define IMX_LSIO_LPCG_PWM1_IPG_S_CLK			6
+#define IMX_LSIO_LPCG_PWM1_IPG_HF_CLK			7
+#define IMX_LSIO_LPCG_PWM1_IPG_SLV_CLK			8
+#define IMX_LSIO_LPCG_PWM1_IPG_MSTR_CLK			9
+#define IMX_LSIO_LPCG_PWM2_IPG_CLK			10
+#define IMX_LSIO_LPCG_PWM2_IPG_S_CLK			11
+#define IMX_LSIO_LPCG_PWM2_IPG_HF_CLK			12
+#define IMX_LSIO_LPCG_PWM2_IPG_SLV_CLK			13
+#define IMX_LSIO_LPCG_PWM2_IPG_MSTR_CLK			14
+#define IMX_LSIO_LPCG_PWM3_IPG_CLK			15
+#define IMX_LSIO_LPCG_PWM3_IPG_S_CLK			16
+#define IMX_LSIO_LPCG_PWM3_IPG_HF_CLK			17
+#define IMX_LSIO_LPCG_PWM3_IPG_SLV_CLK			18
+#define IMX_LSIO_LPCG_PWM3_IPG_MSTR_CLK			19
+#define IMX_LSIO_LPCG_PWM4_IPG_CLK			20
+#define IMX_LSIO_LPCG_PWM4_IPG_S_CLK			21
+#define IMX_LSIO_LPCG_PWM4_IPG_HF_CLK			22
+#define IMX_LSIO_LPCG_PWM4_IPG_SLV_CLK			23
+#define IMX_LSIO_LPCG_PWM4_IPG_MSTR_CLK			24
+#define IMX_LSIO_LPCG_PWM5_IPG_CLK			25
+#define IMX_LSIO_LPCG_PWM5_IPG_S_CLK			26
+#define IMX_LSIO_LPCG_PWM5_IPG_HF_CLK			27
+#define IMX_LSIO_LPCG_PWM5_IPG_SLV_CLK			28
+#define IMX_LSIO_LPCG_PWM5_IPG_MSTR_CLK			29
+#define IMX_LSIO_LPCG_PWM6_IPG_CLK			30
+#define IMX_LSIO_LPCG_PWM6_IPG_S_CLK			31
+#define IMX_LSIO_LPCG_PWM6_IPG_HF_CLK			32
+#define IMX_LSIO_LPCG_PWM6_IPG_SLV_CLK			33
+#define IMX_LSIO_LPCG_PWM6_IPG_MSTR_CLK			34
+#define IMX_LSIO_LPCG_PWM7_IPG_CLK			35
+#define IMX_LSIO_LPCG_PWM7_IPG_S_CLK			36
+#define IMX_LSIO_LPCG_PWM7_IPG_HF_CLK			37
+#define IMX_LSIO_LPCG_PWM7_IPG_SLV_CLK			38
+#define IMX_LSIO_LPCG_PWM7_IPG_MSTR_CLK			39
+#define IMX_LSIO_LPCG_GPT0_IPG_CLK			40
+#define IMX_LSIO_LPCG_GPT0_IPG_S_CLK			41
+#define IMX_LSIO_LPCG_GPT0_IPG_HF_CLK			42
+#define IMX_LSIO_LPCG_GPT0_IPG_SLV_CLK			43
+#define IMX_LSIO_LPCG_GPT0_IPG_MSTR_CLK			44
+#define IMX_LSIO_LPCG_GPT1_IPG_CLK			45
+#define IMX_LSIO_LPCG_GPT1_IPG_S_CLK			46
+#define IMX_LSIO_LPCG_GPT1_IPG_HF_CLK			47
+#define IMX_LSIO_LPCG_GPT1_IPG_SLV_CLK			48
+#define IMX_LSIO_LPCG_GPT1_IPG_MSTR_CLK			49
+#define IMX_LSIO_LPCG_GPT2_IPG_CLK			50
+#define IMX_LSIO_LPCG_GPT2_IPG_S_CLK			51
+#define IMX_LSIO_LPCG_GPT2_IPG_HF_CLK			52
+#define IMX_LSIO_LPCG_GPT2_IPG_SLV_CLK			53
+#define IMX_LSIO_LPCG_GPT2_IPG_MSTR_CLK			54
+#define IMX_LSIO_LPCG_GPT3_IPG_CLK			55
+#define IMX_LSIO_LPCG_GPT3_IPG_S_CLK			56
+#define IMX_LSIO_LPCG_GPT3_IPG_HF_CLK			57
+#define IMX_LSIO_LPCG_GPT3_IPG_SLV_CLK			58
+#define IMX_LSIO_LPCG_GPT3_IPG_MSTR_CLK			59
+#define IMX_LSIO_LPCG_GPT4_IPG_CLK			60
+#define IMX_LSIO_LPCG_GPT4_IPG_S_CLK			61
+#define IMX_LSIO_LPCG_GPT4_IPG_HF_CLK			62
+#define IMX_LSIO_LPCG_GPT4_IPG_SLV_CLK			63
+#define IMX_LSIO_LPCG_GPT4_IPG_MSTR_CLK			64
+#define IMX_LSIO_LPCG_FSPI0_HCLK			65
+#define IMX_LSIO_LPCG_FSPI0_IPG_CLK			66
+#define IMX_LSIO_LPCG_FSPI0_IPG_S_CLK			67
+#define IMX_LSIO_LPCG_FSPI0_IPG_SFCK			68
+#define IMX_LSIO_LPCG_FSPI1_HCLK			69
+#define IMX_LSIO_LPCG_FSPI1_IPG_CLK			70
+#define IMX_LSIO_LPCG_FSPI1_IPG_S_CLK			71
+#define IMX_LSIO_LPCG_FSPI1_IPG_SFCK			72
+
+#define IMX_LSIO_LPCG_CLK_END				73
+
+/* Connectivity SS LPCG */
+#define IMX_CONN_LPCG_SDHC0_IPG_CLK			0
+#define IMX_CONN_LPCG_SDHC0_PER_CLK			1
+#define IMX_CONN_LPCG_SDHC0_HCLK			2
+#define IMX_CONN_LPCG_SDHC1_IPG_CLK			3
+#define IMX_CONN_LPCG_SDHC1_PER_CLK			4
+#define IMX_CONN_LPCG_SDHC1_HCLK			5
+#define IMX_CONN_LPCG_SDHC2_IPG_CLK			6
+#define IMX_CONN_LPCG_SDHC2_PER_CLK			7
+#define IMX_CONN_LPCG_SDHC2_HCLK			8
+#define IMX_CONN_LPCG_GPMI_APB_CLK			9
+#define IMX_CONN_LPCG_GPMI_BCH_APB_CLK			10
+#define IMX_CONN_LPCG_GPMI_BCH_IO_CLK			11
+#define IMX_CONN_LPCG_GPMI_BCH_CLK			12
+#define IMX_CONN_LPCG_APBHDMA_CLK			13
+#define IMX_CONN_LPCG_ENET0_ROOT_CLK			14
+#define IMX_CONN_LPCG_ENET0_TX_CLK			15
+#define IMX_CONN_LPCG_ENET0_AHB_CLK			16
+#define IMX_CONN_LPCG_ENET0_IPG_S_CLK			17
+#define IMX_CONN_LPCG_ENET0_IPG_CLK			18
+
+#define IMX_CONN_LPCG_ENET1_ROOT_CLK			19
+#define IMX_CONN_LPCG_ENET1_TX_CLK			20
+#define IMX_CONN_LPCG_ENET1_AHB_CLK			21
+#define IMX_CONN_LPCG_ENET1_IPG_S_CLK			22
+#define IMX_CONN_LPCG_ENET1_IPG_CLK			23
+
+#define IMX_CONN_LPCG_CLK_END				24
+
+/* ADMA SS LPCG */
+#define IMX_ADMA_LPCG_UART0_IPG_CLK			0
+#define IMX_ADMA_LPCG_UART0_BAUD_CLK			1
+#define IMX_ADMA_LPCG_UART1_IPG_CLK			2
+#define IMX_ADMA_LPCG_UART1_BAUD_CLK			3
+#define IMX_ADMA_LPCG_UART2_IPG_CLK			4
+#define IMX_ADMA_LPCG_UART2_BAUD_CLK			5
+#define IMX_ADMA_LPCG_UART3_IPG_CLK			6
+#define IMX_ADMA_LPCG_UART3_BAUD_CLK			7
+#define IMX_ADMA_LPCG_SPI0_IPG_CLK			8
+#define IMX_ADMA_LPCG_SPI1_IPG_CLK			9
+#define IMX_ADMA_LPCG_SPI2_IPG_CLK			10
+#define IMX_ADMA_LPCG_SPI3_IPG_CLK			11
+#define IMX_ADMA_LPCG_SPI0_CLK				12
+#define IMX_ADMA_LPCG_SPI1_CLK				13
+#define IMX_ADMA_LPCG_SPI2_CLK				14
+#define IMX_ADMA_LPCG_SPI3_CLK				15
+#define IMX_ADMA_LPCG_CAN0_IPG_CLK			16
+#define IMX_ADMA_LPCG_CAN0_IPG_PE_CLK			17
+#define IMX_ADMA_LPCG_CAN0_IPG_CHI_CLK			18
+#define IMX_ADMA_LPCG_CAN1_IPG_CLK			19
+#define IMX_ADMA_LPCG_CAN1_IPG_PE_CLK			20
+#define IMX_ADMA_LPCG_CAN1_IPG_CHI_CLK			21
+#define IMX_ADMA_LPCG_CAN2_IPG_CLK			22
+#define IMX_ADMA_LPCG_CAN2_IPG_PE_CLK			23
+#define IMX_ADMA_LPCG_CAN2_IPG_CHI_CLK			24
+#define IMX_ADMA_LPCG_I2C0_CLK				25
+#define IMX_ADMA_LPCG_I2C1_CLK				26
+#define IMX_ADMA_LPCG_I2C2_CLK				27
+#define IMX_ADMA_LPCG_I2C3_CLK				28
+#define IMX_ADMA_LPCG_I2C0_IPG_CLK			29
+#define IMX_ADMA_LPCG_I2C1_IPG_CLK			30
+#define IMX_ADMA_LPCG_I2C2_IPG_CLK			31
+#define IMX_ADMA_LPCG_I2C3_IPG_CLK			32
+#define IMX_ADMA_LPCG_FTM0_CLK				33
+#define IMX_ADMA_LPCG_FTM1_CLK				34
+#define IMX_ADMA_LPCG_FTM0_IPG_CLK			35
+#define IMX_ADMA_LPCG_FTM1_IPG_CLK			36
+#define IMX_ADMA_LPCG_PWM_HI_CLK			37
+#define IMX_ADMA_LPCG_PWM_IPG_CLK			38
+#define IMX_ADMA_LPCG_LCD_PIX_CLK			39
+#define IMX_ADMA_LPCG_LCD_APB_CLK			40
+
+#define IMX_ADMA_LPCG_CLK_END				41
+
+#endif /* __DT_BINDINGS_CLOCK_IMX_H */
diff --git a/include/dt-bindings/clock/imx8qxp-clock.h b/include/dt-bindings/clock/imx8qxp-clock.h
deleted file mode 100644
index 6fec368..0000000
--- a/include/dt-bindings/clock/imx8qxp-clock.h
+++ /dev/null
@@ -1,289 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2018 NXP
- *   Dong Aisheng <aisheng.dong@nxp.com>
- */
-
-#ifndef __DT_BINDINGS_CLOCK_IMX8QXP_H
-#define __DT_BINDINGS_CLOCK_IMX8QXP_H
-
-/* SCU Clocks */
-
-#define IMX8QXP_CLK_DUMMY				0
-
-/* CPU */
-#define IMX8QXP_A35_CLK					1
-
-/* LSIO SS */
-#define IMX8QXP_LSIO_MEM_CLK				2
-#define IMX8QXP_LSIO_BUS_CLK				3
-#define IMX8QXP_LSIO_PWM0_CLK				10
-#define IMX8QXP_LSIO_PWM1_CLK				11
-#define IMX8QXP_LSIO_PWM2_CLK				12
-#define IMX8QXP_LSIO_PWM3_CLK				13
-#define IMX8QXP_LSIO_PWM4_CLK				14
-#define IMX8QXP_LSIO_PWM5_CLK				15
-#define IMX8QXP_LSIO_PWM6_CLK				16
-#define IMX8QXP_LSIO_PWM7_CLK				17
-#define IMX8QXP_LSIO_GPT0_CLK				18
-#define IMX8QXP_LSIO_GPT1_CLK				19
-#define IMX8QXP_LSIO_GPT2_CLK				20
-#define IMX8QXP_LSIO_GPT3_CLK				21
-#define IMX8QXP_LSIO_GPT4_CLK				22
-#define IMX8QXP_LSIO_FSPI0_CLK				23
-#define IMX8QXP_LSIO_FSPI1_CLK				24
-
-/* Connectivity SS */
-#define IMX8QXP_CONN_AXI_CLK_ROOT			30
-#define IMX8QXP_CONN_AHB_CLK_ROOT			31
-#define IMX8QXP_CONN_IPG_CLK_ROOT			32
-#define IMX8QXP_CONN_SDHC0_CLK				40
-#define IMX8QXP_CONN_SDHC1_CLK				41
-#define IMX8QXP_CONN_SDHC2_CLK				42
-#define IMX8QXP_CONN_ENET0_ROOT_CLK			43
-#define IMX8QXP_CONN_ENET0_BYPASS_CLK			44
-#define IMX8QXP_CONN_ENET0_RGMII_CLK			45
-#define IMX8QXP_CONN_ENET1_ROOT_CLK			46
-#define IMX8QXP_CONN_ENET1_BYPASS_CLK			47
-#define IMX8QXP_CONN_ENET1_RGMII_CLK			48
-#define IMX8QXP_CONN_GPMI_BCH_IO_CLK			49
-#define IMX8QXP_CONN_GPMI_BCH_CLK			50
-#define IMX8QXP_CONN_USB2_ACLK				51
-#define IMX8QXP_CONN_USB2_BUS_CLK			52
-#define IMX8QXP_CONN_USB2_LPM_CLK			53
-
-/* HSIO SS */
-#define IMX8QXP_HSIO_AXI_CLK				60
-#define IMX8QXP_HSIO_PER_CLK				61
-
-/* Display controller SS */
-#define IMX8QXP_DC_AXI_EXT_CLK				70
-#define IMX8QXP_DC_AXI_INT_CLK				71
-#define IMX8QXP_DC_CFG_CLK				72
-#define IMX8QXP_DC0_PLL0_CLK				80
-#define IMX8QXP_DC0_PLL1_CLK				81
-#define IMX8QXP_DC0_DISP0_CLK				82
-#define IMX8QXP_DC0_DISP1_CLK				83
-
-/* MIPI-LVDS SS */
-#define IMX8QXP_MIPI_IPG_CLK				90
-#define IMX8QXP_MIPI0_PIXEL_CLK				100
-#define IMX8QXP_MIPI0_BYPASS_CLK			101
-#define IMX8QXP_MIPI0_LVDS_PIXEL_CLK			102
-#define IMX8QXP_MIPI0_LVDS_BYPASS_CLK			103
-#define IMX8QXP_MIPI0_LVDS_PHY_CLK			104
-#define IMX8QXP_MIPI0_I2C0_CLK				105
-#define IMX8QXP_MIPI0_I2C1_CLK				106
-#define IMX8QXP_MIPI0_PWM0_CLK				107
-#define IMX8QXP_MIPI1_PIXEL_CLK				108
-#define IMX8QXP_MIPI1_BYPASS_CLK			109
-#define IMX8QXP_MIPI1_LVDS_PIXEL_CLK			110
-#define IMX8QXP_MIPI1_LVDS_BYPASS_CLK			111
-#define IMX8QXP_MIPI1_LVDS_PHY_CLK			112
-#define IMX8QXP_MIPI1_I2C0_CLK				113
-#define IMX8QXP_MIPI1_I2C1_CLK				114
-#define IMX8QXP_MIPI1_PWM0_CLK				115
-
-/* IMG SS */
-#define IMX8QXP_IMG_AXI_CLK				120
-#define IMX8QXP_IMG_IPG_CLK				121
-#define IMX8QXP_IMG_PXL_CLK				122
-
-/* MIPI-CSI SS */
-#define IMX8QXP_CSI0_CORE_CLK				130
-#define IMX8QXP_CSI0_ESC_CLK				131
-#define IMX8QXP_CSI0_PWM0_CLK				132
-#define IMX8QXP_CSI0_I2C0_CLK				133
-
-/* PARALLER CSI SS */
-#define IMX8QXP_PARALLEL_CSI_DPLL_CLK			140
-#define IMX8QXP_PARALLEL_CSI_PIXEL_CLK			141
-#define IMX8QXP_PARALLEL_CSI_MCLK_CLK			142
-
-/* VPU SS */
-#define IMX8QXP_VPU_ENC_CLK				150
-#define IMX8QXP_VPU_DEC_CLK				151
-
-/* GPU SS */
-#define IMX8QXP_GPU0_CORE_CLK				160
-#define IMX8QXP_GPU0_SHADER_CLK				161
-
-/* ADMA SS */
-#define IMX8QXP_ADMA_IPG_CLK_ROOT			165
-#define IMX8QXP_ADMA_UART0_CLK				170
-#define IMX8QXP_ADMA_UART1_CLK				171
-#define IMX8QXP_ADMA_UART2_CLK				172
-#define IMX8QXP_ADMA_UART3_CLK				173
-#define IMX8QXP_ADMA_SPI0_CLK				174
-#define IMX8QXP_ADMA_SPI1_CLK				175
-#define IMX8QXP_ADMA_SPI2_CLK				176
-#define IMX8QXP_ADMA_SPI3_CLK				177
-#define IMX8QXP_ADMA_CAN0_CLK				178
-#define IMX8QXP_ADMA_CAN1_CLK				179
-#define IMX8QXP_ADMA_CAN2_CLK				180
-#define IMX8QXP_ADMA_I2C0_CLK				181
-#define IMX8QXP_ADMA_I2C1_CLK				182
-#define IMX8QXP_ADMA_I2C2_CLK				183
-#define IMX8QXP_ADMA_I2C3_CLK				184
-#define IMX8QXP_ADMA_FTM0_CLK				185
-#define IMX8QXP_ADMA_FTM1_CLK				186
-#define IMX8QXP_ADMA_ADC0_CLK				187
-#define IMX8QXP_ADMA_PWM_CLK				188
-#define IMX8QXP_ADMA_LCD_CLK				189
-
-#define IMX8QXP_SCU_CLK_END				190
-
-/* LPCG clocks */
-
-/* LSIO SS LPCG */
-#define IMX8QXP_LSIO_LPCG_PWM0_IPG_CLK			0
-#define IMX8QXP_LSIO_LPCG_PWM0_IPG_S_CLK		1
-#define IMX8QXP_LSIO_LPCG_PWM0_IPG_HF_CLK		2
-#define IMX8QXP_LSIO_LPCG_PWM0_IPG_SLV_CLK		3
-#define IMX8QXP_LSIO_LPCG_PWM0_IPG_MSTR_CLK		4
-#define IMX8QXP_LSIO_LPCG_PWM1_IPG_CLK			5
-#define IMX8QXP_LSIO_LPCG_PWM1_IPG_S_CLK		6
-#define IMX8QXP_LSIO_LPCG_PWM1_IPG_HF_CLK		7
-#define IMX8QXP_LSIO_LPCG_PWM1_IPG_SLV_CLK		8
-#define IMX8QXP_LSIO_LPCG_PWM1_IPG_MSTR_CLK		9
-#define IMX8QXP_LSIO_LPCG_PWM2_IPG_CLK			10
-#define IMX8QXP_LSIO_LPCG_PWM2_IPG_S_CLK		11
-#define IMX8QXP_LSIO_LPCG_PWM2_IPG_HF_CLK		12
-#define IMX8QXP_LSIO_LPCG_PWM2_IPG_SLV_CLK		13
-#define IMX8QXP_LSIO_LPCG_PWM2_IPG_MSTR_CLK		14
-#define IMX8QXP_LSIO_LPCG_PWM3_IPG_CLK			15
-#define IMX8QXP_LSIO_LPCG_PWM3_IPG_S_CLK		16
-#define IMX8QXP_LSIO_LPCG_PWM3_IPG_HF_CLK		17
-#define IMX8QXP_LSIO_LPCG_PWM3_IPG_SLV_CLK		18
-#define IMX8QXP_LSIO_LPCG_PWM3_IPG_MSTR_CLK		19
-#define IMX8QXP_LSIO_LPCG_PWM4_IPG_CLK			20
-#define IMX8QXP_LSIO_LPCG_PWM4_IPG_S_CLK		21
-#define IMX8QXP_LSIO_LPCG_PWM4_IPG_HF_CLK		22
-#define IMX8QXP_LSIO_LPCG_PWM4_IPG_SLV_CLK		23
-#define IMX8QXP_LSIO_LPCG_PWM4_IPG_MSTR_CLK		24
-#define IMX8QXP_LSIO_LPCG_PWM5_IPG_CLK			25
-#define IMX8QXP_LSIO_LPCG_PWM5_IPG_S_CLK		26
-#define IMX8QXP_LSIO_LPCG_PWM5_IPG_HF_CLK		27
-#define IMX8QXP_LSIO_LPCG_PWM5_IPG_SLV_CLK		28
-#define IMX8QXP_LSIO_LPCG_PWM5_IPG_MSTR_CLK		29
-#define IMX8QXP_LSIO_LPCG_PWM6_IPG_CLK			30
-#define IMX8QXP_LSIO_LPCG_PWM6_IPG_S_CLK		31
-#define IMX8QXP_LSIO_LPCG_PWM6_IPG_HF_CLK		32
-#define IMX8QXP_LSIO_LPCG_PWM6_IPG_SLV_CLK		33
-#define IMX8QXP_LSIO_LPCG_PWM6_IPG_MSTR_CLK		34
-#define IMX8QXP_LSIO_LPCG_PWM7_IPG_CLK			35
-#define IMX8QXP_LSIO_LPCG_PWM7_IPG_S_CLK		36
-#define IMX8QXP_LSIO_LPCG_PWM7_IPG_HF_CLK		37
-#define IMX8QXP_LSIO_LPCG_PWM7_IPG_SLV_CLK		38
-#define IMX8QXP_LSIO_LPCG_PWM7_IPG_MSTR_CLK		39
-#define IMX8QXP_LSIO_LPCG_GPT0_IPG_CLK			40
-#define IMX8QXP_LSIO_LPCG_GPT0_IPG_S_CLK		41
-#define IMX8QXP_LSIO_LPCG_GPT0_IPG_HF_CLK		42
-#define IMX8QXP_LSIO_LPCG_GPT0_IPG_SLV_CLK		43
-#define IMX8QXP_LSIO_LPCG_GPT0_IPG_MSTR_CLK		44
-#define IMX8QXP_LSIO_LPCG_GPT1_IPG_CLK			45
-#define IMX8QXP_LSIO_LPCG_GPT1_IPG_S_CLK		46
-#define IMX8QXP_LSIO_LPCG_GPT1_IPG_HF_CLK		47
-#define IMX8QXP_LSIO_LPCG_GPT1_IPG_SLV_CLK		48
-#define IMX8QXP_LSIO_LPCG_GPT1_IPG_MSTR_CLK		49
-#define IMX8QXP_LSIO_LPCG_GPT2_IPG_CLK			50
-#define IMX8QXP_LSIO_LPCG_GPT2_IPG_S_CLK		51
-#define IMX8QXP_LSIO_LPCG_GPT2_IPG_HF_CLK		52
-#define IMX8QXP_LSIO_LPCG_GPT2_IPG_SLV_CLK		53
-#define IMX8QXP_LSIO_LPCG_GPT2_IPG_MSTR_CLK		54
-#define IMX8QXP_LSIO_LPCG_GPT3_IPG_CLK			55
-#define IMX8QXP_LSIO_LPCG_GPT3_IPG_S_CLK		56
-#define IMX8QXP_LSIO_LPCG_GPT3_IPG_HF_CLK		57
-#define IMX8QXP_LSIO_LPCG_GPT3_IPG_SLV_CLK		58
-#define IMX8QXP_LSIO_LPCG_GPT3_IPG_MSTR_CLK		59
-#define IMX8QXP_LSIO_LPCG_GPT4_IPG_CLK			60
-#define IMX8QXP_LSIO_LPCG_GPT4_IPG_S_CLK		61
-#define IMX8QXP_LSIO_LPCG_GPT4_IPG_HF_CLK		62
-#define IMX8QXP_LSIO_LPCG_GPT4_IPG_SLV_CLK		63
-#define IMX8QXP_LSIO_LPCG_GPT4_IPG_MSTR_CLK		64
-#define IMX8QXP_LSIO_LPCG_FSPI0_HCLK			65
-#define IMX8QXP_LSIO_LPCG_FSPI0_IPG_CLK			66
-#define IMX8QXP_LSIO_LPCG_FSPI0_IPG_S_CLK		67
-#define IMX8QXP_LSIO_LPCG_FSPI0_IPG_SFCK		68
-#define IMX8QXP_LSIO_LPCG_FSPI1_HCLK			69
-#define IMX8QXP_LSIO_LPCG_FSPI1_IPG_CLK			70
-#define IMX8QXP_LSIO_LPCG_FSPI1_IPG_S_CLK		71
-#define IMX8QXP_LSIO_LPCG_FSPI1_IPG_SFCK		72
-
-#define IMX8QXP_LSIO_LPCG_CLK_END			73
-
-/* Connectivity SS LPCG */
-#define IMX8QXP_CONN_LPCG_SDHC0_IPG_CLK			0
-#define IMX8QXP_CONN_LPCG_SDHC0_PER_CLK			1
-#define IMX8QXP_CONN_LPCG_SDHC0_HCLK			2
-#define IMX8QXP_CONN_LPCG_SDHC1_IPG_CLK			3
-#define IMX8QXP_CONN_LPCG_SDHC1_PER_CLK			4
-#define IMX8QXP_CONN_LPCG_SDHC1_HCLK			5
-#define IMX8QXP_CONN_LPCG_SDHC2_IPG_CLK			6
-#define IMX8QXP_CONN_LPCG_SDHC2_PER_CLK			7
-#define IMX8QXP_CONN_LPCG_SDHC2_HCLK			8
-#define IMX8QXP_CONN_LPCG_GPMI_APB_CLK			9
-#define IMX8QXP_CONN_LPCG_GPMI_BCH_APB_CLK		10
-#define IMX8QXP_CONN_LPCG_GPMI_BCH_IO_CLK		11
-#define IMX8QXP_CONN_LPCG_GPMI_BCH_CLK			12
-#define IMX8QXP_CONN_LPCG_APBHDMA_CLK			13
-#define IMX8QXP_CONN_LPCG_ENET0_ROOT_CLK		14
-#define IMX8QXP_CONN_LPCG_ENET0_TX_CLK			15
-#define IMX8QXP_CONN_LPCG_ENET0_AHB_CLK			16
-#define IMX8QXP_CONN_LPCG_ENET0_IPG_S_CLK		17
-#define IMX8QXP_CONN_LPCG_ENET0_IPG_CLK			18
-
-#define IMX8QXP_CONN_LPCG_ENET1_ROOT_CLK		19
-#define IMX8QXP_CONN_LPCG_ENET1_TX_CLK			20
-#define IMX8QXP_CONN_LPCG_ENET1_AHB_CLK			21
-#define IMX8QXP_CONN_LPCG_ENET1_IPG_S_CLK		22
-#define IMX8QXP_CONN_LPCG_ENET1_IPG_CLK			23
-
-#define IMX8QXP_CONN_LPCG_CLK_END			24
-
-/* ADMA SS LPCG */
-#define IMX8QXP_ADMA_LPCG_UART0_IPG_CLK			0
-#define IMX8QXP_ADMA_LPCG_UART0_BAUD_CLK		1
-#define IMX8QXP_ADMA_LPCG_UART1_IPG_CLK			2
-#define IMX8QXP_ADMA_LPCG_UART1_BAUD_CLK		3
-#define IMX8QXP_ADMA_LPCG_UART2_IPG_CLK			4
-#define IMX8QXP_ADMA_LPCG_UART2_BAUD_CLK		5
-#define IMX8QXP_ADMA_LPCG_UART3_IPG_CLK			6
-#define IMX8QXP_ADMA_LPCG_UART3_BAUD_CLK		7
-#define IMX8QXP_ADMA_LPCG_SPI0_IPG_CLK			8
-#define IMX8QXP_ADMA_LPCG_SPI1_IPG_CLK			9
-#define IMX8QXP_ADMA_LPCG_SPI2_IPG_CLK			10
-#define IMX8QXP_ADMA_LPCG_SPI3_IPG_CLK			11
-#define IMX8QXP_ADMA_LPCG_SPI0_CLK			12
-#define IMX8QXP_ADMA_LPCG_SPI1_CLK			13
-#define IMX8QXP_ADMA_LPCG_SPI2_CLK			14
-#define IMX8QXP_ADMA_LPCG_SPI3_CLK			15
-#define IMX8QXP_ADMA_LPCG_CAN0_IPG_CLK			16
-#define IMX8QXP_ADMA_LPCG_CAN0_IPG_PE_CLK		17
-#define IMX8QXP_ADMA_LPCG_CAN0_IPG_CHI_CLK		18
-#define IMX8QXP_ADMA_LPCG_CAN1_IPG_CLK			19
-#define IMX8QXP_ADMA_LPCG_CAN1_IPG_PE_CLK		20
-#define IMX8QXP_ADMA_LPCG_CAN1_IPG_CHI_CLK		21
-#define IMX8QXP_ADMA_LPCG_CAN2_IPG_CLK			22
-#define IMX8QXP_ADMA_LPCG_CAN2_IPG_PE_CLK		23
-#define IMX8QXP_ADMA_LPCG_CAN2_IPG_CHI_CLK		24
-#define IMX8QXP_ADMA_LPCG_I2C0_CLK			25
-#define IMX8QXP_ADMA_LPCG_I2C1_CLK			26
-#define IMX8QXP_ADMA_LPCG_I2C2_CLK			27
-#define IMX8QXP_ADMA_LPCG_I2C3_CLK			28
-#define IMX8QXP_ADMA_LPCG_I2C0_IPG_CLK			29
-#define IMX8QXP_ADMA_LPCG_I2C1_IPG_CLK			30
-#define IMX8QXP_ADMA_LPCG_I2C2_IPG_CLK			31
-#define IMX8QXP_ADMA_LPCG_I2C3_IPG_CLK			32
-#define IMX8QXP_ADMA_LPCG_FTM0_CLK			33
-#define IMX8QXP_ADMA_LPCG_FTM1_CLK			34
-#define IMX8QXP_ADMA_LPCG_FTM0_IPG_CLK			35
-#define IMX8QXP_ADMA_LPCG_FTM1_IPG_CLK			36
-#define IMX8QXP_ADMA_LPCG_PWM_HI_CLK			37
-#define IMX8QXP_ADMA_LPCG_PWM_IPG_CLK			38
-#define IMX8QXP_ADMA_LPCG_LCD_PIX_CLK			39
-#define IMX8QXP_ADMA_LPCG_LCD_APB_CLK			40
-
-#define IMX8QXP_ADMA_LPCG_CLK_END			41
-
-#endif /* __DT_BINDINGS_CLOCK_IMX8QXP_H */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
