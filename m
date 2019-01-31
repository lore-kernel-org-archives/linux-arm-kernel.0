Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57807C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:21:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25ED22085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UBA16lp8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="k40ncnK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25ED22085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NlmqmjjPjO1rIP5NeC6dVPIhKKvorUw1Jh3mCyxohnY=; b=UBA16lp8NG3Oy+
	cWfiiQLSPPgz02KXjqXQgCcCVyOoEbnWb63m098iB1k/78qiER8LruHSiy5dEPzN+7JfmA/LTYppV
	JAjVVQ95k3AecJktMshyY8nsv/c1Y48V2HKspksfan6+zGoAdOkJKTh/5x58Cs+MdoIlOe5oF47sv
	1H1WRxA/7TcoPG2NXp9eJcbz8fmdlLMp5C1JLe9UgQvP5WP46L2R9JxG9YsiI2C17La6jrMCMPR5z
	GHk4jc8A/r9u2B7QneT2TTKI8gfczkuin2crnktueEov7XNjXJaZWSmxHejRlrgXiwL/4PklQxfr6
	wE8SeXOS3hwK5aWuMh3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpF5Y-0000vk-Gs; Thu, 31 Jan 2019 16:21:16 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpF0F-0003Eg-2S; Thu, 31 Jan 2019 16:15:53 +0000
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; d="scan'208";a="25990743"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 09:15:46 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:15:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fxb3sOi6qK6Dzl2aCLZ6+yNkNqUTonU3R14fFSBDklY=;
 b=k40ncnK3e6VRHjBarhGKi7n1AmscMxrp5yi2XBsgjYtLqf2EEdPSG3hyqgqYW7kAWILqNvWEuksVuslbydv4XsfSwSrjbvW6sW0Kvuu6Zy5Dnh2RoLHhemEJuv0iEMGWn9ClYx/jutbbMiH5+X9AQEZjgC2sQwheMZ7370Ps9Wc=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB0004.namprd11.prod.outlook.com (10.161.155.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Thu, 31 Jan 2019 16:15:41 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 16:15:41 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>
Subject: [PATCH v2 06/10] spi: atmel-quadspi: return appropriate error code
Thread-Topic: [PATCH v2 06/10] spi: atmel-quadspi: return appropriate error
 code
Thread-Index: AQHUuYA2ThOESU6JdEiI/8ypvWP+Qg==
Date: Thu, 31 Jan 2019 16:15:41 +0000
Message-ID: <20190131161515.21605-7-tudor.ambarus@microchip.com>
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
x-microsoft-exchange-diagnostics: 1; BN6PR11MB0004;
 6:nelS39jNtyEbkwk/DKirjJF2yJ9e+jNZzoqi/cFkYroDCkhonTWwzdi/uxn0IluybJq5EXmRkcQy9q80PKAVS1aixYym0hz+GYqsiUAYh4QlregLACh6mSGjzmxigP2pWCljmzG5A0X9NmbFPIKU3LpiTu0QUW7Z4lxdmhI3xbxSZepGLRUBRSlqmPEUmn27NGShXux1SkYVnH0ftd1cEIC35R2ECufIhGSkvTYDddicTHqTXmV4GNnw6ffjwugDT4hkjDQbactNXQK9VJRkDLboZkmw5I0uRDCRRyZREaltVDA1K25JbIGDjkL1wNP7A3FAYB5UTtlIYbPIxipnF+bFZIyBVC6gBM//1Ez4cvhDbNdcRzFMhhoQ6YPnLoRMgQCVcG0UbWIevPciCUioawRLgUoGBW1jso3/6nEeQkYHkUeDkwd5GfGHEKI73bTzaN5gb70s9d92M1+iyilzWQ==;
 5:7PCZg/rvU7UAjN8O/IP28gH9asJDNPVM1HNigaV9ZA3XwleaesmiIBTb6AoFKPECV15HtnkUrFwSfEmaej1WSdyxVsaPlw29tBhiO3xVTgcS1baZrJ68RlDmGyFearjKFNSmS2vxCiC2ujWWcyIj57/C5ZyDXllYG+PUwGqQEbcF+WmTiFpajs/Gr9zkEqv9OsKJE3k0L7nnH69aHcCpzQ==;
 7:wTUCpKJNBS31xDjs4kACTm54sx8aqQS7wEzJ41WOllQBeYYPaos1X3fv0DTi3UdX8Nioj08KyPRMUvz+AWXPB4ArLsvAiWDbL/Z5uTNcNIsiX3DP08aGSgDDhqImzG/jh67/WEbo7so0ueTo/69oKA==
x-ms-office365-filtering-correlation-id: 5f035d60-dd8d-43c5-ef0e-08d687975866
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB0004; 
x-ms-traffictypediagnostic: BN6PR11MB0004:
x-microsoft-antispam-prvs: <BN6PR11MB000412C9C5575BD51162F795F0910@BN6PR11MB0004.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(8676002)(81156014)(14454004)(186003)(86362001)(36756003)(1076003)(4744005)(76176011)(68736007)(81166006)(256004)(7416002)(8936002)(72206003)(52116002)(6486002)(386003)(6506007)(305945005)(11346002)(2906002)(2616005)(102836004)(50226002)(6436002)(66066001)(71190400001)(486006)(316002)(6512007)(4326008)(446003)(107886003)(71200400001)(476003)(97736004)(26005)(6116002)(3846002)(105586002)(478600001)(25786009)(53936002)(54906003)(99286004)(7736002)(2501003)(106356001)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB0004;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /ZvDTI0tgwV3N0+RvsydFekWPty3hch7IIK/2NmskP8aIHHts3o0svBtjoSkWmypeDCqVrBePfofCJ85psaq/lCe3Y7alc7yeP2bAyDk94NGqnsJpIdgjnsH5TlOrABc/dgpBpCtgnqdlA0yoWEjnydrDi0O4/H/RC2ek0F8or+V5f3RUDkxQXZs8C92DIfI9GEs0aIXq6D0yVC85h0PttF5TgeCMUFG0mdNFm/JBLoTkPLogcaxvDgmFQvIVViLEKxdT/G5U0XOVDtO+a8eKoNSwk79+6UnxAaushpaHR/0vCHCVhEMioxBxBCeDVJ01OJlY8wXfHBaEVgM1Aswz4JJyWoIn1uM5y7b5vJKpvZHNuqWaU5y06HbTzg8JdNq7ms5AP80u+1rSNU+dTrkv5hbcxC9WWPz0XEFjAPbI+k=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f035d60-dd8d-43c5-ef0e-08d687975866
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:15:39.0547 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0004
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_081547_832030_6FA04DB4 
X-CRM114-Status: UNSURE (   9.18  )
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
v2: collect R-b

 drivers/spi/atmel-quadspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 2db935488270..1f7cf5d2953a 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -198,7 +198,7 @@ static int atmel_qspi_find_mode(const struct spi_mem_op *op)
 		if (atmel_qspi_is_compatible(op, &sama5d2_qspi_modes[i]))
 			return i;
 
-	return -1;
+	return -ENOTSUPP;
 }
 
 static bool atmel_qspi_supports_op(struct spi_mem *mem,
@@ -234,7 +234,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
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
