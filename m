Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E64C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:51:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54BF920657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B8Osqz72";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MtyO7YuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54BF920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8nZDWSlnSSflr9HRgFTGgyBIDQo/7HeWamIdKN57+48=; b=B8Osqz72yvUB1F
	yZer8Ieq0J7ulHeOzBa3FRDYYWbEIvCHQItWciZFjUBoPjFkhdTmppTu8G7Hd5+D2sO3OepR4nTVQ
	EZsbZpYNBb9pyDjpI275We376zB50/ZrqLdmsXF8461DeGxa+EOIczfcLnPnru93vLKyijMvYl4V6
	DwTG9zcJuYykJFbjRt03pV0DRR9qPi1GI260Bc0EjUhiDhu471X3G85a4xlfTCfLCmbhq4+vsehB9
	sosMyBy272qn4oMsfryZ/kt18a3a46GZ2te0fo/dAL1gx126kCZl9zmGZfiOrB/DABSB6p2/0OYuH
	dSbWh7r0ihj0p4f2rjjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjLNM-0005jJ-S2; Tue, 15 Jan 2019 09:51:16 +0000
Received: from mail-eopbgr150059.outbound.protection.outlook.com
 ([40.107.15.59] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjLMl-00053D-MV; Tue, 15 Jan 2019 09:50:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bA4y1Ir6rYl3LbKfNhCiaBdNtImU5JocvqlT3bDDifI=;
 b=MtyO7YuOG/Go0fSJHdwIio+Wo0yWrcZa8wse6ZuaDbRVUXuNpy5aICcL8CRp8ehnYw57I9BiXNqIvZt7CenmwYrmgU4inJEvb7PhHjSYVEyLrI94pZEQnMHG737E8mMaVB9cqkFcr6Z5C+U+mOWTkFOVWjmnzVSrYj3rgZ2ge4c=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5086.eurprd04.prod.outlook.com (20.177.50.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Tue, 15 Jan 2019 09:50:35 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 09:50:35 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: [PATCH v7 2/5] dt-bindings: spi: add binding file for NXP FlexSPI
 controller
Thread-Topic: [PATCH v7 2/5] dt-bindings: spi: add binding file for NXP
 FlexSPI controller
Thread-Index: AQHUrLfCF980LyW4rk217qdQa1lQBg==
Date: Tue, 15 Jan 2019 09:50:33 +0000
Message-ID: <1547545697-4042-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1547545697-4042-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547545697-4042-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:3:2::25) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5086;
 6:gHeMaS5ooCO3e+EQHeXPdWX/R0z5z6L7eO4CdQ1xVUpEox2JnVbTXi1TGUftPqoMuC76+PsOs2fT2h4jVVh94/krVUtyeHuDQaIbXHIWpKQ6TtV/k3YXj4uv2PMvaLwRapqNqABNtQjlbRmZLQYDAO5gExF27D+NSXmokHmbcFI4SU7n/r3OhyPUv1q7DMewPIhdX8NvYmF1Wip8UlT6W/C/EUWUs9it5daZGORPGFJ+u68EFYHGzZiwdRovtV/38yKZIpps8sUqQtUxcLg9et8LwNs7TJ21wdgV+7tmxaOQIijpXA91SNRUrR+QFOqPiGHo1ayK2i0dSJhAXSRzRZn9RfPckRkVeQVKNVZba4MV/1E963cePgAaN/OIQB2J4H5UBxZRZvDrdcYG5JEuFlf7LKk99kCkn79lwC/VCRK4kYmOxSs5eZppUPtAAdP0nl8jyvRF9jtCwIIx4ik7KQ==;
 5:oc6UOCjxKXi+hUSk+Wzau2tubHcuJsUXaGZIKeqHRctCu1OtKRi2djB73kupC2eT/MgUmsXd71uMo/qd98cbsDgcwNhZffstz2IqBEtf0eV+ClOvvUTD3lFeed/BFCMPcK4Em7Ev81MltJIJIN1d+f5b18woZqPNikigU2HSdxvQc2SKNHLvA0B2eBdIRsTGuMm1wdl82XDUMrYoi3SNQg==;
 7:/cQeZjgBqQnVjNkLFZbnX4Wn9ok4d5ohn8CPm/AwkBjWHNisNEYuhxWffbGi24J5yFQq3Ls7jKQ+crF6DG/xifMtKiAnRNSswmyf0wmNHC4Z5pXWZ5bm++TzrcBf5mC4/df7ImfMM5FHH5bIsTaKqQ==
x-ms-office365-filtering-correlation-id: b4c123a4-dd92-44d7-bbfb-08d67acee44f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5086; 
x-ms-traffictypediagnostic: VI1PR04MB5086:
x-microsoft-antispam-prvs: <VI1PR04MB5086A59DE36ECF828F3E600C99810@VI1PR04MB5086.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(189003)(199004)(39060400002)(7736002)(305945005)(2501003)(110136005)(99286004)(66066001)(36756003)(50226002)(8936002)(25786009)(2906002)(486006)(4326008)(498600001)(256004)(54906003)(86362001)(186003)(97736004)(2201001)(55236004)(102836004)(14454004)(26005)(3846002)(7416002)(6116002)(6506007)(386003)(52116002)(106356001)(76176011)(5660300001)(71200400001)(2616005)(78486014)(105586002)(71190400001)(68736007)(11346002)(446003)(6436002)(6486002)(81166006)(53936002)(6512007)(81156014)(8676002)(476003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5086;
 H:VI1PR04MB5726.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 88hShAKVMRgyVA7IOWpez7LbxN4M+mzE0dY/TOYM3duVZQCbBHzzOkzeDzCFQA3y3vrkGX4IzftaHoCow1MdKlgetPw8LkkqQUGxAKJ9mq1lKZ5kSR/7c5RkyJ/JN0e0UmRCU0HrEdBrkCwBkofu3Q2h4tS38T1oXYc3ujBAebNZYcjgQZPGTlf9f1ugTPItGgKEZuN3jbDP4bG+Y0yb9anmXKDW3ydZSR+j8H3WN/WcV/MSWZktTZ0ch2fjXbOk9XNiPZzi8uZPHXFEOhsMx0x0jc1QJQ8oyWZYtXjclvK1SxxTiM1bzTgPrYkXMcP6lZVZIXvNeGHrnwjursItWrvbN2Jq8fa6Y6OkPGM7PuZsw9csSNIIxUeUQyMqtxZIP/mWANbM16TCpfJXWv/L/MgDtJZWPt/e4Edwa58QfCs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c123a4-dd92-44d7-bbfb-08d67acee44f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 09:50:27.3659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5086
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_015040_180877_00AF3C1A 
X-CRM114-Status: GOOD (  14.80  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "robh@kernel.org" <robh@kernel.org>,
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add binding file for NXP FlexSPI controller

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v7:
- None
Changes for v6:
- None
Changes for v5:
- None
Changes for v4:
- Incorporated Rob review comments.
Changes for v3:
- Removed node property 'big-endian'.
Changes for v2:
- Incorporated Rob review comments.

 .../devicetree/bindings/spi/spi-nxp-fspi.txt  | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
new file mode 100644
index 000000000000..2cd67eb727d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
@@ -0,0 +1,39 @@
+* NXP Flex Serial Peripheral Interface (FSPI)
+
+Required properties:
+  - compatible : Should be "nxp,lx2160a-fspi"
+  - reg :        First contains the register location and length,
+                 Second contains the memory mapping address and length
+  - reg-names :  Should contain the resource reg names:
+	         - fspi_base: configuration register address space
+                 - fspi_mmap: memory mapped address space
+  - interrupts : Should contain the interrupt for the device
+
+Required SPI slave node properties:
+  - reg :        There are two buses (A and B) with two chip selects each.
+                 This encodes to which bus and CS the flash is connected:
+                 - <0>: Bus A, CS 0
+                 - <1>: Bus A, CS 1
+                 - <2>: Bus B, CS 0
+                 - <3>: Bus B, CS 1
+
+Example showing the usage of two SPI NOR slave devices on bus A:
+
+fspi0: spi@20c0000 {
+	compatible = "nxp,lx2160a-fspi";
+	reg = <0x0 0x20c0000 0x0 0x10000>, <0x0 0x20000000 0x0 0x10000000>;
+	reg-names = "fspi_base", "fspi_mmap";
+	interrupts = <0 25 0x4>; /* Level high type */
+	clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+	clock-names = "fspi_en", "fspi";
+
+	mt35xu512aba0: flash@0 {
+		reg = <0>;
+		....
+	};
+
+	mt35xu512aba1: flash@1 {
+		reg = <1>;
+		....
+	};
+};
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
