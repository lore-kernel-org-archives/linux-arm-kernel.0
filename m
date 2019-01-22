Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37257C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:59:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 075F521019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gbLHadxX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xHaBmU8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075F521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K4x2wX0uN0M0+vZHis3XL78stB9nSWmqxoaVNeOtMig=; b=gbLHadxXgMuBhC
	MXjiNbQw1K3Df7mbaHXhbwNDSMIP4meDX9qb+vFDNQeIu2bLWa/keFc1n1tqAn5qaY7uUBo8uS4ii
	SqvJuaX+IwsFg7xurvY8U7yxrm/I48cxgbpp9SsovT5//zowBFT7Czl4XA3VMoRll4p2OhB7cCdV0
	Gy3MY7XQOsIr15N+lC/MURql28+icpeiegMBXLnwUKh8RJ+FDqwbcUkFVszM8ePXvqSWmrRu3ts6a
	auhL9D+vfsDdDd1LmXV9hvK8QkT8oLX5k6cO8ZdbsX3wm9P858SmL3m5zBiiqdRKPu2sZFptnNj/0
	sLSVLvcup8+3Mlk/JBvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glve7-0007OD-Fd; Tue, 22 Jan 2019 12:59:15 +0000
Received: from mail-he1eur02on0618.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::618]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glve3-0007No-Qs
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 12:59:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLwFxAh+dQuCj7brMER9Gflb305wlSlW7UbDrYrf2CQ=;
 b=xHaBmU8A9MQDbDMglxje9IpjAupWIzG6awN8PVJdwBvjuyUzd3a+Mmd/YFsj9h2ReZi0o46NkpcKUo0gHagWps/eyXgPvHOBhU9/RzBmqZD/GvgVNzTw26VaTxjlFOptADpoPN13dD3MVpJkSzklLnM2TA086qrEImpxf7FBwWA=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5586.eurprd04.prod.outlook.com (20.178.117.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.31; Tue, 22 Jan 2019 12:59:07 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1558.016; Tue, 22 Jan 2019
 12:59:07 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Rob Herring <robh@kernel.org>
Subject: RE: [PATCH RESEND v1 4/4] dt-bindings: imx8-clock: add a53 and a72
 clock id
Thread-Topic: [PATCH RESEND v1 4/4] dt-bindings: imx8-clock: add a53 and a72
 clock id
Thread-Index: AQHUqaSkppDl39MTT0aJiP3Ffy/VUKW6emSAgADVzmA=
Date: Tue, 22 Jan 2019 12:59:07 +0000
Message-ID: <AM0PR04MB4211003C959DCC89B169D39B80980@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547207400-28307-1-git-send-email-aisheng.dong@nxp.com>
 <1547207400-28307-5-git-send-email-aisheng.dong@nxp.com>
 <20190122001011.GA15952@bogus>
In-Reply-To: <20190122001011.GA15952@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5586;
 6:bo/KfGmxVgQNDpKgVffIHBCj7rXTzogeMw06ES3gEpPsRw/AvwdkJbAHsjRtcT+Cv9pXTtlR95EAyTjL4tdGhPE7LMZFOo1cr5QDn1mDGiq4xgNGURac/SPsil45hOmxB+GTxtottiN5Y8sv+qZvHAjy7V3u2G3GlsTVQtv2jaBIrihi0yUIRLvfak6PXuIRqcE7S0pkycb3d+pkqh0sR191m8pRfMvJdFdQA06uU8O+Ko/yLx6E1yaPyQCtRHnLAz2Q0ATPQxTOOIAiYB5PlHo5F5788Xwitbj5BGGb6Vlol4jxC9waFlInbH9m6aQis0FBj//ZQDQU+sdmhb8OHOYFlyhPVuQHYkwpfl45HdmHeAXI/uUnckGEZLLy23J5UCeeAo+nEhyEpXbzbtT3meGsMC3T551aQ86Ovqpek+tR/JZVXjJ71/PAe+EewJgKzkRH/kBlMvUts9vShGs8mQ==;
 5:BThYMZjREDTRJ9n9T08h5zyl0LOkSJwxW5+Zy604sH8AQFsQFhy1xThWHu+H6kLy1HaoDsmQUaTcfik+aNyjYmjgBzZCHrTqYd0eFq2vFcny5FgnsBmNBTxt9T1/FKSxkQkO9Gk3YD7cgvT8acGMF+7eKjjTtb3zDEpMJ/ztgWZx91MPTdrlXB6quRdRhnTRA7BtLQ+2sqR5fXFiyYiCeQ==;
 7:Iu193nZSxZ211aI1XhPX1tWTHPde5nJHNkBYwC3JJF3qoR7gpN2eDNWA9pgZ/psFTFgnIDtA2dY9H7sHdQnTSe9/fNBnxiNfY0hSsyMIWvai/O8ml5DYRUF6qGm5rHGaeX3lwfEJSItVzKK72c5tZg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0ab23428-2c39-4b60-4394-08d6806964ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5586; 
x-ms-traffictypediagnostic: AM0PR04MB5586:
x-microsoft-antispam-prvs: <AM0PR04MB558670BDAB694915170C6F9F80980@AM0PR04MB5586.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(39860400002)(396003)(366004)(136003)(199004)(189003)(478600001)(71190400001)(74316002)(102836004)(25786009)(6506007)(105586002)(14454004)(71200400001)(6246003)(26005)(2906002)(186003)(76176011)(4326008)(7696005)(217873002)(53936002)(3846002)(14444005)(256004)(106356001)(305945005)(66066001)(6116002)(55016002)(229853002)(486006)(6916009)(9686003)(7736002)(81156014)(8936002)(81166006)(11346002)(446003)(476003)(54906003)(86362001)(99286004)(316002)(8676002)(68736007)(97736004)(44832011)(6436002)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5586;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OQuNHtQu1WrjIW+806xAWUPm4gzSbS3TxC7zoQMeY2H7vyDiJpBurLyxmZq5Vlqk0wmZEH20eyv9HmDThNnS8unlLa0mPV7m84qpFuFfQPd7Zz0j89gn3vWwdeIhcQBkx/skvkdjozDyKEz1QqKVSdrbnd2vZG71blVFAphITdkNRYrF4jGilVFd+m9GYmgIkSWRoOsaE2ZW0XytosveYU0wX8/wghPK4JOcKiGAID97ZZWHRAWfuH6AY4h+hOdS9AoAb5CjchDnaaSQGgfpOE7UXaD3TVgdhQPWgS3CiCeIawC98rnqEL1xqWpLFBXja44mVDgc1d2WdEhlgPxVXM9rHyrxyVyeb9LiT/0ZTfwelgtQnsaHIolgF0QjvkbhYTBsmipxB3RdRo5xxT5EoST9sb+EbWZm+BSx1P01V/E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab23428-2c39-4b60-4394-08d6806964ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 12:59:07.1791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5586
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_045911_867941_441753AC 
X-CRM114-Status: GOOD (  18.20  )
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
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Tuesday, January 22, 2019 8:10 AM
> 
> On Fri, Jan 11, 2019 at 11:56:09AM +0000, Aisheng Dong wrote:
> > Add a53 and a72 clock id, as there's still no users, we update
> > IMX_LSIO_MEM_CLK base to start from 6 to allow a53 and a72 clock id to
> > be continued with a35 clk.
> >
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  include/dt-bindings/clock/imx8-clock.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/dt-bindings/clock/imx8-clock.h
> > b/include/dt-bindings/clock/imx8-clock.h
> > index 4236818..2f1aa2f 100644
> > --- a/include/dt-bindings/clock/imx8-clock.h
> > +++ b/include/dt-bindings/clock/imx8-clock.h
> > @@ -13,10 +13,12 @@
> >
> >  /* CPU */
> >  #define IMX_A35_CLK					1
> > +#define IMX_A53_CLK					2
> > +#define IMX_A72_CLK					3
> 
> All 3 cores in one chip? If not maybe these should be split or define them as
> cpu cluster x clocks.
> 

Not in one chip.
Here are common clock IDs used for both MX8QXP and MX8QM.
You mean change to something like below?

#define IMX_CPU_CLUSTER_A53_CLK			2
#define IMX_CPU_CLUSTER_A72_CLK			3

Regards
Dong Aisheng

> >
> >  /* LSIO SS */
> > -#define IMX_LSIO_MEM_CLK				2
> > -#define IMX_LSIO_BUS_CLK				3
> > +#define IMX_LSIO_MEM_CLK				6
> > +#define IMX_LSIO_BUS_CLK				7
> >  #define IMX_LSIO_PWM0_CLK				10
> >  #define IMX_LSIO_PWM1_CLK				11
> >  #define IMX_LSIO_PWM2_CLK				12
> > --
> > 2.7.4
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
