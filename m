Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2F5C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:11:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96388207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K5+J0O1W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R1jlLVcm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="KoE9sjjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96388207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N0/bWErbrjyxwryZNAU6hHTrhA6WpB90yxW6vRy5/hI=; b=K5+J0O1WrR3LKN
	QbqBFzWxQbRN7xGchYw1R0JceJzbUh89rCAwQmKRtHT116oe2utbiCAuyeKw8BjYSc11pH5NkLMai
	PlOQrdTKwsHoky8g5j4ItYQSHE1RFBblnhBMcO3NQ19hVJvVaHTQY/0uLyrMxrcrngiPGIwZVu7PF
	lRGBvnI4WcfGERCzDY8X5JzF6YBtmb289itAB+5D2HIAh2PwlqqIpUXVbaCwmLaecN5yRtpl1ZonC
	t61Uzh7vAXPZ+krUcgMwB/7Mu5E6jAXGpOF8IDov953jh7dYIgY4ih9+qrUQubAoePuGfhg5doDKu
	yQ9Ojw+GHDBlyou7vwPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqcAK-0003G9-3v; Mon, 04 Feb 2019 11:11:52 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqc9D-0001nl-1I; Mon, 04 Feb 2019 11:10:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Hi1vNDMrxr0a1GeY9ud/j7RRugFDkPqeT8Wp8GY6C3A=; b=R1jlLVcmhv5i1HaToYVhTJ6TuW
 47kiH2NYjlSGGsphpYPKDhh8L6doOtGqEQoUUr0ZMioJmOugfhKtIh8l6v/hBXZ4rilMXJbgxYsfI
 kHEBqU/kjlUBVlvZBDRILzqfXFiLwsTxt1KLQEi1AhIAuWtil9+Q4TPx5iERTafIqeV1TdN5ATd5O
 HTpFntJ219dL9Yz3hzXJ5uCy66PllWqHhc7BTmj9U5KTmj0fa+DedeaP0luDAdHVw4vHyb4yk7O0b
 pU9jSFfEP7Ym5MgK6k0Y/EZaAHJ01f9gkUjXdxMKYDNMUGwJoYO2hzY+waRzmlJpRAumaiGwySu8O
 A3XYSh7Q==;
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqbCW-00084m-9r; Mon, 04 Feb 2019 10:10:05 +0000
X-IronPort-AV: E=Sophos;i="5.56,559,1539673200"; d="scan'208";a="23387582"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 04 Feb 2019 03:10:03 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Mon, 4 Feb 2019 03:10:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hi1vNDMrxr0a1GeY9ud/j7RRugFDkPqeT8Wp8GY6C3A=;
 b=KoE9sjjnOWDm5gra/59xE8HwX2XfmDLfiPxEw/FmmRGJ+O9qeu7uoCRkeIthcr6thAQ8DgdbaCQwnfETaCgzda5AVfaCBAg4PWIlD4E0cB6Ih1V0LOFIjA4sCZyHaa24g9opoEa7lX6idvEs/HSGZzLYfYfGnEGTSyfaZttaLxo=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1508.namprd11.prod.outlook.com (10.172.21.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 10:10:01 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 10:10:01 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Subject: [PATCH v4 10/13] dt-bindings: spi: atmel-quadspi: make "pclk"
 mandatory
Thread-Topic: [PATCH v4 10/13] dt-bindings: spi: atmel-quadspi: make "pclk"
 mandatory
Thread-Index: AQHUvHHKNN0AaU4kNUq82/lZ0qLedQ==
Date: Mon, 4 Feb 2019 10:10:01 +0000
Message-ID: <20190204100910.26701-11-tudor.ambarus@microchip.com>
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
 6:CGRyQDY9D9mUpou7mwzrd1JqKfEtzMU3BUVIVg8WiVMIulv4d9pZrKIUF1LHNuvIQebqz+oxc5qvpgjv6PF+pl+5sx57EmA9eB3XEfQ7yQQBQFx2QvAsri9m3NlY29nP3AluCgHszi1/R3aWc8ia4OoZKfy+i7Z8x60PfHXiJqSJlU8yKBelVpyv8brZYm/1aGcdEq3+wYG3Imi+/PfSBA0vsrRj/wBSlj4w/aRM8DPgE8YJSN44FFBiVrIf5sS3uifHut2L2YkrmhZ6TVBFf4rdhJM7RrtW9wuo+YJC4NtdbOKghGFT6jiK1uVeYlFjQwWh1RdJCC22Zm4/MDoyudNRCP29iONgyuIRCijFadIR82oRBRhcox2BRzR+9DOn/yeTJdgah9lUIUZznDarAGhcxIKGA0xuS4qGxfVNbuZoV4XkqY6D9CxEolkzZVl6uEfPrma3+pl5DmCJVAuLtg==;
 5:DvEPMp4SPKg1hj3Ls5nlxT8rK+LI4AgK+mLTgtV7S/G6nKU92fvUBfh9jccmY8oKtt4S/ylH3Qny2HszFWXBjuWrA1Z2PbspUCI+ZnYz5+9PMoUSZ8m68dMYYSGkrAZXAl5Q/wudPuGIZKzOF0PEyTJ118hDXBrWDHkOm/acdqBALYbc2+dcLytWxnjPZkxY63FIW2+04iv12iWcm48EMw==;
 7:C1of3+oieED+bF7ElCGCIFP/TeIRhJfs6RepS9Kkr4Qdi0QpnKF5ej74feVTMkuKOWOqZyPAqo7pyEoiT9UDUSeN8S175WK9sC2Gan+ZksJv1VP3xdS12NgsVOU1YP7IgDhw8afc94tTIJAW0VRCHw==
x-ms-office365-filtering-correlation-id: a4d3f372-ab71-4121-4337-08d68a88ec97
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1508; 
x-ms-traffictypediagnostic: BN6PR11MB1508:
x-microsoft-antispam-prvs: <BN6PR11MB150819F64806A71BCCDF3E03F06D0@BN6PR11MB1508.namprd11.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(6486002)(11346002)(446003)(2616005)(486006)(106356001)(99286004)(6436002)(4326008)(105586002)(478600001)(476003)(76176011)(186003)(53936002)(305945005)(3846002)(6116002)(7736002)(81156014)(102836004)(26005)(81166006)(6512007)(107886003)(8676002)(25786009)(68736007)(39060400002)(52116002)(50226002)(110136005)(8936002)(2906002)(386003)(54906003)(6506007)(86362001)(1076003)(36756003)(71190400001)(71200400001)(316002)(97736004)(7416002)(14454004)(256004)(2501003)(72206003)(66066001)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1508;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wmkBAQR5BHEdrJkOSKA5F9gucnqqgKV7QVp2TAdwHdctRal5uexQfFjvyAa5uL+6SBzjyBKGfGSiyCh7aS69u1EkMwfd5dV96/GF/kBA/qpmCK5caH3NP1jw88XZwXp32rOn8E6IYCi7S7BZ+afne/1fVFy5x8ZgtNPoxYOQTiGBlTS3y7W5uVOZnKXI/WLfaUzd+mCgvz1KjwN37fPhoSFmiAPxG9cQeMh+Qwq52cojfN86aSwjjN5hfJk5AatKvv8tlhuTB1r5XIz7l7KWDhhL5N0FZ75kVwDh0kw3CSjLC8CY2+8FGOTPiEyw2YeTV4AKiRozvELXwEGkrMdNLy0UjNjsT5YprRjGt+1MAkytrr3meXoJGeacJmN9jHS7NOb0F/j2KBCLJPmpHRfBEZ4Jo0nIpMr2TUk920ecuWI=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d3f372-ab71-4121-4337-08d68a88ec97
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 10:09:57.5187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1508
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_051004_505302_FE6D6BD4 
X-CRM114-Status: UNSURE (   7.73  )
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

Naming clocks is a good practice. Make "pclk" madatory even if
we support unnamed clock in the driver, to be backward compatible
with old DTs.

Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v4: add missing semicolon, collect R-b
v3: new patch

 Documentation/devicetree/bindings/spi/atmel-quadspi.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
index e9dae6264d89..50bd257e6826 100644
--- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
+++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
@@ -9,6 +9,7 @@ Required properties:
                   - qspi_mmap: memory mapped address space
 - interrupts:     Should contain the interrupt for the device.
 - clocks:         The phandle of the clock needed by the QSPI controller.
+- clock-names:    Should contain "pclk" for the peripheral clock.
 - #address-cells: Should be <1>.
 - #size-cells:    Should be <0>.
 
@@ -20,6 +21,7 @@ spi@f0020000 {
 	reg-names = "qspi_base", "qspi_mmap";
 	interrupts = <52 IRQ_TYPE_LEVEL_HIGH 7>;
 	clocks = <&pmc PMC_TYPE_PERIPHERAL 52>;
+	clock-names = "pclk";
 	#address-cells = <1>;
 	#size-cells = <0>;
 	pinctrl-names = "default";
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
