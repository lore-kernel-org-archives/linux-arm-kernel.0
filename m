Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F13AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:44:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5D0222CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rYrjgASk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sVjV+lEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5D0222CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qh1OHN3+PUqkJ+vYPdGntu+OZiwOhLFQHaqB8QNTlKQ=; b=rYrjgASklBkC3T
	557xv+wCW/ma70M4oUvw0Y6wkNgdYpT4hcf5maMoWS1PPQGsNDTB5tBywaCLunoowN2qnYJWdPLGR
	I3gUrCNta94yS+y3rF5YsBeiGQs7GLHikTBDiljajPdg0OPCNVPP2EjwtxCFyj6w0zYmUSCmmPfGy
	M4x/FM6zG4zDHRQOKgPf71DCKnYIc0Vh3unnnOBrXi17vj+zMd70SxBYK8iZ3DnhkNdwvm9ASruPI
	L7oCj/u4ELJvGK1hgoAPBYpgMXQuCh5H62hX2bfZkjRW7xLRvsfj3EIId0SXGOObEbN8ht+95sYDW
	a0uRcR2lVGc+iVWYC7Xw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu7x0-0000iW-Ep; Thu, 14 Feb 2019 03:44:38 +0000
Received: from mail-db3eur04on0620.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::620]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu7ww-0000au-1A
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 03:44:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVP1fyT2RmfrHwiLQ+dv6YOi7fm0E00J3Hr8/iBwVhw=;
 b=sVjV+lEiAoRWy5yQI7ok+j7QRenbmhwou3E1Bf0L9Dg80fO4VtjEWqY6zhJWOOwk4JAWvz6jwFCqgFbq4Kzy8SIsE8YIltokeTBdUVIikGmyyIelM2t25OVElcGvVX7hgityR94p9xC4qwRokxjNxhGaNjg88FGHRakd1/DmEtU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 14 Feb 2019 03:44:25 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 03:44:25 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 "a.zummo@towertech.it" <a.zummo@towertech.it>,
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, Aisheng Dong
 <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, 
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-rtc@vger.kernel.org"
 <linux-rtc@vger.kernel.org>
Subject: [PATCH V2 1/4] dt-bindings: fsl: scu: add general interrupt support
Thread-Topic: [PATCH V2 1/4] dt-bindings: fsl: scu: add general interrupt
 support
