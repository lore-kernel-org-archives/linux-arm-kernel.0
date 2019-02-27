Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E39C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:53:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26DD3218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XjGDioK3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ISZZC37u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DD3218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8ibzNJ9+hRMx+WU8wvfiyZ0KKA8gyz1C0KAuVp0Pa2U=; b=XjGDioK31p4wkC
	87CAH3lPazmp+LXO7Xwp5UxzKo1lm/6GN34VNSfM7hS5jqGBxgDgRsutdttyg0J8qPV7u3BmnhX9/
	MElpMj/7K8WsInqLz4QIreYDBNlCtZHuD2FSAhzc1nE5zGtlc53T2W8etsWCel06IdNeYDsp4/X+k
	k/0a2SLFqPpx0JXxvKt9n8LpSc4E8/fMNSx6ZgCx5ROs3L2DfhEQjMwnlaTQdGQtQAixv3P0N0E/9
	zHN1whA/6NqeCF9VIXPkEl3UHQ5TJq595wlHYJd10and09jY8eOu5pFS3GhUYt5vI6N/fitKiRwwJ
	iRNKcB4kRLn3TE61nL4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gynTG-0000aN-Cg; Wed, 27 Feb 2019 00:53:14 +0000
Received: from mail-ve1eur03on0611.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::611]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gynTC-0000Zm-KK
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 00:53:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LN1HBb6ArK5wzNqz37ecdtH3msbt9mbyUFdpavcakco=;
 b=ISZZC37u9O517WQdPoZo0c9TF30icLwb4aLzK2iBPghdsvykj0edhI2RkjXTHO67YN8kNYUQgKx9MvKRiqCysDcNDFE8vTJ9+Ofxm/1q/exLtNOfL+cT5DBpN8MRPsGfcmEX8du0CxAhqR6yg/f87InowXwlJZyDdGvCVCxuvJk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3771.eurprd04.prod.outlook.com (52.134.67.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Wed, 27 Feb 2019 00:53:04 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 00:53:04 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, Aisheng
 Dong <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org"
 <ulf.hansson@linaro.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND V4 1/2] dt-bindings: firmware: imx-scu: remove unused
 resources from scu resource table
Thread-Topic: [PATCH RESEND V4 1/2] dt-bindings: firmware: imx-scu: remove
 unused resources from scu resource table
