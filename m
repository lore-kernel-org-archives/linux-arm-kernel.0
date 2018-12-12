Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD0CC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:57:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D65220849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XSXGthz3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="RZXnMRoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D65220849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u7JUZ6gAjdCsz03CM9+MBlEVRI2dizEPt4AmSE5wnZ8=; b=XSXGthz3MeXxMg
	WvAZtSDAznGMwzck3uFP7SuWzGhqyPsTmn7RU5mWkP1BMnmwD0/O+J09f6IyRSbhFkL5/qxrMGvqa
	xAih05c5lznFMhh1lLNw/mXpFr/PD/QZ3rJrtwxyu+PLPcH7Z/tPLlq2DDLsAE+u+uwG8qXTnuM2u
	aOt7LQZAagQS44+KAE7LhW4yH3hhjWlIlLxifR0xedVM6jNXU5jJn6FBXH0Br+qbVoUltmZ9RnrpN
	UY9oLLAx6hdr39o+3iEvTb63U7F+nzUYhGYGVjC3Gxr+VaONLzR5Ix8oSKHck3h7R1JrJ9XVvzMzQ
	e1nIY0tEIH+HSzA12EGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX38u-0002MW-Cr; Wed, 12 Dec 2018 11:57:32 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX38o-0002K3-10
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 11:57:30 +0000
X-IronPort-AV: E=Sophos;i="5.56,344,1539673200"; d="scan'208";a="21415419"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 12 Dec 2018 04:57:14 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 12 Dec 2018 04:57:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKTsdZWpa62osy2QUv/EwtEeoJsEZ5aF5mcGq8G7Msc=;
 b=RZXnMRoBN/Rt8oMpXMOt0ybRKn6fOoWMWV+5hJg2SxKCDno1ZXPvghEoLV7KjNL5h27aX1OBxxiGByabrVRlnH7GMQjeVhP0pu80B15dhH8J+vkoGQO9kylW3bRQ3GHbannzr4hpFKgKnXKbPgVomAd02RIxymcq/3Wb6Hi2MvU=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2145.namprd11.prod.outlook.com (10.174.112.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 12 Dec 2018 11:57:11 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838%3]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 11:57:11 +0000
From: <Andrei.Stefanescu@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
 <gregkh@linuxfoundation.org>, <Nicolas.Ferre@microchip.com>,
 <mark.rutland@arm.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: atmel: describe SECUMOD usage as a
 GPIO controller
Thread-Topic: [PATCH v4 1/2] dt-bindings: arm: atmel: describe SECUMOD usage
 as a GPIO controller
Thread-Index: AQHUkhHQYswuMKmv5ki18JkJjNCwcw==
Date: Wed, 12 Dec 2018 11:57:11 +0000
Message-ID: <1544615784-29331-2-git-send-email-andrei.stefanescu@microchip.com>
References: <1544615784-29331-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1544615784-29331-1-git-send-email-andrei.stefanescu@microchip.com>
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
 6:hXPnJnCErDTiRErgYtjADUy5lmaE2dxjijYXFJ15geuRSsBm9bk6wfhIi0dzdywJXkwrA5SN7XZqzifbQOXgRkIIJ4lCkFvLHiFybC2mzyS2lAG7/Jj/mOUgGylIOpF3PAWhjVQPhFB3Nal1GuqbdBTQVteDv0z/bFAKrtE3lSY6wQ1oKdGDB0wUyaCVqfHihr85ainVXh5q27GPTAj8Cth9K28fT92KxHpQdpsMTis++oZQ5w7eoi4lhM+CGB3ziKW8r9RSbsYh/7rzEen929D/j7grM36DDfl98lmES6PYx1XxkhzGotwPB6+2VNE3sXYJfnga1P9lrfOarh+CTIyMJb7+8Eq9yI5qRsZW5gw7KJLypZQvaOuq0G8bk/TwQLuD0ZVr0IVQRJxT212nKZO9XpAu4WPKwGP8ulXMbqksphLXVPaEq4srmQPZzYLGPc8eGpXfGwLThmweo5ecwQ==;
 5:llhsL4Q2d+TKTo2F2ihjpk6Ph/RrIRCqmk8dPHGFck/1RRXpN2DwzUXKarIX1sS4JTuqZixsw/2fW333YDCZOWcA/9qJBjoLJGO+Cx1rz1WnwMp6yyohoPbeKKTnqs6rNCwfBOXlj68q1mkrY3edo+5CEuxE9k4SMrlDgs3fVkk=;
 7:r2CFHWXoO7BkdtyQUTI5eVSQgsbkld62tJ+hpPE+lh68MbaXXE/Ju3DhPWlTxPwF8aAJ/AnxEfeeJV2QYukuLz8HwrH0gOAJ8StckBGM+RkyKmbdxqaj3znZB6AQyBCE7UIQkHbZpUNm5ZZ3EUfA2w==
