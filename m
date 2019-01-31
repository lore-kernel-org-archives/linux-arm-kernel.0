Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC3CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:20:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDBC52085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DeXAGZPu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="hXPj5B1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDBC52085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EUJzwnOYi3vCsFDlFZTeYN3e3A5YNFjhf8xEMCa9JlY=; b=DeXAGZPuogSlR1
	o4Ly7OTHcYb5dGUUgzruEuag9ZR5M5S5fOT4sf6nn7qvM2OEmzPACBhZag5SaXUW9EO515YTn8Qb2
	xUUbTP9K0NMHIQ9KbHBu8V7efKE7Gd6Su/foj5DCY5uyzaZA6KhOmvLbLK7VLJC3trpUPJpaO0amB
	zitMWraUReGw/6E19XOyWM56qDFM5/1yYxqVtMzU+hdibE9V+7vWkbXR4GbkH8OFGpLyBo2T1eoqx
	FJAf/kjIFDAdFp9/TzcLhmnuJWjTCUECCZxLdmTJQ+w1SrHtSf1y0GXvPPQgU7A6JixpWlwKvuKIA
	wnGfp2aIUa6P4wj9wOLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpF55-0000Qv-KF; Thu, 31 Jan 2019 16:20:47 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpF02-0002zw-TU; Thu, 31 Jan 2019 16:15:39 +0000
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; d="scan'208";a="25990724"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 09:15:33 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 31 Jan 2019 09:15:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXT5CAqJqrsddP0v+H9j3bI2zNh1ct0eXs+9RFMdhK4=;
 b=hXPj5B1u0wH78iYsyQyBHlTq+tTiGWxE9cjPMkYZdj0fEqTF/BF4tErrQ7m2ngkZTd0ZEp8wEjA3DymQo31CltIAclIObk+RXNIfIvhmsbGZZpv6sFp35mGVI9wNGc9FNLO/Z1rkiUcEfQ4p53ZARmvZNyPzxM8ngeWT7gQtXOs=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1874.namprd11.prod.outlook.com (10.175.101.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Thu, 31 Jan 2019 16:15:31 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 16:15:31 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>
Subject: [PATCH v2 02/10] spi: atmel-quadspi: order header files inclusion
 alphabetically
Thread-Topic: [PATCH v2 02/10] spi: atmel-quadspi: order header files
 inclusion alphabetically
Thread-Index: AQHUuYAw8ZDPknGqbUSbsvPqrU2nUg==
Date: Thu, 31 Jan 2019 16:15:31 +0000
Message-ID: <20190131161515.21605-3-tudor.ambarus@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190131161515.21605-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR02CA0046.eurprd02.prod.outlook.com
 (2603:10a6:802:14::17) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1874;
 6:XkBaC8fBFY/HU46E2m2kgbMzINQiEFUCIwI1CeTKKLa1TCmiybyC2TojPANp0jtVWoadbdLFqHAscwcvo+bImMNBztSoXFtBtDmssXcVSwEvmatDzPzn+gJzEptlrGDa2aBqLD7Pf5Xks/6/REPsUKilxmOOqnnmlSRPS5xt52Nv38ESXnr+BfTYqXkzY8JSwWNzTh/PLw19fFSWngzX7qPS574x70NJDG+31hTbfwM7/g2JeUhxNwF8U2aeL9HzpCi1x435Jo0+2cI/OmhVkCGn3sPZtLsTOiBbdpeWpayVEbyvzRQVgncWMtzP70DFm0vV6f7qWH4pbqTBKC4W4l1a7p88QtXmtKotBeBdA1Q6RlHRuqaASfLqg02y+5DmxdDIRr2rMdJTx4PjyxqV2T7/7wjI5KNpF0+oJH5Jsa1X3W7qFxMrv2rmijZL8wl72dcpkwg+n8pmjyqJn3v5DQ==;
 5:YYw3XCQPiaOn2aOoRGfjAWmhnBKc2l2GWGqdCVBJPrTO5fIzk+5tFyAJYKtsZ6siXVdpzQ6f4YPfjZqk5js+hqYn394l7KNCzNRYQ6efVYiI0kO7xeetC72EsFn6QMvHb9CeEu1srzEPUins/obwtsEdKRPs3D++UinYCzAIFviA4mBWJDkB414BJQu4i1gstlDSai3D6zb+HSIzLeiHWw==;
 7:JSB1iQReViLklKhtTg+2QejBps+n8rcXn/co74rRnlXbI1oTfgsJiDdXAuOdu9JGqivzdObdC/v2SqUmQyFaqaeLpwiFY+mnuvR3gVJjnWBjcnrL7vA7qG2hr46MHry6E3EigCwbAUkBiefTBrMrTQ==
x-ms-office365-filtering-correlation-id: 317180e5-4011-4735-5dd2-08d68797525e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1874; 
x-ms-traffictypediagnostic: BN6PR11MB1874:
x-microsoft-antispam-prvs: <BN6PR11MB1874FC83A9DF6E8E96548586F0910@BN6PR11MB1874.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(346002)(39860400002)(136003)(396003)(376002)(366004)(189003)(199004)(186003)(107886003)(26005)(4326008)(68736007)(97736004)(72206003)(478600001)(256004)(106356001)(105586002)(36756003)(99286004)(54906003)(50226002)(8936002)(7416002)(6116002)(3846002)(7736002)(8676002)(4744005)(81156014)(81166006)(71200400001)(71190400001)(76176011)(52116002)(2906002)(1076003)(305945005)(2501003)(14454004)(102836004)(6436002)(66066001)(11346002)(446003)(25786009)(476003)(486006)(2616005)(110136005)(316002)(86362001)(53936002)(6486002)(6506007)(386003)(6512007)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1874;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Kp7AXn88HvCprD0m7QJiiiISghbNStqIT716qwkFI2IBax4+CklazfpSFBwzK2Dx4TZL3EBXAH7diDavV5fHhIb6wQygT/DR/zqIX+OUY68R3nEfKN+n1O3k7xwe3el4iowBtvnBOlmU7POheALBc6IKtc4Gy4x7YbfOtDDMIZav1yX2o/i7491CWU64GOc3HvG861a9gN6sL00PmfG5WilN2RKLoP/KM2nSrlLPPMRqmvYALtyRhVfu/bba+noQeY/68qzmq4U2pwRVQclEzhn9jODKVnxt/I0ExdJiwAd1d8o/M7pdOUexsJoNTAdZEY7C5jGCg/J9PsgI+WNJ2PQB0q561xCCEg4pc1CL3ycoSomhubxzO4T3gBEoeC0nfFQ785y7Hh9KuHqOEMFPncRe/vqTsZJZ18v2ZMnOan4=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 317180e5-4011-4735-5dd2-08d68797525e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:15:29.1544 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1874
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_081535_433973_04E94F7C 
X-CRM114-Status: UNSURE (   7.57  )
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
v2: collect R-b

 drivers/spi/atmel-quadspi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index fe05aee5d845..c986daa895a1 100644
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
