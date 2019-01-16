Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57880C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:40:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2755020866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rnt57GUo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RTneqmjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2755020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2gDmL+X7AhH7sz7OwFzDIzwuk0/RZsYlFJOQz+Q7UTs=; b=rnt57GUoaPAetR
	iMGxNYspCAdNThVGh+oSLemZ2RV4GPJ00sOtuLviicXw+D+XdvR3yegS8sqfTgjm09JF3xxa60FcC
	qP/15YIEkgFMvuCHo2uo7eO3gMo9m8Jrg/Sr9dIYVUslQxAddUt3c7xLqCgkB0BGvGmHJ+bb1Pw6V
	9VAWjU53xiolnohurxHsy+4jW9WmUAHYvEXTcHccMjcOPx5yWc06lfRlT39DudFcGC9mhB5rk4dm+
	tMYxINl9HJ8Y6AbRkfHk+UNy8b3i0Gmx+AQNEp/xatpyNxCdG5ZgmrFmwfGx7hQvBN545yI2RskvO
	G05nAGdIPSfxAXySkP2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjdvx-0001U8-Hm; Wed, 16 Jan 2019 05:40:13 +0000
Received: from mail-he1eur02on061f.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::61f]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjdvt-0000TK-Iv
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 05:40:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0Yhcnj8c+K4KSLTEOMcdar/X0LcdWHsev3KX3NIGYY=;
 b=RTneqmjpEdz/USNwlqIvL3kIggCVeN2LlycXA1YbsPWSCWTWDKm7fIkrE+Fvzryd0fFTJWdfrr1a5fd7bKvmHJYWQJl5jfWPsa5shViXfs9pyV1Qo2MgDb2rUCtlko0WeyWhqUQjYNffLTeUSA4aLvfCMnH6Qa581zJpb5phVWQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4596.eurprd04.prod.outlook.com (52.135.149.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Wed, 16 Jan 2019 05:40:01 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 05:40:01 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Aisheng Dong <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "sboyd@kernel.org"
 <sboyd@kernel.org>
Subject: RE: [PATCH RESEND v1 0/4] dt-binding: clk: prepare for imx8qm clock
 support
Thread-Topic: [PATCH RESEND v1 0/4] dt-binding: clk: prepare for imx8qm clock
 support
Thread-Index: AQHUqaSa8HQ124jcu0KqZJxAJsOAcqWxZ6Xw
Date: Wed, 16 Jan 2019 05:40:01 +0000
Message-ID: <AM0PR04MB42115D3E98B8B319936AC60E80820@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547207400-28307-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1547207400-28307-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB4596;
 6:9q7q2ESnYogaTi19CpJ1T/2FyyQPAcCEBjQtgXImQ2/18CvQM7eYAsAMN2nGhz5PWlQ2K5yediNz+I3iwX7Lz9IHLp1Df4wsLaZ3farlWaY2B/TDQI8bT5FYYqrrvpb2c15L2UfuajZ8GCgAliE86OX9Lf4F6O6lhLKm66Cx+hFXuNUh5YtlobNH7bgIM13ai9oeI4Nij5dqX+6Xwg6L2mmVuI3f3CJtVh5yUjeC0AlrSrX9ui/P7iOV5IAFWmHx7yVg91mNoJVuFpnBhzqyURGBXTCPILVvfRIpPjWFsYM65tcB5CcJHr9r6Pr2IzoBodtkzf22ikDJI86KzfmuqAkgZUV72YGUPFtiLZQVPd4+E/QhgtC70hmuoOLR2RZ5UAZ384BszfW2euQU5xbo0RwQMI/XpJWuYTjIZV4YbXff/LzdjKp1KJhvdkNXROfJ1wqLcWWNI3GjTXHDj27p2w==;
 5:LTEukSytWhRNdfcVcuI+UlvcRKvht6wQzza/dv7SQQr34xZhEQTMcd/s3AYnwzFyZNzXPKRwpIpydJWWJROx7K9PE1o2OGJ7DPlKjYzSNG+Dpde1pGdrrzDzHyvQu5J9ikPBNnlbo07j7+dTuB7Vq0wzIWwdF0oC1s7nAD72f+2/TRgMyHczYuyX8zDx6u2RIgwaUVvQ94uCWWlLq1T7eQ==;
 7:5sZzYhOWKioFBY9KnUqQMOxBXqYKyxCfLU68/11F0AGrSDmkPC4/qQ92EowZY263xlh0yy2i5Wz9U3UamIdc14kOgKkculWuThHgq7pd4FO5OU5z4yP18Ih9JZpC2GtGDNKWZ5mUCC/KfjZTcyfidw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7935bd62-30ed-428c-55b6-08d67b750f07
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB4596; 
x-ms-traffictypediagnostic: AM0PR04MB4596:
x-microsoft-antispam-prvs: <AM0PR04MB4596FCB692E6E4B3FE7872C480820@AM0PR04MB4596.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(376002)(39860400002)(136003)(346002)(396003)(366004)(199004)(189003)(68736007)(2501003)(8676002)(305945005)(8936002)(71190400001)(81156014)(7736002)(110136005)(186003)(81166006)(33656002)(66066001)(105586002)(106356001)(102836004)(54906003)(9686003)(44832011)(86362001)(71200400001)(53936002)(25786009)(76176011)(55016002)(7696005)(6506007)(6246003)(2201001)(4326008)(229853002)(486006)(11346002)(97736004)(99286004)(446003)(5660300001)(14454004)(2906002)(14444005)(316002)(26005)(74316002)(256004)(478600001)(6116002)(217873002)(3846002)(476003)(6436002)(32563001)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB4596;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gwx6+rV30JrDmLDnTS/r63motBIROZpcTLebZNddudRR9kPVrIoPsXoSEAsYI6fTr1NFnYLPSbFObW8GbJUFFK4Fn+gZCDdnM2G7HU8DzfZ/Fe5dKIAqEOIIBZoefD1VPEVabswf+TSjaqibSn08qovsRs2QqXv3FSunKKuRN/eRvC7Gmn8jtPWgmXD4bWdBRK/tpb1eE1bdG7ZUKQbrv/3ze+dxfVsDkqiXTVedyhEI/bGBp4aohQcVjK15yBb0MevivSwbZBbvk0xl9MOylU87zf4E5/eeBXepsPCWDTJkfL1h8SlmX8MUu7IOnK5P9X1/uNRsUft5s6OipVskLcjOJo9PzL5PJVMgIFOz4sEVN4Y36np2UvFoqBiV/gHqw9dSuwHMGiWR2QI4vB4s8YKm/YcuZiJSJudq0LYlX3Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7935bd62-30ed-428c-55b6-08d67b750f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 05:40:01.1531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4596
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_214009_962767_1CD2F800 
X-CRM114-Status: GOOD (  14.11  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Ping...

BTW, as the first two patches change the same firmware binding doc fs.scu.txt.
I'm not sure whether it should go to Shawn's tree for the binding part, or Stephen's clock tree.

Shawn & Stephen,
What's your suggestion?

Regards
Dong Aisheng

> From: Aisheng Dong [mailto:aisheng.dong@nxp.com]
> Sent: Friday, January 11, 2019 7:56 PM
> 
> After a bit more investigation on IMX8QM, it seemed SCU clock can be used in
> a similar way as IMX8QXP. So update the binding and driver to be a bit generic
> for easily extension of IMX8QM support later.
> 
> Dong Aisheng (4):
>   dt-bindings: fsl: scu: add fallback compatible string for clock
>   dt-bindings: fsl: scu: add imx8qm scu clock support
>   clk: imx: scu: add fallback compatible string support
>   dt-bindings: imx8-clock: add a53 and a72 clock id
> 
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 7 +++++--
>  drivers/clk/imx/clk-imx8qxp.c                               | 1 +
>  include/dt-bindings/clock/imx8-clock.h                      | 6 ++++--
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> --
> 2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
