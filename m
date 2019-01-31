Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA38BC282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:20:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 717BA20B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BOJ3ngTc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0KF8QOFJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="bf23ISaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717BA20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=z9xLO0bzVh+RkYjjSs6c4e/5Q4GUkHEg62tsQyKrHEM=; b=BOJ3ngTcyqOmYr
	ZsNBtooS5CU3K3efTY8ApKQtNBvQxJfLSMCJsS5OQc8kzpnxyBqBGL6ZqiVe+An95LwWZbCXBPOUr
	U521RAykDPevaG3SReA/Nnu8B3CKQ369rElwQcTiB/CP9go3xO+TD5aJoxkIih6rdsx60X+hzYm6R
	9l1rvj++JABpxK/uLZDsbUakLMB20nuIEgIgJpYPARnfo+mWAgo9nm5gOZ3k2iikWws/L8k0A/5NA
	FDbfFTm1UsuNi0VaresQnF5gb/5r4P684eB1j8NDqV1IxidVEp5J+zNSPuZasppgA0UlYwUqokdIJ
	ljs5Z88cwZtXCTOhU3Xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpF4S-00075L-67; Thu, 31 Jan 2019 16:20:08 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpF2Y-0005Hn-Iw
 for linux-arm-kernel@bombadil.infradead.org; Thu, 31 Jan 2019 16:18:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uFNU9hQrbzz7MnAddvvx938X9tBXjO1zBd6niod8Zlo=; b=0KF8QOFJx5E64KsES0/vVdk1zf
 KW1VZHYSEaRzLTcq3N1WKiLNL1AXzWJnqjIFZvTNGZcnPdcAIVyYw//ZBUvqz6zq0yGDp7PfeZHWy
 YV6yEVziwQvTaoP2SyyLUl5L3bgZnU5ilV39qE/wQkXceQxU1B+H82KKHAsONBIELiprFkElhFCOu
 pebeC+aJ6cS2KhWvvZ4QRtsdcVQ+TNddo87R6B1jJeCSxLMeCZdlgZnOVz2WysJFqGN2WlpmFaAwp
 s1lR6r2i4j4Ti4melq6NeAmS4Nw5qjmsWDqbiOx3/pLEGa04vKAYL0rVfxahCmp52ED9FN5DRHTWJ
 J+cEbTdg==;
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpF2V-0008Fp-JG
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 16:18:08 +0000
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; d="scan'208";a="23261716"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 09:18:02 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:18:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFNU9hQrbzz7MnAddvvx938X9tBXjO1zBd6niod8Zlo=;
 b=bf23ISaSgbnnJKSeduOp6/T4x+9hM1LGz4AciDacJ2r+9PvwD++e7Mxb6BuOMqaEBCEjdNn+rd2cArMc7Y8/AOdkc2k9gmQOL96EHj/TeEQuoYYrkFw9XjuSUrw3sQN5gAQveJSlmIk0iBiKsFJZ4Kd/WbnU1wBhmgVxNNs37zo=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1823.namprd11.prod.outlook.com (10.175.53.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 31 Jan 2019 16:18:00 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 31 Jan 2019
 16:18:00 +0000
From: <Claudiu.Beznea@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH v2 0/7] add support for SAM9X60 pin controller
Thread-Topic: [PATCH v2 0/7] add support for SAM9X60 pin controller
Thread-Index: AQHUuYCIYmzCBuLbeE+gbwGCJdU00w==
Date: Thu, 31 Jan 2019 16:18:00 +0000
Message-ID: <1548951466-26297-1-git-send-email-claudiu.beznea@microchip.com>
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
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1823;
 6:AT67PYUNSVbBaNRDS49vrwU1reNfRhk9AphzAepjK2fSxOw89gyXn8q1ZQmkd6TJjGcWagDG+qbNQf2r2m5GJhQu+WOU1boiCuBvXykE2L6wJ138K9/vV1wC9tgmluhLpC5Ux0sNKV0m7BjkhhrXDsWRB/hG5tQrd75ZvhUTBr3ekzvWe6Hb47Iq9xYhtAHU1weULHO+AXjxux0qFeePPYSEod/ZQtn5SqMvwBrRJlLABXGIvc0Ou6ruESUvodJrfyCwwBSgucOkPbJmYs+k55+Ngy1yFNgTAgv6YSTC2r9Dhs2t/pzxCyNECu2UvddW76GieQ13SIqhI1CHi3/deZrQM2+MYSblY6OU0uQrTAaKgDPtLwBewuTHRCvXpdq6cnq3w3E4adjBKzBd/G+Mm3jeu+jgPXzY0Gc06u2YNswN3XeR/Q8kA7wtNxnEnPLBOVlzTvMm48soEaHeT74D0A==;
 5:oChDtB5CXO915i4ksr5iXIThEdBNx4bGGFwhhgn1qLV7c56BOQkJObkVNeQZ4CUxnEhm6WfNKIE9sT3L8iXpetMjlDmsEi2EJnwzslHZCDVoPH7z2QKTYEENVtPKNofKaW6/asm2sqNiZWltMoaeovrn3uchE0RCecI9oSGDrL7wY1GEBhmfmycTfczN8hFJWJOKoYJBhRNWjMqrFCtk8A==;
 7:baTlKAc4BUwVGHjCw6fQG+aFjdprgkoIl/NS1CQiuruqd8Sjy3kT9GTTUCmxiK3tQZcW9peoPa1qDiMSZMb/ACfY98Sf6kykiuzGl8yZZ/x98qe6BxR9gjUOznPYzFH5C4i+7eL/bjfc83j1xPrqlg==