Thread-Index: AQHUxBeU4OYcP5Aoy0y86uY2s/lN0g==
Date: Thu, 14 Feb 2019 03:44:25 +0000
Message-ID: <1550115535-14488-2-git-send-email-Anson.Huang@nxp.com>
References: <1550115535-14488-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550115535-14488-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::32) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f98dfc00-ec06-4adc-dffe-08d6922eb6df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3659; 
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3659;
 23:paqdxpeB0UHq69oLAS3ii7PMfo5XTSNGDkVNe?=
 =?iso-8859-1?Q?W6OHcQGI6cqhOOAwVf1QYDqK/4rKxChAJSHQKdghZNHq036BWht6O0kMaH?=
 =?iso-8859-1?Q?g0WoUlWINs17K4zKRU6cL/FnUX8OppS7mccrMG0I0+K/wpLknCrTh8QshE?=
 =?iso-8859-1?Q?1iOEQZuopztnOVr0shKIL6TZ5KyOhW/i/04S8HHsKVoYy/nRJgjVGgYwLL?=
 =?iso-8859-1?Q?1LDyYlwpluXId7k6/O/Z/WoaqL654aw24DMbXD+ZP5E3Y+JZUTkAO2kKYQ?=
 =?iso-8859-1?Q?QDcpTv6mDG2l2u9hOvEYMzmKZ7P+xkh3DeKTK1HHjm/uroLW9tuLLKeDmI?=
 =?iso-8859-1?Q?PE10NLO3RHYSXkG2QL2e6EhyXKX2ekFQw/u6Sq+RuMX04vRPl4OeJAN9Je?=
 =?iso-8859-1?Q?FwhDp6O3Zq99skk4CPOZQpFSCCDWJNGjFre6JUu6InKNISkByadSqx9LYt?=
 =?iso-8859-1?Q?vSnGBHKj7Vi7FeFLKhd47Jt2/7KtphXdhuqf7eYbyS6jZNAEWku1WYlZLa?=
 =?iso-8859-1?Q?X/0Xpc1vJbtnYwCCd+u/5VcSEN6V1av56mmnZs0nv3tQtCEQ4rGY4zHYdm?=
 =?iso-8859-1?Q?o9X8/x5rbFzQFlrfWbjiUpubZI36NliwNfb8Wujndubbxmzd5V8kasY4yK?=
 =?iso-8859-1?Q?zwt8TqK6N6zffUzVhd5SZMfqzPsU+Q7JeVqLv9VmOhedLl6IukeSKrD2Yo?=
 =?iso-8859-1?Q?Vyv4efxjeSztr7HnOOdxVgzgl0srSJcKgCWm+YufBY+G3kLe4Cte6tQsOY?=
 =?iso-8859-1?Q?7XauZ2QRyXc5prf41LWxG08frErKZVgRqZzgzUlyFeSy9oVf43BnVKsrVw?=
 =?iso-8859-1?Q?3xIstRtgjoHJp/0dDfbOzP5u6L+i73OrL8klOoq8TlX0XaQ1xWg/6gZrBP?=
 =?iso-8859-1?Q?7IeUtkdUYqhRTIPWsjjgAJ9xsPygXPnWq49YcvOfMYYzxW33aA9gWRtmpe?=
 =?iso-8859-1?Q?fJbBykZLLk/TUk77vSHget5Pmu1LKRNhIIMPrrTeUfolqjkos+PoVJQPLN?=
 =?iso-8859-1?Q?W31V7yA8oGWMVLdnVMobuREZUUOtqaifeGzQzZ3/bdz62TswYaCPO2g4h5?=
 =?iso-8859-1?Q?f+NEhUPMEil7WKbFUOGsxcc0I+ACai5+TYOSr4y0FVPdVw/fAWGRa0184Y?=
 =?iso-8859-1?Q?obOwbrCSZasqjiRg/EHccBEohSFZKsOu9Sb6D2cx3DqeQMAmd9ur15wToG?=
 =?iso-8859-1?Q?gEQq1SUdme7KbgqisvqI5zq/CV44r11nVDuyenDM0Osmz3QkEZsYaucJ+/?=
 =?iso-8859-1?Q?vEn8DK80KbS6G5BB4a5cPlqokaIqUqThF5ApdePhguheBp8kghoLpoDx/P?=
 =?iso-8859-1?Q?AwTc=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB36596013870C748455ACEB37F5670@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(39860400002)(376002)(396003)(136003)(199004)(189003)(476003)(2616005)(68736007)(53936002)(52116002)(66066001)(14454004)(76176011)(486006)(86362001)(50226002)(4326008)(26005)(6512007)(2201001)(478600001)(71200400001)(6436002)(8936002)(6486002)(25786009)(446003)(8676002)(71190400001)(81156014)(81166006)(11346002)(186003)(2501003)(105586002)(3846002)(6116002)(386003)(6506007)(99286004)(102836004)(7416002)(316002)(2906002)(305945005)(110136005)(97736004)(7736002)(14444005)(106356001)(256004)(36756003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3659;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sAnhMXeu+iR4uwdeGSMewJBXFK/bAZv8gSxkb2+Vj3ua5jB01vUliHITO2jan9BV+N1Mm5pcL0y3bDx679cg0xLj0dpCZZWanHfA+5iPaanfk0moOUh++foOFbBRqgRGyrfz/iSHDTOtopY2IJ/rZPeLPnBGOOuN8g0b275e+TBQsJn7I4PbI3QH/8lqXNXFOp7Fppauqs8mEKoSCf60HyL3VcxtnpSKFbQStC/HLjNRCy97wq8UXQ20JGUKJu5KVixRIOLl8upI5K2FEzmfNag26rRsY2+zRy9hOk3pKnhTL9kil9ebZ04MUQW9lS4A+uoyG48Q8CS2qmhh0Hk53JTeRSJzR3CXB4bisVYzfUDnXAWiqeDwpjcgVr28xNBQknE+xxz4xWP6QYFJH56Xa2zRSxmYYUlcg+J+2Ra54F8=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98dfc00-ec06-4adc-dffe-08d6922eb6df
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 03:44:20.2393 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_194434_108245_9E2464A3 
X-CRM114-Status: GOOD (  10.43  )
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
Changes since V1:
	no change, just update the patch based on latest next branch.
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt      | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 72d481c..8acdce1 100644
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
 
@@ -133,7 +137,8 @@ firmware {
 	scu {
 		compatible = "fsl,imx-scu";
 		mbox-names = "tx0", "tx1", "tx2", "tx3",
-			     "rx0", "rx1", "rx2", "rx3";
+			     "rx0", "rx1", "rx2", "rx3",
+			     "gi3";
 		mboxes = <&lsio_mu1 0 0
 			  &lsio_mu1 0 1
 			  &lsio_mu1 0 2
@@ -141,7 +146,8 @@ firmware {
 			  &lsio_mu1 1 0
 			  &lsio_mu1 1 1
 			  &lsio_mu1 1 2
-			  &lsio_mu1 1 3>;
+			  &lsio_mu1 1 3
+			  &lsio_mu1 3 3>;
 
 		clk: clk {
 			compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
