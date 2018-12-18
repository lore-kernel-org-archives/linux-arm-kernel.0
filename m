Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBB6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:02:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A1321873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T/yEzD2C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SU/mV7re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A1321873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z3mlV6/WCro6AtId0SF6wtw363SlVfcLhdulWImdQTI=; b=T/yEzD2CBKtMh1
	d7iCQekGrs5xdUc9AZ7yZLKTuvfiTpPQCgqnCsITDmzouPcVUpAZeGn5ZSVoUqZrmJKAx/2pJwQzV
	LnMh9lee6QQ3+h2frXSt2770yfXys775Mz+S4JHR2guWiKNACumjwLchpKYy1znMoCSGFq6r7/lkF
	yOclfd4KRNnr56N3queuLRG00j5l0QK3you1+FJGFMO+2aSTuLr0H9jrG1mbR7TJuLlWhRkpjCNnD
	ewa1KXPpmPxDEWvOgyJiyfQmZ/63Xc3/9W+UMqyWV02vo/3C8/EmZE176ii/+KTioJFTmf6j8Jbpt
	6wco73M6eYozYkF0U1wQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHop-0006ns-OM; Tue, 18 Dec 2018 16:02:03 +0000
Received: from mail-eopbgr60078.outbound.protection.outlook.com ([40.107.6.78]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHoP-0006NQ-Uh
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 16:01:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcPw4x43eI7NqkBJZJmhUTza6OShXwUv5Cq5S2siscQ=;
 b=SU/mV7revYd3FTEsFR9qNA3cbKUWDCY21bg/Of4XdpabULHaQMouA3itrX1/xTQu0cZeV2nN962VnXuFzoTZiApSTanXhAPvx1QqNl1zqrf8m9p+X24aRpv2WbvEUREhQyD7v43H/16TJqRDl4OemTQJSYx+pfO7dAg41gxrAI4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5202.eurprd04.prod.outlook.com (20.177.42.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Tue, 18 Dec 2018 16:01:20 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.023; Tue, 18 Dec 2018
 16:01:20 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/3] dt-bindings: fsl: scu: add fallback compatible string for
 power domain
Thread-Topic: [PATCH 1/3] dt-bindings: fsl: scu: add fallback compatible
 string for power domain
Thread-Index: AQHUlurqutx971slw0Wkld4RueG9XQ==
Date: Tue, 18 Dec 2018 16:01:20 +0000
Message-ID: <1545148524-658-2-git-send-email-aisheng.dong@nxp.com>
References: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:203:36::28) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5202;
 6:uUpPXNGWHfQtOJbvuA28yX3MVPw1CTyTXpqgxB0B2RHDoBECErZtCCX4jUcF9KkAx+O1rxPkYdp85zqliq/Eh1+YvoFp/YcQoptv5h3JfOLjcTGLTakbuNA9jhzQqePKb2uIbo0rCCsz/AXpX4Si//OnKHYX+8vc9wAeJ2+E4cMyT1tcViJHC7CIAbiO59aBT2oREdS4tXQ5NwliCUk1lTl3B69lsfAtRm17rbbfWSCoQqiDuh8z1EWi7PGYooHoXFgHs1MzF02NG9F9hp/qNa3b5yVNxo3HCXVX6JkG8fzmFt/xa7He/0bmklOGbfFtP7WRM3LU9iJfbg3/Dyzu31X1XPeEGD/POyyLbtPzI5wmOjSLaWCFqu8VXfyReSjMFxGw2iaHWIpcoFj7mh2dC7qLjatUJ6fNMjJle5ccNYV4tFanUunXQbs0CTMjC373M1WH52bhDaHlO7o93VDSCw==;
 5:ewdErl6Gq486lKmVVPb2SWTNGm2Dnvwn+6j/D7dLXYDzZKehPfN46Afk17udNv0VUHODII8jdPflsJXtOO39q296krmAiM4DrRPhM6LiRz2W0AAwLInXtGksUzFQY57FhDDunPbbQnQvO8AV1boFhfYulAlE+W+aoEwaZv8lEsE=;
 7:E0oYXZ8MGCRSJQhabf28swumf1W2L2YLuaF5qZlDfk21x4I4XQu+SdiLmCbUxwWNAVYTIp2OI/mxXV26cGFof2xNXSoRZPZlNC72lAB8CmwGFUV/9nY5VXFUT5N0JeslQTLdMuDL6022yvipg6cj9A==
x-ms-office365-filtering-correlation-id: 00e40472-8124-4dbc-3698-08d665020ce2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5202; 
x-ms-traffictypediagnostic: AM0PR04MB5202:
x-microsoft-antispam-prvs: <AM0PR04MB5202C5B952362549778E417380BD0@AM0PR04MB5202.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5202; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5202; 
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(366004)(199004)(189003)(446003)(2616005)(7736002)(11346002)(476003)(486006)(106356001)(68736007)(39060400002)(105586002)(53936002)(6512007)(97736004)(6916009)(4326008)(66066001)(256004)(14454004)(44832011)(3846002)(6116002)(6436002)(25786009)(5640700003)(8936002)(6486002)(71190400001)(71200400001)(2906002)(478600001)(305945005)(5660300001)(50226002)(7416002)(2351001)(81166006)(8676002)(81156014)(2501003)(52116002)(76176011)(386003)(186003)(36756003)(102836004)(6506007)(26005)(99286004)(54906003)(316002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5202;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RZ61DIAW9hPFRqrtSOTpQSQV33AV0ZHpmf7Ude1krXEQ2U8c060a3P4O6mDtwQJOBZ7KPv3AivxrjF9pqLUiSpvEqyOzn2wCnn49wDZGS1N9B6fd2A4hI+ksmQFC8C52X8fUU5uCEucjj0R8w1yuFJfXie1G5UyDYNCCM/8eFkfS3myhHSFqMeZ5CkPax2awSzHF2gs2K4QwRKFX7pfMFYwVjmZdArrSYn7GlqX+LTTVIqvCKhIF/BGf6lRmWM86tZcRA0KRDWFGbDky5XrT4Z4xyQ6USCXI/bBDCEOkfxIEkC7ox5G9CwhgwAGUykAo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e40472-8124-4dbc-3698-08d665020ce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 16:01:20.2651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5202
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_080137_988351_F1FA79B3 
X-CRM114-Status: GOOD (  15.40  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "khilman@kernel.org" <khilman@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SCU power domain can be used in the same way by IMX8QXP and IMX8QM SoCs.
Let's add a "fsl,scu-pd" fallback compatible string to allow other SoCs
to reuse the common part.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index c20f38e..849b671 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -58,7 +58,10 @@ This binding for the SCU power domain providers uses the generic power
 domain binding[2].
 
 Required properties:
-- compatible:		Should be "fsl,imx8qxp-scu-pd".
+- compatible:		Should be one of:
+			  "fsl,imx8qxp-scu-pd"
+			followed by "fsl,scu-pd"
+
 - #power-domain-cells:	Must be 1. Contains the Resource ID used by
 			SCU commands.
 			See detailed Resource ID list from:
@@ -145,7 +148,7 @@ firmware {
 		};
 
 		pd: imx8qx-pd {
-			compatible = "fsl,imx8qxp-scu-pd";
+			compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
 			#power-domain-cells = <1>;
 		};
 	};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
