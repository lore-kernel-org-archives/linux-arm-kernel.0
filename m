Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F50C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:09:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D88E121479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xafb9iQ1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Bss3x2yl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88E121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GQ0ISlaqbIxVo7aOp1oqNl7ZdJXUQmC+zg9x4LZUmBM=; b=Xafb9iQ12pK7q4
	L3dgcuJHDx5kEspynM8WCpc/Slomr8zrPp3JhLsRij8GjVARzpEQyn2B3WdOKSmXh9Oj+KoWIpx1s
	IQeMcWD7HOovT7Fy5Rumfx+rVGjORYPAoqea4+mBRQA2mVaVv4M6E/OyXGW+0TeSLPjdiUjILdwmV
	XRu7rYUCKVKjKGi/LEqlfHz4WhHVGJNUV9XwkFw7s38t5zuJrd+0WmBxkyuBNIPd0rJ2U2KHzZtJk
	twquJyI9Ygpa51crW+sFKCeQkF9SAB23aqsxNXSh+37uwC3U/d6+wv2Z2jeJ1bo1siHNPA/Q5Om2Q
	SNAh8LIQkctlVzjWBzcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpmcn-0002f3-PB; Sat, 02 Feb 2019 04:09:49 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpmaY-0000Xg-7A; Sat, 02 Feb 2019 04:07:33 +0000
X-IronPort-AV: E=Sophos;i="5.56,550,1539673200"; d="scan'208";a="25777619"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 01 Feb 2019 21:07:29 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Fri, 1 Feb 2019 21:07:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG7iGgTwvPxZQz0QAGw+YOD5d88ma2kLdOUKEE1TsIU=;
 b=Bss3x2ylW7kV8ZYsT3INc6imcyrx5EeA3tjw6tPLjFzJbE7dsvOaQGXoocP7BoPhlqPGxSFSBwJDjccRyc5Z1pv27LY7e6i2NVQjGDor4LT86WfIDKXom/3NdssTsLlL+djTLygc+A/cvPXtzrZX1IXYdw4EnLaB9xCkscDlLCA=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1300.namprd11.prod.outlook.com (10.173.26.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 04:07:28 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 04:07:28 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Subject: [PATCH v3 06/13] spi: atmel-quadspi: return appropriate error code
Thread-Topic: [PATCH v3 06/13] spi: atmel-quadspi: return appropriate error
 code
Thread-Index: AQHUuqzP3o+BJj+KVEmV9ZSLE3DYYQ==
Date: Sat, 2 Feb 2019 04:07:27 +0000
Message-ID: <20190202040653.1217-7-tudor.ambarus@microchip.com>
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
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1300;
 6:84o0bsYq6K52D3EarS6hP5RvX8lDVMY2VsBw2wcFchIHAJf2bIuh1tNm3sNyVCAGJjTNBWl3b4th3XRPw72DCr0sJsri/JO34mfb/7d6rYxochgPVeF2HbddU3XjIqslbQ+z4H2VpCIpETG8w0E+uQXVGfcutDPNxN0xtFqAxUnZdr1WS5ay7WUkbuYzrvmhEt5l4hKdvWrd+V9VRngwKLiwhuHE0jvlheVfCx8rn0enddXsaZLllvL11mlTawNDrrmQWAJoW6eVbJIMU3r7a0IYLI4h2ka1Sf+tG55Fh9RG0fasu4uAFoq3AAXxNZPkhOrXa7ORet7764ZGteSmyovF97J4aOSFWJ0FwTdq28DYkiqUkFO2ledGFNxnlvEKExUhk0/A2EwfR1txm2g4SE5pGPxFX1lx2sx1Kxo1vSqZyZo++cs8rNlQcIsidLSNy6qx0MrqW/MwjFyaEdpaOQ==;
 5:hbXm7s5zl5I9fPCfXRqdoQxFU+VHX6S5CNu8o5IpjTSNEADomq33YYeWwBSuqBN0NTfafFdDAAiivOl/myGR+tF2IEDHfgBN56eIAmlXb+lIzH40SECW0coNYRxStthVxv5mh8VEiMGH0rw6mJImMm26v3MeipC6kgNSQxSjiCbnqfS6mDKwo/FVe0XU884naQtYLFvRGbWw3sO9qik+gA==;
 7:eHUWDHRErYljTPUViERrObfAm/zmTt6RdnKSCJ+N3kKHmpozmbGymfwKx8WpFK3frnMQxBLZoyZ8c3v7X5cMmrR1XTlYHPGzYJZmZLTaXIctjUfC8B3UNKpSJbmb/u1EAIm6+PyEDPFF7BS6HTXrVA==
x-ms-office365-filtering-correlation-id: 669bd50b-6762-4342-d830-08d688c3f1ab
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1300; 
x-ms-traffictypediagnostic: BN6PR11MB1300:
x-microsoft-antispam-prvs: <BN6PR11MB130082EBD3FF899749DC666EF0930@BN6PR11MB1300.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(14454004)(52116002)(50226002)(105586002)(6436002)(102836004)(72206003)(81156014)(81166006)(2906002)(26005)(7736002)(478600001)(3846002)(6116002)(53936002)(256004)(106356001)(8936002)(68736007)(36756003)(97736004)(76176011)(107886003)(4326008)(39060400002)(2616005)(99286004)(476003)(446003)(86362001)(66066001)(71200400001)(11346002)(7416002)(71190400001)(6486002)(4744005)(6512007)(316002)(110136005)(1076003)(305945005)(186003)(8676002)(2501003)(25786009)(486006)(54906003)(386003)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1300;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IfHKrUy0hmkoFoQbLmv3stDkzI2C21O1pkmzNMLEy20YSJJNx3A3maKUFjLF8TBuYZ+9nfagktoe4rdg4qvMmJ9CNS5sDaIvWIpbbleKqRfLyHggz4qaYFaQW+NuQcpJSy28nHOPMr2DobiUeNxprSszx9eXgj/C7O6JpxeLKg12RAy/WEITA4BlUAdzqmkv3uuqQqK9c810oheGNfIDDUpcPEkCqeU/k4VKDdsc2pjtR6jb1kPvHub7fN2je0ReTg/eY3C1kqYS98VeerA7111IQEUpo5GT3ArA8ja8Q1EU2j/YvQEUGCx9lC8ffxq5CH+PimEDCdBKhTZII4iLIE0GPdQolVg9F9a1D0uO8hwbXu4GqkURHLDfYvAkXXr3a7uLgYF4nYA7/Vc1VPpwoJVXN9XxCSyY8uDKJKYNLYc=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 669bd50b-6762-4342-d830-08d688c3f1ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 04:07:25.3698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1300
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_200730_719859_10F9D940 
X-CRM114-Status: UNSURE (   9.35  )
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

Return -ENOTSUPP when atmel_qspi_find_mode() fails. Propagate
the error in atmel_qspi_exec_op().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v3: no change
v2: collect R-b

 drivers/spi/atmel-quadspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index dbc2c65abc86..80b77eb4ec5e 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -198,7 +198,7 @@ static int atmel_qspi_find_mode(const struct spi_mem_op *op)
 		if (atmel_qspi_is_compatible(op, &sama5d2_qspi_modes[i]))
 			return i;
 
-	return -1;
+	return -ENOTSUPP;
 }
 
 static bool atmel_qspi_supports_op(struct spi_mem *mem,
@@ -236,7 +236,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	mode = atmel_qspi_find_mode(op);
 	if (mode < 0)
-		return -ENOTSUPP;
+		return mode;
 
 	ifr |= sama5d2_qspi_modes[mode].config;
 
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
