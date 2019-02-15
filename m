Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E18AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:57:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096DF222D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WO1pyCdk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZjMq5vG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096DF222D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t/ZHH0C2Mh1pP2GZ/AHnvbhWNONvpGC6YIevesq7KcY=; b=WO1pyCdkzZEiHb
	sPOGTeDpMuJKvcAjaeXpfNrGurC2j4mfhUw31EGvW0g9OmaPxgS31bONtaf1XT5Oihaah8+zpWExi
	dAROJnI3osuqEYYee4DAEcan1bxiUbYiKRksAXYtlZ/tTTDhqefuOsrwkjwoOsWz0T1s9BmMISKkA
	rm+aYI+2K5qlbx2Iq8HcCzrv5UPCcDbwg1Zuzcs8jQKT4csxQ9VAECI7/tkRgCfE7nM+YD05z+tRJ
	FvSHVR27N8AX1BCtD0M1RANFY0+p/IyehLthsz5FeB1uOfj60RY6IEntK2udq0UOlFErMdhm6ichJ
	Fk3FKgAVuYe75D3NVAqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZIS-0008Ly-Uc; Fri, 15 Feb 2019 08:56:36 +0000
Received: from mail-he1eur02on060c.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::60c]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZIP-0008Kc-3L
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 08:56:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMOEGBw7O0D9xfSutby/ZNX1caM3bYSbeQRh4MNCKHc=;
 b=ZjMq5vG+BPMrX+169BO7hCsIRepwKgrTkrPQLMdDUKskwRqQyQUlooeDmd6UqhDrCZzs0D8bnx8ZitwGFXtA0PTpBT23tg9ESsoYXvpOHhS6aYDDiWBihb9G8LbXCw9zZpq0rOM6FxvS9abC4V0fmmuQNZdQFxIJI3ENkXUtypg=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6305.eurprd04.prod.outlook.com (20.179.35.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 08:56:26 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 08:56:25 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Angus Ainslie <angus@akkea.ca>
Subject: Re: [RFC 5/5] arm64: dts: imx8mq: Add the opp table and the
 cpu-supply nodes
Thread-Topic: [RFC 5/5] arm64: dts: imx8mq: Add the opp table and the
 cpu-supply nodes
Thread-Index: AQHUxMkkpnPnEnH9UEK8Pa2IFDhbGKXgjxUA
Date: Fri, 15 Feb 2019 08:56:25 +0000
Message-ID: <20190215085624.dtc5uyxch72l2q6g@fsr-ub1664-175>
References: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
 <1550084693-9797-6-git-send-email-abel.vesa@nxp.com>
 <76b2c0e4a61d022f7f798990af4dfd8b@www.akkea.ca>
In-Reply-To: <76b2c0e4a61d022f7f798990af4dfd8b@www.akkea.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c605fca-1e19-4231-e381-08d693237781
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB6305; 
x-ms-traffictypediagnostic: AM0PR04MB6305:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; AM0PR04MB6305;
 23:2k+0cjWy0bFzZLGevibW/rsBbWJe9Gy+KHI1q4wa8?=
 =?us-ascii?Q?Q+x18TpD1AHPqBgpZpwfQ9PG+7Tb3I/xOBL3fngLu3LMMqzg1DDnb6GSr2j3?=
 =?us-ascii?Q?IwET5kQPvMsnNlimOHor29abfWuMcO58z0DCeuizP9Zm7oswaxBvM+qosPL9?=
 =?us-ascii?Q?hX7IqqFKZ2+Bbn/z3onyqrugULqT7mnp7GlDJEb6zRzwKzzLQsnYaDS+I7mD?=
 =?us-ascii?Q?kJWRaJKY5MI6FN/S08jooQDMlFxzHITQgdccLreoRZxwWOCVbYp3a3cqJCa0?=
 =?us-ascii?Q?bFckY9xwNduSrqD4unyrcf6vaJPpBD8gcLtCMvFf8K8zRfVyFko1kss3bYRH?=
 =?us-ascii?Q?r+W/4ytO2vTOqFFIt/jYHOytBhHzKByBstxKw4xUQBkniJkRh6fQilX8+gFR?=
 =?us-ascii?Q?apLy+iiULfUsk/deXqhT1HEqTXLq2/rLbO0v+oWhsCKcbvzKOhUp/93+dCnN?=
 =?us-ascii?Q?8t53E/2aAGwg/AFbYwpkKKakj4zO1MEhz12F6XomR9AmR+Us1smYsNneHMYU?=
 =?us-ascii?Q?UCzYUTRysUTDNAn+NVHIywvlaxfXq+7QMyfQU+EAbc0VS9SyfRb/9upiPHZn?=
 =?us-ascii?Q?5pRwKMwj/rqFqVVM+/7qR2ZydANAbgisPhL1QQa7kML2g77ZXtkMIdPB2G2I?=
 =?us-ascii?Q?yoXEiu3NlmmEna2KykGm9CUm0v+bhYCISr/NjiTRTsim2aod1/9Lmpt35JXS?=
 =?us-ascii?Q?q+fQGoF8T0z9WlHQGNhljq15JPv2B7EyRwKkXsCR8hIjPQhMo7SZzmWmvjbY?=
 =?us-ascii?Q?XRCInaJAfsXUM6+kYM+Y4NRJy/4ETtaX/q3LbosIkjm4zQ9j7/TvthYWOVhG?=
 =?us-ascii?Q?1DeMZ803H2QDbZiJuyGnnE+iQPjG92rR48WL2KabFmkLCQMlcDvoo2KSTOcq?=
 =?us-ascii?Q?Mw/9xVezyl0gYIlzImemL1H39KYinEblCLnlE8k9E0Fj8BFvhsWupLQz0x1m?=
 =?us-ascii?Q?VGU2I5ugShrrarzKWvvVYCE8JhZKO1x4waUbLPsRi2aiMKXBiSzWrIkjxKuH?=
 =?us-ascii?Q?MqxsgQgY9U2Jjm2tBdGTN68CD4pqFFeM8HgRaW+NCEJwjok37KzfcBCzre4Q?=
 =?us-ascii?Q?X+kwLRhys2FXoPsKA9MLfv0AOgnMIVAJt6gWeF7erQ8NDhvzGs5dEifNoe2c?=
 =?us-ascii?Q?/JUw6nSQTIzqrR2Um2+Qbb/qzB8dkjrtj/UXrOofk2nYsnkKMAf/KK5+L/iB?=
 =?us-ascii?Q?ftlXK0/19BN9K54TqoTpb32IutBg5pIBsA3O3rcGrAO6yR4d65d6StU8tZCr?=
 =?us-ascii?Q?uLpw/gkK8sGDj3Dyo9RXjyt2bN6K0vnOeyVo4xerT4kmHyfVkOM4wd9cZ/tY?=
 =?us-ascii?Q?9B95r4rb77RD/PaEdCf8a5zfBtwBZCV5qFj8ilpXnWw?=
x-microsoft-antispam-prvs: <AM0PR04MB6305ADDE74DCA0D037123B52F6600@AM0PR04MB6305.eurprd04.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(7916004)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(4326008)(14454004)(229853002)(6116002)(305945005)(6916009)(2906002)(7736002)(105586002)(99286004)(25786009)(3846002)(106356001)(97736004)(6246003)(966005)(81166006)(68736007)(8936002)(478600001)(66066001)(53936002)(81156014)(476003)(6436002)(6486002)(26005)(6306002)(9686003)(6512007)(14444005)(86362001)(316002)(256004)(486006)(8676002)(186003)(33896004)(33716001)(11346002)(71190400001)(71200400001)(102836004)(7416002)(1076003)(446003)(6506007)(53546011)(76176011)(54906003)(44832011)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB6305;
 H:AM0PR04MB5779.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fsA4Dmj6tqdCXzWPwDqtaBpD/Iop9Xm0jZbCEfod179QbWFOcI++2iYVphE5Az1xoTKQlGMvLq6Xg2dGn3wYZWh/UzLZeqVEv2J/GkEFFh/tF7RevCJmvtnoj3/RSrsgOcCHwKENa16MLOxV3TYAegEH8/I18sS5kAftjU/nRmUv2Le0f5bxXFPPiU/sc8Cr54a1AkkUPsTjoAgfC2dTKdku5Ax0QdhRUI/7dEiVigD8/hX53gjQJYpQkYpHYvl6la5c0eT7sASg0uho2EcLEGWAgg19YEt4GmpVLoaPzx8kkSglTnk4SSmvgmsxrFjnuUBgoo773UjTx6PiIxXPoM2GAQt3DLq2UpxQZKDOAdkQfxb9tHlY1w7suMhvJaPaLysMguUt4HQmJrSVfp3Ju23GLAVs2q/iprw/H5PMSxw=
Content-ID: <2998E0C023992748802F4B623D2C5B93@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c605fca-1e19-4231-e381-08d693237781
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 08:56:25.6822 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6305
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_005633_139224_7BA6B643 
X-CRM114-Status: GOOD (  17.16  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Anson Huang <anson.huang@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Mike Turquette <mturquette@baylibre.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-kernel-owner@vger.kernel.org" <linux-kernel-owner@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Angus Ainslie <angus.ainslie@puri.sm>, Shawn Guo <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 19-02-14 16:55:22, Angus Ainslie wrote:
> On 2019-02-13 11:05, Abel Vesa wrote:
> > Add the opp table containing only non over drive opps.
> > Also add the cpu-supply nodes for the A53 cores in the EVK board.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 17 +++++++++++++++++
> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 23
> > +++++++++++++++++++++++
> >  2 files changed, 40 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > index 54737bf..114359e 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > @@ -31,6 +31,23 @@
> >  		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> >  		enable-active-high;
> >  	};
> > +
> > +};
> > +
> > +&A53_0 {
> > +	cpu-supply = <&sw1a_reg>;
> > +};
> > +
> > +&A53_1 {
> > +	cpu-supply = <&sw1a_reg>;
> > +};
> > +
> > +&A53_2 {
> > +	cpu-supply = <&sw1a_reg>;
> > +};
> > +
> > +&A53_3 {
> > +	cpu-supply = <&sw1a_reg>;
> >  };
> > 
> >  &fec1 {
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > index 1a89062..89b2d5f 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -91,6 +91,7 @@
> >  			clocks = <&clk IMX8MQ_CLK_ARM>;
> >  			enable-method = "psci";
> >  			next-level-cache = <&A53_L2>;
> > +			operating-points-v2 = <&a53_0_opp_table>;
> >  		};
> > 
> >  		A53_1: cpu@1 {
> > @@ -101,6 +102,7 @@
> >  			clocks = <&clk IMX8MQ_CLK_ARM>;
> >  			enable-method = "psci";
> >  			next-level-cache = <&A53_L2>;
> > +			operating-points-v2 = <&a53_0_opp_table>;
> >  		};
> > 
> >  		A53_2: cpu@2 {
> > @@ -111,6 +113,7 @@
> >  			clocks = <&clk IMX8MQ_CLK_ARM>;
> >  			enable-method = "psci";
> >  			next-level-cache = <&A53_L2>;
> > +			operating-points-v2 = <&a53_0_opp_table>;
> >  		};
> > 
> >  		A53_3: cpu@3 {
> > @@ -121,6 +124,7 @@
> >  			clocks = <&clk IMX8MQ_CLK_ARM>;
> >  			enable-method = "psci";
> >  			next-level-cache = <&A53_L2>;
> > +			operating-points-v2 = <&a53_0_opp_table>;
> >  		};
> > 
> >  		A53_L2: l2-cache0 {
> > @@ -666,6 +670,25 @@
> >  			status = "disabled";
> >  		};
> > 
> > +
> > +		a53_0_opp_table: opp-table {
> > +			compatible = "operating-points-v2";
> > +			opp-shared;
> > +
> > +			opp-800000000 {
> > +				opp-hz = /bits/ 64 <800000000>;
> > +				opp-microvolt = <900000>;
> > +				clock-latency-ns = <150000>;
> > +			};
> > +
> > +			opp-1000000000 {
> > +				opp-hz = /bits/ 64 <1000000000>;
> > +				opp-microvolt = <900000>;
> 
> Shouldn't this be
> 
> opp-microvolt = <1000000>;
> 

Hmm, I looked into some older datasheet which said the maximum non
overdrive is 1GHz.

But the latest one I could find:

https://www.nxp.com/docs/en/data-sheet/IMX8MDQLQIEC.pdf

says it's 0.8GHz. 

So I'll fix it in the next version.

Thanks.

> > +				clock-latency-ns = <150000>;
> > +				opp-suspend;
> > +			};
> > +		};
> > +
> >  		gic: interrupt-controller@38800000 {
> >  			compatible = "arm,gic-v3";
> >  			reg = <0x38800000 0x10000>,	/* GIC Dist */
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
