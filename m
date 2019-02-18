Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F1DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:54:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6AB217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EQYFtM52";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O/HYEVit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6AB217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b0SdG/F/YY/zHtT+qACen37OvUtP9krH4wQ10rICIzk=; b=EQYFtM52k58BbM
	bnYJBve80g2hk+jND/mA4Zm3CTmjk5p8tUuKYsc9Bla865BjcSAFUdBzpc2jRW74xr5oPIBNad8Lr
	dr//sINHW17538alR4RhOlQc8B9sOhe2ETBddIiVioze3o9NiiSGVAGh2Hiw+FKexvsp3dmZoiabT
	D6CtHKiTtmEVHGJGbN8CFoCfHE9rjwhiBQQrmLmaVi45Ip7ouF8rdrT9NWamBNgGcaZ+pRXKjBSjT
	2/UUO23eYF6P0MHdPLQV7kBZS+jq8InUdnhHRl7GW53IpFK60ueWU9VIzXvLsIP5cAFzvoUk64OAC
	yhcBjDnfGdd4LA3m1vGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvcpF-00032N-N6; Mon, 18 Feb 2019 06:54:49 +0000
Received: from mail-ve1eur01on061b.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::61b]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvcoo-0002bN-HD
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 06:54:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMF6mfksn3469BaI3W2QlVEM3a4LL5OsTA571XEYlek=;
 b=O/HYEVitOT6IFHgB0CEOXcTuGl1YVR4TWaxuFFxsMy+J5dKffZ5tkzPx3Ua6IelSso8c0c5surl8sqMTo/mjZe+I77vEtv8Y8h4PamFHtYtfEA6dgi1F9KXmMuubhZ7t86B7SIev6lGJsy+kG8StxOTq/l3x1+G2l38fLuIV8+8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 06:54:17 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Mon, 18 Feb 2019
 06:54:17 +0000
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
Subject: [PATCH RESEND V2 4/4] arm64: dts: freescale: imx8qxp: add watchdog
 support
Thread-Topic: [PATCH RESEND V2 4/4] arm64: dts: freescale: imx8qxp: add
 watchdog support
