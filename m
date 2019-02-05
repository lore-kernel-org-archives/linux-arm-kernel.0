Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22861C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:39:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA1132175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kdPkEfy6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="vyIFtj6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1132175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EUV6IIiIxm0sgzsCvclMwU8dokhADXNCyAkB4mhgEFo=; b=kdPkEfy6WV0NVU
	IQPgNqSUIXD0uE4vnp1N401t6HPVt0vlo7EGKl5N/Zt6RK1EsD5irg6zt9N1BoSE3lf8UtS3zTM5A
	hj7QdvjdBa6+7TqlDx1xU5N8lvSEun3GgpK6Ciz8RwAp+HEWfv73vAEOCdldKtOpasPJ+wYhOO6Yc
	czqQiCdrXc0EFQPC2TbeKmyA6yRdjWnyjdn1P/HI3gEqcJu3oBZjxZDwdAZike47wFO7BGe2r/Gmj
	PSAYxwdNtSNyoJ9LCCISLvp/ZJLPWruK5pdTMFn5cgqGbJfWRd/notJUMDyrcBPpyxIFlADlTCcyq
	JSCO3uCpu/1CQmdMFLZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr4gj-0001Ci-4M; Tue, 05 Feb 2019 17:39:13 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr4bM-00031h-BU; Tue, 05 Feb 2019 17:34:29 +0000
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; d="scan'208";a="25881425"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 05 Feb 2019 10:33:39 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Feb 2019 10:33:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnPNLz7Zj0WP8PCqpyRMz1iMXvA+YRwBN4HSmUM0tW4=;
 b=vyIFtj6MmRr7Yz4y9cpbCH7mfbN8V3aNly9PAxfsPibLfjAIjRyaipYFcXdKZGHsHySps3coaYoBiE/iKmBICcUtL2N+UjlikbQw19H7DPyXt0gQbR2rA3WSPpaDjHnfFdoMUNC+LnKp+FwF8l/MAfmPZtdJa2ZnC9QbCW40Mp0=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1539.namprd11.prod.outlook.com (10.172.23.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Tue, 5 Feb 2019 17:33:36 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 17:33:36 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Subject: [PATCH v6 12/13] dt-bindings: spi: atmel-quadspi: QuadSPI driver for
 Microchip SAM9X60
Thread-Topic: [PATCH v6 12/13] dt-bindings: spi: atmel-quadspi: QuadSPI driver
 for Microchip SAM9X60
Thread-Index: AQHUvXjsZikC9xtTx0aofZ0egHbBrg==
Date: Tue, 5 Feb 2019 17:33:35 +0000
Message-ID: <20190205173254.16388-13-tudor.ambarus@microchip.com>
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
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1539;
 6:WpAvIBd0MKD7d7dou3qWkXJOy/WegL6aKe4CTVz03WO4vMtVbFMnmaKlyhpZtCq6i4kPZ5DD30vT2ZTd6PLkgVIzL6qcvrRr3VMXD1dkCe+FwDpUdamohxHIxFRiTXAb9pioH6/oQKVZZprcH+QWlggmt0YYciC+YmsW6pCukS3j2TPSi3lAyZVs3t+cLHxPhwK0zNq6glefX3TGRZT4Ea/9piBBt7sLraNXkHRVAHBeNmApwsoBVXgPfU78IGZH9kXMXTw9oZYypcMn9kmV5yeXcCaigrhs9/+qUGSRmjAJtjCY7/JPbLKwKjdReSoDbSTz/RwanHcNyCBws2g0mB/9dGYmXajBNp/JXzrZhaz/6pzsATwAxkdpX18BbRmcx2/mt6+3ZJ81Tg7Zn0CG5wbRl7alBbcaYVDjtykMIbwqRTnsUp6XVd5yN7/zWt6/qMNakvAOsgIDwaph/AzXNQ==;
 5:5DXuHUPyAV7yXLddBmJH/UYOIJ0mr2sTCOJCGRAX8bw0nBeD7CWXTf1gnVxp+Yf1V/ZJA3Hm6VROZgUv32jwmPjYjkBlt6253bgEOLxvRYoXvxn+OKqS149FYHWlz+WOt2ekdtznBJViYSh0hwOgr924Ugcm3rRu7p2hb2emkMnHfuegMAdz4pIYt/TtDEIu/3ZpPNjoi9/Ck7TaLP1UmQ==;
 7:qIK0hx6XCBSUuzVl1e9bFnUJ4nZEnaIYn6ZW6M5SY9CiKDC/32+FIengtmDhmJyliFnnBVbXRXZnAGlJwrDaqE339ChV7zkYES1eG3jJ2iZz873l8E9IIVbJBVrxg7zbjX7+HApFtZ8eRUUzqd3HYQ==
x-ms-office365-filtering-correlation-id: d7727321-5c3c-4c45-6b34-08d68b900eb0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1539; 
x-ms-traffictypediagnostic: BN6PR11MB1539:
x-microsoft-antispam-prvs: <BN6PR11MB15393F9D31DF97EF6DAF2B37F06E0@BN6PR11MB1539.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(386003)(6506007)(7736002)(4326008)(71200400001)(71190400001)(99286004)(72206003)(2906002)(110136005)(14454004)(316002)(305945005)(76176011)(8936002)(8676002)(52116002)(7416002)(3846002)(478600001)(6116002)(54906003)(2501003)(50226002)(1076003)(36756003)(106356001)(53936002)(105586002)(25786009)(81156014)(6486002)(68736007)(81166006)(256004)(86362001)(102836004)(26005)(486006)(6512007)(11346002)(14444005)(66066001)(476003)(97736004)(107886003)(6436002)(186003)(2616005)(446003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1539;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4i68Hvldjv3iyIS8u6uEcZIFgMaw4S9PRuickltIsFQqooc0Cwixr3erW3sF5NtZwBpcKqc7XD2TJXkIripoaEX2ZJIY34weYGZAPKw+TgcdNRIZOLwEa1KJ29GkQkmref9D6ZVC7HDbWX4Y6o3mIo9eSgzRRSmB9iYkkuHL7bzN1gko0c6DE46CQGlBSXwoNIKR9NxTZGmPe/8TiIv4jnkTdiwuPI1Imq5m+vuIA79aQjCLNVpDEOlfJpnNpfFwFBJIoeeZTsrZ6/GEf+r8M6L0CPZgkfF5NTqbMugXnv7wnnGSnA+5qCOvtMPZLI++1bIh7PhMPZAmaCsJIR6IWZgoUmBjNF6If7H1IF9j9HKCaEtGF0iwqaHgr958BA3yFrMLtyKG/qromCct6+mXDEfH9hRPxt6BKdhvSrL04Xk=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d7727321-5c3c-4c45-6b34-08d68b900eb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 17:33:33.5869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1539
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_093341_226145_DA898D50 
X-CRM114-Status: UNSURE (   8.41  )
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

The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
access, the other for the qspi core and phy. Both are mandatory.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v6: no change
v5: no change
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
