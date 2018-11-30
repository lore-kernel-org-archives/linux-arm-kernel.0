Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6A2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:26:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0BB42145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A8RwRbJ1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="kNS/NQXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0BB42145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lDUHeGGjHe2k6YP5SemHlQr49mjGh3f3BYZd21jip3U=; b=A8RwRbJ1SLHjBD
	v7MW2B2mLYISpPXA8JX3MlDONh/7fTaeG0EGWsYvhRD+75k7GAK4rux8kM/M6FEmI8uWoRk2DoZmT
	zC3kW6Xkz++OXSBo466bP8lqnTQR5x1rQ4pXPfp8dNtNmMNXMW2SGp/zLhXYNU46UkRgd35L9mz6J
	rYVNb/84tTlYHwlDlY7GzTvku2kOVz+EKr4oipnZ183QlDXwSn/EnNqzi/e8p5BFTMOSF3ryAz3NY
	KNlHFI7Q2mkMcJEbLOo1TykLuOL4Yx4E4Z6Ot9fP52ab5QR2HS56W814oH7xPLb2OC2af+mBJJNcK
	QgNk+i6fptWkkUMNXW3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSfzj-0003GS-JG; Fri, 30 Nov 2018 10:25:59 +0000
Received: from mail-eopbgr1400107.outbound.protection.outlook.com
 ([40.107.140.107] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSfze-0003F2-Hj
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 10:25:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rv92inYlHJlJgUSMUMd1Lt37IyACMp+jSuDmObb3vog=;
 b=kNS/NQXNNfD1jsl/GbVVuYfmNm6AYfrheoFvRT6CnUAHVdEEelO98Z/guTTspi8+EiSN/oQ1GHucExc126E2JdYRnvZK09OPA+b3gJ5BI2L6Dlety5CHZqoTA7kSdy+Lk5cntfShMO7lAb8Oe8kHU12m7ethqtelo/ZHrC5gxWA=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.162.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Fri, 30 Nov 2018 10:25:37 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6%5]) with mapi id 15.20.1294.050; Fri, 30 Nov 2018
 10:25:37 +0000
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Stephen Boyd <sboyd@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Russell King <linux@armlinux.org.uk>
Subject: RE: [PATCH v8] clk: Add (devm_)clk_get_optional() functions
Thread-Topic: [PATCH v8] clk: Add (devm_)clk_get_optional() functions
Thread-Index: AQHUgNtosi7IqypTfU2C9ie/xa1taqVoFvOAgAARhXA=
Date: Fri, 30 Nov 2018 10:25:37 +0000
Message-ID: <TY1PR01MB1769161656941346A08F9F8AF5D30@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181120141445.21378-1-phil.edworthy@renesas.com>
 <154356894146.88331.4169293505438588293@swboyd.mtv.corp.google.com>
In-Reply-To: <154356894146.88331.4169293505438588293@swboyd.mtv.corp.google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; TY1PR01MB1562;
 20:q/etJ3qjlM8meQGaaoYJg3vErCKE9MWu95cOIC9RoIxThwFusrmsmd9jUkztQTdf+iNRVbA1NGS6WSJcbJg3Naidg5SYURGfga/BS5m9r0SmOl6YH6p+bAC4Fy9krRiUbUfHgaDLSy2dE+gumZqBFZG9K83YLGNCd21AGPLO57U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 016f51c5-2d93-4c59-9cc4-08d656ae2bca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:TY1PR01MB1562; 
