Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862EBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:45:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A2620859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u5839xQj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IOTUfqLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A2620859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zbnwC4i8xJMkqWwIsXvD46NV96+80BlfF7pX40rBlck=; b=u5839xQjYSaieq
	BiOUjZmLZCas9SIcqY+CJSuabfPQRpKqtkf0OOstIRsOyHLWAacYa70lhyHDp/9gAit/sncNFLr3n
	mgXYQoH3SeUTvXYOE5o/kY1QYJQRjhakPpCuOK2CHFxhswXXO8rFbl6TdQ24NR4usb3S02oVqGDWS
	lPzxnB6TJCJwzHePxRhnEFlcz7Ea76sr0152SBS5Ey8yV/uBUJcXjuMx2ZaqNr3ecl6o54D9wdhlZ
	Hc3vsdqbZgKu/p/cAP8+n+lIl3OGHahc2VEy9NgNmdAoBOnmvb8GcPbr2thDp+877aB7IRBxoUePO
	1iJX7lnxeiD5KVJXBvQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjewz-0007Vt-Qo; Wed, 16 Jan 2019 06:45:21 +0000
Received: from mail-db3eur04on0630.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::630]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjeww-0007VR-Jw
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 06:45:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5EFrSI6jX6xbi0YggkwfxLVpW8YV62Kc5ZoGRYrM/E=;
 b=IOTUfqLFusxaqvTN81iHbnfOsVRLKZfIY+Y4/cEeAcyY4jKZEkhF9dPFUNoxbALAxnOZyoo+G9jRTVJJBLleBotowhvF/tsaZeadqqDX6WH2Aoz93wOiFhVs8CiMhBudq1Gu1wdvlXiYnukHmTdJIqYFmBAV2OQIgkzf/1J//oI=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB6002.eurprd04.prod.outlook.com (20.178.114.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Wed, 16 Jan 2019 06:45:13 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 06:45:13 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Abel Vesa <abel.vesa@nxp.com>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann
 <arnd@arndb.de>
Subject: RE: [RESEND] arm64: defconfig: Add i.MX8MQ boot necessary configs
Thread-Topic: [RESEND] arm64: defconfig: Add i.MX8MQ boot necessary configs
Thread-Index: AQHUql41bLWLh57rrUukHyLcrmJCyaWxeH5w
Date: Wed, 16 Jan 2019 06:45:13 +0000
Message-ID: <AM0PR04MB42115A85AE100A1B35E25C4E80820@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547287458-12693-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1547287458-12693-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB6002;
 6:FYiU5uV6xWgp/OEEmTym8qgEjTfdnqnUFmEeG+zzhYtAe32JHj0oQaS9UiLGrat4FbopGfV7NcSo/Unwxh49ht0kM6tkSlBUS6afPW5orSTJ3e53V6aPejpnfqNnbc9Ra7bExhtPglO29JfiGUrIKQnZXYUpZsR9TDRvsAnEx8Mf+BTbOtyup/2nAA+ucaDVVzhdDW5JSLSaHTemCLepPUc38L5x+D5XbShpSwYjoMBcfILs7unQ2hR2a8N0waViP4x7Ss2SrvG9rSxZKyda7WtRNMkFluzHDCQERpgi6uiJZTlmKRe79h1gs8spqPwvXcK+fLM7cMxKKlD0DbKPvRe0Vx148NIhVmEP7FqquTA56I223xUTW8lcVZ40+u3QPAOIRdyTbXyefhBlmmqP9lvaLfe9aAwcsVwOS8CUC2OKOUyODcM3ET7UxbuP94+bKMnI9eX1dwQq00dqQBG5rw==;
 5:Uum/Ts7o7pKpU0MgBF5hyVJ9KgpvJVY1+TBiToSOqjuh/+4yDR23flkf8BlutkzaHSFvpvBnehMbf9bPFEbsLg040qbbEhZ7t2kXbuoSJBywosgjzlbFhHM+cfoT1rgI6eJxs8uAr9YKiM+t5shJ+QmRuzlnFMChKmZDDlR5hP7UwhlYZawi5rk2BC/g1vMidPYSS7a1NxYNgHbjzNtVLg==;
 7:WxQxgMGHGtk4xf7Jt6NLbal/wGs/I0vZA6sBuFAKG4m/ku67Ee2ooZCDQ6mmpx7VDn6H0VFFFZ3h9fYgIiy74Gkk/6hmLdFQv24zdtLA6i+N60cpWLOtuXZoGkKLm2RTK7vGZr+9C7KjB+XkMcG1Cw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0c49df9e-9c1b-46ee-64aa-08d67b7e2b0e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB6002; 
