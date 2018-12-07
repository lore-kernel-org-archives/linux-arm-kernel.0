Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712D9C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:07:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 393B02083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MKwSKllY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n+4FjKkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393B02083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DoSYiwzZYEaM9IJn9yfqr8p2Nr5aRhDvKKdjJL8jqVY=; b=MKwSKllY2E3NsS
	mR7M2Wd+gFQdgnESkFkGBMmfs1Z9x62nR2m2KzLAtl6AXOxWBmLplZBC4IUcfx9Tv5bjUrSKQGrU1
	AY7gwGdS+YoGWyd/Ll+suYDY7jGzc/KEBgRtBCTEQoqaftE8G3R0B5srVSQkXAqqpID9XY0wg3joh
	lq6Hs15akQ2/ies8XmTdYrSjtZMMdaoxCFzKvZ49/GU5yb8a85Jg+ZvGiJs00ZhRdazUjBFGlSRLl
	Ee0IyQ92EqoyLUN9WhTmJHcBaqZa3X6GBJXYMaNFivjNzYX1MQDHuYQ7D5cyYnA+F0hTRnBoaY5lh
	vPXl/XLTMIvL3pIXkwsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVNLW-0006By-O4; Fri, 07 Dec 2018 21:07:38 +0000
Received: from mail-he1eur04on0631.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::631]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVNLS-0006BS-Ci
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 21:07:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5YEb/rNMZou6Uol+n1LjtI9R5mEGJa6FNt5GdQVaQM=;
 b=n+4FjKkWIEDCGxLBDaaQYtthW/ucNB9pHzPojzk1M5IGmJQTJSgKcyz8qav1UfA2LLXGxwpxFJqmJSXV6fqeOofHR/zvAvpApRChcRpCteOuaThREQ95VREZ6i/wPFLemTx/0wf7+z0tUt77DjF0JiJv46cLd+ChTJI46yluwHc=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3575.eurprd04.prod.outlook.com (52.133.20.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Fri, 7 Dec 2018 21:07:19 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d%4]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 21:07:19 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v4 2/6] arm64: add basic DTS for i.MX8MQ
Thread-Topic: [PATCH v4 2/6] arm64: add basic DTS for i.MX8MQ
Thread-Index: AQHUfELcnHGgzTZTVUSaNCzZm56coaVTDsYAgCCJYICAAAVxAIAAS48A
Date: Fri, 7 Dec 2018 21:07:19 +0000
Message-ID: <20181207210718.ueg2uw6tfniniscl@fsr-ub1664-175>
References: <20181114175242.12468-1-l.stach@pengutronix.de>
 <20181114175242.12468-2-l.stach@pengutronix.de> <20181116232524.GA2013@bogus>
 <20181207161723.2u5z3sdobbpop4kz@fsr-ub1664-175>
 <1544200612.3709.111.camel@pengutronix.de>
In-Reply-To: <1544200612.3709.111.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR0402MB3575;
 6:K1B2qVwYPz2XzSiubBNOHtgecS/JpUxW72CoccE507U3imuEhppRKSlBPM5gpBx90b9mqLxUjMnNFaruFeuoNouKPu0cs/6nXdcPZ+AHxgDlq1agfCayr8Ol60ZBujKccWa7BFZYlegqWoLMYbyhv5HLTMhCyW9t4I0ZAtej7HIs7D8ntbxJyA5k8b+50WnWPs0RHSUwD4gNDYJZ1LRl89ej1DOhGIgunZXFdwjVt+Dy5L89y91t34s6nS1/THklVin2IV3ApTE7zi1RZDZpaie+ryKRdSUmK9kYNzO6kwJ1E87nDMQl9u0dDod6XeOc7Tx33U2ga0PLjYTo8rgswJrK+aOFxyOWgbzvMCu0KQZyZDeUa0ij0vhJbOdwCK6qSlhpN2As7X435LZAAOpgYS44Pr7oepHyz0ZXDhD4elGJ2KGGO7oMJxFiaCPQXDO9jrjk5b5Bz8Kw4jcg1Qfwow==;
 5:LDCSpp4nmsI726NKcmLzgxnVTymrFqfiPsjr6znNETMYO9yJKmUzUmqru7dTxG/I+wwvyFkYT4ILhUFj74whWRLpYDnPHUNiSb67XFyl7piumtkrYwBI5tdA1g7tN9fCXl9M/zrMJ/zWrMVs1WZyDd6+QAJdeXwRym7ePJ2vBII=;
 7:JpXgmTqeW2BTczNy2RmEyrDqBdyQ9W+1dR/nsqcL0rwHwEJgWyjM86IZG4Bofol1I8osrCY4r9CVLScdUqd+smGktt3PqSDPsQIWBGByLuG9YVlb2v+buKRyBNIytBlZreOdJMgwdUk53CeO722iEg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a6dd59ca-ffd2-4db2-935f-08d65c87f96e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3575; 
