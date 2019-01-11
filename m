Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBC0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:38:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA1521783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FDq8y9KZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vqwHHqjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA1521783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=opuAx1W9SrVKfv/YQxNTgbUT3xntSPFk3Z9RvTqhbw4=; b=FDq8y9KZ9+86GZ
	BDczSxSEYfXRqoYB0hn6YeR8Ty33PHvEHX7EDmMkQvVDXS/1qMSbt851NcJzSaAaw+k3lJRgaTWol
	nXiflPmwXdtr9dcCIDruEPnFe6zPH4WyUNv/SAV8FVi/yCVkC84fOgIXZMkBiRRNXOxFzbs7mRX7N
	gHgSLWTtNtQDBXoJrPC4ZMunVrfgLqbpiLKj9e0YdFgKW3S8/zqaHv2ddg03YtrY2gj2Ug5HtvCCP
	yUTlU26T/KUOzwXd3INJSwKOkqCrgiKu4a6xGUprvzj8A20MJdnP/HBinx5HpF/WBJZYQgBE2+Fky
	qhVQfeENwVvplqFt+3Ug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghv9A-0004Dj-K4; Fri, 11 Jan 2019 11:38:44 +0000
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghv8S-00037D-VY
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 11:38:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEZyR3RQDEVD+9+hXCTOQ6cZVALD8oO2leJeNUdjP58=;
 b=vqwHHqjL28fC1fGdYKpYOQed4addpEKS3YEdii0ruJxLpSGQW5pSqYsTmVe7VDiRq6ZlpZIXeM4luwSxVkTKRhqT3HZABR9NzC0Gdw1suJ+RspxvF4uO5JtCi8W/cXK7VDme5EVNqDImMqx8E6RcQ91vaRUkEGxRyqQZ6tLXpMM=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5251.eurprd04.prod.outlook.com (20.177.42.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Fri, 11 Jan 2019 11:37:37 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 11:37:37 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V6 4/4] defconfig: arm64: add imx8qxp support
Thread-Topic: [PATCH V6 4/4] defconfig: arm64: add imx8qxp support
Thread-Index: AQHUqaINQb4f2cB3o0SMLCWYwIJ5AA==
Date: Fri, 11 Jan 2019 11:37:37 +0000
Message-ID: <1547206279-26169-5-git-send-email-aisheng.dong@nxp.com>
References: <1547206279-26169-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1547206279-26169-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0085.apcprd04.prod.outlook.com
 (2603:1096:202:15::29) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5251;
 6:yO8qLe2t1Wu5YTenhDZKTSWdzilGAgcdLY1ZDfqTf4VsAZC+GUSQfaXdKmC5YncGm3SRsjQkzGZ3JTEb/UNLOKL8pZXJweMIWKKgdU4/CdUsj0J8QDHu8Uzw/A2ex3G+2HWkfB3BpMFzwUWvuZ98E0IhAYfk6xKqy4ED0nHe8J9rsyuSDI/4HCu/fIvJTKN1fsOV9Js/MXGwr5+P8w06PWjqNllhkzCm9NqY97i+MHtowxOe6sRwY39z6gHEYSQ+ysB13zO/pzMCqb71+W/2mcGMf3GUGwBSlPiEgfnn5NW057DrHeP4IKgw8XA2+I9fyXI25hHnPiplb7zbu9wEp8+K9oHKQJjg0z38mHjCIhPTAprQskTvx/h2RomjdIMvRMy0aEEjWkyx2t1O1QKtS+fZlAWgZI6xzWB/VK2ehOItPmfgb1v99bMbaRPPINxUrw+OdFs0SfDl9GGv1CxQlw==;
 5:g7Y7HgFRWW4AwoZUQ134Afdn/IJLXuPK+vJgIIXryvYDAv3fpRFY5R4SqlEt86msey4NTek0HLmMGxgVgnE1tc+hZoqvGL/IbbGkYr48dP0E2acxET9sqECf6WpNsRh8Rz/pfgbLtZDAIRsTyN/o3eH3qq54yW1GPjyx8U5uN2Z+X7Jf0GUPdFWuXC9JlHMdMGodTVEtcKcQAJpup2D0cA==;
 7:tt72XmIj89t29xinXeDQTT5IEibw74fwFqzQUVKxUKl9p1nQLumpkw9JTMvzxZ1LuGVOa2sZlO7yaZNt8FJTrC5s5Ej8kFAqWfZfP6N9f1BX0W5sH9vdldRRUnm89ZDl9EB51RdGzGUyLe450gl90g==
x-ms-office365-filtering-correlation-id: 8ec01da3-27b8-476e-eff7-08d677b92fb0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5251; 
x-ms-traffictypediagnostic: AM0PR04MB5251:
x-microsoft-antispam-prvs: <AM0PR04MB5251638FF4E6C89EBA17337680850@AM0PR04MB5251.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(346002)(396003)(376002)(39860400002)(199004)(189003)(99286004)(68736007)(476003)(4326008)(105586002)(81166006)(81156014)(2351001)(2501003)(36756003)(8936002)(256004)(39060400002)(71190400001)(50226002)(6486002)(106356001)(71200400001)(86362001)(14454004)(305945005)(54906003)(575784001)(478600001)(7736002)(316002)(102836004)(6512007)(486006)(6506007)(386003)(446003)(6116002)(3846002)(52116002)(66066001)(76176011)(8676002)(26005)(53936002)(5660300001)(44832011)(186003)(6916009)(6436002)(2906002)(11346002)(2616005)(5640700003)(97736004)(25786009)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5251;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R0RQpzTx3dULpZLNLOn0S3FBTDec3TNLMatgbwFWtRISGhru+WGmYvB09jarWuQgE1lqNersoJn/300wEC1HtueISFWVGpzV7UnHzEG9ygqEuyDRkPwTqcga+H2k8UC4TnSVLL4U1rOtIoqdJW0CgJibMcFtabh0X0DpaSWG7eYfVglamRjt8e2V6Rkyj0zgskIo+fIZhIYUwD1gG0bXT2s1HB0/iCSK4fJS9WNk/7fd5mMFeY9TmicXzlqp2bFk6YSnw3i55iI/Ed0N5z/qwTfs4QU5JkgdGw7PHqww5WB0F2PMY8FQN5mUWRCqMmfRvgik1f8zQyNz4xxaEDCV4/xYFXKR7p1xvRSou/CapmFNTleT7Q+JVlq4QdkNMpHFPoCBQL5MRwOWipgvgbCmr1pKn/mfr0121e13sPS9Jco=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec01da3-27b8-476e-eff7-08d677b92fb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 11:37:33.9941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5251
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_033801_732469_D7A748BA 
X-CRM114-Status: GOOD (  12.10  )
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
