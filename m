Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A88C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:59:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 148B72080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aXngyjaF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uFFeHYPk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="E0drAS/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148B72080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c8OfHYnQ0k/sYpgya59RwQGT5xGPp+7ykZlHcX+CUq4=; b=aXngyjaFidGRQO
	xpgOOguy38sO70bwB2XgIkUUYwgrFCJmT3dXZpzmz1bvk0K/MgrUMU+7V3uLx1SMM7pZ7xLTScljc
	816VrXT3y/1934rJmKGZ6E1Ivv7sGNRuxDCgur+AdOM3ZvOXkc23qUESqmJPRObvXyeodDX80PPsu
	5JRuhr+lL4d7Tp17aYxRtbGeE9p5IfQ0MhNucYpp4/IKv64ypJkGztgNyZ+FrC2uCSa99Ad/e+LKE
	LGdjfVg+tbPccle7pitEjrSIeAxwRqCpDR4hnCSmgqZwNGLIRMhZNtHdszX1fBTm9rodRptgpG/aG
	BIEmG8KJNEvRRyMm0r1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr38R-0006df-D8; Tue, 05 Feb 2019 15:59:43 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr37P-0005Z9-2x; Tue, 05 Feb 2019 15:58:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ANC5cgl+5kSOAeLmfZNwzCIDmW22gC8QxdKBzwzsJzU=; b=uFFeHYPkGE+oERzjQPXz0SOzn/
 QqWziriZkMVz/RyKGg2Zp1f7dz9MgyZmGl8DHdBigbpWXKk6MIkH+4gZvhUmt98ERSEmubeyd/J4u
 Wz7WcglfhoNDGqGMFLiv4p7AnKezMwciYvncxa0FyfHJDIqlVxeoCydkmYadbew5z8wWRlooIG8kP
 u13HvAeLT1f765b0s2yARcf2IdUy6IzEVxoSX066OFPKn63ZPCltg3srXt2Db7KEaX8EInF6TYpoP
 6YQwRvlQTTUyU1WKlMFm4o9GWogzrgnihQC5Py+JH2Ow4o3RCiyi0vsiMQMPULOu7bVTORdWBw8uG
 MU3YHFHw==;
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr2su-0005v5-DO; Tue, 05 Feb 2019 15:43:42 +0000
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; d="scan'208";a="23460614"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 05 Feb 2019 08:43:36 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 5 Feb 2019 08:43:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANC5cgl+5kSOAeLmfZNwzCIDmW22gC8QxdKBzwzsJzU=;
 b=E0drAS/hb40LBJaLGVeq+tiMODPamNcJDzds/TZ+B+mEVkgJSgdfoCdN5hTMuxsOqrS+9tUVx/tZg+By9FGIttaC9W1IT/v4qurClrPs7NVKNuTgkrlWYR2KDW5piMOsxSmD8B93C9L2yDyDqpwF1Iq8ODC64XFyIVhFeWtq9Kw=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB2020.namprd11.prod.outlook.com (10.173.26.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 5 Feb 2019 15:43:34 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 15:43:34 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
 <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
Subject: [PATCH v5 05/13] spi: atmel-quadspi: remove unnecessary cast
Thread-Topic: [PATCH v5 05/13] spi: atmel-quadspi: remove unnecessary cast
Thread-Index: AQHUvWmNlktXwAQKWkSoVihsTTy0dw==
Date: Tue, 5 Feb 2019 15:43:34 +0000
Message-ID: <20190205154257.29529-6-tudor.ambarus@microchip.com>
References: <20190205154257.29529-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190205154257.29529-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB2020;
 6:kTqgMUsHk3eu84qyjftBrLFkIxt8OlkNxXHNQTcj7pVAn5oIuO8dsGt0KJEwVK8qC3iIMdCG+riuMtBWHEPIXowszAECyIgQOMv64wWWm1W56SPlTyWwD/SoYtKf0sRCqkQqxUOyUK8rH1hTCjmSzkre7t3PRjdHUOQMw1oEB4uQtPzM3aHkg6VDY2LRNPAnC7GP4o8iCQkzuRPgvFv8itqjfyLXBtUQ4k+3wjVVW74v0v72BDBtx/vO8Gs8CmgPQfGSt6X5vfT05j0YSbDIoADFp8x0vT3/4WZq9HF2NQlq6pHdH8AuPDF3Rzsg6NHy2twoWhCISDWhazdijrDUF2BCIKjr90TBZukF6+NtlMMzBETwW/UUSQKwwzYq9OvGyl450uLGBnEfxDCi1QwsDUAYqvIB1whOuwRbP5jklZ0M5K3tn4okc48klaLs1j1OVPdtq6jydhVs5RlgMp69vw==;
 5:fJvJsM+4hG3xoFswRhK++Z2bOjs2YnHAHGwEGPq3TmllAVDFue2Z33EyN49Rtc7Uth0NlobPKlav364yHhGD4GV18k+oztyfUuv+TAkv7UpQnLYEeTwmigm6vv2avf1uN7cAvGX/6NZXcg1x1CW5ErKUDfB5R7ANRmJCadxhOtp5uHNDjnvITHHGA0ITVkW+ZUnkOCp8LSVXXQ/uwtkVVg==;
 7:kEVT5H9tHTiL0r7Du1IGp7IsZuvKkH5jxb7feZ/q4a1O5ZuaZH3r0zyaLzGnymvYQpw9Srt3SEKjmH1Dx/6nSmQs4X2lnF5MyEiah94RFqOCjMxG7Dtn5mWtdWsG3jM1BiAz9CsA82XeMmaQF0D8Yg==
x-ms-office365-filtering-correlation-id: 28332fee-797b-4a1d-143a-08d68b80afc8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB2020; 
x-ms-traffictypediagnostic: BN6PR11MB2020:
x-microsoft-antispam-prvs: <BN6PR11MB2020950C53618567A88F599EF06E0@BN6PR11MB2020.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(346002)(376002)(136003)(366004)(396003)(199004)(189003)(107886003)(6116002)(3846002)(4326008)(8676002)(305945005)(7736002)(2906002)(81156014)(14454004)(2501003)(1076003)(7416002)(81166006)(8936002)(50226002)(52116002)(86362001)(99286004)(6512007)(106356001)(36756003)(71200400001)(71190400001)(25786009)(68736007)(53936002)(11346002)(2616005)(486006)(446003)(186003)(105586002)(102836004)(6436002)(316002)(6506007)(386003)(478600001)(66066001)(54906003)(110136005)(4744005)(76176011)(72206003)(14444005)(256004)(97736004)(476003)(26005)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB2020;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lXRG+gXOVlTyAhBBWeMDFhBiRCfcJUj36Q++5orWQPLy9b4M9MQZ2y8/ZUonSMbxDHz5WbgogTlkcS/j0JUSREFTuX7w1cxFSAw834Yt/ePmiOp9XDXHJjhTXGleMad5cSMiBrG0dh8uULomAOyftctb3I7GIFvIXlYKXSpl5d4LYYWuLyVL/8oHDWkw8U+rGBuxKKDGCFvhZCKBhYw5uvQlFKR8QzWH+Gc6eDVf1KVU89wv+3IYDfz2HerqGLtDhKsACNKsio3y7l4w+XGhPa2y/a4WK9lxZl6ejMFVvB1SKVMy24/Y36jicyJRIUu1Go+AigWOPwsIjFj+Bp85JAm8oxi9eOKPRK9Jc37frv9vBT4/UX56rrS8OACeSwDYPXJvbNZ1JgOMiVj+Ls9/i6rtc953QTKwa50p/zKRT0E=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 28332fee-797b-4a1d-143a-08d68b80afc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 15:43:21.6499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2020
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_154340_830259_DE5982E5 
X-CRM114-Status: UNSURE (   9.72  )
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

The cast is done implicitly.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v5: no changes
v4: no changes
v3: no changes
v2: collect R-b

 drivers/spi/atmel-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index be1d1ba7898c..be7f87fd5ac7 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -389,7 +389,7 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
 
 static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
 {
-	struct atmel_qspi *aq = (struct atmel_qspi *)dev_id;
+	struct atmel_qspi *aq = dev_id;
 	u32 status, mask, pending;
 
 	status = readl_relaxed(aq->regs + QSPI_SR);
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
