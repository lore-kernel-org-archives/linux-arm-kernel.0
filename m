Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57CFC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:12:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A6D20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B+FtHhvG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="RxV9nspu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A6D20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uIKBRByII5pK2X2Hh0SbvW7sjIHpClXyz41kVNO2vJ0=; b=B+FtHhvGjbrDxO
	t/Z45rV+QVF2jxYaK1j03MjT3NoLVzIWIuXmgMBnhutdUYQJFaf4QPAyltfl69fEGbamLWuLPKFwf
	WgM7b36Tr7FPYYLKVq4ygPHRoU0SN5AIDvnjzklEvTqPARjsxDtnwAN9csjMHt/lWzjawub73YcX0
	5a1mIuDQT+e5cFPWle7uz3/qgD7m2LgkWVqtjSx7HL1rO+8yTVyVyEqopushaGPdvwmW7KE+Fo69N
	pwc8xvovkTl9RZ91qWvtcrtyrAjAaF4EfKoMYsdxA/61ykdonDBVq0ndVIAdbjc08ZStLGMxCi8pz
	bqfU0zoWSzhP78pXvgww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gorWz-0002Tf-DA; Wed, 30 Jan 2019 15:12:01 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gorU6-0006ob-0X; Wed, 30 Jan 2019 15:09:30 +0000
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; d="scan'208";a="23208579"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 30 Jan 2019 08:08:47 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 30 Jan 2019 08:08:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TG71vXqO0OqB+nWHjqNIPzPDwPgd30426H8GG2TERY=;
 b=RxV9nspuAxilRVYOjIeMcOThGQXSRxE0dRClL3CmOCGaCWPcrcKTEnFx2sUBDsfMQXfjYdboTFRBNE6xOxAgucctXjwjLAbKa/MUK/nHgymm+YlZ+knBpyuXbcPZpqPLpRYZ2orvI1iTQBU17EW6SD72rZd/sgoUTMqxgeZOIE8=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1428.namprd11.prod.outlook.com (10.172.21.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Wed, 30 Jan 2019 15:08:45 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 15:08:45 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: [PATCH 8/9] dt-bindings: spi: atmel-quadspi: QuadSPI driver for
 Microchip SAM9X60
Thread-Topic: [PATCH 8/9] dt-bindings: spi: atmel-quadspi: QuadSPI driver for
 Microchip SAM9X60
Thread-Index: AQHUuK2xf3u2KPfoDkGm5485KIOYJw==
Date: Wed, 30 Jan 2019 15:08:45 +0000
Message-ID: <20190130150818.24902-9-tudor.ambarus@microchip.com>
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
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1428;
 6:FYV9AvQcZlKuG/kUR+LnYnWETLChnFPKMmwTNueG7OcioIUaTfd0PoZNem5Rqup9NdM7oFH1GFV1QLSx4Q9pC4F7mVI7vjdMfaT8XDnxESWVUapzYWDQ5RXvsimthswtNbMYVpWPIkthUosGrEOxOKcyJHbnKzhRYHgC1lOnVjYjJLjHKD4jlsYT0064idSxeH0/roXKwxoYUKrwa4qhFAxjfd9ZLe8yAS0pRSuT/lsDGsEnaQVvek3vg8GVqMvmdCQ1kkTvHK3xse6Y0oKxi2inwlnMSxcN3xBAMCUlJc1qKjLVX/cX1UlJYeh/eBVE4kdJ9WQxBKaIsDMZPQ2Mo/JJBOuNN3K5wJMsGQi14WdgapGAxe2W1k0gFJ+pkpSbOXP+sSR08YrUYyvoAm7IvyPas1E2TK2JajCuWQdVL4l/nkVp0fxMdIjAGzcr5C+XuNIvw2e0nioFAd3Rw1DWXw==;
 5:9S5g6qtGYGOaqwuXsPEwh21sKa63p/6NWWTPxnr0/Fmwj+WGXIKNydBVQTUHzjxR2l+lb15PqggaxkWstSM0jZFEEf/borTUpROe7IpMKvNc0KTyt+940u6bnTkNhdumPGyfxq2A4RG06TFNwfQEmZ5OolZbtlqgfYKQjL+eJ+mSRvj2kgTUi6zOUBSR8hhRj3J/WJt+fO/Nl1DwEoRUnQ==;
 7:gCpf+6Rc6DUF4SOf1qWhTB52QxPihpz77qlE1brWjw9Hlg5MqVd9mb/2+ackwBAhbErRYZ66yuJxjq0W60wiY/PKXwHzs3hRiXhbZbMhrP4Kix+Xc46bA552cJrpr+8aDSbCTKVZh7YiyPlH7lxMDQ==
x-ms-office365-filtering-correlation-id: f062ca55-80fd-444a-226f-08d686c4d419
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1428; 
x-ms-traffictypediagnostic: BN6PR11MB1428:
x-microsoft-antispam-prvs: <BN6PR11MB142870BC1BEE6CBC9AB5E966F0900@BN6PR11MB1428.namprd11.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(376002)(39860400002)(366004)(346002)(189003)(199004)(6436002)(68736007)(97736004)(6636002)(52116002)(6116002)(186003)(8936002)(50226002)(2501003)(66066001)(26005)(486006)(107886003)(3846002)(53936002)(4326008)(110136005)(86362001)(6486002)(71200400001)(81166006)(316002)(6506007)(102836004)(2616005)(11346002)(25786009)(476003)(71190400001)(54906003)(446003)(386003)(105586002)(8676002)(1076003)(305945005)(106356001)(2906002)(81156014)(478600001)(72206003)(7736002)(99286004)(76176011)(6512007)(256004)(14454004)(14444005)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1428;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DWAma5nbTSyLJ/RSh+RUQ/9jzYXf+W8x0/Z2FmUhs7Mh61+8jQbumAljMsMI3U1M1cNC3wAqaPiZNNNXVmXN7TbdD1Yu7sFzSv62awmweu+K7VLT6E7wBkIxGqfwUypupeD/gZtqLp7kmtAL6zCbceUyKiP6yqStANc8CDTgIUNm60fUl/HwaTossSKDuYm2EpRukxCPv8rnT7Zu9i9Ax2Ud1jvh9LUP5KVSd01Rc3/fWuBYZK0ytj3YUGHGZmHc1j2t9FAy5l+JFcpGWSB7b//Rh7c9ABZKAQedGixFZg4+L6BoGX8j28vVD8hLu5cDXAQ+XQH2NbtbbzwmIrLmy1nz7nPYRjJm5QFXnI0T5mW/Ee9evTxw7cXsXFr+JIz9myXw/dupnUZ7sw0Cs4gFB9/BioPcMueK8oRxJ+XSW14=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f062ca55-80fd-444a-226f-08d686c4d419
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 15:08:43.4900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1428
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_070902_732297_6C633BD5 
X-CRM114-Status: GOOD (  10.51  )
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

The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
access, the other for the qspi core and phy. Both are mandatory.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 .../devicetree/bindings/spi/atmel-quadspi.txt      | 28 ++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
index e9dae6264d89..e7b7f297c5d7 100644
--- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
+++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
@@ -1,14 +1,22 @@
 * Atmel Quad Serial Peripheral Interface (QSPI)
 
 Required properties:
-- compatible:     Should be "atmel,sama5d2-qspi".
+- compatible:     Should be one of the following
+		  - "atmel,sama5d2-qspi"
+		  - "microchip,sam9x60-qspi"
 - reg:            Should contain the locations and lengths of the base registers
                   and the mapped memory.
 - reg-names:      Should contain the resource reg names:
                   - qspi_base: configuration register address space
                   - qspi_mmap: memory mapped address space
 - interrupts:     Should contain the interrupt for the device.
-- clocks:         The phandle of the clock needed by the QSPI controller.
+- clocks:	  - "atmel,sama5d2-qspi": the phandle of the clock needed by the
+		  QSPI controller.
+		  - "microchip,sam9x60-qspi": should reference the peripheral
+		  and system QSPI clocks.
+- clock-names:    Only for sam9x60 - should contain two strigs:
+		  - "pclk" for the peripheral clock
+		  - "qspick" for the system clock
 - #address-cells: Should be <1>.
 - #size-cells:    Should be <0>.
 
@@ -29,3 +37,19 @@ spi@f0020000 {
 		...
 	};
 };
+
+qspi@f0014000 {
+	compatible = "microchip,sam9x60-qspi";
+	reg = <0xf0014000 0x100>, <0x70000000 0x08000000>;
+	reg-names = "qspi_base", "qspi_mmap";
+	interrupts = <35 IRQ_TYPE_LEVEL_HIGH 7>;
+	clocks =  <&pmc PMC_TYPE_PERIPHERAL 35>, <&pmc PMC_TYPE_SYSTEM 19>;
+	clock-names = "pclk", "qspick";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+
+	flash@0 {
+		...
+	};
+};
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
