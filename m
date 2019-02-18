Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E30C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:54:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FAAB218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZEEI3MvJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RHOecRwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAAB218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QgTOn68vHmfyiPzqbu4iI2EhpYgnPYwSPKxgTuI3CK0=; b=ZEEI3MvJXcqsa1
	ndEoEItQmutklKvk0dCtMzhtTXjQImm4E8CJgrMdkXgHjd7XJBBz4IS2kcI4OYsvbiL81YL3WzW/Z
	p93laEAVO3dpDFU/2wSdaVJ5HXLrYn1a1zYjq4y7N1OPlGCOvvTngd6iz2WszSrOUfQKCLBf4wTHJ
	tTs3JS2euyJk6a6y5gTm78+18JjHGw4HVzaMdZide5Mq484xsSRYjNWbbNzf2JIID3/D1lMt3sudo
	wX9oIMG/aZfMr0HE/rACkThOhhclhONeJ5NYrfhjtuA3L12WhGTKTIkcsWbjXt3nMwD1D4SczJrTl
	fkR6GUwJ8/ANwt4wFomQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvcoV-0002JC-93; Mon, 18 Feb 2019 06:54:03 +0000
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvcoN-00024A-0S
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 06:54:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCNTAynTg2q8AA2gyzNGQFEWGQmH01CDoDn7y9XG2L8=;
 b=RHOecRwIynovovZWkjo+kqk1OSDuh/MiG0M70Qvw7K62iTP+zdMAf7O/J93VVV8vDVi5O993S/HylmvMPuAcDcE10mCr1FFyLGa4BjqWAEaoqgvCq0xmJb1pLlbJhp4x9ptYfpDNjp8LvUfw+Hp3H5uwsKa6nhgEL6nVuWGIS+g=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 06:53:49 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Mon, 18 Feb 2019
 06:53:49 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
 "linux@roeck-us.net" <linux@roeck-us.net>, Aisheng Dong
 <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, Andy Gross <andy.gross@linaro.org>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, "heiko@sntech.de"
 <heiko@sntech.de>, "arnd@arndb.de" <arnd@arndb.de>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>, "olof@lixom.net"
 <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-watchdog@vger.kernel.org"
 <linux-watchdog@vger.kernel.org>
