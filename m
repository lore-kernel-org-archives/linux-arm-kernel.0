Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0E4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:26:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B64BF2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oeQPU6cC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MaY+tEB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64BF2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gaSo0A/rlhU2Os5eBBazXgWm56JBlTqF/AdJduUW2LI=; b=oeQPU6cC6Fvs81
	rfNoAXRXSbGSlUyH3JxFf6gsIGnZUIDJwuNTXzitLNpkLKSq05g4wIXu+MnuyDFZFdDeIMt9vN3iy
	jykfmkwJyRQJm+kJBzSpp7UKADmHzl++YEpfgCnhxuGRMUAaXGVB6yDJaBMhZ758Q1qzPHO5JwtOo
	t2hO+6LJOrFvqZrtawsOcT1vAIcETZgMqdvCD0i19xFFFSJ4e/cSa7Y8IBh5ota7JhY+FZ464mh0m
	b1VsNiM4PIU8VEtJCz3e58mWkDBq0OErg2eVLkQNHwLla6a5t0isl0HXpXzPdZCPg3HOj7zKiz39U
	BMfQPrVVH4xka4gkd5OA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcinS-0007Rl-4W; Fri, 28 Dec 2018 03:26:50 +0000
Received: from mail-eopbgr60079.outbound.protection.outlook.com ([40.107.6.79]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcin3-00071s-91
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 03:26:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WKMJDJ4zFL73UxJ9B4P6uMjXe9wcqTVkB4b8CIT4H8=;
 b=MaY+tEB4DnEOTz02QM3B1255AslYnXM5pbIFOkxKN1OH6YVoqi6bUmr6WK4jpBgu7ho+B+WEHcduyknfTO7uEE4zZaResTAGY8y34+glhY3nr65Fxv7umAgXz+Nds/RGuR8hHQ3OVLJmHEjS4m+GSWnjiJTe39I4i8evtA4Z2MI=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.50.97) by
 VI1PR04MB6047.eurprd04.prod.outlook.com (20.179.24.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Fri, 28 Dec 2018 03:26:16 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::cd3d:ce97:132b:7148]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::cd3d:ce97:132b:7148%3]) with mapi id 15.20.1471.019; Fri, 28 Dec 2018
 03:26:16 +0000
From: BOUGH CHEN <haibo.chen@nxp.com>
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v2 3/3] ARM: dts: imx6ull: change to use new compatible
 "fsl,imx6ull-usdhc" for usdhc
Thread-Topic: [PATCH v2 3/3] ARM: dts: imx6ull: change to use new compatible
 "fsl,imx6ull-usdhc" for usdhc
