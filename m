Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44336C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:22:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9BF206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a5vdv/wC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rG+AgdQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9BF206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=opuAx1W9SrVKfv/YQxNTgbUT3xntSPFk3Z9RvTqhbw4=; b=a5vdv/wCFQTVai
	gtP8kMNReLFIuUZcEcP8B24bIYD2MApGQ+9oasMCwgCz0eYB2jcXCeIlhAZFmGF0p74Ss3Y27KuUU
	PKMjw4u5Y3UT39qOjS4g8YdPls2XqEs8TbdZ4+YNRJb1gL4dFHNNHlpiRE/RAoz/OQ7My9OLCPK+E
	vTPkqz62oI9LawbAqthkjE1AkR6hx8duClsVjrjXxLfC1d3NjLOH/wA4yKHFaiBGtsZU3jQecQlc8
	ypUP2qMBQMncJD3qjjFsix7IKO1D+SdULu1f6/MTNrVqd1RKxUkszVVgpybqrutYS7D/lXCy1+M4x
	vDrUmEz0PYp5dnsFc7Xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggR7K-00043q-GO; Mon, 07 Jan 2019 09:22:42 +0000
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggR6g-0003Ia-Gf
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 09:22:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEZyR3RQDEVD+9+hXCTOQ6cZVALD8oO2leJeNUdjP58=;
 b=rG+AgdQ/rCIp6MDj81DZp09700Qp0U8WS1c6EQOSUV8nRpkMpqGWeqMxN5IwV8/SmSO7totmxt4ljipE96n3RcB7NTWCu0xz+zMqbyE0Qpes9yZknqkFunz3J5ezTrt/zKNcY5DGxVU8BrKFD8ZN4hepp/H1KZ1DuKyeArCFsbI=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5697.eurprd04.prod.outlook.com (20.178.119.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Mon, 7 Jan 2019 09:21:57 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 09:21:57 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH RESEND V5 3/3] defconfig: arm64: add imx8qxp support
Thread-Topic: [PATCH RESEND V5 3/3] defconfig: arm64: add imx8qxp support
Thread-Index: AQHUpmpvFV4elVZvWUGDgDgcTSLExw==
Date: Mon, 7 Jan 2019 09:21:57 +0000
Message-ID: <1546852546-29228-4-git-send-email-aisheng.dong@nxp.com>
References: <1546852546-29228-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1546852546-29228-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0043.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::31) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5697;
 6:pTUzGzM9AWy9fZJ2hZQ+IgRHaCxjY5hAwu1I27QtcjJrty6CfcwRJ60eCduB4MZWzUAOOUP8n/ESvwinNuBmhdH31sKN3T9yZPsPZeMr3uLRUmC8nbuhh0M60nqWFiyagecQpqfXgYVirfUgniJFRAGvchdQY7T884WmptBarZjTDx3BLTfZqdVDmWSrrT4mljxnR2V2eg7o7dEGSS2y4EVU3kVAbML5/YQtorsPbiK54CWSQUiNhJoufra4cWpcnD8hiP7GEkF8Aagt8jbW983yuqu4Av41RvXsupk9GYDwyVJ/h/68cQokHyHNMbsp9xCDwfsxM3BuF6PkrWTc/Vwwr48E9xvkFLxUo1+ufstVkLn6NyYl8EXH3NLxH/ozTMWUIT9jPtaDLeoeuNTP65farCP4CggLD3qkuGXLG3zxA3/LasotJ8LKKWqRpbRIQKBj5ObumWDCN3M4TCgHnQ==;
 5:+5WI+GxW/maqjCOoNwnlira5YpGhLDyRPtu+qV0Eqf04ea9dHxGfIn0laaXwM1x35yHRn5zrcQbFOWvSMk2B90h35Sh/QSL2Tb7U84oTIGyzYTxzAvfTMs2pY+0ZDVTPFmK/HjOIUTFvTfDRLtaEK1owRdv9iTQEnRWPxZnYSG15UNYaC5Jx+TPgQbL7Fl3lU9NKJC6NFR1tSkelQFgqeA==;
 7:HjAQ1zZ6YRr4Ab9HbiYWm3r6aa3B3a16uhwzI32L4ojkpyniwRhAwO9YBCnoVpZQx2w4bAdeJwg1NhS6wEoBvllTUmP1pGbEQS9wKky1qgp8lyroohtLiQaEJLAmVaTr4vpuQoOlk6PR/Lr4Of3FEA==
