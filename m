Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4452C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:05:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E8A9217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Te4vmTup";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oicS19GH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8A9217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KNJIn83dqQjtxPnBlR6n7xGS4jugsQu26sQE15uApiM=; b=Te4vmTupb7zQGM
	UX16YZgCgAOUYv1IQWglNF0iOUlSwVLxM1rrXjJMWE+jdLNghgsHlaJDCbnu7D9gw6lF8XCTuIoyk
	Eq0IGY2y+pHw130QZjyByObkbDNgnhUigHya9jvs6nqa0pzyyhau3EJ5+5Rdyy2blDxs4JEXdqKrU
	h95ZZWwOhJn0VFdOfHghyNWJbBXeCH9nMAwTaLF77stEMdMwVsaHOfWFlaGDHKkzwfeYwQ3QsfDzt
	jlEmZt46T7RlSv2SW2Hc+GM/E2iXXUdcFwHXsKy1CUG222LEE8xWHJAj8uL2neNcLdbpTpFeA0rbs
	FZCqC6CaLKP0vQO36W2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybTr-0006ct-2q; Tue, 26 Feb 2019 12:05:03 +0000
Received: from mail-eopbgr130080.outbound.protection.outlook.com
 ([40.107.13.80] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybTn-0006VX-4Q
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:05:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mdZRh56SUQBbcbH6/ETtMeZJK7aaUw0yL1J2lBHKv0=;
 b=oicS19GHKT7JtfACreYHo++FTo9xv7Me+uTVEriFTSyJhRIpksmUl5ECSIPPfmzIiAsBbZiz84rlePaNF22bv+BEDh+2nJrGGc4U7YuDlSwcNDcqVycgPMcNDAWs2BEEbl77dIDy9xlQMyEk6R4Hng9HIZvp3X0IG1t7MD6QuTI=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB5101.eurprd04.prod.outlook.com (20.177.50.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 26 Feb 2019 12:04:53 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 12:04:53 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Anson Huang <anson.huang@nxp.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>, "ulf.hansson@linaro.org"
 <ulf.hansson@linaro.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 2/2] dt-bindings: imx: add new resources to scu
 resource table
Thread-Topic: [PATCH V4 2/2] dt-bindings: imx: add new resources to scu
 resource table
Thread-Index: AQHUyyaeCJ4QOUOebEWEXoq3nWLbxaXyAEXQ
Date: Tue, 26 Feb 2019 12:04:53 +0000
Message-ID: <VI1PR04MB42224FCEB9264F6F731D75A4807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <1550891655-29043-1-git-send-email-Anson.Huang@nxp.com>
 <1550891655-29043-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550891655-29043-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bb578bf-84bf-4594-85c9-08d69be29e42
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5101; 
x-ms-traffictypediagnostic: VI1PR04MB5101:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; VI1PR04MB5101;
 23:An6U/xxhsiLvd6ZztUz6AS4bhrhNOiw8djStT5EPW?=
 =?us-ascii?Q?Z3cwjrrinXIgHwcgk5Dw+FLIvOXWZmDVrzO87KJlyNV9fm/9IOyWTZH/q9IU?=
 =?us-ascii?Q?7ugLv5aVvshKmFhm1A1GyRGuzfJvA9PeHrLrfyoPKYpliPXPlhu51YlCEMlP?=
 =?us-ascii?Q?vFKgSrWfy45X2jhiGQSokn4ZawPr3thvRO9FcJH8yLHhxKv2MwMyxlblQfwA?=
 =?us-ascii?Q?4PBBec8HDPjyviFcSSoPMMg7Na76o3ml4sKPV+meN+OK8k92JySlxWkkdsE9?=
 =?us-ascii?Q?nhqjx5F2q62WkM2wQmJzl7vYZC+jMOzA5Ej6V3T+MjOJf+CduLodnF9wQnAi?=
 =?us-ascii?Q?9vhFvI0YTkt71uf4hFHKLAAdVJD61JjU7aGT2DSyqxka2NoMSYZ0J491KEV8?=
 =?us-ascii?Q?FQUlGYFKuc0GHk+xDm9i1AvOWH8IN/rwgteqlI75LYQ1vUjDILlJK+IJN5yn?=
 =?us-ascii?Q?cjKG6bT/jmoZKnio0LuaefsMQBPknJS/nva9MesGnjolej2RudVLWM9Ystps?=
 =?us-ascii?Q?Yk5EAfgBtc9sW0ddEo9eyAPEecNAKaXZ4z0O0QwAdPX8Icu/Z+AeqIQa2RRv?=
 =?us-ascii?Q?GjeT4g6lFmEZcmTq5dbvm+T0shWeRsxOin+qlejiKpXmhK2ByCq0vBPFTxzs?=
 =?us-ascii?Q?0emmfLzwSmUkeDIm1rHpApb3uz0DxoEAUd/byNKkI2rpRO/I7OUDepOXq0hJ?=
 =?us-ascii?Q?fFYEvT78aZervREOziiXFKjQzfl16RFNc34e/V0BNA7agFoGx5mNGdEv0BAU?=
 =?us-ascii?Q?c/TCPqdSlwcUd9tEK7apI60O+Ma3a+kATxSBJatk6wBtUIomGVhbnTujR/56?=
 =?us-ascii?Q?H01pkb9aOm6TKd1majJEzHLFG81sRQX1B9+uzS8xNHK71E1Dt9nBv4rNpeWU?=
 =?us-ascii?Q?68Q8AHfnwpSvvCuGxSYc3PPfyTr7revlRUPT+x7M3EyBH6vHevccNbRqtlRH?=
 =?us-ascii?Q?Uo6tGzb8AHIVLuNlsYn2pUAga9lIN69cxkgE0x3E6GUQXTmyD0/pqF5CYoeq?=
 =?us-ascii?Q?WBTyjwZ2sLku95zY7saK6Zp1KbPX1EBolLiSOuYf/6EPYocYNGJI99Ea0Ab9?=
 =?us-ascii?Q?S7O5L6pRlkswItyIfB2PjB7YRLfQADQ9qF3tCClzW3NOD00G3ezfsdBo2ZC8?=
 =?us-ascii?Q?e5lSQK/l2y9DELv9ODIOSHvxLpg2CtGXUkFqoIKNHHRulgsOgPPRprEp0d4N?=
 =?us-ascii?Q?Fq5jHUu5iuSiJuStLpAU96bpqSQoGKYg6GWoqF2AMi9rAAYHR+4UBbiP43Ia?=
 =?us-ascii?Q?JXO8l6ZfX9IBPc1ciYm+ykk/hQnpxtoop0w2JSgYJGflUKY214NET8Jni+hG?=
 =?us-ascii?Q?O0w0dLqww8hs3mVazGVVqFFVT/vA3n/camF4rhu5CaQ?=
x-microsoft-antispam-prvs: <VI1PR04MB5101F1A19A9B2D16CA1DDAFE807B0@VI1PR04MB5101.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(366004)(376002)(136003)(346002)(189003)(199004)(52536013)(25786009)(102836004)(2201001)(4326008)(6436002)(105586002)(53936002)(9686003)(33656002)(7696005)(2906002)(7416002)(99286004)(86362001)(68736007)(229853002)(106356001)(97736004)(6246003)(2501003)(55016002)(6506007)(76176011)(110136005)(316002)(14444005)(5660300002)(44832011)(486006)(478600001)(81156014)(14454004)(26005)(476003)(305945005)(8936002)(8676002)(11346002)(446003)(6116002)(3846002)(71190400001)(71200400001)(81166006)(66066001)(256004)(186003)(7736002)(74316002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5101;
 H:VI1PR04MB4222.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FJdNaFNhAVd645/FBKR2OLEQiL2rTg1QwdbxHpE3s7BNuW7/6DCRhwUynIZ8YZKt1yA8zeaBH8JZxT5jWJbnvO6QdSaL1nE5k8H4ZQ1YtrcFXLPMqg0Q9wuaJrc1clWRLmBmHWo7nb40bUk21Md1bL+ilk6x7n5RDm2DElQQAC97YfC7FA2VlyUMdAcTgCrEI9oqy8SYTfC3C9vWdDK2e/KT04vl1ZLEAQAIG+CvG4T8M/2p1bfw22vfP7ccRwzVjrET4hJgYHUFd+KiPQdKQkzS+2cPs0xSZtVKRz7GWASYWn+bExMdt6iU59dJAqYJfM2gRjLWJj8K/kE+gntMjgnYuJ+wHBaegtSp9H9jHE56sk6VqaKsBklUoJTJS+HA0ltWksCdvmML7cwxEF9da0dOl+AeFHgLHk30S2SOmrs=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb578bf-84bf-4594-85c9-08d69be29e42
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 12:04:53.7646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_040459_176988_8D5A5C1A 
X-CRM114-Status: GOOD (  12.32  )
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

> From: Anson Huang
> Sent: Saturday, February 23, 2019 11:20 AM
> 
> Add new resources as below according to latest system controller firmware for
> new features:
> 
> 	IMX_SC_R_PERF
> 	IMX_SC_R_OCRAM
> 	IMX_SC_R_DMA_5_CH0
> 	IMX_SC_R_DMA_5_CH1
> 	IMX_SC_R_DMA_5_CH2
> 	IMX_SC_R_DMA_5_CH3
> 	IMX_SC_R_ATTESTATION
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Please update the patch title to:
dt-bindings: firmware: imx-scu: xxxx

Otherwise:
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> ---
> No changes since V3.
> ---
>  include/dt-bindings/firmware/imx/rsrc.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/dt-bindings/firmware/imx/rsrc.h
> b/include/dt-bindings/firmware/imx/rsrc.h
> index d69f934..4e61f64 100644
> --- a/include/dt-bindings/firmware/imx/rsrc.h
> +++ b/include/dt-bindings/firmware/imx/rsrc.h
> @@ -36,6 +36,7 @@
>  #define IMX_SC_R_DC_0_BLIT1		20
>  #define IMX_SC_R_DC_0_BLIT2		21
>  #define IMX_SC_R_DC_0_BLIT_OUT		22
> +#define IMX_SC_R_PERF			23
>  #define IMX_SC_R_DC_0_WARP		25
>  #define IMX_SC_R_DC_0_VIDEO0		28
>  #define IMX_SC_R_DC_0_VIDEO1		29
> @@ -322,7 +323,7 @@
>  #define IMX_SC_R_IRQSTR_SCU2		321
>  #define IMX_SC_R_IRQSTR_DSP		322
>  #define IMX_SC_R_ELCDIF_PLL		323
> -#define IMX_SC_R_UNUSED6		324
> +#define IMX_SC_R_OCRAM			324
>  #define IMX_SC_R_AUDIO_PLL_0		325
>  #define IMX_SC_R_PI_0			326
>  #define IMX_SC_R_PI_0_PWM_0		327
> @@ -539,6 +540,11 @@
>  #define IMX_SC_R_VPU_MU_3		538
>  #define IMX_SC_R_VPU_ENC_1		539
>  #define IMX_SC_R_VPU			540
> -#define IMX_SC_R_LAST			541
> +#define IMX_SC_R_DMA_5_CH0		541
> +#define IMX_SC_R_DMA_5_CH1		542
> +#define IMX_SC_R_DMA_5_CH2		543
> +#define IMX_SC_R_DMA_5_CH3		544
> +#define IMX_SC_R_ATTESTATION		545
> +#define IMX_SC_R_LAST			546
> 
>  #endif /* __DT_BINDINGS_RSCRC_IMX_H */
> --
> 2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
