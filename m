Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EBBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:45:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5274B2177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cvie3+7K";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bxJUgX/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5274B2177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kjKKtqan36D+Jeb6MiT3Na3uiLvRQqlsao+OP2J7XI0=; b=cvie3+7KbGANG/
	bZfYVrB32hmGvu/ZZlgE/W0xAsJtBqRF8Dd/yFiZ0BmIi3Cs00/mwBsb0EuJC5HPscJ3SugM8Hkqt
	eY3/fVmAUo5egBWeTWodbkJHV2CYRSwiNnSrMIKC/l5p7osoU5sWD8FHNwyrhJvKKPdKGmKg0q5IE
	MIVQQNCaC1gWsopcHMIDRr37wVfuF1MspGqKLOTvkV/Q5zqdv+8TdIyq+N727DwmPqQEjpaxL3bHA
	1L7n4hJQqXeMhx+liso7w1XQtsOsiGEFnoz1jGpxmzY2cCisdq4b9hNoiaLLOUJi+SzG5tejnPMGC
	PmkiPEWLcyXgFjesl8fw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guFSO-0007Ox-GJ; Thu, 14 Feb 2019 11:45:32 +0000
Received: from mail-eopbgr150042.outbound.protection.outlook.com
 ([40.107.15.42] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guFS6-0006gK-Gg
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 11:45:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiGaM5YKyHD5ZZNwpj8ttfuA8x55jKBMPFvp8LNvpag=;
 b=bxJUgX/uNcQKxOfkX3ZfqIzow3Y7VeBT3vGCAKOwPgMp429MlU17PzV/OvqjxISjhPMHmtoWU9YchETvdEhDmG2m93eEvsJXB+pSX0sGFljdOyNbMkRESHQVkF/K0kUQsFoR8JntO3NL/EwkLEPRRMbPlECfhbFguykZcSCtdOM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3676.eurprd04.prod.outlook.com (52.134.70.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Thu, 14 Feb 2019 11:45:08 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 11:45:08 +0000
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
 "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>, "olof@lixom.net"
 <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-watchdog@vger.kernel.org"
 <linux-watchdog@vger.kernel.org>
Subject: [PATCH 3/4] arm64: defconfig: add support for i.MX system controller
 watchdog
Thread-Topic: [PATCH 3/4] arm64: defconfig: add support for i.MX system
 controller watchdog
Thread-Index: AQHUxFq60nG0YKZF6UOCGlfg4d6O7Q==
Date: Thu, 14 Feb 2019 11:45:05 +0000
Message-ID: <1550144346-1187-4-git-send-email-Anson.Huang@nxp.com>
References: <1550144346-1187-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550144346-1187-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0087.apcprd04.prod.outlook.com
 (2603:1096:202:15::31) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b7e3223-1a61-4be1-c6ad-08d69271dc8d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3676; 
x-ms-traffictypediagnostic: DB3PR0402MB3676:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3676;
 23:x1LTYvk7Q5bnqNlKeXX9LsCO61T5gZs8lYB75?=
 =?iso-8859-1?Q?0WL+tBwv6Cbb/JfcqI7lJxaLj7U40dQAPmfUemeT6LO7IQZAW8ftw30vnW?=
 =?iso-8859-1?Q?4gmGp7bSVRpyIsS08fbLvlRuCkG3adJvBRnbgcbtYCNN8pDcZlODS/kkSH?=
 =?iso-8859-1?Q?jD3JArTKIhLF64YZ+1TF05lBwzRQX5U/UVwBVp0O79WTG4Ni0axQiG25ip?=
 =?iso-8859-1?Q?npXkjIYv+Lqw74C9DIalOtzaZxO+xH/DzCMhgsWj5UQC6TfZcgYzfq6t+X?=
 =?iso-8859-1?Q?JRS+LaYbhCcTVcf6Wh+yXmxB6YOYpBaiB0t4QjWmcmWMyv+F50RoAlJOWt?=
 =?iso-8859-1?Q?BAsrLGYnXHKCBo+vunW/TzsJhE5A+Savcr2mfuRHEMQN2DmVHv1GGJk73C?=
 =?iso-8859-1?Q?xjdnJKDJ2ei8nReApctsRfz7k1F3lt/SlSYMwXMZ7GPMAOJWpYFPIwWZn3?=
 =?iso-8859-1?Q?lCshLFR1ISN3diP0uI1k/AnNIsQeOI9Z35+epSSHqjRLt1fPYsmrPIRD+Z?=
 =?iso-8859-1?Q?/CtFw/ywVt0ukyz+WYooF4vQLoL1gYF8yGIf5U6tRRl6RHbPT2lsTyZHPH?=
 =?iso-8859-1?Q?xgTDgPCR2O8HWx8zp8ZTfBDYScE4dlVGS1evKUGXPmmcD4gH3SoIp/qg18?=
 =?iso-8859-1?Q?p3pyB+OWntTnzsb3KZBGsquSI0IQfXbJ2eDEh913RTp3yxCzhO8ou7VQHU?=
 =?iso-8859-1?Q?NO2IDgU2JInxlEPXoexN7oJlGOzg3PP4Ypmoui5fg4jjLp4O63ynwFfce5?=
 =?iso-8859-1?Q?KfBuc4YWnuoo7JOjqQOcYWeyfv5Wz3YtxPbl2lYmr2LNrMiUhUjMZXz9Cs?=
 =?iso-8859-1?Q?0aAO3v2CicRnFhCioCaonUBbrn/Ms/HxzYtIupSplGIX7VPHXkJgx/sWEz?=
 =?iso-8859-1?Q?wYSTP+cgr94W6dpXTiXEGFESu8V+89RGv8zVoVHo4c5X3R6soQVE2dZ4eL?=
 =?iso-8859-1?Q?9Riuptxi2OicHLO3BrDAsArvZ9J5bwuOWdc+Wj6Zw88AJOpl9EYKO94/fz?=
 =?iso-8859-1?Q?Fab7Jt/C7tZBcqGqhRBRZCxLD8c+BAW5zdxrhErUnCWi6kulsWV2l+BoHs?=
 =?iso-8859-1?Q?G8wZsc5kkXDZupwGR/Gg3dPEbWwNppfhFgzitBGY5H7tY46I76vm0I/MjF?=
 =?iso-8859-1?Q?2Uq10ZNauGU8Gd+H0lRCN78/YHpEmxA23rytFUwUgkHhfreh4DdkOwF8RF?=
 =?iso-8859-1?Q?OJ90st8SoOydRzdCa9tjeBqgDZrw6KYW4UFZZYkV5H3yq7WNzjc5PROvYN?=
 =?iso-8859-1?Q?vSG4j5GbeyYw3e8seDI0d/Fzc/Gxk6J/7+1QwlEM4K/Av6W1ZCUMVRk4J0?=
 =?iso-8859-1?Q?Y3e1iue9BMmQmHBrQ3dstxjEh?=
x-microsoft-antispam-prvs: <DB3PR0402MB3676EB7F522B5A9852285ECFF5670@DB3PR0402MB3676.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(396003)(366004)(39860400002)(376002)(189003)(199004)(476003)(2616005)(486006)(2201001)(6436002)(36756003)(66066001)(106356001)(7416002)(446003)(25786009)(105586002)(186003)(6506007)(386003)(11346002)(26005)(3846002)(6116002)(4326008)(102836004)(99286004)(256004)(8936002)(81166006)(81156014)(8676002)(2906002)(14454004)(7736002)(97736004)(4744005)(6666004)(305945005)(71200400001)(2501003)(86362001)(316002)(50226002)(68736007)(6512007)(478600001)(6486002)(52116002)(76176011)(53936002)(110136005)(71190400001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3676;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: awbnYlZZRBH8L+MFKbvU/gKcRnhwmfbZy5b5ZyivWiINA82UU5yHpj9yrJCYh234lHVoP+4QFIakqhNObcHRd+kt3PicgnYr75GxhGs+J90iPryZ2Os+MesQogPXkOlvX19jaD9l8XbQxSa4D5TD9wT5W/2/sVvnT+RJgjxzLdKmZ0Me34x4vwWI9gxV+zYNOu9JIqioo4uDolff3Y9xNxr/ql5ETPJy88BXgwUuX1mlLF5Qe/Qt5z3079XFZ/IJ7ttfCsjadsVTAvgr7g51Ff8/MMWWMKPO9auXY/YyV3phOMC4MJk5X+EqU9KZjQSkK/OLWYSCYWX3Lz/rg8U8AC0A714rGv95fM2o/3UOWTXVYjTJAKHNHZLD86k2NkcrNPSGo7xFwnkUY1dh+672BNZkz8dtoiX93iqmkO03BqY=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7e3223-1a61-4be1-c6ad-08d69271dc8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 11:44:56.7825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3676
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_034514_745630_328FC05E 
X-CRM114-Status: GOOD (  10.61  )
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

Enable CONFIG_IMX_SC_WDT as module to support i.MX system
controller watchdog.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c390..690f4ba 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -427,6 +427,7 @@ CONFIG_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
 CONFIG_IMX2_WDT=y
+CONFIG_IMX_SC_WDT=m
 CONFIG_MESON_GXBB_WATCHDOG=m
 CONFIG_MESON_WATCHDOG=m
 CONFIG_RENESAS_WDT=y
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
