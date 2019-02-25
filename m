Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9609BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:19:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD392087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 02:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k0NuEmr+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ne+3gz4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD392087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ezmW1sNuLkdJYaiTi5tfQ8KjiYmDHhaEkVKnIv0fVC8=; b=k0NuEmr+mnh/ko
	H1WrEGSU2WHXagVcwRh+HC7wNQ4uEhnnqayLR7QtOmBrEevNeKHNwE6zOxMjrxxijcH1Wko2BHvH+
	0r/6q4PiRXnF4FI5ersN8UnR9TwL+xIF/94c7A1iCd3QXFId5zo4iRIRGECgh8qaSDFMIDCwWBfiK
	WjJuFVojSiUp8ezwcY5EEmqQxD2h7QpRvgueUZle3juqcujp1ZHYESIVQDpRmicbiJvc1E6UpYwTa
	+rOZe/NPf4PerkNJNL6R0GE0XBnaJHSquI6rdiRxKHY1wocDNS5PRUVyMBtqzGxwLotFKzjcC1M8H
	/4qeGNFonJ+9xhAB8x7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy5rD-0007Gs-69; Mon, 25 Feb 2019 02:19:03 +0000
Received: from mail-eopbgr00077.outbound.protection.outlook.com ([40.107.0.77]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy5r9-0007GT-Cd
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 02:19:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJIwByVuXAh4v7dRSU5aApK7jpfPceQPXcp4Ds9UzSA=;
 b=Ne+3gz4mBkY+tnruC6mYg3fSYj68BCimansEqU2Dh5jrZRqnk6dOh2kSYy9lmwWtT2iWXIxR9erK9A5nAM7/s+O0TlAVIfeDJFnbN6gGPYDAJO+KC21ielDovjS5c8PSGBye/M8hp6UHEkEnN8/U7Em2Mc7kj8U6PBwWz4GnBLU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3674.eurprd04.prod.outlook.com (52.134.66.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Mon, 25 Feb 2019 02:18:54 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 02:18:54 +0000
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
 <heiko@sntech.de>, "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net"
 <olof@lixom.net>, "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-watchdog@vger.kernel.org"
 <linux-watchdog@vger.kernel.org>
Subject: [PATCH V3 0/4] Add i.MX8QXP system controller watchdog support
Thread-Topic: [PATCH V3 0/4] Add i.MX8QXP system controller watchdog support
Thread-Index: AQHUzLB0r5YVhKiES0eqmgM1XXhaBg==
Date: Mon, 25 Feb 2019 02:18:53 +0000
Message-ID: <1551060850-22553-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0078.apcprd03.prod.outlook.com
 (2603:1096:203:72::18) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51fa5689-47d6-454e-5e95-08d69ac796ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3674; 
x-ms-traffictypediagnostic: DB3PR0402MB3674:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3674;
 23:ROmQzD/16XKgVOtZUCuAJa/japmQ6QYlarKKF?=
 =?iso-8859-1?Q?XF7pKqe+/RGeqR1YxpLByPvz7h8BJg3gX0JV2SzVU3uNarcTLdxjTd/0ym?=
 =?iso-8859-1?Q?CvbdnJqmTszlFu6JLCoLkDGr4MenZpWr/mrSE08aigtN9tjOkixONyGiX9?=
 =?iso-8859-1?Q?sZIN6eTGg2qSzY/ua5p6EKXIS9JSXFZyF9SLcdT+6CHPEWrFDxdVVb9rwZ?=
 =?iso-8859-1?Q?CTiHQNqqKnOM+EuD35Qr3bKqX5XBIThxKgepfPideiWqAt0QzrD5Jj5fs3?=
 =?iso-8859-1?Q?e/Kni/AJpW1rwqutB4U88fML1wvrNcA8iBde+uBKOuTJ0khBg5JSxuvZGz?=
 =?iso-8859-1?Q?mp+KsYIADirxwOkexckz19LJoVx4foT/aUC+UG8QIsDVaOqt3/vL9I+pwL?=
 =?iso-8859-1?Q?uAaQ+yuEj7zZca0/dbh+s04jVrmGwFAm8s5zPxiTDViacw4uEgcobnb8Z6?=
 =?iso-8859-1?Q?q71boPA4MUXJol2mnZk4u9pOPbn4fiiUg2a0RYHpyKM1GtAYo110oiNlZ3?=
 =?iso-8859-1?Q?782XS3669X+qTLP/22pbv2x1x4E8bm8jU3VAAWFIcSTNB4QdEh//4jsWPC?=
 =?iso-8859-1?Q?YehuocOb2PTALoi4UDsG8x0Reh2H97sMwg7VXbPZnZZVfiFjau2wOqksFv?=
 =?iso-8859-1?Q?gFzU9EjrrVOKfRV1VONTd+00c/zczivvAYyfzpRAiLHwgYezUUpfnBMvyC?=
 =?iso-8859-1?Q?ZR8Sn6AEjr+GM8YJgQk2oYyF9HzbRnXzugX9p3FCQISHY0yMC9lbAevCxf?=
 =?iso-8859-1?Q?bC8VLQc6C/hRM8hJesj+y5H486rRbUvwhNfAqITY/3uWGE/OfSC+fUlqiv?=
 =?iso-8859-1?Q?p2lqqeiNmhN3TWI0BeKYmzXQVt5yzW2z5ltJLVxN0DkuIP+vfptW4UN+Cn?=
 =?iso-8859-1?Q?f7yEpqDOGb6n4wOVl+rPP/eXlHJgtU6+CYl/NGWo9qatiHoC2HYoxaE5XU?=
 =?iso-8859-1?Q?ZMgPo4zROrvO5CKbNJXhN72lu9MdQYr9MH1NwDg6ijz38IMKVbMlyZfniB?=
 =?iso-8859-1?Q?lvTsAO1vsxr1IkC2SXxMdQqzES0GJxHLLk6pXceCkLwrMIWRaqlNnMvqXX?=
 =?iso-8859-1?Q?Cm218nSiYpghUW5+FoNZfR3yJQ1pBTn3FXm0B6F3PFC2j79iSj6n/cFBbp?=
 =?iso-8859-1?Q?TKpudsPJRLpUcSL+Rgg9fhuObEHYbY6/ZqZXoanOWjGpOZFUapnzzRaCol?=
 =?iso-8859-1?Q?QJFU8YfgioZgFeKnyOgJT8HheehxNZj75bEWqOXizEbzW5zQNc5l62gST8?=
 =?iso-8859-1?Q?YdxM0ANy5JO9VjKMoqTvkjCz/iWPGdYh5mwUViRiEpiziJwhpwjXtTbJIq?=
 =?iso-8859-1?Q?pUkDFYgC53m9p9b0M6AfxPlm/?=
x-microsoft-antispam-prvs: <DB3PR0402MB36746920AD2A6D1C17246CB5F57A0@DB3PR0402MB3674.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(189003)(199004)(54534003)(66066001)(305945005)(2201001)(52116002)(486006)(14444005)(7736002)(316002)(110136005)(256004)(476003)(50226002)(106356001)(2616005)(53936002)(86362001)(105586002)(99286004)(97736004)(7416002)(966005)(81156014)(3846002)(6116002)(478600001)(68736007)(6436002)(8936002)(186003)(2906002)(4326008)(25786009)(102836004)(8676002)(81166006)(36756003)(71200400001)(71190400001)(26005)(6486002)(5660300002)(6512007)(14454004)(6506007)(6306002)(386003)(2501003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3674;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WWeRo2OayiUs/pBIPSkz1KfnfQ8qwJtMpohKdh/qY719ZOtnvhivFehNfipMNS50L3Yrtt1wjVcUrPwpB3BNezkem/zwgjKlfhPHe0oS78wMqzNUJV8Q5B9msVrMVfXEeMstMpeePSwOBhHn6VBEPmm9eyIl1ovDACXsKXbBlDzBgdrcnLhtJC/L10bn5xgtTXzAIFAjhDTQm7z9h8pQeW3h1Y6vZ6wU/rSQK11tOCnkwpDWFON6nfZBZywwLzCW91Puz/tDUnPcsSfDpju5twTDrfwKd4dmuUm6RmmdtQ63+iTOMWKRc4cbHz9xM/cxZIoTpms8A5lzCZo74KssIK7df3WQUMzPv0HPG1+4Dfj1oF1mnBQa1h3CTPTG/aQH8GpP1F4V/8D2aTS5PMu4k1GpoqDBGUq1ncHYbxjzEHw=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fa5689-47d6-454e-5e95-08d69ac796ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 02:18:45.7217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3674
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_181859_578306_C9CF262C 
X-CRM114-Status: GOOD (  10.09  )
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

This V3 patch series addresses all the comments from V2, and change log is inside
each patch of this V3 series.

Below are the patch dependency:

The dt-binding and imx8qxp.dtsi patch are based on my thermal patch series as below:
https://patchwork.kernel.org/patch/10827673/

Anson Huang (4):
  dt-bindings: fsl: scu: add watchdog binding
  watchdog: imx_sc: Add i.MX system controller watchdog support
  arm64: defconfig: add support for i.MX system controller watchdog
  arm64: dts: freescale: imx8qxp: add watchdog support

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |  12 ++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   4 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/watchdog/Kconfig                           |  13 ++
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/imx_sc_wdt.c                      | 183 +++++++++++++++++++++
 6 files changed, 214 insertions(+)
 create mode 100644 drivers/watchdog/imx_sc_wdt.c

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
