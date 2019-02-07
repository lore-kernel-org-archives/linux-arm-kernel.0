Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9294C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:25:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F5D218FE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e4aKVekW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="OWPMMwB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F5D218FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tcd5Dx0RGr+R8Ng7cS7oGMU7U8djZd/pLJWzRXxvUbM=; b=e4aKVekW4U/45j
	uCrMC0b+7ogeK53H7vpgTYqlwRGLdWaG/YaLRQ1BdxhUc3+9Tu6yYUX7Ckhnl8WpvpcZAl7c2RXMJ
	y5gGgTu5y8fI0zbMiDRcxJyCfopfh+xgGoq6JkVvI6PEYintKJAsgqzlBCfeZf6y/306wHSNrZn0K
	m89Dte3q6YyWKI2x/dzj9HdADL9IRudzC8grPS8Dl0mM/uyv19eOC2FuFXW/8AI0Gxdq6kacM1G/A
	VPj7DPrDiHzON/ec1whUeq5HWdHjfS82rw4oXRi0dqZ3BZuuP4MO8bzqTEnHnw4p0dYaA4faLTJmR
	3DTPTSMoZEbe44aXDSoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grfwE-00032r-LI; Thu, 07 Feb 2019 09:25:42 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grfvX-000181-0F
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 09:25:08 +0000
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; d="scan'208";a="26410860"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 07 Feb 2019 02:24:55 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 7 Feb 2019 02:24:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1behtaKxCg0m81in3g/HDF2mBd1HLEugmpIuWg2IkSc=;
 b=OWPMMwB9rIRXWwMllHHCI1maK56U9+Q4fZplqjrXnZ+ZncRV7GA9c8u5sMTOxauEhMxcTGjRf4BElIUQFS2P3loH0TBXJAK5XxOCEAeQ45Zy73fG00MmcEa7GJSy5S32bpYLokuUoTUnaSRRqrvc3sYD1CU/N17whVLO5/C01Ys=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1757.namprd11.prod.outlook.com (10.175.53.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 09:24:53 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 7 Feb 2019
 09:24:53 +0000
From: <Claudiu.Beznea@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH v3 3/7] pinctrl: at91: add compatibles for SAM9X60 pin
 controller
Thread-Topic: [PATCH v3 3/7] pinctrl: at91: add compatibles for SAM9X60 pin
 controller
Thread-Index: AQHUvsb7V/4QIMwqHUaeWejdySg3Lg==
Date: Thu, 7 Feb 2019 09:24:53 +0000
Message-ID: <1549531468-1676-4-git-send-email-claudiu.beznea@microchip.com>
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
 6:2bXW6px+EsAvMRsv0WLbuR99qvn0yzvPhbsLQrouhtyPMtXpEXq6cbytGlEBERAYWkKaBw/2UYhHhVAqfb5wWEwoT8tqqSZncSe9pJ2cKMi+Et6nMXzqKGCgaIeGMFVgmVxPJjK7+Fp81WqJ5fbmp0v8jOE4rtANoGTBzfuN3jlHgjdi0j3/gELZl4puIhXtQ1GvZGQJl79EG1iOe3WmATQ/f9hql/XCAXopvusLRHY3nLI8wZf65+SKIW1It0U2OiVkRZAewQUvvDdwFvoD8o4O6FKyLWdd2JPqZqLAjs1BKGmXaqk0VA7kbH0B++5G+0byqprFKhfWtEW+u3iF2WfRZMoD6j4NsxKkl65JZ362OYXbrlHMKmNspA+rB+G8C6vzHkletpjSATvrXnZgIBSpSlliYCdJI3KhVN1xh1OfRmO9APTTyAYbLerab7s2/1LRc6nulTyUEJ3DaZZ+fA==;
 5:DSMihR8DcRX95SywSyRNQDaMCvhAWZlxHjAVlgRRwEbzWDNm8uMJfQK2yk3Do0pVj38PX4a5/iEE0uS6x1QtogMPFTEmGgp2prRKvYN9d23aP+i9zzedgWp/y4Foqx/R9Sst0VoQJ8XslPYZrABV80LFtfEu6iRsGxfl9U3GMYkLZUW77FzzPi4nZLFZu0MJICp29SCpy5AO+y2M4ZfnoA==;
 7:qYrCgUxyyQZN4A+n3T6D9lG1D7iLEUfxe7afYeHEjvdJ9uY7IZ2BEaQ5UIgfaa5wf2ZiVzVUoTffKga0pnDdsESuHoEgrKFZ9CP0LD3QbIWbexW3KrvdDsX660zST5ZypOfHBhWQ44dfAyIDA1UGRQ==
x-ms-office365-filtering-correlation-id: e6ab6708-fec0-4762-7d6c-08d68cde1dd0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1757; 
x-ms-traffictypediagnostic: MWHPR11MB1757:
x-microsoft-antispam-prvs: <MWHPR11MB1757546D2D1E0B278300876387680@MWHPR11MB1757.namprd11.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(53936002)(66066001)(72206003)(6486002)(256004)(71190400001)(71200400001)(99286004)(26005)(102836004)(386003)(6506007)(4326008)(25786009)(478600001)(2906002)(76176011)(186003)(52116002)(68736007)(316002)(14454004)(50226002)(97736004)(8676002)(8936002)(86362001)(6436002)(81166006)(81156014)(2501003)(2616005)(6512007)(107886003)(446003)(11346002)(476003)(6116002)(486006)(305945005)(3846002)(6636002)(106356001)(54906003)(105586002)(110136005)(36756003)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1757;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6EHvCMm8S0ibppWj2bAhuIeUcTDpTjKHxp4CH6UjgtHYgb1H7FAG1Dn75O70+ymuZLBBOGiCxQrGNfN5dHc4YE8lQSxuy5eXMcP3lH9MqLvmaf1PpdXmIMCO8aG6d6ljPhwyYM9vCpVBQG6OhTtT1zOcEmG/+hFfAHzZW2XpEb60YuLUytc5hEoPd2LB5rtycm586n0zG1PuOhZbhvdlflNZEruaPtQOcxAmuS5YSI6hUOwyEMmIcUmXWiNqNU2aKD4qTIwIHeMdUMFHB4E2fZeU12d9PvPwJiGvs06n255Z80QjhrUrm4a+0Mm9zOeoIiJl3rR7MNMo0UP3aQhruwLkU9skt9t4OpR+bmdv6ezTQgM5/7q8qWhY/ppmDJFopP6KEMEb0yhXKYf3xi+NZ2+PyHT/c+Z5baOipk2YZ+8=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ab6708-fec0-4762-7d6c-08d68cde1dd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 09:24:50.2782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1757
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_012459_612784_12A8C46F 
X-CRM114-Status: UNSURE (   8.80  )
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
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
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
+	{ .compatible = "microchip,sam9x60-pinctrl", .data = &sam9x60_ops },
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
