Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1220C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:03:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEAB221A4C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZAuI3qAf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aEvOx4qf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAB221A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JqR1zIS7OPTIRNye+y67nePM3FuvnTMC3f6cZsA11FE=; b=ZAuI3qAfu0XRby
	0cveUHL1zk9maB8I0VCFMRkTaNrfjiFNA8MrLwJN1KqS86TG6K32w9XZ5x7yEHqlIY/sVP1OvhZfQ
	Cjgxfyq1+DuAQOcaE+8+OyeM93fvBIvkPFIjnoEMDnHhB3PJaXFMYttsOxGKOnZOF8cr7/fqc/L3w
	ZAmYaowezI7YvSIbFkY74AntpMufONrH4slG6+XQVZfpZWejywkPQHAbP+mnam1GE9+IYqpyz/YS4
	abU7SHbPHtBtCq9EsbpoXdh5F9zwwZMxWcXGWt3lm9NJh4bML+7Tb3kybFAFOvE6xXveGvAnYOsEk
	3HHbyiuGTnUBFkWzgk/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guhpp-0007dr-UQ; Fri, 15 Feb 2019 18:03:37 +0000
Received: from mail-eopbgr40045.outbound.protection.outlook.com ([40.107.4.45]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guhpX-0007Do-41
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 18:03:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ukq58iB2j668XCJq0QdXsAtT9VDMSjLpxH4wdNdZt7w=;
 b=aEvOx4qfcLqxJfQ4j02maifuZFOOiXi0gVRpYbPBqhqQEAOewkaDr182YZgBqEH5AyaUVn/tTco/xN4mKvXw1drCf7eh+mXjyHfv8sHveseYcijtzDeRyzZyH3ppV3YTcMbxqXYRUOmI7kZE33nYkifmTGoUl5otuROvqJyl+1Y=
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com (20.177.49.159) by
 VI1PR04MB4893.eurprd04.prod.outlook.com (20.177.49.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 18:03:14 +0000
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849]) by VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849%5]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 18:03:14 +0000
From: Frank Li <frank.li@nxp.com>
To: "mark.rutland@arm.com" <mark.rutland@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 dl-linux-imx <linux-imx@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "lznuaa@gmail.com" <lznuaa@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V4 3/4] arm64: dts: imx8qxp: added ddr performance monitor
 nodes
Thread-Topic: [PATCH V4 3/4] arm64: dts: imx8qxp: added ddr performance
 monitor nodes
