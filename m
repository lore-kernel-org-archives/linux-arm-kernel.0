Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB4AC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:09:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A2DE2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DG62WXWY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="jn0guIsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2DE2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/sFLbG4OfNkt+FpkAqz/JJG2ZKSoB68GaMrrv0B46WM=; b=DG62WXWYEm4bGk
	wmpz9UMPCFC2hR7JltdOtng6KIJdpugewOUzWjEJ4xoZmk5vIJ8ICD5deHxY0xcaZKZczJdH5xBmy
	0bMAXNPvjw7K50E0+sFBBjYNHsdQBrbaQz1D+iNwIEKGmFqAEYXkYZ93U9/FAv2Un+aYVL9SLtjg+
	K+GB2CjpplvjgwUPOpQp/qMBnpIBL+jzQa9zRGsK4jOnzr0Q40daO1isR16FOjdhpEqHWKFOlWxxb
	y5oBZRvz40+m6ZlQ9+icu/yf8N1cj4gfcxptobJwX3H3wJL61tdTN6svEQYHEPPqnW61n9XWehQAT
	/gIFRae6zmO3OVrIREXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqbC9-00067f-8S; Mon, 04 Feb 2019 10:09:41 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqbBt-0005wE-4Z; Mon, 04 Feb 2019 10:09:28 +0000
X-IronPort-AV: E=Sophos;i="5.56,559,1539673200"; d="scan'208";a="23387560"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 04 Feb 2019 03:09:22 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 4 Feb 2019 03:09:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxGiQjvY1tBFUNKMNTo6+eO5z1XqGbISn0vd4kY3Nlk=;
 b=jn0guIsSXcInGD/Df0QiMFV1s/spJqTDSJ9COEf3ca7/QxdpvNdIdOnoif/6btuYfFQLEFkDy/et072pftci665I8lYOPgwt9g2Ll7upHSBfZpirsVC1e0FCbp1eKSSyrQ9mxoNDnM/bBARRP8180RZmiIhaLEK0tJr2nK5yuPs=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1473.namprd11.prod.outlook.com (10.172.21.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 10:09:20 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 10:09:20 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Subject: [PATCH v4 00/13] spi: atmel-quadspi: introduce sam9x60 qspi controller
Thread-Topic: [PATCH v4 00/13] spi: atmel-quadspi: introduce sam9x60 qspi
 controller
Thread-Index: AQHUvHGxs+YMRi1JL0yTwYRhTEiWew==
Date: Mon, 4 Feb 2019 10:09:19 +0000
Message-ID: <20190204100910.26701-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0270.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::43) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1473;
 6:MNb5h32zHsO0pHzrYLiUpUpx1bOMWYoo+ZsMQ5gIwt87RkhwJxWdoJrt5hzSDEs3Bfc6X6C2r8zse9A3SGVFX0iNGX4DK8I4VvZNQh3Ffvao51jI4bjHcDYvpbyB6JPZX5bCi/VlKqpTMmRJK603bp6TLoySdjLecoR2PaNXUcItjU5n6r0pKpiPK3q2Vx7Iylv3joh67J0amigSOv27G5RvvNG4q9QW+ptJDJZf+f+eLNdD9/0d3ibhIrRPm+eIUQVVt6jbys9VhdG88w53ODnKsmgHd5scFubwydq3Yl2aduzWhsFqMkXZ4vkmuC9QHlr7n7APEXQ6C4VwimywBGKlBUurd1XsD1KM/Tg9RXxfAglM9/s/Et0Bnl65mzmBek4Lusxci0AxpJxaOLVVPHXlp77pUrVxN2jUiLOXaS5kZ3HGT8Jq8RPnl0nzNalJ5SK5TjQpXWNQI5JIPyiDRQ==;
 5:xzgA+/ikLG1wmQCYaVG7NYXS4ckt8CIFxabP/LwjHEJ+g+cy21vtmEmTthOyYpgmS0npzh0S3ZMHFL7HHA/z8igoBbbZhdKGWLVQhDAAS4lOW6dcap4s8zAL/7Ev2iZhYgKwnmtERnSsiFnTL8uQOIsf9qFBTGc5MfDklVp8YZnlqJdmsqYE9dCoV7EepIP6VF3kxCXHOS/tSeyly/TlZA==;
 7:RQKCa8XADYkjwHSqiFoII7v/b0A6aucPANzuJucTyXNsrUEN4MTaN0m+/g4nVEjyuWFdK0jkblOLjVvQ0LpcQufETGx3Htz3cHkerrEvFCjkGylDJVajnA6sDohRT4+4FtOcxKh/CK6t08yeu4OwVg==
