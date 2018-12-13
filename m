Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE88C6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:09:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAFA720811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tqoJtB+H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AF5HoQFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFA720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lemxu66v/C8N9SwyQNsqX9ogHf2ImfAIUmTpohdwJwA=; b=tqoJtB+H6j+vEY
	RAEsS2xp1PdXcGFBJ8+zGHSKhXXnB9WnK24H5MnDOetV+nfj1FJ9QuIDdJoI/LUFdiird03CME+eS
	sORKqNUTRhloLMbVPgynA4C20PolI9rckMfBajnv2I4P729ZFKmtgzn6LxfSYvGVGMMq0WI7xwflK
	0DRwO5PFXHtFjNl6BFXCwKi2+Hp4UTiru0sDHayXVCzbpBgrPmubQ3XtsXceenck/j1uiZtoJcJl+
	Nc3RCnCjB5ensR4eqY2jpiFDw/bpgLV4+siT7InmnY2zGuHCVJHuQxBsKRGaxareNAvrVnGU0o1gG
	DdVquezQS7Mr6fiAza8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXFVQ-0005Sb-9J; Thu, 13 Dec 2018 01:09:36 +0000
Received: from mail-he1eur02on062f.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::62f]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXFUJ-0004Em-Hm
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 01:08:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wy0lmyr3qt/fT92NOWjuFG38+pkum8GNFqLv427GCwY=;
 b=AF5HoQFU4c3FFnaLagAsvH9dTwI7kuc4Jb0H4aZI+12AmYP/tb3XR+DXfoLqLI3UCSV8BvImjgjFVLYeXdcd1QZoXeKBRzsVmekWDvaQ7HbPFw3/RUVcyaebGVxOPavqOYU53aMH9wx2GH4JMPH/GKs63/4PhxdjHAqpukkgdLU=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4852.eurprd04.prod.outlook.com (20.176.215.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.23; Thu, 13 Dec 2018 01:08:06 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Thu, 13 Dec 2018
 01:08:06 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V11 5/7] dt-bindings: clock: add imx8qxp lpcg clock binding
Thread-Topic: [PATCH V11 5/7] dt-bindings: clock: add imx8qxp lpcg clock
 binding
Thread-Index: AQHUkoBOFuJmZxHxf0SxX8vS7E5JzQ==
Date: Thu, 13 Dec 2018 01:08:06 +0000
Message-ID: <1544662938-5020-6-git-send-email-aisheng.dong@nxp.com>
References: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4852;
 6:fU7pp8ZND3bhb5+5jWKt0n4qcDQcT4LrZUeoAnStyq+1rXmDV10OKyC9mdjfXgsuf+mQleaYpOEoiNFCgeMASxNgK9yTvifryvix6NrI4E27g88odKDa16BmbEiklZX33CEEoY2qk5cwioRvFQEHEiFvAhvIcsvJ6SDX+F/ngF52/rdGcFGiXAuY/dEebm/h5jaP82cDYu5gtVnviahB7lEOVuhDcMf1WK58r2zuAHMO96yZPDiHEJnSgdLOfDB3XRL7eHqbUHMD9wkFlm38P7RQNYBdENesoOsOQaBFT2te3dXQ9nXoo6WtZdy8Wn0GbPucLC/A0ZHP7noWtTg8Ht51IyIdZklBNor0WQhM8hev+rcfsgXpbahkcF8NEfnT5CVM3zskRmeLRH9uWkF/xFf7vOzDYATLTo+7iivdOXp33ALFx5nUyZUj4Yxd+OEw6noJzcO3k49G1cOeRhw87A==;
 5:+rWj7PvS6TSuLEfpuMSavmzza6L++g2u8ccjv1hYwo64PsBd2dKOPglT/9NBMTJlsoNUe9eEXJBRf4ZorZY67e8MAOrftQfTIlcFz551AKCsntpLneELifWdcVOKZzf4PrIQVSQ6PN9+lFYDK2Vo+OaYIL4TIfh0LrfW4trFIDY=;
 7:kXcZVUGfhS7OuFCbM26L+bHy3QHLbZfoXLuBTZ2charuvFFZQ2KAl1UJ2za+pp+rRnAvjceHWq53MBxcSEOGrMmP1m9hiEVuX7btLAPW3jRQPi8VI4KMtUNHi45zjOjtR0uJRM//JTVh2F3NauYtvg==
