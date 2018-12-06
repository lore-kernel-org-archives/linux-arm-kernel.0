Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CCDC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:42:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00A020892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OYzCLlYf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fnDxylx1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="mutwC5rZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00A020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X67u8Ad0IoPVnZLj5d5YLAotxd89+6nK1GSQmzRZOpQ=; b=OYzCLlYfdsPgw7
	SgV2NOuvBvdT1v3PeFeMnnp362TwNOu5XjIS8kqz8SnDSvotN0SOf0eOM7mX3pC2yUpCTwoCnSJ/c
	zhzGYSHs0IsXnSk/5GFo1BGqitONuFSygm52UQqhUwiSOzP3Ts6sGM/XKlvixLD3gVkDKrzZjH+6V
	veX9mwBfSCLnoYci9xpgsR1pepHN+Zwb0EhRFlw7KmtXzfRHew7vdjZUlEKaROjrLcYt1/CH43JlQ
	3qiLLV0DtoBnZstcWt7dXv081NF0IBq0vhAvexC3Z9k+9EYxgOghK4oVu50IaYKk/2BqUj81RXEiu
	r2RRM+6mgcLU1cJhOMzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUsyt-00016c-6K; Thu, 06 Dec 2018 12:42:15 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsyh-0000my-TJ
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 12:42:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BCeQ1DMNjeaKJnC+fsKDsP194IybAkkg/awb6d+lxK0=; b=fnDxylx1ZFxVswidEYk9dBugHw
 sRtKeTbQ8+TO02wjJLMCoPLeP/GBmWfTkCt6PXtrpOUJxFpSV03tBu8Zws+8LuN2iFT3F8eA2UnZg
 bhyavZMuVkV6kv0q2DWw/H3GITomWpoY9eGHk2PdAjJHAi0YbBh0RD24RNAnIZiuEB7wGrnxuuMBk
 vw3F7NeM5l9gag8/5ccDylKefrqxZLFgwhtfoqgfKyJ8BmVZsMQNBopOV5bETtuX5xoSRRaGwOtTw
 6LTZ0badT1PxH9S+SMbtJSkjb6xNd2R2uN1urnBe/gm5O03+PMpLYHgCtrNsG80/dBS868sUvsXtQ
 DU2VWY8A==;
Received: from mail-ty1jpn01on0702.outbound.protection.outlook.com
 ([2a01:111:f400:fe9d::702]
 helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsoC-0003Tq-P7
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:31:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCeQ1DMNjeaKJnC+fsKDsP194IybAkkg/awb6d+lxK0=;
 b=mutwC5rZN5qknUG1g0OOZBAKZx3u6uQujJYQezpcqYYar30Vsxf+5TRhtSehGquqYenmtDZlOeJETll+EB7js2S8ITXFt4GUoo9jQK9u2wayvdM9kG0K7gZdERbJfsNi2/eMbN5MUH5mLlaWAXVY4ldZp3+Nm0sqOmkaynxVI0s=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1561.jpnprd01.prod.outlook.com (52.133.162.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Thu, 6 Dec 2018 12:30:53 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::9dd3:2789:8699:7885]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::9dd3:2789:8699:7885%4]) with mapi id 15.20.1382.023; Thu, 6 Dec 2018
 12:30:52 +0000
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v9 1/2] clk: Add comment about __of_clk_get_by_name()
 error values
Thread-Topic: [PATCH v9 1/2] clk: Add comment about __of_clk_get_by_name()
 error values
Thread-Index: AQHUivk3i4Y+f5/feUuqUWNTx+pZGqVtAtEAgASlWYA=
Date: Thu, 6 Dec 2018 12:30:52 +0000
Message-ID: <TY1PR01MB1769B12A216ED3E76A40A6B7F5A90@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181203111309.3709-1-phil.edworthy@renesas.com>
 <20181203111309.3709-2-phil.edworthy@renesas.com>
 <20181203133040.GN10650@smile.fi.intel.com>
