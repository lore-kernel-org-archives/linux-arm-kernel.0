Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E46C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:37:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B602084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IvDTLPYM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="VQHELVJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B602084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4cuDbHc4Y6T0e6MxfeR7gqJiXOx19DF5D6DWjFI1ORQ=; b=IvDTLPYMAL+lu+
	VP4pm2/nCfKN2P28l568Fxx+0ETMqu9UP2e2AL9g6TUpRO9cr4v1oC0qHaBMi4vRzSzVGXFReEs+C
	PEJabFLOhmhdWrrvqVrizthaBgBovbb/im/vUAA2u6FGadXegwuIoFexHv0ZkQ+C0JTv5UsRNJ3pM
	LI2hYGtOqeiwKVMRA6AOKT7HX8ao35IjZdnI63WyUXNoyOFAz4aCDv6Jn4YLDE58XHo+mQzjM7c9B
	hY6RRZ65bqENwoS8GpvMq3sMEkdP00+oQwXB6oecmP+PlcNNgQzB534rhqr/e5kJr443QK26LNvNq
	njy0XNi2ttQ2UkAqgbIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grg7O-0007l4-Mr; Thu, 07 Feb 2019 09:37:14 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grfvc-0001IC-16
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 09:25:13 +0000
X-IronPort-AV: E=Sophos;i="5.58,342,1544511600"; d="scan'208";a="23535633"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 07 Feb 2019 02:25:03 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 7 Feb 2019 02:25:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umhZ9kikCJPc6++oHjm00Q42V994flPZyao+aMseocI=;
 b=VQHELVJSQj+yFtgCwixHb2u29/y1/2rgB5Wj0K0Hu2dY/Vr1adld17xJf8LJUIJqu2bCaJnQV2dziBaqv4WIJlrrj/eHR3o86yWRtkXLHZAninlASn35PbHKHKzgkS6AwYWBevrlfVB96uWVe4+SlHOYuWrxedZ5jXn02XHwq9g=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1757.namprd11.prod.outlook.com (10.175.53.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 09:25:01 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 7 Feb 2019
 09:25:01 +0000
From: <Claudiu.Beznea@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH v3 5/7] dt-bindings: add bindings for SAM9X60
Thread-Topic: [PATCH v3 5/7] dt-bindings: add bindings for SAM9X60
Thread-Index: AQHUvscAkc2UXwHoZEOYNtFhxKwNpg==
Date: Thu, 7 Feb 2019 09:25:01 +0000
Message-ID: <1549531468-1676-6-git-send-email-claudiu.beznea@microchip.com>
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
 6:g9atLaUgrSw7fX2glEgosxNc3l9UvkgR2M7kSZE+ZQPFzjBBJGg6hq6klzpQ4c7ZxpTJnUI8M6dmS8ngRip6DfHt9iZ/O9VFEL8UXtJFk+LCWJ6NaeEIqhVrsupe2oyUJP5tYiZpuDUxXil445MG+2g4O4G83oj5OFkiQicy9ujRwRdG1AeBPaUPG4F8EXJkdkAp6RRiRILpsIWi+Wh+vtLbkQ9MT4hWUpY13/KoCdD09t7gSERMIJgeGqaMu2g3tcqdiCzHT85Z7wJQH/d0Tc9DyNIEIfLrV/G03GeCw7RP3OzQQ1bYgDtRomFF+79EEC0Kc0Bwsngk2AhXSJsgDdfyZjGLHCRH3zE2reGCn4Dc9C/vQ0KB6jHSLyG8ARluDuacLdkEKAyUZRZS7OtoDQRBMb54KNncR14L7N3zLkgWmOzFORXqMRyf/1QxvN4XFsGUzezy3qlXRUOYUOZAVQ==;
 5:tVT3AWXxu+su0+wK6AykMlJhIW36jrKsDpeNOGjZ/0MuZiXOmI9nPdA5sCgalFyl6vNI1dzKJMKx2llIXMNHOKdJsQYXz2WjZFmD6VLdDtgFs2oj71bj4Qgk+UYHdL0AVJQ7hptF3P29fEgOLSfCNBE7BdC0PTw20ydvo59o5ohajHhyLJ29x/LVzSRRCV7gbrGLduhu7S2SjG/XGoLVpg==;
 7:H/nrhmFgMwcQlvlIPUAPzdkbVzoRMOXhQSQMuSA3dQhCY80/GaCXPgnHofThUKWfe68MFgQNznCI8E7MPY31u/4Jjv1qjWYcVfwvGa5VlxsqOWs9U4lGzoYZkUQhWDW/Pl8Vdhj2MFmlMHIMGkKp2Q==
