Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8FCC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:08:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA0320989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CSUmnhLs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="b7a4LgX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA0320989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ll83yNntSXtNDTKLmeXevFCnCQgWXvT4u7n98z7bkwY=; b=CSUmnhLsimdTSP
	aPyUaHzSo9u/H9WCrbWCmzQtRbJqYWHbi38yi/qN54zI55wAkngdSzoG1Sp7Rv13QRekhRq/jtVPU
	Aki2rtdQSCbnTzMkY8+6yXLxt0OkDi4lJkiQUCffNjmfq9qMgMdL878MazZzakfBXeB9IZ/PmURrK
	rmah3r6X/MZvrnxfTVontvmSAspGbOVuWPjfiZ9+xhqhRds0aJtExbIpfNh1jvA9HI8R4ByeJdMkE
	7XEcVC+a3qLY/9WebHrKkhGj5+DR0OVfV5yy6aDzNAfbtc3hjRKZoI+41KT1J/HYR5XV4VJmYRDqa
	Y+DvcNNfaxdJgIM9XarQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gorTg-0006Zz-FY; Wed, 30 Jan 2019 15:08:36 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gorTd-0006ZC-1W; Wed, 30 Jan 2019 15:08:34 +0000
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; d="scan'208";a="27058550"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 30 Jan 2019 08:08:31 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Wed, 30 Jan 2019 08:08:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpXbS9OZRX3oWgUoUuC0hMNL2D8csIhtfbn1sFcKWgQ=;
 b=b7a4LgX3NracZaDFYQvG5I9K0t7xh/xC0xx3lvVRT1+vyOX1WaCadrMZS2cNgu1+uyB4YkXw/uau2n6E6u4DVkmMKK5GZ1wrZOW2Khpx3T6bLRZHLk1lSNpXLvZEHrV5O6vE0SXC+I+kHSk+qIvnriaj/TJfMBiYuhwvybKMcIY=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1796.namprd11.prod.outlook.com (10.175.99.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Wed, 30 Jan 2019 15:08:27 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 15:08:27 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: [PATCH 0/9] spi: atmel-quadspi: introduce sam9x60 qspi contoller
Thread-Topic: [PATCH 0/9] spi: atmel-quadspi: introduce sam9x60 qspi contoller
Thread-Index: AQHUuK2nvvFYiCpvqUCIN9CcSw7iEg==
Date: Wed, 30 Jan 2019 15:08:27 +0000
Message-ID: <20190130150818.24902-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::32) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1796;
 6:TDMbpK3ecsZXTP5hcI3mXxmDniV3YMdSwgCG3Zn03XmRGVUl4OJHn/StKGk/lxFcAN/vc9aiACRnPqd6+AQXMCna2gC/0zw07X/Qcvpjd0S/E2EWUKAN6a0tSWE/+v/B7b//3jXkhvgk4StaiasJOQ65NG23t72FBSwOAiuuJCuBmdNHwUyIZD2O7u0jWKRYZ742WrgJdfl7Ro/6x8TPDGZdn7/aJX0Cb7fGjv7sEd+OEczmCH2BXTZnq9xtMSoDftGoPNwfQz38YUX5jmWkjyWtsruaHbErLsbKXsmWvAFmEkSU3drENxFOH76G06Evj8/zeFE3i4pX4MqA9Wqk5DQ9jlhS/tDTLNgnYwD01c+rxa/YAftYm01ES2YydH8Dh852kiVDJwVXLBk1kbYFlPZrbLFvbInCBiPKplnGDe1vtYnSXX1UcUaVQNZOWH/mQcAxbFzyxAbvefbbj2d0YA==;
 5:j5HEPE2wHzoXRXS8qrrXZrdHe5hy+MxHgl63WOy5dLr8jYUgGo70hhHMq3hOTqlTAFy+IQb/HIRNjkNISBtroRW3BtebgmHykiBZE3kRFhu8daztt7fEJS2ghxFm4OlYZx5EsEPVrRCm39FFwa5Cqixx5Q+Nemy9eCmxPOt8TrBSKEtvxVRpNxwIRPhHI8Kk0FG5MHEp+ki7kMAAQd1sQQ==;
 7:A8jcXRJgl4q96tRT1C5Ok/wmALfyyJ1Yb8sg6va8htmG8yrVx9RTDjBR+a/gJd+yJJSS4oTtbBayuFrCXJRpuvV4KNPRlYTf9JCmls6z0IZYr0AXFl1Kvvf+2Zq48fxW9CuSYmb3kNFd5IRmxObHQQ==
