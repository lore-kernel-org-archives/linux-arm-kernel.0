Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B89FC10F02
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:54:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5E6217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ciJUbK0u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZJMnpU9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5E6217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kjKKtqan36D+Jeb6MiT3Na3uiLvRQqlsao+OP2J7XI0=; b=ciJUbK0ubEJw9s
	aI3nFOn14YVq9nSnjKib1al2PH2Dh2aFIH1BUVclqecvdLzKR6Z/pAoPXzV58aeIi4U/lt2J+Nj1h
	P7+qjHZ24gt+lbWzDaEpQRFpEKhws35+C1ZQm//rTlQr7P6nSyIHFLTytu9d2vlrncDyf0ySkC2O9
	9Jp65OHZCRPRmzYoiK1YAEy8wQE9pRAkLvzRGONVf0o1Wm0iMLRsFXRTK4Dxb9DCtxx6IXEBy4fOY
	aRzWU5tiTdhNpe6vwtEqUp2U/4eCBustbynbK8Eo68trdwT1trRz0DciLU4MXS5B1NrweXOvoVrqD
	BFwCQ9DZRo75BdkYLPCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvcp6-0002sM-8i; Mon, 18 Feb 2019 06:54:40 +0000
Received: from mail-eopbgr20066.outbound.protection.outlook.com ([40.107.2.66]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvcoj-0002KP-Eo
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 06:54:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiGaM5YKyHD5ZZNwpj8ttfuA8x55jKBMPFvp8LNvpag=;
 b=ZJMnpU9QQn21/vHW0bnybAPOxInd0T7LdshYA3mRH2vk8anmPNMc4QtPhWny2G1O9cJI/Zr1LxxSH+G8wU6gNsQTV/LekaWLIkAFMgdyu5j6mvngoMG3a0TOE0H3rLS3Ufaf6Z2qaYOspiEg3NdL9YOfEDZVok3gCC+3dtMOYCQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3738.eurprd04.prod.outlook.com (52.134.70.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 06:54:08 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Mon, 18 Feb 2019
 06:54:08 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
 "linux@roeck-us.net" <linux@roeck-us.net>, Aisheng Dong
 <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, Andy Gross <andy.gross@linaro.org>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, "heiko@sntech.de"
 <heiko@sntech.de>, "arnd@arndb.de" <arnd@arndb.de>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>, "olof@lixom.net"
 <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-watchdog@vger.kernel.org"
 <linux-watchdog@vger.kernel.org>
Subject: [PATCH RESEND V2 3/4] arm64: defconfig: add support for i.MX system
 controller watchdog
Thread-Topic: [PATCH RESEND V2 3/4] arm64: defconfig: add support for i.MX
 system controller watchdog
Thread-Index: AQHUx1a+KT/Wtwg6NEWBUGDR51bseg==
Date: Mon, 18 Feb 2019 06:54:07 +0000
Message-ID: <1550472539-16590-4-git-send-email-Anson.Huang@nxp.com>
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:202:16::17) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f40e9ed-3c5d-4c31-5a6c-08d6956de0bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3738; 
x-ms-traffictypediagnostic: DB3PR0402MB3738:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3738;
 23:cHjR7UPxT9D8dzwatvXShhzF3uCzhlOnRdqmI?=
 =?iso-8859-1?Q?5rR+WX5139DKQVxJMnIletw17sX/dHNVsu3Y6yXhoguQmU9gbEJr+N3U0f?=
 =?iso-8859-1?Q?/56TLZXvOUNTE0+zZujiYH1DCdEU1Kz4bPpvKsDyoI1SrsbomDlvOCykWF?=
 =?iso-8859-1?Q?MZ3bpZSsi40oQOl+RuzzrEKI5H5HLH4Ve2/ZUcSzCLgsNoGXV+uRn/5CLn?=
 =?iso-8859-1?Q?Ot/911KJqZfxZZvVqNGQbZYFlfpNvzFyJseUNrBBp47+teGmYndVcCX5g8?=
 =?iso-8859-1?Q?d+lAk4Axqko4PCxg8KpEF5PMiloGY5jsK3VEYe8OklFu6BW7O9rfq1g1bI?=
 =?iso-8859-1?Q?fwETqsP3iYJ1E/4EucKQb50ZOmEugbIa1L4uA9VFACVh17eO0uqcDIB0vj?=
 =?iso-8859-1?Q?hX7zLo76rQYFbaOsTtBwfATtmBod7mfjETMjTjc4LFyaUgiBX9yx5JApLU?=
 =?iso-8859-1?Q?eP1PxBrY4ktE9eQqx0cur4XN0HD2nu9CWouYDiZ08ITePHnLhxHSmEoHQ1?=
 =?iso-8859-1?Q?6R53/iDqPBZYgXYaU4c0mrOYDSPILzYFkUtlr+B+q3DCm62vd54BzXzM/q?=
 =?iso-8859-1?Q?KmvgWZmIb1/u2WO7+ow25MkyFDMtiaVLn57H0o0ANOgvL4Q6qE3OVLEFRK?=
 =?iso-8859-1?Q?xSoBTuztnNVNTTi3L5TX/rHu1gvB3IM2VlY7tKLF4VCo8mS60D+aMEhyFF?=
 =?iso-8859-1?Q?jGb9AKM6uWlhpRSpr9Q05LycU/vCc28lYtsHZrjAT02swIbjoWDYXXFxUN?=
 =?iso-8859-1?Q?6BI47C3vcMXyIDaEd+9j3NQ1wqLZbcL3LgC+UY9bnMZY0A5y7CBR7+1PpE?=
 =?iso-8859-1?Q?48sfswd931EKHFZgjRsGYtqkDIfIM9O48+yAJsDhvFOS7rpUY2IwWGPwi9?=
 =?iso-8859-1?Q?/5T2WfgaTqq++RWbK/X+RtyGY9EJWycOFeLa4r7TqUB7B4NHQUrnXMS2v7?=
 =?iso-8859-1?Q?FpAVXLXndatj+5FrUDH21Mi+Hkn+hKNFFjqYjsaZAthd8vD6JQH4KzQbXh?=
 =?iso-8859-1?Q?cNb3suLMFCwCnnkjjfpk3uH9rc4slDJQOxoqFfnM7GKDNX2yXCbmVelyRR?=
 =?iso-8859-1?Q?coHpufuzr8RV4OBP7En99hn4C6u6YUoEYfPPZmNM1qm5jSAkup8ACh93N0?=
 =?iso-8859-1?Q?dhfBowO5LH9kn/Btl6M7PMUnO0wWTEjuRom7K0ejjXZ+Zk3WUKrVsLGgGn?=
 =?iso-8859-1?Q?yb5ezTFcULvCntIALGxqpKg3lhWfcn370qaIlO1DSlZOjRzCXmWJzLUige?=
 =?iso-8859-1?Q?Uxk0diOrmGeN1IXtPvEsJKrhChDSjRnd7DEsUca0p9q1oGKOH625i0+Es8?=
 =?iso-8859-1?Q?Jcf/BBrSHoKy8Kdq2QQCPZpcisjtGTMoAP3V0ASKB5EvCnA=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB37382ED7AC9670EA63085356F5630@DB3PR0402MB3738.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(97736004)(86362001)(5660300002)(71200400001)(71190400001)(36756003)(106356001)(66066001)(50226002)(4326008)(105586002)(76176011)(53936002)(99286004)(476003)(110136005)(81166006)(81156014)(4744005)(6506007)(8936002)(25786009)(6486002)(386003)(6512007)(2616005)(256004)(6436002)(316002)(486006)(102836004)(6116002)(446003)(3846002)(11346002)(7416002)(2906002)(7736002)(478600001)(14454004)(68736007)(2501003)(26005)(2201001)(217873002)(52116002)(186003)(305945005)(8676002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3738;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w9jo/3q7lWbJhE0U8czDCgPijHLt4ALCY77InPwR3qqVyH1Io9cjphbC98MAal9NilMwJ+VAl7zZuzulpd0fjj6iiBlUKNf9j1TXvr/xNX23Snz+qPn78tgvKJ11rytCX+lqh76cDe5smUa4NS1JdA5Xi9AsXXEiAlPPLXbR12/uAbuTyN6O+D3kpknuWMDOW8/WM92Lnc9T1nGOjFasedWwRo3AKzSKVtnc3LKggp2aJg7VVsnklRixuA2bIra5WlKdVbbFusJWO2DV6vhd166Dk/eeMeowrizqNLDFEUOnj4CNwyl6xDgrJ5GVZpv/N2P1Sy77K2bPQiDWW5gLVrw2hDMNrW5VsuVQCHRbzNHfBsic02rAeuRjBpwzfHa+OrjspMY71+39Ct4Tg4ohVLiIQ6oZtfRA+TiyLTpo1SU=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f40e9ed-3c5d-4c31-5a6c-08d6956de0bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 06:53:58.4428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3738
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_225417_611301_9AFBF386 
X-CRM114-Status: GOOD (  10.47  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable CONFIG_IMX_SC_WDT as module to support i.MX system
controller watchdog.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c390..690f4ba 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -427,6 +427,7 @@ CONFIG_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
 CONFIG_IMX2_WDT=y
+CONFIG_IMX_SC_WDT=m
 CONFIG_MESON_GXBB_WATCHDOG=m
 CONFIG_MESON_WATCHDOG=m
 CONFIG_RENESAS_WDT=y
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