x-ms-office365-filtering-correlation-id: 9c30e9bf-2517-4fa3-0ab2-08d660977083
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4852; 
x-ms-traffictypediagnostic: AM0PR04MB4852:
x-microsoft-antispam-prvs: <AM0PR04MB485268930D8D01C44FADEDE780A00@AM0PR04MB4852.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB4852; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB4852; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(376002)(366004)(346002)(396003)(199004)(189003)(53936002)(186003)(2616005)(2501003)(11346002)(71200400001)(44832011)(476003)(5640700003)(6506007)(3846002)(52116002)(71190400001)(66066001)(486006)(7736002)(305945005)(6116002)(50226002)(6486002)(8936002)(81166006)(14454004)(68736007)(81156014)(6436002)(8676002)(256004)(316002)(36756003)(86362001)(25786009)(54906003)(6512007)(26005)(106356001)(6916009)(76176011)(446003)(478600001)(386003)(2351001)(97736004)(2906002)(102836004)(105586002)(5660300001)(4326008)(99286004)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4852;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wM61DERw8JgGwhIhv80WKYxZjWrH/VsSWsAWulL9/zXYBcM2/hsB5rwwjvvj+1GygV/VrI7gWHVC6fH7yVi95pdmgChVfPS5H7zpx2U3WbtybKrlPoE4y4kdBhwxYb04bmgEvWdvS+oyMVH0lgOgc1zs6wR2TwWiZewHjHqawCVGIcAzqUa7jHgIhlWnL5LCZXJSYJ4suD453WJmLezMA5jeCWa7G2rJGFPqD60Dfo2Da5StO8pLMz2Lwz4E5KJPxBI6TXk6pNpUhf4Qe2hWXpFXCI+ounVbDxOe3xCYP3gXviMQxDWjbDM8lmaleikQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c30e9bf-2517-4fa3-0ab2-08d660977083
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 01:08:06.6650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4852
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_170828_293727_8A857500 
X-CRM114-Status: GOOD (  15.74  )
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

The Low-Power Clock Gate (LPCG) modules contain a local programming
model to control the clock gates for the peripherals. An LPCG module
is used to locally gate the clocks for the associated peripheral.

Note:
This level of clock gating is provided after the clocks are generated
by the SCU resources and clock controls. Thus even if the clock is
enabled by these control bits, it might still not be running based
on the base resource.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v6->v10: no changes
---
 .../devicetree/bindings/clock/imx8qxp-lpcg.txt     |  51 +++++++
 include/dt-bindings/clock/imx8qxp-clock.h          | 153 +++++++++++++++++++++
 2 files changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt

diff --git a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
new file mode 100644
index 0000000..965cfa4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
@@ -0,0 +1,51 @@
+* NXP i.MX8QXP LPCG (Low-Power Clock Gating) Clock bindings
+
+The Low-Power Clock Gate (LPCG) modules contain a local programming
+model to control the clock gates for the peripherals. An LPCG module
+is used to locally gate the clocks for the associated peripheral.
+
+Note:
+This level of clock gating is provided after the clocks are generated
+by the SCU resources and clock controls. Thus even if the clock is
+enabled by these control bits, it might still not be running based
+on the base resource.
+
+Required properties:
+- compatible:	Should be one of:
+		  "fsl,imx8qxp-lpcg-adma",
+		  "fsl,imx8qxp-lpcg-conn",
+		  "fsl,imx8qxp-lpcg-dc",
+		  "fsl,imx8qxp-lpcg-dsp",
+		  "fsl,imx8qxp-lpcg-gpu",
+		  "fsl,imx8qxp-lpcg-hsio",
+		  "fsl,imx8qxp-lpcg-img",
+		  "fsl,imx8qxp-lpcg-lsio",
+		  "fsl,imx8qxp-lpcg-vpu"
+- reg:		Address and length of the register set
+- #clock-cells:	Should be <1>
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.
+See the full list of clock IDs from:
+include/dt-bindings/clock/imx8qxp-clock.h
+
+Examples:
+
+#include <dt-bindings/clock/imx8qxp-clock.h>
+
+conn_lpcg: clock-controller@5b200000 {
+	compatible = "fsl,imx8qxp-lpcg-conn";
+	reg = <0x5b200000 0xb0000>;
+	#clock-cells = <1>;
+};
+
+usdhc1: mmc@5b010000 {
+	compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+	interrupt-parent = <&gic>;
+	interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+	reg = <0x5b010000 0x10000>;
+	clocks = <&conn_lpcg IMX8QXP_CONN_LPCG_SDHC0_IPG_CLK>,
+		 <&conn_lpcg IMX8QXP_CONN_LPCG_SDHC0_PER_CLK>,
+		 <&conn_lpcg IMX8QXP_CONN_LPCG_SDHC0_HCLK>;
+	clock-names = "ipg", "per", "ahb";
+};
diff --git a/include/dt-bindings/clock/imx8qxp-clock.h b/include/dt-bindings/clock/imx8qxp-clock.h
index d72a39c..6fec368 100644
--- a/include/dt-bindings/clock/imx8qxp-clock.h
+++ b/include/dt-bindings/clock/imx8qxp-clock.h
@@ -133,4 +133,157 @@
 
 #define IMX8QXP_SCU_CLK_END				190
 
