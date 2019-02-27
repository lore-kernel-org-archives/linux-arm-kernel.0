Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C5AC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:28:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936512063F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="riApCdbi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dRV539de"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936512063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fPtVLI8poaC4d0sH4Cwv8cDzhSoXnHbYmHy8I9b/e+I=; b=riApCdbiNgytpZ
	0DYmZn6qW+zsAHy+lgb5q1LFQUorthuKgTJpZi7ZvmYXL8tNTkV6OkhaLrEcWuX6rL1SC6Z3pm6kY
	YM2vCanKsFaiPzC712sw5cfSQfRCfjvxm20MYEi6FVFnBDtExQIMA3XOkrX7DZjeyOaldNOwSlAIm
	3gKmHovs9CzbDRMkW+DXqf7iAvu6qiYtVA0GPWDImXYnpwY4G+RjvtlBtOfvejM5xg75xEbZkQjjk
	47aBtdVOinKhZPS573Njn0FKM0pSJQX27yiPtgoBfDZAZS1vFGe4pODsUwA7lsI+2bHYxD2CO/xke
	K8k8I/2aQSK0rtgp6LTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyo1k-00070B-Po; Wed, 27 Feb 2019 01:28:52 +0000
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyo1T-0006ix-VF
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 01:28:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8GONokrkJCRgf8LCK3dcw7tj2Jq8z0psqkXyRB6WyI=;
 b=dRV539de3GU+DVd+BWfCztLThFXLeR1SY5d8MUbrL21Y9pDO6qVcil66xnNB+6nmLkdLFB/MaTpU/VMfzctzHLFt9vr/m330Nn0ugH97OPxWBUo39jxvwjj4odBvzR3tCbxwPcnlvbrBAWWKYUaTyL+UnagqRNt5UwuDMC4dBqs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3772.eurprd04.prod.outlook.com (52.134.71.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Wed, 27 Feb 2019 01:28:32 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 01:28:32 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
 <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>, "l.stach@pengutronix.de"
 <l.stach@pengutronix.de>, "agx@sigxcpu.org" <agx@sigxcpu.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: [PATCH RESEND V2 2/2] arm64: dts: freescale: imx8mq: add clock for
 GPIO node
Thread-Topic: [PATCH RESEND V2 2/2] arm64: dts: freescale: imx8mq: add clock
 for GPIO node
Thread-Index: AQHUzjvA03UnUztuhEWJOxcKYzcX0A==
Date: Wed, 27 Feb 2019 01:28:32 +0000
Message-ID: <1551230622-30660-2-git-send-email-Anson.Huang@nxp.com>
References: <1551230622-30660-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551230622-30660-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0022.apcprd04.prod.outlook.com
 (2603:1096:203:36::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a618193d-8913-45b0-2f84-08d69c52e276
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3772; 
x-ms-traffictypediagnostic: DB3PR0402MB3772:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3772;
 23:MBgGiqq1xgtbyZdafhGxGAadsiGwYYXXAMPdK?=
 =?iso-8859-1?Q?1yNTjb2glrpwKHJ3r69HYpxEiO3KXFlGoTZsTIkZyY3x+pCwrvcYiCOsT8?=
 =?iso-8859-1?Q?o496/fJZm89uKIr6xiHwSYjdLOI7MTuJwiUVu20o1CSl+k/dCDmOIF3xxb?=
 =?iso-8859-1?Q?DfXAIkw3ipM3K94NZoWuxm9EPptkSgEQozcrCH00eZMUx++zXoZ30B6eFf?=
 =?iso-8859-1?Q?XPIw+kMTAOGsx2dcIUurzmfzlAjIpBWbWLRqpsz+btMkZ+5gykP+jbaCC+?=
 =?iso-8859-1?Q?4ghiIcT/oxjRtanmCAmgrbymLlD2/PmCn43M/n/P4zpXXZ8ie0X6I448nK?=
 =?iso-8859-1?Q?taDIWECu7GPPiGfevBX+sWL+UVzJ90e+cnwBZYS0dD1YmrL2KwwuQMJvKg?=
 =?iso-8859-1?Q?mSb82OvU3LRLZNnkv4Nni6MBUP5LVBIBxbR7sOJGkki9F5+pRKWXCpxCN/?=
 =?iso-8859-1?Q?1cjVChmSlzpAFpkLrRTy2yagVrZX6+f19Wdt7nkZs7/ZF8+Vetbtwdqsd5?=
 =?iso-8859-1?Q?soLy9eMHOjapV0eXPc3lkss3iwp1dyhqEIIm6f3JPKhZhxAkWBGGMGgIKG?=
 =?iso-8859-1?Q?RHY7tUY1Qwd93gOvVLxFTF6AUwQUpCHXfUDkL9K+OtEiuhAr+G1Nr+xDCe?=
 =?iso-8859-1?Q?K7Cobk2dX0mgf+6pZuqBq35z9isMpFomtGgTKjsc6rjGkOXbzps0rLfexS?=
 =?iso-8859-1?Q?47kKIDao+hzBMwxvjNQHMUdKdK65Bg1hMyKH/46HGGJOUgiBbX5C48oTtn?=
 =?iso-8859-1?Q?p7+GS02+cvQX23Q6FqPRKZvy/IHNETeN9/S4I2rmR1aj6U/tGfNk570tb3?=
 =?iso-8859-1?Q?4Fok+z5abROMSrr5HKlnRa0Btyij4j8vpV9icyQ30pCwNZV6nuVBLoGUwU?=
 =?iso-8859-1?Q?A7K+sKXsWiKL2NiPc3q17pLSEoLgpD7Uaug57kPVnPRSz1K6XYsfiEHnI6?=
 =?iso-8859-1?Q?IEHF0sIqDsREdcBI542ZBSr+QQBlJRVlPw7cVLPzMPW+lseFTf7vvpkEG7?=
 =?iso-8859-1?Q?FbllocAXTBmGRSj7wAF97eLkykmL5TKgF+CCdjtwK8vGEmyB8z58xv2l2P?=
 =?iso-8859-1?Q?OOHJTTq9uxhNbiY7Vp8OrE/8ljGIEcFhmt5shPeLWG7VQ8Iw4NBeRmgOFg?=
 =?iso-8859-1?Q?oy9aU9H/sVxuGzwzbwdltm7rfH47JvXRgtzgeSpaR5yIKkPygq6a7aJQ6n?=
 =?iso-8859-1?Q?NBrRdVJs8Zb2RWrSBZfCOlttWJ9uHPbEz7NSjbEacjI9CZ28N6Ro2eoSzL?=
 =?iso-8859-1?Q?RlFBnWDruIJ7SSsYst2JAGENLPIvHbFxdb9Y9yeefjysCQ8y/4vr6pntWv?=
 =?iso-8859-1?Q?3reCD5hQgp+a1zfiIMwdQqo+L+8WOsnWdDY3GptlOgUoZVw=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB37728FEE31231A9A58CCDEEFF5740@DB3PR0402MB3772.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(396003)(366004)(136003)(39860400002)(199004)(189003)(6486002)(3846002)(6436002)(386003)(6116002)(7416002)(316002)(71200400001)(71190400001)(256004)(186003)(6506007)(478600001)(99286004)(6346003)(102836004)(5660300002)(53936002)(50226002)(6512007)(7736002)(305945005)(81166006)(14454004)(26005)(81156014)(8936002)(8676002)(486006)(446003)(2616005)(4326008)(76176011)(68736007)(66066001)(25786009)(11346002)(2906002)(105586002)(52116002)(110136005)(97736004)(2501003)(36756003)(2201001)(476003)(86362001)(106356001)(921003)(32563001)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3772;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t3BohuJy6xMx/3XdCM/QkyQyLx9R6Dn+Yww6jqKi6w4tqFNE7XCtnx3aT5pGppoAs3plMjQEb0pwBo2SkKAbnuY0bTI7AlUD/zJ+xchcY6LKoXnkZ3eNCEkhQ1akA8nuawcNcJoJLpeTVftqPG2zsl/gQaAK4i8ai+89vJVyHP+0+FUTVBw0tBhYho/pwaeMoK2uV8KC4NO+EDTIcd8jrfQdDAtp36G56MPmcjchNGjPM0C0kc8t8OhIDsWtoXZnT7HpyfJfyfkey0yK4JLC9/KIiKADDVTlodGXMM2rwdqOlYuOdfUSyv01Bj1nyRYc9yjzWQh4f1E0MD//D4eaoMN6iRQQW6cAoiJ6CFId/XcxlVJKeHRIFU0b8S3og8NvbTjWUzzYgJYFCFbz5oEKkGAjmbxXRr2fX0QHj65cDw8=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a618193d-8913-45b0-2f84-08d69c52e276
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 01:28:27.2407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3772
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_172836_270049_6B871D4D 
X-CRM114-Status: UNSURE (   9.88  )
X-CRM114-Notice: Please train this message.
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

i.MX8MQ has clock gate for each GPIO bank, add clock info
to GPIO node for clock management.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 8e9d6d5..6be8849 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -149,6 +149,7 @@
 				reg = <0x30200000 0x10000>;
 				interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
 				             <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_GPIO1_ROOT>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -160,6 +161,7 @@
 				reg = <0x30210000 0x10000>;
 				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
 				             <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_GPIO2_ROOT>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -171,6 +173,7 @@
 				reg = <0x30220000 0x10000>;
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
 				             <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_GPIO3_ROOT>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -182,6 +185,7 @@
 				reg = <0x30230000 0x10000>;
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
 				             <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_GPIO4_ROOT>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
@@ -193,6 +197,7 @@
 				reg = <0x30240000 0x10000>;
 				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
 				             <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_GPIO5_ROOT>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				interrupt-controller;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
