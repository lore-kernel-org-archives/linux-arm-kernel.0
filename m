Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39EFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:39:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF8720675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mxZbCg6r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="v2sPYRn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF8720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NyV/b1OWM0KR5Z8LwdHtGZ5j2DgYtsuWIrWC1r37FIw=; b=mxZbCg6rroS1HY
	5v0dS3W0ouOP6QF7n6NSfZGuq43IAL1xR1LAxqHJPsOh6q63Hz6HhOQkBkxv9R3aiWC/eMBHo0rUl
	gl3AmSGCMwnXyCKM0TphzJS2Dp7ZkTkR4dq1MCx/ru4wdFKQQUYC0HxqmZKXNQagKg9diiA0PzeEt
	kcdWv3/V7z9a8kjb3yE3VyTDp7dQpNJfAMOXUom/El2iJLuwl+m0aVtfjHCfmKWNfXgthmCLvm4+R
	hB0HLED494AQDT/PkXEDCZEaV3qU5rqsceryJH31yn11UvUad18FUVP5Y2Tj+0Q/UWn03Z4HL02n1
	nrrWo0bJgiWgYWFmiPdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwi0o-0008S8-0K; Thu, 21 Feb 2019 06:39:14 +0000
Received: from mail-am5eur03on0601.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::601]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwi0S-00080o-Ig
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 06:38:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jK0792C1pJU6XghGsPQVntLzuXdgz0/ZqsnOMV/Z6xo=;
 b=v2sPYRn+jH6ykCh91gn9YU5c/QL6c1pLsoSgOZwfpoGSmFTLQA/EHolmguVM3CiCIy3BHQF2WFVa/ZdkW6W0QQCX1la48Mt8JaKpwQDB5ydAigATcbWxS8hqGYFIHZiN5E42bgycK7U3XmMsGi4DtEnlp0fXq/chvNw09L6xdjg=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3734.eurprd04.prod.outlook.com (52.133.29.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Thu, 21 Feb 2019 06:38:48 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1%4]) with mapi id 15.20.1622.018; Thu, 21 Feb 2019
 06:38:48 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
 "edubezval@gmail.com" <edubezval@gmail.com>, "daniel.lezcano@linaro.org"
 <daniel.lezcano@linaro.org>, Aisheng Dong <aisheng.dong@nxp.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "sboyd@kernel.org"
 <sboyd@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, Andy Gross
 <andy.gross@linaro.org>, "horms+renesas@verge.net.au"
 <horms+renesas@verge.net.au>, "heiko@sntech.de" <heiko@sntech.de>,
 "arnd@arndb.de" <arnd@arndb.de>, "maxime.ripard@bootlin.com"
 <maxime.ripard@bootlin.com>, "bjorn.andersson@linaro.org"
 <bjorn.andersson@linaro.org>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "enric.balletbo@collabora.com"
 <enric.balletbo@collabora.com>, "marc.w.gonzalez@free.fr"
 <marc.w.gonzalez@free.fr>, "olof@lixom.net" <olof@lixom.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>
Subject: [PATCH V8 3/4] defconfig: arm64: add i.MX system controller thermal
 support
Thread-Topic: [PATCH V8 3/4] defconfig: arm64: add i.MX system controller
 thermal support