In-Reply-To: <20181203133040.GN10650@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; TY1PR01MB1561;
 20:xB/9pCi7ydiHEkR9cfr1q1Hszy7CoWdXxjN0Yltn7rdRWD8g1NkxGGxOkImaqGCG2ftGwQRQy3W3Ue5FK+yoxsT1YPVoXqLwPGJJW5KoANQVZaCpo7DoyHu+Sc4LzhibM+V1p6k/v5G3rB3ExPFNYs+SmYwZdu4vPDHRdp73o/M=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fcaf1fb9-b9ce-4dc4-6a7e-08d65b76a9a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:TY1PR01MB1561; 
x-ms-traffictypediagnostic: TY1PR01MB1561:
x-microsoft-antispam-prvs: <TY1PR01MB1561CC62211FAD8A861F1BF5F5A90@TY1PR01MB1561.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:TY1PR01MB1561; BCL:0; PCL:0; RULEID:; SRVR:TY1PR01MB1561; 
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(136003)(199004)(189003)(51914003)(478600001)(229853002)(74316002)(102836004)(6506007)(53546011)(76176011)(71190400001)(71200400001)(81166006)(81156014)(53936002)(55016002)(105586002)(14444005)(256004)(106356001)(9686003)(2906002)(8676002)(186003)(97736004)(6916009)(33656002)(6116002)(3846002)(54906003)(316002)(7736002)(305945005)(14454004)(446003)(26005)(476003)(11346002)(44832011)(25786009)(6436002)(5660300001)(86362001)(68736007)(486006)(8936002)(66066001)(6246003)(7696005)(4326008)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TY1PR01MB1561;
 H:TY1PR01MB1769.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /zGu961oHRsGeLLGQQa1VH1XV9LgAkEoF3zPvF6y77iEUsdka5h9YtO59eKi++h2lLkVFOz6O42n2EKh7gFPc23OvHWXaJfJpsRRFNf2ft3Rci8htR5lxe4GJFxg4o22mzt+7i5Svb26Xnvg7OtyT08y5oaYfp9FwO8CCjFD21Q0F7HALRViJ2CRmVw7P024I/iNXqjqOKYG0IjEYiqWl6D9QaDosDeDQVS+Mcc/jJofv7qos0/NRO08CBYtF1A0SE3MJtgyMBkvpE09xQT3qu1MkOzIcTgkm1RrWyxoOsGXrXwNk2YgmSNfS/iVPx16onpNISpJaDg4mqQw7bIH0DR/695HbMqVYwvjVakbDiU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcaf1fb9-b9ce-4dc4-6a7e-08d65b76a9a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 12:30:52.8047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1561
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_123112_808095_5A99B20F 
X-CRM114-Status: GOOD (  23.43  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Russell King <linux@armlinux.org.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andy,

On 03 December 2018 13:31 Andy Shevchenko wrote:
> On Mon, Dec 03, 2018 at 11:13:08AM +0000, Phil Edworthy wrote:
> > It's not immediately obvious from the code that failure to get a clock
> > provider can return either -ENOENT or -EINVAL. Therefore, add a
> > comment to highlight this.
> 
> > +/*
> > + * Beware the return values when np is valid, but no clock provider is
> found.
> > + * If name = NULL, the function returns -ENOENT.
> > + * If name != NULL, the function returns -EINVAL. This is because
> > +__of_clk_get()
> 
> I would start new sentence from new line (this will emphasize the possible
> variants)
> 
>  * This is ...
I disagree, the explanation is specifically related to the case where the function
returns -EINVAL. Though this is a nit, so I'm not really bothered either way.

Thanks for the review!
Phil

>  Otherwise looks good to me:
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > + * is called even if of_property_match_string() returns an error.
> > + */
> >  static struct clk *__of_clk_get_by_name(struct device_node *np,
> >  					const char *dev_id,
> >  					const char *name)
> > --
> > 2.17.1
> >
> 
> --
> With Best Regards,
> Andy Shevchenko
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
