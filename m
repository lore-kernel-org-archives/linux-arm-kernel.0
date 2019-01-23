Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C725C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:17:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2B921726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cCppzfWW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gjEvAeR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2B921726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nb15HiQaWo2xmihtCyoblf7jiUGoTGBvWN4U5pLrkGA=; b=cCppzfWW63PzxD
	W5tpdV3dKGCo4sbrrb1BXtm5ebkAzeLzqhkHZgz4qJYwTFdsF073rJ4M7GdI3fpHPghA2iby0l97a
	pDO5pO0nfrki8HIDGIW8x/mVVuvbYKkgyOGhlSuki7extI7IB3Hf+oCMkSMPbKM62hcfwVijOTAwe
	1si7gjmx2gnuabL+lQONHYJzmJMjlVYCjjFdZ593kJQzL97tfbRZ5Z5Hlo6Ce4LwVs2BQFiv1l1YT
	a1UVNXsQUQ8RfFY02FOvsPq6DmMjQe/NTQLg16cIRrYIKTiIdsaV8WoGzTESA9nPh33JgYBQVjQxr
	eId6ZloLZ0O+siM1jncg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmGX1-0002VP-9T; Wed, 23 Jan 2019 11:17:19 +0000
Received: from mail-db3eur04on061c.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::61c]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmGWy-0002V1-Fx
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 11:17:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4tdytffGcxslRl5rX9yst+JBf4iEA778GSGKFKXXsY=;
 b=gjEvAeR8rpVBj24Il6UI+Nz8yTBi2tz3q/7ycFazEQ8SBSrO+MEngtnLwuOL3O9vlOnr82t/7+czrzlYBXAi6cKNiugToqlWbnE3UVkByW/BL9lEyE00XD2LqiTTCDUm3pk9VKPi9ATzHBPsFbRDyxp/Ob2n7NsC9tgmyibBo4o=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5044.eurprd04.prod.outlook.com (20.177.40.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Wed, 23 Jan 2019 11:17:09 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1558.016; Wed, 23 Jan 2019
 11:17:09 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V2 3/5] dt-bindings: clock: update CPU clock ID name
Thread-Topic: [PATCH V2 3/5] dt-bindings: clock: update CPU clock ID name
Thread-Index: AQHUsvP/O+Vf7Z/SeUispxSFpbwAC6W8tBog
Date: Wed, 23 Jan 2019 11:17:09 +0000
Message-ID: <AM0PR04MB4211EAC52F0744EB516717EE80990@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1548231044-4344-1-git-send-email-aisheng.dong@nxp.com>
 <1548231044-4344-4-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1548231044-4344-4-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5044;
 6:NP+XnlVAlxkFkfZzFXJ4NTL8jEHohOClYeEKQszUbi2W54ythy+CvsiIeMkd6bTIDoMioTTGCz2DWpJNYsX6T8GpDWAP/I+IiNxJNpclrT8x0s1g5+KPdI8zdeogRCXrcTf8yLvHMHzqWhd2HV9QGZlpTM39he+0hi+OW/ojdz5TA73GHyeSonmXy3a+kJ/PZEVql2mkjeRcMQTCGKqdAEsD1Bn2GKX3kj3oMm49unGzz388z1k6NHVUY3yr5p1c1iJViHGptbaj/vR3ubIXYpZlvGCgsUBfBAcVukC0fco37+QpuiNDEdYdHVNH+cOsHgOEx8j4GJWEQS6o2+zz2xq6dUghU6UIwi3odD4XU2l+HrAWEwLm4LTmst8hXUw481xG/RSMTrlf3r0HJWXHka8sFM6++8K6QN2OIbkw1tCAe5Kcn/yAXAh7REd20eMZEZCLD1TZi24R0k6MeagQ9g==;
 5:0uvZnQtVUasqsf6GEJNjpuG9LGXXcb0SzwinD/YxUywrOmFfwR3mAuzpEIPfXnmuXd8qFkFHJk0Bj1yzkPhWfhuioV8loG8T/DWl3SnBtIHPMRJj2PFFXxIW756wO32CoVVTtNXh+60GmwCzBfYn3EgBgtnF99spuuKbS5vuwDoibfLvdLta6qZ9In63JtH6KXGTpDigTEKJsiQS3qjQzA==;
 7:/9HLGHIA2IcRuXiGtFV0nbzwlqxv6jr1l1VWeIz8guXZRQOXk98CE9STC+GE0XZezuEa5WqTQYnfyY4Y16oPRvKc4tMz808qjms/7sxJbaD92YWRlUWDsCPlkB1FJFWk7rRmY3YcLplpMNkGzL+/4Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 48ec3339-cc10-4a4d-3f25-08d6812450c1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5044; 
