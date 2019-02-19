Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E134C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:11:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C9A321773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kk/2UkHq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E73pH/4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9A321773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vLpkxUdJJIdVkGkWwSGIzApmK0P58CG+ABGnZDwWJ2Y=; b=Kk/2UkHq0Lcf+d
	z/tfhKW7OXIsjSGos5H3GVLp3MHw8Zbywt3iK4k5VxuAw8SOQf7D3nTDHKsGGWjbxdeUNugtXj7WL
	8t0J5Ka9OxkLp7AtZkFXBk5jTv2Y3Cm18XZ1jaiNuMdNAPR+1XfZvvH6JF/xBrDUSTdtJ1jrhjAXE
	ru+xgu3wE8ihdFyZR1HpulW+6QAvyN4LQ7ksomC4Kzcly7mQ6JbTL4PaIEfCJy2zekLA9AfM88yDr
	OScMAkpAgAlfD4rxGGui0kPsANpSeqk8kQweOrxI1pesfJdjUFcxHGqoEoLQk76RkyvmneyGn/YyY
	P99W6BwmrR+0KBpLpEow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvvoU-0003P4-HX; Tue, 19 Feb 2019 03:11:18 +0000
Received: from mail-eopbgr130054.outbound.protection.outlook.com
 ([40.107.13.54] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvvoD-00034u-4Z
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 03:11:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HtWs4sYrw4s7Ertu8GDGz/JJAC3zxW45so3JQv+dlw=;
 b=E73pH/4UO+pwcJUq4YWagod675SykDMrsBgEiSDA8/3YaOxmFJaqWdS/XIBW3Rn5D9p2ZlCuKYjEkFRgrj+Jd2ovbpBCPsg90QbynaHEh6tR5eD4YY/7C4kiEdXX1IgavOppogjiRo4L+df84OErATV9YvVvN2H+H9Aw0Nivz0A=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 19 Feb 2019 03:10:57 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Tue, 19 Feb 2019
 03:10:57 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 "a.zummo@towertech.it" <a.zummo@towertech.it>,
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, Aisheng Dong
 <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-rtc@vger.kernel.org"
 <linux-rtc@vger.kernel.org>
Subject: [PATCH V3 3/4] arm64: dts: freescale: imx8qxp: enable scu general irq
 channel
Thread-Topic: [PATCH V3 3/4] arm64: dts: freescale: imx8qxp: enable scu
 general irq channel
Thread-Index: AQHUyAC7+97rhJSSv0mLmWl8Z1nJYQ==
Date: Tue, 19 Feb 2019 03:10:56 +0000
Message-ID: <1550545569-7197-3-git-send-email-Anson.Huang@nxp.com>
References: <1550545569-7197-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550545569-7197-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0186.apcprd02.prod.outlook.com
 (2603:1096:201:21::22) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfe2c08b-ad3e-4c4f-3308-08d69617dd8f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3916; 
x-ms-traffictypediagnostic: DB3PR0402MB3916:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3916;
 23:pmlKZ9mUlKHUiP8/8azLJjz2q3EysQkGLSh/Y?=
 =?iso-8859-1?Q?QA2tDo0jnrlGCbN0TCIOny1MY6TVYHdOCQJMEMtZyq4oYJLnzxFS4tz8mz?=
 =?iso-8859-1?Q?zwhlMTjrjKQ7Z2HituiSyNdIYZh3v1G/wPqxmtftuOx/80GfIXBZHVKRme?=
 =?iso-8859-1?Q?c8X+rSBSIA7VoHJiHbCk11XwMpzg+Z1gKU8nHXvhYtp6fHz4d/H2yi3uVT?=
 =?iso-8859-1?Q?trPnMYUbxTxJV8uWaIeM4jhp609qak3Ngs4PHKFWGaEOYqpCFhYHPdTEwt?=
 =?iso-8859-1?Q?n+fwFPPr0grUdkHXHFVdBddv/UbWFU2WCeu1tRqiiBqAX7Us+4RAfubaqs?=
 =?iso-8859-1?Q?3IqqDpjG452GMkR8b+UjgI/620nJ8jDMSvjEPhRCbNnJP/T1gm/kVguA/X?=
 =?iso-8859-1?Q?vYqaAcf6CNa8Vv3dLZoyip5FC3CZpTgd/VJBLod6xhkQ8pwRmZFNw+3MkV?=
 =?iso-8859-1?Q?+CPmFwClxOWy5HlvvhdKT8qP29q/P0uXG5JMVGwvhabYXYT2Mt4lA8y8Go?=
 =?iso-8859-1?Q?iv8j3vWZqyiv53rCKv56vcljjcNRw+Ab5ghDNUS3URlPwrOVSHoTSThgkS?=
 =?iso-8859-1?Q?92lDN+fujAeE7mXMflxHeI/h2HH2TquNTsK6flcqyTiJPg5Vn5+aTeMCG/?=
 =?iso-8859-1?Q?IrPgjPGd5P+6JA3kicZDTghal5+DgotYNMW3zTLRC8OX6qNG0pLbNbNG+w?=
 =?iso-8859-1?Q?MKi2wafIwgu6DajlBDgzzGqKsFH3U7ZSU9e4Vf8xMu0IK6PGKbWXrLIidX?=
 =?iso-8859-1?Q?zfu5d+XQcusByuV/0joEoaoKuxgriSDglAUvzwXxu4GigbbcF+lbWxQVT5?=
 =?iso-8859-1?Q?YIw3d9rPdzxL9K7qgNxiiccMf4Ws6I57Ma4QuwFPp8q9bxTlGDAnWw5D90?=
 =?iso-8859-1?Q?EUMqYxJ5Uvjg01FkhaZbtS+IX9I/ggBNaVwoIUBqZuLKqn93fLtLPI7G6j?=
 =?iso-8859-1?Q?iJyw4jXynD/gjiutJxkzlXUy+ImAhhpxJqconWhx5MIGK/HM9z2WS+jZOh?=
 =?iso-8859-1?Q?hrGRCNrD6VZjjpf6x9DnplZw+GtOpKqK9TplJsNAUIO6iQDekVv3/MXJbP?=
 =?iso-8859-1?Q?XUwJ0SZkMxl64DJaoRQBTIAkcaDu7f/yZE8Qy5gPVkT8PVCNaEb7JAp4zV?=
 =?iso-8859-1?Q?vIKvyqrFLkKh+yZUrXgFHDaNQBwFNmnYEvn0SDPTpo8HbrVoHc68BEIz/h?=
 =?iso-8859-1?Q?7Fm9A57DW1tZzRh10WWlXv9momCVm+jkEOSvxXTBl41jp6xhNfsgroiNQT?=
 =?iso-8859-1?Q?HV3ZJfTlg7w8iODG1qwjSqNu/JogeVjg4mCom2TE0r/nom7BY33K8OC0yY?=
 =?iso-8859-1?Q?Rj9uVc49AVe/2ljh4U+kKeFchpQMMtP+u+25QkNejf0/srfaFsnUee4kga?=
 =?iso-8859-1?Q?XXML2RKwso=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB39167A442B2E848255950B95F57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(39850400004)(376002)(346002)(366004)(189003)(199004)(26005)(6512007)(25786009)(68736007)(256004)(6346003)(478600001)(486006)(3846002)(6116002)(6436002)(7416002)(2616005)(4744005)(186003)(14454004)(446003)(11346002)(476003)(6486002)(4326008)(52116002)(316002)(8936002)(81166006)(50226002)(76176011)(99286004)(7736002)(81156014)(53936002)(305945005)(110136005)(8676002)(2906002)(86362001)(102836004)(105586002)(2501003)(2201001)(386003)(6506007)(71190400001)(71200400001)(97736004)(106356001)(36756003)(66066001)(5660300002)(32563001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3916;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RgEFGQfr09s+QV3qd9pOZSQVA+FiWwwZVJcuTjis9FnNfhv2aWXWGkj7l3ekBjGHBjaKSgDfYxmgePdOGE7eChveeVzYsI5OVOnl/zmJmeHfSyxJhZ80tqAQNUqcDiMZSE76eI3758TswOo4mA88bjFhAwsun4MgAKy50/r3LDCufP2VmldS33l14rzebDhxn7r3Ok+UVkWdHSy/1dGHOlucBj7ZQKR98zfxyrqyYXh9qMdObefSoZJtDtk6sPwXpSgZti9YYEKFEnFkK4UOL+0xrUEO2hCvJK8AJbXqZDdxPW1MRDAGSbijQq05FMh4JIKeididOWIL+7Ttr8vn48r3kpOOOLvjvh8/EmAMSnQj79M8YfBDtjtOwLCmmsaHxpe48lOvGLiVkyWfRu+el7GGziSkWH1Klvoo+WGyzdU=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe2c08b-ad3e-4c4f-3308-08d69617dd8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 03:10:49.2706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_191101_190051_7B6108D9 
X-CRM114-Status: GOOD (  11.21  )
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

On i.MX8QXP, SCU uses MU1 general interrupt channel #3 to notify
user for IRQs of RTC alarm, thermal alarm and WDOG etc., mailbox
RX doorbell mode is used for this function, this patch adds
support for it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change since V2.
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index bfb77a5..a95a3a3 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -88,7 +88,8 @@
 	scu {
 		compatible = "fsl,imx-scu";
 		mbox-names = "tx0", "tx1", "tx2", "tx3",
-			     "rx0", "rx1", "rx2", "rx3";
+			     "rx0", "rx1", "rx2", "rx3",
+			     "gi3";
 		mboxes = <&lsio_mu1 0 0
 			  &lsio_mu1 0 1
 			  &lsio_mu1 0 2
@@ -96,7 +97,8 @@
 			  &lsio_mu1 1 0
 			  &lsio_mu1 1 1
 			  &lsio_mu1 1 2
-			  &lsio_mu1 1 3>;
+			  &lsio_mu1 1 3
+			  &lsio_mu1 3 3>;
 
 		clk: clock-controller {
 			compatible = "fsl,imx8qxp-clk";
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