x-ms-office365-filtering-correlation-id: b3534988-5634-4937-238c-08d68a88d3f4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1473; 
x-ms-traffictypediagnostic: BN6PR11MB1473:
x-microsoft-antispam-prvs: <BN6PR11MB1473CD35F8261508D925BDF3F06D0@BN6PR11MB1473.namprd11.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(136003)(346002)(396003)(39860400002)(199004)(189003)(52116002)(8676002)(478600001)(2906002)(26005)(2501003)(186003)(50226002)(53936002)(4326008)(81156014)(316002)(66066001)(8936002)(3846002)(81166006)(6116002)(1076003)(386003)(6506007)(106356001)(68736007)(6436002)(6512007)(39060400002)(102836004)(107886003)(71200400001)(54906003)(71190400001)(105586002)(476003)(99286004)(36756003)(7736002)(14444005)(6486002)(97736004)(14454004)(2616005)(86362001)(305945005)(7416002)(256004)(72206003)(486006)(110136005)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1473;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qDXWe8tMnKIT6pKfEIlpDTNlgLfVOj9Ho+t9RQYPUvi+cCAPIh+7o076TC/7T1fRd08oAsh94VumloR1e59sUMKAcrOFQll+ofCnJESPi5uZ0nLusjVN+VYXUoCHsE90tXAzg9k8rKU+iJb/C8mDet7eImU/uJ1ivKTekWiPtUXqX+cvosxVKCq3kjjIOaqX8HoelwEPx7T7ycdJwBIGY99qC7cC3ePYiSFG10z48c4u8efeATsvDNTCFQaCqtYnppqqy2Jx5ppjl5Bm4EakWSj1E0dRt4QUl0VgCAAEm/HfwATtFqb5628PFjs1lSmfigRB803Zf44XIRR88Qq4U9G8mSj33vTq9TpcuNyBByPepPzoCCoELBOhXHvPnrH/DqazVsTFMUGCEKJ+N9spfL7Alw8E4y7qkmR+H4xzmis=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b3534988-5634-4937-238c-08d68a88d3f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 10:09:17.3333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1473
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_020925_284953_F8FE37DC 
X-CRM114-Status: UNSURE (   7.02  )
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
Cc: devicetree@vger.kernel.org, Tudor.Ambarus@microchip.com,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Patches from 1 to 11 are minor fixes or cosmetics.
Patches 12 and 13 introduce the sam9x60 qspi controller.

sam9x60 qspi controller tested with sst26vf064b jedec,spi-nor flash.
Backward compatibility test done on sama5d2 qspi controller and
mx25l25635e jedec,spi-nor flash.

The patches are generated on top of for-next branch.

v4:
- s/smm/mr, init controller in serial memory mode by default
- drop local variables that kept aq->regs and &pdev->dev, the compiler
  should be smart enough to store them in a register
- introduce QSPI_IFR_TFRTYP_MEM
- add comment saying QSPI_IFR_APBTFRTYP_READ is defined in sam9x60
- s/sama5d2_qspi_modes/atmel_qspi_modes, modes are the same both
  controllers
- fix kernel doc header
- move comment in function body
- collect R-b tags

v3:
- update smm value when different.
- treat just regular spi transfers when introducing sam9x60 qspi IP.
  Mem transfers will be added together with dirmap support.
- reorganize the code and change ops functions pointers to avoid code
  duplication.
- rename aq->clk to aq->pclk to indicate that it's a peripheral clock.
- drop unused and NOP transfer macros.
- add Suggested-by tags, reword some commits.

v2:
- cache MR value,
- drop iomem wrappers,
- make "pclk" clock-name mandatory even for sama5d2,
- rework clock handling,
- reorder setting of register values in set_cfg() calls,
- collect R-b tags.

Tudor Ambarus (13):
  spi: atmel-quadspi: cache MR value to avoid a write access
  spi: atmel-quadspi: order header files inclusion alphabetically
  spi: atmel-quadspi: drop wrappers for iomem accesses
  spi: atmel-quadspi: fix naming scheme
  spi: atmel-quadspi: remove unnecessary cast
  spi: atmel-quadspi: return appropriate error code
  spi: atmel-quadspi: switch to SPDX license identifiers
  spi: atmel-quadspi: rework transfer macros
  dt-bindings: spi: atmel-quadspi: update example to new clock binding
  dt-bindings: spi: atmel-quadspi: make "pclk" mandatory
  spi: atmel-quadspi: add support for named peripheral clock
  dt-bindings: spi: atmel-quadspi: QuadSPI driver for Microchip SAM9X60
  spi: atmel-quadspi: add support for sam9x60 qspi controller

 .../devicetree/bindings/spi/atmel-quadspi.txt      |  12 +-
 drivers/spi/atmel-quadspi.c                        | 389 +++++++++++++++------
 2 files changed, 284 insertions(+), 117 deletions(-)

-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