Thread-Index: AQHUzjbLosGXq4bHDEGIwgGx+GRRZw==
Date: Wed, 27 Feb 2019 00:53:04 +0000
Message-ID: <1551228502-1535-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0183.apcprd02.prod.outlook.com
 (2603:1096:201:21::19) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46d8a5fa-e1d3-4c2d-2831-08d69c4dee27
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR0402MB3771; 
x-ms-traffictypediagnostic: DB3PR0402MB3771:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; DB3PR0402MB3771;
 23:j0eSACaKL0fo5Nuai+Cu1QbPTTP5AaQvvgv8v?=
 =?iso-8859-1?Q?DGukEe3FZzl0X349MDqPIiQxwpGR8G1VeoO+JIYfwNbjLH7/gy/UPZgB1z?=
 =?iso-8859-1?Q?HkWOTnuvTFbkPixAUfmhiJ2H/QFGhVE8G7oquq4n367WdYZVx4KvxSBqPE?=
 =?iso-8859-1?Q?rNla+Rd9Kjz1xnBYmiPz0dweWlt3evp9D0b920yK5OkaNGiAbDC2DZBhNe?=
 =?iso-8859-1?Q?Ji7MuOOT/8w+CtAzzbBWy97ra9pdby9S7knvX0nPv+DVFiEE4imM43z/EM?=
 =?iso-8859-1?Q?8nrElPP0qph4tXOMZjmbPnGUGrPZltf3XF8a5URDtcUCtCzu/PFPWxiyIz?=
 =?iso-8859-1?Q?7f5CUVvdwvSkf2sILMwaV5WS5Hl7B0ElYo3mJU+QHYLic4rQozLM6q2Pup?=
 =?iso-8859-1?Q?2LLdUivjo0LJaLB7J6CplX+TgWy3aEuvkQWVIoRJEluh/pg4VNgtmgahbK?=
 =?iso-8859-1?Q?N+YTOOTAfk+iqi5NzDQgqKYbbxywWbXJz9BngtdL3AVWcnPTmCraPSfts8?=
 =?iso-8859-1?Q?mkUgTtVosZ8zrGXZRIxiof2qc5EoK+o7p2JqPMD74imLhNQ2JHMxUHtDgi?=
 =?iso-8859-1?Q?F9mmIBq1D1ydHPwWEA+8mwVX7/KWIDDp6iWpEmYsofO9Dwk/UvSs72lYI1?=
 =?iso-8859-1?Q?gg6TWpQeYqglK+MunPzhZYA9TXDKSNn/V3qpCiH+PRhuGgxe1+6R075Uid?=
 =?iso-8859-1?Q?AbtRwGM3Whs2gSV1qZqD6MdHGpuj03/JkYKz0bydwIdIsOvpMBU6EjBo7J?=
 =?iso-8859-1?Q?jGZkedOVkT9Fcqamu78Wm6Nv0O5q87N8Ec9Y2NriP5whs/+wRKCwzFHmoD?=
 =?iso-8859-1?Q?rSOGZ/7JSgK2bvVcLfJNhGUcBOzKUOXDKpbGeU/l8rAnPnBDcMAzofxKGX?=
 =?iso-8859-1?Q?FZR1e1yQmQ/NWxzvIBLR+7mMJ0Pc8BL2q0rFVY+NaLA+5vJq9b2izV2ykJ?=
 =?iso-8859-1?Q?0aj9xNjLa0uEJYAcv35GuVc09SFcw08fBiRsk0z8/u4NtPf6BAcXCt38Oi?=
 =?iso-8859-1?Q?KVRavXRo4nRJ5jz2AULGu0SkzpbRRfe4W3BSbnanS3+4BDV5camCG258EG?=
 =?iso-8859-1?Q?GFx0oOTUjP7iTFRPEhask6lolQyeNeUwTOe0Al4mqKDosBXzTQI2TJ+qve?=
 =?iso-8859-1?Q?lPxdopVYpvJYAweaxbv4pIDxh1tJRVWId/tIXXMLglNRqUW2NJiN0+yZ0v?=
 =?iso-8859-1?Q?A0t8qynyAN3njrCq9ZvSpQmLC4zugEEyjI6rsqNAx9gvtlAPByzPduVPzF?=
 =?iso-8859-1?Q?xT/l7MVa/bL5tN2HKxX?=
