Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11367C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:26:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF1F21900
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KsoadV9i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="hL4qyjlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF1F21900
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nlU1GiDCbdPLflBcCP/WbnMNprmHm1ECEBjXUBvBueE=; b=KsoadV9i+udMNK
	fHS/OESJbimh2hARNjNpzcjP95MhQZnt0JlinN01g/vTMcobQvv4zkZcIrdob2K8xP6xb5Wo6gq+G
	HowI/KRx20NFAIfkmwPtCjQCQwxe2kvmMjM4cMxgRXaAKTyReVZWU0uuPoiSR1OYTolcvlTn4/y33
	ZobhDPFx+ZQqjLSYUbZntysgKPs4ZN2fWerNztAnbjMz5++qlf/ZFSEN770Ix32YzdnJSwlNuP4+T
	BFqkeBemBR2WTkEVJxajhQYBMmwlTwmgqsMOaoeQm6ziAGNiwR2woRsaWwWB9HaZHYLoNJnZ46CcT
	b6LWlzxrUNfhaPE3xZ/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grfwz-0003qH-Ge; Thu, 07 Feb 2019 09:26:29 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grfvY-0001AV-Nb
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 09:25:14 +0000
X-IronPort-AV: E=Sophos;i="5.58,342,1544511600"; d="scan'208";a="23535629"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 07 Feb 2019 02:24:59 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 7 Feb 2019 02:24:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlUsA/wD8ToN7/UR3246X/TwBw3N7gsqgXbbrWr1iOg=;
 b=hL4qyjlKo/YjXknU8PAlrV3jurjoUtCIhChabRE+ib/ueSqY3Yduo7YA0i9fmZuIZC6Wio+6O/WmSp9KYhXjQuj7P93h4BQmxDyyUxacyHDjScIDGn1mzND1gnEVeffYFywhmOfEVxTUikLFeXttfu1EdIoOEQWHtuCWsov/ne8=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1757.namprd11.prod.outlook.com (10.175.53.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 09:24:57 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 7 Feb 2019
 09:24:57 +0000
From: <Claudiu.Beznea@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH v3 4/7] dt-bindings: add documentation for banks
Thread-Topic: [PATCH v3 4/7] dt-bindings: add documentation for banks
Thread-Index: AQHUvsb9IFl2jeGVHEmCJ2ljPSVfhQ==
Date: Thu, 7 Feb 2019 09:24:57 +0000
Message-ID: <1549531468-1676-5-git-send-email-claudiu.beznea@microchip.com>
References: <1549531468-1676-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1549531468-1676-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0350.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5a::26) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1757;
 6:imuhh6jjFZ2sCwjmdRfY6STllOY0cPiu9MlGoOqkdLP7lgC26HI15FluD3sH7lXtsjfu8XkmbvWFDQZr5dZau2pNXXMtUALCnTtoVUeaF80xoLVVgTqt/y98Nw1T1X8JjPWPMEoOnyMjwNCJpaf9tRbaX1EMu7JnpX3nctq51PE1X7pfHx2RY4KKHICPoE/EjkFG+Pg3NMutZHLyq4Xx/+O1ABJ83AGp+U4WVgV2q53KZCG6ocCSte3evZ7v0wOgZ2bQvYoSqtlOK1rnyN+JP+7GalDMBIhJirLPoqqzxQG8Ip2jgY7qLYf2axVH2kEYRNehfYf21eU09OoKMG5bH4mMNYTrfaUwjDBtsqCnd6eIq9oM9frL9wEUFgRfLnWKwmIWOlbg67MfaFhgx7TL1qd/BinVRvUlXnRhvBM7/LL4gExPvmoZGhGw+rSVadlK/T32sbh5ZADqQz1aAi+RxA==;
 5:OmXGifu/BFGJK4ApdoHVM+xaEL+19UBHTVwa5HX9xpANdHVwlXx3iE4m7z4paUskuSXkNe8yVDCeFjOKFkNnb33qWJk7/R4xM7Zk7fNMaaiMvEKCXKRTshtB9vTXZii87oWxh1bGz76af9B0rS+qGFCxwkkSOPn6s7+YGYvYPun0rwikWpePNu3jSAO1j6dLvJtQNH81xCHxVHbBDQ6vDg==;
 7:nxhlkQIfzA5mMhp1Y9wkLZqQr8ep6UQ2tA4sll7H+Se20GBPZhmJQmt1Y3UjBV+k8i44KNqgnLOmQIH+mvLLfBSCAKq8M1Uxvfc+BP7TJNIA47tLnqwdfBbZYZF7OVEmKbO/fDJalqgsgv0tacKlbg==