x-ms-office365-filtering-correlation-id: 48874f41-44bf-445c-057b-08d68797ab14
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1823; 
x-ms-traffictypediagnostic: MWHPR11MB1823:
x-microsoft-antispam-prvs: <MWHPR11MB18236B40ED7B1E52B4C1BCFB87910@MWHPR11MB1823.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(8676002)(6512007)(14444005)(8936002)(7736002)(36756003)(305945005)(478600001)(6116002)(106356001)(71200400001)(71190400001)(86362001)(99286004)(72206003)(3846002)(486006)(52116002)(14454004)(256004)(6636002)(2501003)(2906002)(26005)(6506007)(25786009)(4326008)(68736007)(81166006)(316002)(6436002)(110136005)(53936002)(81156014)(186003)(105586002)(107886003)(6486002)(54906003)(386003)(2616005)(97736004)(66066001)(102836004)(50226002)(476003)(4744005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1823;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SLdy+hXFiaosAg16NzwLy5MCEwoqL8tvKZCxo1orMZJlMZcZRH0IoH7ha+5Ce9zwSQk6r9kGpBREj4B4NdSm9KPWMPnw/LAUpKXqaKXI+Bou5D+q0UTwLqzhntUJDS24QDxUvR1pN++NJJKuzi1lYNfIIEezvuj5HiqSvspUHy2331vtHOsgGKi1Ym0UNrQIFlyLVGCMqGmwNxMRZ8u7lMDCJufYjWU75mdvxtYpDy/E/UMYIh/H1ao2d3N7C3YNKFSqr2NeUXQX1bRjF8ZPbFRzJV3v9MQzoBmGi+0A4dAWf0X2mYcQMq0M6IRktu0lXkPsOJ5uEA8gKnoOtHCwlv+7fEO3gQItdxRpogbBs1VvKigL1kX9xiEJo1SnYrq/POS9CHdQjO8rYn2/SOJaDgQraJoTyFknueNCFxNHveE=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 48874f41-44bf-445c-057b-08d68797ab14
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:17:55.9498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1823
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_111807_956476_F094460A 
X-CRM114-Status: UNSURE (   7.21  )
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

This series adds drive strenght and slew rate support for SAMX60's pin
controller. For drive strenght we could have 2 values: low, high.
For slew rate we could have 2 values: enable, disabled.

Besides this I took the chance and adapt the documentation for at91 pinctrl
driver.

Changes in v2:
- s/microchip,sam9x60-pictrl/microchip,sam9x60-pinctrl in patches 3/7, 5/7

Claudiu Beznea (7):
  pinctrl: at91: add option to use drive strength bits
  pinctrl: at91: add drive strength support for SAM9X60
  pinctrl: at91: add compatibles for SAM9X60 pin controller
  dt-bindings: add documentation for banks
  dt-bindings: add bindings for SAM9X60
  pinctrl: at91: add slewrate support for SAM9X60
  dt-bindings: add documentation for slew rate

 .../bindings/pinctrl/atmel,at91-pinctrl.txt        |  27 ++++-
 drivers/pinctrl/pinctrl-at91.c                     | 134 +++++++++++++++++++--
 drivers/pinctrl/pinctrl-at91.h                     |   3 +
 include/dt-bindings/pinctrl/at91.h                 |   4 +
 4 files changed, 155 insertions(+), 13 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
