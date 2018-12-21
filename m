Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0094AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:31:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B55E721903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EIDrZ84f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UmxogrM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55E721903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rN6pSeudU2tOzP4hdYaMBPo+4KhVHPrnCF5Zc5ZjHPk=; b=EIDrZ84fkmqoL8
	EMCe+CD07CmSwTY685DTvuGBm6c3hhnj9azOvzROJmlAPiSN7uEmhkgrcHB5QuGQgSYG2HZSPqRQ3
	0EC4HSicAlJ5+d1Cl9E2DNwLbPpC2Uswe/2h4Lfv+jCpSXcpM+ZnRPbF8WqmqNmNN/y+lFf0q+TUp
	JzsGYrLDAjZm2XvJsB2lBGFpl2rlXtJWEzueZYaWzus1lWO3rsHOwd+xnjzCZ1X51lte+erj9fSah
	RyxdFxA5Lg1mA2Asez6qCdM5HyIMth7Q6iLvAyUtfNNjIJvUwX9BtrpRZ8hQSmgOvHMsVgkiCHamp
	YgCqdVCJFVwFUVn4pkHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaMm8-0006In-KK; Fri, 21 Dec 2018 15:31:44 +0000
Received: from mail-eopbgr40049.outbound.protection.outlook.com ([40.107.4.49]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaMlo-0005da-6f
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 15:31:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgLxbuvJZcf3yQ7cACTLuYwoOpt5DrqhYCGNnThVRAo=;
 b=UmxogrM2uAFPoU9MmhckRx5b6Q8QjRdT7DsdfV4rcLlBjTVl4m5Rx2HKuiNTAiOGp9ccUhK1TWUo1NQbUSrptak/BG8AbnvllROoNEuVI/DFf5vpjD2yMJonNIWxUkV2yNWrPcOKh8u8/wBqtUoD+3HhGG+B2mPGrlboeo5sIYs=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3488.eurprd04.prod.outlook.com (52.134.4.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Fri, 21 Dec 2018 15:31:09 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::95a2:5df5:8d7b:22e9]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::95a2:5df5:8d7b:22e9%6]) with mapi id 15.20.1446.022; Fri, 21 Dec 2018
 15:31:09 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Leo Li <leoyang.li@nxp.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2 platforms
Thread-Topic: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2
 platforms
Thread-Index: AQHUmUIyF6ylLjPS3UibJyYT5PgWGw==
Date: Fri, 21 Dec 2018 15:31:09 +0000
Message-ID: <1545406240-3061-2-git-send-email-ioana.ciornei@nxp.com>
References: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0801CA0082.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::26) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB3488;
 6:YaSNjSv889VOJyrkFS7X+u0Pcr1Wz6g492X0xDgM8Nw99x2TRAendTLnfl3mUtmcxBGFkpotyDFD1mfImXtcjpY5BEsJg2jtQ4P1qpauHoB4Uu24ibH7fN03/bMfrJ2XlyJnoI+//8oaXuKHH4c3Gt1gOYVLFHphHnNPdHhgwsdXi3YyxooWsVJHuZ0bK8bcLilKbjw6X1Zb2xlmCX0I/9Lv+bPQx4fqQeZNHpMpmUg7fHXAWX+rwjjgQ9Xy1OS9ZxHZF4Q1JpLeNtALUCVOgDxHYPY+k5blLzcJqU0vxyIDCYzHAHTMXNUCiuQI3Jx8Nj5USFMBk2QcsN0CnVyerCA5rl5ICkXXCSpMbwYZwsqCm0dBehGO/zNTyijIlmYRf8lz/cEhXQE4xibuel0B9gWc1wRW/NPVwWKgXbGkhPI92y34U7sx7mO05RVLeaKcAHihGw8x1wUHBnmnqxDhKA==;
 5:f4YCXJdiqUmF3tRvKk8ENshVC6lyDydG4c9RE7wX6pjZhptduOHyREwgLRJ3X87eakkllkxrZRGBKP+8vyUn8FW8XrrqbLjH/m6oZH3ll5p9seOXMnCSS9Z/iYIp4N8swRw+cyPNh5GDhPmNDhAzM/Hf6gHk7Rdt4A8xaXt+SIo=;
 7:BVhi1Cpx3EOUu3TxWHlxvSjdE16b56oCEfUy8b+gWmgCcz7M3XiQzLuSz3yyefdiS5DiJoJFU7YLfUac1UHaI2OBmog5Kjxk5Ip2RAdfJYJ4PFzv+oXZswgVZrvHb55WNqXdXb6CR0FWfM9jijnmfg==
x-ms-office365-filtering-correlation-id: c7911344-1ccd-4b8b-59b8-08d6675954fd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3488; 
x-ms-traffictypediagnostic: VI1PR0402MB3488:
x-microsoft-antispam-prvs: <VI1PR0402MB3488B9B074FD3F7CB4240F1DE0B80@VI1PR0402MB3488.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR0402MB3488; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0402MB3488; 
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(366004)(346002)(136003)(396003)(199004)(189003)(6512007)(53936002)(2906002)(71200400001)(71190400001)(575784001)(86362001)(2201001)(26005)(97736004)(256004)(102836004)(6486002)(110136005)(186003)(386003)(68736007)(99286004)(316002)(52116002)(305945005)(446003)(76176011)(36756003)(6116002)(25786009)(11346002)(66066001)(8936002)(105586002)(6436002)(106356001)(2616005)(476003)(54906003)(81166006)(81156014)(14454004)(44832011)(3846002)(6506007)(8676002)(478600001)(5660300001)(486006)(2501003)(4326008)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3488;
 H:VI1PR0402MB2800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ly3GmqiyT2wswRBByp1XXFH/VJrWDFl0ktPgJQunpckLaFUJgYzfcvm7vTrMxRvtvPuWPZYGHDQ6Sq5WeaTbiqUCtf98VyW1X0TpZpBxS7RA5paOfBxCH+7+q/FzqHo/Ac0NydNg+qVR8L9ey8POea0mmf3MWBwYscSlsv22SVIYAMmTC9KZawsedS3A1/NLqDJ+KSO2iUBqjtcnEfcPdiyxRVI1Jpvn4OUU8/uoQdvXBMUsLP4RGGVA90lLgwis9olv+nVTIQ2Ldnbh6zSp7hyg/iyVygORIdSYCNw8JJQh9dBIsz2Wx6Zuuoi5lvMV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7911344-1ccd-4b8b-59b8-08d6675954fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 15:31:09.7956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3488
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_073124_243727_6C052FBF 
X-CRM114-Status: GOOD (  12.05  )
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
Cc: Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
 Roy Pledge <roy.pledge@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the dpaa2-console device tree node for the following
DPAA2 based platforms: LS1088A, LS2080A and LS2088A.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 5 +++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index e73e55f..664e337 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -569,6 +569,11 @@
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
+		dpaa2-console@0x08340020 {
+			compatible = "dpaa2-console";
+			reg = <0x00000000 0x08340020 0 0x2>;
+		};
+
 		fsl_mc: fsl-mc@80c000000 {
 			compatible = "fsl,qoriq-mc";
 			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index d188774..6db6ea4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -333,6 +333,11 @@
 			};
 		};
 
+		dpaa2-console@0x08340020 {
+			compatible = "dpaa2-console";
+			reg = <0x00000000 0x08340020 0 0x2>;
+		};
+
 		fsl_mc: fsl-mc@80c000000 {
 			compatible = "fsl,qoriq-mc";
 			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
