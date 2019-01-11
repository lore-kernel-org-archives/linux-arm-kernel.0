Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6447DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:37:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA7921783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dFhIy1sS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EYnXKaWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA7921783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BTEtMAqWFo8Rv1D00sIXzeVrcdM/ShziTV5VFbtNi9s=; b=dFhIy1sSZLQPas
	NqHkzNj58D/iPGQbIAACnFgvkW1nXr8wfoPScr9rtIbHUtekUnyjMXAApuqKhKuqu4hoAg67HawiH
	0bwlURxIPutbfnrEcGb4a1Zh7laVMK2Y7Rymp+3CQlY3xJ1zQwvqYczlOehofmgKsyxzIjc0RMlS5
	/d/7P+t2irYsIlFaYJB9wBsK/5dkOCTfByExX367LaVLs1jIfX3OzTWk8w4cQJgaV2aRp9zyRd+7P
	cJOZ7x6cMVC6sUdedD70bdLg0DRQwCY9dla+XUkzspc8KttLvYPrvrGCaDt8wmF2VcXav7GQRNTmh
	6xNESfvr9M8DRVr/7ILA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghv87-0003Co-R0; Fri, 11 Jan 2019 11:37:39 +0000
Received: from mail-eopbgr20062.outbound.protection.outlook.com ([40.107.2.62]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghv7v-00033x-H0
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 11:37:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PX0pjhl6VO6ryifbx5ipl/iNfpT9FYkRJIajB1vQ4PA=;
 b=EYnXKaWoVwmgZT791zbH0F6I9+tO2wDL/ELmjjjUmnaOmlacayVY9mmLTlDiEjplWxASwDE+tGEXPxuE6LgusBRfpe/5Sl/FacT7x1P4MSELq0vuX3n+YrnTHRKtZlHmRTov5+mZ/ppJw12Ud2rmoVZItQVWudn5AcmDwM5Sln8=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5684.eurprd04.prod.outlook.com (20.178.118.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Fri, 11 Jan 2019 11:37:25 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 11:37:25 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V6 1/4] dt-bindings: arm: imx: add imx8qxp mek support
Thread-Topic: [PATCH V6 1/4] dt-bindings: arm: imx: add imx8qxp mek support
Thread-Index: AQHUqaIFYuJy/O23w0mduCIfSKp7rQ==
Date: Fri, 11 Jan 2019 11:37:24 +0000
Message-ID: <1547206279-26169-2-git-send-email-aisheng.dong@nxp.com>
References: <1547206279-26169-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1547206279-26169-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0085.apcprd04.prod.outlook.com
 (2603:1096:202:15::29) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5684;
 6:2RPNLt80XxEmwGZ8QX11r8NhcSz3iviWPiQDIlXygM0yq4TSXOeyMcncT6qbQInd/rJDWPFVp+WYGrfzJsAxPX1ltBaZWVbcoKBOYNYD3GUvhdgdPs86PzgIsmqcHxcWP+D8v4uIXAevER5FOFvbEhRfM9utiIZXJazBiciXKYbQlKQBGqJJtkNDKeZydgj6fF3NsNetFxphJVXRSm63lUKLfVenq/pm6//hh+HTCMG0iDWhHgY6oE4UZ/q6pq902x7z7w8UiHhJZVn0g6s7PcpIeaDqn8Cr8NTZPcFtFXvHfjV/dOguje9V9tDOmmrXbWZTYV2FHTebJBvHHdlo35RfC0oI0XfeiOdR3E8TKk6wkzyktgfNxwsJ4Qoe4qm7B/dRF+M+Tq4eZeHYUUowGHYSgm2jybGIEVjKf5YicvV0pR8TyqVZ83ok25X8KRtiwldk3oOydx7oPGpNMcSD9w==;
 5:BY2eEDY5/TvZh+Sarp92aERb5itv/KpkVMhkXaRFqVnfsCkPQP1NYMuTuD4oUfCHqSqJ8Bv5d7J9HRyOGEmaI0qOyyh75uWS8L2eNS2Q9xrV90GyATIa6lBQpOkYhrwrXRwmF3x/IK7TCB7a3JZV+c52W5Fy7Bxf7jwyESMNx3/SGLYm/MHL1muYmZUesA81dKbyfE4VRqeP3GNg8sThYQ==;
 7:CpLDmKU+UKvNvR0NRHdajXJl/pfP5/baX5KKPv9IGSSSY/aJ69PZu+vDqxWZj7hWhkNW26PWzi9qt6tosBpVHAyYLh96UkysYHMqvp/CG3jmL6N7vuLUmaWN+eb+LtkINDdZb9MprfJj25LBWQovtQ==
x-ms-office365-filtering-correlation-id: 00d49615-fcf6-40d4-842f-08d677b927dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5684; 
x-ms-traffictypediagnostic: AM0PR04MB5684:
x-microsoft-antispam-prvs: <AM0PR04MB5684578375B6AD57CFBBCA3680850@AM0PR04MB5684.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(136003)(376002)(396003)(366004)(189003)(199004)(50226002)(256004)(2616005)(2501003)(8936002)(316002)(26005)(52116002)(6436002)(14454004)(54906003)(6512007)(97736004)(3846002)(6486002)(6116002)(99286004)(81156014)(81166006)(478600001)(39060400002)(186003)(8676002)(5660300001)(68736007)(53936002)(76176011)(4744005)(2906002)(2351001)(105586002)(106356001)(66066001)(6916009)(386003)(6506007)(4326008)(44832011)(86362001)(476003)(25786009)(11346002)(486006)(446003)(102836004)(7736002)(5640700003)(71190400001)(71200400001)(305945005)(36756003)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5684;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2vOhNGGI7n6sF+s9rP8bB3sEtEVnbke1ERyhtP3hrHlwRb5nz3sDVEQ55VUVk+tnWdfN+RMlPt1N8zjRFZlWrx8vwFTJ2RpTrLy2BbVxYazpEfC+20ujZTV+niYJJ4okh0QSq+RBjCfTzuwA73E+6gjT+hS1MeWvAcxSeT0mc0GEW/yM/3QMCTg/Zf8UYiduw0nDlvw1eCVyTLV3z5YCaaRgFewMhFd75UYbk2v7+6bDYT3dreBzvhqFztJjQ3vUFqCJmPCxNHWLTKQc/08JtMatjiFExttUd/pEKh0sntj2/p8f2vF2xo28meRPS4aaB/6XwCmG7syOykr9KL35V09OMYI3Qh6X5i7PnhQwk0tvEp0hkwvtSUKmVrciaxe0KLYT8KypEj6mAyCkxY3pgaXELRJDRTUvILjpnNelTOo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d49615-fcf6-40d4-842f-08d677b927dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 11:37:20.3385 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5684
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_033727_833138_765ECB3C 
X-CRM114-Status: GOOD (  12.44  )
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
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

i.MX 8QuadXPlus is a quad (4x) Cortex-A35 proccessor with powerful
graphic and multimedia features.
This patch adds imx8qxp mek board support.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index a4d625d..d34fe07 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -151,6 +151,12 @@ properties:
           - const: compulab,cl-som-imx7
           - const: fsl,imx7d
 
+      - description: i.MX8QXP based Boards
+        items:
+          - enum:
+              - fsl,imx8qxp-mek           # i.MX8QXP MEK Board
+          - const: fsl,imx8qxp
+
       - description:
           Freescale Vybrid Platform Device Tree Bindings
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
