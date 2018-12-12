Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E438C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:58:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54ACF20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FZJKdTmT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="siHVtDnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54ACF20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7CycDFFrIPMxhO/iFcso2mYe4gRQukoQKnzizcEJo6I=; b=FZJKdTmT5Xehwt
	XjQOlZoX+6QS9YmZ/jj4Tox9rxhSTv2FB3lFBYRz8VgERkNSqK6D3KlNKbNIJov6rQT3kT9CLk36d
	wHCucHHp02sg7T1W62HVdQfmjfJrB4sNiepCMXpqUUGCJJXtv1A9PSdNlt3OjKo104/f9pcmw2IGc
	yGzqzoppYtntFsJ2VOvoo/5RMXPrpdcCEINcOdnYSUINqHdDjHcG1lEE/tpV56XGQuW3B4A4m9cQS
	SibNRz8KtETLmzQiBpukLHB7Fnf/Fzal4c8jEmi6Rvtkz6MWXT9pAhMGq/u4uU2MQsGrFRJfjbnV3
	/uGFy1HCB3FkezPW6YQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX39R-0002rL-5y; Wed, 12 Dec 2018 11:58:05 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX38p-0002K6-Tc
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 11:57:31 +0000
X-IronPort-AV: E=Sophos;i="5.56,344,1539673200"; d="scan'208";a="23828878"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 12 Dec 2018 04:57:02 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 12 Dec 2018 04:57:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=447IVdqa1ggiTZySRTE+VqgF+7L77UA7FDDBKBM5Lig=;
 b=siHVtDnhl1NDTFmioQgiM0h+qHTf4FfbmK2FJwBPU+AQAYhIgOifqcefETNDkhYDexYmNNnYKvqujJvVpXlsAZ5FA70bY1AsYpAc6yqE5X4FfYdjZzHsKOoUWyjMzcJZXjWgJgioog+2qDiNJeeluMmn7IavAJi/l3x//JkB3bw=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2145.namprd11.prod.outlook.com (10.174.112.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 12 Dec 2018 11:56:58 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838%3]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 11:56:58 +0000
From: <Andrei.Stefanescu@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
 <gregkh@linuxfoundation.org>, <Nicolas.Ferre@microchip.com>,
 <mark.rutland@arm.com>
Subject: [PATCH v4 0/2]  add SAMA5D2 PIOBU GPIO driver
Thread-Topic: [PATCH v4 0/2]  add SAMA5D2 PIOBU GPIO driver
Thread-Index: AQHUkhHJAvgLQJH9Pkm0EOF7tLahAg==
Date: Wed, 12 Dec 2018 11:56:58 +0000
Message-ID: <1544615784-29331-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0064.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::41) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR1101MB2145;
 6:xrzAJVDV0ZoTpIB8BkLAFH6RAp/ZSK6I4LKYj49Mx4lxv7Hm49W40It1RTyb/aA6ONjWLo6WtTIV9JcnDMF/LyFO6U7RU78FcrxOglu6B/FFAqBssZRmFaT0Q6SPv8uiZW4A8prI1VttmFAe0K/4u0kC/lfiq0FSbjkRUefbttR+7VCo3sj2JCQz6z1NrKAaZcUDIcMEa7/SDLEzPCVbHlG1kDSAtyXQBBbMaIYGcK06GHWabFkHqlTnoAZgjf2wEUXjlW5IS7PzXHXGYAf6S+qIIndym1d6Dn89auHZHQ8SggZ6zFmtNF4aszFTco3YYtbgH5PtFwCPBdtNISmvBtNgQU2wL5wctSq3zWbLMGlP9kKo7YLMN0TeRLCKUjICJy1N4a2zunaoVQy6kjbWbyq8eFoZ4At5r0Rpo6yFB5oJHp8TjSXJsgZH0X36OsFjVGJAt2JdTOk57G18ufTgYQ==;
 5:/oHM19+Qp9ugnYy+Q6/f4FHmmDv+pYQqel+rpkxeMsgBmhaW3COScArk+1awO18oEFUvCI8Ql8DrGtpnHftH9MDSCukLW6cc8NPTmQNhlGSbO9TEn0WK1RgRt9KLKZA9Fd97oGpqEO/4Z7MA4hoUmFthwehQyux0acY5U214Xeg=;
 7:NXvsTRuwH0nGUeSe3YykXhJci+b7MiPJdEUPra81caroGac5C4Y2UZFhXooWmJ+6RClvtyfhByY1usfOsuTZj1yKWTetrVBbPitaBVfNHVW8sNGBcFP8oyKDQ6L+Cq42LIrle01BiTOgXr8uy5s0ng==
