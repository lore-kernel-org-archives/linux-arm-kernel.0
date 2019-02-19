Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298C9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:09:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1FD62177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fDT961Cr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="bO/BDByU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FD62177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0zfwKgAfF3QWEdba8Ef5gxD7DkG5rWhznRRrKLjTvSM=; b=fDT961Cro/GJa4
	FUbFPC9L0VYk9+jnpjgy5mEze+wI1k80jMjToiGYfyLX/VTlIGbjS0Sb68DVQCSMLNsX1+doksYRD
	UtM4n5T9wqLUDZwPSJhWNrtscnhp2ZyzmTLhKau/yX03JOxGGI0RnNeHxcD3JC6g0dROeg5h8H8yU
	lcGFbj6vb8Tewm0qAafwAV1oNPmSQW87QSztg5NAL69Xxi9WyeBKUJkC44o0JaFnYhwDi9gOLNuy7
	omCd8IQeu5wEKQQGnFOFbxazA2YHmXz7uJuuCZl08HXVixHeXNbI6RzWZaWLWQE9vmBxvd8TaDpUR
	k6LNM68x7BliJfPfEfgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw2Kq-0004rj-GZ; Tue, 19 Feb 2019 10:09:08 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw2Kb-0004gR-5m
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 10:08:58 +0000
X-IronPort-AV: E=Sophos;i="5.58,388,1544511600"; d="scan'208";a="27948380"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 19 Feb 2019 03:08:52 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 19 Feb 2019 03:08:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7aQUjOyrC8dM1a6K7cxBr9Zul+jbM3VEnn1PoSLlYc=;
 b=bO/BDByUXnlk5Hv7d28V2M3rggp66XX7QkxP/vRr7AFSRzC1V5tjulnYt6/0fRnc4MUGcZ0pAWKbzT12Wboh3dKoD6ObQmId8mpGhwODvuniTsskoa1qPp8rUbLbrgSqmrxCV0wITOimGXLkxJbxoao3fyAnH9Pyl8j4el4Yx5c=
Received: from CY4PR11MB1909.namprd11.prod.outlook.com (10.175.61.147) by
 CY4PR11MB1831.namprd11.prod.outlook.com (10.175.60.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 19 Feb 2019 10:08:50 +0000
Received: from CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1]) by CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1%8]) with mapi id 15.20.1622.020; Tue, 19 Feb 2019
 10:08:50 +0000