x-ms-traffictypediagnostic: AM0PR04MB5044:
x-microsoft-antispam-prvs: <AM0PR04MB5044E23DC8BF952C0A64DB2280990@AM0PR04MB5044.eurprd04.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(13464003)(53936002)(53546011)(256004)(229853002)(106356001)(6506007)(14454004)(102836004)(2351001)(86362001)(97736004)(26005)(76176011)(14444005)(2906002)(6436002)(81156014)(7736002)(305945005)(105586002)(81166006)(8676002)(8936002)(99286004)(9686003)(7696005)(71190400001)(71200400001)(66066001)(478600001)(316002)(74316002)(68736007)(486006)(3846002)(6246003)(44832011)(55016002)(476003)(446003)(11346002)(4326008)(25786009)(2501003)(54906003)(6916009)(5640700003)(33656002)(6116002)(15650500001)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5044;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AiwT/3ehutMA9RF2fRWrJKgb+VfIwZMhKIMtsMm1qvJWeIMphlfuyegG3IXN6bFituJcThVriOlixN1FPaRSW12ZgOvYm7vEdkRbqlD/MNQNcrENHtf8LsX1//7YC70gyCRgUuGAv3wvCLoHoYZECLm6Dk7tCWG9KVpotPInil0RflP8dY+vBEYl3qxzafEGPSBA5NIl9iS0tXpbQ2Qza0T0LWC2jEvzf0n+JZiEYOXKVkr4CkARoG9ASyPjXNam8ZgbRGwfXF4FS4mbagymKDxZ5NNT0rxTu+hl40da/lNM1QSExHbJa2L01ajt/85WtGrVCUwZDZBH0yLheTwUyc3+Y9YQue6kx4x7C3OPAT+dmaOCBwpithPSj6hRxu4UkHxVTHfL0F3JVOK+afeBbkBatnlV0SOiTH92KtH+r6Q=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ec3339-cc10-4a4d-3f25-08d6812450c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 11:17:09.2000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_031716_650541_D9F1C95D 
X-CRM114-Status: GOOD (  13.72  )
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
 "sboyd@kernel.org" <sboyd@kernel.org>,
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

> -----Original Message-----
> From: Aisheng Dong
> Sent: Wednesday, January 23, 2019 4:17 PM
> To: linux-clk@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; sboyd@kernel.org;
> mturquette@baylibre.com; shawnguo@kernel.org; Fabio Estevam
> <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
> kernel@pengutronix.de; robh+dt@kernel.org; devicetree@vger.kernel.org;
> Aisheng Dong <aisheng.dong@nxp.com>
> Subject: [PATCH V2 3/5] dt-bindings: clock: update CPU clock ID name
> 
> Update the CPU clocks to CPU cluster clock.
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  include/dt-bindings/clock/imx8-clock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/imx8-clock.h
> b/include/dt-bindings/clock/imx8-clock.h
> index 4236818..aa9b9a0 100644
> --- a/include/dt-bindings/clock/imx8-clock.h
> +++ b/include/dt-bindings/clock/imx8-clock.h
> @@ -12,7 +12,7 @@
>  #define IMX_CLK_DUMMY				0
> 
>  /* CPU */
> -#define IMX_A35_CLK					1

Sorry this one breaks the building as clock driver already use IMX_A35_CLK.
Will update and resend.

Regards
Dong Aisheng

> +#define IMX_CPU_CLUSTER_A35_CLK				1
> 
>  /* LSIO SS */
>  #define IMX_LSIO_MEM_CLK				2
> --
> 2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
