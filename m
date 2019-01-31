Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8C7C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:10:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18E92087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z5ihvE1Y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oIh4Kt4s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="d/yXLP3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18E92087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GiODuxMCZgYr7oexALqZ0gKaBd92EIZbxJHPCqU6Tr8=; b=Z5ihvE1YyrJZDM
	BW18SObbGdVdJxs5MU962yxp4WTUDj7jz7R5U5ROnEuuw/rNLW1bnryXZnWp+ZL66PlBO8wdv1cdy
	H2clwkpMNfkemcOhFTFMZf57vBcqGJcRezR9EMiiEoHoB5aI4m8yCyyQGzRwXsHkmb2DCDPJYwS9N
	Cz3X9Dkm3cAMvKB+acFKOY0nrPBIwuxFIEfszdzZLaKp8vMnUkVNH9qbnLaCMxt02a7xtfbkeBp1n
	IspFgo5XJmJq3E8c0HJRotHX+SAFiUVIY81IwIyTP/tCKQMutOO8rDpf6WQW6OEs49820W5CJQfch
	b99FGsvtG1IFfR73utoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpFrS-0007Du-Eg; Thu, 31 Jan 2019 17:10:46 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpFrP-0007DU-OE
 for linux-arm-kernel@bombadil.infradead.org; Thu, 31 Jan 2019 17:10:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DlWZon+rSEzQf1T1pd6TbimsUt2AGfcLCDR8sggSVYM=; b=oIh4Kt4skou85GVRuiXc8U5o5J
 3SCV4GAKGxB/wyQ7JOYF1G6Mu9Muk+Jf5T5nsJQzpeqfKLBeZVJhq+KzXiceLOw9dPNWx+jt5dt+l
 6YsQcNzX2uTEyhM+P9CZ6UOSf6b5NbPbXo1f7QLwMJ3Rw9nOHkLg/ByAci/GqpblpWoiOqSjxh7jR
 yzTXxBYmdKPwhlE4TEnq+sKdEv6NJATJozqkNPFkbcam1iCupH//OCpkBFuRbQjqnAIrrjW8Jfb8H
 1T+eYhtw1iWWeIYaOLSEny9AxyATbsA1yF1TqSwSgkNH/2hSfJjLMgU+lXp+jBb3eEydgYh6krf/Z
 wgOgybNw==;
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpF2s-0008Ho-Eq
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 16:18:31 +0000
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; d="scan'208";a="25990857"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 09:18:20 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:18:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlWZon+rSEzQf1T1pd6TbimsUt2AGfcLCDR8sggSVYM=;
 b=d/yXLP3hJ/NcLBLy2vUliTzKhZHyJSLq52Wdm9AbIAdZA4kYc6Od/n3vYFfYjBOhr00bakQKDAclkVgY69DAplNFcGXOCn2/X9kH+tsNsPNkycW/4st3Qe7zDWwR2rQO2ohfiRKITRNWSJ6p5n1gTxKmfMjlsoyyJbcu12+BBKU=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1424.namprd11.prod.outlook.com (10.169.234.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 31 Jan 2019 16:18:17 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 31 Jan 2019
 16:18:17 +0000
From: <Claudiu.Beznea@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH v2 5/7] dt-bindings: add bindings for SAM9X60
Thread-Topic: [PATCH v2 5/7] dt-bindings: add bindings for SAM9X60
Thread-Index: AQHUuYCT8H5qX/E+kUG+nGMqCjt7VA==
Date: Thu, 31 Jan 2019 16:18:17 +0000
Message-ID: <1548951466-26297-6-git-send-email-claudiu.beznea@microchip.com>
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
 6:WlvipejO/Pcr9NCy3K3kGHd9eWrblNt7fztsxHIkM6PUCdY9TiqDQs72tiFCf68tuPfoPPrsZl0uTpfFJA3VR56yUNKHDgSH8fJ4NL1Jk5MfIs8d6AZt0qqjyOFBxN0AR4babk5ByFgyPTn6QSEmcWUZBd5ebTe+9bPrdEthay9jVxI+b+8JZ/4HOx5E7U3fc0lw++k+XjF7KQPh4xUuVfrXhvS+1xmWxOZxcOiEo61paXLWW29sunMIAa3QOANW0U7Vqhwe5mprt9j9cmf1n00tIqljMLa9Vgw4ACwcf2oO9jkfQS2grzjQr3/Sei6OFJua2JCDl1GyIIN91UXCv7BMymIHMsS+cjxZC15k6tLPLdcy4jzMVYQysX/lgN/hdFHnAdgXCrtjXGQQDNCTIuOEZemS/qiLgUKS+cqhBo1PlPWDMlfkQK01TSgtSqv5LKvxnpbnsaHoZgNzKtq5Bg==;
 5:1uBeOD8mev8lehwMtoeYxwTF7++LYSIXJ4901pPgdGBLomk/Ly6+6jK8qQY1YFkM/x159M5aV6M528oJVaLFXHjPKAx8fatYUFf1U3sPRMBidzuE/2Imfy3o2Ki1I0fGaxy6rImJCw7ENZ1BKBvGQDCObJhISCTdLeBF5U7383JV4FXWKPDH7l6ktI09MKnTaY3gOZfB4LMb0vdIRC3uMw==;
 7:Kif9aLUaCwxpkSrpq4UKRItmFZLUlZwHYZlVBuHJkDbiaAvWBhtVSPPnkdhTEhwb0ZKADGrehJ2zSzn6xBbUsjzw9+3eYo6OfYu5LqMskgBmf0Rmh+oyUy3sxJVVVleqlNPdnUwDUB6/zhf6o0VTTw==
