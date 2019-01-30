Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717B8C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:14:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB0420844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kcd4tHtJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="2ZV4+7xz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB0420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V/xmqS/e4p/TEuPOAl7piQ/Z57y7fEGrkpEM0itvGoU=; b=Kcd4tHtJcsEFBJ
	GTSGMOr7QtxXq2NRiQvZ6SJ61VyI9StwMiyUN25ZH+eoFW/CK7YZ0NqCG2ghgXybVogBWORgRYctC
	9z7hRc0+xY7TuCZOs5YlMLSUFp4iO7DiGu5g07n7sym7CchJWWYoKy/a3b04fapTh7e5frMsUUyLB
	Pa87feJJ6HiJ3/zHtJ0TBhH+/JaycA+w96utLW0GiHNErk6J3NORjGiJWnAZw3J2ByTk843KuRbWR
	VDPu2UTeaYH0FVkhxGTiV3BYix8l9ncJhLKClqTRH/XlWZo0WKlBKykSjdOdUstT3tAHzSgqYyTyA
	AC2U65AheY9auDyFC9GQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gorYz-0004LM-TW; Wed, 30 Jan 2019 15:14:05 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gorUG-0007DG-Vr; Wed, 30 Jan 2019 15:09:46 +0000
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; d="scan'208";a="25940456"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 30 Jan 2019 08:09:07 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 30 Jan 2019 08:08:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHHna9VDyXkM/w3fk4YcVBk9k8fvYwyfLaJ2raH3rsg=;
 b=2ZV4+7xzwIY2f06kZ7FsIwbrFNykyXm3H7iLO1F7ICfytjY/Syo+QwFzw8eZy83xAJnTdHUerKI3PELCD9d1nOFM4CZ2WfVQfawtSa1aJMsAJmm76AEeDQw6zmMMSb5ZSt6PeS8tc8rq2yCPzuzB/+8XIh44uf9Qvw7EHRWcYpU=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1796.namprd11.prod.outlook.com (10.175.99.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Wed, 30 Jan 2019 15:08:41 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 15:08:41 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: [PATCH 6/9] spi: atmel-quadspi: switch to SPDX license identifiers
Thread-Topic: [PATCH 6/9] spi: atmel-quadspi: switch to SPDX license
 identifiers
Thread-Index: AQHUuK2vEcfS0aw/f0aWTrM/MWrx0w==
Date: Wed, 30 Jan 2019 15:08:40 +0000
Message-ID: <20190130150818.24902-7-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190130150818.24902-1-tudor.ambarus@microchip.com>
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
 6:vu93DfEoNl8/wiZxoD6HfsOzOJdU3/COsNaxM6/5GpS9SM22dOfzzN/yiuDmUi1PV3u7dKVEhqSgjKrUnDCp/qg+gzx17hvUfvVx5+/3L79rtpxp1OBKK6+4MJXXx6HgpuGWWlEXA/np1vxie9vZKRnWhudsQkkxre9kSSovygAF84Il4f5JN5j+5qJkZQNf8O4g5F0XpnHFwF3MCKbpQMy7fVtuBJD2PhGWUlshl0vOQZXfvpxO6j25iOQ4pFZYZZXEk9WkzNsso8dsSMb6IkAQOZer4uAuGLrk0L9fUuhw0adPl6fUSYSjgtzNggQJWTww6PjqMK999yzdjsBRrUsPy1+egnXepLn+AMkZ8biCdC/VxSrG73m+NrEsMiTq+OTEKdfXC7aK5M5pBKJbfxz7n3ycTAGpO8i/VWCLFXU1u11ZaJcjY6g/zMfNTkPjGPNU07Ip1+0KZBsO/fWKHw==;
 5:Wxi4uGv3YtgHuiWL8rAZYB5OLp6OGXVkKrb9Xp45tXJ3A97/HqVO+qASkjl3HP0gmI69dMeBEZ5WSa4H49c2pA88ooTMwb+Pg827QlXDFaT/qaQQJK5WpmjD1vOdmSjUWR8Htw95Tq/vA/5LTx5gDLHSGwQvbmmTpvz4SRcG7Ai7vwf52JS/dUBUEELwL4sApJmhOtb8rayvrQcjlKJAOA==;
 7:ikR4zD4/UgXa9TOHCUhO49qUWXKq8go0HyIc+zCOHgXW5dqtCSVoCjYEtnR+29eID0ps6qnw7Bw5i/dyc8NI6Am/+ZRRWlPxgfc8aJaMzQdD2rMka0lkeZi40FEwYxKMMKctmWMPiSqejn30uuvhMQ==
x-ms-office365-filtering-correlation-id: 06dbf267-1f25-49b5-4e01-08d686c4d176
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1796; 
x-ms-traffictypediagnostic: BN6PR11MB1796:
x-microsoft-antispam-prvs: <BN6PR11MB179618ABE392C82B3D91A91DF0900@BN6PR11MB1796.namprd11.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(386003)(316002)(81156014)(2501003)(72206003)(81166006)(486006)(14454004)(476003)(110136005)(1076003)(8936002)(6116002)(4326008)(11346002)(6306002)(50226002)(52116002)(6506007)(2616005)(36756003)(3846002)(68736007)(6486002)(6436002)(53936002)(8676002)(54906003)(66066001)(6512007)(478600001)(99286004)(186003)(71200400001)(97736004)(86362001)(2906002)(256004)(71190400001)(305945005)(446003)(6636002)(102836004)(105586002)(25786009)(7736002)(26005)(106356001)(107886003)(76176011)(2004002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1796;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mmray3SYjCjRbRpg5izMX1CuozEWRiPli+IE0N48VZA/WmcfdGuACYf096irB+gr6AiPVx6Ql771Qkona6PAtK+0Cze0y15drUQrsDKzIjt8mVAMm78hCk9QEtP9vnzbsaab5NNik5lvBVWztcBbzWkf70sswkhdmzBC3yPn43qS9r3/+myNJe5obqYFvcceb5CampMovF1/xZb9ESdivWA89VdQ/iPmFz6ckBzvcGz70uKnLQNv3Kl06jgCfLdec01K/PYfoRDSL6ePwSi+pW2DLh/d+KUcSMeTJW77RpKBeMr5w8ZoJYQtAuGGz2pBhcpFQraPR8IoI8OwxfdTd+Ds8QU4v4g5G9XC8Uxm22cj3Gt+/nKJqTZzBOacpSBYKWoDfxM1mNWCF8nc5xQNjLuF9K9LpJGkcZ03oM4ZC9A=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 06dbf267-1f25-49b5-4e01-08d686c4d176
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 15:08:38.7632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1796
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_070913_484925_9D3B1A4C 
X-CRM114-Status: GOOD (  10.53  )
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

Adopt the SPDX license identifiers to ease license compliance
management.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index e6de6e3d1345..1d21db7851e9 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for Atmel QSPI Controller
  *
@@ -7,18 +8,6 @@
  * Author: Cyrille Pitchen <cyrille.pitchen@atmel.com>
  * Author: Piotr Bugalski <bugalski.piotr@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- *
  * This driver is based on drivers/mtd/spi-nor/fsl-quadspi.c from Freescale.
  */
 
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
