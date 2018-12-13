Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954FAC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:19:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64EDD20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hK+wlRsr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m3RYvhoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EDD20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=99RSpXGiHNKVlHSFOFKjM9cUkGzQ0/kS32pJPa8x1bQ=; b=hK+wlRsrIRMqmi
	2tkkJ++d/AsdPUuCAgXQnW4YoVbOcrkBr1whkWLv0gh5UazlV0C7q+L+VNHZXBgkLpkQsvxApzdgL
	ZOboyEyenhe/FJi7w8mF96jDLbLkfT26bNACyVB8rQoq0w4cQ3sk7/sy+TyrA8gJOH7y88Qq2dtmt
	nVOcJc268OnCoZ+RS3pAj8pfGQAO79bmqkLUGGOUbf2ySfrBR/sSBZckP0BLSWn5iZHNrpD7g7EOB
	C2IhFJWhhD6wcnl8wU2OsMTRxnfA9YrupGWaoa7Un1wdiRXxOO3tomgwOPxZhMzpTezZ2jwZSOZYi
	8v7SwWpFpM/YPbI52D6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQtB-0006Nk-IQ; Thu, 13 Dec 2018 13:18:53 +0000
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQsc-0005kW-3Q
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 13:18:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79Ryls9WoN2uPfg8zdg2z5SwKrCJUkH6KSy1ovwm9kQ=;
 b=m3RYvhoZ+LQQjfyKBNxVrrbgSYINvdMNMMyHcCgodLvUOVhaRTPaXVEsIHEXPsWzWla98KKRbeS3CfQaJKYVTLtlc47xB//QDrBEt0tNzbq48rmzfUwmU3H71lazmUJ3kLexBjVFd/re6AN/F++xKqV5nuT+EIXHdNDVENPxKC4=
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) by
 DB3PR0402MB3692.eurprd04.prod.outlook.com (52.134.65.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 13:17:44 +0000
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb]) by DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb%5]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 13:17:44 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Aisheng
 Dong <aisheng.dong@nxp.com>
Subject: [PATCH 3/3] arm64: Add i.MX8 boot necesarry configs to defconfig
Thread-Topic: [PATCH 3/3] arm64: Add i.MX8 boot necesarry configs to defconfig
Thread-Index: AQHUkuY7xsi/enJXskWRpq5LGMGyIg==
Date: Thu, 13 Dec 2018 13:17:44 +0000
Message-ID: <1544707047-4417-4-git-send-email-abel.vesa@nxp.com>
References: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P192CA0103.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::44) To DB3PR0402MB3658.eurprd04.prod.outlook.com
 (2603:10a6:8:2::28)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB3PR0402MB3692;
 6:owjKpEKlIXGMqCYxTtgVzhNSRxqN0puyEvY2+M5SBC9g93RsmkKN495LKmgnCwH9ypNfYCREavwiaN7a+v/QAfjBX383CXjpw53wWrzC4oklWild71QTkRXbD9MwEKXA8O7N7FInfD7XKg/Paw7uWsn0D/c6jrhOcdFC8QGWiL10WtkVsG6wN9Sk/HgLxiH7Yz/Tunw2qgfIxJDq37Ygeh3TkuEbfW/Gv+1cuQqcX8TxYI09jQWxL4oSqiO0feL07KOxtPpmYm8bm8uZWdW7JZOFReLMqpkT8WNvkc+5fp9jBKSoZEr1oNsC8pO66zKc0MOD//EnG3ZRE2HavCAF2ZSnSJJHTfBrfpkNhGXB/pXmPr4uU3QOqHJBBN94in5E+nI1R4o1pbP53WPw1ss7xrWAW75+DbDi0x/SwGaocBTMwq4xuDsl92Au4D5GLt292eitEzgyfDn+XIHsLCWxqQ==;
 5:HH9mCLWxb+2ifwfW6D+8lUPM+R/tCTg35DlsmvvLtByKv1AhG1ELLr9U8HeXz/djkJAJjM/689s2FeOOlYyxMyx4VcQ0D/9LoRGV16irdLf9efEkG4rSCKeJUHo6P6kCUyZeOjy3Q53o6MwbV0JnC9hakFpHOuGt0o785nqUm+8=;
 7:0JhnQbtCWt+s6lW7L2+2cByc+Z+JcMRTS+5BPlXqBgAuxxAoqrI60eitusng4YvK1ziME3xJeiu4KxlLAMZXjC3CJVJ0tHCxUIU7h/4SDsqMEL/QOsbxgqOfLJC0KEzv4SE13GPnBeMORherqZqQuQ==