x-ms-office365-filtering-correlation-id: 4f585e8c-6eb1-4a2e-8dcd-08d686c4c949
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1796; 
x-ms-traffictypediagnostic: BN6PR11MB1796:
x-microsoft-antispam-prvs: <BN6PR11MB17965591C0733DFF281730B5F0900@BN6PR11MB1796.namprd11.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(386003)(316002)(81156014)(2501003)(72206003)(81166006)(486006)(14454004)(476003)(110136005)(1076003)(8936002)(6116002)(4326008)(50226002)(52116002)(6506007)(2616005)(36756003)(3846002)(68736007)(6486002)(6436002)(53936002)(8676002)(54906003)(66066001)(6512007)(478600001)(99286004)(186003)(71200400001)(97736004)(86362001)(2906002)(256004)(71190400001)(14444005)(305945005)(6636002)(102836004)(105586002)(25786009)(7736002)(26005)(106356001)(107886003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1796;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dxhKBzKH3aEVidoszXmiLZ1IwuQwKyMHXkAdScoufvxVK7TsXqFRg5eAL5IQpU8RSx55mtEK9lF0ZMKzJHAEpCdNl3c3L/Jz6ARRcA37VQNqLxiwdkJT9e+jvznzMctjWef3QC2yMViW+VUK/VljDCI8uEmwRH6LbETiehv/MEJaNRgBNcCSxZOuhK7uLCCFBfIxGrTA0nkqBz6S2QllicOnTSyphWMzaLsFh7H+oqungiw2+xyg3zUsWzZAW0ST7Y8u5ksra/cnQSV9CySZ6mMneP4mYAr6IQ0/DVCJFmXXQ29n2jktqXH8eg6nbnGuTmq9/s1hkygPo0s8IC8hYhkz8wL/+J3KBYauXJ2kYmY3ZZobHsFYNORzYS0uz73sCQ2UlUU2HqKquseP+uLx38DQ8eYabBGBUZwPpD2HQws=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f585e8c-6eb1-4a2e-8dcd-08d686c4c949
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 15:08:25.4265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1796
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_070833_202545_A45F3391 
X-CRM114-Status: UNSURE (   4.76  )
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
Cc: Tudor.Ambarus@microchip.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Patches from 1 to 7 are minor fixes or cosmetics.
Patches 8 and 9 introduce the sam9x60 qspi controller.

sam9x60 qspi controller tested with sst26vf064b jedec,spi-nor flash.
Backward compatibility test done on sama5d2 qspi controller and
mx25l25635e jedec,spi-nor flash.

The patches are generated on top of for-next branch.

Tudor Ambarus (9):
  spi: atmel-quadspi: optimize qspi init
  spi: atmel-quadspi: order header files inclusion alphabetically
  spi: atmel-quadspi: fix naming scheme
  spi: atmel-quadspi: remove unnecessary cast
  spi: atmel-quadspi: return appropriate error code
  spi: atmel-quadspi: switch to SPDX license identifiers
  dt-bindings: spi: atmel-quadspi: update example to new clock binding
  dt-bindings: spi: atmel-quadspi: QuadSPI driver for Microchip SAM9X60
  spi: atmel-quadspi: add support for sam9x60 qspi controller

 .../devicetree/bindings/spi/atmel-quadspi.txt      |  30 +-
 drivers/spi/atmel-quadspi.c                        | 406 ++++++++++++++++-----
 2 files changed, 336 insertions(+), 100 deletions(-)

-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
