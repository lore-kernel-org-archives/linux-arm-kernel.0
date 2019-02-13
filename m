Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D08C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:13:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 191B0218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qKSBPHP6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uxLRDB18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191B0218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=teVQbb5SA+b3pFcPVlAaA4EnmbUfiuHCqpm99Jz+0Yk=; b=qKSBPHP6K0MGx4
	nX7BGWMKzgr2Egcdmk/k+wJE4vWbB5O5Lk0COccAO96K36WqvgygUb9N5QDp7Bpj7dLGvuODVNkeM
	7xeaNvOC7TV3m2P80//ISKc5alY8toAdaMjkMD9u4iztktzK9+ls9SczDL437uA0Uyj1w8InaG/B2
	NPvTKUdukwWxWmOhJmjw4/R7DbwlMNC6BxH/GFAkvbAF8tL9DNBSfg9oJsdr9oPn2wlhNrNj6gzZl
	HMW/TZbilsxsLgc63LIFZkUYGjOky82z7xitBRFgcVhSI2nW9096I2X4DK23NelZ1RZXDOVa7dqQ9
	o5jvNnxIz3zSXQrOot8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtz1t-0005FS-Vg; Wed, 13 Feb 2019 18:13:05 +0000
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtz1R-0004dy-DG
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 18:12:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=As4xPenQ5uzKYQM2LxBSirAp/E6ZEL95HbBUgeHBHOE=;
 b=uxLRDB187TzJVG7zUcEKnTc90IngY675BQ840dFK/9KP22t9Olk4XeybXHCVqHaiMeXDbGWkBcmqSopibBK3YaM51U6t11Ih2ymnpZIHOjXlLSd/dnhLXg7U5jEyVZaTzBefLhvejBwVmpJsAzgjkVThL0bNwPMo72MxmRDDKR0=
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com (20.177.49.159) by
 VI1PR04MB6223.eurprd04.prod.outlook.com (20.179.26.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 18:12:33 +0000
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849]) by VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849%5]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 18:12:33 +0000
From: Frank Li <frank.li@nxp.com>
To: "mark.rutland@arm.com" <mark.rutland@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 dl-linux-imx <linux-imx@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "lznuaa@gmail.com" <lznuaa@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V3 3/4] dt-bindings: perf: imx8-ddr: add imx8qxp ddr
 performance monitor
Thread-Topic: [PATCH V3 3/4] dt-bindings: perf: imx8-ddr: add imx8qxp ddr
 performance monitor
