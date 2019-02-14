Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDCFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:40:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C9562229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kkiPQwOq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="nde61tss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9562229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GcbQ226gqsFshHcEisuyqow+J13JM8DK8Leg0Y6tMPk=; b=kkiPQwOqYo8rFO
	7qfDj0FOCoIxr4hyv7vRuJAQkHemVs/wKREQzsSUTBpkLmD7lmGhaYlST1KGKwQzh+Ehj1Yoi+fwz
	x8v5M+TJeWF8w/6N2odzSv/SYxUDbybai9Lf+nUkaLtuVBZIxrmeKxyuXbq5emQ15+LtEPPStO0Zd
	b4ifD6qwey+i/zXrSg2VY4BT8KuEeJHlLtVrBDHVi8A1YotE858cAHJeDimtyFD2+xPU+bJVGoxGD
	f7JXvguj9OVJNzuekYN9sI/0kxJjsQ0PS7x7Kmj83XuSZiJU4lSAbAD5JTJELKkxLiJK+t0QyexVw
	/C9fix4qDy8iXvElMD4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guERK-0001Z1-5C; Thu, 14 Feb 2019 10:40:22 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guEQo-0008A2-BR
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 10:39:53 +0000
X-IronPort-AV: E=Sophos;i="5.58,368,1544511600"; d="scan'208";a="26553206"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 14 Feb 2019 03:39:48 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 14 Feb 2019 03:39:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCNUldA2knDbqPcnnpx9VqtfvGDrXfKf2MORenT3Vbk=;
 b=nde61tss7WezWE7bnh2YaUl2gtWjrYiIPXXqL2c8rSdPC9G5AvBGtnSnP3mOSveYX/FFDzYVf6FMIK6r9TysOsRMQibKfSuQ43xoJbO3j882B+R3SXW7pQMRy9MXae+a0oCn19JsK12wVTDMxFrU2p1aEmI81tPRJ3b34HdV3zI=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1311.namprd11.prod.outlook.com (10.169.237.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Thu, 14 Feb 2019 10:39:46 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 10:39:46 +0000
From: <Claudiu.Beznea@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
 <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: [PATCH 2/2] dt-bindings: clk: at91: add bindings for SAM9X60's slow
 clock controller
Thread-Topic: [PATCH 2/2] dt-bindings: clk: at91: add bindings for SAM9X60's
 slow clock controller
Thread-Index: AQHUxFGa1Ws9uMk6xE+nFNAsW8romQ==
Date: Thu, 14 Feb 2019 10:39:45 +0000
Message-ID: <1550140748-21714-3-git-send-email-claudiu.beznea@microchip.com>
References: <1550140748-21714-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550140748-21714-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0131.eurprd07.prod.outlook.com
 (2603:10a6:802:16::18) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [213.233.85.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e43bfe9e-f7cd-4ba7-cb6a-08d69268bc66
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1311; 
x-ms-traffictypediagnostic: MWHPR11MB1311:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; MWHPR11MB1311;
 23:X+n8mjD6Ew0rE802rFGwCK9NxzPgtq+Qe3ZHMqd?=
 =?iso-8859-1?Q?IVUuownbcxfg7YiKohoLV7kHeK1OGoJnFqFNVKvYDuyf9cdkJ7RAPtEkD+?=
 =?iso-8859-1?Q?Y7MEcIa8UvO71Bn7FruFe34Xl6ELvkjbfcvcKANwHBaphhf9vwrLYkhMOu?=
 =?iso-8859-1?Q?aQl+beIfjTeJBxdtHIM//rzYMrM85R8YGtgWaHyHCAkYjQV7D/lFzj0EIA?=
 =?iso-8859-1?Q?n6r/6KaYX0UReFZBe2/YrUlSZWHIdHbhZh+qoGSi4vqLCBqgBvkjyd1t19?=
 =?iso-8859-1?Q?ZNePQznlyUY+fwYpsc1oNaaOZiQp7zH1TTjmkRr6+RT8fZuws3tdAEFAll?=
 =?iso-8859-1?Q?fWAOt7ch2Izn9za7E7p/0bZlQHprsakTfZTMjiFW/WHtdxz7uS0Vze/+Y5?=
 =?iso-8859-1?Q?JEUsoV47DXVQaaUxe0qHAHKIo/AltLYrq5ioqv4bWAoNUsfYe9zR0P23MS?=
 =?iso-8859-1?Q?AVSM2ugiIdhBmQKCioilJMzUo5LJtQrx5Br6JhHRDti9fVDW/rMowjCDwX?=
 =?iso-8859-1?Q?JOHan7RcV36nZ/H1YHKHxJnNn6smX2A1YMIHvRSGfnt+kipB4GYU5Yu0Fw?=
 =?iso-8859-1?Q?hzRCcdAFv+8Qdg6qXUPmMbNgAKfr12ez5vZ1kzlixBUCFH+x3w0p3uhRSJ?=
 =?iso-8859-1?Q?VCDHZgH1Hb/akZNMVYUFzcs712cpyO31GR4oV7uDxodeVP86h1M+rDP1Dv?=
 =?iso-8859-1?Q?j2pvKjxCxBQR0GWBVi+/bhOZVpRY3Dc6QfEvwUZKwHEytP8OCKCsLC7MTu?=
 =?iso-8859-1?Q?A3zxvxm3UNapmhTeFQ2mq8Hxfjf0EjM7hj/+QbkPY2bVgdzPJ6U9gVvOy4?=
 =?iso-8859-1?Q?mB2C2ijkQeeoe1H0P2jLRHCV/TQzwIjn/XpTMt1oVeHTNxrI4hHwXoG/dg?=
 =?iso-8859-1?Q?A7pdOeq/LDgdw9iel7oCtGEbV5NbntDJZk+JEhB2XhlqB0GXSSJ9foclqV?=
 =?iso-8859-1?Q?qQFPQF/6XDI6Q/LIc73EDhGz/4vFERKPE0QtjuvNJim+Awrcgs9Sqm0NiC?=
 =?iso-8859-1?Q?vul1pMiCnGXJvGGS16Ig3SROGJsLeBO52GEskFgOpW83ewjdrH6pI8Bvgk?=
 =?iso-8859-1?Q?KFNtYb+azVcrZvG3t2qLx1Hu/6WAcffZnN3HrEscePe+PhPXLcxBnjjnAp?=
 =?iso-8859-1?Q?umvTibx8vdEp8SS5s5DJLVhNa3JRUdY0pz6HBP2r2STNKQsTafMkhOaEmb?=
 =?iso-8859-1?Q?Xrl3LQPo1lB7sAgzXBv8DUvvZkVjYnMfQTr7jlqfQSvpLVrJTr/qmdcdiI?=
 =?iso-8859-1?Q?o261JWKmTiRPRZHxSPCChZadje3Rr1wlphXIiUfE5QPff1yCDMgDK0BgT0?=
 =?iso-8859-1?Q?LX0shJmcO3IY7K8pFUbTP9j?=
x-microsoft-antispam-prvs: <MWHPR11MB131169CA47CBDCCE425801DD87670@MWHPR11MB1311.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(396003)(376002)(136003)(39860400002)(189003)(199004)(53936002)(110136005)(105586002)(106356001)(72206003)(97736004)(3846002)(6436002)(478600001)(6116002)(86362001)(36756003)(6512007)(2501003)(2906002)(25786009)(68736007)(14454004)(50226002)(81166006)(81156014)(8676002)(99286004)(71190400001)(66066001)(4326008)(486006)(7736002)(4744005)(305945005)(71200400001)(8936002)(76176011)(26005)(256004)(14444005)(386003)(6506007)(52116002)(6486002)(6636002)(446003)(476003)(316002)(2616005)(11346002)(54906003)(102836004)(186003)(107886003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1311;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dqCvHstP12UFy8117YeQBvp7FzrLqD4RLQAlMKDWKVSHdA/JRaMmNQDZubE+uD2TERD5d7QGi5d+5bdrGmXuzj/yJPckHf4b4Ev+D+rsUt1rmXCi+RBFxl2+WN982UWv2t2obksGJRsNmADGbZFvR7WLJJkNv1IHCZokdKweNUm/1DRi8IBPqL3iDjbQMRelNC/+RwcZpQSL5Hv/Dwg13lxZmbkWnMOV+0IbVXFP07+OPKpa0y8MhhgYsiDdCcKe/YmZGHMiXLoJBGYrRFYRW8MMVUxi9V0hsp1CdJngSYSvqW1r7xrzDfx3OoIZHm0cD6qovA11sl4sOYLBUTGndmtHsnjrb6c3WWZSS+el7jnHTznzZrYAgabOqKbp6dzJdEllck1rxyRrECexfxH7VFQIWyvzil3fwD6VM1cV0ew=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e43bfe9e-f7cd-4ba7-cb6a-08d69268bc66
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 10:39:41.7560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1311
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_023950_718742_B38B50C1 
X-CRM114-Status: UNSURE (   9.39  )
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
Cc: devicetree@vger.kernel.org, Claudiu.Beznea@microchip.com,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add bindings for SAM9X60's slow clock controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/clock/at91-clock.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
index e9f70fcdfe80..154686a5f338 100644
--- a/Documentation/devicetree/bindings/clock/at91-clock.txt
+++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
@@ -9,7 +9,8 @@ Slow Clock controller:
 Required properties:
 - compatible : shall be one of the following:
 	"atmel,at91sam9x5-sckc" or
-	"atmel,sama5d4-sckc":
+	"atmel,sama5d4-sckc" or
+	"microchip,at91sam9x60-sckc":
 		at91 SCKC (Slow Clock Controller)
 		This node contains the slow clock definitions.
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
