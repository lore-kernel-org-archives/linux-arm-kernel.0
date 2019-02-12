Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4597C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:59:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91EFA222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OohlIVkk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lbEtxIEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91EFA222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4U/3z9zCMTkzt3vPhKOkfCR4VFXjnu7MwR7etiiaKxA=; b=OohlIVkkN/43eD
	Co9jdZ0KdtNdk1UjIfQrH+tKLXPCL08vCDy5cC+GFBbN5z9nEieu7XBQAXGfv7Ai+ibKFv3VXLivY
	WFwXZgfbkKEXbRwj7pYxYL0L6Z0uhtQ00iBM/sF35sP6YM24NvooFBSMIDuGs2dlUIM3pHFQEEv4N
	k0u5eWZAm8Ir5nmuoq+JrhZmDQOdHpuumeHTpkIetvl8QXZDPTwDLjwCYB9TFHqxWjtW3Y+TbOhYW
	0d5Iw4tFmYdWyN+lNKG8R2RYDgJm/FaMPiezTnbgByGHdJOl0+tpM1GJ29XPlbzYqQQaQcA6lIfQB
	010QjuQVbbYqrtlfqsbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtf9Z-0006QJ-HO; Tue, 12 Feb 2019 20:59:41 +0000
Received: from mail-eopbgr10072.outbound.protection.outlook.com ([40.107.1.72]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtf90-0005rE-W9
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 20:59:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ahLN/A+xCbeGwIH3RaERiGgRROihJEYLDOA9Yyauts=;
 b=lbEtxIElnRivYSovc5W5xLaCPNvEpLT/UIhTp8HRxPut/6SC1MXEJ0vfiPbPKKoslM0UfI8dDVKfT6Yw7KZNo8Wx76dQWXmXs/VSq2vosNeEoeqZ1zy+ObNdmuPtIcN6sdVgIf5SgZ+PzH3vh+0cq/jMHft8ZB1cV0CYFZDA2yQ=
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com (20.177.49.159) by
 VI1PR04MB1613.eurprd04.prod.outlook.com (10.164.84.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Tue, 12 Feb 2019 20:59:01 +0000
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849]) by VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849%5]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 20:59:01 +0000
From: Frank Li <frank.li@nxp.com>
To: "mark.rutland@arm.com" <mark.rutland@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 dl-linux-imx <linux-imx@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "lznuaa@gmail.com" <lznuaa@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V2 3/4] dt-bindings: perf: imx8-ddr: add imx8qxp ddr
 performance monitor
Thread-Topic: [PATCH V2 3/4] dt-bindings: perf: imx8-ddr: add imx8qxp ddr
 performance monitor