Thread-Index: AQHUw8ewTDDLp5mksk+yzpOwPraUFg==
Date: Wed, 13 Feb 2019 18:12:33 +0000
Message-ID: <1550081533-25000-3-git-send-email-Frank.Li@nxp.com>
References: <1550081533-25000-1-git-send-email-Frank.Li@nxp.com>
In-Reply-To: <1550081533-25000-1-git-send-email-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:805:3e::49) To VI1PR04MB4910.eurprd04.prod.outlook.com
 (2603:10a6:803:56::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=frank.li@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.5.2
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8492fb9d-6b68-44b6-0c1e-08d691ded309
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB6223; 
x-ms-traffictypediagnostic: VI1PR04MB6223:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB6223;
 23:jiBuwNVp7EHGhiMh5Ot5GYndv87+Ul4DpLW8dgc?=
 =?iso-8859-1?Q?DSrPtkbfa9WtMchy4t63/YdFKjjxQGAzMqvvjnjga+PNkSLGUBwAdMJy2n?=
 =?iso-8859-1?Q?kFEou0GloQ+PiMZYyrfPPmztbfbe3BLcgxWTtSQzi9BJKI71wj1quUn8+w?=
 =?iso-8859-1?Q?9zdQfH1gG2aM6oaMAhftbmpu1OexOrA9zRwDusHNAG9aBu6ziVnxoBBuQm?=
 =?iso-8859-1?Q?qYPsbp6OzmdWgH/kXtCaKXRT3CiTimmIztpyaSuHpmNR2HP2P4VZnAN9+0?=
 =?iso-8859-1?Q?MhYFIo4iI26eGQZb7snqHX3HNI1Q75gVu7jFY/G5YBeeGPdE+iSZcUmd4h?=
 =?iso-8859-1?Q?aGEvIerQyjRZ6lqG79jQQzsYVVAe4ARiUjeQsfaQpfLZQaKxLBC1OPBX6y?=
 =?iso-8859-1?Q?plQBxK2D9QsJPUdib5A0Nfr2cPmtxZI6UiXZDRIPCZyPxlB9cCQo+WTbmE?=
 =?iso-8859-1?Q?W5+knKQPZbNurUCpDHdzZjZfE5AOII6q6wfzlh08n++nrooevQz4zLio7a?=
 =?iso-8859-1?Q?S6jVExDFLUc2x0p2fM5iWl97OMUYoHTWDTIjOeL00rf98Dl6hbXHl3ZEvz?=
 =?iso-8859-1?Q?x+AzOCFGrHiFxh2mipCPoRaiCx/DPjSzWUcHzSgcFnMVZVa8fS2/we6QXa?=
 =?iso-8859-1?Q?oGu1YC1imQMHPpQ16t6iLpkoKq9vpyGkwQpVwFhdD3KGi75aS9vdwMduJu?=
 =?iso-8859-1?Q?skMpOakJppB9kBEYeVauMtaMVsNhfLBRl8yBq+pmP5Dn6DV2Rec8Ezx5Af?=
 =?iso-8859-1?Q?sByKBgBygwzaU//+wGUeXvAJZDBsGgcFxFzN8lwaHNDwA1uep36ZmPfNgR?=
 =?iso-8859-1?Q?yBFxH87TVE+4FElc6UcHpMi04A4kzXx7W7yB2tzKQmQ6brC/rN98+oMh02?=
 =?iso-8859-1?Q?pYSKJhtHyT8dWbvQWmCuiKO8bexYlcKbI89AV270leYXBaSBHWfW/oym7W?=
 =?iso-8859-1?Q?hiumNVnZ+k0obgoLj51WaAvbRhltNVZXXKOizP9+4/TCgOzDpSgVqp3sxV?=
 =?iso-8859-1?Q?3TFUhd7SlIe6/+yOD9woyjmZgCaotfUQSEQgt5NH3iwLdKHehrI+YQRuQz?=
 =?iso-8859-1?Q?gxMTIsDLh7NWixO9mlXT4NYSY28I66//PgD0IZVmIwtIAgsQxH4X6wrYoT?=
 =?iso-8859-1?Q?gRAjAcu+7WH3667C6uwTOqcVlmCjFi+1YSEWNhQ7Yt2aVvRTI//ymvAJbZ?=
 =?iso-8859-1?Q?YQTf2lagmA89jqyhu+L4FEEqBxiw8MxJwRQ1kQmyllmhGpgRQzBooViAkq?=
 =?iso-8859-1?Q?1Af/XX+4E1DC/WIL0uAC0xtZuJ0bIOmOhjaHvQaiOwdXTSX7lnJmPUAUW8?=
 =?iso-8859-1?Q?DM=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB6223692E9C5BAB8399479D3C88660@VI1PR04MB6223.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(376002)(346002)(366004)(39860400002)(199004)(189003)(6436002)(2616005)(66066001)(76176011)(52116002)(2906002)(99286004)(6486002)(386003)(478600001)(102836004)(256004)(26005)(186003)(53936002)(6506007)(7416002)(36756003)(2501003)(110136005)(316002)(476003)(486006)(68736007)(446003)(6512007)(11346002)(105586002)(14454004)(106356001)(86362001)(25786009)(2201001)(50226002)(8936002)(71190400001)(71200400001)(4326008)(305945005)(7736002)(8676002)(97736004)(81156014)(6116002)(81166006)(3846002)(921003)(32563001)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB6223;
 H:VI1PR04MB4910.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N6MHS4hoTv1A0RQ1PGcqvfgVrFg411IB4oP8GthYtteom3uuHMK8LI/aVQKwUQRD/MYiGk6NuqAfCwOp9Nwne3k4mAEArVnR9zggkXVCVImJToNkfWFBNKIQkk1Zp0X75A9Y3KtoFUJkwa1kQpkEFAH/9UTQ2HEs5MDrPekGZWjB9IT8gD2eWMmCFZXFpMzCs7xCgjchDS5o2h2NC32rl+E3xy4PKfdiTZpLCsEKITPTjbErfvpQyn2YfVV5oZy45+wlmC87G/cFYCi5BJ6wlj/wSwwe+ndoaM75fuoHRtf/ABTlXHGqaokE6kWOjWe6HnyB8zsTpeYtk/1n5cngogE88oxiIPqiAaiS2UvG3NK0+gRr1L5GWfo5/Z5GEkkZ2jBidPRYihQBUz9/V+bE9Evc1T+0i3wt6l7rhTCYsbw=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8492fb9d-6b68-44b6-0c1e-08d691ded309
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 18:12:30.7751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6223
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_101237_444631_E976C058 
X-CRM114-Status: UNSURE (   9.65  )
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
Cc: Frank Li <frank.li@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Added binding doc for imx8qxp ddr performance monitor

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
* ddr_pmu0 -> ddr-pmu

 .../devicetree/bindings/perf/fsl-imx-ddr.txt       | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt

diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
new file mode 100644
index 0000000..9d55182
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
@@ -0,0 +1,22 @@
+* Freescale(NXP) IMX8 DDR performance monitor
+
+Required properties:
+
+- compatible: (standard compatible string) should be one of:
+	"fsl,imx8-ddr-pmu"
+	"fsl,imx8m-ddr-pmu"
+
+- reg: (standard registers property) physical address and size
+
+- interrupts: (standard interrupt property) single interrupt
+	generated by the control block
+
+Example:
+
+	ddr-pmu@5c020000 {
+		compatible = "fsl,imx8-ddr-pmu";
+		reg = <0x0 0x5c020000 0x0 0x10000>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
-- 
2.5.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
