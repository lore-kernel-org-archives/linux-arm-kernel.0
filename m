Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0E7C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:01:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ADEE217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rHi1Y+ZB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LDPpgCyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADEE217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VJhl88vYSAkfOX8XcfUrINaE3Ajnt4joldkR2t7ksb0=; b=rHi1Y+ZBMAhvHR
	iBG5HinOYxh5KmVLbII9YVvXeDJZ0Zc2u3REyexGxBftK3mBo+x7jelSAQme+Pp6TMzZ2bsAynt5P
	VuNOLTVhEN1EzMMwrvfJE+P5HcufFeEkYVjPwfnARifWc7TfcyZ9ZHY3B1yPtzHDcIp3uI+dDIL9A
	BRIcWsf0lpBiAGnQLaL5zShka9cZ25RsHJpTB2WtS2PzaK6g8PGuQhhvCoZkR9M72lotjUnw5obnh
	QUJpiXQzGiImFAiI8vXt8wj27i89eI/bTnkMahhYl7Xo40iaXoXT36E72lKjsLvpw6gN35wdbTxrG
	0cfM6r1oan9/aWadfASA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmDTT-0006fB-Ne; Wed, 23 Jan 2019 08:01:27 +0000
Received: from mail-eopbgr30057.outbound.protection.outlook.com ([40.107.3.57]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmDTP-0006eZ-T2
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 08:01:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc8d1BABvtW63/QrDl2E9nA93Xi+OTpa6DOfV9gLCc0=;
 b=LDPpgCyzGL7OmqoNhM08a1HD2HpqreiJxbUcXj0ZSx4Ir+hN/25FqOryDrEf5mLBhYIytInJOlGmCLT9o9jOiwimlsVnwrKpzHHrC4uExJ1WUMgDWHJ+/JlTOjLTf+2xL1kKXw6AyT6BIlsr7LwqiuJ1Wvu24UjdiKF0T/VvTGI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3851.eurprd04.prod.outlook.com (52.134.73.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Wed, 23 Jan 2019 08:01:12 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 08:01:11 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, Aisheng
 Dong <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org"
 <ulf.hansson@linaro.org>, Daniel Baluta <daniel.baluta@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/3] dt-bindings: fsl: scu: add general interrupt support
Thread-Topic: [PATCH 1/3] dt-bindings: fsl: scu: add general interrupt support
Thread-Index: AQHUsvHOk0zMHq5joEWG3q1+7cErPA==
Date: Wed, 23 Jan 2019 08:01:11 +0000
Message-ID: <1548230179-26076-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0142.apcprd02.prod.outlook.com
 (2603:1096:202:16::26) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB3PR0402MB3851;
 6:PjsM4vLU6T05JdVE31bDcu8ZZJI4+SDKfoJSH12+lNtMT2tHCAZ+h5sT6Z+dtgVFqsxHotmmA/jCoJZqcw8yIqrHDjZdDCqDbLem3zzMbDtlMvZZUOvkJ6gTuI572E6xAboDIMpJaaCBmbR+zccaV8olM5Trb1PD/GD+x444eCCfABjgYHCr6T22mQYRcvt2JRHZ7pxhFscZ/cDuDAWSikQU0Ete+uuTiLCbO50hxICALEVDqBYMchEroNVqh9Z7Nt9KeidyHnVLaTP/4B4m0IXpCq/PpKWYld6dduatEoGHlkJbQQSZ54pmVsCe+nOuNOTH6Fw2v11U9IgbaJCcYkZrQgGQ51dIyLc5omJAK7nH0i3c/dGBPYn71AksoqzOzhCFVOWreIZMkWtE5CJ8nX9WlScAiNf+69a2QCYWAugEGg7+ORC8a3zc+/grNT++7902+RTBEa8buN9+LckFSA==;
 5:KfWNF7u9Q0MedNfKd9Pho/oJXARMa5nroJIiIULSaors0+eXxWA68iRO7u6/RYEDV0NmlkqVjWGJY2jPD06oGiTGQWNzd2FXbIwtWTKAMVNZqRyRlynh7kvS73lcWurTNdOcC26cBE9URSuWmvGAaHIyI4zBkIK3xubNUuEabSh84gLtcZxNfipgtEd6+UZMKyZEVydyv6Z5m/qd8QjcxA==;
 7:ZWm+JcHCstpqmL9bk90vOxbKJt4Z+5JvucFlr32lu7y6bKCqWRd3jZBk6i3YS03khSr53tE6GKQfgODmlP/nS5jLJAxOaH3GcCCOo3tqOnzq8LfDt0EMrn6t/J3JGPukZiJn4IeaFrMyElbGC9Jggw==
x-ms-office365-filtering-correlation-id: 518b5842-f5af-4eff-4531-08d68108f09c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3851; 
x-ms-traffictypediagnostic: DB3PR0402MB3851:
x-microsoft-antispam-prvs: <DB3PR0402MB385108394C0680BA7B1088FEF5990@DB3PR0402MB3851.eurprd04.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(39860400002)(136003)(376002)(366004)(189003)(199004)(39060400002)(14454004)(106356001)(25786009)(6512007)(4326008)(478600001)(6486002)(68736007)(105586002)(36756003)(6436002)(53936002)(97736004)(7416002)(6506007)(66066001)(86362001)(102836004)(386003)(6116002)(2616005)(476003)(3846002)(186003)(2906002)(305945005)(71200400001)(256004)(81166006)(316002)(81156014)(110136005)(8676002)(99286004)(50226002)(8936002)(71190400001)(26005)(52116002)(2501003)(486006)(7736002)(2201001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3851;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oiEUAPx13lw8fBaFqcoHVXRfN1T2cFSy0ivEKq8UhO8emhV3lLJFKSuVrgU+1m8rdfMt+wdcCPxnA091e1p2EJ7F/tO0MLRF9GWqgv/n2afdCWK1+8+03WlnGIZBYzSKKnnGePOwPgS19TaZebFUzTRGwQZyyleYeay7o7Ozx9LObf66Zs+8EHHyDYyVQkW61KMVCPheIyWrYzXnY575gidhvCVx6UZ6TH6c9FWIrBRThMjztjVoc/UfA1ijv3uH7hds8YNfdtiR1MXXJRFiv/blxj3hx+0kgqnFi2wWakJoAOqNZYAS41Bsp0oVY987l2jnhQ76JxwGL/olwvDYfEE1xovbIf7+VBu8cuN7nD8l8rmL6YwMH5rogn8E2khYqRXh+JHDipKXfw7ygsjP8OwBsc2mWwUWERxMDGQ6h7Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518b5842-f5af-4eff-4531-08d68108f09c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 08:01:07.2716 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3851
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_000123_946829_F4C39E44 
X-CRM114-Status: GOOD (  10.54  )
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

Add scu general interrupt function support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt      | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index fd2bed2..3c976ac 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -22,9 +22,11 @@ Required properties:
 -------------------
 - compatible:	should be "fsl,imx-scu".
 - mbox-names:	should include "tx0", "tx1", "tx2", "tx3",
-			       "rx0", "rx1", "rx2", "rx3".
-- mboxes:	List of phandle of 4 MU channels for tx and 4 MU channels
-		for rx. All 8 MU channels must be in the same MU instance.
+			       "rx0", "rx1", "rx2", "rx3",
+			       "gi3".
+- mboxes:	List of phandle of 4 MU channels for tx, 4 MU channels for
+		rx, and 1 MU channel for general interrupt. All 9 MU channels
+		must be in the same MU instance.
 		Cross instances are not allowed. The MU instance can only
 		be one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
 		to make sure use the one which is not conflict with other
@@ -34,6 +36,7 @@ Required properties:
 		Channel 1 must be "tx1" or "rx1".
 		Channel 2 must be "tx2" or "rx2".
 		Channel 3 must be "tx3" or "rx3".
+		General interrupt channel must be "gi3".
 		e.g.
 		mboxes = <&lsio_mu1 0 0
 			  &lsio_mu1 0 1
@@ -42,7 +45,8 @@ Required properties:
 			  &lsio_mu1 1 0
 			  &lsio_mu1 1 1
 			  &lsio_mu1 1 2
-			  &lsio_mu1 1 3>;
+			  &lsio_mu1 1 3
+			  &lsio_mu1 3 3>;
 		See Documentation/devicetree/bindings/mailbox/fsl,mu.txt
 		for detailed mailbox binding.
 
@@ -130,7 +134,8 @@ firmware {
 	scu {
 		compatible = "fsl,imx-scu";
 		mbox-names = "tx0", "tx1", "tx2", "tx3",
-			     "rx0", "rx1", "rx2", "rx3";
+			     "rx0", "rx1", "rx2", "rx3",
+			     "gi3";
 		mboxes = <&lsio_mu1 0 0
 			  &lsio_mu1 0 1
 			  &lsio_mu1 0 2
@@ -138,7 +143,8 @@ firmware {
 			  &lsio_mu1 1 0
 			  &lsio_mu1 1 1
 			  &lsio_mu1 1 2
-			  &lsio_mu1 1 3>;
+			  &lsio_mu1 1 3
+			  &lsio_mu1 3 3>;
 
 		clk: clk {
 			compatible = "fsl,imx8qxp-clk";
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
