Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBAAC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:50:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1857320645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mUItuNAj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="EDDys2up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1857320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ga+YKnfmkbRZPMPNwFN4M55Ad782F8cE/F5Op3qJXNs=; b=mUItuNAjI1Tndp
	07sZD2lf6sooIibTB21wpMJWQzjbx+6Oki+MuRpelLtB340HfQB28xU2NeJsuqidZqG4Py1MaF2Lu
	iuQ7cziwV9l8MDJCzXMTQkWuBZfLqdAagIILvzX1CGpdFAF7ThmRSk4ut3RB7wF334TmlzW1Yh3Ni
	jA9EsIKW7esjYtYQpVoQlZqfBTUZ1C3wiq4c9zM6gNZxZc+kK7GfEBQdOpjgPnLVr/dmxaShUh+79
	9QxnX8oCXyysfk4Ay2tzFkp59CpOnZqzHMDzPbF7tQ1+LV/x54U3aK1oh838JKRLNABnrNl0RHd1M
	NZ/ROpwWZcx1fzABs02g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQRI-0005JH-Dd; Thu, 13 Dec 2018 12:50:04 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQRD-0005Cp-PZ
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 12:50:01 +0000
X-IronPort-AV: E=Sophos;i="5.56,349,1539673200"; d="scan'208";a="23873171"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 13 Dec 2018 05:49:48 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 13 Dec 2018 05:49:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6wj2LIg8tE5O0/EdBfxt0cEWgf1dYIg2WlzmBZhDLs=;
 b=EDDys2upwsssLQhjCF/rkFF78IjEkONyuWn/NG3P+xaK41hmBHhLTKQOW9SC+1tY/WmsXJHcA+Emy2g3SLhcIj/ERym1KA9OgYjCymnOTMSk/TJFcOnWctepld9/5eHYvfmMcA2MOJmaRlx7w/S5jaCWOhlRvzWaE/xcDsJodTE=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0519.namprd11.prod.outlook.com (10.163.158.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Thu, 13 Dec 2018 12:49:44 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 12:49:44 +0000
From: <Claudiu.Beznea@microchip.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
 <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: [PATCH v4 0/5] add PM functionality for act8945a PMIC
Thread-Topic: [PATCH v4 0/5] add PM functionality for act8945a PMIC
Thread-Index: AQHUkuJSt817GApqBkOd8F4AATMFUA==
Date: Thu, 13 Dec 2018 12:49:44 +0000
Message-ID: <1544703110-27161-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0248.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::15) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BY2PR11MB0519;
 6:7bt3p8jbwmGzWrCcB0IpcCtLafIsuxCClc0LU9SLvxBtF1ZuPkOM98lJNpn7WhYqLVbaH/shzahxC6EGGNtGLbiwAgQO6hd9WclJM9FPPMqk0yPGYmLzbd4JNhiM0bzbB+G3uEJHx8H60Bvz6e5mztRcm/1B+eOe8q9GEhpZXSEtUuM5VUKE78oFkOlsElhJGfhrqm6Dki5mQTxxfeUlpXMweEFU5nHTRqexQXXH8SuG5HLc1NLMWs85X9IiQrn0j/2JYXt2u7d/yBkP7kKdG+iozJICB4Zu1J1/+EV2etcM3/rFVS8kRkgzT2/3w2UxUzuCPqyNQWbVD7r7y5pgCM8tUvifUE45M8lwYbV0y91S544s94vaf3uow433M0NQuvQyuZmtCN2xh1h6yTtVdO/0kAVMzH3/trDon1ScAeDWHDJmjxbsTauwIBMxbZyd+ESDKpasMEkK6jDO7ZaaPPBUU1PCNAOpIMRjFqaVcQ0=;
 5:4kupmgIOMq9Rn0C/1vbtOAlaUGhhwm4l2HoLdSZL9s9pZgBE51xnCyYbZ3h4KFqY88x9KkfSAaiyzwq7JSpgq93vCq6hjUVC0OVdl/StWZ3onx7GsDbERbaCCjLsdJ3szjejXdwdIZ432Uy7diegLYNoK1C1bpwxXQu7FApohjc=;
 7:PThmxVgtX2IHMjME0Np6352lCmRqqnySPcvDxXEtxQ3EAIP0CuiYfwcjaLdsq7eCK6XzQARIwBribuUmXLuxxNUI+knspCu2tYyvgSoWPMY8uXHsovDZDFpDEu6iBjeYNzRMPk6w40LnMt35QXnXMQ==
