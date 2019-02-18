Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEDDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:53:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D07C1218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W9qZ/rnG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X5hQz9mH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07C1218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=m9u9wWhzK7tJzGuA3jK99vplF6XFqr83N8VKDVkRIL8=; b=W9qZ/rnGb6ktl9
	ifE34aswQh2oRO2P/cGYc9rZpaeON1XnWW9GYFY08fgWefVwcxz5Tv7uQ5mHGmm6vT36IwRHUitJq
	XFUltHDp6tk+sm+2LIjejq7RBbhiYwe7osXxUrvUZBVe5Lk2dRLwRqbESLTpKn9bALopEhOgyE4PY
	si8oKMUceLMxPCIK+NTTAw+vv+XlIqjjut4ALPf0zVs/oswL4dWEloSNg2iihul0eRiScGOMJWQfr
	Piasd47soQ7pYqYAT+Ctr8/BLC83TZQszbAg+mggbEunibvt3kZjKv3N3Op9ZcsqATPumG2KNIyAN
	CJn1gq1MMEVuM77pWozw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvcoG-00020h-Ua; Mon, 18 Feb 2019 06:53:48 +0000
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvcoD-0001zo-0w
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 06:53:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrM9BCm9y7Y1cuUfJyUAeEJToBuXD9iRMdPf1FUA2rM=;
 b=X5hQz9mHzddw2lgPlisgFarS1yfUDkoCKREkcwVHJUmB7lxpt5f7bzndLkLb4quowHIF4G8Q/fjy21oZR5HeneiXT+VhFfoA5NHunLZr1zR3mLHpKq9TEMufwzSBjDXWwiyXsj9bUHMe0JYo+Nf4UgyK4sefFZ7JvA40nmg+cOg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 06:53:39 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Mon, 18 Feb 2019
 06:53:39 +0000
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
Subject: [PATCH RESEND V2 0/4] Add i.MX8QXP system controller watchdog support
Thread-Topic: [PATCH RESEND V2 0/4] Add i.MX8QXP system controller watchdog
 support
