Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB80CC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:34:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEAF520821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tWVXjK4V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="EqRwYaif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAF520821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QZV/kkO71pcD6ph+F8iuWq/TViyYwoGlOXsCZx/zigk=; b=tWVXjK4VS+QWV/
	qdL98ZStHLEwQk3zypw82qP6dX02c8H4M1W4g6xRJxqWwusU84gwvBLIKTfTgqrO04tOiRhB5Uqn6
	L0avnvSTpcCKAInBh9tzc+khq4N/BN9XVrep23ijF62gJ3L3bv4JL4JE2aTtxo62ShjuosrojcniR
	Q4AaF3n39mcd9rO0TSVlFJ1BTvXRKelrGxDTOH7YQM3MZUY8QGJfYOC7Ar07OIn+QrEa4HOPVePji
	uocArSOgKP1kuT1CL1Mm8nPi/NhYkvBy0sUjuA9LQ5CKfsXzTqXqZHbuq4FMePbE7D29BDj6y2c5k
	peugaDAv2AxNqkQXtG3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr4bs-0003WG-Ay; Tue, 05 Feb 2019 17:34:12 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr4av-0002YM-LC; Tue, 05 Feb 2019 17:33:16 +0000
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; d="scan'208";a="26340118"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 05 Feb 2019 10:33:11 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Feb 2019 10:33:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilExX4CoBlbb6VpJB/DpV0CgUqLATdWKWBrBqCU3bJc=;
 b=EqRwYaifQqkGQUot4+8kLq2V4EFLKbe7/OcE7LfJSxZhV67YLp5JhGa+ZvQ+AIqZQ6Ic9LRaFywNJVt+cybCL/w9vzjxWeisAdjSxjrLpyj+gFTGBRDM1spAvWl5qaxkOZ8I5CODlkQ6ZLcjmpvlweWlCT4o1Zyj0so7zw7qiBw=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1681.namprd11.prod.outlook.com (10.173.26.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Tue, 5 Feb 2019 17:33:09 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 17:33:09 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Subject: [PATCH v6 02/13] spi: atmel-quadspi: order header files inclusion
 alphabetically
Thread-Topic: [PATCH v6 02/13] spi: atmel-quadspi: order header files
 inclusion alphabetically
Thread-Index: AQHUvXjcjl82TiRX0kyk3skfMtGbOw==
Date: Tue, 5 Feb 2019 17:33:08 +0000
Message-ID: <20190205173254.16388-3-tudor.ambarus@microchip.com>
References: <20190205173254.16388-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190205173254.16388-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0128.eurprd07.prod.outlook.com
 (2603:10a6:802:16::15) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1681;
 6:H8U+xXhTG3M3fA3+f1dvGm94NgXzQONPxjWWs2zlBLKWxoIVGBEfQGmBILRGp3eq1sxyjXfRfYV7bKvOfQSjTsGIb4CFZ6Wch1SG9VHvdoMsS4zae/d+o3RCNxdQIGZDaUoKcRqokz5ClYLbxpzsgxmGM/OWZPi1ST69+u46XKIgZ1sD3wt03TXNunBnLtpel2Ak4a5YpsMIUmrC2m00qRrb7a5h2hQiCOOJihp+HpbWK1RFrHKzIw79T0av/iqbjkIn4UCaR1ls5k/F5WQgPFIOpAjX35GUJZ3FpSfrBiiMZ4Zg8VMF8GDBpBt3CFIYkB2DwFb0lcnxKlkXdhEn4S80FYolfL1qZ7UlynHjlRnb33x7ntkTuzkr9slNbTWneErXY+EzXDCX1kZhNIztyVZ2yy5wHRTSGN4MZT01fCFNsx9i5hFVUPF6H4FHOcYFpJTEo144TEY8263BcvFDwg==;
 5:ON8nCxBxpT8FVTherDIm1D92htZ0IStg8zmp1c02NPwnhh9PsNak2+tInAQ2IuNJOOZbQNXU5MjHnFIU3HOBfNwEyvCsZpNFm2BnM+fc2AW7FoCc5nQnzrL5zQSeiG+9A+zwRE+kRmtgDxhO18I7mOA2yxpkeCyMKKn7qIfcNlr9uFxmYrKlo+fs7VhvXu1PTmSur4BupEWRnTXDTKDvzg==;
 7:5yHMGmvixgdtaotFjTQyn3CNbfTZP6SYvBy9r2ulfuazwgVXXCXsFjv+ArXAwSIWWqbxkarosVsJxgmkFj8Q+MkmjFGHWhWafE5gdgtnR6tW8Aa70NDNdU7+Q8+csGy+ZdPQvi3nsCf2SPBXsY1niw==
x-ms-office365-filtering-correlation-id: 41ff5320-808e-46c0-8afd-08d68b8ffe83
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1681; 
x-ms-traffictypediagnostic: BN6PR11MB1681:
x-microsoft-antispam-prvs: <BN6PR11MB168193F25E28A42A77C16BF1F06E0@BN6PR11MB1681.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(396003)(39860400002)(376002)(366004)(189003)(199004)(4326008)(186003)(1076003)(36756003)(26005)(110136005)(25786009)(6512007)(316002)(476003)(11346002)(7416002)(54906003)(486006)(2616005)(446003)(86362001)(6486002)(6436002)(66066001)(4744005)(478600001)(71200400001)(7736002)(97736004)(14454004)(71190400001)(76176011)(256004)(52116002)(3846002)(2501003)(305945005)(99286004)(6116002)(53936002)(72206003)(386003)(107886003)(8936002)(106356001)(81156014)(81166006)(105586002)(102836004)(50226002)(68736007)(6506007)(2906002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1681;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h9caS1f+0EWgcMUlQWo6a+Bav7pTUtx18076wctVx4c6KR9IXEgKoxS5TVkAl8/YMTvlri3e+SR0kMAlamhMBzEoo09+BLSBJSHGyLDZRhbEesyE1OWjkXTclvKKkfxURqZahKjzvSdQf4teHKlwI7qffyI/sAibdQqfQZ2INK4daul25Jc0S1ielJod76sZD3pa4tXbSC3Pz7OeG7tgTI4mrdPoqVOsMP2u4I51638ZdZPyATAMq7kmDHbEjhfP8Gr+u9LgHUnhcudsvzEsgpU+GHKdvut8SpmrnVyJ2YH6RiD+6lGmgv/1NhgHCff/nJnBKGHjHiyWnoQ5dUYrZVFgWtXiqBUjzU8BT2zqkl64D5IKzw8u4yC19FrnYpaPTa193DICbhVkWI6soPdmbZd9UFkxviDLipqJler3SIw=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ff5320-808e-46c0-8afd-08d68b8ffe83
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 17:33:06.4042 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1681
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_093313_814608_B4081F28 
X-CRM114-Status: UNSURE (   6.84  )
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

Cosmetic change, no functional change.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v6: no change
v5: no change
v4: no change
v3: no change
v2: collect R-b

 drivers/spi/atmel-quadspi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index d6864d29f294..7d83ce8747e8 100644
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