Thread-Index: AQHUybAZacUv2up9EkynheNHIDhcqA==
Date: Thu, 21 Feb 2019 06:38:48 +0000
Message-ID: <1550730831-14995-3-git-send-email-Anson.Huang@nxp.com>
References: <1550730831-14995-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550730831-14995-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0069.apcprd03.prod.outlook.com
 (2603:1096:203:52::33) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ebc525f-ebcb-4517-f9ac-08d697c73bde
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3734; 
x-ms-traffictypediagnostic: AM6PR0402MB3734:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; AM6PR0402MB3734;
 23:KTaeBNzrdQVxAM56R3h5NqDzgTbiK5L2HDmep?=
 =?iso-8859-1?Q?jTeWHBBPHWeex+gblof3iHDOsAy3YDC1EDYmo8NgBTsyXpzdkODiMhHy9l?=
 =?iso-8859-1?Q?Gyo1cELdWur6cVbjViOl8/8zmUcZiZFlUcAayjA79qvH81rMOT4/WOXHb2?=
 =?iso-8859-1?Q?w7rK/J5yC+5ypg1GSNQdeTwLdLF/3fZoJHml48k/w9zwMQ7KcJ52h9Phjt?=
 =?iso-8859-1?Q?IVVpqBkxm61NzE/R3PmvGl/VqE0TYhGc2pHMs803jvCAynX+oKs5vgX45e?=
 =?iso-8859-1?Q?zkiFRhoQO/b2whG9VYrTkgYERf9mgskLE3pAPAVWDhZ+hRWiTieLC0Wsi+?=
 =?iso-8859-1?Q?oR6S30oKPKolOaADTlrks/mPPUNULRFuOrm/A3ZaCqCbsBNVrZNVUaicbF?=
 =?iso-8859-1?Q?lRw2+yjndauhxpgvKvoQtRh3Tmz5eOm1lJU8mZixeLSOIUlDaVp22SKNMO?=
 =?iso-8859-1?Q?bvDPWzcjgOabs5ijjozw6w44NBPHd8ch1YoLOGY973U7q7XdWxCn7GvAs8?=
 =?iso-8859-1?Q?m0TBUrDuVD+qRFtVFlYFP6AnHkgcIqXGWUKxewHui9lFGOLhHG6WLPHtXr?=
 =?iso-8859-1?Q?u2/mP/Hm7L0N0R4Y4P6j5WLph/uNvo07c9khIMHSCyYgiGrs4JapWTHm2b?=
 =?iso-8859-1?Q?zsYy/c7n+bd02n7GuCeMU0sOVPekFavOaPCpdiszCJqqHu2fp0vjAnfcRz?=
 =?iso-8859-1?Q?tM/kto+eFHBgy0a6Cu70U+GR/Q/7oNlInM9FPfx0JLAnJc9InHw5VBRsZj?=
 =?iso-8859-1?Q?E7VvumS4K+4wlT8q1TeMo3QZvdt6OJAnNmvzVcIKjM6LrVTQ6Jq+C4Be4w?=
 =?iso-8859-1?Q?c0feHPHUR2yCqG/U8K02ju4fK6tw2Lw599veW0KoZX85Xfq5J0hg87HKLu?=
 =?iso-8859-1?Q?Tw9ak18cx7iW52Gj6Ubkvw3jpTlqUTikbgDx/wLPLL90ByFd6RLwVcBMM2?=
 =?iso-8859-1?Q?CkMfw+Tl3BgY0iqw7pDUiDI+rCiiiW5uWquPZf6R8s7qIvG66ksPftVvnP?=
 =?iso-8859-1?Q?c+XZ/rpkLumQ6YI5ujkdhEuR4qjhsrPKLk9375Pr4i5/mf2f7rP/UZvkHc?=
 =?iso-8859-1?Q?/2yohaoxfH3Sm2BWmjKtb0E0K7boMGVhhG9SLCyYUBRg5HbM06T9DcBfEU?=
 =?iso-8859-1?Q?BrLQ80hWa90TpITfjECGk3TKF43/UA+45ASUcDuc1XD++gJ4X3QSBzp8p/?=
 =?iso-8859-1?Q?b9xEqnIHIZ/6dTqrbQBCBBR/n1wsJKnq4t3LwxV4pZi56GfFZ7AOkciuPH?=
 =?iso-8859-1?Q?Mf8QTsgnTu5rfczXo4xQ6keETuA3fNX9L7jwPcwO0VhHYHemhS2QnRxbDn?=
 =?iso-8859-1?Q?aaapN0r7L8rTNFvW6TTiimV/u?=
x-microsoft-antispam-prvs: <AM6PR0402MB3734E9E84D3E44045C9C7B3AF57E0@AM6PR0402MB3734.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(366004)(39860400002)(136003)(346002)(199004)(189003)(476003)(66066001)(76176011)(105586002)(486006)(52116002)(2501003)(36756003)(53936002)(14454004)(25786009)(50226002)(110136005)(6116002)(99286004)(3846002)(8676002)(2616005)(7416002)(186003)(7736002)(8936002)(81156014)(81166006)(26005)(106356001)(11346002)(102836004)(305945005)(6506007)(68736007)(386003)(316002)(6436002)(2906002)(4326008)(2201001)(6512007)(86362001)(97736004)(71200400001)(4744005)(71190400001)(478600001)(5660300002)(6486002)(256004)(446003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3734;
 H:AM6PR0402MB3911.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OOkEztoUBvNYYwOSiB/C+JkjDzESxj3j/dDmMGn6ZIYGsv0A/rF042sjIxHEp2F5RVDzlSERdQJ0aoM9rIey9lif8yo715VDceA+nQivIsdKhEa7nZrmc6EYdUu51Gl76gI4x55H/ZVml8uM52lRpqoADKSAkPjM3hCPSZnsHrTwbj3kBU7bhvA94jw72iJtT/T0mbYYhYweA6dLgfjMs6j1OvqRHXSSU+G/ogxoyTp3Vq1tq30wFO2tR6nZOuWCq775RLGVVrSuvicDStVZPxXYfegf1Gqr56I4Xg2sVzr8iWo2+pVLfOae6Ct6kQKUrTsINB8Qmf4qo1VAorIwgN379bZs4s5ZfLkGvv/kHB90tBR+CldohVnVgerxrbucU3Zg/z89eEF6b/tArQVQoX+Bpf+MbqEn/oEzfX9Wk/w=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebc525f-ebcb-4517-f9ac-08d697c73bde
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 06:38:39.5699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3734
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_223852_843152_9D1283B1 
X-CRM114-Status: GOOD (  10.59  )
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

This patch enables CONFIG_IMX_SC_THERMAL as module.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c390..52d503e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -413,6 +413,7 @@ CONFIG_SENSORS_INA2XX=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
+CONFIG_IMX_SC_THERMAL=m
 CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