x-ms-office365-filtering-correlation-id: e9dcbe3c-5e6d-4b33-6864-08d674819224
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5697; 
x-ms-traffictypediagnostic: AM0PR04MB5697:
x-microsoft-antispam-prvs: <AM0PR04MB5697E3EEA1211DF2573598B080890@AM0PR04MB5697.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5697; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5697; 
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(346002)(39860400002)(366004)(396003)(199004)(189003)(105586002)(2906002)(305945005)(68736007)(14454004)(5660300001)(6486002)(39060400002)(106356001)(5640700003)(478600001)(66066001)(2501003)(6436002)(575784001)(25786009)(217873002)(2616005)(11346002)(54906003)(446003)(86362001)(476003)(6512007)(97736004)(81166006)(36756003)(52116002)(256004)(53936002)(50226002)(76176011)(2351001)(316002)(486006)(6116002)(3846002)(81156014)(8676002)(26005)(8936002)(102836004)(7736002)(99286004)(4326008)(186003)(71200400001)(44832011)(6506007)(71190400001)(386003)(6916009)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5697;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rcGKJjpo94zMsGbxXpVgkAp7r80TGinyrQ6U3aHUTb06KLU9EjiEW40g87G5/ktJuDyNbtu6apdLpAvjpPXbw24c+mfgXylFd03ko+1JX+9XltpcnqDW0zRjbmuHiLN2HOmFjFPVRvRNCldHKexJVqADNb5AazxF4Ppckn5Dq/IFJOSS4d2RJUvjovwQttvdL9Bm0oUfLbjDHHZpwJpnjuaTqtJrWcavbzkEbhwUoacpdvUhH4pnBQOK1h49BUNmJf32IfDTdEOzDDsy5prJ2h6CDnHbqyPSMJ1KMLEbsTRMuKlUQXAIS1DLUXgkHH0U
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dcbe3c-5e6d-4b33-6864-08d674819224
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 09:21:52.6285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5697
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_012203_336559_7BCA5C04 
X-CRM114-Status: GOOD (  12.12  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm64/configs/defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3ef443c..f0f38dd 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -43,6 +43,7 @@ CONFIG_ARCH_HISI=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_MESON=y
 CONFIG_ARCH_MVEBU=y
+CONFIG_ARCH_MXC=y
 CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_R8A774A1=y
@@ -113,6 +114,8 @@ CONFIG_ARM_SCPI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_EFI_CAPSULE_LOADER=y
+CONFIG_IMX_SCU=y
+CONFIG_IMX_SCU_PD=y
 CONFIG_ACPI=y
 CONFIG_ACPI_APEI=y
 CONFIG_ACPI_APEI_GHES=y
@@ -245,6 +248,7 @@ CONFIG_NET_XGENE=y
 CONFIG_ATL1C=m
 CONFIG_MACB=y
 CONFIG_THUNDER_NIC_PF=y
+CONFIG_FEC=y
 CONFIG_HIX5HD2_GMAC=y
 CONFIG_HNS_DSAF=y
 CONFIG_HNS_ENET=y
@@ -326,6 +330,8 @@ CONFIG_SERIAL_QCOM_GENI=y
 CONFIG_SERIAL_QCOM_GENI_CONSOLE=y
 CONFIG_SERIAL_XILINX_PS_UART=y
 CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
+CONFIG_SERIAL_FSL_LPUART=y
+CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
 CONFIG_SERIAL_MVEBU_UART=y
 CONFIG_SERIAL_DEV_BUS=y
 CONFIG_VIRTIO_CONSOLE=y
@@ -365,6 +371,7 @@ CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_MAX77620=y
+CONFIG_PINCTRL_IMX8QXP=y
 CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_PINCTRL_MSM8994=y
@@ -547,6 +554,7 @@ CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_OF_ARASAN=y
 CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_MMC_SDHCI_CADENCE=y
+CONFIG_MMC_SDHCI_ESDHC_IMX=y
 CONFIG_MMC_SDHCI_TEGRA=y
 CONFIG_MMC_SDHCI_F_SDH30=y
 CONFIG_MMC_MESON_GX=y
@@ -613,6 +621,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_CLK_QORIQ=y
 CONFIG_COMMON_CLK_PWM=y
+CONFIG_CLK_IMX8QXP=y
 CONFIG_TI_SCI_CLK=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_CLK_SMD_RPM=y
@@ -627,6 +636,7 @@ CONFIG_SDM_GCC_845=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_ARM_MHU=y
+CONFIG_IMX_MBOX=y
 CONFIG_PLATFORM_MHU=y
 CONFIG_BCM2835_MBOX=y
 CONFIG_TI_MESSAGE_MANAGER=y
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
