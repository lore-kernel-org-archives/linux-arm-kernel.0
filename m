Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ED8C10F04
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:24:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F59F20700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ir8zYjDs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="biwZd7ta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F59F20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=64GGw2A/w8sxATp2wPd0/ryA5Zu6QRfz/e4MKBroGVk=; b=Ir8zYjDsQU4afD
	ifX+dpg3CR2aAZJhPFoXD2gIuEAUX8YxfQQYgQHCkcukDIt5BLtMpRjbNOSjSyOscVy6yInUkj7fs
	altJFfaO6gznLWlTUVyZCuWSDLKOoJRVT/CFlHHZXFTyppNtJBQf5F17dBNzjcr2I3Qu5p2EqqFNz
	5vGoNtoshYWzccaB8cZUJXROASt19zIqPFNjRUYdPGfjWLH82QMgWal5ldOo6Blf6t+L56OSv3zFJ
	GA+j4xY2qjvpj3L1ZSCJnClbknDEtsNabAfc3SrQK04vuPdctpvPhpZovwnz1rREOTyZB8prFYFxG
	1IC01wluGYK3Vq7BfTJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guF7i-0005Eo-15; Thu, 14 Feb 2019 11:24:10 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guF7d-0005EC-RQ
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 11:24:07 +0000
X-IronPort-AV: E=Sophos;i="5.58,368,1544511600"; d="scan'208";a="27707242"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 14 Feb 2019 04:24:03 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 14 Feb 2019 04:24:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22kaM9gu/Od0UUhT3RP6luUeshDpWdIKH1wz8ZZj3GA=;
 b=biwZd7tagfY3vQXJjbAR0umWwXZiKR4bNvMSzQy3J2Dg5rZc3+EN9Ej43/HLdKqIqs8IercruhyqZXYO//bA5wp4VIhvVSD0zCmEVeQwll73uK7j+5djF5RreTs+alkvmMaEm+jYVaVdhSNfphQvMlDQaVMui7K5qWXzDK4QETM=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1661.namprd11.prod.outlook.com (10.172.55.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.24; Thu, 14 Feb 2019 11:24:00 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 11:24:00 +0000
