Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1A0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:59:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0309E21473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i3QENdOd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iJs/F41Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0309E21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OmTWawiuETuc+FCS9mp1rF/WLwurQcFKCVjHghAn9yE=; b=i3QENdOdEs006M
	sNupFbVIB4CJMg1E2AatlE5Hrz3KFQWRMf5vsk02NeEmwhgSKNWAAz0BIrDbls5t8Hte5DvkXOvlZ
	RGykXLrFYqaW74jUgDAkFUkJz0FGXjVryLTz86DGSuRYtvegy3F7bpQ3ADNGJnCLNiHH8MalT41Wb
	uWklJqRXnlSEqTDJKaJycwT/nlQu3jhCW6RHf/Iy8him11PyL6jPvXY2XwhqDyvwR/OvhRVMxZyMU
	luj3u53SuziCzy2a5Eqhx0jEYQqakpqZzPIqSBIn/p81Eg26MNilrxfnBsXUWqY3DE0rGV/vr5S++
	l46w22eeVAgicxj+RkMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYy7E-0006vd-TG; Mon, 17 Dec 2018 18:59:44 +0000
Received: from mail-eopbgr150082.outbound.protection.outlook.com
 ([40.107.15.82] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYy7B-0006u9-Je
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 18:59:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opcMvsYkUWBS1u5Kbyd9Ni5NvdVj2ghMznX7HqmSblA=;
 b=iJs/F41QeryQSotzmjelnhuxTYlNFlSseqVpeONoj0LLdGyXFJlGkHAMKNIeKFxmo897R502wcwADwCUIZoLA7f/sPuDeg1Ck3HrrJxoCUC1NMnAiVCOn0n0SahZ0Hv3U6WKiJblvixnGFM6LWKF8otTawpR8qDk7r13NthGXnM=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3895.eurprd04.prod.outlook.com (52.133.29.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Mon, 17 Dec 2018 18:59:27 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::55a5:d113:d738:e0c9]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::55a5:d113:d738:e0c9%4]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 18:59:27 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 0/3] clk: imx: Make all the parent_names arrays be const
 pointers
Thread-Topic: [PATCH 0/3] clk: imx: Make all the parent_names arrays be const
 pointers
Thread-Index: AQHUk8HlzY+WhQB2ck6/TH6/+MaDIqV+utiAgAQW6YCAAHbNAIAABTAA
Date: Mon, 17 Dec 2018 18:59:27 +0000
Message-ID: <20181217185926.xkbpnqvcrollj5vr@fsr-ub1664-175>
References: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com>
 <154482171780.19322.123667425822315496@swboyd.mtv.corp.google.com>
 <20181217113539.nfwp4knbx3luxoqn@fsr-ub1664-175>
 <154507205230.19322.658078387500141910@swboyd.mtv.corp.google.com>
In-Reply-To: <154507205230.19322.658078387500141910@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR0402MB3895;
 6:Rw7wEiti6NEi4SPpi6ECF1FkGkMsuRQqITCR9CYbiPYumG2D0h7P9XBA0NMsJ/JU0SfTUIcZN0XSLauz434aSlrE3dIpnYSxXJTm36LM0j+HQWs5TqjCi87A6OXQz2ndvLRJvAzzSMtFen+yUahPoAJlD40EQtykZ9492q7xBKKfbETAz3H7Va5C6oSv0XiSi1benQtn1BN2KEX+QJsnXVsKw046ksFSidhlQt7ZkIOasNUvVjNwWI5nV1P26m5r6FIZyhxR1Ge7ASM92MNRf3bhucX5TdQnST8hyoxz1K3JSAyqTRu3Vr3lq4f0odjsA3LmjJjnwC8cwoZj5WY5RznBEHn38q18CTwNe8Gv/8c27uHW3AS1f/HfHKsdRsPvjE5umiseypgPN4NUnka26iM8a0nKmRE5LbnKObzmtQbcRZK8/uKhVZ5f4WXbdrUC5X4jKJIBx/iNfZYuRLaxEQ==;
 5:sLvsyScG58R2QUz8SCRD11QzN0AN1Pm9N2yH+ixyYCRB5RA8Lyqtcbfe+NAX0cXUTqJaiTuofTAZAIJEtZrcyQg2F6+d7GBz8AKUJD2BnwswuamY6DCugzOEti7HqC5QmGB4HOBXfwdpQNaCO3M9o1Bq2OXXsZiq8D3UaGYgC9Q=;
 7:4EgoncRVw4DFOTUkRkhFDQaj0ri3Yi3eplZ0lUQO+xqZhXzMqxNMHsmDcdfnN7ZfbZaNeYtKXrwPfni8WcNWYBFHeBSXXbHYAuXwdIi73VXf1guG0Aix3sSxZdMMV81qjYBKZsBvweBGi6VfJh9DdA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 37bb1b98-cbe3-4e65-fa17-08d66451c4b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3895; 
