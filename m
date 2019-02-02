Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA2AC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:26:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE9A20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oagi/Wf8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="yq6Shrue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE9A20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P5mzteNh+mE9TYxi/cLE/TxUn/kW/bi2oL1xgBOp0Ww=; b=oagi/Wf8GaoCns
	+s2yXjdgw4kzrQwpI6uxdmfAF4civMHC7vSDBjJFcK1/g+YrcHvQfn4ZNw+rwHo+9nt5u8cgf2g4F
	i5w3cKqSIPbzNG0B4n9Hd346meHUdBKon7hMhtB77OmMIirh1t263cOCFLB9oCwuVXBHfS+ePzlsm
	/Sb1AaynZ2Im5P3w5Y+AWQNENqEUd4Gjaegp+RhvqcUynY7epXOJwhHV15ax2SlzW/WWg4S+2J5Ri
	3CdZRnPsVnTl6tdKNqC050CVMq1RoD67K1ZzkF5S2sZk4TwHWnIG0Hc/ccHVwrwQQKoQflP4WvQY9
	MHVBGduw53C/eulfZFSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpmsd-0005Kh-9o; Sat, 02 Feb 2019 04:26:11 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpmao-0000r7-OC; Sat, 02 Feb 2019 04:07:59 +0000
X-IronPort-AV: E=Sophos;i="5.56,550,1539673200"; d="scan'208";a="26062099"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 01 Feb 2019 21:07:41 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 1 Feb 2019 21:07:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8cR0aSyph+qDC0ZF+ga97oZmkbtZ/HiJNZqcC0r0/Y=;
 b=yq6ShrueHp/4OGJbQTKMpVIS+BxxM6sAQ9ao0RrDCFaDbhuXXXVwnH08Y4u7oiI1b31PocfDFLtU5Dw8s37R7zIebmQWueiF6M7Sx5bP4JyQkKNTC5Fwv4bY53lqaRxPbuImQW+EFf+B4FGH7F8/fuSc9qH+qrR25cZIIuGAGLk=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1987.namprd11.prod.outlook.com (10.173.33.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 04:07:39 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 04:07:39 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Subject: [PATCH v3 10/13] dt-bindings: spi: atmel-quadspi: make "pclk"
 mandatory
Thread-Topic: [PATCH v3 10/13] dt-bindings: spi: atmel-quadspi: make "pclk"
 mandatory
Thread-Index: AQHUuqzWMMnmbraYeUy6BKjmB0h60g==
Date: Sat, 2 Feb 2019 04:07:39 +0000
Message-ID: <20190202040653.1217-11-tudor.ambarus@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190202040653.1217-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0062.eurprd09.prod.outlook.com
 (2603:10a6:802:28::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [188.25.201.137]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1987;
 6:G7eQEyq0yF5a+47TA0yrz5srCSKMs/D/dlv3PcQM/d6zsZOPnUrt27AQJXmAo1xePs7MiKaJJzk3b+OWNzYGrwOeoKOQVdmLSEgX8WbBOjfZzVoEUZoFwP0JY4Ygne8NgRG4H5xnasuyTx3ToAhVKnP8wmzvYzsI7Z5g272rhhaHMIQwCjh6FgJaJ9MOtEJaXU4cc3OMwSITGPRpNPWKH4QyEiBWtyuyXldVI2PxVbGuvIEwQVONz3NNr27KcoQ/w1eQxwshITI4eICYwbrKiRV6Lr70kCQsFkElk0JZ/ufAdAXDPaRXgS4MTY127RiaW3428/PDSvevVXUkDUFuptuEDfxm32h2a7FuxlfI5aaI3DCGPqQUYc8QdTg+Es9L/G1W+/qjXg/w1RnSNmKQfzAcFbyD4Ck737XvqYGyRboNmkjj6oNA8jCmbOggnluGcBwKMXd8oR0VQY+Qlszraw==;
 5:Ce/WMXyW8K8dj2vJ+zJPhueGMN8ynUPsmsrjKSOAexTLHUjdXZp1x/uLG58XrbpTt/qKO68SU7TJc7cRc73wJJx695+6F/qR6fjKo9+jNguztETLnRnPv4GTqD4ZFAwHtxc4Y+e/bvovGdCURmFi4uL5m4D7rTUfOR4QRYjemUNlVHHsldMUDNosf4HrTsGGIf7O+Q3ramR7aaEL3onPvg==;
 7:Zw7PV/KUV7riCMsXpywxDc/o6iX4QGGdWOjnZitps1sMpwNEn/oo4aas7+/pd7yUPi2k9S+LOpojWZtrKr6wYf+aWMdgnpHw3V2IvPnSTAfg8X0IqLqUL4D3fCH21oD6WzxeAEMelREtkaKgJt8H6A==
x-ms-office365-filtering-correlation-id: 96793553-5f96-4e65-88d3-08d688c3f84a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1987; 
x-ms-traffictypediagnostic: BN6PR11MB1987:
x-microsoft-antispam-prvs: <BN6PR11MB19875B1B4A5582F0A50A59A8F0930@BN6PR11MB1987.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(396003)(376002)(39860400002)(136003)(199004)(189003)(97736004)(76176011)(4326008)(1076003)(106356001)(50226002)(66066001)(6506007)(386003)(53936002)(52116002)(107886003)(105586002)(2616005)(72206003)(71200400001)(39060400002)(446003)(6436002)(71190400001)(99286004)(256004)(8936002)(186003)(2906002)(25786009)(86362001)(11346002)(305945005)(14454004)(36756003)(8676002)(3846002)(6486002)(2501003)(7416002)(81166006)(478600001)(54906003)(81156014)(6116002)(486006)(476003)(110136005)(68736007)(102836004)(7736002)(26005)(316002)(6512007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1987;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Fz1KW/yFx076I+gChiSaPgEkLIJDB+Rz+ULoU7uPN0fVcPrkomIkofAJCgnZ9mrPYDDNskeHyvEKJ6b5Ijy958ETCYq5Lrqz6f4MHzlZ7QmPrpJ3m4uMuQ03XC7598bl7DPncheyHvbWy+lj+HJJzgMyeb3nlNwvmVFhy5FnK0XqSsiyNckfGA1qa0LpgptLY2p0DEU3oVC0ToMw2gpZVEX2qoV13dAqAUnCa6Y5WZkDcColmbw9R5fN0BRhtr2xuGB6zVkRJg7ADGSvlkLlcmdG3Rqa5zFkmdHkjARZfXz14ijYUHu3MZ7GDFuN6nalvcaBNkmpKVcfHLuSEKw1VNjsC8ipKf8mqXGO07VU59qzj8z2s80agp33CzUVfKjgYgQ2SshZWuAQZJDwhK33sa6A+0NHZ9E1JK+uIQNdUP8=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 96793553-5f96-4e65-88d3-08d688c3f84a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 04:07:36.4681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1987
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_200747_330490_AE230A4E 
X-CRM114-Status: UNSURE (   7.76  )
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
---
v3: new patch

 Documentation/devicetree/bindings/spi/atmel-quadspi.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
index e9dae6264d89..1de54e87f5d6 100644
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
+	clock-names = "pclk"
 	#address-cells = <1>;
 	#size-cells = <0>;
 	pinctrl-names = "default";
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
