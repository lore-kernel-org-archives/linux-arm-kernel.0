Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1D7C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:30:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB342087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pUzeNvBV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="WQsKKfw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB342087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3xT0lxLL4tgMdrz21ZvJEU3oZRms6NZqMFDiAwjFvcA=; b=pUzeNvBV/k1Nvd
	1BH8ymgIRLPVKTVOJ2VHkzIB3X1JeFAmPd01/koD+bQZKzmLzlXY5pA6IlH8yGzbbWlS1lihLEmBC
	oMm+Y3wRo/oZnXc5phRy8uqfVgR3aj7HMlSMBr7q5iLFL7aSq18CKyCxqX9oHDU82cm5qRYUoH/6g
	DyM7tXHXURRafzA/7mCwzMG+07yGIuGK63jX9Bg+4erFNuJApebcNL1EXB0paXC6QxX8SBrQNaXEy
	1tjC+KvyvvYpuG7Bpu8MNDDnQVVRhI3imOOxKGb97ryD5I14sNTzWD0UQ4SbvLMZdLb8v9Fv0FRVh
	zTEv/Rvu8Y7610781s+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpBUF-0005FF-U8; Thu, 31 Jan 2019 12:30:31 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpBTM-0003OS-St
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 12:29:41 +0000
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; d="scan'208";a="25981390"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 05:29:35 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 05:29:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbLrbOt6+Bcb9YYxkB0kkjLn8iVxj1hXo2Nyy3ZAoJg=;
 b=WQsKKfw//J8zkn5lXlXwVDZABwsiABcAv7X8AmXGzVkHn1dEAeYlWs8a2VEup8sGLsJXBAOD6kVoPFTi4ieHqJDQt2vScHz9TAJppNGiNfcm/0Zmrn6C5qi/zmJlJBfuI5hZGudxfcCRa/QF7d9o7H/tKBNy3JTpQs3kEcl14tg=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1454.namprd11.prod.outlook.com (10.172.53.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.19; Thu, 31 Jan 2019 12:29:33 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 31 Jan 2019
 12:29:33 +0000
From: <Claudiu.Beznea@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH 3/7] pinctrl: at91: add compatibles for SAM9X60 pin controller
Thread-Topic: [PATCH 3/7] pinctrl: at91: add compatibles for SAM9X60 pin
 controller
Thread-Index: AQHUuWCeSP4bG3gsKk+RqaWqwuohGA==
Date: Thu, 31 Jan 2019 12:29:33 +0000
Message-ID: <1548937733-20189-4-git-send-email-claudiu.beznea@microchip.com>
References: <1548937733-20189-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1548937733-20189-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0036.eurprd07.prod.outlook.com
 (2603:10a6:800:90::22) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1454;
 6:vOksYcFodv7aynoXeKQB+vvhCTLTJTgLq3u5DzQn+ca+ZjWZK8uKCnArA4lwXEBz5cymij+WxhEuKh2kErtA0Hd7DMiss2W+kq9WcM0ZoX7rAi1UV8YpYJeMI02GN7jdpJS+jNQaxtjUVrfc3HdERobb253TkGnW2xQYmCFe+9jemZow0H7dPKKwx1p5YSk91TVxbcFeSkEqpwOmyQiNEJetvr0s34q11MlYArpAiedR0le2xmr/iksJfW67P2Z1UArO9iNsTRHaYJNcygVl9J113MNMgk3Q1uEW0huATRGQX7esKoosEpTjBqCeO2cLk9yzBCJ/PJn/iUZ6esQ2mt2hcYttcNwbd0PofKpqXSlhiIy5ZBD2eicODa13QawDMX0F9HrLBX6XG3ajyfGrLiFIVsudmzQI+EYSJ7THD5F4h7/SMHh5EhmX5fIbxyON/6PwfV7pFhlhcMFIZ8Ao1A==;
 5:YwLXMGf0CJypJx9u9lem634yeqisNhlTI4Q/YcAtoTjkED6z8b0kAIJi/LPgKnTJBQ/u+R1kLObgwcXLUm56+2LRbgWyPmKh2dZ34iozeGMywjMyecPOC3ianVnndJ3pP036rvALGJD+o1aSZSlPCnavAt+YZlGNXLPHGcm7Z+UfpKf1Qmo0DkWPJjIU8pXpQbN3t+LhWKm1atq9vzFQpw==;
 7:LpkuVrop84uQLR888YGzH01vDnSNu3dhRdsUmp+STZOiUBMkDTy0fxKMgRQYceHE64i8wYcrafRkkUj8gdZ+sRjqSJcnjlHQHPuZITMf7kne9eD9NDwcPdzdNHUYNmZ47gaoszmeNUJXPeHdbjn7xw==