From: <Claudiu.Beznea@microchip.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <sre@kernel.org>
Subject: [PATCH 0/3] add support for SAM9X60's shutdown controller
Thread-Topic: [PATCH 0/3] add support for SAM9X60's shutdown controller
Thread-Index: AQHUxFfIwlhv0YVIg06o7A/bOME6/w==
Date: Thu, 14 Feb 2019 11:24:00 +0000
Message-ID: <1550143407-26109-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::45) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [213.233.85.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00ce5003-2141-4f1b-f563-08d6926eeac6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1661; 
x-ms-traffictypediagnostic: MWHPR11MB1661:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; MWHPR11MB1661;
 23:FTPUw34tY02IaOdvJP6KOESAyfMkxxg4HmmtoJU?=
 =?iso-8859-1?Q?2vmSMDYgQ/HhV2le/mkjhvqJjgV16p75jWV35T/Fe+1yRUeuZ5EbJUS1GZ?=
 =?iso-8859-1?Q?PL3Tlsffdk324vetFhQi+AxxhepOyRe86lIZURYENeGF/MxDZGxZ5n4jfI?=
 =?iso-8859-1?Q?tNQlRZUgmhXHQT4VmnCl17EjP93X1nHyCpA7GmYm9gmJGwwdTB6bvYq+mu?=
 =?iso-8859-1?Q?cCYtCtGHTN7B/13sy+OlKondSSdsl+tGSho93eqQ4mH7R58yYRFJ+9mL6q?=
 =?iso-8859-1?Q?z1K6soN4eNu8eD88lb9D6c1iEwFpomO9cRmx/F+rw5lMR381/ADRqPLX4R?=
 =?iso-8859-1?Q?84som4mOAwUVS8/XCqo/juSilktdiLY/9+a7vvV3d3JKHNYD6644a1QiYV?=
 =?iso-8859-1?Q?9AajlV0iFP0ZDRmT0F1xPK30YsVjqBdOU/TVVfz4UHLe4l/8Cp/gBNlObv?=
 =?iso-8859-1?Q?XQDxN6L++aKy2sj/xTIO1OelvLVV6N0RWgOCEgbs03gJ00U/hmA/ztEYdh?=
 =?iso-8859-1?Q?YsZv2UpV1i9AvqJSVfIc6PbT+ipNUApUvmCyjzwSlqzSgO5wulqwBMtW5U?=
 =?iso-8859-1?Q?BM3l56Hd7tspfQWKzFLkzTuU+LLjEuwn0nbvy9iTTeRdIbh4OwbARxaTCH?=
 =?iso-8859-1?Q?s/EE5xEcst9Dr4Eeth7E+iyDxlLPuYWlFS5/X/qnIIn28Pri9bN0cF+jz8?=
 =?iso-8859-1?Q?zGhPwi00SeLqfHqG9XU/7DZGHv6uKCxK0YEcFOEkcqezV/zo8NpTcDp7e5?=
 =?iso-8859-1?Q?2EQvQ/YKggze7wFcU8fqKsHMU7BlcCMTpUffNcGp1A1ftL7lwqGD1qzBfF?=
 =?iso-8859-1?Q?PmLB6l1EG0ziJCa6oIsiqx5xyC5tCo68nXEh4Toh71IPoevMtxL6z4ug3n?=
 =?iso-8859-1?Q?ixiybOa9s0iNTjFdhKxaT+v/jTwr8RvZJpQH9gyKPHakfxgp8PbyQXhzbg?=
 =?iso-8859-1?Q?17XJ6kTteUwVL/2143gii2ctbT58MFWjuUpj88jo/M7mlDw0bne7fvVItL?=
 =?iso-8859-1?Q?726GY2TAn2PW5C/oqfy2PcLvKl/aDsYDYfW5nMS1gcCSvXfj6ueQrBUU3n?=
 =?iso-8859-1?Q?FcgMDhMJ9OPviKwz+BSfDc+qpDpdPxY12wOGdi0AwHsMO32u0JnnFEyJuI?=
 =?iso-8859-1?Q?UYzePM6ZzU24ugHx0jzEQoVbn/HJCxDFqlN7dvZ+IWg9M8d3qicUAQ4TJC?=
 =?iso-8859-1?Q?nowr2zwWDHDEuEEhu342YVMndUmIET5I83RCZNRylGCoJ7HNRIh9c56BSb?=
 =?iso-8859-1?Q?szfC1N0TqrQHUMiDz?=
x-microsoft-antispam-prvs: <MWHPR11MB166123EA74E8FA2723F7BF0B87670@MWHPR11MB1661.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(136003)(346002)(396003)(39860400002)(199004)(189003)(68736007)(54906003)(386003)(105586002)(6506007)(106356001)(486006)(71190400001)(99286004)(71200400001)(478600001)(36756003)(72206003)(6436002)(110136005)(107886003)(14444005)(2616005)(476003)(4326008)(4744005)(97736004)(86362001)(316002)(6512007)(53936002)(2906002)(2501003)(256004)(6486002)(305945005)(186003)(81156014)(50226002)(81166006)(66066001)(7736002)(8936002)(102836004)(52116002)(14454004)(3846002)(26005)(25786009)(6116002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1661;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hgAVsWx1W2Ed2hlXBGasVpszqM+5oHMjK//3gddw5arIFBcZjGPiep+9aCexAo+lt04vS31D5T2yUZUrHq+GpcrVsSqkYrj968JlUN6bNTGoCXiRFh0nRgCcHYJh8IVBChFvjGg6qxLXp2Ufb9QLJmriUecfR81iZda58xmGClPO+OZ/XhlY+bcnE0w4vXJRnn971edcE+B92ZbqBMp6bIrHtPF+SsuzNe1LR+z/DKASJzwxrtR8Wb5/ZE7LbANOwtSBskTQal6MAGb/3fIB7KJVZ7Iq08nwgOX+p7vGZ/UW8Rz2O+ehinnTcFc3OVQ/aMDs4vltF7OkgW9y/d/AnROhttDW4gQgO3YqpdumMG8nWS3U7ayX84MJvqBCm5lxNTYC7LOdQiEQq5EXYhatEB8CjI2IPGm3/eUzn9m5o5I=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ce5003-2141-4f1b-f563-08d6926eeac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 11:23:55.7111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1661
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_032405_997504_EA2B3A33 
X-CRM114-Status: UNSURE (   6.69  )
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
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Hi,

This series adapt SAMA5D2's shutdown controller driver to work for
SAM9X60's shutdown controller. The difference is that SAM9X60 have
option for RTT timer wakeup.

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  power: reset: at91-poweroff: add RTT wakeup capability
  power: reset: at91-poweroff: add support for SAM9X60
  dt-bindings: arm: atmel: add binding for SAM9X60 shutdown controller

 .../devicetree/bindings/arm/atmel-sysregs.txt      |  6 +++++-
 drivers/power/reset/at91-sama5d2_shdwc.c           | 25 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
