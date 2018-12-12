Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A66BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:10:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6542120851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JgNDV1WF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SE6m/O90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6542120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zjak7d5mBi51tbRNthgp+w4mtbwdolALc0n5RRSAeD4=; b=JgNDV1WFcbT8y0
	NwaCkKbemc6rpooyQS+5tNrvqQzLlyHuTyxtAqy1Vip/DjXxP+yVYrh1aYoFG3Gh0TK2UtPpKir1P
	YQJOMJqqzw4KAChbFcs+O/1AqTj3I0fFkRVS0QOiT79tI/UjYyojgXRrh5JwwogmTTy2hjkwaBhp2
	8gNecQcMmSr1ZDeTSstFvA/J8ggRtUtCj/eT7hv5+2bDLxQMBTTtCdpEnAl1CeMD91/hoeEXD23SA
	NpMgWUegcONlYSjTEdlbv02ecs7/0b1/VLt3crmMGSw/avg9sOakXjp8ZVkwlf8QSv5cKchZPwS86
	PO5moVYwIe8+/FblhSag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWyfQ-0003rA-NK; Wed, 12 Dec 2018 07:10:48 +0000
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWyes-0001tG-NB
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 07:10:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hheJoTwQ6pgflbNO9SMxqagYz0/P4RdDc9/2pQIF3ig=;
 b=SE6m/O90lGYRnf1kYDRiIyl7hj1fMT7s9WOUcGcpYnOcMXyQiMEOqh4D+sO9MPIxyBu488XrT3f0Tq7KL36Ox18C7VHOLEqg7+U1Hds2kjEJDyXlkVWqFsnSiaSxxQkAGHO2NCWHYEmxkxVhqjwHenIXE3sfixV9B8scuec8YwA=