x-ms-office365-filtering-correlation-id: 843550df-da09-424e-e371-08d66028eb57
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR1101MB2145; 
x-ms-traffictypediagnostic: BN6PR1101MB2145:
x-microsoft-antispam-prvs: <BN6PR1101MB2145EED4CCE5239BA661E247EDA70@BN6PR1101MB2145.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:BN6PR1101MB2145; BCL:0; PCL:0; RULEID:; SRVR:BN6PR1101MB2145; 
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(366004)(39860400002)(376002)(136003)(199004)(189003)(8676002)(110136005)(6506007)(386003)(102836004)(52116002)(53936002)(2616005)(8936002)(81156014)(316002)(81166006)(36756003)(106356001)(54906003)(68736007)(105586002)(7736002)(2501003)(97736004)(186003)(107886003)(99286004)(66066001)(71200400001)(71190400001)(5660300001)(86362001)(72206003)(26005)(2906002)(478600001)(3846002)(6116002)(14454004)(305945005)(14444005)(256004)(217873002)(4326008)(486006)(25786009)(476003)(6512007)(6436002)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1101MB2145;
 H:BN6PR1101MB2243.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oxzYxULnmuXTYj+pGRxShrkVKO2T2bkOYws80bY0a1ueKCQr0Ux86aVgSobensV7La0ArsZu31lCZ0PDG6tW3TnA7gKdD8T9DSGFl7pa1MVAApbQIA5DAq93RbzuT3Nrgm/fsF1o7ytbV+uTs/sZ/reOALMECKB5orcDBPS6lb9HiuwLDLWiBCOAnNWo+uFf8ac8lfnGHc61vXMD7i/QEcB8p9uf4tKCOQE/pkk0uWIur1MHNn+ye0/Po1hF5dRTlyV9lJdL2CPE5u4NnQOeImRGMBmhAL6qez2ZGsfCkgtulQVfQljBAkO6R7nc5Jo2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 843550df-da09-424e-e371-08d66028eb57
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 11:56:58.7399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2145
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_035728_276124_A694B7FD 
X-CRM114-Status: GOOD (  11.98  )
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
Cc: devicetree@vger.kernel.org, Andrei.Stefanescu@microchip.com,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Ludovic.Desroches@microchip.com, Cristian.Birsan@microchip.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On SAMA5D2 SoC the PIOBU pins do not lose their
voltage during Backup/Self-refresh mode. This can
be useful, for example, when the voltage must remain
positive for a peripheral during Backup/Self-refresh
mode (suspend-to ram is the Linux equivalent state).

v4:
- readd Makefile and Kconfig changes which are missing in v3

v3:
- change driver's compatible to atmel,sama5d2-secumod
- get syscon using syscon_node_to_regmap(pdev->dev.of_node)
- document how to use SECUMOD as a gpio-controller

v2:
- make driver be a subnode of the syscon node
- change Kconfig to depend on MFD_SYSCON and select GPIO_SYSCON
- change include header from linux/gpio.h to linux/gpio/driver.h
- include linux/bits.h header
- change intrusion in comment to tamper
- fix kerneldoc of functions
- replace GPIOF_DIR_* flags with 0/1
- replace ?: statement with if-else
- remove the use of sama5d2_piobu_template_chip
- retrieve syscon via syscon_node_to_regmap(pdev->dev.parent->of_node);

Note that PIOBU_REG_SIZE is used to determine the register to write to
with regmap:
	reg = PIOBU_BASE + pin * PIOBU_REG_SIZE;

Also, no irq capability implemented.

Andrei Stefanescu (2):
  dt-bindings: arm: atmel: describe SECUMOD usage as a GPIO controller
  gpio: add driver for SAMA5D2 PIOBU pins

 .../devicetree/bindings/arm/atmel-sysregs.txt      |  12 +-
 MAINTAINERS                                        |   6 +
 drivers/gpio/Kconfig                               |  11 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-sama5d2-piobu.c                  | 253 +++++++++++++++++++++
 5 files changed, 282 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpio/gpio-sama5d2-piobu.c

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