x-ms-office365-filtering-correlation-id: cc0b3615-f1ba-4ca7-8f9d-08d660f974d0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BY2PR11MB0519; 
x-ms-traffictypediagnostic: BY2PR11MB0519:
x-microsoft-antispam-prvs: <BY2PR11MB0519A21604945DDEC163E5E587A00@BY2PR11MB0519.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:BY2PR11MB0519; BCL:0; PCL:0; RULEID:; SRVR:BY2PR11MB0519; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(316002)(5660300001)(305945005)(8936002)(97736004)(2501003)(102836004)(26005)(6436002)(36756003)(99286004)(476003)(68736007)(3846002)(386003)(6506007)(7736002)(14444005)(52116002)(6486002)(106356001)(6116002)(186003)(4326008)(105586002)(6512007)(256004)(53936002)(81166006)(81156014)(8676002)(2906002)(66066001)(39060400002)(25786009)(2616005)(86362001)(486006)(6636002)(478600001)(54906003)(107886003)(110136005)(71200400001)(71190400001)(72206003)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY2PR11MB0519;
 H:BY2PR11MB0744.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: W7ZiiF6RukCQ+cPZ9rAFLeELuRVpJCSJEL2gJidvofFsYjJUfk/z17m/Xw4hNVwiNvjbXBCDMeAlytiozPHjdJzhTV8FIZY8OikRw/MhNtNN2Uq+9Z4swHTC8z5TtXwIemA/AmmU4B7wp+ZAcB2BmzfwHCZyTrz5q0SNvkOyEAhbp9TWMvxg7JwUdKLCUX/SeZx9nFVlzS1/ZXw4QNCy7I7Oa5sU3tPlW2gNUY8O4UkAWdI7l9C/crGW7ZSsA2jqXvoVB6rgFYtQfFazXAICX99CgghKibipuJdULCiAh+DjXPeb9hXdQ0quPXGr/xoD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0b3615-f1ba-4ca7-8f9d-08d660f974d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 12:49:44.6175 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0519
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_044959_893429_5AA6B90A 
X-CRM114-Status: GOOD (  13.62  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Claudiu.Beznea@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

This series implements PM functionality for act8945a PMIC and use that support
on SAMA5D2 Xplained board.

Changes in v4:
- move dt-bindings/regulator/active-semi,8945a-regulator.h in documentation
  patch; driver uses macros included in this file; due to this documentation
  patch and drivers patches should go through the same tree
- make documentation patch, patch 2 of this series

Changes in v3:
- add patch "unlock expert registers"; it was wrongly missed in previous version

Changes in v2:
- split patch 1/1 from previous series in 3 patches: one adding regmap,
  one adding pm functionality, one adding shutdown functionality
- use dev_pm_ops suspend function to set register specific to PWRHLD line: this
  is specific to PMIC itself and not to regulators
- add mode support for LDOs
- add constants for mode in dt-bindings/regulator/active-semi,8945a-regulator.h
- document modes and regulator suspend states
- remove rdevs from struct act8945a_pmic since were not used anywhere
- add op_mode field in struct act8945a_pmic, update it when setting mode and
  return it when reading mode (avoiding one extra register read while
  reading mode)
- add a patch to fix a checkpatch.pl warning
- in shutdown function use directly act8945a->regmap instead of an intermediary
  struct regmap variable

Boris Brezillon (2):
  regulator: act8945a-regulator: Implement PM functionalities
  ARM: dts: at91: sama5d2_xplained: Add proper regulator states for
    suspend-to-mem

Claudiu Beznea (3):
  regulator: act8945a-regulator: fix line over 80 chars warning
  regulator: act8945a-regulator: add shutdown function
  regulator: add documentation for regulator modes and suspend states

 .../bindings/regulator/act8945a-regulator.txt      |  34 ++++
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  54 ++++++
 drivers/regulator/act8945a-regulator.c             | 200 ++++++++++++++++++++-
 .../regulator/active-semi,8945a-regulator.h        |  30 ++++
 4 files changed, 312 insertions(+), 6 deletions(-)
 create mode 100644 include/dt-bindings/regulator/active-semi,8945a-regulator.h

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
