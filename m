Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B59C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:22:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B48DF2085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fzBTSnpf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="N/5PrNXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48DF2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b4JK3D9950q4opJsjNy5M4E4ATkAZvzKm/Hg1wkGJeE=; b=fzBTSnpf5pVX0b
	+hPDrasgcjexCtfCFSrF4KlBge45+tyIqcLk9fWDvSzDIWA0pMwoXS5/WHGdSgBGWTfrXm1oBj/cj
	oPkwePBA3iMcrmQMNnp3yLU5u72zo7v6F/qmLJAWglCkDyGriZ92xRwPWQgaCcUF8rsD4fXxqqHjs
	fgP4jbFrV9CHQZ/PpP3Wa1bJRl9UUbwrqEm30csLqQd7vNr3ld4PvOxj3NlwNvoro/df9Eved9tEU
	ULIi+IMmg7cPrSkI5SZjfOeVukYDZqCbYShFwMtnAg6VZDnutxzi/jR/amXDycs8IP75kK8qWZYCs
	n/F7OieKudQ48+xpPnfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpF6V-0001rR-GH; Thu, 31 Jan 2019 16:22:15 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpF2h-0005Rf-LQ
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 16:19:29 +0000
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; d="scan'208";a="23261725"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 09:18:18 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:18:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOuAGL9BaiJknZEJq36gOOSa4pvqQRiuEsByjdI3VQY=;
 b=N/5PrNXAje24nROhnvIiPNyv6QTM+ogAEKOzLEPCWVJ8U8/bjg5JAdo5z6G7sy7aXwBeBTEogonqE1N4RFzQNs5K/8FUYfb/H0w2CUY17oXWIBil8bRaZfExbbZexeQbGAKMLwvNrlmX9W14Yb78PVg14Z86xJM0J30937CIQHI=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1424.namprd11.prod.outlook.com (10.169.234.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 31 Jan 2019 16:18:14 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 31 Jan 2019
 16:18:14 +0000
From: <Claudiu.Beznea@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH v2 4/7] dt-bindings: add documentation for banks
Thread-Topic: [PATCH v2 4/7] dt-bindings: add documentation for banks
Thread-Index: AQHUuYCRlE62xsYP4EKdyYvfcyWYPQ==
Date: Thu, 31 Jan 2019 16:18:14 +0000
Message-ID: <1548951466-26297-5-git-send-email-claudiu.beznea@microchip.com>
References: <1548951466-26297-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1548951466-26297-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0116.eurprd09.prod.outlook.com
 (2603:10a6:803:78::39) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1424;
 6:POG5agXQoZrkL2PIQ2fjB/cfhdrOrA9elugcvfoKv/IWmURoBg00FIqKMl91uo2szhF8SM2DsnKQAo/x3leZxBZTll+5sz4gh/eYdx5B3UtrvlhIEawOWkN62mmYNomISlCTgK6/URDQutcCBanyg/4jQwI5rCC5Pi1yBGNyw7633Un2g4SSmbpPztVUV6jSHb/YTcZAF65byNM1fE1UImGLjPavVC0WfGy6ULUJUxt2ymgouOrmnFGqrj9K8fEArV5IPM4LV1CvQYlHuhFe5VqD0dQzYeVF3GfS8wkkDWd295pzk7rqKRJzw01i6ddMM0gdpjzTHVup6ppRNFfo3r9Hy/rAxJgTu4MV+y8rxhxOkSmiAn8/4c2LP4UA7QrT3uMezeBkBOvNRbcGu+5JdYK0v3ssZBctyHsAxoNYLQ0MZxUtByvYYFOgwKpVjdp9SK8S+OC24xkrsD7JOIopLw==;
 5:umeUfe6BoQPYGiXUZ+c35rMSbb5aGfE7QeA4m2197h6e0lrDFO61c/IbzEH8OJlM6sYtTVIquaEOwArUpzbqn3AOaWfrf5Uq2vo5A5JmsSOSIiV+ov8LeXiQ6z0+uyBTsPgoclzRqQYQ+guzcNqI8g2fixom68+2VXnxAVIW/wnJWHxZ9MAQZ+uY0bYkFHkqeZ9eefyu98BqjoWKKtOGzw==;
 7:56qjzqj6zJCxSI3F7WAUlZBb7R6/BgPbcjwAbZYdxXJQ5Y2YpmR5o1U9pY7oO3T5YvBalzTPSse40v7lZZqboyg7sdlKoq3yyVLcwbovf98W+tkNtf027PPFGt5KZZnmLK2crThnrzslQwfGpJN8EA==
x-ms-office365-filtering-correlation-id: 02deabd5-f5f5-4e78-7171-08d68797b398
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1424; 
x-ms-traffictypediagnostic: MWHPR11MB1424:
x-microsoft-antispam-prvs: <MWHPR11MB1424E1C8BED06D784A6597FC87910@MWHPR11MB1424.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(189003)(199004)(71190400001)(186003)(6116002)(81156014)(107886003)(99286004)(86362001)(446003)(8936002)(2906002)(53936002)(66066001)(15650500001)(305945005)(110136005)(72206003)(8676002)(68736007)(81166006)(3846002)(478600001)(25786009)(50226002)(54906003)(97736004)(4326008)(36756003)(14454004)(7736002)(316002)(52116002)(102836004)(256004)(386003)(71200400001)(26005)(6512007)(6436002)(76176011)(6486002)(2501003)(2616005)(6506007)(476003)(11346002)(105586002)(6636002)(486006)(106356001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1424;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M3e7hhRreM/hZysLU/gdM+cBQe+kL21yI3deKnNCRUIaOAQFFO1DEGeEo1WB2x3nk7RrJR6+oRYVP1c9y5Ad23s0RiJFcAo7MqvMYcBUTyT+6ByxaS+wAf2KA2MUClgXP20/e111eS3T/OnH2geXrm2VaZ/Vlk84Yp4jujkXS45WImnqGLB19vtKKbet2A/95vSnkBcA2rL6Ru65Cf2VC3RZt5gJCl/IXqaGIPTs1Zjn3LR2byWeqgef0G1PDfTmaAFWwPtO27LLpnrxmVmms9wYqImxqniKrbpzgDWdcN0GQskDfdtb9mNaSGPkZX4lwlIvsPM2HWv6k/Y/YIZMzXqF5P6GJlA6HPajq/JoC+EPY0Ng3SbiKcizTNmURoB3ZQTJhMeIP5L7S1MQq1V+yLKjX1RYEFlOZge9cDqRgM8=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 02deabd5-f5f5-4e78-7171-08d68797b398
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:18:11.6246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1424
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_081820_343390_3A0398F8 
X-CRM114-Status: UNSURE (   9.10  )
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