From: <Claudiu.Beznea@microchip.com>
To: <thierry.reding@gmail.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH v2 0/4] add support for the new SAM9X60's PWM controller
Thread-Topic: [PATCH v2 0/4] add support for the new SAM9X60's PWM controller
Thread-Index: AQHUyDscosDqnY0tu0a5kDn0fcaiKw==
Date: Tue, 19 Feb 2019 10:08:50 +0000
Message-ID: <1550570914-26391-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0090.eurprd09.prod.outlook.com
 (2603:10a6:802:29::34) To CY4PR11MB1909.namprd11.prod.outlook.com
 (2603:10b6:903:11f::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e8a0ccb-3325-4e6b-5460-08d696523e4a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR11MB1831; 
x-ms-traffictypediagnostic: CY4PR11MB1831:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; CY4PR11MB1831;
 23:kq4G/ACZoedpz60N0lYKNXRiFqAI0ut4Et8Kh8C?=
 =?iso-8859-1?Q?qJmk/Hrsp/KUgXNyjBWOIt84Lpc1pIebJgkxpfwlaHNEm57iTvejc1Ybeh?=
 =?iso-8859-1?Q?Mc6Sh2vToNrGxsQ2ag8rtaU80AIxjnO8dli79iprcg/x1mO/AK/u3G+IHR?=
 =?iso-8859-1?Q?soXXQljq+LgML0DtqjuJD2X8pj0gYLF9mx2CrujGHcToqSCMet5DMuVSL7?=
 =?iso-8859-1?Q?U6l21AKktV2jguQhFKhTEHUwgpVaGzaT2Ng+dj4hEM9iBCQPJJL17JqWPx?=
 =?iso-8859-1?Q?j3IxbNHkU5iXk6hG6ucMcJdt5wdGWneEazqT/Qm8Pb0cayiQaVFIoAVxvq?=
 =?iso-8859-1?Q?Cbw7pBHGQOtFy8sTyXX6fBtGFUsY0m91yjRN3ECnJIg5Ploak+co5MczpE?=
 =?iso-8859-1?Q?CaiG1uUIsDx6rBMEQ8Lx/8wxRPfX6Ifs3LQHniV88WpQrcVuAxcbO5mYe5?=
 =?iso-8859-1?Q?StzxSfbMP1HZM4bYUsbUGNXLbJ2dlN3HPPJIKLKIGeVuP/WCOCVRP3HN/T?=
 =?iso-8859-1?Q?ui99wg3B6RYc+m0vVpqyXklB7gYlXUjDGib8+72CcmEuA+lVOcAwYxD/aF?=
 =?iso-8859-1?Q?iSkKwUUP4RmJVySiZHkT6GJ4Jlqs3o4xuWFQHLfQLITAzQoDMFqAGNqjJS?=
 =?iso-8859-1?Q?YKrdivXI5gzMP1/4o8P4MsuuJQZoJ+wZKHu+49gkjQrjsw8H3vIDQU9g48?=
 =?iso-8859-1?Q?TTSSS++KLEpaNvjbfG9xTgg2R0iTzKW+FX+sdPavSEUe6GVzb7FkihZuy8?=
 =?iso-8859-1?Q?wNYTLGKIl/1yfswBM8k6YfxAJcIg6mJFRYk/ZHV8qHivsanZt2Qulwkjbl?=
 =?iso-8859-1?Q?tyohuzNh06cgT2DCe2dAsdu25guLBf0GFuq+28PYk9F3nLO6INJZ5pMLi8?=
 =?iso-8859-1?Q?fhSouERw7phX3Y8p4kOaM/E3qgP5kW1lfRpKgG8ETA248mlAmQwJfWm/vx?=
 =?iso-8859-1?Q?xGKapVm583cMmSPgEv14nKgu83xBC4Brtje2VqlH2m24gMrefeXCOjua5f?=
 =?iso-8859-1?Q?VkUNeV4s6hiOiSWm4YrajFtQfKbtD6XJOiav7uf2+QBj1ZEK5Ty166K3/i?=
 =?iso-8859-1?Q?JT0Z4I/mJogSgjrpxOGXElaDQjdFabCFrUjk06Iw68JX6FXBsstPArfd8W?=
 =?iso-8859-1?Q?xiZcKmxFLGU50QL6ClwxL2q9bBM/iBp4GJMjjM0NHWKg8gGdVwRv6Um3PV?=
 =?iso-8859-1?Q?iMvB+Ee++sKHUc6yONYfYJDlwyytblhA6/4j5h/3siALQhoB8CWKTTDW0M?=
 =?iso-8859-1?Q?mKcdRLDBc5A4D8dE1iV9ESahF7Pm7bWbPIJxMKai9Wzj5f3USDeNLFnKGg?=
 =?iso-8859-1?Q?XI=3D?=
x-microsoft-antispam-prvs: <CY4PR11MB1831E92975B0A5B9F7852A2F877C0@CY4PR11MB1831.namprd11.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(39860400002)(366004)(396003)(346002)(199004)(189003)(6486002)(53936002)(2616005)(26005)(486006)(97736004)(4326008)(14454004)(6436002)(186003)(25786009)(2501003)(6116002)(99286004)(4744005)(6506007)(476003)(102836004)(386003)(3846002)(6512007)(52116002)(107886003)(5660300002)(71200400001)(71190400001)(305945005)(8676002)(81166006)(81156014)(36756003)(7736002)(66066001)(8936002)(106356001)(478600001)(110136005)(50226002)(54906003)(2906002)(14444005)(256004)(68736007)(6636002)(105586002)(72206003)(86362001)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR11MB1831;
 H:CY4PR11MB1909.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xljgmtsHUJU7mkYiB7WCpPcgw0pvCcmJjVUxxt29skVmcXfhbLdGLFX38Dio6XUMROLnxj5o33gZstoCohC8imoFOiVST848vzeP+pue2kRLX8rGG8G+93oYnQ9haJQTsGDV4YvmejDZ03NGwtgHxoDsVN3RjdjaWRTu+w+GGFLMmVMhAdJovnJ3RaSs/afqRCewcopPerhOSBuDGU8+7Aii/A5hWXtJIA0ac0wkoM80c5+8oRTUYW9pKcFxwuz9Vyk6AfXTh73euHUVaCsO37i1o3HmOJnJzs4f7IwcEDh/CSSUsoDg12cXeuEnG13Q6Rzxyh3UmIRIeCmUWtlmB4MO1VhgYX8WQ7ZlA+eEIRF5Tn0aCUkVviRrnkIGjPkgE/+OiJbwFdyvvvekek6BBWJJbL4O6Ksi50kPT38tYuI=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8a0ccb-3325-4e6b-5460-08d696523e4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 10:08:45.6995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1831
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_020853_459533_2E3FB482 
X-CRM114-Status: UNSURE (   9.42  )
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
Cc: linux-pwm@vger.kernel.org, Claudiu.Beznea@microchip.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

This series adds support for PWM controller of the new SAM9X60. The difference
b/w this one and the provious AT91SAM9X5 is the counter size (32 bits compared
with 16 bits on the previous version) thus, allowing to generate signals with
bigger periods and duty cycles. This series, modifies the driver to take into
account per IP counter size by embedding this information into driver's data.

Changes in v2:
- add reviewed-by tag to DT inding patch
- move PWM_MAXV2_PRD from patch 2/4 in patch 3/4
- change commit description for patch 3/4

Claudiu Beznea (4):
  pwm: atmel: add struct atmel_pwm_data
  pwm: atmel: add support for controllers with 32 bit counters
  pwm: atmel: add support for SAM9X60's PWM controller
  pwm: atmel: add PWM binding for SAM9X60

 .../devicetree/bindings/pwm/atmel-pwm.txt          |   1 +
 drivers/pwm/pwm-atmel.c                            | 119 ++++++++++++++-------
 2 files changed, 81 insertions(+), 39 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