x-ms-office365-filtering-correlation-id: 23a68f8c-c8eb-4a88-f7fe-08d68797b580
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1424; 
x-ms-traffictypediagnostic: MWHPR11MB1424:
x-microsoft-antispam-prvs: <MWHPR11MB1424BC2D61E41ED13A1E734587910@MWHPR11MB1424.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(189003)(199004)(71190400001)(186003)(6116002)(81156014)(107886003)(99286004)(86362001)(446003)(8936002)(2906002)(53936002)(66066001)(305945005)(110136005)(72206003)(8676002)(68736007)(81166006)(3846002)(478600001)(25786009)(50226002)(54906003)(97736004)(4326008)(36756003)(14454004)(7736002)(316002)(52116002)(102836004)(256004)(386003)(71200400001)(26005)(6512007)(6436002)(76176011)(6486002)(2501003)(2616005)(6506007)(476003)(11346002)(105586002)(6636002)(486006)(106356001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1424;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E4Px3/iOcIDO/DBl1E+LReIaSq356oDdPGEbCpMo7Rd8O8QYxAVP4axK+DX78QGYdj04eygfCOPkkrWj2XIyhqpMYLu2cqHPBBG9lEZnAwAgDWuUxbKRGJ7psugDnO7C2YlU1ZfkuWO61vJOQIsjGYWp5Gwu4h7tE/SEtvMauuahZIJyMKI3DFvSin4yAXNlTtRWZVEzFbBIANet+/RLONrVD35lgd/F4NcPzxgSUuVujdY9gv24hXjEZLHid+3iAOUYEsWy7Cpn9Ru3lczwTFff1QdZVJtlnfAngbX8eSG57Nxv6NDhOkY0uO4urudoXkvPIr7iveUq0pVoQPLSIUhx6cTGYl3oXBdZgPo7SfQGv5Zmye7Bg+lDdXEBfLTIorOng4wtiBOI56pO7azFTpjQ0xxtMaAnrPkZAJvZ+tQ=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a68f8c-c8eb-4a88-f7fe-08d68797b580
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:18:14.7501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1424
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_111830_696544_8E86B582 
X-CRM114-Status: UNSURE (   9.75  )
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

Add device tree binding for SAM9X60 pin controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
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
