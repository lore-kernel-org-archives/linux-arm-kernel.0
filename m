Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F35C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:11:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B0842081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gDJWBaOy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="LMUwYrdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0842081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UHSxupNWIX1xE8iw9YDAX71+Qo5I07CNhuU6fWE9oTI=; b=gDJWBaOy8aFGE6
	3Ka+Yjnz10IVS/paXsXe3Gbic6ynpI739kD+C1zHCdM476E1rlcaw11BnzvpFfaYbU5Gg/b3SRtTn
	8FtAFIlxcAdTZK7pYi695vVrY5RMFdCtq7TvYUOo+E/DRWAQeW1hSDRxBe8Mmnfv8xUlC3QSVKcGU
	o885+96wBHiuG6oXBKdLqma+kJxzVsRDsSUzUdAZua2G/2+i64O04KJxb8akOQtJXK7c97uak/p8R
	x/rFWZzw8FAn2LajpNpS+BkggwWnvCK45l4QrufvXDthV3k99X3QSo/lfwjisEeNIqlbjf5ySAce2
	MPc1g+GHzrT9JwHJXbjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqbE8-0000w5-VU; Mon, 04 Feb 2019 10:11:44 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqbCM-0006NG-3H; Mon, 04 Feb 2019 10:10:35 +0000
X-IronPort-AV: E=Sophos;i="5.56,559,1539673200"; d="scan'208";a="25825536"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 04 Feb 2019 03:09:52 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Mon, 4 Feb 2019 03:09:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QudQEcBNY3IlZXAcjHloyvJjDnL9r/QZ3QsqUfCNLQs=;
 b=LMUwYrdB36RIqDIavx4M7bQJu8tqr2ud3ilFCgehi72uVopJHAfPYABdXWhnG73IssVoMbctUlTrRHXUXttdtK3P9Z8Lqhf3ernmT7se/k5SUwLKLqokn6ESKg7Lw73I1AjYlL2ZaHkSLLrN/K5j/Jd3leRjTSlww4f7dxvg1Ew=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1508.namprd11.prod.outlook.com (10.172.21.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 10:09:50 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 10:09:50 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Subject: [PATCH v4 07/13] spi: atmel-quadspi: switch to SPDX license
 identifiers
Thread-Topic: [PATCH v4 07/13] spi: atmel-quadspi: switch to SPDX license
 identifiers
Thread-Index: AQHUvHHEp1fPUXoA/UCY5jCZC4t8Lw==
Date: Mon, 4 Feb 2019 10:09:50 +0000
Message-ID: <20190204100910.26701-8-tudor.ambarus@microchip.com>
References: <20190204100910.26701-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190204100910.26701-1-tudor.ambarus@microchip.com>
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
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1508;
 6:4LF7YhruNp1aq4ni0Zk/Sid5MoycbRe42kUW8LknzSldrAbC1pj63qSWR+PBxp2MBIEWI5+ZhTV0RX9D2GjeBRKBKHJPDKPBo+RmSyu0tSfmOd+7ffJ882YF3XETdnsyPtpnD1E6A188GucSAHRx+4tPBz22656JwaogeqCvjB4/98ILXjDlst+tk4QOwGFE7wrOqIDpcMUmpaJdHt5Fgjfz0p7sVazemEJdbLO+FBU3VQhF+zzEYYbkplZeKZ59g8a38Up3SvijrMEX6IbZmD42RnEIiF2/YQeveVtD70nbZkEcbZQb3A2xlWizjzZ0jABfVDZd/aRgGJ+02PReyZukdMwCrVL7W61qm8fW1db6sox9FLWTcWsjAEWWsGpzrpg7dyN26yqw5XWP6V7b+1GIgFjGo9A5hV3i0TtXfTqpd9xVn+Ce4r2RdCHHq82mf1SaHR0m6uLrmnLTq6sHzg==;
 5:IIm/JxZrRlrdJlo7KfrBro6/r9CL+NvbtVdayOwYJNjjd8X9PBhw3tDwFp/VHq7jTPtVFAoUFAsV4QsSQHUcqoB/ihWctcb+gV8XU9iijVX9AS8pAiVOkOQR04uvG/9+1XfsJt+X59eeA7VedynvGAqyCYa9E7Qp4PGxroJcDxJkth79wuXZZMnJyxTiDpd89+yCtp5hZm9K4UtL48vN0Q==;
 7:JbSlE1bgm4sdoXdFlULqulY+41z3rxs30rDFBQ/tCiurCS5uGQB9anZ6lbSr3qX3LZ3IQlUkO5Nfb0Von5Mn6gp1Ip0PQ9NiSull9wxkKzLg/mKfkfTusC+OrGF+FqQM/8VD1tbpJxrQzWOa8LyE6A==
x-ms-office365-filtering-correlation-id: 729be9c0-2b09-498f-de99-08d68a88e64e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1508; 
x-ms-traffictypediagnostic: BN6PR11MB1508:
x-microsoft-antispam-prvs: <BN6PR11MB15086AA9CB5A7F5EA3950A13F06D0@BN6PR11MB1508.namprd11.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(6486002)(11346002)(446003)(2616005)(486006)(106356001)(99286004)(6436002)(4326008)(105586002)(478600001)(476003)(76176011)(186003)(53936002)(305945005)(3846002)(6116002)(7736002)(81156014)(102836004)(26005)(81166006)(6306002)(6512007)(107886003)(8676002)(25786009)(68736007)(39060400002)(52116002)(50226002)(110136005)(8936002)(2906002)(386003)(54906003)(6506007)(86362001)(1076003)(36756003)(71190400001)(71200400001)(316002)(97736004)(7416002)(14454004)(256004)(2501003)(72206003)(66066001)(2004002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1508;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u2MYBub+52mxCmFajoeCAAGpCvfZY6rgf0iPUhmMBrDtZ6FhdTjS/Iz0Afr74raxrP6Hv8h4o/9JIsOONA3iI9Z2Ty+mBat4sKufVWs6akVp1OeAEJRe6deKLFGwq5Qkgstn3yiMEJQBjdajwDXeSAu5iIeeD5t+gxQ7oakdmqDBqHxBW7jzJToIuIGEtUBuYbcswcat4YDBXP/enFCCogUHtCJZDaPYE2eCg/P+HD8i7+YnfpTlek2R9/1ama28HWF8V2n99fSZb3BX1afVNjwG49swxI5hk3Ag+el7XMV5jvXOiEJEduMST7G4Y2qfBShwwhVNBfPmwQn7f70Rs9wIhS1nbr9MGklfdjryoLtWy6K/3L1csIpP8MU9gnyGyGEo8pf8yti7m1OQTheCAYshnOY8b+48MfyUQ3SAdUs=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 729be9c0-2b09-498f-de99-08d68a88e64e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 10:09:48.0428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1508
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_020954_693269_273EA90C 
X-CRM114-Status: GOOD (  10.34  )
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

Adopt the SPDX license identifiers to ease license compliance
management.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v4: no change
v3: no change
v2: collect R-b

 drivers/spi/atmel-quadspi.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 06c31830d07b..ce4f8a648f45 100644
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