+/* LPCG clocks */
+
+/* LSIO SS LPCG */
+#define IMX8QXP_LSIO_LPCG_PWM0_IPG_CLK			0
+#define IMX8QXP_LSIO_LPCG_PWM0_IPG_S_CLK		1
+#define IMX8QXP_LSIO_LPCG_PWM0_IPG_HF_CLK		2
+#define IMX8QXP_LSIO_LPCG_PWM0_IPG_SLV_CLK		3
+#define IMX8QXP_LSIO_LPCG_PWM0_IPG_MSTR_CLK		4
+#define IMX8QXP_LSIO_LPCG_PWM1_IPG_CLK			5
+#define IMX8QXP_LSIO_LPCG_PWM1_IPG_S_CLK		6
+#define IMX8QXP_LSIO_LPCG_PWM1_IPG_HF_CLK		7
+#define IMX8QXP_LSIO_LPCG_PWM1_IPG_SLV_CLK		8
+#define IMX8QXP_LSIO_LPCG_PWM1_IPG_MSTR_CLK		9
+#define IMX8QXP_LSIO_LPCG_PWM2_IPG_CLK			10
+#define IMX8QXP_LSIO_LPCG_PWM2_IPG_S_CLK		11
+#define IMX8QXP_LSIO_LPCG_PWM2_IPG_HF_CLK		12
+#define IMX8QXP_LSIO_LPCG_PWM2_IPG_SLV_CLK		13
+#define IMX8QXP_LSIO_LPCG_PWM2_IPG_MSTR_CLK		14
+#define IMX8QXP_LSIO_LPCG_PWM3_IPG_CLK			15
+#define IMX8QXP_LSIO_LPCG_PWM3_IPG_S_CLK		16
+#define IMX8QXP_LSIO_LPCG_PWM3_IPG_HF_CLK		17
+#define IMX8QXP_LSIO_LPCG_PWM3_IPG_SLV_CLK		18
+#define IMX8QXP_LSIO_LPCG_PWM3_IPG_MSTR_CLK		19
+#define IMX8QXP_LSIO_LPCG_PWM4_IPG_CLK			20
+#define IMX8QXP_LSIO_LPCG_PWM4_IPG_S_CLK		21
+#define IMX8QXP_LSIO_LPCG_PWM4_IPG_HF_CLK		22
+#define IMX8QXP_LSIO_LPCG_PWM4_IPG_SLV_CLK		23
+#define IMX8QXP_LSIO_LPCG_PWM4_IPG_MSTR_CLK		24
+#define IMX8QXP_LSIO_LPCG_PWM5_IPG_CLK			25
+#define IMX8QXP_LSIO_LPCG_PWM5_IPG_S_CLK		26
+#define IMX8QXP_LSIO_LPCG_PWM5_IPG_HF_CLK		27
+#define IMX8QXP_LSIO_LPCG_PWM5_IPG_SLV_CLK		28
+#define IMX8QXP_LSIO_LPCG_PWM5_IPG_MSTR_CLK		29
+#define IMX8QXP_LSIO_LPCG_PWM6_IPG_CLK			30
+#define IMX8QXP_LSIO_LPCG_PWM6_IPG_S_CLK		31
+#define IMX8QXP_LSIO_LPCG_PWM6_IPG_HF_CLK		32
+#define IMX8QXP_LSIO_LPCG_PWM6_IPG_SLV_CLK		33
+#define IMX8QXP_LSIO_LPCG_PWM6_IPG_MSTR_CLK		34
+#define IMX8QXP_LSIO_LPCG_PWM7_IPG_CLK			35
+#define IMX8QXP_LSIO_LPCG_PWM7_IPG_S_CLK		36
+#define IMX8QXP_LSIO_LPCG_PWM7_IPG_HF_CLK		37
+#define IMX8QXP_LSIO_LPCG_PWM7_IPG_SLV_CLK		38
+#define IMX8QXP_LSIO_LPCG_PWM7_IPG_MSTR_CLK		39
+#define IMX8QXP_LSIO_LPCG_GPT0_IPG_CLK			40
+#define IMX8QXP_LSIO_LPCG_GPT0_IPG_S_CLK		41
+#define IMX8QXP_LSIO_LPCG_GPT0_IPG_HF_CLK		42
+#define IMX8QXP_LSIO_LPCG_GPT0_IPG_SLV_CLK		43
+#define IMX8QXP_LSIO_LPCG_GPT0_IPG_MSTR_CLK		44
+#define IMX8QXP_LSIO_LPCG_GPT1_IPG_CLK			45
+#define IMX8QXP_LSIO_LPCG_GPT1_IPG_S_CLK		46
+#define IMX8QXP_LSIO_LPCG_GPT1_IPG_HF_CLK		47
+#define IMX8QXP_LSIO_LPCG_GPT1_IPG_SLV_CLK		48
+#define IMX8QXP_LSIO_LPCG_GPT1_IPG_MSTR_CLK		49
+#define IMX8QXP_LSIO_LPCG_GPT2_IPG_CLK			50
+#define IMX8QXP_LSIO_LPCG_GPT2_IPG_S_CLK		51
+#define IMX8QXP_LSIO_LPCG_GPT2_IPG_HF_CLK		52
+#define IMX8QXP_LSIO_LPCG_GPT2_IPG_SLV_CLK		53
+#define IMX8QXP_LSIO_LPCG_GPT2_IPG_MSTR_CLK		54
+#define IMX8QXP_LSIO_LPCG_GPT3_IPG_CLK			55
+#define IMX8QXP_LSIO_LPCG_GPT3_IPG_S_CLK		56
+#define IMX8QXP_LSIO_LPCG_GPT3_IPG_HF_CLK		57
+#define IMX8QXP_LSIO_LPCG_GPT3_IPG_SLV_CLK		58
+#define IMX8QXP_LSIO_LPCG_GPT3_IPG_MSTR_CLK		59
+#define IMX8QXP_LSIO_LPCG_GPT4_IPG_CLK			60
+#define IMX8QXP_LSIO_LPCG_GPT4_IPG_S_CLK		61
+#define IMX8QXP_LSIO_LPCG_GPT4_IPG_HF_CLK		62
+#define IMX8QXP_LSIO_LPCG_GPT4_IPG_SLV_CLK		63
+#define IMX8QXP_LSIO_LPCG_GPT4_IPG_MSTR_CLK		64
+#define IMX8QXP_LSIO_LPCG_FSPI0_HCLK			65
+#define IMX8QXP_LSIO_LPCG_FSPI0_IPG_CLK			66
+#define IMX8QXP_LSIO_LPCG_FSPI0_IPG_S_CLK		67
+#define IMX8QXP_LSIO_LPCG_FSPI0_IPG_SFCK		68
+#define IMX8QXP_LSIO_LPCG_FSPI1_HCLK			69
+#define IMX8QXP_LSIO_LPCG_FSPI1_IPG_CLK			70
+#define IMX8QXP_LSIO_LPCG_FSPI1_IPG_S_CLK		71
+#define IMX8QXP_LSIO_LPCG_FSPI1_IPG_SFCK		72
+
+#define IMX8QXP_LSIO_LPCG_CLK_END			73
+
+/* Connectivity SS LPCG */
+#define IMX8QXP_CONN_LPCG_SDHC0_IPG_CLK			0
+#define IMX8QXP_CONN_LPCG_SDHC0_PER_CLK			1
+#define IMX8QXP_CONN_LPCG_SDHC0_HCLK			2
+#define IMX8QXP_CONN_LPCG_SDHC1_IPG_CLK			3
+#define IMX8QXP_CONN_LPCG_SDHC1_PER_CLK			4
+#define IMX8QXP_CONN_LPCG_SDHC1_HCLK			5
+#define IMX8QXP_CONN_LPCG_SDHC2_IPG_CLK			6
+#define IMX8QXP_CONN_LPCG_SDHC2_PER_CLK			7
+#define IMX8QXP_CONN_LPCG_SDHC2_HCLK			8
+#define IMX8QXP_CONN_LPCG_GPMI_APB_CLK			9
+#define IMX8QXP_CONN_LPCG_GPMI_BCH_APB_CLK		10
+#define IMX8QXP_CONN_LPCG_GPMI_BCH_IO_CLK		11
+#define IMX8QXP_CONN_LPCG_GPMI_BCH_CLK			12
+#define IMX8QXP_CONN_LPCG_APBHDMA_CLK			13
+#define IMX8QXP_CONN_LPCG_ENET0_ROOT_CLK		14
+#define IMX8QXP_CONN_LPCG_ENET0_TX_CLK			15
+#define IMX8QXP_CONN_LPCG_ENET0_AHB_CLK			16
+#define IMX8QXP_CONN_LPCG_ENET0_IPG_S_CLK		17
+#define IMX8QXP_CONN_LPCG_ENET0_IPG_CLK			18
+
+#define IMX8QXP_CONN_LPCG_ENET1_ROOT_CLK		19
+#define IMX8QXP_CONN_LPCG_ENET1_TX_CLK			20
+#define IMX8QXP_CONN_LPCG_ENET1_AHB_CLK			21
+#define IMX8QXP_CONN_LPCG_ENET1_IPG_S_CLK		22
+#define IMX8QXP_CONN_LPCG_ENET1_IPG_CLK			23
+
+#define IMX8QXP_CONN_LPCG_CLK_END			24
+
+/* ADMA SS LPCG */
+#define IMX8QXP_ADMA_LPCG_UART0_IPG_CLK			0
+#define IMX8QXP_ADMA_LPCG_UART0_BAUD_CLK		1
+#define IMX8QXP_ADMA_LPCG_UART1_IPG_CLK			2
+#define IMX8QXP_ADMA_LPCG_UART1_BAUD_CLK		3
+#define IMX8QXP_ADMA_LPCG_UART2_IPG_CLK			4
+#define IMX8QXP_ADMA_LPCG_UART2_BAUD_CLK		5
+#define IMX8QXP_ADMA_LPCG_UART3_IPG_CLK			6
+#define IMX8QXP_ADMA_LPCG_UART3_BAUD_CLK		7
+#define IMX8QXP_ADMA_LPCG_SPI0_IPG_CLK			8
+#define IMX8QXP_ADMA_LPCG_SPI1_IPG_CLK			9
+#define IMX8QXP_ADMA_LPCG_SPI2_IPG_CLK			10
+#define IMX8QXP_ADMA_LPCG_SPI3_IPG_CLK			11
+#define IMX8QXP_ADMA_LPCG_SPI0_CLK			12
+#define IMX8QXP_ADMA_LPCG_SPI1_CLK			13
+#define IMX8QXP_ADMA_LPCG_SPI2_CLK			14
+#define IMX8QXP_ADMA_LPCG_SPI3_CLK			15
+#define IMX8QXP_ADMA_LPCG_CAN0_IPG_CLK			16
+#define IMX8QXP_ADMA_LPCG_CAN0_IPG_PE_CLK		17
+#define IMX8QXP_ADMA_LPCG_CAN0_IPG_CHI_CLK		18
+#define IMX8QXP_ADMA_LPCG_CAN1_IPG_CLK			19
+#define IMX8QXP_ADMA_LPCG_CAN1_IPG_PE_CLK		20
+#define IMX8QXP_ADMA_LPCG_CAN1_IPG_CHI_CLK		21
+#define IMX8QXP_ADMA_LPCG_CAN2_IPG_CLK			22
+#define IMX8QXP_ADMA_LPCG_CAN2_IPG_PE_CLK		23
+#define IMX8QXP_ADMA_LPCG_CAN2_IPG_CHI_CLK		24
+#define IMX8QXP_ADMA_LPCG_I2C0_CLK			25
+#define IMX8QXP_ADMA_LPCG_I2C1_CLK			26
+#define IMX8QXP_ADMA_LPCG_I2C2_CLK			27
+#define IMX8QXP_ADMA_LPCG_I2C3_CLK			28
+#define IMX8QXP_ADMA_LPCG_I2C0_IPG_CLK			29
+#define IMX8QXP_ADMA_LPCG_I2C1_IPG_CLK			30
+#define IMX8QXP_ADMA_LPCG_I2C2_IPG_CLK			31
+#define IMX8QXP_ADMA_LPCG_I2C3_IPG_CLK			32
+#define IMX8QXP_ADMA_LPCG_FTM0_CLK			33
+#define IMX8QXP_ADMA_LPCG_FTM1_CLK			34
+#define IMX8QXP_ADMA_LPCG_FTM0_IPG_CLK			35
+#define IMX8QXP_ADMA_LPCG_FTM1_IPG_CLK			36
+#define IMX8QXP_ADMA_LPCG_PWM_HI_CLK			37
+#define IMX8QXP_ADMA_LPCG_PWM_IPG_CLK			38
+#define IMX8QXP_ADMA_LPCG_LCD_PIX_CLK			39
+#define IMX8QXP_ADMA_LPCG_LCD_APB_CLK			40
+
+#define IMX8QXP_ADMA_LPCG_CLK_END			41
+
 #endif /* __DT_BINDINGS_CLOCK_IMX8QXP_H */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
