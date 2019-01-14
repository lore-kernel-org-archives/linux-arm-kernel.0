Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D24DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:22:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278C320657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FM1qvHIL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l6TIADpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278C320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=j4MjVRi0vKTlhOrKgLxOCqSPdK0lfYVc5JXIxrPBXeQ=; b=FM1qvHILcZTwue
	cFLX0FoQsDzOCWegvpX7lKVZDfKZjbfpHW88Uu/vPkvWoLzlgGHwTz++nQgL+3CTkwLg/ROX/6VJ6
	M7+YjBJj7CD25qRfTTs9ga79w1XWih6KM1IqtXpNczFc+TEGEI4aLoSdNXJZAyx/Po4b7lw5MwZy0
	ld8lInyAe8/5OsCJ6TIxZuyi2N4GOYAS3IzWN3RJ3zAZhrVVcrz/uUspRABkBvC0BjE/siRpmNqt7
	7hESgaHdifFl/Wqq4ijRLF4AK4T2PtxcqdNSASYxIeHXNU9l4Ftx+B/Wst4JIJonD3DHPZ4xGmtKo
	5mYXS0LdGeh8K6d9wpfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gispd-00070i-6L; Mon, 14 Jan 2019 03:22:33 +0000
Received: from mail-am5eur02on0602.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::602]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gispZ-000700-1w
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 03:22:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aOBYvvkAxOfGntgkRZFbfbpett81wTzKjuViTFpoQc=;
 b=l6TIADpXSQx0ePTyXiUiWG1vLuf2TdA8GI2wM9cBAnQE5tVwYyKEaSHVB78q52vc7kJ3zxHcOovaFhiIM1DVGR4WKwovYkZV4WSvc/6Ty6qG/JQMGX0t6pbK3CupRpkSy8EaRebaBU1JoF12BkwzYjX3EfHCDZktLOGcqwM1TtU=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5299.eurprd04.prod.outlook.com (20.177.42.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Mon, 14 Jan 2019 03:22:21 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 03:22:21 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V2 1/1] defconfig: arm64: add imx8qxp support
Thread-Topic: [PATCH V2 1/1] defconfig: arm64: add imx8qxp support
Thread-Index: AQHUq7hceldFwigxqk2tFxEamDBJDg==
Date: Mon, 14 Jan 2019 03:22:21 +0000
Message-ID: <1547435792-17697-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0162.apcprd02.prod.outlook.com
 (2603:1096:201:1f::22) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5299;
 6:0sgxT7SH7D4A7uP5mVvGHk7XQwVTf/QweG+1AeQBRC5wW15CXdF/929Myz0qqY34Nssi3jtyGZQISnbgzN250DHz3V5vAgEWVFakFNNUdErd2lwswTLTsWihawxEPMjIJ4pUw/dOG5hrC+KEAzS5LkA954qDQa3xsfzzbIK+Q1WVsOIaOnaz+l2EKKdxGIAxNknzJpQcDFUVbtley2d7CutZxnr0nwHP/7WIoEOng4/31ZNQfBghWrDN5FBsIrHKZ9ddqAnp3gPWFYuF1n1g4c7qTIMLSbZZPXDHBGBi9Kjkvo8PGXwRbDmHAzNtFqwXo38hasxzdv3IqNo++LGzCJZxlYcvmIDQym0e/f/1e+XAbVSNVR2XN9+RJDq5iyvu8KP18cJoNCaFjAC5FDNuE2ELud+QZDtdH4YHiSXAOIQ1zDCe5tJf0TC4hu7czCL+1cJnr9ys0P39xcSjzD23Nw==;
 5:MV9jeSrgpobs86NY2PqzoNgydSFDwkjpXD1ZhSLzJoy9yQymDtL4X18ee4tOO+h2BSsYAJBcccW61jBFwPZfqOpsr8VrxZUeMtbAtW+Dyn/zY2C6dLS7z7Nos6nhCu7ZPxmkIapqZwpXtNiwlW1fOhmJkeo8uJpYMw0CZWRisHj3X3IyYewUh7qYL+NgH9scAS1daEiujolhD8rAXs2hNw==;
 7:UUatHELg57vFbO2NY0GLZe1b5y9lUEn/5pbkLZjc8F7WqXMmRr52J9XCNL/XlsWkdxI55PY/03P16LEF0QBVcOuUs+xC9F47J29zE2EP6dFgQcrzuXjaQTR0+yKwMhL5unFe8HdBfdmkpjXbP5pUXw==
x-ms-office365-filtering-correlation-id: ba487b3d-899c-437b-400f-08d679cf7eef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5299; 
x-ms-traffictypediagnostic: AM0PR04MB5299:
x-microsoft-antispam-prvs: <AM0PR04MB5299E77DF20F7AAE7DC21C7E80800@AM0PR04MB5299.eurprd04.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(136003)(396003)(39860400002)(346002)(199004)(189003)(8676002)(256004)(105586002)(71200400001)(39060400002)(106356001)(6512007)(71190400001)(2906002)(5660300001)(6916009)(316002)(54906003)(53936002)(81156014)(81166006)(50226002)(99286004)(68736007)(2351001)(8936002)(6436002)(478600001)(5640700003)(6486002)(86362001)(476003)(575784001)(36756003)(4326008)(26005)(14454004)(44832011)(102836004)(305945005)(2501003)(186003)(25786009)(66066001)(52116002)(386003)(3846002)(6116002)(6506007)(97736004)(7736002)(2616005)(486006)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5299;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bWKXUVHI9YrtZcIYnIThBXBqf0gyXQOzfxVCZjDyXCmp9CVRu0Ov4UkAh+18jt1SAZcS7ZpL0qVugl4otysNacURw1qKOcL9DJ+9e+coWf7ktQfXvBoW+fb+bnFYvIbfsS6+7BLhhomhOblH2CTSRQeYQraOc1xd5CM1kp4eNdi1IN9bIdhny6QrpcBD5FHSUZvsVvkvEbN69eJZIsbRa74lXOY8qPNwUjOTWuDktg9rkVgz7QqylaMXEsdnfA8Gu/9oqa0elfVCxekPtSMGPQhw08o0s6qpKqV8W1pqlV6jYTewksNh/HUKpOzBUXIW9KAgGvuSvxttehfbjQqIm5vn9fXSqvVV6Czaa3us3azoCs8QMl5qqJo2DbcgQYYlrgPzDJ746pmi0bAY82iXpitm2fRiZPUGYyMB6ZensmY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba487b3d-899c-437b-400f-08d679cf7eef
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 03:22:18.2180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5299
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_192229_197939_3053CD10 
X-CRM114-Status: GOOD (  11.29  )
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

Enable basic drivers for imx8qxp booting up support:
SCU firmware, Mailbox(MU), SCU Power Domain/Pinctrl/Clock,
Uart, MMC, FEC.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v1->v2:
 * add more information in commit log
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
