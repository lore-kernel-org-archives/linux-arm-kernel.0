Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C6BC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:16:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97BC6218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CeJNMB9V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="KZu92Hi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BC6218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XesfWl108bEIcMApHuTLmHIxRwfwPwSF8um99R4FbtU=; b=CeJNMB9VauppqL
	NWNyKB7+6BT6V1uy05apr6/+35Wl9URlbBnIUytEmoa61GnAuJh2EiSPM8iVZ0Apiq7lakql6l6ay
	BAE1vQQsyQMwycnv6lH8dFLsPrXIgAAOV1oS/JZEoJ965mXjNTNDxMWE0dCayOBR3Lk1CyoAcvNDA
	Gi2DNdNlopPIzdcDh7HDMMVGPMNPFJ2Q0L5ySHboqkpIA7oxhvpGOeB1Qdadx2Yxl0dPta3GN40g0
	areZLpWLJOa4q3jZA+iAGtB3iWnFt+hCaCO4Yer3dh9suYqirDeRIwFH2qWVGfm6dlXgDQfqAokTv
	Kiw5wsIMt3agVBnDYLrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpF0i-0003eQ-8i; Thu, 31 Jan 2019 16:16:16 +0000
Received: from esa5.microchip.iphmx.com ([216.71.150.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpF02-0002zT-6X; Thu, 31 Jan 2019 16:15:40 +0000
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; d="scan'208";a="24072842"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 31 Jan 2019 09:15:31 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:15:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebZoX02BIUVl/c7RPJ/TiAnts4tU9d7VKoLF6wM4x2Q=;
 b=KZu92Hi1MgMl+8MDZ+BBjbg9PhK7FTWBbARnkHcKwsq4ZrC0ImSy5S/n9E69IuR7Z9OH0g57RQcOVP5GDGvsZzbAVvVp9NtDiXcQCpL1X0TAB755lwheN4BJ/FOB1O0G4E17k167tS8WgfvxNsXnii4NWtAuSeodmBpC/v0B91o=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1874.namprd11.prod.outlook.com (10.175.101.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Thu, 31 Jan 2019 16:15:29 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 16:15:29 +0000
From: <Tudor.Ambarus@microchip.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>
Subject: [PATCH v2 01/10] spi: atmel-quadspi: cache MR value to avoid a write
 access
Thread-Topic: [PATCH v2 01/10] spi: atmel-quadspi: cache MR value to avoid a
 write access
Thread-Index: AQHUuYAu+viSD5s94E+u9UEZBRyorg==
Date: Thu, 31 Jan 2019 16:15:28 +0000
Message-ID: <20190131161515.21605-2-tudor.ambarus@microchip.com>
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
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1874;
 6:BzLNUzNL8RZusRCyEOH7UOV2/cCumLRKc2LZF0IFI67EtzGiX2b2T1LJ2b1qusxQWy8/9u9YXOEe9m8fXmpTwbFskMm7x5Sy7IA9w/njmsfZL1uozURLd27134zj7x9/l9USKu00xlzJn2iUc6k7EUxrQWB926AqtlQ5MGNDedOL2uOfDCeqBV5u2q/CkISaMkTWinnjbf7+QF1i0oWc3/WGxISa1ZQpI7P0U6LS7Okmc8QKcnVr4nWLG6eu+Qwaps+mGRUy8USMkzEsWqLy9NyYcGbMfTSiKc25DoFTXXb1FYsnVJB9eohEZdNuqaaSPx5tNlcNPLplt3+EesGBCfUB/I1oE81rNrbf+KFubR1ZHglifNMA3e0SDkAJ/V4uDxI1d/x3FIUz9HAMwg7ywTwrY/Z46jbJ+jNcuHT16ENE+n6YgHtA7hlrk4szL61tvxjwFHNG7EwuMB3jC75OhA==;
 5:3UQ5NSXUqZEz4Gw++kdvB1GeSrItnwAaxww7b+bIu8enscOeEqLxJ3PST6Htlgb7nxVNipwQyV2SIQXaKG4zb9YdR6ifX3qjVXr75pImwG5whtgQBItRc5Z6LEVxiUkcCmK3BT//GNB2g02VU6KUOPjbGNWmV33mpXHsGEvdFivp3XSUiH+67W6jwRxtYecT3o4obfYulM/bfIL5bW/1nw==;
 7:UU1Jmv0ePdPaTYIfwp/TJWIz6F96g8fbItbPRC+Mb9FX1Ci8fE8eNZSSmlP6qzAwvbEKDKuKUSe93PBOk5n7D7CLfyTfAA6E+nV2zhOBLcbuv3dAKQBLcXfudmiLJN1SpumrI+N5dGHAOPPWl/lPEw==
x-ms-office365-filtering-correlation-id: 0c971f3e-7c53-43af-9658-08d6879750e9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1874; 
x-ms-traffictypediagnostic: BN6PR11MB1874:
x-microsoft-antispam-prvs: <BN6PR11MB1874A4CFE3FA3123E60D3086F0910@BN6PR11MB1874.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(136003)(396003)(376002)(366004)(189003)(199004)(186003)(107886003)(26005)(4326008)(68736007)(97736004)(14444005)(72206003)(478600001)(256004)(106356001)(105586002)(36756003)(99286004)(54906003)(50226002)(8936002)(7416002)(6116002)(3846002)(7736002)(8676002)(81156014)(81166006)(71200400001)(71190400001)(76176011)(52116002)(2906002)(1076003)(305945005)(2501003)(14454004)(102836004)(6436002)(66066001)(11346002)(446003)(25786009)(476003)(486006)(2616005)(110136005)(316002)(86362001)(53936002)(6486002)(6506007)(386003)(6512007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1874;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LqntUc5PA8+tCcRQKvjllraJlLQwIWaXFeNitnWXD70kd5g7VfB1YIO1ixhiSTS+Rhxr0Mq8MZWlXw/yJD1e6DiGvp1wneJnzm3ZmcRv1IaIH5inszah1dTfAj56CyJG+cJkoBLa+gX7+ClfQOCOvpekX0qiNfzmFOR9DBobYbqZ+Lw/m+UTjvO4tPpAjL1tUxz5dZ9WdKevrjZY+uzi+IGBOgSVfWkAy+/UCQ5P9JUlwoOqedtvMln7p0eAHAkgG7NzxXSsDVUPnyd2nRcfB+/K4BzVqAXHlKCVKa5T80P/NAw0cc1Hb6l/vdCLTvsvDvgnxtCkh8b8GkqrpMivNppp6zAAQwjfYlVSJere5H44KIx/nzNbivEJT88hhstDIfCKhjkK/yx+tVEW+1c1u1R+SSHoUhkMiqqB7pdTRYo=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c971f3e-7c53-43af-9658-08d6879750e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:15:25.7446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1874
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_081534_690295_73FAA87D 
X-CRM114-Status: UNSURE (   8.85  )
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

Cache MR value to avoid write access when setting the controller
in Serial Memory Mode (SMM). SMM is set in exec_op() and not at
probe time, to let room for future regular SPI support.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v2: cache MR value instead of moving the write access at probe

 drivers/spi/atmel-quadspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index ddc712410812..fe05aee5d845 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -155,6 +155,7 @@ struct atmel_qspi {
 	struct clk		*clk;
 	struct platform_device	*pdev;
 	u32			pending;
+	u32			mr;
 	struct completion	cmd_completion;
 };
 
@@ -238,7 +239,9 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	icr = QSPI_ICR_INST(op->cmd.opcode);
 	ifr = QSPI_IFR_INSTEN;
 
-	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+	/* Set the QSPI controller in Serial Memory Mode */
+	if (!(aq->mr & QSPI_MR_SMM))
+		qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
 
 	mode = find_mode(op);
 	if (mode < 0)
-- 
2.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