Thread-Index: AQHUx1bE/VGkGSoFAkyRycenototrQ==
Date: Mon, 18 Feb 2019 06:54:17 +0000
Message-ID: <1550472539-16590-5-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 4800fac1-7676-49c2-1898-08d6956de66e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3707; 
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3707;
 23:5ZkZ4jJ8vEONpyEH1vNfqYLIOW8pbsmnSgpRD?=
 =?iso-8859-1?Q?UePm5QJYj3YjprfPnM40DWG555RTT0C+ybSsP0ftvHuTDaGAOTcZUKP2OV?=
 =?iso-8859-1?Q?HYvZZghYA+aCc4Z/X5yHt0TUkIkQZmIqZLdXXZCA2LyBuuNUnv0j2kBvRf?=
 =?iso-8859-1?Q?kTOlmKyhSdQ+uzhoBFfQIklDmB8dnHHk2POF0R/vlV7Ra8NLGng3krj97/?=
 =?iso-8859-1?Q?vzypNGFeaL2dllwxk36v088SjM7kc97Lvj6DbW4/5PAyQht0KBjMVrNdkg?=
 =?iso-8859-1?Q?OWSh8gseuuqAOufYuoJJHmF5aVOhvnAsNklyxjO+93BjpvvNb451ZH/PA6?=
 =?iso-8859-1?Q?Fasq/z9ykQEpU3Bl4oJsexU/yiOvgkARtrDt+JB2H4+SVbgAaUwfECFHRD?=
 =?iso-8859-1?Q?jDsDYj3oWU6MZR4S2n8H0XCXC6+HOCCA2ZFMKmGuG2aXeA2baDoYmtRQuW?=
 =?iso-8859-1?Q?cL5HswEKmTnnhtczfA0VGkt1rYVoioRtrIkg0/4qJWpEaYut9HjiQyAfVB?=
 =?iso-8859-1?Q?chTZSnrpslMga/lazTsrnHjugdokRXZBfJrzLyapna7uVdiXLwJweZG7qM?=
 =?iso-8859-1?Q?HNLmDd/sLz574rCe28KvtVWEO5cNlKtRvJw7UR/Ote0SLdsGV9oiuFa7rF?=
 =?iso-8859-1?Q?u3oyFd8R+0iBAoeNdhg72TZe3nRb4BNIT7ZZLLO3dLaEuOFh+yYgahGYW1?=
 =?iso-8859-1?Q?p9t01py4vUhWUqYOKK+G7olD5WkM1a+My2UGrlOa8s+x55GqXEBSGpsdhg?=
 =?iso-8859-1?Q?KnpHR9db4xMpC0Kqvr7xHzO3GOtpDjnKMxiHB/5i8ifriWOP4W6aLTgNal?=
 =?iso-8859-1?Q?VGjJpaXe0jav3exkRr0mFCMDfpk5O3UtakTvOh00Xb3OGeDI1rwM+HRRzb?=
 =?iso-8859-1?Q?otNGM3YQ2HfxL9R5rtSgDGobgYQyvYDPYvhHbZ8HkFrQoZEAhJGNuKUurz?=
 =?iso-8859-1?Q?l/uLQX1WALaT/gZlzZ2TBfI2Q2YDmzecKMu82kaFkhjsO2eEH6sGo60idp?=
 =?iso-8859-1?Q?WsZUkfUbelGLOFM5rnN7UQlJfY9IQNIi6jJgSeCZ5czycgyBknxxfOl8MO?=
 =?iso-8859-1?Q?3rWxdwEOaIbym0ZY3ekdoweYgiIG29nTUiC5Ga3ZqEaQXzbT/LSwwGJzt1?=
 =?iso-8859-1?Q?fhfcOqXsmN8KGdrNKvQh6oB6uRQseWcAvodFGYRUGJNRT3tAXMWYmjPiGy?=
 =?iso-8859-1?Q?+7rQIDH/W2eEQC/b5f9nTnDnw+OnJOpmPUCYcUj9B8cEZNgR9JaperFRIo?=
 =?iso-8859-1?Q?KAHVAvhNkArPuEYyjYrwm8IcwptsuxrXG0ChU4UQz8+4acxJTY+3Upb1q7?=
 =?iso-8859-1?Q?ED3nSy08Q3wAKS8CXRbOuYYESLtUj0VNlgNI+THdzGcVDUwHYZp6A3DT3j?=
 =?iso-8859-1?Q?RPweuDGHnY=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3707D4DE56802D6D00E0A8D4F5630@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(39860400002)(366004)(136003)(396003)(199004)(189003)(305945005)(71200400001)(71190400001)(217873002)(256004)(76176011)(5660300002)(4744005)(105586002)(4326008)(7736002)(25786009)(476003)(2616005)(106356001)(53936002)(8676002)(11346002)(7416002)(316002)(110136005)(66066001)(2501003)(446003)(486006)(6116002)(3846002)(86362001)(81166006)(6436002)(8936002)(68736007)(81156014)(2201001)(6512007)(50226002)(102836004)(2906002)(6486002)(26005)(478600001)(36756003)(97736004)(386003)(6506007)(52116002)(186003)(14454004)(99286004)(32563001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3707;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jgsbUitUZErGQbuEmIzRxYRmSMSI9xhaw0l27s2GUs/ucYqNwgMjzviq6y8ar8566aHRLLJpi0Elnges+X/3JAlD6pivv7Wbn7NCAY2IFOGqHfSU4I6HchJR6yrkU8fDKFAyOU7ucXjjLE4daB9GbxeT7AnA+fxwaPb10bZLoOQCDv+e+PNyBrDwKSYOQTy/H6EfhqLV695K1YN65e2Cc/Rjh8/UO5R6AYZgDPvVd6E8PdEvrS7FvG0XNG8wkkOxz3gx6cIENXMdKg7Yp1FNZJbGMz7xhTwX2B9IFf38RKuLTn5sHqDvZEbfh3cj3pcBw+7k3GrPykXCgXH7s4GtsYkr7LJWiCLBhCimvUmUSPFAa6jZQrKUuQqCG+w7u4moc+ybx6HJVuxCGhJoncoDchbN4tJEVxcyyrFFzgZA2RM=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4800fac1-7676-49c2-1898-08d6956de66e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 06:54:08.2389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_225422_969120_CCDB30EC 
X-CRM114-Status: UNSURE (   9.75  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add i.MX8QXP system controller watchdog support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- use watchdog instead of wdog.
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 88eb04b..bfb77a5 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -123,6 +123,10 @@
 			tsens-num = <1>;
 			#thermal-sensor-cells = <1>;
 		};
+
+		watchdog: watchdog {
+			compatible = "fsl,imx8qxp-sc-wdt";
+		};
 	};
 
 	timer {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
