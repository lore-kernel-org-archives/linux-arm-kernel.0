Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D721C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:17:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B2D2085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WqnMq6ms";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="bLbT1I++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B2D2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yvnkTCluUJ3At8WBPjTFk3FRIPqoz6TPGPRfjbdqKX8=; b=WqnMq6ms8SS+Aj
	zuKKVsRJ46MQogqfJjHEa3XnWxcUgKYPh6aMyYYNLe9x294fBwehFUYiX8Ms8QiDa2xM5kyYfIhc9
	oYWIfsKh129kJRp54jilV0BfDqXZV9DpatavFJtiDTCpCNfJxsioBCrkAGH6qn5RXDgk+ubje//Vb
	gTt+z+oI9TLB7oV7qexdFdL7doT2PyK4MYSkSiXY/nMoNAf4YvrL8TlGHa8DtlnA0+sZFu33D69Wc
	HYGPieQOEhfMWXJTPEH+2WEiBSnrmGOYDOOsATtKlG8qweDLlgZprrpCIuFTwyfNh2aq73bzfvbYA
	bbQaqxIoNcQQ5kwh/uTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpF1j-0004Vp-ER; Thu, 31 Jan 2019 16:17:19 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpF0A-0002zw-LL; Thu, 31 Jan 2019 16:15:47 +0000
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; d="scan'208";a="25990739"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 09:15:41 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:15:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N0kfM9j5S7ly1ryn+Czo2EJ+DL8FnG5fcH41qaprx4=;
 b=bLbT1I++48i9uoFDozNeps3EZBTqTOp9gLkJFx6EOs3CajYhqQ85mPT5MkhlcjaNNDCZqZ/nJwogblmQf0JNk0fyxNqy8BcaKj7PmTDqVETiEHK49w8ASmA6jYMcfdG9R7d23GixiNzx3iFPVMX7TRlqnCESCydE+0SPmEPefj8=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB0004.namprd11.prod.outlook.com (10.161.155.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Thu, 31 Jan 2019 16:15:36 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 16:15:36 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>
Subject: [PATCH v2 04/10] spi: atmel-quadspi: fix naming scheme
Thread-Topic: [PATCH v2 04/10] spi: atmel-quadspi: fix naming scheme
Thread-Index: AQHUuYAyhUVeJr6pTE+IWHeqOweSqg==
Date: Thu, 31 Jan 2019 16:15:36 +0000
Message-ID: <20190131161515.21605-5-tudor.ambarus@microchip.com>
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
 6:WJJqCabjrvtwVLqOOt9s+EZzp2fGJo8k+PBMNSFiA4Wpst5yAEy4VLZsUgC4yCr4JFSWxyH1JvaeC/HmrWWfanA25/P9F8SCq1o9NpHQlDaE0rQ+8p0xp75pZjlj2g1uxEQKcijVhtRIQTxnW8WoaxZ77WCdrozw/8jjftNIqWNZyc/giEVPOwLt1HNMIeppdsKy+rDXauR92kf82pRJE+64+08PACVWQKcIVUQ0CqKvugAiERXPD1nHBaug4EJzqpkukaH4Pe9PU9rrgJvC6mqS2/i4kY+8cc4kde28HDoPBFlkkwnw7kYwbkHA6xzqcNi81vIJEcbXiNvI67hDZfA9VKpS5LthLCfIY8Xn4rrQzO8LL2uq8jHlivh4yzsGTYKzYZxwKv2Z79lqy0a9Ap3EUOpN/lodUCfrVFlRNq4VngSmI56ZJZmD8F5wzGtUYU5aMUmUF4supz7NikwrrA==;
 5:tohkeNJop6y72W3Yd6xC60FDan9ERlAeRubKz+0Za4I4yhvp/zqIONzDn12evCI09TtQe5GNh1Vm2gp0nykuP2Y4r5rLItbEHOjfpv4Pi3Ts9oWZUKdaBNa1xPJK8dmkSq57E3oOdatQ9O0fCsTHyENzM4vm5dk9nMTfmZAKlRGjT3fY6jXaPOCg0RwSOn5uF5ebPealTefp2VZEaUFtEg==;
 7:/pKXHdCkLIC7DaKMP4RAxB7dxNTRYehypPQJB7WsthzEu4hXviGdZGQDGWvew5VGt8MKh3b7ESo/VS4KXjkjEBtvVvS4tNy9GwbCCtcNV5y0H4XJqWeXgTLVpHbpFsv7Tj3XJd8FiE+HQGmGHAPeNw==
x-ms-office365-filtering-correlation-id: 584ce8a7-f175-492f-083f-08d68797552f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB0004; 
x-ms-traffictypediagnostic: BN6PR11MB0004:
x-microsoft-antispam-prvs: <BN6PR11MB00043DB746E6B384693AB61FF0910@BN6PR11MB0004.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(8676002)(81156014)(14454004)(186003)(86362001)(36756003)(1076003)(76176011)(68736007)(81166006)(256004)(7416002)(8936002)(72206003)(14444005)(52116002)(6486002)(386003)(6506007)(305945005)(11346002)(2906002)(2616005)(102836004)(50226002)(6436002)(66066001)(71190400001)(486006)(316002)(6512007)(4326008)(446003)(107886003)(71200400001)(476003)(97736004)(26005)(6116002)(3846002)(105586002)(478600001)(25786009)(53936002)(54906003)(99286004)(7736002)(2501003)(106356001)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB0004;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7rIcn2vPC0EwXGSIGOBvDMvioGzPjgoJk/JdYftPp5FpzIhiV1/B3Scg8IbJ5Haj8tTjX8TAbCbuTEh7TUlH6EiJdNYU0sA9Fqnk4govXiRghABmsqbLFd/L8S5Yc/n+MMuHKCf8c5+dvz3rwXr0TuAn02xsOiCmMJxfro7CAyto45eneqSJZYFk+oWkRbkYxFlngNb3xeNb2gLU9s3KloGbFh0EgpbjQ4B2AecS0haxnwYsnmPTgoZ9dE5tPiQIV2n706aa/TjjOw+nua9lo4eWOACLLrWI9t0zOLOAzk+wYw7ek2qf2PvVitf0C6fxrMPA2kVjiH4e1qVJSrvh7/90Ct1AfRt6LOceXtUbxbLpTB/vyhrKCBE1VbCPajcPwFl6FSCG1NpLBt24rjdTh+iGLSaa3BzTV2pQvML2tQw=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 584ce8a7-f175-492f-083f-08d68797552f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:15:33.9164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0004
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_081543_502842_1BD1B4C8 
X-CRM114-Status: UNSURE (   9.78  )
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

Let general names to core drivers.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v2: update after the removing of iomem access wrappers

 drivers/spi/atmel-quadspi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 3a7648ea07e8..4105ded68f44 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -158,14 +158,14 @@ struct atmel_qspi {
 	struct completion	cmd_completion;
 };
 
-struct qspi_mode {
+struct atmel_qspi_mode {
 	u8 cmd_buswidth;
 	u8 addr_buswidth;
 	u8 data_buswidth;
 	u32 config;
 };
 
-static const struct qspi_mode sama5d2_qspi_modes[] = {
+static const struct atmel_qspi_mode sama5d2_qspi_modes[] = {
 	{ 1, 1, 1, QSPI_IFR_WIDTH_SINGLE_BIT_SPI },
 	{ 1, 1, 2, QSPI_IFR_WIDTH_DUAL_OUTPUT },
 	{ 1, 1, 4, QSPI_IFR_WIDTH_QUAD_OUTPUT },
@@ -175,8 +175,8 @@ static const struct qspi_mode sama5d2_qspi_modes[] = {
 	{ 4, 4, 4, QSPI_IFR_WIDTH_QUAD_CMD },
 };
 
-static inline bool is_compatible(const struct spi_mem_op *op,
-				 const struct qspi_mode *mode)
+static inline bool atmel_qspi_is_compatible(const struct spi_mem_op *op,
+					    const struct atmel_qspi_mode *mode)
 {
 	if (op->cmd.buswidth != mode->cmd_buswidth)
 		return false;
@@ -190,12 +190,12 @@ static inline bool is_compatible(const struct spi_mem_op *op,
 	return true;
 }
 
-static int find_mode(const struct spi_mem_op *op)
+static int atmel_qspi_find_mode(const struct spi_mem_op *op)
 {
 	u32 i;
 
 	for (i = 0; i < ARRAY_SIZE(sama5d2_qspi_modes); i++)
-		if (is_compatible(op, &sama5d2_qspi_modes[i]))
+		if (atmel_qspi_is_compatible(op, &sama5d2_qspi_modes[i]))
 			return i;
 
 	return -1;
@@ -204,7 +204,7 @@ static int find_mode(const struct spi_mem_op *op)
 static bool atmel_qspi_supports_op(struct spi_mem *mem,
 				   const struct spi_mem_op *op)
 {
-	if (find_mode(op) < 0)
+	if (atmel_qspi_find_mode(op) < 0)
 		return false;
 
 	/* special case not supported by hardware */
@@ -232,7 +232,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (!(aq->mr & QSPI_MR_SMM))
 		writel_relaxed(QSPI_MR_SMM, base + QSPI_MR);
 
-	mode = find_mode(op);
+	mode = atmel_qspi_find_mode(op);
 	if (mode < 0)
 		return -ENOTSUPP;
 
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