x-ms-traffictypediagnostic: AM6PR0402MB3895:
x-microsoft-antispam-prvs: <AM6PR0402MB389595BF68564885D7AE0E24F6BC0@AM6PR0402MB3895.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR0402MB3895; BCL:0; PCL:0; RULEID:; SRVR:AM6PR0402MB3895; 
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(7916004)(136003)(396003)(366004)(39860400002)(376002)(346002)(199004)(189003)(25786009)(11346002)(76176011)(105586002)(1076002)(81166006)(3846002)(186003)(6116002)(4001150100001)(97736004)(4326008)(106356001)(68736007)(6436002)(66066001)(6486002)(6512007)(14444005)(256004)(81156014)(33896004)(486006)(5660300001)(9686003)(6246003)(6506007)(53546011)(53936002)(93886005)(26005)(102836004)(33716001)(6916009)(54906003)(2906002)(305945005)(71200400001)(86362001)(71190400001)(478600001)(316002)(8936002)(8676002)(14454004)(99286004)(476003)(44832011)(7736002)(446003)(229853002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3895;
 H:AM6PR0402MB3654.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UngrksQgYgsl4Anu7z3F8jLuRoC6VoY5qgn0F8B2J2aZs+dk94UWS4ZHEAz0I0LmKt25bUGce1o+o43x3vMQstZon1ays0b5fz+Vunr4YvJHIfdfuWHSJ03ECDYTtSXlf2arjIBjZxiQFlaQv0k28pc8m9qtguZa/Ckr9P510dNwFWJdOoZGcbRND2WT3j7Yv3krr3//bSW7qfCQ8iJg654tJQaXZBUpRQSNFiStZgksMDfF1Ab0r4VcmyoPBUBAId+nlKb5TXluBgETtI07+QQ1F9/H2gDEs2VB5UP7YkxG99Pc16mAkgVvuC6lTRKL
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <E0D39000BDA3C048B4D40B8005EE0590@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bb1b98-cbe3-4e65-fa17-08d66451c4b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 18:59:27.3627 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3895
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_105941_734689_55DCC95F 
X-CRM114-Status: GOOD (  21.78  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18-12-17 10:40:52, Stephen Boyd wrote:
> Quoting Abel Vesa (2018-12-17 03:35:40)
> > On 18-12-14 13:08:37, Stephen Boyd wrote:
> > > Quoting Abel Vesa (2018-12-14 07:30:08)
> > > > This is mainly to shut up the checkpatch.pl script warnings about the
> > > > "static const char *" needing to be "static const char * const".
> > > > 
> > > > Abel Vesa (3):
> > > >   clk: imx: Make parent_names const pointer in composite-8m
> > > >   clk: imx: Make parents const pointer in mux wrappers
> > > >   clk: imx8mq: Make parent names arrays const pointers
> > > > 
> > > 
> > > I still see warnings though so there seems to be some more work to do.
> > > 
> > > drivers/clk/imx/clk-imx8mq.c:401:89: warning: passing argument 5 of 'imx_clk_mux2' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
> > >   clks[IMX8MQ_CLK_GPU_SHADER_SRC] = imx_clk_mux2("gpu_shader_src", base + 0x8200, 24, 3, imx8mq_gpu_shader_sels,  ARRAY_SIZE(imx8mq_gpu_shader_sels));
> > > 
> > Hmm, I guess you applied this on top of clk-imx8mq, right ?
> > This change is against linux-next. The actual problem is the imx_clk_mux2
> > which looks like this on branch clk-imx8mq:
> 
> Yes. It would be great if you could indicate where patches are
> generated. In fact, I see that 'git format-patch' now has an option to
> do just this!
> 
> 	git format-patch --base=commit
> 

Sorry about that. Will do that in the future.

> > 
> > static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,  
> >                 u8 shift, u8 width, const char **parents, int num_parents)   
> > 
> > but it looks like this on linux-next (which is exactly the same on clk-next):
> > 
> > static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,  
> >                         u8 shift, u8 width, const char * const *parents,     
> >                         int num_parents)                                     
> 
> Hrmm ok. I'll have to rejigger things and I probably won't be getting to
> it until early next year.
> 

I can rebase it on clk-imx8mq and resend if you want.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