x-microsoft-antispam-prvs: <DB3PR0402MB37715572455CE26D715023BAF5740@DB3PR0402MB3771.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(102836004)(316002)(110136005)(71200400001)(71190400001)(68736007)(386003)(478600001)(256004)(6506007)(6116002)(3846002)(99286004)(6436002)(6486002)(66066001)(6512007)(52116002)(2906002)(105586002)(106356001)(97736004)(7416002)(186003)(2501003)(25786009)(476003)(26005)(2616005)(486006)(53936002)(4326008)(36756003)(14454004)(5660300002)(8936002)(86362001)(305945005)(2201001)(50226002)(7736002)(81156014)(81166006)(8676002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR0402MB3771;
 H:DB3PR0402MB3916.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Six/iDtzsM+RHuUpy2aco7+sbB6VTnueFkEifun6HAuIzuejxEN3M2pVisD9LSZblGVJAmsy+X4GSeQl5OyDIJWuJjlWDAeLcP0Ac0ghYB8/cBF+F3loauUXxS2zFlBSa/cY7hslJUpvUgWO/CTD+lJYY+CebZUOPukNbwEvCP37Iq8FVR2kYTICinGXVtkYUp+fvmE1ONW0yp0vNXRLnTnxaaVGeV+0+cf3kUhtMaU4TSzqXg2JscA9gNpgCP1j1ccHyDpzKelt+Hk3PUPoVyBEra53hKFa+WVsGZ96dxkD36Rouce43Ql+8CQ1jts00xeYmg2fgBCX/HAZTww9YvNcRW6tjg9buVzsmOLpabMgxCCTA0bcuAeuRbGnDNlsty0Ir5gTBIz9tZxXJtla5ii9wG+rxCWGX/DDQKKlOrc=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d8a5fa-e1d3-4c2d-2831-08d69c4dee27
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 00:53:00.3705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3771
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_165310_694474_5C7C563E 
X-CRM114-Status: UNSURE (   7.52  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Removes below resources which were defined during
pre-silicon phase and the real silicons do NOT have
them, they have never been used, latest system
controller firmware also removed them:

	IMX_SC_R_DC_0_CAPTURE0
	IMX_SC_R_DC_0_CAPTURE1
	IMX_SC_R_DC_0_INTEGRAL0
	IMX_SC_R_DC_0_INTEGRAL1
	IMX_SC_R_DC_0_FRAC1
	IMX_SC_R_DC_1_CAPTURE0
	IMX_SC_R_DC_1_CAPTURE1
	IMX_SC_R_DC_1_INTEGRAL0
	IMX_SC_R_DC_1_INTEGRAL1
	IMX_SC_R_DC_1_FRAC1
	IMX_SC_R_GPU_3_PID0
	IMX_SC_R_M4_0_SIM
	IMX_SC_R_M4_0_WDOG
	IMX_SC_R_M4_1_SIM
	IMX_SC_R_M4_1_WDOG

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 include/dt-bindings/firmware/imx/rsrc.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
index 4481f2d..d69f934 100644
--- a/include/dt-bindings/firmware/imx/rsrc.h
+++ b/include/dt-bindings/firmware/imx/rsrc.h
@@ -36,15 +36,10 @@
 #define IMX_SC_R_DC_0_BLIT1		20
 #define IMX_SC_R_DC_0_BLIT2		21
 #define IMX_SC_R_DC_0_BLIT_OUT		22
-#define IMX_SC_R_DC_0_CAPTURE0		23
-#define IMX_SC_R_DC_0_CAPTURE1		24
 #define IMX_SC_R_DC_0_WARP		25
-#define IMX_SC_R_DC_0_INTEGRAL0		26
-#define IMX_SC_R_DC_0_INTEGRAL1		27
 #define IMX_SC_R_DC_0_VIDEO0		28
 #define IMX_SC_R_DC_0_VIDEO1		29
 #define IMX_SC_R_DC_0_FRAC0		30
-#define IMX_SC_R_DC_0_FRAC1		31
 #define IMX_SC_R_DC_0			32
 #define IMX_SC_R_GPU_2_PID0		33
 #define IMX_SC_R_DC_0_PLL_0		34
@@ -53,17 +48,11 @@
 #define IMX_SC_R_DC_1_BLIT1		37
 #define IMX_SC_R_DC_1_BLIT2		38
 #define IMX_SC_R_DC_1_BLIT_OUT		39
-#define IMX_SC_R_DC_1_CAPTURE0		40
-#define IMX_SC_R_DC_1_CAPTURE1		41
 #define IMX_SC_R_DC_1_WARP		42
-#define IMX_SC_R_DC_1_INTEGRAL0		43
-#define IMX_SC_R_DC_1_INTEGRAL1		44
 #define IMX_SC_R_DC_1_VIDEO0		45
 #define IMX_SC_R_DC_1_VIDEO1		46
 #define IMX_SC_R_DC_1_FRAC0		47
-#define IMX_SC_R_DC_1_FRAC1		48
 #define IMX_SC_R_DC_1			49
-#define IMX_SC_R_GPU_3_PID0		50
 #define IMX_SC_R_DC_1_PLL_0		51
 #define IMX_SC_R_DC_1_PLL_1		52
 #define IMX_SC_R_SPI_0			53
@@ -303,8 +292,6 @@
 #define IMX_SC_R_M4_0_UART		287
 #define IMX_SC_R_M4_0_I2C		288
 #define IMX_SC_R_M4_0_INTMUX		289
-#define IMX_SC_R_M4_0_SIM		290
-#define IMX_SC_R_M4_0_WDOG		291
 #define IMX_SC_R_M4_0_MU_0B		292
 #define IMX_SC_R_M4_0_MU_0A0		293
 #define IMX_SC_R_M4_0_MU_0A1		294
@@ -323,8 +310,6 @@
 #define IMX_SC_R_M4_1_UART		307
 #define IMX_SC_R_M4_1_I2C		308
 #define IMX_SC_R_M4_1_INTMUX		309
-#define IMX_SC_R_M4_1_SIM		310
-#define IMX_SC_R_M4_1_WDOG		311
 #define IMX_SC_R_M4_1_MU_0B		312
 #define IMX_SC_R_M4_1_MU_0A0		313
 #define IMX_SC_R_M4_1_MU_0A1		314
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
