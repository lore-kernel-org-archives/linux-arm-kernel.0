Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF7DC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:20:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BCB12081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ugcncgx/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HOqomif7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="oAgHbpy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCB12081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vn3uQem4bg+6xyjGkLMUiezViva48/VWNxGutWWArOc=; b=ugcncgx/TS+wrL
	cl/4xg0+7e4n9KbZjequROmDnFBA6gmgo2bH9xy0KJTZju2YIisHUNvoBa/A3L8znDt9o4agOwVWI
	Vy8HNxxxr+2dL/xuSM75ZZoeZ6kcJ5vDKC0eT29zIhGp2xu27Ghr3psjXRLuvymDNhhYk6wOLbl7B
	ThEV7rwK4ihoWkjWLYDRX3aZ/u7Y+hAtfZWn6etPtaNkQ1Stb8fhPwmHQeuR9RXDobLbiHOv7+mUI
	m5kpu586Kt+1kLYZIYbB5LL/fTvr+d6zZ5e1vA3eMszT/pAEcjXqTU8NAa3LIJOkWbHpyzDTiVRK6
	fH6a804cClJju8SQDJzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqbMr-0005Ab-Hc; Mon, 04 Feb 2019 10:20:45 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqbMo-00057f-2G; Mon, 04 Feb 2019 10:20:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DM9YvZFRmm2TujWMa9nU320PQq2xBK8WAP6mbRCU62Q=; b=HOqomif72C24ZSL5tL5bmzqld1
 x5OvGjFK7uUQ/3be2desAwZZzapslMxDhcrnFmibVEQC8WiSYRFs/0Zy0g3EwhtzgAjLSCaKpX32Z
 EuCRCoP2nSKvzU6bJvNdxME7kobViObYbL/qiyv/UvHBejSa1EAl1f8v0Z0PcXkyqGApPxyxm6JEC
 8eAqCvy5sahX/9RwQfLKAkIN4vZ21kAfSzrg5/A3zcMwk5oetvWWucjCDdgRqirI0RGYHgydbNKo5
 dLtqIiduU/Ln4c31KF62uQ3277vA58uEnejukOGv5awKLf17WpQZ7l3bq4wMPFB7rAOQAlqSTidA1
 pKRWw1QQ==;
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqbCd-0005Te-RF; Mon, 04 Feb 2019 10:10:13 +0000
X-IronPort-AV: E=Sophos;i="5.56,559,1539673200"; d="scan'208";a="26269146"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 04 Feb 2019 03:10:10 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Mon, 4 Feb 2019 03:10:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DM9YvZFRmm2TujWMa9nU320PQq2xBK8WAP6mbRCU62Q=;
 b=oAgHbpy9TM02n/W6bIcNXCjQO3rfT7Zv0AoGEXibeFTCqfCt39AnYYB1kfAr+SohH1f5o3Gp6ToudHHxxvvG6wa3DO9v2yRh0b5iqE4Y5LHg0cx6biJ8RerxSHwOedQ8/S4eEIcy2Emcsy/LFXvPf5cHQfFT7ztRFIZmznWy/xU=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1508.namprd11.prod.outlook.com (10.172.21.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 10:10:08 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 10:10:08 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Subject: [PATCH v4 12/13] dt-bindings: spi: atmel-quadspi: QuadSPI driver for
 Microchip SAM9X60
Thread-Topic: [PATCH v4 12/13] dt-bindings: spi: atmel-quadspi: QuadSPI driver
 for Microchip SAM9X60
Thread-Index: AQHUvHHORQ3gmJMls022AUAaShGcrw==
Date: Mon, 4 Feb 2019 10:10:08 +0000
Message-ID: <20190204100910.26701-13-tudor.ambarus@microchip.com>
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
 6:F6H9QMlkGjUeufPohpPHIofAK/Q+1rILtJVyR6CABwmTA5dwHjPsOEqLG5kJf68ddhsD40+31ygumT8/c2TdWbuHhd70Tj3QNu6I/aimw2Rd3lUIH/YrfNVh4JwmwC9PNInar2uY9xVUz5EfczY2f6S/oSrvxMICE5YTu9RxbGwuLAF0yJvqxQN51PhOvTV3+YLGYBA4xv9QI//3WDmRvmHlWzFEsDbxZuNnABDC0ar8ljDHsKKG616aMru3kjQ95g0/d7VQHI/HNXBcgH6WoT1SFLQgcXZhRqu3ZPeriXbSzz76IRGEGcH1uZ0A2dvwh94Q7Lx6qHUc0ebQr81yiZvAonDzWLKejEeVmCokw/ae5hRh7QQZ58IcR1ZSmnnx3cKYucfUY45EplYpT37MZznSY7sxaQIUv2CM9vxzLE9QfgLDigvvm3UoxxHW9xg+Ehqsfp5YspcxxbueRnPdTA==;
 5:CONmofZgrPnM5MMq8vlShcM9MKpZBgCt50cSCc98cVIAjfGhFsKsjnDJo9UEIbFdSsEooC0pkneDopM4+mdOO7/xaIe1johz3jvvqgFWxI9PpkNaNToQNJYTp32Iq6ryGNvvxOGvTGm9GILRkwqLW7ed75E97fZyTU+0qopnfSJs0LdiIvTDjBgyQXO3JzlL/sqw76uULuef1buYlMwgIQ==;
 7:bkENbz5KA/kWVfvMTqrOuNcQPDJrKq0toK6NN0b5tSylCfLetlKoVqvhRpkl687eyYZWP5sSx1hRr3Gz8QNiM5ymC76Y/Kk+1haemIQ9xWWjIFrYqZ7Ye7niuMoYB1JzBCPfEgF5kuOFj0+elhV91g==
x-ms-office365-filtering-correlation-id: 6448876f-88b0-47a3-4b78-08d68a88f0a1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1508; 
x-ms-traffictypediagnostic: BN6PR11MB1508:
x-microsoft-antispam-prvs: <BN6PR11MB150881B775BA2AFBE17911C4F06D0@BN6PR11MB1508.namprd11.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(6486002)(11346002)(446003)(2616005)(486006)(106356001)(99286004)(6436002)(4326008)(105586002)(478600001)(476003)(76176011)(186003)(53936002)(305945005)(3846002)(6116002)(7736002)(81156014)(102836004)(26005)(81166006)(6512007)(107886003)(8676002)(25786009)(68736007)(39060400002)(52116002)(50226002)(110136005)(8936002)(2906002)(386003)(54906003)(6506007)(86362001)(1076003)(36756003)(71190400001)(71200400001)(316002)(97736004)(7416002)(14454004)(256004)(2501003)(14444005)(72206003)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1508;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VSKawq9VLWQHfpDKbDDL8UCxz0VH9bvmbsvzBbjo76BiXEgcnO4+S6Bgx8TquJO41zcXbhzaVnZvYS2/7wBZ1BIne8YKbESiVcQmBBcIpI7TetR8MNCD2nKpknQyNiGYrMJ77nq4Bl1pSJn7Jb3vr6OFgb/Iv9LZHi8JszCi6WvxH4eprytqK8RsxYtskN2cQF5HCEH0dmYLcptEE4vl+orB6AAHeLsAn0+UbAGJ9Ta6f20B1KNlA597oiPPEWVJuPSiB+3sHbj+nqwbEsSGOeT9/J9Y/tp/lip6oWmw4vvFiQDK4X+/A64jEOz4bMoDibonWL0IIA4PbKmqKB5w5MUPWveYx52MgMGbxpFfhoiruJqN3kVFICruSUk3XfscBID16sERCKjswzn0AFy2StQdx5MM29F+0YcRDwEmjBY=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6448876f-88b0-47a3-4b78-08d68a88f0a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 10:10:05.0149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1508
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_101012_216032_BE43FF83 
X-CRM114-Status: GOOD (  10.86  )
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

The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
access, the other for the qspi core and phy. Both are mandatory.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v4: collect R-b
v3: "pclk" was made mandatory in previous patch. Reword clock
descriptions.
v2:
- make "pclk" mandatory even for sama5d2. Unnamed clk will be
supported in the driver.
- drop unneeded example

 Documentation/devicetree/bindings/spi/atmel-quadspi.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
index 50bd257e6826..7c40ea694352 100644
--- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
+++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
@@ -1,15 +1,19 @@
 * Atmel Quad Serial Peripheral Interface (QSPI)
 
 Required properties:
-- compatible:     Should be "atmel,sama5d2-qspi".
+- compatible:     Should be one of the following:
+		  - "atmel,sama5d2-qspi"
+		  - "microchip,sam9x60-qspi"
 - reg:            Should contain the locations and lengths of the base registers
                   and the mapped memory.
 - reg-names:      Should contain the resource reg names:
                   - qspi_base: configuration register address space
                   - qspi_mmap: memory mapped address space
 - interrupts:     Should contain the interrupt for the device.
-- clocks:         The phandle of the clock needed by the QSPI controller.
-- clock-names:    Should contain "pclk" for the peripheral clock.
+- clocks:         Should reference the peripheral clock and the QSPI system
+                  clock if available.
+- clock-names:    Should contain "pclk" for the peripheral clock and "qspick"
+                  for the system clock when available.
 - #address-cells: Should be <1>.
 - #size-cells:    Should be <0>.
 
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
