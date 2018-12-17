Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237ECC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:01:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D24CF20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jY/cqi21";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S9b6IhmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24CF20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GlrcwuuV/UtvQ+FYUg0K3wFP1HeM5/VblL4VY+abopg=; b=jY/cqi215j8qoI
	FuxUYUYy+Z/bIKAbwep0dxAmllT+F1fUPMJpzouOTTQrOxPQfg4WQu6iFX5KQm4QJq/S2Jrbjjyx8
	ab49BHqDCiwENS2wfFDoOHbqUOX3xeOSeSrLHKmdVL/IrLJ+6WJ7FRpV4Pc0l677jkmwbJVVMBQH0
	Eiq/WOS2w7d4B88vjv/uo9IRa9dYpxWFrojTTvdf3zLl7mPVcphZ0pFhQMIq+EG4IRxoX6zV+7++J
	UWFOYnNGdLf7C/z9CbrXUdT8fMa0u5h+hQE4hOfQLPX9+kkpflF+859X1GKfHIO0adOPo8LzpjasB
	PrXXvm7PVx6i79n02wyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYuP0-00085T-Ce; Mon, 17 Dec 2018 15:01:50 +0000
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYuOU-0007Gc-70
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 15:01:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOu0TuN7F6YNUkwB+8Fa8rl69c3t/QrLjSjeX4nefX4=;
 b=S9b6IhmOiFOaD6a+7WAW4gxllOdGhnzAmlgICzTZm+owFwFQOGaB23SexvzNG7DQ3+1rq0oxuuEzd56+hL6ZxmyrikGnOZsJ41FGpOpC1DrCeXA671uVq/EWQOaCQnc15Z7Nk98YjN8cCGcSA5P2kiiy8u8pJ9+NjZw2wsewouo=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB6211.eurprd04.prod.outlook.com (20.179.34.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Mon, 17 Dec 2018 15:01:05 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 15:01:05 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V5 4/4] defconfig: arm64: add imx8qxp support
Thread-Topic: [PATCH V5 4/4] defconfig: arm64: add imx8qxp support
Thread-Index: AQHUlhlVMNyllvjMOE64/3OESx9jzg==
Date: Mon, 17 Dec 2018 15:01:04 +0000
Message-ID: <1545058517-18643-5-git-send-email-aisheng.dong@nxp.com>
References: <1545058517-18643-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1545058517-18643-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::29) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB6211;
 6:g5paEE8RBMcSmFFrt9vd+YixBhn8F6LVO05Cz0wrbKyPWEJtfas77kR7BBS0tdImKsEBZwH1HPsdgOdRWhOcq0dsei+IEKhD5Uk9NpZBx7xhu3lrsz/cNHRjJXRtwyaucrp4wMtihUGoBNZm3aaCMD3u7xvoPEo/8AGXGYPA89RGg7Hkrz8HaRu8WO/tAexk+M8bZixyH4A8PqqmY49/WYLrPx4Jx1SqvKJFyzV2zZehkJ4+xtE3Up7ZjPv77YVnzrtvLTcM7pLRZCI0qWCwiv/D3wc8/up/vM0ePmiMkinuWiIRk/3U+UpXVVHuYqIdrUnsr4NqewhNRFJM/C5oS6v48758XoG+dnpedkRjW7o3OehC24WB3fcYVef8s/9hQ7S8WcFOjXO+ekmCIvoWJpA2QiBCTGW280otd2R2chqMDmgilLkk+P1gOJptbTm2IoD7NZGwMZV798/ZSGqAqg==;
 5:cttxAxwFqavx/eXTX3oJG0j15DBaobOK4QRwYFJ7QRI2EaSalPFfb8B1Do7OlAtuehu8PfTPEQeHYCR9HYWrGUhRHbGgAjvHeI6Sc66CfTLcCYmtESFSgkEHrpynvBwkB2N1rCXwhNtvbzRSfN4ru7ZpuF9Ud1jtvVnkFuTDVrc=;
 7:1qqQDuxTDpx0GteRYtVJOD9EveZkwgGZXgv5BAkIv1hDWnz7949NmJOUCxATMESpaQcE17IjT4WUUyld6WDZl8bvY3hqLQY+ud21xBUZ8OpYjA+6e+5RDlUqxwPAS/nOSw1OVvNVm+yB8ur8EBEJBA==