x-ms-office365-filtering-correlation-id: ba8a2185-fce6-4238-8693-08d66028f2f8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR1101MB2145; 
x-ms-traffictypediagnostic: BN6PR1101MB2145:
x-microsoft-antispam-prvs: <BN6PR1101MB2145DD0CC0D82D54B5AB9727EDA70@BN6PR1101MB2145.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:BN6PR1101MB2145; BCL:0; PCL:0; RULEID:; SRVR:BN6PR1101MB2145; 
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(366004)(39860400002)(376002)(136003)(37524003)(199004)(189003)(8676002)(110136005)(6506007)(76176011)(386003)(102836004)(52116002)(53936002)(11346002)(2616005)(446003)(8936002)(81156014)(316002)(81166006)(36756003)(106356001)(54906003)(68736007)(105586002)(7736002)(2501003)(97736004)(186003)(107886003)(99286004)(66066001)(71200400001)(71190400001)(5660300001)(86362001)(72206003)(26005)(2906002)(478600001)(3846002)(6116002)(14454004)(305945005)(14444005)(256004)(4326008)(486006)(25786009)(476003)(6512007)(6436002)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1101MB2145;
 H:BN6PR1101MB2243.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sO1/EHc+a8FFhbilXJDkvDmNr4NUjqPFFwjcHrA8AIxZOaZsiaL5bYzfRo5t4iE8WlfR6s0+JXTbYkSPllmc2AcwguW9Q6mC5nNMMXh682phQKvKXovVI/MBudZf47ahQH8iP70qjv7rIYD8XyOmk6r2Y/syyNkl8zEHeUSw1XklvvyRpL/wi+OwCVbvow1svpeXFfFfzbDlTELvuXVJpYbg969ScWaJE9p+fExo/dVR86m3wc5xgR28xyLm/HiSxRk8uQCGD60ctkTV13XZtPBMGt+qijlRsXpkZ7RfeHRWZtwxS5T+cHUFxAVnIGNV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8a2185-fce6-4238-8693-08d66028f2f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 11:57:11.4429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2145
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_035726_118924_5DA9DE74 
X-CRM114-Status: GOOD (  10.20  )
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

This patch describes the Security Module's usage as a GPIO
controller for its PIOBU pins. These pins have the special
property of maintaining their voltage during suspend-to-mem.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index 4b96608..c89db84 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -158,14 +158,24 @@ Security Module (SECUMOD)
 
 The Security Module macrocell provides all necessary secure functions to avoid
 voltage, temperature, frequency and mechanical attacks on the chip. It also
-embeds secure memories that can be scrambled
+embeds secure memories that can be scrambled.
+
+The Security Module also offers the PIOBU pins which can be used as GPIO pins.
+Note that they maintain their voltage during Backup/Self-refresh. 
 
 required properties:
 - compatible: Should be "atmel,<chip>-secumod", "syscon".
   <chip> can be "sama5d2".
 - reg: Should contain registers location and length
+- gpio-controller:	Marks the port as GPIO controller.
+- #gpio-cells:		There are 2. The pin number is the
+			first, the second represents additional
+			parameters such as GPIO_ACTIVE_HIGH/LOW.
+
 
 	secumod@fc040000 {
 		compatible = "atmel,sama5d2-secumod", "syscon";
 		reg = <0xfc040000 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
 	};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