Thread-Index: AQHUwxXHAbjQOur2CkqkwPkAjKPVYg==
Date: Tue, 12 Feb 2019 20:59:00 +0000
Message-ID: <1550005119-25750-3-git-send-email-Frank.Li@nxp.com>
References: <1550005119-25750-1-git-send-email-Frank.Li@nxp.com>
In-Reply-To: <1550005119-25750-1-git-send-email-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0021.namprd04.prod.outlook.com
 (2603:10b6:803:21::31) To VI1PR04MB4910.eurprd04.prod.outlook.com
 (2603:10a6:803:56::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=frank.li@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.5.2
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB1613;
 6:1hkfXuC8JTWGIlI1tMEvz+9DtaJJRvnnoeDT1oKSEXHj8ZJTRn3E0ShukQGMsND23crB8FvjYsdk8PWOrmr9crDRo4VtS/LFbcl6Oq6DRFknFrhJg9Vigptvt4HBlHzIh5b0YCehYvV8TykYBU95/2anBJAu9TbOJ3gRzXshN9uBDe/ZzmzJ9k4ZoAJha2oYxGLq8b2hsQGRi+vfwYE4xr1YjaONqN3/A/6IqTEqcPHpyZf/yyZ5l340kenwo28bYAPEycKI61G5N3532AE/qfsx9L4hnqBjNAnRkh8Erjf24587Spktdps87VbncR4g8OeI7rO086gAfO4/J9Jj+aAvWU3xRmIBMC1Q4gJFegOfEBEKqjlq//DSoTEDUbBUo17/4zmKxUuFjtiOVbA8OIumdYYm7SFNiffpbGAoCyaY/h1mN5eew4eAxnhrmiH0NH2scFAVP6m+18bc69VvJg==;
 5:sJFIUAgYaFs/JFNBaALQW6PQ/wzzqTVu+MBblQcnIt0GvxbD+4yjZA7is5hd80XaUoN8VtGPkFnXR0+sG9TzDuELx3YGYgZC3Z75YzntTxugEAFU+Lq2RhtURelWVsBh6Ry3x4cGcjOhuC3XyiV/wnwSjjdTIvdncFpuqTfTmKns2fBP4eIRpKSXfYjpzj5i4ohBclzYgVRyslIMuG+AKA==;
 7:4P6lMuhKBrKXAqLE1ZnfXkUgWgn0nVc5fS3oLKRDGb2FgUjT4Ane0hR9iXYscB/WCUwvKwSvQ/veJbRBF5Wtse6qmspxodbbLQDDvmnHJP7Q85EUMWd5YYkkn78VoD8PJc3uIdKR37GQZOzIhWDgxw==
x-ms-office365-filtering-correlation-id: 55295476-414e-47e9-57b3-08d6912ce9b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB1613; 
x-ms-traffictypediagnostic: VI1PR04MB1613:
x-microsoft-antispam-prvs: <VI1PR04MB1613B2E790FA96D9FA20E87288650@VI1PR04MB1613.eurprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(346002)(366004)(136003)(376002)(189003)(199004)(97736004)(71190400001)(81156014)(26005)(11346002)(81166006)(446003)(102836004)(50226002)(25786009)(386003)(6506007)(8936002)(8676002)(68736007)(99286004)(6116002)(3846002)(71200400001)(7736002)(256004)(316002)(110136005)(305945005)(76176011)(7416002)(53936002)(2906002)(86362001)(14454004)(2501003)(2201001)(52116002)(186003)(105586002)(478600001)(6486002)(4326008)(6436002)(6512007)(486006)(36756003)(106356001)(476003)(2616005)(66066001)(921003)(32563001)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB1613;
 H:VI1PR04MB4910.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZrQNZotIcpyxSNQHJAwLjBRU8MtcYP/1vXzmidG6fop+i106KWxASn7X+JMAUSlV47NOs4uQfev3wTb0aS1hmd33MM9hPPMM7kIB6epBCS4ORbKUK6uWvhjvO0C3rooc29/GllDDoE7Uek8jVp6G/MSwNW+6YfjEDeE1QvR6Mn1CVFTSCrzlqKePBYiiwb8VpgQZYkTkCU1msvWDNWoCVEVlV6R0uVhUIn9MmNy5qn8+MkqrCy88U2y0ekI/xMUWfiCsfCkkK7OC6ZwuB2I0sCb93eWzCgmp3JyfqZIWod8vk72sGOlHkHZeZRcj3d+hTpAC7zzteL0COsqY/97/3gSNLswdXHvMSgOcXzGkhkO1ELpPG81NRZjdK9s8jFNARC/RqA2/lwAszkw+7sB2X9sT9u/L7Ug6SoEHBYxFMP4=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55295476-414e-47e9-57b3-08d6912ce9b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 20:58:58.4114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1613
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_125907_250091_0781336D 
X-CRM114-Status: UNSURE (   9.94  )
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

No change from v1 to v2

 .../devicetree/bindings/perf/fsl-imx-ddr.txt       | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt

diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
new file mode 100644
index 0000000..375a67c
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
+	ddr_pmu0: ddr_pmu@5c020000 {
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