x-ms-office365-filtering-correlation-id: 8b6fc272-b283-473a-ab87-08d66430776d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB6211; 
x-ms-traffictypediagnostic: AM0PR04MB6211:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-microsoft-antispam-prvs: <AM0PR04MB6211858C12B1CD1DAF0E885B80BC0@AM0PR04MB6211.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB6211; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB6211; 
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(346002)(366004)(376002)(136003)(199004)(189003)(54906003)(44832011)(486006)(6436002)(476003)(2616005)(66066001)(11346002)(446003)(8676002)(81156014)(81166006)(76176011)(7736002)(99286004)(186003)(102836004)(386003)(26005)(6506007)(2351001)(6116002)(256004)(2501003)(6916009)(36756003)(53936002)(4326008)(305945005)(106356001)(52116002)(105586002)(39060400002)(3846002)(97736004)(71190400001)(71200400001)(14454004)(6512007)(8936002)(50226002)(68736007)(5660300001)(478600001)(2906002)(316002)(6486002)(86362001)(5640700003)(25786009)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB6211;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: crS324iMuMTh+zynsaiaxrCvlvnjuK4fIkjKsyMgVZDGv6hX5O0OL6fAGtcHkCTj80sWiLxLIJILRT56iBgs0h+0eZxT9r/KR0N0REywCGMG07iUQ2b5f1c5j0p++QPBCYfXbgF3i1VVtVzVMTKen8/Pgi33xjMyooWchJojjHrSf6uisgNegihheC+yyosHDS3lKoZxvrNvTgwegGsSC9IQolnohEbGxvNbDbcrJO3QeA67/QtvgaB+b3Sxst5ZboVxe/Dd05sX8PfJH67ykZLYKqlc/GPQtSq43RT8phf9IBGAZfas1PunvWkTxf82
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6fc272-b283-473a-ab87-08d66430776d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 15:01:04.9387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6211
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_070118_720373_8C7774DF 
X-CRM114-Status: GOOD (  11.78  )
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
v4->v5:
 * remove SOC_IMX8QXP
 * add more neccesary configs which was selected by SOC_IMX8QXP
v1->v4:
 * no changes
---
 arch/arm64/configs/defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9a57d1..48a8dec 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -45,6 +45,7 @@ CONFIG_ARCH_HISI=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_MESON=y
 CONFIG_ARCH_MVEBU=y
+CONFIG_ARCH_MXC=y
 CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_ARCH_SEATTLE=y
@@ -119,6 +120,8 @@ CONFIG_ARM_BIG_LITTLE_CPUFREQ=y
 CONFIG_ARM_SCPI_CPUFREQ=y
 CONFIG_ARM_TEGRA186_CPUFREQ=y
 CONFIG_TI_SCI_PROTOCOL=y
+CONFIG_IMX_SCU=y
+CONFIG_IMX_SCU_PD=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -226,6 +229,7 @@ CONFIG_NET_XGENE=y
 CONFIG_ATL1C=m
 CONFIG_MACB=y
 CONFIG_THUNDER_NIC_PF=y
+CONFIG_FEC=y
 CONFIG_HIX5HD2_GMAC=y
 CONFIG_HNS_DSAF=y
 CONFIG_HNS_ENET=y
@@ -305,6 +309,8 @@ CONFIG_SERIAL_MSM=y
 CONFIG_SERIAL_MSM_CONSOLE=y
 CONFIG_SERIAL_XILINX_PS_UART=y
 CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
+CONFIG_SERIAL_FSL_LPUART=y
+CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
 CONFIG_SERIAL_MVEBU_UART=y
 CONFIG_SERIAL_DEV_BUS=y
 CONFIG_VIRTIO_CONSOLE=y
@@ -344,6 +350,7 @@ CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_MAX77620=y
+CONFIG_PINCTRL_IMX8QXP=y
 CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_PINCTRL_MSM8994=y
@@ -529,6 +536,7 @@ CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_OF_ARASAN=y
 CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_MMC_SDHCI_CADENCE=y
+CONFIG_MMC_SDHCI_ESDHC_IMX=y
 CONFIG_MMC_SDHCI_TEGRA=y
 CONFIG_MMC_SDHCI_F_SDH30=y
 CONFIG_MMC_MESON_GX=y
@@ -593,6 +601,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_CLK_QORIQ=y
 CONFIG_COMMON_CLK_PWM=y
+CONFIG_CLK_IMX8QXP=y
 CONFIG_TI_SCI_CLK=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_CLK_SMD_RPM=y
@@ -603,6 +612,7 @@ CONFIG_MSM_MMCC_8996=y
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
