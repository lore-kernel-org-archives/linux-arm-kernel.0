Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F5BC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:02:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABDFB222BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LsJr5h62";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Hqm4Vnn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDFB222BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vShdlH3u5t3lQv8xF1TVE8uuzV0Zo2hRccSJuZDysJ8=; b=LsJr5h62pFmj8d
	Fp0dDOlwT4oU3L1g/AhG56h0JrkDkgPna/oWgAWW0qWPuOeOTjYWUyIAImylzlM8VcCW1KS19PERe
	y9B/CdvtDQQmnyfG2t/1og9/z1X2E/f/0xZWGMHAXiqzwgDJTCAqVhVWcZe9QI9JFx+E4ZqaeA79s
	Ra4GYvV5XshmmgahTo3/3SxmlDnG5+Bf7vhly/fpt7BJt9r2UX9szbXw2/wU06opAxA9cs1zogw+Z
	EW+jbf7mr356Mn88h3XQP0nq5Gf1Z5KNT0P4dFiwLQSZJx+4BhLwizsWdONEyBabJB+PcsZGK+FzN
	m4xbn9sx4uW9AqFvItaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtqQU-0000td-Nw; Wed, 13 Feb 2019 09:01:54 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtqOk-0005mk-3Y; Wed, 13 Feb 2019 09:00:16 +0000
X-IronPort-AV: E=Sophos;i="5.58,365,1544511600"; d="scan'208";a="26473939"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 13 Feb 2019 02:00:05 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Wed, 13 Feb 2019 02:00:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nLDWVH0PRm4yE5un4BnzvmNxpigSmhZbFcJtWZN0iQ=;
 b=Hqm4Vnn8W+gv/B75IY6QS04qFIfM0L2//olqSj3DRepTNE0JCtcdsquRctcrmT9UoZ+sa2tdglIwbE+1bGkr7pvTRrSwLJ6NPLk/O8WkxIV5DSvAhkEa5HTYbIdvR1r6KvBepn7DHSe40EjXBQwALGD172eQl3Wq/N/RyYD5k9Y=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB0019.namprd11.prod.outlook.com (10.161.155.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 09:00:02 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 09:00:02 +0000
From: <Tudor.Ambarus@microchip.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <dwmw2@infradead.org>,
 <computersforpeace@gmail.com>, <bbrezillon@kernel.org>,
 <marek.vasut@gmail.com>, <richard@nod.at>, <miquel.raynal@bootlin.com>,
 <lee.jones@linaro.org>
Subject: [PATCH 06/11] dt-bindings: mtd: atmel-nand: add sam9x60 compatible
Thread-Topic: [PATCH 06/11] dt-bindings: mtd: atmel-nand: add sam9x60
 compatible