x-ms-office365-filtering-correlation-id: d63a2b07-b5f7-48e1-3ff5-08d68cde2015
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1757; 
x-ms-traffictypediagnostic: MWHPR11MB1757:
x-microsoft-antispam-prvs: <MWHPR11MB1757B961629EC33A9F47494C87680@MWHPR11MB1757.namprd11.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(53936002)(66066001)(72206003)(6486002)(256004)(71190400001)(71200400001)(99286004)(26005)(102836004)(386003)(6506007)(4326008)(25786009)(478600001)(2906002)(76176011)(186003)(52116002)(68736007)(316002)(14454004)(50226002)(97736004)(8676002)(8936002)(86362001)(6436002)(81166006)(81156014)(2501003)(2616005)(6512007)(107886003)(446003)(11346002)(476003)(6116002)(486006)(15650500001)(305945005)(3846002)(6636002)(106356001)(54906003)(105586002)(110136005)(36756003)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1757;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r+DK4KYD1V+yAXRcbBx8bxscUvCKKExw4xqg7Cwk3HkjjRLHYkQLJJa6AMXSpYFD7x4zJAa0ap5WMbifsoFg2vaiVFH0H3C39Ss/fq9WRPnXLMPrvDHez7daH4qwggSPIPICEcA3HtS8kjyXCCywJwEfwLNs4t4ZZo6wFk9MUB8mTmNaBSnDydMlFho0Bw72J8KOPc3c4KNKfL4eE2sKs2zlNuPwskqZrskp6/YKAoFWcqamis+p29r5GEuGxmtNo6dhpCoQjx6sk2GF3jmbNJ4Nwv4VzUKBibPzDeMZEvXumlrg9tX8CNPTOywINep9bGIWYdm6a0ZC/IIdDePGcuCnuNv+jXcl84PUeQur3U7UdRGH8htZOZJksVIu+yyzk2ukGtG0hul3erZFX3a6up6zCFjLJChD7Tmcmj3ClLg=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d63a2b07-b5f7-48e1-3ff5-08d68cde2015
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 09:24:54.0673 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1757
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_012501_065884_E4C9A73E 
X-CRM114-Status: UNSURE (   9.36  )
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
Cc: linux-gpio@vger.kernel.org, Claudiu.Beznea@microchip.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add documentation for at91 pin controller banks.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 .../bindings/pinctrl/atmel,at91-pinctrl.txt        | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
index 3e23fece99da..40e33dfc36fd 100644
--- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
@@ -116,6 +116,18 @@ Some requirements for using atmel,at91rm9200-pinctrl binding:
    configurations by referring to the phandle of that pin configuration node.
 4. The gpio controller must be describe in the pinctrl simple-bus.
 
+For each bank the required properties are:
+- compatible: "atmel,at91sam9x5-gpio" or "atmel,at91rm9200-gpio"
+- reg: physical base address and length of the controller's registers
+- interrupts: interrupt outputs from the controller
+- interrupt-controller: marks the device node as an interrupt controller
+- #interrupt-cells: should be 2; refer to ../interrupt-controller/interrupts.txt
+  for more details.
+- gpio-controller
+- #gpio-cells: should be 2; the first cell is the GPIO number and the second
+  cell specifies GPIO flags as defined in <dt-bindings/gpio/gpio.h>.
+- clocks: bank clock
+
 Examples:
 
 pinctrl@fffff400 {
@@ -125,6 +137,17 @@ pinctrl@fffff400 {
 	compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
 	reg = <0xfffff400 0x600>;
 
+	pioA: gpio@fffff400 {
+		compatible = "atmel,at91sam9x5-gpio";
+		reg = <0xfffff400 0x200>;
+		interrupts = <2 IRQ_TYPE_LEVEL_HIGH 1>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		clocks = <&pmc PMC_TYPE_PERIPHERAL 2>;
+	};
+
 	atmel,mux-mask = <
 	      /*    A         B     */
 	       0xffffffff 0xffc00c3b  /* pioA */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
