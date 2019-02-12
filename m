Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24DFC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:59:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD968222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LCwCK+ft";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b8/aEr41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD968222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6OQ6gQqQMY8OSleA3JzBcFM9y/pV3EJJjxVUrhEGISA=; b=LCwCK+ftL3r5FV
	TtbP4lpgscv7i+VuG83wANA/C24Id3U7ljXIrMb+R1XQuM2ijlosXmsPmE1gjAkP4DOdA/fg4B4FL
	n4IuLL4PNfpDfF3Dpj+uShInL4KCkaYEFMe1GFU4NzfgmjbylX/fjioKwV9b+w7T9D6lVfdZPVyCy
	yoxwSpl3vU4DR2yXuI0/RuViaFuC+wCq3b5CKVhIqN69WpYg7QbjjTNCuX6/n9AC6dVinE5sQxlCU
	ou7V5gZccjtUBHo/2tD40JaqjR3oLtFCJbDlwCSksLpRIcHK3bBU1mWaKVlrvl13/EUOKiI6p1065
	+yAG+lMtl87NGV65ndaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtf9J-0006AJ-WE; Tue, 12 Feb 2019 20:59:26 +0000
Received: from mail-eopbgr10072.outbound.protection.outlook.com ([40.107.1.72]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtf8z-0005rE-9y
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 20:59:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl+oTkCEqYYLfQuT3EdL/sW0bnL8cWDXs57kavdlElA=;
 b=b8/aEr41N+osxOzvIDrlAgCcaog24gZ2KXuekg9VhhIhPZ21wM2ZcQkoNh1FtNpZNJcNwDZtw2CmKJrsVV6zur4J0dbGLqHmP5LoLDRhaYKiPjzGvfQRHDxPXVmyHMW1xwTCavVkvlLw7D7Dr/ANHz5il1oZzezlyQ+KKYAdXz4=
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com (20.177.49.159) by
 VI1PR04MB1613.eurprd04.prod.outlook.com (10.164.84.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Tue, 12 Feb 2019 20:58:58 +0000
Received: from VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849]) by VI1PR04MB4910.eurprd04.prod.outlook.com
 ([fe80::6cc7:b375:76f7:b849%5]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 20:58:58 +0000
From: Frank Li <frank.li@nxp.com>
To: "mark.rutland@arm.com" <mark.rutland@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 dl-linux-imx <linux-imx@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "lznuaa@gmail.com" <lznuaa@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V2 2/4] arm64: dts: imx8qxp: added ddr performance monitor
 nodes
Thread-Topic: [PATCH V2 2/4] arm64: dts: imx8qxp: added ddr performance
 monitor nodes
Thread-Index: AQHUwxXFmYG0FryvaEGTG9MykhBDgw==
Date: Tue, 12 Feb 2019 20:58:58 +0000
Message-ID: <1550005119-25750-2-git-send-email-Frank.Li@nxp.com>
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
 6:DwM/vI4q2rv4I2MTJCfqvg6ZPDxkeBVREVisLw+ixyAMPhrv5zty7LPJYkgvVM+EDytb4mKCU70M4xmk7YQU1gSOigRSN74fqmh0flWF5JwAUyiQws2CYHuC4wRoGkFE88XG2iswNmC+cCiTCzDoFpga2OuOCx3Sgsaz7zFR4rkVriXQyPrs88EbzLPF+Tvt8hFI3NijfbyDL8YstcBeZA6mffZ/EMnzafm89aKv3WxiCg8buMjYCFtsREkXMwVXfAMTowxgtm+WSyeFducNkR57mgtU/eXK/WYFgc9fpfykx4WXIuLBEKzTcmMc0vNHDpigB4J6rF0Ir182p7F/klvfDZSC9Rq3cKXmksPJRpFfj8KUclP97L1DnppDVPcDbSap3u7PEUvjWpN3m0kvg/ahYcDeLUuvmj/ximY43kvBLcF/9h0jcXhAePELr7HaTaTR7m++ibOGatnTou8NBA==;
 5:UsgcA67EjDgSH9P0ZsPIxOl/ahpK7SlPtkoAFj0QbAB+ULPl4KAKRorwdPMisbrOIWKK4+adSchXrzbMp76pfLp6vOKXBxZ3hkfS77aBdi7xo+n1pizjcs/0pL/LunVX5ZqRDtdXl+7z8e+5dmEMsm6zQSVAKna5i2Y68LpsMQvPjfUWChGj/trL8xG4UUhIKl1I3xZf8s81gGkWIvMftg==;
 7:Aq6r64yaY/I4WQ21rWcdYomVo3n1prX1scS0A83Tffe5ZNHeW7pcOBCyu3LPFmF5ornNq8/y4t5asBylUUvKX0h/jGsv+3MmtM5qV7T93FEu6Q5NYxZ1fV4mQBAXcj7MUhbWVxHtL2eW8xeZK8T20A==
x-ms-office365-filtering-correlation-id: b497029f-17c6-4ad6-29fe-08d6912ce818
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB1613; 
x-ms-traffictypediagnostic: VI1PR04MB1613:
x-microsoft-antispam-prvs: <VI1PR04MB161361566BEECBC231AD234A88650@VI1PR04MB1613.eurprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(346002)(366004)(136003)(376002)(189003)(199004)(97736004)(71190400001)(81156014)(26005)(11346002)(81166006)(446003)(102836004)(50226002)(25786009)(386003)(6506007)(8936002)(8676002)(68736007)(99286004)(4744005)(6116002)(3846002)(71200400001)(7736002)(256004)(316002)(110136005)(305945005)(76176011)(7416002)(53936002)(2906002)(86362001)(14454004)(2501003)(2201001)(52116002)(186003)(105586002)(478600001)(6486002)(4326008)(6436002)(6512007)(486006)(36756003)(106356001)(476003)(2616005)(66066001)(921003)(32563001)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB1613;
 H:VI1PR04MB4910.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8X5vmIIvtYa03NUNjkU9Ni6HwAplqjoxTc0DcNIMUz7LioNW+QwWTyBP5DkmbAvaFhzwUhOxqGbnpf7R0eFuhIozmZEUtHEXxliLID5DBcmmQGGzG5BW2KkPNI+mNZ8hvZdkSFhOVBJs4jqopVUCj1bDfIM5cz9Rvm2Rpa2b7rjzfeM2qYNry2Y25g9Dc4e+bLeOXB4UWPEYKPn7cnnjYAW+rICuvd7MKITkqPlmdsvQzkfM2TmvR+/vUXCiqpVOwENSghCfRia51hcoI7/Y6YgLfZVsYBg4Zw8UN9HbBI9N4eOhqbPoPvYNUX0top9JuXJlZpJjMpyS0H1TjpPo/b1Rh6y1m078yYo69gHp2C2Pop78xHlzAYKpG1tbgA1C2GjO8i8RHqXlFHenOv9YOcwhg1Pf+6XvKkhDxI7sojw=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b497029f-17c6-4ad6-29fe-08d6912ce818
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 20:58:55.6905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1613
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_125905_348834_F844ED07 
X-CRM114-Status: UNSURE (   9.15  )
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
No change from v1 to v2

 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 4c3dd95..243d7b3 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -79,6 +79,13 @@
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	ddr_pmu0: ddr_pmu@5c020000 {
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
