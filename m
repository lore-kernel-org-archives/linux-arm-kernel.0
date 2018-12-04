Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1ABC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:40:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1CDE20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bZoY2Lfx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OMDOwBdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CDE20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cqTnq8MDBeKYt+15IwfCyPF4y0fl+7lmhSZE1FKwthg=; b=bZoY2LfxN0i+2j
	rs4s7H3VN7/uRqjB+e4kYsQE+ts/9XMa7iwTrZaaWNeoUwVC5F9wME/AUXJeZ678kSKb1Y4h2/79o
	u6PAxY0C7JPO/bX5POgRTC1a3FAST+c+jFFoyrZvTq6vugRC88sSgOuxop447Xxk9jNA7iidLAfYB
	z9iUhCDnfa0dibEObk/tFYGFU1s/qeaa+lPyh2O2rgkzqjuK+XooyxEu20cNMTlWdM/Wfk7gqh8a9
	T8Q+Fb6d0uUcIqMC06sruWZGXYPWvADXAzxy82DbePS6ZEMDhbYQ1AqYAw/SOcm6uRYDafhYNnZJa
	BLhYc1Y9kA7JjLth9n6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBsP-00058D-A2; Tue, 04 Dec 2018 14:40:41 +0000
Received: from mail-eopbgr10081.outbound.protection.outlook.com ([40.107.1.81]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBrR-0002oB-Cm
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:39:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQGMfSpfOP/mURDBpCdniOSA16TnPTWNqcJq8BTPnwg=;
 b=OMDOwBdvJJgWxiWxkM969C+vxLUSnGwmBDjC2g23OAUh5DhIUi7t1PYIkdgL+AAMPG7cvLd7D8+WADLPydjlbsI3zN1RV4/Q985aY+hb62FPaVwUC0LR8aMckYlV/KkkA4S1m4z+QTpWMluRRLChoobQsr4Eiujy/VbH+CPs9dk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5763.eurprd04.prod.outlook.com (20.178.202.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Tue, 4 Dec 2018 14:39:37 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1382.023; Tue, 4 Dec 2018
 14:39:37 +0000
From: Aisheng DONG <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: [PATCH V9 5/7] dt-bindings: clock: add imx8qxp lpcg clock binding
Thread-Topic: [PATCH V9 5/7] dt-bindings: clock: add imx8qxp lpcg clock binding
Thread-Index: AQHUi98uDPLg0+kS8EGQTi/fnmGubA==
Date: Tue, 4 Dec 2018 14:39:37 +0000
Message-ID: <1543934041-12572-6-git-send-email-aisheng.dong@nxp.com>
References: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::27) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5763;
 6:5+mhSzeQXqYStauiG1JkYvZdtDeU77ldmKW/+qGCxLTVxAsvQVbTacwAd4QrElkeLLA8DqVYLuAEzL9jqlbxXNeEpfITl6draeFKloUaJtq/P5xdPX2HpWf2f5ichN4a4J6MrbnAauVXFUD3mCfkWVlk/yer7nsLyvPy4eRHXCnSv57VcI/Z5d6EDaI0e43iDWdy1ZCGfSJPu1iidLyFJUE7YR7ciDCLUG55AEeyiHFgDU9LxVeS15/pX8LwW+CVyypoNm/nopMbuQ5Ap3EchiTHmaJ2c21xU1k+oG5/mcYA+ezstdcrNJ9mFk6sBFavgaLIrBAD52m0F44LTf+TFnoDrQiv+CdK/hi4oowzifmMPEF7n3E9rWpWo+1gvKSLmJKD3RHTeqfUUlkEnJj96a9spuda6+Pyt+H4+JIXdW5/AFjzASBjtFXgQW6bqGALv4SKwtyESArserFv7MS3tA==;
 5:3Ew6CcCxbDu3PRcVjtqpkTYuhAmqoTPTlWVYlga7FeVHOlUQSHA6Wwrf7bJhDNKn/SJleH7nzmUqcFXtFVMyalw0yqIKMG1CAQqkcEdauBy1onj3AJVY2qxc+47wnA0eUdtyQhXFbdyt24upbSyejg30ia+XL45H9mpYvFEme8g=;
 7:sew9wXCgAPQkHBMW0BDLe5ClbLD3zediZkzkkWPJKevhnOwG9qdmDQDovcOx6IG/qPNfB6mLLOdo+HHLTP1F1qQefGqMWUXCFHHPJg+oXRbfn+4yVBWvqbEddX+TbITm3Teb3QLttvpBglD6XTbavw==
x-ms-office365-filtering-correlation-id: c89b675b-762b-4402-fe0e-08d659f650e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5763; 
x-ms-traffictypediagnostic: AM0PR04MB5763:
x-microsoft-antispam-prvs: <AM0PR04MB576305E886F4E2E3C524690C80AF0@AM0PR04MB5763.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(944501493)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5763; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5763; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(136003)(396003)(346002)(39860400002)(189003)(199004)(305945005)(386003)(102836004)(25786009)(97736004)(52116002)(186003)(36756003)(76176011)(478600001)(256004)(6116002)(2501003)(8936002)(86362001)(26005)(81166006)(3846002)(6506007)(8676002)(81156014)(4326008)(50226002)(316002)(486006)(53936002)(2616005)(476003)(106356001)(99286004)(2906002)(5660300001)(6512007)(7736002)(11346002)(6486002)(446003)(6436002)(2351001)(6916009)(68736007)(105586002)(14454004)(54906003)(5640700003)(66066001)(71200400001)(71190400001)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5763;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xC4WddgqUa2n79zWgOHqDYmvEzKUA9GsdgNgj+DVI/VOkBY8XFp9OvuJVo0aB/6L5i474DXNEQ3GO75+tPtWmaxSxz3uqlXZPLc85uV9G93ruMhn9cIaHAVznYGtm43+vX5A2tPnZ+4xsAyHQpKDwPEPtmY36eGjYUTvny9LQmuWuD49pZR+kfYmS1C4CegC2Bl37VZmSCdGckWyK+nY37x2xDY7u1guqHf9z9vmaug71DL1qJTWb88DNA37gI0Pr+C90hT5m577KL4stHlPpc2p7RmQZviIXvXIT6Z5HeXGxDIiVjHi0RQG0yUDjq5v2GzhPbDt7atW42DjnGK2shUy/r0/KWuq446xTvJwilg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89b675b-762b-4402-fe0e-08d659f650e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 14:39:37.6585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5763
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_063941_921231_D38DA294 
X-CRM114-Status: GOOD (  15.99  )
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
Cc: Aisheng DONG <aisheng.dong@nxp.com>,
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