x-ms-traffictypediagnostic: TY1PR01MB1562:
x-microsoft-antispam-prvs: <TY1PR01MB15626ABC3ED4834A789C7B03F5D30@TY1PR01MB1562.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231453)(999002)(944501466)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:TY1PR01MB1562; BCL:0; PCL:0; RULEID:; SRVR:TY1PR01MB1562; 
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39860400002)(346002)(366004)(376002)(136003)(199004)(189003)(478600001)(256004)(9686003)(55016002)(6246003)(14454004)(25786009)(53936002)(8936002)(8676002)(33656002)(81156014)(81166006)(5660300001)(4326008)(316002)(54906003)(6436002)(6116002)(110136005)(3846002)(99286004)(44832011)(66066001)(7696005)(86362001)(575784001)(229853002)(26005)(102836004)(53546011)(446003)(71200400001)(6506007)(186003)(476003)(486006)(71190400001)(11346002)(76176011)(7736002)(4001150100001)(97736004)(2906002)(305945005)(74316002)(106356001)(68736007)(105586002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TY1PR01MB1562;
 H:TY1PR01MB1769.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hFSbmzA8gSZQwdpJs1sEYDGzPZywFbq8fw/TvP2Nr/C6cMMvCc1rqIFlp222vJUA0s1VNgUMDROQutpyS9V0y0cs8kRs4ckRSbH56yd2NpF799djOANK+gplymdiXsvkE9sXvCVLoxfQwMbNpM2RT2tH4A7p3Lv+mYf6vk6gBcsowmXjJIbxDGyjMnAwTOysPpSl1NT62hiE2l8Ha7LYoDuGh+ojkvWmAr4L0TbfmjA+P2YVBT+f02eRnVhAveGsB6tXCXfVLMZgx3KzFd66884N7AkAdh4w1vK5eVcE3NP3QPNSLuvue/V7ZrxtAYQVIlLK8P4OsINLxocqoJKwYA/iw1DKBKBbOTWvM7ChZoc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016f51c5-2d93-4c59-9cc4-08d656ae2bca
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 10:25:37.8000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1562
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_022554_589917_7FD8CC0E 
X-CRM114-Status: GOOD (  24.42  )
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stephen,

On 30 November 2018 09:09 Stephen Boyd wrote:
> Quoting Phil Edworthy (2018-11-20 06:14:45)
> > This adds clk_get_optional() and devm_clk_get_optional() functions to
> > get optional clocks.
> > They behave the same as (devm_)clk_get except where there is no clock
> > producer. In this case, instead of returning -ENOENT, the function
> > returns NULL. This makes error checking simpler and allows
> > clk_prepare_enable, etc to be called on the returned reference without
> > additional checks.
> 
> Ok. I guess that works by virtue of how -ENOENT is returned by various
> functions that are called deeper in the clk_get() path? I'm cautiously
> optimistic. So cautious, we should probably add a comment to these optional
> functions that indicate they rely on the functions they call to return -ENOENT
> under the various conditions that make a clk optional.
Yes, it does indeed rely on how clk_get() is implemented.
Specifically, that if __of_clk_get_by_name() returns -EINVAL, the error is
superseded by clk_get_sys() returning -ENOENT.
As you say, a comment may help here.


> >
> > diff --git a/include/linux/clk.h b/include/linux/clk.h index
> > a7773b5c0b9f..3ea3c78f62dd 100644
> > --- a/include/linux/clk.h
> > +++ b/include/linux/clk.h
> > @@ -383,6 +383,17 @@ int __must_check devm_clk_bulk_get_all(struct
> device *dev,
> >   */
> >  struct clk *devm_clk_get(struct device *dev, const char *id);
> >
> > +/**
> > + * devm_clk_get_optional - lookup and obtain a managed reference to an
> optional
> > + *                        clock producer.
> > + * @dev: device for clock "consumer"
> > + * @id: clock consumer ID
> > + *
> > + * Behaves the same as devm_clk_get except where there is no clock
> > +producer. In
> 
> Please add () around devm_clk_get() so we know it's a function.
Will do.


> > + * this case, instead of returning -ENOENT, the function returns NULL.
> > + */
> > +struct clk *devm_clk_get_optional(struct device *dev, const char
> > +*id);
> > +
> >  /**
> >   * devm_get_clk_from_child - lookup and obtain a managed reference to a
> >   *                          clock producer from child node.
> > @@ -718,6 +729,12 @@ static inline struct clk *devm_clk_get(struct device
> *dev, const char *id)
> >         return NULL;
> >  }
> >
> > +static inline struct clk *devm_clk_get_optional(struct device *dev,
> > +                                               const char *id) {
> > +       return NULL;
> > +}
> > +
> >  static inline int __must_check devm_clk_bulk_get(struct device *dev, int
> num_clks,
> >                                                  struct clk_bulk_data
> > *clks)  { @@ -862,6 +879,16 @@ static inline void
> > clk_bulk_disable_unprepare(int num_clks,
> >         clk_bulk_unprepare(num_clks, clks);  }
> >
> > +static inline struct clk *clk_get_optional(struct device *dev, const
> > +char *id)
> 
> Any kernel doc for this function?
I took my cue from the surrounding functions, let me know if I have to add it.

Thanks
Phil

> > +{
> > +       struct clk *clk = clk_get(dev, id);
> > +
> > +       if (clk == ERR_PTR(-ENOENT))
> > +               clk = NULL;
> > +
> > +       return clk;
> > +}
> > +
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