x-ms-traffictypediagnostic: AM0PR04MB6002:
x-microsoft-antispam-prvs: <AM0PR04MB6002132680B97E7E3608980F80820@AM0PR04MB6002.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(376002)(136003)(346002)(39860400002)(189003)(199004)(13464003)(26005)(305945005)(99286004)(6246003)(3846002)(74316002)(105586002)(106356001)(6116002)(7736002)(4326008)(11346002)(6436002)(446003)(66066001)(25786009)(68736007)(55016002)(476003)(186003)(256004)(229853002)(81166006)(316002)(110136005)(54906003)(81156014)(9686003)(44832011)(14454004)(2501003)(486006)(33656002)(97736004)(71190400001)(71200400001)(478600001)(5660300001)(2906002)(53546011)(6506007)(102836004)(86362001)(8676002)(7696005)(53936002)(8936002)(76176011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB6002;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QbfvlLrjxkNzzvVzgCQYtZHJ2K5FNOhaARxaPxuv4Oq/jKtBfdT8MILpiIpxasE/CwqjPkW4BgxqDNwiZS1XH1pGuDUXUUyKo2rejec1Jhcs6udB6Dzkyb9fkUiahyWsRgNJPQvCXus+y84ZEDUgZcXK0H1hADvBJeX0mtX2l7lKBiNm7xAMpIVQAZXprD2Essyf3uJ0wqyp7Ltti+NDVM/GIruP+bEq3h9BQJckHHfBbrUOGMvLdf6IrctjoYsucbYpydH+hdb+oEa5cjUhN5gyTXHkL1VVPGUdSAJDHztIu6poQ3tFOI4q5uxbyIHj2iGgwpBT4k0zE94dGcdLnZanl+f6eWs9nBVtoKJ3r6YQpEi7RU7HDV/iJ+IeDsY743B5uj0xYT2BtRCISHTh4y/bNbHM1WSI+02bpkG7xuw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c49df9e-9c1b-46ee-64aa-08d67b7e2b0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 06:45:13.6592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6002
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_224518_724944_2D09C1C3 
X-CRM114-Status: GOOD (  14.33  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Abel,

> -----Original Message-----
> From: Abel Vesa
> Sent: Saturday, January 12, 2019 6:05 PM
> Subject: [RESEND] arm64: defconfig: Add i.MX8MQ boot necessary configs
> 
> Enable all the i.MX8MQ configs necessary to boot.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Would you rebase and resend with GPCV2 support added?

Regards
Dong Aisheng

> ---
>  arch/arm64/configs/defconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0478ef9..e1d875a 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -43,6 +43,7 @@ CONFIG_ARCH_HISI=y
>  CONFIG_ARCH_MEDIATEK=y
>  CONFIG_ARCH_MESON=y
>  CONFIG_ARCH_MVEBU=y
> +CONFIG_ARCH_MXC=y
>  CONFIG_ARCH_QCOM=y
>  CONFIG_ARCH_RENESAS=y
>  CONFIG_ARCH_R8A774A1=y
> @@ -245,6 +246,7 @@ CONFIG_NET_XGENE=y
>  CONFIG_ATL1C=m
>  CONFIG_MACB=y
>  CONFIG_THUNDER_NIC_PF=y
> +CONFIG_FEC=y
>  CONFIG_HIX5HD2_GMAC=y
>  CONFIG_HNS_DSAF=y
>  CONFIG_HNS_ENET=y
> @@ -319,6 +321,8 @@ CONFIG_SERIAL_MESON_CONSOLE=y
> CONFIG_SERIAL_SAMSUNG=y  CONFIG_SERIAL_SAMSUNG_CONSOLE=y
> CONFIG_SERIAL_TEGRA=y
> +CONFIG_SERIAL_IMX=y
> +CONFIG_SERIAL_IMX_CONSOLE=y
>  CONFIG_SERIAL_SH_SCI=y
>  CONFIG_SERIAL_MSM=y
>  CONFIG_SERIAL_MSM_CONSOLE=y
> @@ -365,6 +369,7 @@ CONFIG_SPI_SPIDEV=m
>  CONFIG_SPMI=y
>  CONFIG_PINCTRL_SINGLE=y
>  CONFIG_PINCTRL_MAX77620=y
> +CONFIG_PINCTRL_IMX8MQ=y
>  CONFIG_PINCTRL_IPQ8074=y
>  CONFIG_PINCTRL_MSM8916=y
>  CONFIG_PINCTRL_MSM8994=y
> @@ -617,6 +622,7 @@ CONFIG_COMMON_CLK_RK808=y
> CONFIG_COMMON_CLK_SCPI=y  CONFIG_COMMON_CLK_CS2000_CP=y
> CONFIG_COMMON_CLK_S2MPS11=y
> +CONFIG_CLK_IMX8MQ=y
>  CONFIG_CLK_QORIQ=y
>  CONFIG_COMMON_CLK_PWM=y
>  CONFIG_TI_SCI_CLK=y
> --
> 2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