Thread-Index: AQHUnl0XSZn1LiPUw0Ku0PNeBt+ZMQ==
Date: Fri, 28 Dec 2018 03:26:16 +0000
Message-ID: <20181228033323.32308-3-haibo.chen@nxp.com>
References: <20181228033323.32308-1-haibo.chen@nxp.com>
In-Reply-To: <20181228033323.32308-1-haibo.chen@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To VI1PR04MB5040.eurprd04.prod.outlook.com
 (2603:10a6:803:59::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB6047;
 6:q+fCLKB8WDczR9Ul1DNfgKC/nRN/p4SdzpqQLPYWKAwn1xLTESrmcFTDOCHSq5WKyn4THaNOfGq3KlX4Eci/w0PHjiF8cwW2hhZoZ/SgvYhRqd5U1k7pd9vuCbJ+BiROpAM9DcJN8U0iOYc2DsdcLCBuVWM9u6ELkWJBHnpz7KLWHftudFqo5hyXlGX89aFntRpBmDEmsU/xaODJjBqZTBdiOrrFNzo+w40QtM1axHpDG5Fl1l88IawXerfYc4WNitONEANvZ3vkC1+GasfHC2HIGaDwlW2Uz8z3byxsjABrzhXzbcUdRL22q60SwGavwOOc1VAPAz3LYAUumPDEUFwdP3hMVa4BgWtacQXNGMm13dze1IAIm9DuoFJ8wHaF6WpY8tXO8ZOqsivvC7YsZsescRchFpMK5NedTWJt5Y7LlLAJ9PWLfzlTQLlQyrfhqTcKxX+hafUEZSth2wQnMw==;
 5:Q1zJ+g3jpVLeqkCw0pNQVQZN21qibU27u+1VcP/e61IVLE+DgFGrC7BeIAvvSPGgcW94e/PS9n+4QImrBVEQxMkdZcDk+lu8BegzpMtxP4LNc+M6GXH1x29OmafbhQxvOU4CSvQi9ola3UpGmWbkOdUmo5TO379hv+xNF1Pv8zg=;
 7:T+Jm7dnDj/xZGs216ez8ASx1Esj2woCCGU9FG4MSc0BEEuPRuL1gojycuyugxtLG89LPuS26AFbDZ2EBROv2UDtoyxSjEVHTT+XaZ9/ogMSRpF98twwaUZcRdYI1tD9wEeh/E/m8Qc2W8EpUrXOXng==
x-ms-office365-filtering-correlation-id: da8bcf94-5cc4-4d52-1b44-08d66c743981
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB6047; 
x-ms-traffictypediagnostic: VI1PR04MB6047:
x-microsoft-antispam-prvs: <VI1PR04MB60477419CE639C54A5D7240090B70@VI1PR04MB6047.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220051)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB6047; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB6047; 
x-forefront-prvs: 09007040D4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(2906002)(68736007)(7736002)(5660300001)(86362001)(36756003)(6116002)(3846002)(102836004)(8936002)(26005)(52116002)(81166006)(81156014)(386003)(6506007)(76176011)(8676002)(186003)(106356001)(105586002)(305945005)(446003)(50226002)(71190400001)(71200400001)(478600001)(66066001)(53346004)(7416002)(25786009)(316002)(11346002)(97736004)(14454004)(1076003)(6436002)(256004)(476003)(14444005)(6486002)(54906003)(99286004)(110136005)(486006)(2201001)(6512007)(4326008)(2616005)(2501003)(53936002)(142933001)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6047;
 H:VI1PR04MB5040.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /muYwXH8qNV0L0+yhbtnHlL1poRTmfC2CBhLwsWq4px1N9kwpixatsM4DoqJFRJg/jXkv7oUlnJmRiDjJF255XIqgw6g4PU4vjJIt0jb2WI6ysa1xnAJ7xaandE3h9X6rKkbjxlhtElgoOW81+o/azyUbKSmgLlmJkG2jthhs379wVf8vgNIHWkthcGUWnrklDFva1qZlW1nY+aFj5bannFw45n0ypTrOKa8el3LTAuS44Pqw5eC1ufRWBzHkAGA8O30C22Kpwn2kD0STG1r5V0PEk0qnShxeUFIl/XLMbNtQrY49YDWogKWDgIDeIIj
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8bcf94-5cc4-4d52-1b44-08d66c743981
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2018 03:26:16.0905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6047
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_192625_533010_9A3D4508 
X-CRM114-Status: GOOD (  12.29  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

i.MX6ULL has errata ERR010450, there is I/O timing limitation,
for SDR mode, SD card clock can't exceed 150MHz, for DDR mode,
SD card clock can't exceed 45MHz. This patch change to use the
new compatible "fsl,imx6ull-usdhc" to follow this limitation.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm/boot/dts/imx6ull.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
index f3668fe69eac..4ad58283a9f4 100644
--- a/arch/arm/boot/dts/imx6ull.dtsi
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -30,6 +30,14 @@
 	>;
 };
 
+&usdhc1 {
+	compatible = "fsl,imx6ull-usdhc", "fsl,imx6sx-usdhc";
+};
+
+&usdhc2 {
+	compatible = "fsl,imx6ull-usdhc", "fsl,imx6sx-usdhc";
+};
+
 / {
 	soc {
 		aips3: aips-bus@2200000 {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