x-ms-office365-filtering-correlation-id: 70471211-95aa-4c87-f609-08d68cde2289
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1757; 
x-ms-traffictypediagnostic: MWHPR11MB1757:
x-microsoft-antispam-prvs: <MWHPR11MB175705AC3478273AE702CBCB87680@MWHPR11MB1757.namprd11.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(53936002)(66066001)(72206003)(6486002)(256004)(71190400001)(71200400001)(99286004)(26005)(102836004)(386003)(6506007)(4326008)(25786009)(478600001)(2906002)(76176011)(186003)(52116002)(68736007)(316002)(14454004)(50226002)(97736004)(8676002)(8936002)(86362001)(6436002)(81166006)(81156014)(2501003)(2616005)(6512007)(107886003)(446003)(11346002)(476003)(6116002)(486006)(305945005)(3846002)(6636002)(106356001)(54906003)(105586002)(110136005)(36756003)(7736002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1757;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M/W5GPH3DmXjHwylJ27unVxVj7S5+guwtieP5Pw/nuRu/bmk7P66liMsEuA16wz2Y6V7aKQJd4rXXXApwMFSp2twRAVihftgaDMFTTq0UTCJ4U0yKAWLrol7toFG/3Vur/EsxmCxk5S+roiAFkSAl6q+HEhqyrVMccoEt7b50YKOf3VjHmlDWxl4C198OrZ82k+0xmAGR/BIwHkMWILycW8ImxDW76UZfMOvFMv5OgyzVgsALvZJTgC5Vjk3LXsRD4AP8kYTjAPK/XXJWhyI4bfAdJuSHeCWbFQFtS6GG29uBdj7J2W8Y76blvCClqVM8LR405otmNdPYhFJPX2CIrm2XSrvDfRYdGhLIUajoOTGjSzpCg4kh6rOAAEktJtXtpmDYxvn+SHjR6MRSZdLMXXdDpfNdecslmpiDVaa1ME=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 70471211-95aa-4c87-f609-08d68cde2289
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 09:24:57.8363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1757
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_012505_597155_8E7FCFB5 
X-CRM114-Status: GOOD (  10.04  )
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

Add device tree binding for SAM9X60 pin controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
index 40e33dfc36fd..c2d51ed86d47 100644
--- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
@@ -19,7 +19,7 @@ such as pull-up, multi drive, etc.
 
 Required properties for iomux controller:
 - compatible: "atmel,at91rm9200-pinctrl" or "atmel,at91sam9x5-pinctrl"
-		or "atmel,sama5d3-pinctrl"
+		or "atmel,sama5d3-pinctrl" or "microchip,sam9x60-pinctrl"
 - atmel,mux-mask: array of mask (periph per bank) to describe if a pin can be
   configured in this periph mode. All the periph and bank need to be describe.
 
@@ -117,7 +117,8 @@ Some requirements for using atmel,at91rm9200-pinctrl binding:
 4. The gpio controller must be describe in the pinctrl simple-bus.
 
 For each bank the required properties are:
-- compatible: "atmel,at91sam9x5-gpio" or "atmel,at91rm9200-gpio"
+- compatible: "atmel,at91sam9x5-gpio" or "atmel,at91rm9200-gpio" or
+  "microchip,sam9x60-gpio"
 - reg: physical base address and length of the controller's registers
 - interrupts: interrupt outputs from the controller
 - interrupt-controller: marks the device node as an interrupt controller
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
