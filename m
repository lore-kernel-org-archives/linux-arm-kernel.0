Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56154C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:29:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B4E218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kaSeDwta";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="BP2exMI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B4E218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YAyvWta7v6gBvaoWMzbM5FC6NqJA+uS733Si6//CDvs=; b=kaSeDwtadokUrk
	ljLGTIvInXU1sDaoKZp3ICCgO/lKDfKI5cTQbeYEKkWPqdq6zKt3caIo+qcai8OdbfQWJvJDt/Xq9
	D6revnSrEVzL9kLoK1xaewOh7FjtVgS9XhSJIBC6UN/+Yr1hSQBa4PUhXBoFBJKTxNIO62albTaHJ
	Mot6m/kkBnr+s0HImN/U5SiaHbQ8V0So9L9bjxEeicemy3KLlhssveji7zKD+Grq/o4hHE1aCwsUR
	IwPGXk+x4NrC42uR4fh7/npJeJ6fKgHfNy6ZQbr6iOhKEZ1KeGZFRYamDUNCqFMxgGniLFrrp3Cij
	+g1Si3KZB6xCtmMBEVaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpBT7-00039T-0i; Thu, 31 Jan 2019 12:29:21 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpBT3-00038d-8t
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 12:29:19 +0000
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; d="scan'208";a="26139716"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 05:29:14 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 31 Jan 2019 05:29:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVQgwxOAfsSaFBTBG+Lj3oaJdyxlWnEntQSrbIu4IyA=;
 b=BP2exMI54HKZpoj3qx784qv9A2r/0fByCYb74dM5HcyGKuxKkSTOtLezH8nMsBBiNiHnkToIu5PcGHUA+nbyCabGoIPx92lF4tDGwivHp5cdwebHRMRBuQ7sy3Qj3ijFBNU3HGYuIMMVC5awpBXR1o+wO/3YEMXnBjDZxHEwssg=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1454.namprd11.prod.outlook.com (10.172.53.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.19; Thu, 31 Jan 2019 12:29:12 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 31 Jan 2019
 12:29:12 +0000
From: <Claudiu.Beznea@microchip.com>
To: <linus.walleij@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>, 
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>
Subject: [PATCH 0/7] add support for SAM9X60 pin controller
Thread-Topic: [PATCH 0/7] add support for SAM9X60 pin controller
Thread-Index: AQHUuWCSpvS2KbRwaEKRGWaTrGVUuQ==
Date: Thu, 31 Jan 2019 12:29:12 +0000
Message-ID: <1548937733-20189-1-git-send-email-claudiu.beznea@microchip.com>
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
 6:4vFabOHQTbvQQKEtgEmAd7Rn4qtbv/RbGRiHrdFsAu2JMasioQ9HzCkDYq4cANbojGdXAyjFdXoyBZpAGIJSzXd0ZxXnEuUDg8S6Hgg3zw7jZ+JmBSb8qMYIVTMnt+JZ95H/J3RAH+wqlxNdvumEQ2/PXURuJ2Dl6sFf9OpwG8GaGX9xiN/u0SYIDX9YAwZOCqgSx7TyND6zEjamB/gGXlfF0II0HTlAGYUB4Q4cImB14P/Ujl7GKDyJ3EDSQQXp91OTC2+iczfpYEmwkx4CcAF57o0zfZPy1g4abf/Q3048Eyz2twNlRNkT7yJ6oSnVW5m510yLiUv5IRvMEa3tOjx8DC2X2SzhivWY6OY2RsDkxDi5LQKqkanK+cTFlfjpDkabVQ1pkVw2f0dhKF3Cuq0rokbmaXuRm4tG7l1nLlKogM6owPVx5oHVAuIFn2JctRtQ3qnOTaapdwZeQj+dUg==;
 5:77K5JDDNT+N1OXSOqmm/XN24W+riTUd/HxGJiqMUyudYH0xOU15ySeCeq8zFvBFrj2cxveXFb2VqbjCKFmGQdqHA2EVIOjqG4PSJKg33LzkFRiZLPpwc8tA3rxf/3wlDvhfSW946lbQ2TR185x3BGqEkvICquP0uuM+aZN9Yyiz4ePodGq/io4lKX5/72xEvtuPh8ldmsr0UVjwiPc46eQ==;
 7:icl7IhfZ8xVFXxXXwML8uEZNeiZCpOSwSafsg5YXHRlNYqVZ7oz6xMGc9/XzVy+w6KfspOKttCm/H5wurAknuD1OxQKecghS2Jh1HU+FKHy4Nw6nUvHEcT41ggzOLs+E04G0RxRdNK7cz3fE5o//TQ==
x-ms-office365-filtering-correlation-id: 8685c5e9-d2ba-435d-aa82-08d68777b454
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1454; 
x-ms-traffictypediagnostic: MWHPR11MB1454:
x-microsoft-antispam-prvs: <MWHPR11MB1454868EE9E7F700312F33C287910@MWHPR11MB1454.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(2906002)(110136005)(186003)(8936002)(50226002)(4326008)(25786009)(6116002)(2616005)(97736004)(476003)(305945005)(66066001)(3846002)(36756003)(8676002)(7736002)(14454004)(72206003)(81156014)(478600001)(68736007)(486006)(81166006)(107886003)(4744005)(52116002)(99286004)(6436002)(316002)(6486002)(86362001)(54906003)(14444005)(2501003)(256004)(105586002)(6636002)(53936002)(106356001)(26005)(71190400001)(6506007)(386003)(71200400001)(102836004)(6512007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1454;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nUaPTOyZw2kQ5sFC0CZ0hdDi3A02YnZLBJRHz25Cmm+1zgk/cxh8ox1lY2sKeD27ZzSfthLx5Xow1tFH727VDLdMrzrqOalO3c9tuvmKGa7hckHiAxeIFtEPNhHJ+69wxu7ce6kdkN7aPRYZYmmWWELilGeJg1hIn1kzI7JyhunSaTpjMGPuqvwpqeme8kDKquQc03+WeX0XJoGomMrlQ2uhRFD2dMd5CEpnTX6tkKXkH8Oab+uk4blBxeXTtc0q27B30A2RM23+Z40OPI34oTE5oOf7KHNu/OwI/29Oc4gNIpZm0UUr45XVLpf/bHATecKNB4qSxPsuNPWJ+5f4edxGAJeBo/ZpBdugR+daSR2kVO/uYdYfuCeu/ZnxDGRY0k/GJlZpOowiNnWIvx/hcxd2u73x+PBeudSctUs2i5M=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8685c5e9-d2ba-435d-aa82-08d68777b454
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 12:29:08.1161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1454
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_042917_744635_484367A8 
X-CRM114-Status: UNSURE (   6.07  )
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