Thread-Index: AQHUw3qBqCK41h0EJEubWSs6IunO0Q==
Date: Wed, 13 Feb 2019 09:00:01 +0000
Message-ID: <20190213085930.31578-7-tudor.ambarus@microchip.com>
References: <20190213085930.31578-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190213085930.31578-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0085.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::11) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7db4d0a-7656-45ea-9028-08d69191a34b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB0019; 
x-ms-traffictypediagnostic: BN6PR11MB0019:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; BN6PR11MB0019;
 23:RrDlbFPXi9ekdOyLUmDRfJmDkuYHNJOtIaF8Kec?=
 =?iso-8859-1?Q?PJ8y27zgJwuxke+C91YXcwimILPTiQGl6JJMSsdXFNmCpACbBYhG1TPLCB?=
 =?iso-8859-1?Q?dzxsh9g6XKBef8+Dkb3TsvecVLALszEyEKMRylWaFmY2pBupzCkCuoyk+a?=
 =?iso-8859-1?Q?H5D9fFjWOkx+iEuq4WDZRdufpL4tbu6ztilpuB8ai1qBRLSPhkHFRZv0g+?=
 =?iso-8859-1?Q?GxFWFkZ5vvVCITMsVpuBAYKn2oPf3hx25TExMMLg3NgMADdGjeSMYEhljB?=
 =?iso-8859-1?Q?z2HYF0jo9iDllxFdgiVpUovjEDpY+4Z11EZcKNJkhuQSao7cqBzpLCLQmL?=
 =?iso-8859-1?Q?HdtPXVSaMHV8cL8NnVuQsXxsBk7Y51+nOhhjY/fBuByXueyLllTr/9hd7Q?=
 =?iso-8859-1?Q?TFM+eiPGt0mnb2GPoLUvc+SfGJmH5WKJL+xHmv4q+G00W3icHA2fhdioiH?=
 =?iso-8859-1?Q?xK2fOt8u2ZLgtK/SP6rY9GbncLtit5CKm+ugB+dLmA69P4rz8HTtExcO9v?=
 =?iso-8859-1?Q?neJOcoh6yOghTSKwER4CAEme5TTfLtxxVWVKrfjb5Ni0m9eZEmP5U1axor?=
 =?iso-8859-1?Q?VG+ZYq8dPiND9hPP7fx6NZ7mqv1RXKJFeDSTNxJqtlaaaKNeh+ShLnWH7T?=
 =?iso-8859-1?Q?eBb58w84/eB6xERbDN37gWBrobe+U9Fk4J9c0w1GvSWvaD7/c8iV+3c+qR?=
 =?iso-8859-1?Q?GeDRmpROuVJ8O2dGGvZnwB2g5/BtHqvhs8g3lmdCih4wusks7PEfISemks?=
 =?iso-8859-1?Q?IbfKyGdOIQNElqrJpMNACq1WKHjQsrVyrK8wEEjvJWl374U9GreGYYpPsB?=
 =?iso-8859-1?Q?iS/tG1m1VNIaeLyKWAgoPazioDnc3L1LCaO5RKTB3yR5hwtXdGPKI40QQm?=
 =?iso-8859-1?Q?rHUoQxbJ2b6q2ZYz2UlMIkZlE78ybvVVPJs9wnKXl+AR6Yg1QLJGY0diqP?=
 =?iso-8859-1?Q?Qw5CN5exSxv5FL5Cwm1gLK8DySXjpncUqoRW+6ftdlJ3sFD9T/PnSoRG1n?=
 =?iso-8859-1?Q?5FE71UGswLW46TPfEu4hb21AwWtYLfPPBm8v/rrBgHbkhhXUlbukM9YvYd?=
 =?iso-8859-1?Q?UgOx+Y4RE3XD/vFtp9vtdEFvnqYpdoo+d9AVdxPyWL/taYBpCfOrAOuKit?=
 =?iso-8859-1?Q?+LMp6KPQyu3+cJh76Bxy6la9UxzrEJLEAlNe61XXhdkyrfoOtQWJKspHQJ?=
 =?iso-8859-1?Q?QrPw43jkfrLm9yTIcII+tcDioh5ElrRGaU3JgxqduHnm/N1PQh3VUDfjJd?=
 =?iso-8859-1?Q?01HyH4hGw22KGiO7bPkbe4VBM0p6NpR3cBUHAHvq0OIRfadTYwi0N5zsgH?=
 =?iso-8859-1?Q?U/KyoaSZHg2VSFuzKKQEOgmkUzGDKYpa3VapzOedALsQdBVrAYK8Uxavd1?=
 =?iso-8859-1?Q?WHwtgThqqcKvd5Aui3DXRUR0qboEzk5Oocp2NKhymz/4OlYajbVu/nNkFT?=
 =?iso-8859-1?Q?DqVChParcFSphaEeNN6tLyi/kds3AlGLjJxSHHwl0VjGBSxu10oYbHj6g?=
 =?iso-8859-1?Q?=3D=3D?=
x-microsoft-antispam-prvs: <BN6PR11MB0019AEF40D3E39F1A453FFBDF0660@BN6PR11MB0019.namprd11.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(81166006)(50226002)(106356001)(7416002)(6436002)(54906003)(2201001)(1076003)(81156014)(26005)(110136005)(476003)(102836004)(107886003)(8936002)(6512007)(6486002)(4326008)(446003)(2616005)(316002)(8676002)(4744005)(105586002)(99286004)(66066001)(486006)(6116002)(3846002)(186003)(11346002)(86362001)(2906002)(72206003)(71190400001)(14454004)(76176011)(53936002)(71200400001)(478600001)(68736007)(6506007)(386003)(2501003)(52116002)(97736004)(7736002)(305945005)(256004)(25786009)(36756003)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB0019;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hE/McD67WGhzugLD0ZucRiG10fMxvvvbIkn6ciKv0wonqgwHzsi/Pb+VdehvoFQoChFwQfx++XjWHJo+7xXw5S+8bHb0+vjtpCaDLMeQMHncIAwvF7OxcdLXC1ObOerkjOnHddoTf0Kjc5kljujOHpDH927TtBGN+HZbJpgiQoRq9+H95ZDrGw7OKf8S5B3+I/XsuHBlC7xikvMzuMs7AnwqLBQtkaLfmnhZcXmH6H6w5NQkpvJi5Nr81xIhIXoijsVk/CK5gSfD71N2EMeVuwKbjdJsmUdrtogvfXpkkmvursGmpRWKj1tU8UHYm7TJcw9duv3Pewgtx17HZhl3LqBufXIHRvAqMWPcyulH/fYLOcQu3MUnfucLDxJSYAmmkkYHLFrlEIF92+57PYA0yjYzWNs8tiRQB26KzEHsiCk=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d7db4d0a-7656-45ea-9028-08d69191a34b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 08:59:59.0557 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0019
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_010006_838420_DB740CD3 
X-CRM114-Status: UNSURE (   8.42  )
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
Cc: devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Tudor.Ambarus@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Add compatibility string for the sam9x60 nand controller.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 Documentation/devicetree/bindings/mtd/atmel-nand.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
index 9bb66e476672..68b51dc58816 100644
--- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
@@ -14,6 +14,7 @@ Required properties:
 	"atmel,at91sam9261-nand-controller"
 	"atmel,at91sam9g45-nand-controller"
 	"atmel,sama5d3-nand-controller"
+	"microchip,sam9x60-nand-controller"
 - ranges: empty ranges property to forward EBI ranges definitions.
 - #address-cells: should be set to 2.
 - #size-cells: should be set to 1.
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