Subject: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
Thread-Topic: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
Thread-Index: AQHUx1azBL+yCPCH8ke6RA/LaBE/tA==
Date: Mon, 18 Feb 2019 06:53:48 +0000
Message-ID: <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com>
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:202:16::17) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0850e54c-5c38-476e-5fbb-08d6956dd56a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3707; 
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3707;
 23:6y/u9uVkL4q68838GB376I9nX+cVMi4gG6YC2?=
 =?iso-8859-1?Q?cy/fWQcsLeH36tROtwkg60xN8OmhRNtJn+T/GDLFlppU1wVTw4ExlWjbzj?=
 =?iso-8859-1?Q?yJh8sNk0jgr+tzdP7l6XQNLsSBa/Nj0fapgvNalye/YtNA/vrP/Mb65xyM?=
 =?iso-8859-1?Q?dw8RZSwKqz6xD/PdRbQEERbqK0oYuePS0AsWSdwiGu1R18flJsFHzkEMKV?=
 =?iso-8859-1?Q?eQCaur0ZAY5NkaEXzF3oORBitEIar4BmIf5hyLIMUwWV27imhaBV7oMTPn?=
 =?iso-8859-1?Q?Kkrm+FSEzokCiRHhLsbAP8WH1DTy7b5k3+h5CLqSF3BfIom2nZoRQUEIdg?=
 =?iso-8859-1?Q?Z/QnzP33RC76l3RjKfBXA9xU0ROkuFGQmvbZpQODvEh8EF9+sdvHt69Rt2?=
 =?iso-8859-1?Q?RhsVM+q9iq37GRsMvC3/NKgJ29kzKjTeXatMIFasxn3gMuhNb07eDiTLDR?=
 =?iso-8859-1?Q?gxZS/CR8Zo2yEMyWGi8ILay2ay9LCy44d3ZIhKVGwjpLZvQWuF3ruWA/QG?=
 =?iso-8859-1?Q?cKXVCqqnla6vGZpgxfsmzQwAUCxdhUW3qeMtYF1bzqDXYkENmPO3KuQsvH?=
 =?iso-8859-1?Q?IKsRHf5vfdXZSJSS7hkOmVVZERJ5sg2Wh7klHCw0l+XjNkcZTl9b4Cqu2j?=
 =?iso-8859-1?Q?Gib6PWFlDMMTW7dIRliQdqCBWfUBDRYBr08aCHKEquuxBWj6Qa3p4Cdn1R?=
 =?iso-8859-1?Q?7NFze3mDIFP+vaqzl+IN+7Fw13hZRxAN2PwZTV+9dIhL3iORH3CgPYAMJ6?=
 =?iso-8859-1?Q?d+VOj4KCCoqsoGvfTGFex5m1QSI9200Kdm8+C9HLjjRn4fSqB2zjQtVPGT?=
 =?iso-8859-1?Q?oKgfjpDQaI1KBOMHLmKpd7YHFmZkMZHBCgxi5r1PP3wxEHHJkSPn3LqjIl?=
 =?iso-8859-1?Q?MLlmqBHje2aOtIlGb2H/QPRUG4I94kkccpmw4Uru2DeEvevYkTA6VcOc1p?=
 =?iso-8859-1?Q?UJkwba3A+gZKVDPaWiSr6iXBtxf1wLb1W+SpBz9+0u0ELOfnxEZJ8xtKLZ?=
 =?iso-8859-1?Q?vkcZTtuaDUsDiVJl8TmM5EVmdlNhKmR+otoiSV0+XcMO7SyVJ0TIxnG+Q+?=
 =?iso-8859-1?Q?FWNxn6wt5ez0H9QECEsCromUeWa6w0VkOo8uM5oc6rZ+Xu/5+EaE94Sj2a?=
 =?iso-8859-1?Q?PkLitwXj8fPTzZGyrpUJ/JFWZHKLiNafj1BiK7b2utQWL9okETdQhr93sY?=
 =?iso-8859-1?Q?pOvRrAdRRo1e+3ooDJIARg+q5SrK7FsJUlm86faUD9wRC5k367NfLloWD4?=
 =?iso-8859-1?Q?Da5eWtSl5ml6tQWjarHmKgwryBuQW1R7xksB9mBXbqd9d5kdo1E0rfok8J?=
 =?iso-8859-1?Q?uWgQ1h81aJ8o1Y6mkXYGwFahi6AafYViS4dkS4hnbTQMzUg=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB37070F694B18B03960D44C26F5630@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(39860400002)(366004)(136003)(396003)(199004)(189003)(305945005)(71200400001)(71190400001)(217873002)(256004)(76176011)(5660300002)(14444005)(105586002)(4326008)(7736002)(25786009)(476003)(2616005)(106356001)(53936002)(8676002)(11346002)(7416002)(316002)(110136005)(66066001)(2501003)(446003)(486006)(6116002)(3846002)(86362001)(81166006)(6436002)(8936002)(68736007)(81156014)(2201001)(6512007)(50226002)(102836004)(2906002)(6486002)(26005)(478600001)(36756003)(97736004)(386003)(6506007)(52116002)(186003)(14454004)(99286004)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3707;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BRRBhFeOLuZms7r9HtFn+GWelMVt2obVZi1OiGnuGDP8yY378I19F227WigDiAcP3DDCCNYQdy02Vp7j8Ocnui99CFAEHBEhIXOXFEre8HEq1qlUGRYWChJhCfXbuROxr/zVEu1CnsetjGgMYHJdX1R7/BxkOBSekQ4FrdsfASHKg4x1RR7NbActB64MOsmX6Q2zVy9dkvJvyzZ4eiVPOFXPYeIdAfX6NbCWf+e4dpinPRZc2th13/h/wy8/QZnBtqSEqZTQbSTjJ/RahCX5RSj/xhrwLC3ECEC9AYtj1OXAJoVhZY+vx+lvmh5JtDbfBo8OWQfvfKqIEV989D+hbY9Zim1BJyQDif1JVsWeMw3GUxWk+w1evSbe1wScNzzW7RGK5jozWrEOMQnDdBjNfVEpmmHWQ+2IYDo1kM9DKF8=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0850e54c-5c38-476e-5fbb-08d6956dd56a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 06:53:39.8394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_225355_328716_D0FAF254 
X-CRM114-Status: GOOD (  10.38  )
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

Add i.MX8QXP system controller watchdog binding.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- update dts node name to "watchdog";
---
 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 4b79751..f388ec6 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -136,6 +136,12 @@ Required properties:
 			   resource id for thermal driver to get temperature via
 			   SCU IPC.
 
+Watchdog bindings based on SCU Message Protocol
+------------------------------------------------------------
+
+Required properties:
+- compatible: should be "fsl,imx8qxp-sc-wdt";
+
 Example (imx8qxp):
 -------------
 lsio_mu1: mailbox@5d1c0000 {
@@ -188,6 +194,10 @@ firmware {
 			tsens-num = <1>;
 			#thermal-sensor-cells = <1>;
 		};
+
+		watchdog: watchdog {
+			compatible = "fsl,imx8qxp-sc-wdt";
+		};
 	};
 };
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