x-ms-office365-filtering-correlation-id: 320dbb52-4647-4120-2137-08d660fd5e42
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3692; 
x-ms-traffictypediagnostic: DB3PR0402MB3692:
x-microsoft-antispam-prvs: <DB3PR0402MB3692031EE5F6E09F4B5F294DF6A00@DB3PR0402MB3692.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:DB3PR0402MB3692; BCL:0; PCL:0; RULEID:; SRVR:DB3PR0402MB3692; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(376002)(136003)(39860400002)(396003)(199004)(189003)(81166006)(36756003)(8936002)(486006)(186003)(25786009)(305945005)(2616005)(11346002)(446003)(76176011)(476003)(26005)(2906002)(68736007)(8676002)(81156014)(6486002)(14454004)(386003)(7416002)(478600001)(6436002)(6636002)(5660300001)(6506007)(256004)(6512007)(86362001)(66066001)(106356001)(105586002)(7736002)(54906003)(110136005)(102836004)(316002)(71190400001)(71200400001)(44832011)(52116002)(3846002)(6116002)(53936002)(97736004)(99286004)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3692;
 H:DB3PR0402MB3658.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qyw0JUxUeVhF+3y+16bEMgQ3yyA/NsIWUoeLaaaMyrCQaK8jK4T3GXEvJDJvWBFoqP76K9L5QxwyXkoWR1GDxWk1/w1+sRJT+HC3tsgceC4nY88AlkmwqWLG+FB0j/NdqVReRXIQUFgVfajqU18X2TuqjkJuydaRrRxPoFHSH5bWzm68D2RLleSTY5qkRG+bu6MIMeWTMNNC1HzguQ9NjemqPt/U5XWDazHljKL2k9jVYT6KsR2hn45W7uCDylHl3VeDOS/RIZxUSlXQLwtcdVQ3ZVPnepJ3Ng/VvuF2gSeMX/iIN/8ptKs2x1PNNybM
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320dbb52-4647-4120-2137-08d660fd5e42
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 13:17:44.6770 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3692
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_051818_425975_ED4BE8E6 
X-CRM114-Status: GOOD (  12.89  )
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
Cc: Rob Herring <robh@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Olof Johansson <olof@lixom.net>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The CONFIG_ARCH_MXC will enable all the i.MX8 SoC.
Also add the FEC config for ethernet support, the serial
and the pinctrl for i.MX8MQ.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5c2b1f6..a129e5e 100644
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
@@ -226,6 +227,7 @@ CONFIG_NET_XGENE=y
 CONFIG_ATL1C=m
 CONFIG_MACB=y
 CONFIG_THUNDER_NIC_PF=y
+CONFIG_FEC=y
 CONFIG_HIX5HD2_GMAC=y
 CONFIG_HNS_DSAF=y
 CONFIG_HNS_ENET=y
@@ -300,6 +302,8 @@ CONFIG_SERIAL_MESON_CONSOLE=y
 CONFIG_SERIAL_SAMSUNG=y
 CONFIG_SERIAL_SAMSUNG_CONSOLE=y
 CONFIG_SERIAL_TEGRA=y
+CONFIG_SERIAL_IMX=y
+CONFIG_SERIAL_IMX_CONSOLE=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_MSM=y
 CONFIG_SERIAL_MSM_CONSOLE=y
@@ -346,6 +350,7 @@ CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_MAX77620=y
+CONFIG_PINCTRL_IMX8MQ=y
 CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_PINCTRL_MSM8994=y
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