x-ms-traffictypediagnostic: AM6PR0402MB3575:
x-microsoft-antispam-prvs: <AM6PR0402MB3575552468E68285ABCB0E96F6AA0@AM6PR0402MB3575.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR0402MB3575; BCL:0; PCL:0; RULEID:; SRVR:AM6PR0402MB3575; 
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(7916004)(396003)(366004)(136003)(39860400002)(376002)(346002)(199004)(189003)(446003)(6246003)(14454004)(76176011)(229853002)(44832011)(81156014)(6506007)(99286004)(966005)(97736004)(45080400002)(6486002)(305945005)(8676002)(81166006)(2906002)(7736002)(4326008)(1076002)(33896004)(486006)(86362001)(6116002)(33716001)(3846002)(11346002)(476003)(71190400001)(105586002)(93886005)(6436002)(25786009)(102836004)(68736007)(478600001)(186003)(53936002)(256004)(8936002)(54906003)(71200400001)(5660300001)(6916009)(6306002)(66066001)(9686003)(106356001)(6512007)(316002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3575;
 H:AM6PR0402MB3654.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UTgWcAVgunq8wGqjsONk/lnCXI3GmIgAvtvrouh+xQvC1CQaCrDEWPrDqWCk1Ccdjq/lepo//lHIQ8/PV5daaPq1Ba3BmKGgb0B+nZPCrMtwDF+Heiu+fHuuU/5507KV2WR4T1Mt+dHDQ/co4MnSe1BSNQ1T3a6DKWay7Vv5+YE5UyJmjVIZnCzU06uGCLcSbcuq8V32uuxIhDxPzl8OU2IsG1qZ9J1ogAHoFxi5KUaM0nZd+1VZCKPAQmgxs1Zt4iXA5DqFsaG+edSPGE5k/UXlP2duUmAu7CHC3wzYfYTQiXe4QyEKfwOZWM3fZ94CAqkUv5OJwVrfKM/D7vlRtgXHhoy+JqPuS8fXlKDC44U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <AB1EAF748FF8104C805D9F69BFDDC2FA@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6dd59ca-ffd2-4db2-935f-08d65c87f96e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 21:07:19.3386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3575
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_130734_499191_07632C8F 
X-CRM114-Status: GOOD (  18.46  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 05:36:52PM +0100, Lucas Stach wrote:
> Hi Abel,
> 
> Am Freitag, den 07.12.2018, 16:17 +0000 schrieb Abel Vesa:
> > On Fri, Nov 16, 2018 at 05:25:24PM -0600, Rob Herring wrote:
> > 
> > > > +
> > > > +	clk_ext1: clock-ext1 {
> > > > +		compatible = "fixed-clock";
> > > > +		#clock-cells = <0>;
> > > > +		clock-frequency = <133000000>;
> > > > +		clock-output-names = "clk_ext1";
> > > > +	};
> > > > +
> > > > +	clk_ext2: clock-ext2 {
> > > > +		compatible = "fixed-clock";
> > > > +		#clock-cells = <0>;
> > > > +		clock-frequency = <133000000>;
> > > > +		clock-output-names = "clk_ext2";
> > > > +	};
> > > > +
> > > > +	clk_ext3: clock-ext3 {
> > > > +		compatible = "fixed-clock";
> > > > +		#clock-cells = <0>;
> > > > +		clock-frequency = <133000000>;
> > > > +		clock-output-names = "clk_ext3";
> > > > +	};
> > > > +
> > > > +	clk_ext4: clock-ext4 {
> > > > +		compatible = "fixed-clock";
> > > > +		#clock-cells = <0>;
> > > > +		clock-frequency= <133000000>;
> > > > +		clock-output-names = "clk_ext4";
> > > > +	};
> > > 
> > > This is really 4 independent clocks or is 1 clock connected to 4
> > > sinks?
> > 
> > According to the RM, yes, there are 4 independent clocks. Here is a
> > link to the rm:
> > 
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.nxp.com%2Fwebapp%2FDownload%3FcolCode%3DIMX8MEVKBHUG&amp;data=02%7C01%7Cabel.vesa%40nxp.com%7C303f3053feb94a3c1c9f08d65c623255%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636797974154936811&amp;sdata=CuJSqDl1WiL%2Bc%2B4wYnr3ssDDpH3DorYIzLN87PNHVh4%3D&amp;reserved=0 (page 829)
> > 
> > Unfortunately, the old link (which worked without login) does not
> > work anymore.
> 
> It's really 4 clock inputs to the SoC, but they may actually be
> connected to the same clock source on the board. So I really wonder if
> we should even put this into the base SoC DT, but rather push this into
> individual board DTs.

Hmm, it's part of the SoC, right ? So I would keep it in the dtsi rather than
having it duplicated into every new dts.

> 
> Regards,
> Lucas

-- 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