Thread-Index: AQHUxVi4NXFidk+Cvk6w7YFTCH2pGA==
Date: Fri, 15 Feb 2019 18:03:13 +0000
Message-ID: <1550253761-26841-3-git-send-email-Frank.Li@nxp.com>
References: <1550253761-26841-1-git-send-email-Frank.Li@nxp.com>
In-Reply-To: <1550253761-26841-1-git-send-email-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0008.prod.exchangelabs.com (2603:10b6:804:2::18)
 To VI1PR04MB4910.eurprd04.prod.outlook.com (2603:10a6:803:56::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=frank.li@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.5.2
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e23c4fec-95cb-4848-523d-08d6936fda5e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4893; 
x-ms-traffictypediagnostic: VI1PR04MB4893:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB4893;
 23:JUeD+UlNmdUAR0JuoJyOUt6pe3ElW7Km53NP758?=
 =?iso-8859-1?Q?6fhhd8uABydjeWpQKPku60GChWlJMtlxm9L+aYS3sjmJ0AkD0E3CauT1Cx?=
 =?iso-8859-1?Q?3F7w1zdOdUI5sVTnFPHtRa+ogaEb+KtJCUcQwnHzE25LvUdageA8ZalnrA?=
 =?iso-8859-1?Q?0brFYVJcl2puyE5W/d7liq66i6bTId4h0JHzbynvCeNprzv8hD3Tb/klsN?=
 =?iso-8859-1?Q?POuaJNeUxyGpzWp5We03fFCBP7pWqk7yKGTrgH1jfUrrzR6k+1whRh78cn?=
 =?iso-8859-1?Q?MAG72Yw1vxHNttUeZHcRZp4oxReyNprWKs3DGxYNGB+emH6ezGIrBBqY53?=
 =?iso-8859-1?Q?Ch9/ytDmBQ8frssbEc2oXWP9G63yILosf48MbnGuApawvWDqR10vs2PyF5?=
 =?iso-8859-1?Q?rDmRojfRkn2tqja+3HTT/zUu7S2HmH2h4cOWSjmjMl/7zf+Tkb9vl3SLCD?=
 =?iso-8859-1?Q?Pobt07w7yWgqf8lXBrqzD6Be76dZ5NfNAculfuNsBBA0ZYHhjBQno3xoMj?=
 =?iso-8859-1?Q?v2SeEiIkez6LRxrXXuFn6EesCHOnhqXuDaXwsA3I3nAn+SvYbKJR8MAL4L?=
 =?iso-8859-1?Q?ziSjiFDpdNX5MJcr99qpDC9kspjBqQmiQpvOwATPo10nEIWlQ62qzhM5Co?=
 =?iso-8859-1?Q?m1WKsgT0z8mZ/pdEnlGTg+o/oikRCsVzpoghtz3BGo0/aa/W5sdAx3fdfX?=
 =?iso-8859-1?Q?WPqXbkYgkoLhku6loCwOi/OswqrXZess/rorQ7uu1Bb34RpbVk9IFdSGQF?=
 =?iso-8859-1?Q?vWMUrHYyeGvdjDIXc85s8d+kYXmHXmAMWFZ1QNNoOm5GhdIDUyVaFM16HH?=
 =?iso-8859-1?Q?T0Z+xYYtP2GwJuFHir4iI5vC81ga/Y8l89Tb2E2sbKnBUpGmAZ8iCk4D/K?=
 =?iso-8859-1?Q?b3uibWQGm/m800dqVbjaqAMZZhq6y5eWWjUOS95Zd4ubQhtTaiUpWQ66kw?=
 =?iso-8859-1?Q?33hwZXAfYwbE2Uiz3lDMAcIfBAlkze86k7B/0e604XtVOFdPxQ+I1nNANu?=
 =?iso-8859-1?Q?JlUrrvA49qvOiY3KOV2vc/nu6bQ/KM16XYp7KoRp5dfW0wXzexhJn5a8td?=
 =?iso-8859-1?Q?2O5RvC5ErGDpCq5vNaYNwJlfmD43lDNB5nqytRtgTwTdsyPvv2f2inO5t/?=
 =?iso-8859-1?Q?ToMWR2i89EI2vySBKUeTu7qbmHhPnil3nqC8Q3NWHqlSk+4xmJkvRovk1N?=
 =?iso-8859-1?Q?6tOeNJbuGTpMTib17kX1SH9ypGeG5sUiXaiduBhxE8t+pGXzyNRx9bpsV0?=
 =?iso-8859-1?Q?LYntVu/Zv0rN1SIaHHKveCKaZKT4u/aSMFUFlhGatcMvXsi3ykClE2734u?=
 =?iso-8859-1?Q?CNziZtMLGc/pZkg9LHDPYJB?=
x-microsoft-antispam-prvs: <VI1PR04MB489344491ADBD7D522201CDA88600@VI1PR04MB4893.eurprd04.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(36756003)(7736002)(2501003)(86362001)(110136005)(105586002)(186003)(6512007)(446003)(6116002)(66066001)(106356001)(68736007)(11346002)(316002)(476003)(305945005)(6486002)(3846002)(76176011)(4326008)(486006)(2616005)(25786009)(99286004)(7416002)(6436002)(52116002)(50226002)(97736004)(256004)(2906002)(81166006)(81156014)(2201001)(26005)(4744005)(478600001)(102836004)(8936002)(386003)(8676002)(6506007)(53936002)(71200400001)(71190400001)(14454004)(32563001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4893;
 H:VI1PR04MB4910.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QIC1zJf6iQSFgA4qjLa2l4nQzIb+iyesSgCZ21pjoUpfU22LZAhI+ygNhNha5fHOp1/CxRhf1N1zaMJ92XaysvQEx+TzHaI5uU10TMktxZKaQCsDI+oH3QW+QWNKMplAPmIsVOdnAOFki7rZhJctSvquT3GoFMprjDYsypOVmqIxGjm4OSKgkEcJQqIBGBmgqWi/5dJmWiHoja8s1cdmwuFnJp24nEmL/KESxagjY1cCj1TlDAuVLaB/gg3htYiCyh0VTpLNcY7eFx3IhcMNbvqKS7GlC5wu/qwev1VsXfl70yFascUTTPrV/kYjdWMXn9ojv2nt7KQlq6qY+ueWD8J4X2W7O8N0AvluiL0OklP1YcHYA+h1JwDB+2Q6idkftaTh9ulUSwMBimO/2Avqo7R1sERliLVfyFHW6HCnmoI=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23c4fec-95cb-4848-523d-08d6936fda5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 18:03:11.2626 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4893
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_100319_563291_A51B0071 
X-CRM114-Status: UNSURE (   8.39  )
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

Add ddr performance monitor

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
* none

Change from v2 to v3
* ddr_pmu0 -> ddr-pmu

 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 4c3dd95..ac0691e 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -79,6 +79,13 @@
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	ddr-pmu@5c020000 {
+		compatible = "fsl,imx8-ddr-pmu";
+		reg = <0x0 0x5c020000 0x0 0x10000>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-- 
2.5.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