Thread-Index: AQHUx1atSP6lSFBBKUe5Cz27IkPE+g==
Date: Mon, 18 Feb 2019 06:53:39 +0000
Message-ID: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: f380aa6f-73d3-4fec-21c4-08d6956dcfd3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3707; 
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3707;
 23:RBuINAoncevKsKcqWFPkOm1449Zw1S4eVpBXl?=
 =?iso-8859-1?Q?CQyO8vDm+GvmWn6xj/PFvn4aOinmjUrGX9kbMcxfEcLcTVWdahr0PJSxG1?=
 =?iso-8859-1?Q?QZLJibtv+FGtcYYAWHIyqG4wjL713hZzzffwCGVDVg1WE8Frzx0OnExDJ5?=
 =?iso-8859-1?Q?S7+6qvz3OiKhppYP1S/XP1xGXK1CQgcH/Vm85UXPjxbLxy6l1NzoPKU0Dn?=
 =?iso-8859-1?Q?rqY78fcvD0sGWjLAImq0D6+BS3esqQ55KyOjz3UxpcgwGGjYmseAVgz70s?=
 =?iso-8859-1?Q?RtjQu9fHy/miEw/fJhFUfQvudzTOdFKXDSRO2SjFAn1PY+c602hPh7F3in?=
 =?iso-8859-1?Q?1/JbW8SpIbcWE309I/fww46zZB1UhXnsltSv5iS/cdfqmjEWGreOWwgP10?=
 =?iso-8859-1?Q?RbHbkG/VQHdzX8oi7mSN5OlNtm6pMkIiArA2/55d0V+8DT27m73fLf0jpo?=
 =?iso-8859-1?Q?AM0swvI/vJ3zy8FSKpICxU9dsA+rcYeZ0IhDMLlM7s6mWjn8Sjw5a9z96Q?=
 =?iso-8859-1?Q?/XPaCxX3E5VXCG+Fn7bjVt7E0IJifK+Y6+tv4KYEbEzRiXOKjnuFuSnV0x?=
 =?iso-8859-1?Q?HzI+nlrdva+GUfJ/fl3OV3XXtvxk2Xcs91Ilc3nil/OmwUOnTRv/Jot+Fo?=
 =?iso-8859-1?Q?LkPPUGDda7OrDDoE8aUvIjf4MbQNS+soztS8xFTcC9ZbPelBYoSRldTulx?=
 =?iso-8859-1?Q?5SjMiqU8Pv48+KxWbLhyAS7R0CiiOU2+2YfxAUdLY46odP4HVH71v77t7c?=
 =?iso-8859-1?Q?voB6m3FTvyb2CCGEL9Xs53Rzh0WNE2AdZzJK5VBYUjxEXjPnaaw1VdgWN+?=
 =?iso-8859-1?Q?ey5feWD8nmOBtRrQ5XDh3iUHINBZzmtOZBaxlKqNk0GkEqbcRws6ZlprGR?=
 =?iso-8859-1?Q?lkWhzoX0udHQ/ijgq6KxWgXofdNlhBHjki/Dyy3gY4z7ZOJaHwv0ZQWScl?=
 =?iso-8859-1?Q?f8LAiOkRQQHgq7NBqj0cGqiDzp6hIKPdwN13dnjEp5b6hbvI23uXcrXbwM?=
 =?iso-8859-1?Q?7OZHh7mGsGDZE3V/5uFYf7OImlafZqSkGyeTgpPeE4y2UZGPFdRcukFfjh?=
 =?iso-8859-1?Q?BtMpwSHyVZ7GCYhpmiW0W0WJLWiN6dypBgyJRSKCj8Daj6hEv+e08kf9To?=
 =?iso-8859-1?Q?T8dEzcEgWLB88L0BS9fkgh7GOpOsl31kGXmoEhaHtS4Ht1xEGh0eOOGKM2?=
 =?iso-8859-1?Q?JfhGP7R0y9ohg1aFaJ1MQeciGQJSvr3mN5wyVeJo7w3+dDoeD3oM67yPgH?=
 =?iso-8859-1?Q?KbGldj4eUf5x1hOlwAPYhXDAmSKCLKXpP2S2P3TBW+gWIxyYPji7petZQ1?=
 =?iso-8859-1?Q?nDBVI178ZVl9y31OZSSwaWL1I+6p3i+mcY+OdSI8F7Tb+gQ=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB37076B11FC1845C473D630DCF5630@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(39860400002)(366004)(136003)(396003)(54534003)(199004)(189003)(305945005)(71200400001)(71190400001)(217873002)(256004)(5660300002)(14444005)(105586002)(4326008)(7736002)(25786009)(476003)(2616005)(106356001)(53936002)(8676002)(7416002)(316002)(110136005)(66066001)(2501003)(486006)(6116002)(3846002)(86362001)(81166006)(6436002)(8936002)(68736007)(81156014)(2201001)(6512007)(6306002)(50226002)(102836004)(2906002)(6486002)(26005)(478600001)(36756003)(966005)(97736004)(386003)(6506007)(52116002)(186003)(14454004)(99286004)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3707;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D8DWC7z2VCMd0kU6lxwCNfKX6bmc8jeMgVmXCWrNC3bfYJkfg/n0Ck/Y/S+sHwA9pnYU106HM8wGiicDNQzrOff7/CwJoJ99qZg4trVs5ltz2SKd3PI8KlWKskEGmpyH6NfUVOfq7+TNLTTHpTw/98MXq+q7pBm8XO6T7akjGLhsaEyUhpWIN1S1Ig5RxKS80wFMTgDXuWYh6UU5O8NSpPIoQoUKSY/A0G9eRgO80QgujwYcD+60FpnIXlo2MiJsRg8GWB2I4FaEdJgHXpGwd4wbmVwRfnM2Gsg1eKMu8mUNpd3KBGBF9E0wz1Z/20gdDap6QmVXbpa1vZ6U/ZxxBlUxirg/6LQEao8KDVoHnR2yrE4UmfzwBap5w8zkJtGYfaq+CJ5BUkRAKZR2OIYEbrrGsZwLVgjGWVBJUrFHf6s=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f380aa6f-73d3-4fec-21c4-08d6956dcfd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 06:53:26.2026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_225345_068586_C828B1DE 
X-CRM114-Status: GOOD (  10.31  )
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

i.MX8QXP is an ARMv8 Cortex-A35 SoC with a Cortex-M4 system controller inside,
the system controller manages overall power, clock, secure RTC and watchdog
etc., so Linux kernel running on A35 needs to communicate with system
controller for watchdog operation, this system controller watchdog will
call SMC to trap to EL3 secure world ARM-Trusted-Firmware and then it will
request system controller to do the watchdog operation via IPC.

This V2 patch series addresses all the comments from V1, and change log is inside
each patch of this V2 series.

Below are the patch dependency:

The dt-binding and imx8qxp.dtsi patch are based on my thermal patch series as below:
https://patchwork.kernel.org/patch/10800699/

Anson Huang (4):
  dt-bindings: fsl: scu: add watchdog binding
  watchdog: imx_sc: Add i.MX system controller watchdog support
  arm64: defconfig: add support for i.MX system controller watchdog
  arm64: dts: freescale: imx8qxp: add watchdog support

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |  10 +
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   4 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/watchdog/Kconfig                           |  13 ++
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/imx_sc_wdt.c                      | 210 +++++++++++++++++++++
 6 files changed, 239 insertions(+)
 create mode 100644 drivers/watchdog/imx_sc_wdt.c

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
