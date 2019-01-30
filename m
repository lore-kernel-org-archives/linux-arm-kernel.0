Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123D3C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:09:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22661218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q6Z7QoVG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="R8Pjid+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22661218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xbueOcSTBjXavkVhxunNYIFupoIAOk5M0nDCqvsrB48=; b=Q6Z7QoVG+bs+oN
	nwTT3MauahDU1ge/vYODrH2cd5jumLEuSiNOWFadYFsQr2fvB7/tx/5M47qpRH2LkOukEaCDGOiUG
	HCqKqklIpFvJVkozoqT53r3bet/RbabIomg1L7ROc825Rws139VefDIT8JlP8X7449/xHK1nA7pwK
	/bT0jiV6tHk2AcuSRbShlzs/dWsaceoxkJFt5xTNHL4Rz6uCcACCu/wc0+gStdcNOWTSTpzj26vX7
	qW6MorwlTo/L/Xjhi7bhw6Uztuua0pnIu7LWN5J4I/+LaoHm8LDmv+YNYuEsZWl4sIRj/dMHFIHmS
	KlViFQ4nJkIYnujaPPOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gorUC-00078z-6e; Wed, 30 Jan 2019 15:09:08 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gorTf-0006ZC-5J; Wed, 30 Jan 2019 15:08:36 +0000
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; d="scan'208";a="27058551"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 30 Jan 2019 08:08:34 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Wed, 30 Jan 2019 08:08:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7Keb5XM0YwP+J1+nSKhb0zOxAuAd2DRuVWY9PteKmo=;
 b=R8Pjid+2mGYIPgJDvcHO8Pw9NXxpMOJHSFrCTEHPamNmQgbuVi38ZpDNI1IsRyMPd41kaMDJ5Aqqcf4cpxb4k5XdFnxQuoinGhWNFponms5aQFobPLzUPQRxKf50eX1L0apYonDFcvjaCaMQxcI1ntnTLdWQVEAMFiwaH/3bsSY=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1796.namprd11.prod.outlook.com (10.175.99.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Wed, 30 Jan 2019 15:08:31 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 15:08:31 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: [PATCH 2/9] spi: atmel-quadspi: order header files inclusion
 alphabetically
Thread-Topic: [PATCH 2/9] spi: atmel-quadspi: order header files inclusion
 alphabetically
Thread-Index: AQHUuK2pIHfKRE2XhEm6S4eXsvSP5Q==
Date: Wed, 30 Jan 2019 15:08:31 +0000
Message-ID: <20190130150818.24902-3-tudor.ambarus@microchip.com>
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
 6:AD8+FnLymURF/ILr6d0bqhz/a7e3478ZLBEDAil8Gr1j0CTGzaiLwxuBFg8zFevdJWELGouqlQC7nrGv++S5pmcvEim5obhRCJrjVa9oepTvuR1LopzyO8QmH4R9goKPy2F8WGDfh8p82VQDHQkYGV7B2VRF61aHttT5v1ZEQb2lKNepLq9MK/ax2mzztV0o3sOJOrYml/BplIG3Ip9F+eyXgNAH6QlqcO45OmMtycqZEl8ejg7iAtCVNGO9MbRa1E85bNBqWYG+8sHWKuQFTOQc60ddTtb67uUF5PF3WEcLwbtPU4het2Gc/ekZM1g3FsgI8+Te6SXN3aup6m3TIEWh7OWJnq/5Jr7V/fAmb3SVw9cfTkuXg84yMxMKTqKpnAcJZ6C3EOrnN7poC+k0rSPvLSGuNxpSENQ1XBKraWipVy3rcVcPjJvrNXkMyY3uN8WXvL7PiSXzjqj/qX6knw==;
 5:i3588m+DafUo7sP0QZn9ugfRZJXdHnGj+UHDEF02LfdGKFj4TmmnFO7L/mRiBSuMNOQAaDCXJyUG8eGyJutBhXxEtZMhIRvIvhZGUzDLjS2NcZ3JTrsWCl5MIF0Yr2DaVIv5wWBbCn1DExU1OiNTy+Ln+Zh4VchD0C4BnldN6FgnmfFSTB5kSgrDneG7kCzJ09jAwYqTCjwDbvOR1/p5TQ==;
 7:o5GSZipg9iH3xQN3+8vb0xg7OlFjOaqQSEJ0fp0aA8NysXg73x8BVXK6+KtF3hqZKzYwOAgapripfwL1CJhu+jwrE3I9a8P/7DJd/grZlTsEZERI7aaD3f6Q0bqV3BgyqrTs4zf/htDyQL8/h6y0Ig==
x-ms-office365-filtering-correlation-id: 28717ec4-e49e-4dc6-6247-08d686c4cc0b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1796; 
x-ms-traffictypediagnostic: BN6PR11MB1796:
x-microsoft-antispam-prvs: <BN6PR11MB1796B4E1CA936EF4A908FB71F0900@BN6PR11MB1796.namprd11.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(386003)(316002)(81156014)(2501003)(72206003)(81166006)(4744005)(486006)(14454004)(476003)(110136005)(1076003)(8936002)(6116002)(4326008)(11346002)(50226002)(52116002)(6506007)(2616005)(36756003)(3846002)(68736007)(6486002)(6436002)(53936002)(8676002)(54906003)(66066001)(6512007)(478600001)(99286004)(186003)(71200400001)(97736004)(86362001)(2906002)(256004)(71190400001)(305945005)(446003)(6636002)(102836004)(105586002)(25786009)(7736002)(26005)(106356001)(107886003)(76176011)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1796;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OL5nIY6LbYQeOtRdRWe7wtZdecL1vIruQp1rvCx2/lxPItEeWRYSslfTNiZsI10EjFeEBZv7uCNwRanoh6cIOGIac7ZsFFRYT0dA+T0o91YXj/vagZwPiDf9OeHBHQ0qfxoZzxCB/t2g0mCNxGG9bvZvjbB4i6WRTwNEtahJuVlyr5aeQgsDW1hNl9MsO5ieweR+ABaDksYt4y2gxT9s4ZebE1GxvkkYlByAzG+PJ6kYKBSz99Na6vr7pKB38N9BOyxwfMdxiaBfwa9Tp/kSOAVM+u3dcfpHJ4GMSjkLqgP9IgVy/Jp3aOozgShcoDDTu2R99GXTQTRxUfbgZ/DWgUsUxg0KVPBnwGF3QHHIHZlCHYEjpKptsT/RiNEGXtprvgOFDb7dh/cx549CR8KzpDQs6VR/noGlCQZmunb9bd4=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 28717ec4-e49e-4dc6-6247-08d686c4cc0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 15:08:29.9261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1796
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_070835_366529_5C8C1D30 
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
Cc: Tudor.Ambarus@microchip.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Cosmetic change, no functional change.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index f79b17792a11..64475ad16c83 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -22,16 +22,15 @@
  * This driver is based on drivers/mtd/spi-nor/fsl-quadspi.c from Freescale.
  */
 
-#include <linux/kernel.h>
 #include <linux/clk.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
-#include <linux/of.h>
-
 #include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/spi/spi-mem.h>
 
 /* QSPI register offsets */
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
