Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD75FC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:11:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6840F20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZEmuBePV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="nr9iMbiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6840F20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6g+eF9DguXy++sZLnZaw4m9zDZCPK6Q1N594UXHwmL0=; b=ZEmuBePVphzuBr
	/pAuqH4D8y1wghEwvDuemXmm/dErkLIeUOFLCpnpRls5WqcoZgK6tHRhZxD/ZQWWH/RDnb+6s1obC
	txH/DdkxEsWbvTwVZ3K37hzdfQNsNfcRKaN2RZNTyPzVARDuG3wtaPq4eDVEBDBYxiiBv5kEG565N
	l8dCtkVoLEc9/hFhVd+c7ubwxdHvVcBDI8sNO+F1plx2jpuM6UJ9ugMeAz7brqmFM0I8GmsDefKGa
	6KbbiSoUPamE2VVLrWT/zIGMEuvX2VwquEFU/TuTi6A6hVy0/V5VVmuhSSLHVc64pO9P20x8VPQ/B
	EST281oPVL3LncHCtWPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gorWj-0002Er-Vf; Wed, 30 Jan 2019 15:11:46 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gorTt-0006ob-CY; Wed, 30 Jan 2019 15:09:01 +0000
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; d="scan'208";a="23208575"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 30 Jan 2019 08:08:46 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 30 Jan 2019 08:08:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsJ+rz6/ZiQXa6gww3fp2N07xekBu4FSEPPXkpJSc0E=;
 b=nr9iMbiA6MyhTJz1hkgcKMvbZXwIA/fmk34WSZ8fTWZrfMxYgjALfGSAR+X8PJ4gLhEJam+E3kG0ipgoFrkL813PLUu5wxGwhIb0W+W/Yw5GkKwykREEYXZHTrvsJbx8goJDC0NpOX1J8nIoGaqjKmEj7j5WKxJJrP0EVtsLB3Y=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1428.namprd11.prod.outlook.com (10.172.21.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Wed, 30 Jan 2019 15:08:43 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 15:08:43 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: [PATCH 7/9] dt-bindings: spi: atmel-quadspi: update example to new
 clock binding
Thread-Topic: [PATCH 7/9] dt-bindings: spi: atmel-quadspi: update example to
 new clock binding
Thread-Index: AQHUuK2wJYG8B+2MyEqKItkUoaw7pA==
Date: Wed, 30 Jan 2019 15:08:43 +0000
Message-ID: <20190130150818.24902-8-tudor.ambarus@microchip.com>
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
 6:0vQS+F3EQv76rKUg8wYx3UL7u6gEUM6NmXXNGtLjOqbm/NM+9B5vCKrWBOjhUY4iPs7PRMAIxjnV8gUIM9obO3SkLiOKHfnpEwTtNEzlE6FRVsVFPRxsUHCRAIIap02AkgtEvs+qTWxJygkaoeLEDpNlsWElIwBNQKORZRpONCdS4sQrXL3P+mERBxBaww6I+vLI6kxTsO31deabjgDuIEfhCwm/t6SDsXadmeVvIgj/tzc9yGGZB0b4pJOwot08LtSirVud9BqByTCu+v4XRfxm4fEOpyc0aDB2Le4RyNzXmKrnp3uxJWc8osuLpH2IIMm69EulUc2fcaDdRn/mNzRNrmyZyxXwGfP1cNA95p1dpfiZMbUxa+00G69Xc577dsjl212TVDgW/GfI421sEeAnuGEMqHnovMywXtWhSwAYevGi6mDRiOQXnirGcFSYZCEMKBhzMjkx29Un1MgkqQ==;
 5:t6Y1FonrbUP5dWNM5Ipy9abbV0cf4xMjM1y420IAkNn1PjIKi+0q81BGXPJXSWpshGI1/FFAaNrehNqPsOEPeKxPd4AOv2Pd1p5kk1Ka352xCdF6lzhExEqwruluX9EymAj4JoBvRAlgq5GovS+JXeHDz7FBi0UCujafq6EPCM8rrnkWvhlo0ikQ7wpA06R2ClAQdk4t/Tx89sWoYOp1NQ==;
 7:fXjyC2iXejPIf20olKCJe2snuuM24iaEXiRJHRNbgCCtoXdlypJJut/C7drv0iaiMKQyY4jJwWzv3FS0Dzy2VCQMQbXnfFn5QHueQTOQbv0aCjd06OBjQwbWEKflHshsCTG44YC5eCMRufMVXQnWlA==
x-ms-office365-filtering-correlation-id: dc5dcd13-fde0-4ca5-384b-08d686c4d2d7
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1428; 
x-ms-traffictypediagnostic: BN6PR11MB1428:
x-microsoft-antispam-prvs: <BN6PR11MB142837263DF0421921A7DA90F0900@BN6PR11MB1428.namprd11.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(376002)(39860400002)(366004)(346002)(189003)(199004)(6436002)(68736007)(97736004)(6636002)(52116002)(6116002)(186003)(8936002)(50226002)(2501003)(66066001)(26005)(486006)(107886003)(3846002)(53936002)(4326008)(110136005)(86362001)(6486002)(71200400001)(81166006)(316002)(6506007)(102836004)(2616005)(11346002)(25786009)(476003)(71190400001)(54906003)(446003)(386003)(105586002)(8676002)(1076003)(305945005)(106356001)(2906002)(81156014)(478600001)(72206003)(7736002)(4744005)(99286004)(76176011)(6512007)(256004)(14454004)(14444005)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1428;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I++BtMuD7TfYlm/GVPtiU8rtRVDJNhQY0733mO9Tf2/O/gA4DoBZ6c/Y1PrBlcH8oD3s/4vWlbAaV0+Qv9EcReRjgwTGXKQMc9Ob302S4/zTHTNg3izN2l2vwYSNGecaaF1HDyRpBboxLKIQyUv24FkeZCTPWTzmWdWzUpaVnL3lvUW9nOidtgD2vpa5KIqN7/a3gBycbSfdqPpTFYmSEH60EPkSx8yHFJthPuWe9XBVEShVN9tlQ88XqLtq9YId1rnudVWEqh4cK8RcVIjaQ/DaZGRYzlcRsMzGctGKXgTpTfgyRKC8DQ5mPKX0yEZekXG2NM4UQkehkJTSzjdzSOXIMCY79Jn/e9jKL/wR7CqwfB/xULl2uWg+HZyiUzH4pHZGXgfCQxXiuv9NAO3Ksm2C+8ETpUSvrNUlx8bH/vA=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5dcd13-fde0-4ca5-384b-08d686c4d2d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 15:08:41.3083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1428
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_070849_813270_B1659F07 
X-CRM114-Status: UNSURE (   8.75  )
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

Introduced in:
commit b60557876849 ("ARM: dts: at91: sama5d2: switch to new clock binding")

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 Documentation/devicetree/bindings/spi/atmel-quadspi.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
index b93c1e2f25dd..e9dae6264d89 100644
--- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
+++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
@@ -19,7 +19,7 @@ spi@f0020000 {
 	reg = <0xf0020000 0x100>, <0xd0000000 0x8000000>;
 	reg-names = "qspi_base", "qspi_mmap";
 	interrupts = <52 IRQ_TYPE_LEVEL_HIGH 7>;
-	clocks = <&spi0_clk>;
+	clocks = <&pmc PMC_TYPE_PERIPHERAL 52>;
 	#address-cells = <1>;
 	#size-cells = <0>;
 	pinctrl-names = "default";
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
