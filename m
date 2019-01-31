Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF18FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:31:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991A42087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LFnBchAK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="lCy620F5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991A42087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=74gbNGlAC9BOCO6Rs+2kiShY23ybzG9t9oqkzMUX47w=; b=LFnBchAK4ZX3g4
	maL/g1iW6fmOEa2NlmzqZsK9sXawEQB5x0Cn4awFMIOSmUy+vsaP6PIXGPFqxIsI8czTPfw6TD4xx
	LXqsrtdOqKoy8LdkvRomMNhs+Sp18hpqjE/EzNUVkmcxlsKYumXK7OWWoYNm6H95VN63LL2R5aJ6y
	VGeLegMyMho6cXFb7V6vdqYoYr6mBmiebCq89RTYciNSRtm9AMUVb4KFLtunPl4gVQhZtR1PF9N4n
	+0dU9yFmZEPrqXWP2l4EROlX/AucmHxqkXGcO5AzItz1jw5PcqzY0jmwlEJtchCh2jIsmcAsjltao
	fYmep1twZ6nTf6eK/zjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpBVY-0006HB-J2; Thu, 31 Jan 2019 12:31:52 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpBTb-0003cD-05
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 12:30:15 +0000
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; d="scan'208";a="25691355"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 05:29:49 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 31 Jan 2019 05:29:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GMg+yVpiwuQ9JyQO6QIbZ921QJYFkh4TXk33lG/aT8=;
 b=lCy620F59Xbt29k4SoQ/15FZO2oUnxBxBaQxLWMxAtOljx2/dTAh84h0apD8WtAvZXrTr09T4PPcnS3qAkb0B2Y6xDw5mk3CyjDUHgyBwYvQEYzZaqNVBhqMQQ8gYMNZNGZBwPz7G89OSox5fLbc1FEWxQ/bHoa2siJ41kiSYNQ=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHSPR00MB253.namprd11.prod.outlook.com (10.173.106.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Thu, 31 Jan 2019 12:29:48 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 31 Jan 2019
 12:29:48 +0000
From: <Claudiu.Beznea@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH 7/7] dt-bindings: add documentation for slew rate
Thread-Topic: [PATCH 7/7] dt-bindings: add documentation for slew rate
Thread-Index: AQHUuWCnjZQMTjLPkE+fKo8RZHGXxA==
Date: Thu, 31 Jan 2019 12:29:48 +0000
Message-ID: <1548937733-20189-8-git-send-email-claudiu.beznea@microchip.com>
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
x-microsoft-exchange-diagnostics: 1; MWHSPR00MB253;
 6:sw4gQWIzYU/LefecUlcIgmtv0ovS/+G9cBf17TGgSygraqooLCOKT0n7JLs4ajRXUqs6cwx/L5R+3uLtYjkvaH31Xo7FR7So3ar4lC26G6KeQDojEw9Zet6IPEK/NH/2pyear84NbZKzeYJ+qHfdwJ9EFf9k4GwXQWQIujihsNnHqsWBuJ09O1IE/JozM3/3rXD5rHRFgfGCAa7QVq115N0odasU1Y7lgOlyAcGLr+k1zlFR5HXYTxG43t+O31H6oGwoMdgqRP4vfjFaw7/Ai1LZuKBRIxOBFPLajiHxzMDrjmuoerbydIOuJndOFIE98cHda0WIeIFdKAatraq0P6gaUXg2QnsmJH3No6iG9gCj6M7b1JzjMsTAdVeuMQ0h3SLe1t/Uxpah3d23T6uJwC84GPSNRYNnAR+KakhDcoFyFOTf5eX3QH47eqxBWS1Y18ac1kS0QiB/y04j8oEhlw==;
 5:eswfjyKNoCnTqdpG68RCVMj9w16y5QT63p4rnGW6O4Xild7KxUdVoaDfxYSwLCu771PkkUpwQjqdzxNk8WNwi+jYX+qFnZcIc9uVnos0Dz/bd8z+OhjC1Vw/Chya7Js4LA1bmJNK3iSkRRcAlt9mlgF0yVANII0UTTASKwewQBPGK4/RUih6qzssHHlBP/HVQznwVqkSTL40WspVT3dx2Q==;
 7:W8ZxIJjCcjSlldqRsvwKAFd8AYB/iVy8ijCOS/XTerJYtrIuEZs+szT81EdQj7BVbnOcQBptoUByP2vvwrDONqkp2GS9mSa9IGpgFHW2BXMc/I/UIg2qXuVE7qQ04rQXLrh3BKGNcTdY1Himts59jw==
x-ms-office365-filtering-correlation-id: 4cce0f20-a080-4b28-237d-08d68777c9e2
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHSPR00MB253; 
x-ms-traffictypediagnostic: MWHSPR00MB253:
x-microsoft-antispam-prvs: <MWHSPR00MB25328424E8513D152BADFCF87910@MWHSPR00MB253.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(86362001)(14454004)(106356001)(8936002)(186003)(8676002)(50226002)(36756003)(6512007)(478600001)(72206003)(105586002)(4744005)(68736007)(25786009)(81156014)(81166006)(256004)(53936002)(6116002)(3846002)(4326008)(54906003)(107886003)(110136005)(97736004)(2501003)(71190400001)(76176011)(386003)(6506007)(99286004)(26005)(102836004)(71200400001)(11346002)(7736002)(486006)(52116002)(6436002)(446003)(6486002)(316002)(2616005)(305945005)(476003)(66066001)(2906002)(6636002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHSPR00MB253;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r9NE9pd7cJRpEFSqebhNxZQFTf+AROMbxWpdNkmLvPBK9q+mz60BYSg1h/W94sZHWS2F9z8EmZd3ArvYCxgyosUySKtiJzIt8Xam/fH/ybtZhPLN3c6rqs2yt/eTAvsv788PGt4rw3Kv2Td7Touy+Yszq/+Cgx/RSXh1Y4NLwSLyjQRbBl0EJUXFp+I1y64Kc+rYclDt36plhYiC4P6GofDh9NWfDZyRxWj5AnFmaAYvRwDK5dtKgJY0KoB8Xubp4KpQLPXXNV2V+Es1CD1vcZLP47vDV2bDdUX0xvddS3K14+GMI0rsStRU3U8PUvh4wWuupOjj10icO+8b26ged9hb5cQDQoMOsUpM23F8t8UJnuVwi+8qdoQ11c+KC6wKlHwW84h9dAvKx+LBEUkJUNlp1MwotSwDfZdX0RLFZuU=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cce0f20-a080-4b28-237d-08d68777c9e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 12:29:43.8781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR00MB253
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_042951_599265_597F9485 
X-CRM114-Status: UNSURE (   8.25  )
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

Add documentation for slew rate.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
index c2d51ed86d47..19c255346a49 100644
--- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
@@ -100,6 +100,7 @@ DRIVE_STRENGTH (3 << 5): indicate the drive strength of the pin using the
 				11 - High
 OUTPUT		(1 << 7): indicate this pin need to be configured as an output.
 OUTPUT_VAL	(1 << 8): output val (1 = high, 0 = low)
+SLEWRATE	(1 << 9): slew rate of the pin: 0 = disable, 1 = enable
 DEBOUNCE	(1 << 16): indicate this pin needs debounce.
 DEBOUNCE_VAL	(0x3fff << 17): debounce value.
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
