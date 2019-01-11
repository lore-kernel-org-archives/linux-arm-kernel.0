Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB884C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:32:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B94B20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VXxc3z/X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mrLg6+VN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B94B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VgrUSLCkn9gSYC2hD1zBGuj61PF2UVO6an6n6NHiyyg=; b=VXxc3z/Xnfdh2g
	0H2CTJGRy8VGcWSrZN5woF6Ve+MmQaDd7LGoYSw5EW+ODinZIRaUG77c+0ixK4rYhB7JOy8zLS0yn
	COG8PIVCUGcYMjVPEqyQ6fy0v4VvoP3UxZcffW5xNCfGvUKBcZWNkW1Pol+GmwvMl+PAMx2kUkNQa
	MkRiDLx1EPy3aJ5x16BhFDEi+uJTbdhR5hWcOuuIR0DkMZt+5AAVg9dVjuUzVR7LDvZ6Th3NVeCkK
	C+iBptcXoNU0TZTMaf6QYYyk6wi5CvIpLE64wXhimEomDrEshMC4M7z7IVyNfZ/qNlfX/gYUTQPpP
	AP0zZfqJDD1F6SVQEYpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghu73-0000nt-8R; Fri, 11 Jan 2019 10:32:29 +0000
Received: from mail-eopbgr130044.outbound.protection.outlook.com
 ([40.107.13.44] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghu6y-0000nH-9g
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 10:32:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6FLQQQ4HMcQ2sRHR5GEI4hzsYQy7D62REagMC+jgpU=;
 b=mrLg6+VNVS/ph+68vmWL704qAksHhkidORpzvzziGpis/03foW4q4I9IGhjMMMCNgyg1wa453I16f2K4mEBhdxKmNAKe9thHxN0dK/cif0a5zasPpiMdhsKlahsph9GCoAiud6CvtS9cTvoadcdKE5AiepKMPzZRjZFn0F5erbA=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5954.eurprd04.prod.outlook.com (20.178.112.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 11 Jan 2019 10:32:19 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 10:32:19 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH V5 2/4] arm64: dts: imx: add imx8qxp support
Thread-Topic: [PATCH V5 2/4] arm64: dts: imx: add imx8qxp support
Thread-Index: AQHUlhlPiJ8YSMnJyU2wO9/QT6TwUaWpzDyAgAA4uMA=
Date: Fri, 11 Jan 2019 10:32:18 +0000
Message-ID: <AM0PR04MB42110AF17ADEFDE04CAE8F4280850@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1545058517-18643-1-git-send-email-aisheng.dong@nxp.com>
 <1545058517-18643-3-git-send-email-aisheng.dong@nxp.com>
 <20190111070645.GA32649@dragon>
In-Reply-To: <20190111070645.GA32649@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5954;
 6:KFKkVrV0dUx94eV7eGn9J96c0cuHx3q8cyPWBqH1i4oRh8MfKDGmJCS+aIlpi8Dcoz1Er0UiOzZQLsXI2icHsZ1E2FqHR928v3Gmqt88hZZDnECtMgI7GFr3D3hD3XWiz4Umph73MG+TOPgo7C4q0X6fXCG7xMr4708CpJ07bzygxROFN/k91H3el/pLBwm/8ZgNHjsNRtzwdH7da7Yy34QlTVzs31zCV83sTqv/0BOBb71eMQZtgliwS2fS0LM3kELdOANmvwuObomlYyGjq+fj78+7x7LT2R7T9DWMUJawAKRlLeeI9Igih5NZQiY/kCvxFo5l0aWaSb3xdP5MMPIIxrgz5iclAFH33qoB17AdcMCXXRfkGFpggyeMmfwtJGdnh2zC8x+m+wARvMKZOOZ2rsyWN+hVFjwYqg7ImUI7e391WUtJyVxyLJgUmqe7+VdyyyazPtZe3AFZpGLf5A==;
 5:kRJrDRDLQfn6PAJd7xqaNw/Wk58xCKOcZkqFIDx605cR0bKNSC9EJtYDo3tEYds2DphogpCi5fYbJUiwLirlxSsWqxNhiKXXq1NmSgK7Zr+nNgqsLFKpFwe8/yhjvvMViea4eIfAhMgbyk/MYHNGjCBqhvIrNkrTdiCAzPbl1OdZf/UriRtvcmV6OE69ef0m1K769xXHXZhIxcSlhxZn8Q==;
 7:awUOvabUqThow7N0yo1VKZ9ytbAiIYh4HhsaNHUUnHqkcOT7mdgG30ZqrSHQ87QhuUowmrmFaqzs2oVmNidHMa03fBCB4+pYFYf0aWicxLZE4ITaAr8XsFYIF+2OPjDIOkem1kzpr3mnJL57Nwm4Nw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6bffdd2f-fa76-408c-5cc6-08d677b0104a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5954; 
x-ms-traffictypediagnostic: AM0PR04MB5954:
x-microsoft-antispam-prvs: <AM0PR04MB59545FA4165070607BA3CF6A80850@AM0PR04MB5954.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(366004)(346002)(39860400002)(396003)(189003)(199004)(13464003)(51914003)(229853002)(99286004)(6116002)(3846002)(966005)(6436002)(55016002)(14444005)(256004)(86362001)(575784001)(68736007)(305945005)(2906002)(14454004)(44832011)(8676002)(6916009)(74316002)(81166006)(81156014)(8936002)(97736004)(53946003)(316002)(11346002)(7696005)(25786009)(76176011)(7736002)(102836004)(33656002)(5660300001)(6246003)(6506007)(446003)(53936002)(105586002)(26005)(4326008)(66066001)(45080400002)(71190400001)(486006)(71200400001)(186003)(476003)(39060400002)(6306002)(54906003)(478600001)(30864003)(9686003)(106356001)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5954;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S0tQYlJME3cZMZoPLHlHFBoo1N9L3oyPl3MNnSyxc1vieyy4wSL0dlxFk/pka5kRW6noT6mf6QJL2VgbLtDaL7q0Jeeb8z3aLOvaRVyZ6hJ7FQ4ZtPbYPLuLV+aA0z904tsdJdB/LJQHgBvzaRM2F/UUrr/G+v8IZBjB87336WrelRnnhUn8IW/SCbIqBkdG/26G8UDcU4ubb4JWxyIHOksbSexp+HCjsIarWKcf2ibXytEcbbIZww4055nJ1lz5Y67dafolqqrIZVJfyCocRCWOaekyc+LL/VOCnhC9g+oxddseWTeutClUPz1uS0gNtc9b1YIMIeaKMG8JS1mG8iL3cp8mo3Apxw/Yj2VKDIrclV4FVgoBXX/ARi2awvUGgvjbyOQhJbFgg4F3vyiJLgpQDmAxjro+M7N3FgzqiGA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bffdd2f-fa76-408c-5cc6-08d677b0104a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 10:32:18.9631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5954
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_023224_589955_9E848B82 
X-CRM114-Status: GOOD (  29.27  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Shawn,

Thanks for the review.

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo@kernel.org]
> Sent: Friday, January 11, 2019 3:07 PM
> On Mon, Dec 17, 2018 at 03:00:56PM +0000, Aisheng Dong wrote:
> > i.MX 8QuadXPlus is a quad (4x) Cortex-A35 proccessor with powerful
> > graphic and multimedia features. This patch adds the core SoC dtsi
> > file support.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > v4->v5:
> >  * no changes
> > v3->v4:
> >  * update to new power domain binding
> >    power domain subnodes removed from dts
> >  * add LPCG clock nodes
> >  * clock ID updated accordingly
> > v2->v3:
> >  * add more SoC specific compatible string to IP nodes
> >  * move memory node into board dts
> >  * change pd reg value into hex
> >  * add more explanation about SoC in commit message
> >  * add external clocks
> >  * remove pmu compatible string which is not supported
> > v1->v2:
> >  * mu binding usage update
> >  * no define for node address
> >  * do not use '_' for node name
> >  * drop 'fsl-' prefix for imx dtsi
> >  * no defines for unit address
> >  * generic node names
> >  * range map for 32bit register
> >  * separate board dts
> >
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.txt |   4 +
> 
> Please separate the bindings from dts patch.  We are moving to json-schema
> format.  The fsl.txt has been removed on my for-next branch, so you need to
> patch fsl.yaml instead.
> 

Got it

> >  arch/arm64/boot/dts/freescale/imx8-ca35.dtsi  |  61 ++++
> >  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 409
> ++++++++++++++++++++++++++
> >  3 files changed, 474 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> >
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.txt
> > b/Documentation/devicetree/bindings/arm/fsl.txt
> > index 7fbc424..9b5be3e 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.txt
> > +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> > @@ -131,6 +131,10 @@ i.MX7ULP generic board  Required root node
> > properties:
> >      - compatible = "fsl,imx7ulp";
> >
> > +i.MX8QXP generic board
> > +Required root node properties:
> > +    - compatible = "fsl,imx8qxp";
> > +
> >  Freescale Vybrid Platform Device Tree Bindings
> >  ----------------------------------------------
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
> > new file mode 100644
> > index 0000000..c79e97a
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
> 
> Can you explain it a bit in commit log why we need to have a separate
> imx8-ca35.dtsi?  From naming of the file, it seems there are more imx8 dts
> files than just imx8qxp.dtsi that will include it?
> 

I guess we could merge it into soc.dtsi.

> > @@ -0,0 +1,61 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> > + * Copyright 2017~2018 NXP
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +/{
> > +	cpus {
> > +		#address-cells = <2>;
> > +		#size-cells = <0>;
> > +
> > +		/* We have 1 clusters with 4 Cortex-A35 cores */
> > +		A35_0: cpu@0 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a35";
> > +			reg = <0x0 0x0>;
> > +			enable-method = "psci";
> > +			next-level-cache = <&A35_L2>;
> > +		};
> > +
> > +		A35_1: cpu@1 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a35";
> > +			reg = <0x0 0x1>;
> > +			enable-method = "psci";
> > +			next-level-cache = <&A35_L2>;
> > +		};
> > +
> > +		A35_2: cpu@2 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a35";
> > +			reg = <0x0 0x2>;
> > +			enable-method = "psci";
> > +			next-level-cache = <&A35_L2>;
> > +		};
> > +
> > +		A35_3: cpu@3 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a35";
> > +			reg = <0x0 0x3>;
> > +			enable-method = "psci";
> > +			next-level-cache = <&A35_L2>;
> > +		};
> > +
> > +		A35_L2: l2-cache0 {
> > +			compatible = "cache";
> > +		};
> > +	};
> > +
> > +	pmu {
> > +		compatible = "arm,armv8-pmuv3";
> > +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> > +	};
> > +
> > +	psci {
> > +		compatible = "arm,psci-1.0";
> > +		method = "smc";
> > +	};
> > +};
> > diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > new file mode 100644
> > index 0000000..da99b6f
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > @@ -0,0 +1,409 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> > + * Copyright 2017-2018 NXP
> > + *	Dong Aisheng <aisheng.dong@nxp.com>
> > + */
> > +
> > +#include <dt-bindings/clock/imx8qxp-clock.h>
> > +#include <dt-bindings/firmware/imx/rsrc.h> #include
> > +<dt-bindings/gpio/gpio.h> #include
> > +<dt-bindings/pinctrl/pads-imx8qxp.h>
> > +
> > +#include "imx8-ca35.dtsi"
> > +
> > +/ {
> > +	interrupt-parent = <&gic>;
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	aliases {
> > +		serial0 = &adma_lpuart0;
> > +		mmc0 = &usdhc1;
> > +		mmc1 = &usdhc2;
> > +		mmc2 = &usdhc3;
> 
> Please keep them sort alphabetically in alias name.

Got it.

> 
> > +	};
> > +
> > +	gic: interrupt-controller@51a00000 {
> > +		compatible = "arm,gic-v3";
> > +		reg = <0x0 0x51a00000 0 0x10000>, /* GIC Dist */
> > +		      <0x0 0x51b00000 0 0xc0000>; /* GICR (RD_base + SGI_base)
> */
> > +		#interrupt-cells = <3>;
> > +		interrupt-controller;
> > +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +	};
> > +
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* Physical Secure
> */
> > +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* Physical
> Non-Secure */
> > +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* Virtual */
> > +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* Hypervisor */
> > +	};
> > +
> > +	xtal32k: clock-xtal32k {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <32768>;
> > +		clock-output-names = "xtal_32KHz";
> > +	};
> > +
> > +	xtal24m: clock-xtal24m {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <24000000>;
> > +		clock-output-names = "xtal_24MHz";
> > +	};
> > +
> > +	scu {
> > +		compatible = "fsl,imx-scu";
> > +		mbox-names = "tx0", "tx1", "tx2", "tx3",
> > +			     "rx0", "rx1", "rx2", "rx3";
> > +		mboxes = <&lsio_mu1 0 0
> > +			  &lsio_mu1 0 1
> > +			  &lsio_mu1 0 2
> > +			  &lsio_mu1 0 3
> > +			  &lsio_mu1 1 0
> > +			  &lsio_mu1 1 1
> > +			  &lsio_mu1 1 2
> > +			  &lsio_mu1 1 3>;
> > +
> > +		clk: clock-controller {
> > +			compatible = "fsl,imx8qxp-clk";
> > +			#clock-cells = <1>;
> > +			clocks = <&xtal32k &xtal24m>;
> > +			clock-names = "xtal_32KHz", "xtal_24Mhz";
> > +		};
> > +
> > +		iomuxc: pinctrl {
> > +			compatible = "fsl,imx8qxp-iomuxc";
> > +		};
> > +
> > +		pd: imx8qx-pd {
> > +			compatible = "fsl,imx8qxp-scu-pd";
> > +			#power-domain-cells = <1>;
> > +		};
> > +	};
> > +
> > +	adma_subsys: bus@59000000 {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0x59000000 0x0 0x59000000 0x2000000>;
> > +
> > +		adma_lpcg: clock-controller@59000000 {
> > +			compatible = "fsl,imx8qxp-lpcg-adma";
> > +			reg = <0x59000000 0x2000000>;
> > +			#clock-cells = <1>;
> > +		};
> > +
> > +		adma_lpuart0: serial@5a060000 {
> > +			compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
> > +			reg = <0x5a060000 0x1000>;
> > +			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-parent = <&gic>;
> > +			clocks = <&adma_lpcg
> IMX8QXP_ADMA_LPCG_UART0_BAUD_CLK>;
> > +			clock-names = "ipg";
> > +			power-domains = <&pd IMX_SC_R_UART_0>;
> > +			status = "disabled";
> > +		};
> > +
> > +		adma_i2c0: i2c@5a800000 {
> > +			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
> > +			reg = <0x5a800000 0x4000>;
> > +			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-parent = <&gic>;
> > +			clocks = <&adma_lpcg IMX8QXP_ADMA_LPCG_I2C0_CLK>;
> > +			clock-names = "per";
> > +			assigned-clocks = <&clk IMX8QXP_ADMA_I2C0_CLK>;
> > +			assigned-clock-rates = <24000000>;
> > +			power-domains = <&pd IMX_SC_R_I2C_0>;
> > +			status = "disabled";
> > +		};
> > +
> > +		adma_i2c1: i2c@5a810000 {
> > +			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
> > +			reg = <0x5a810000 0x4000>;
> > +			interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-parent = <&gic>;
> > +			clocks = <&adma_lpcg IMX8QXP_ADMA_LPCG_I2C1_CLK>;
> > +			clock-names = "per";
> > +			assigned-clocks = <&clk IMX8QXP_ADMA_I2C1_CLK>;
> > +			assigned-clock-rates = <24000000>;
> > +			power-domains = <&pd IMX_SC_R_I2C_1>;
> > +			status = "disabled";
> > +		};
> > +
> > +		adma_i2c2: i2c@5a820000 {
> > +			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
> > +			reg = <0x5a820000 0x4000>;
> > +			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-parent = <&gic>;
> > +			clocks = <&adma_lpcg IMX8QXP_ADMA_LPCG_I2C2_CLK>;
> > +			clock-names = "per";
> > +			assigned-clocks = <&clk IMX8QXP_ADMA_I2C2_CLK>;
> > +			assigned-clock-rates = <24000000>;
> > +			power-domains = <&pd IMX_SC_R_I2C_2>;
> > +			status = "disabled";
> > +		};
> > +
> > +		adma_i2c3: i2c@5a830000 {
> > +			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
> > +			reg = <0x5a830000 0x4000>;
> > +			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-parent = <&gic>;
> > +			clocks = <&adma_lpcg IMX8QXP_ADMA_LPCG_I2C3_CLK>;
> > +			clock-names = "per";
> > +			assigned-clocks = <&clk IMX8QXP_ADMA_I2C3_CLK>;
> > +			assigned-clock-rates = <24000000>;
> > +			power-domains = <&pd IMX_SC_R_I2C_3>;
> > +			status = "disabled";
> > +		};
> > +	};
> > +
> > +	conn_subsys: bus@5b000000 {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0x5b000000 0x0 0x5b000000 0x1000000>;
> > +
> > +		conn_lpcg: clock-controller@5b200000 {
> > +			compatible = "fsl,imx8qxp-lpcg-conn";
> > +			reg = <0x5b200000 0xb0000>;
> > +			#clock-cells = <1>;
> > +		};
> > +
> > +		usdhc1: mmc@5b010000 {
> > +			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
> > +			interrupt-parent = <&gic>;
> > +			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
> > +			reg = <0x5b010000 0x10000>;
> > +			clocks = <&conn_lpcg
> IMX8QXP_CONN_LPCG_SDHC0_IPG_CLK>,
> > +				 <&conn_lpcg IMX8QXP_CONN_LPCG_SDHC0_PER_CLK>,
> > +				 <&conn_lpcg IMX8QXP_CONN_LPCG_SDHC0_HCLK>;
> > +			clock-names = "ipg", "per", "ahb";
> > +			assigned-clocks = <&clk IMX8QXP_CONN_SDHC0_CLK>;
> > +			assigned-clock-rates = <200000000>;
> > +			power-domains = <&pd IMX_SC_R_SDHC_0>;
> > +			status = "disabled";
> > +		};
> > +
> > +		usdhc2: mmc@5b020000 {
> > +			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
> > +			interrupt-parent = <&gic>;
> > +			interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
> > +			reg = <0x5b020000 0x10000>;
> > +			clocks = <&conn_lpcg
> IMX8QXP_CONN_LPCG_SDHC1_IPG_CLK>,
> > +				 <&conn_lpcg IMX8QXP_CONN_LPCG_SDHC1_PER_CLK>,
> > +				 <&conn_lpcg IMX8QXP_CONN_LPCG_SDHC1_HCLK>;
> > +			clock-names = "ipg", "per", "ahb";
> > +			assigned-clocks = <&clk IMX8QXP_CONN_SDHC1_CLK>;
> > +			assigned-clock-rates = <200000000>;
> > +			power-domains = <&pd IMX_SC_R_SDHC_1>;
> > +			fsl,tuning-start-tap = <20>;
> > +			fsl,tuning-step= <2>;
> > +			status = "disabled";
> > +		};
> > +
> > +		usdhc3: mmc@5b030000 {
> > +			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
> > +			interrupt-parent = <&gic>;
> > +			interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
> > +			reg = <0x5b030000 0x10000>;
> > +			clocks = <&conn_lpcg
> IMX8QXP_CONN_LPCG_SDHC2_IPG_CLK>,
> > +				 <&conn_lpcg IMX8QXP_CONN_LPCG_SDHC2_PER_CLK>,
> > +				 <&conn_lpcg IMX8QXP_CONN_LPCG_SDHC2_HCLK>;
> > +			clock-names = "ipg", "per", "ahb";
> > +			assigned-clocks = <&clk IMX8QXP_CONN_SDHC2_CLK>;
> > +			assigned-clock-rates = <200000000>;
> > +			power-domains = <&pd IMX_SC_R_SDHC_2>;
> > +			status = "disabled";
> > +		};
> > +
> > +		fec1: ethernet@5b040000 {
> > +			compatible = "fsl,imx8qxp-fec", "fsl,imx6sx-fec";
> > +			reg = <0x5b040000 0x10000>;
> > +			interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&conn_lpcg IMX8QXP_CONN_LPCG_ENET0_IPG_CLK>,
> > +				 <&conn_lpcg IMX8QXP_CONN_LPCG_ENET0_AHB_CLK>,
> > +				 <&conn_lpcg IMX8QXP_CONN_LPCG_ENET0_TX_CLK>,
> > +				 <&conn_lpcg IMX8QXP_CONN_LPCG_ENET0_ROOT_CLK>;
> > +			clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
> > +			fsl,num-tx-queues=<3>;
> > +			fsl,num-rx-queues=<3>;
> > +			power-domains = <&pd IMX_SC_R_ENET_0>;
> > +			status = "disabled";
> > +		};
> > +
> > +		fec2: ethernet@5b050000 {
> > +			compatible = "fsl,imx8qxp-fec", "fsl,imx6sx-fec";
> > +			reg = <0x5b050000 0x10000>;
> > +			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
> > +					<GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
> > +					<GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
> > +					<GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&conn_lpcg IMX8QXP_CONN_LPCG_ENET1_IPG_CLK>,
> > +				 <&conn_lpcg IMX8QXP_CONN_LPCG_ENET1_AHB_CLK>,
> > +				 <&conn_lpcg IMX8QXP_CONN_LPCG_ENET1_TX_CLK>,
> > +				 <&conn_lpcg IMX8QXP_CONN_LPCG_ENET1_ROOT_CLK>;
> > +			clock-names = "ipg", "ahb", "enet_clk_ref", "ptp";
> > +			fsl,num-tx-queues=<3>;
> > +			fsl,num-rx-queues=<3>;
> > +			power-domains = <&pd IMX_SC_R_ENET_1>;
> > +			status = "disabled";
> > +		};
> > +	};
> > +
> > +	db_subsys: bus@5c000000 {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0x5c000000 0x0 0x5c000000 0x1000000>;
> > +
> > +		ddr_pmu0: pmu@5c020000 {
> > +			reg = <0x5c020000 0x10000>;
> > +		};
> 
> How is it used?  It doesn't even have a compatible.
> 

They're still not used.
I could remove those unused nodes.

Regards
Dong Aisheng

> Shawn
> 
> > +	};
> > +
> > +	lsio_subsys: bus@5d000000 {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0x5d000000 0x0 0x5d000000 0x1000000>;
> > +
> > +		lsio_lpcg: clock-controller@5d400000 {
> > +			compatible = "fsl,imx8qxp-lpcg-lsio";
> > +			reg = <0x5d400000 0x400000>;
> > +			#clock-cells = <1>;
> > +		};
> > +
> > +		lsio_mu0: mailbox@5d1b0000 {
> > +			compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
> > +			reg = <0x5d1b0000 0x10000>;
> > +			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
> > +			#mbox-cells = <0>;
> > +			status = "disabled";
> > +		};
> > +
> > +		lsio_mu1: mailbox@5d1c0000 {
> > +			compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
> > +			reg = <0x5d1c0000 0x10000>;
> > +			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
> > +			#mbox-cells = <2>;
> > +		};
> > +
> > +		lsio_mu3: mailbox@5d1e0000 {
> > +			compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
> > +			reg = <0x5d1e0000 0x10000>;
> > +			interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
> > +			#mbox-cells = <0>;
> > +			status = "disabled";
> > +		};
> > +
> > +		lsio_mu4: mailbox@5d1f0000 {
> > +			compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
> > +			reg = <0x5d1f0000 0x10000>;
> > +			interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
> > +			#mbox-cells = <0>;
> > +			status = "disabled";
> > +		};
> > +
> > +		lsio_gpio0: gpio@5d080000 {
> > +			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
> > +			reg = <0x5d080000 0x10000>;
> > +			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +			power-domains = <&pd IMX_SC_R_GPIO_0>;
> > +		};
> > +
> > +		lsio_gpio1: gpio@5d090000 {
> > +			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
> > +			reg = <0x5d090000 0x10000>;
> > +			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +			power-domains = <&pd IMX_SC_R_GPIO_1>;
> > +		};
> > +
> > +		lsio_gpio2: gpio@5d0a0000 {
> > +			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
> > +			reg = <0x5d0a0000 0x10000>;
> > +			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +			power-domains = <&pd IMX_SC_R_GPIO_2>;
> > +		};
> > +
> > +		lsio_gpio3: gpio@5d0b0000 {
> > +			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
> > +			reg = <0x5d0b0000 0x10000>;
> > +			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +			power-domains = <&pd IMX_SC_R_GPIO_3>;
> > +		};
> > +
> > +		lsio_gpio4: gpio@5d0c0000 {
> > +			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
> > +			reg = <0x5d0c0000 0x10000>;
> > +			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +			power-domains = <&pd IMX_SC_R_GPIO_4>;
> > +		};
> > +
> > +		lsio_gpio5: gpio@5d0d0000 {
> > +			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
> > +			reg = <0x5d0d0000 0x10000>;
> > +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +			power-domains = <&pd IMX_SC_R_GPIO_5>;
> > +		};
> > +
> > +		lsio_gpio6: gpio@5d0e0000 {
> > +			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
> > +			reg = <0x5d0e0000 0x10000>;
> > +			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +			power-domains = <&pd IMX_SC_R_GPIO_6>;
> > +		};
> > +
> > +		lsio_gpio7: gpio@5d0f0000 {
> > +			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
> > +			reg = <0x5d0f0000 0x10000>;
> > +			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			interrupt-controller;
> > +			#interrupt-cells = <2>;
> > +			power-domains = <&pd IMX_SC_R_GPIO_7>;
> > +		};
> > +	};
> > +
> > +	hsio_subsys: bus@5f000000 {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0x5f000000 0x0 0x5f000000 0x1000000>;
> > +	};
> > +};
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flist
> >
> s.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&amp;data=02%7C
> >
> 01%7Caisheng.dong%40nxp.com%7Cd9d1fb2a24984eb79ad408d6779366c0
> %7C686ea
> >
> 1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636827872304455002&amp;
> sdata=EQ0
> > MbwoJ%2B0ftNgcIJbff55dOsRy0OUFPoCXztuikdjQ%3D&amp;reserved=0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