x-ms-office365-filtering-correlation-id: 78f9ad3f-1cee-49a6-cb30-08d68777c0f6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1454; 
x-ms-traffictypediagnostic: MWHPR11MB1454:
x-microsoft-antispam-prvs: <MWHPR11MB145412DAB5A1F140485CCD6E87910@MWHPR11MB1454.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(2906002)(110136005)(186003)(8936002)(50226002)(4326008)(11346002)(25786009)(6116002)(2616005)(97736004)(476003)(305945005)(66066001)(3846002)(36756003)(8676002)(7736002)(14454004)(72206003)(81156014)(478600001)(68736007)(486006)(81166006)(107886003)(52116002)(99286004)(6436002)(316002)(6486002)(446003)(86362001)(54906003)(2501003)(256004)(105586002)(6636002)(76176011)(53936002)(106356001)(26005)(71190400001)(6506007)(386003)(71200400001)(102836004)(6512007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1454;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XkFPmvCsGC3IV9/Linehc22wCtAHlyzcUObgJ2z61kjh3AM+1+2h7c73ebvODjC2NhPiIgyO1pcvua1Ocr5aYu5BfkJy9bzJciEQk91xAL7pRjqVkWkaZ2djW4IgrCEAl76WTHbWBso/kxfgfm+WcHUZd0hJiBb1DBWW58jiaT403H4mPauvvSzLFV6tlOIur6vaw5W5C00GuMG+pT63XRrTg5B9FcmIT/vKPNGDzXNFGSzjI0Wejz5w0WPtdx1hOBnxDUQM7y8z0csflry37/WoZRAW8SnKEqLHcbfTcM7o5LQEqEhhoffAijWMWIUjxOjgz1KJd+QVgUmJdg6UvbMBgxyjT+ofE4azAv4d5l1gj1bA4l8iBg18vO3reo/FSrpz8tUkTPNtIrXJkedj0hPe8vCkCknVd59zp8P+jrM=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f9ad3f-1cee-49a6-cb30-08d68777c0f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 12:29:29.7866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1454
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_042937_105992_DBD9D24D 
X-CRM114-Status: UNSURE (   8.33  )
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

Add compatibles for SAM9X60 pin controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pinctrl/pinctrl-at91.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 46443b97d811..5456a2692b8c 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1215,6 +1215,7 @@ static const struct of_device_id at91_pinctrl_of_match[] = {
 	{ .compatible = "atmel,sama5d3-pinctrl", .data = &sama5d3_ops },
 	{ .compatible = "atmel,at91sam9x5-pinctrl", .data = &at91sam9x5_ops },
 	{ .compatible = "atmel,at91rm9200-pinctrl", .data = &at91rm9200_ops },
+	{ .compatible = "microchip,sam9x60-pictrl", .data = &sam9x60_ops },
 	{ /* sentinel */ }
 };
 
@@ -1757,6 +1758,7 @@ static const struct gpio_chip at91_gpio_template = {
 static const struct of_device_id at91_gpio_of_match[] = {
 	{ .compatible = "atmel,at91sam9x5-gpio", .data = &at91sam9x5_ops, },
 	{ .compatible = "atmel,at91rm9200-gpio", .data = &at91rm9200_ops },
+	{ .compatible = "microchip,sam9x60-gpio", .data = &sam9x60_ops },
 	{ /* sentinel */ }
 };
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