Received: from HE1PR0402MB3323.eurprd04.prod.outlook.com (10.167.125.20) by
 HE1PR0402MB2811.eurprd04.prod.outlook.com (10.175.29.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Wed, 12 Dec 2018 07:09:58 +0000
Received: from HE1PR0402MB3323.eurprd04.prod.outlook.com
 ([fe80::f95d:89f3:77e0:b668]) by HE1PR0402MB3323.eurprd04.prod.outlook.com
 ([fe80::f95d:89f3:77e0:b668%5]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 07:09:58 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawnguo@kernel.org>, Leo
 Li <leoyang.li@nxp.com>
Subject: [PATCH 3/3] dts: arm64: fsl: lsch2: Fix the endianness property in
 nodes
Thread-Topic: [PATCH 3/3] dts: arm64: fsl: lsch2: Fix the endianness property
 in nodes
Thread-Index: AQHUkemwEVV8J0YsJ0iNBSlSn+EgGA==
Date: Wed, 12 Dec 2018 07:09:58 +0000
Message-ID: <20181212123505.32415-4-pankaj.bansal@nxp.com>
References: <20181212123505.32415-1-pankaj.bansal@nxp.com>
In-Reply-To: <20181212123505.32415-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::11) To HE1PR0402MB3323.eurprd04.prod.outlook.com
 (2603:10a6:7:81::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR0402MB2811;
 6:wC+oeUXV9ZmTf9r9ToejNswK0P7adR8/6GBFqYihfR9I+5B4nouhO/NFfRoUFSQiIn1SjFe8adLJfDSBjtD9oAKLsr/2jt/ZHNrD+ItEIJvVktQJ2O7D+T+c3ohaKWWbmFZ8ndLNBpxPXTFllvBPwqwulCGdhzLWdQFMELYp9j8ghgut+atgw6id9iNFmUxL6jur3gE/67b5hP98l83guxDpL6Esh7yTsf9ZOkm3RqNKosCn8xYlWVsFePMtIyLERN2fV1Cf2qUfKb3vxCauRT2peuydzS58OcHO7nAZXniELWj/jegpr+SIPvHjVj8YS5IZCWX6Tut+XyX78HDVbeO96nD6kJJbA83uxNWIq67gW0kU/gI61tgMVajMi3dvY6wU5jIjjLQyQaIc86cSeQUwYWj+U48fz0nVY4b/k7upL3IOq1glm2wXzs3H/K5NgBAgLEfeeI992blFllm16A==;
 5:dKeM5B++fTlFiwka1ST7HaWaR2E3tKe8aZJT6sxO+3FkwXBZYgSA7VpmIda3151NQNUARahuJV4ulU6pGax0sVK3QCzbIWw5qRKJ5iokATEIjSfL8rUDzplm5L8ck43V0XYUxJxKonhwf1LkOMuHJVD58oY/NGAprTHPNXQaBrg=;
 7:yeL0Bll4dKWlPjp5Yxp2Bh2KYM3Gj5tACDh73N/YIYzNGCZBhp3Kg9+7NCuagl7nK8r9c0HFybAAfwz3rmbWiZD1bAzp+sBdIp28Gf/lSJabA6+r0MKJNm9G/0VBDJMewlbccs9OXVtJSYXXljWspg==
x-ms-office365-filtering-correlation-id: e29f354f-3e39-4968-023b-08d66000d342
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR0402MB2811; 
x-ms-traffictypediagnostic: HE1PR0402MB2811:
x-microsoft-antispam-prvs: <HE1PR0402MB281150D0E6CFE36656FAC483F1A70@HE1PR0402MB2811.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231472)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:HE1PR0402MB2811; BCL:0; PCL:0; RULEID:; SRVR:HE1PR0402MB2811; 
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(366004)(39860400002)(136003)(189003)(199004)(55236004)(446003)(2501003)(81166006)(7736002)(11346002)(305945005)(76176011)(486006)(66066001)(8936002)(476003)(2616005)(5660300001)(44832011)(81156014)(8676002)(256004)(106356001)(25786009)(105586002)(97736004)(2906002)(52116002)(4326008)(6486002)(1076002)(6636002)(478600001)(6436002)(6116002)(3846002)(575784001)(99286004)(110136005)(36756003)(316002)(14454004)(54906003)(386003)(6506007)(6512007)(186003)(102836004)(86362001)(26005)(71200400001)(71190400001)(53936002)(78486014)(68736007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0402MB2811;
 H:HE1PR0402MB3323.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +JVZyQU3moxA7XlW9yL3jcMjAEfd6hHMcbTeGeOT/6LkeSB6GBA2QTBf/hX5HXYCvR72IcEe9wl+DzJDy32Z8va2G0s8JOR2QtRgVWH1H18h7Ar4x4jWFwBJmm3zYwfa33C8C+3azyPSqwwPa0fRK5M+FGXjxJ+Z18gTE5zJNKxYMit6SXaSZIvqEKaekSDlSqShEOCUls8yAfHc/HmqmLXozP0vyPVFZXCWY3+j8TBDP+ELiYeXwdd6PeVMSTmMBFEDshps830kctpiinEVQLMYTr0aoHBe4MOzjSS1hfK8Z58F7Ld3XfRq+1mYHxY0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29f354f-3e39-4968-023b-08d66000d342
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 07:09:58.3451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2811
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_231015_173477_78B65725 
X-CRM114-Status: GOOD (  12.46  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Pankaj Bansal <pankaj.bansal@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The endianness ought to be mentioned in dts nodes if the device
is big endian. this helps the software to read/write device registers.

refer Documentation/devicetree/bindings/common-properties.txt

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index eea23b84daee..9e497757229f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -240,6 +240,7 @@
 			ranges = <0x0 0x00 0x1700000 0x100000>;
 			reg = <0x00 0x1700000 0x0 0x100000>;
 			interrupts = <0 75 0x4>;
+			big-endian;
 
 			sec_jr0: jr@10000 {
 				compatible = "fsl,sec-v5.4-job-ring",
@@ -367,6 +368,7 @@
 			reg = <0x0 0x1880000 0x0 0x10000>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			memory-region = <&qman_fqd &qman_pfdr>;
+			big-endian;
 		};
 
 		bman: bman@1890000 {
@@ -374,6 +376,7 @@
 			reg = <0x0 0x1890000 0x0 0x10000>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			memory-region = <&bman_fbpr>;
+			big-endian;
 		};
 
 		bportals: bman-portals@508000000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 49a363abf2ad..60a0bad946ed 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -245,6 +245,7 @@
 			ranges = <0x0 0x00 0x1700000 0x100000>;
 			reg = <0x00 0x1700000 0x0 0x100000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
 
 			sec_jr0: jr@10000 {
 				compatible = "fsl,sec-v5.4-job-ring",
@@ -284,7 +285,7 @@
 			reg = <0x0 0x1880000 0x0 0x10000>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			memory-region = <&qman_fqd &qman_pfdr>;
-
+			big-endian;
 		};
 
 		bman: bman@1890000 {
@@ -292,7 +293,7 @@
 			reg = <0x0 0x1890000 0x0 0x10000>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			memory-region = <&bman_fbpr>;
-
+			big-endian;
 		};
 
 		qportals: qman-portals@500000000 {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
