Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DCAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:50:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEDE42070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SD2iLYvP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P0bbI3uS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDE42070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZichxvOfGX3ZZ/UfsFjs1SMrd2PaJ8d4/pmftNUu3i4=; b=SD2iLYvPbeocba
	p7dqfi2JYLGuZjjDVnFwCIgdrydGgRQg9D5ZMHoS3Ql2hZhm75/UJb8CwqIBq/9uQ6Y76tteJaUqK
	WeRuD47yonCDNOHuRXzHE9kTas8RcEK4IZS2lihbwu512YyLtJCo+FOptKTBRjs/k6UQl9Z0IrIaZ
	8Q8mFYj9hb8iJR0jaGQfRjvmYgGA5N6buqOCLeS2woABYVSwTzWcNrNrWQ+LIUgmLXOjR2zL9TLNx
	fciJj1KSJ7o4ehuRBcq1beeQebKnj3/CbBW4FPKO76oRe7Wx49rfSshISbjGHqqZ5heFtuXVsa4fs
	MPsWadX9LO7iOJ8S51Nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfGUy-00007m-UL; Fri, 04 Jan 2019 03:50:16 +0000
Received: from mail-ve1eur02on0620.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::620]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfGUt-0008SJ-SD
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 03:50:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtKiM8POtEDI8hTYHz7BpFeCwY+fgV1JdvcIW1VuCrU=;
 b=P0bbI3uSSUfIwmVZ9wR6dA20LwxPICsmKDCGx58qavpTRjgCNeSRZmps/phuAzds6KpIf3Y3QambGGiFX1TSb7bOeHX8G0ptBO722XAbuFqmulXJ94+ijmK8I0KAI1r1lV/PBU8Qg93G7rnobcSA1sbLCRuslKiGI8XePNx8NCk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5412.eurprd04.prod.outlook.com (20.178.114.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Fri, 4 Jan 2019 03:50:06 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1495.005; Fri, 4 Jan 2019
 03:50:06 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [RFC PATCH 1/1] PM / Domains: Add multi PM domains support for
 attach_dev
Thread-Topic: [RFC PATCH 1/1] PM / Domains: Add multi PM domains support for
 attach_dev
Thread-Index: AQHUngerKaedheUOE0OdzOpUuVXDP6WUSj8AgAD3l8CABpO7AIAASp8ggAH1SoCAAGfykA==
Date: Fri, 4 Jan 2019 03:50:06 +0000
Message-ID: <AM0PR04MB4211C13768DD0D9543B6A59F808E0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1545930550-9906-1-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFrP8HOum_4S0-4Bx+sYbTNSyctv3rQDB78zozeNWOuv=A@mail.gmail.com>
 <AM0PR04MB42117D773477A408462D19D180B00@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAPDyKFq4eji_FVKrRJ2k=c1iKuVP_3aERspy6vpXQzeFdBYt9w@mail.gmail.com>
 <AM0PR04MB421124AE755C01CEEC0CF31D808C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAPDyKFodySv0A9ESDWwpJU=FQeyZ3FpOG0BMVBPxfgxd3oLWDw@mail.gmail.com>
In-Reply-To: <CAPDyKFodySv0A9ESDWwpJU=FQeyZ3FpOG0BMVBPxfgxd3oLWDw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5412;
 6:K6Aa4KizXaAM4c3cPVv+YfPUXxXhT4Od+FP5iAM+ZNrVkXaRmXrmnsVseIds9Ano/Lk7OxX0vB3ssb/WkThmDa9aRY2WWrhatstL/Bqi18p9E1GEir4FL6Gr6YD5Fods10r1SKM27Iu660qBZRaL6NHtmTdyR7uSyIC4MsY/wxV7T7xXgJEzhVffKIuR9YWgrw++UlfT590AbIUUgHspGy0b2bBCIE2G13t+c5PkjITLM9R3gqjGbB6EDcLW+5cfHQv/CDKKDX3b9UpVRcCF7PYNY5c4u07HcMhbRDVEFFsVinNBMTIGhheu05ex6F2euBHI7dalYMkcOsPAuLbrSb+5oYU6jstYifim0YaMiWnK7QhfrZgVBAHZgj4elDmtEt1qzq6PHFTL7rnPP0b7gw02GGnE8cKAuqI0Y/iEjPkGvFFaAoH/8v5UOy8oaTA3UxvyGe7S+de8y0NDpNW11w==;
 5:WPJsXvxA9z+oAq0PUpj1keVwZNh04pVSZ30ZC8ckjobcq10QoRVLpfPXejDgzg9nUhHyc6b8sqpP7JvP8QtV5d9y+QH8lkKX5QlauWZiM5o4RLgl5+/YQrqkm5zF78orU6827/2xEh49fL7bhil264gs+DWgv3aunBcUj8ru2hVNsk8qs2rbhKyJqq5ahZkf7WOa64S9q/XDOn7Yh5aOog==;
 7:Dl8vNliIDI2iSf34HSS7vR4ldb1HYbM5UPDRhipJ51tmQ0/IOchNWhfR8nymIrvpj3rNNp9j3Q3HtmJiDaZneJsgAXpC8MVBYuJTUWuEw5UYZ/8b9kRqCinMcK4yvEJRWp1p3yHb2F2L+LBRsjOt0A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a1e388db-a3fe-49c9-f6f9-08d671f7b709
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5412; 
x-ms-traffictypediagnostic: AM0PR04MB5412:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-microsoft-antispam-prvs: <AM0PR04MB5412FE35E6E3B6382691F9E3808E0@AM0PR04MB5412.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(10201501046)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5412; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5412; 
x-forefront-prvs: 0907F58A24
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(39860400002)(376002)(136003)(346002)(13464003)(54534003)(189003)(199004)(52314003)(51914003)(102836004)(76176011)(55016002)(6506007)(478600001)(6246003)(9686003)(97736004)(8676002)(4326008)(81166006)(81156014)(53936002)(7696005)(8936002)(7736002)(68736007)(25786009)(446003)(74316002)(11346002)(305945005)(476003)(93886005)(14454004)(99286004)(7416002)(86362001)(54906003)(316002)(486006)(3846002)(6116002)(5024004)(256004)(14444005)(6436002)(66066001)(229853002)(5660300001)(105586002)(186003)(217873002)(71190400001)(71200400001)(39060400002)(26005)(44832011)(106356001)(33656002)(6916009)(2906002)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5412;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6F+FM3jGlR7ZiFEBSIfUX90E56Wa6NGjUs7Zh5aTyEpOshNP/aa4eC1Cw7VYiQJU/iIHwgHZQunS0NiEP9W2AdQGnODvSW5CBkX9ZnzLqpuAG95Q8bYPmLxRE+mHqNazxo2Lmczz7QMsPfg6bgRZx3QxebTwZ09dld7a++xFUjs3CVJnGIgWZ7Re4NTMhWqlDNeYAUP568DFVIYzlFQqCjxL06uFVrw+whmDd9r3B9wTDzCerWxx3k03IdBJOF3fvjv9+WFK8LBrRqQNciGuxv/8ROZv0H296Kl40ewCzbi1fsdrnFKmUgwL2W8/Wxt5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e388db-a3fe-49c9-f6f9-08d671f7b709
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 03:50:06.0547 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5412
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_195012_217044_7D179E19 
X-CRM114-Status: GOOD (  41.03  )
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
Cc: "dongas86@gmail.com" <dongas86@gmail.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "khilman@kernel.org" <khilman@kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> Sent: Friday, January 4, 2019 5:11 AM
> On Wed, 2 Jan 2019 at 17:29, Aisheng Dong <aisheng.dong@nxp.com> wrote:
> >
> > > -----Original Message-----
> > > From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> > > Sent: Wednesday, January 2, 2019 6:49 PM
> > >
> > > On Sat, 29 Dec 2018 at 07:43, Aisheng Dong <aisheng.dong@nxp.com>
> wrote:
> > > >
> > > > > From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> > > > > Sent: Friday, December 28, 2018 11:37 PM
> > > > >
> > > > > On Thu, 27 Dec 2018 at 18:14, Aisheng Dong
> > > > > <aisheng.dong@nxp.com>
> > > > > wrote:
> > > > > >
> > > > > > Currently attach_dev() in power domain infrastructure still
> > > > > > does not support multi domains case as the struct device *dev
> > > > > > passed down from
> > > > > > genpd_dev_pm_attach_by_id() is a virtual PD device, it does
> > > > > > not help for parsing the real device information from device tree, e.g.
> > > > > > Device/Power IDs, Clocks and it's unware of which real power
> > > > > > domain the device should attach.
> > > > >
> > > > > Thanks for working on this!
> > > > >
> > > > > I would appreciate if the changelog could clarify the problem a bit.
> > > > > Perhaps something along the lines of the below.
> > > > >
> > > >
> > > > Sounds good to me.
> > > > I will add them in commit message.
> > > > Thanks for the suggestion.
> > > >
> > > > > "A genpd provider's ->attach_dev() callback may be invoked with
> > > > > a so called virtual device, which is created by genpd, at the
> > > > > point when a device is being attached to one of its
> > > > > corresponding multiple PM
> > > domains.
> > > > >
> > > > > In these cases, the genpd provider fails to look up any
> > > > > resource, by a
> > > > > clk_get() for example, for the virtual device in question. This
> > > > > is because, the virtual device that was created by genpd, does
> > > > > not have the virt_dev->of_node assigned."
> > > > >
> > > > > >
> > > > > > Extend the framework a bit to store the multi PM domains
> > > > > > information in per-device struct generic_pm_domain_data, then
> > > > > > power domain driver could retrieve it for necessary operations
> > > > > > during
> > > attach_dev().
> > > > > >
> > > > > > Two new APIs genpd_is_mpd_device() and dev_gpd_mpd_data() are
> > > > > > also introduced to ease the driver operation.
> > > > > >
> > > > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > > > Cc: Kevin Hilman <khilman@kernel.org>
> > > > > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > > > > ---
> > > > > > This patch is a follow-up work of the earlier discussion with
> > > > > > Ulf Hansson about the multi PM domains support for the
> > > > > > attach_dev() function
> > > > > [1].
> > > > > > After a bit more thinking, this is a less intrusive
> > > > > > implementation with the mininum impact on the exist function
> > > > > > definitions and calling
> > > > > follows.
> > > > > > One known little drawback is that we have to use the device
> > > > > > driver private data (device.drvdata) to pass down the multi
> > > > > > domains information in a earlier time. However, as multi PD
> > > > > > devices are created by domain framework, this seems to be safe
> > > > > > to use it in domain core code as device driver is not likely going to use
> it.
> > > > > > Anyway, if any better ideas, please let me know.
> > > > > >
> > > > > > With the two new APIs, the using can be simply as:
> > > > > > static int xxx_attach_dev(struct generic_pm_domain *domain,
> > > > > >                           struct device *dev) {
> > > > > >         ...
> > > > > >         if (genpd_is_mpd_device(dev)) {
> > > > > >                 mpd_data = dev_gpd_mpd_data(dev);
> > > > > >                 np = mpd_data->parent->of_node;
> > > > > >                 idx = mpd_data->index;
> > > > > >                 //dts parsing
> > > > > >                 ...
> > > > > >         }
> > > > > >         ...
> > > > >
> > > > > I think we can make this a lot less complicated. Just assign
> > > > > virt_dev->of_node = of_node_get(dev->of_node), somewhere in
> > > > > genpd_dev_pm_attach_by_id() and before calling
> > > __genpd_dev_pm_attach().
> > > > >
> > > > > Doing that, would mean the genpd provider's ->attach_dev()
> > > > > callback, don't have to distinguish between virtual and non-virtual
> devices.
> > > > > Instead they should be able to look up resources in the same way
> > > > > as they did before.
> > > > >
> > > >
> > > > Yes, that seems like a smart way.
> > > > But there's still a remain problem that how about the domain index
> > > > information needed for attach_dev()?
> > > >
> > >
> > > What do you mean by domain index?
> > >
> >
> > As we're using multi power domains in Devicetree, attach_dev() needs
> > to know which power domain the device is going to attach.
> > e.g.
> > sdhc1: mmc@5b010000 {
> >         compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
> >         power-domains = <&pd IMX_SC_R_SDHC_0>, <&pd
> IMX_SC_R_SDHC_1>;   // for test only
> >         ...
> > };
> > Then attach_dev() can parse the correct "resource id" (e.g.
> > IMX_SC_R_SDHC_1) from device tree And store it in per-device struct
> generic_pm_domain_data for later start()/stop() using.
> 
> I see, thanks for clarifying.
> 
> Seem like, we have two options to make this work.
> 
> 1. Let genpd pre-store the index in a the per device generic_pm_domain_data
> while doing the attach and before calling the
> ->attach_dev() callback. This would make sense, if we consider this to
> be a common thing.
> 
> 2. Provide the index as an additional new in-parameter to the
> ->attach_dev() callback. This requires a tree wide change as it means
> we need to update existing code using the ->attach_dev() callback.
> 
> I would probably try 1) first to see how the code would look like and then fall
> back to 2). What do you think?
> 

Yes, I agree with you.
This patch is exactly doing 1.

For your former suggestion:
" Just assign virt_dev->of_node = of_node_get(dev->of_node), somewhere in
genpd_dev_pm_attach_by_id() and before calling __genpd_dev_pm_attach().
Doing that, would mean the genpd provider's ->attach_dev() callback,
don't have to distinguish between virtual and non-virtual devices"

As this can only solve passing the real device node issue and we still need
pre-store the index in a the per device generic_pm_domain_data and then
distinguish if it's multi power domain virtual devices in attach_dev(), so
I'm not sure if it's still quite necessary to do that way by assigning
"virt_dev->of_node = of_node_get(dev->of_node) before attach".
Probably after fully switch to option 2, then we can do it to fully drop the using
of per device generic_pm_domain_data to make it transparent to attach_dev()
users.

So now the options may be:
1. Pre-store both device node and domain index in generic_pm_domain_data before
  Calling attach_dev(). This is exactly this patch does. 
2. Pre-store only domain index in generic_pm_domain_data. For device node, assigning
  "virt_dev->of_node = of_node_get(dev->of_node) before attach.
3. Change attach_dev() to passing domain index and assigning
  "virt_dev->of_node = of_node_get(dev->of_node) before attach.

Can you please tell what's your prefer?

If you're okay with 1, can you please review if this patch is ok to you?

Or we directly change to 3 which is fully transparent to users
(users don't need to distinguish whether it's multi pd devices).
e.g.
saving genpd_is_mpd_device() and dev_gpd_mpd_data() in this patch.

Regards
Dong Aisheng

> >
> > > The ->attach_dev() is given both the device and the genpd in
> > > question as in-parameters. Could you store the domain index as part of
> your genpd struct?
> > > No?
> > >
> >
> > AFAICT no.
> > With the only device and the genpd as in-parameters, the
> > ->attach_dev() don't know which power domain to to parse from device tree.
> > Thus no way to store it in genpd struct.
> 
> As stated, you are right!
> 
> >
> > > If you are talking about using the "power-domains" specifier from
> > > the DT node of the device, that should then work, similar to as been
> > > done
> > > in:
> > >
> > > drivers/soc/ti/ti_sci_pm_domains.c
> > > ti_sci_pd_attach_dev()
> > >
> >
> > TI actually does not use multi PM domains. So they can always parse
> > the first power domains to get the correct "resource id" / power id..
> >
> > wdt: wdt@02250000 {
> >         compatible = "ti,keystone-wdt", "ti,davinci-wdt";
> >         power-domains = <&k2g_pds 0x22>; };
> >
> > static int ti_sci_pd_attach_dev(struct generic_pm_domain *domain,
> >                                 struct device *dev) {
> >         ...
> >                 // the index is always 0
> >         ret = of_parse_phandle_with_args(np, "power-domains",
> >                                          "#power-domain-cells", 0,
> &pd_args);
> >         idx = pd_args.args[0];
> >         ...
> > }
> >
> > > You may also provide your own xlate callback for your genpd
> > > provider, like what is done in drivers/soc/tegra/powergate-bpmp. - if that
> helps!?
> > >
> >
> > I'm afraid no.
> > Per our earlier discussion, we're going to use a single global power
> > domain (Tegra is not) and implement the ->attach|detach_dev() callback
> > for the genpd and use the regular of_genpd_add_provider_simple().
> >
> > From within the ->attach_dev(), we could get the OF node for the
> > device that is being attached and then parse the power-domain cell
> containing the "resource id"
> > and store that in the per device struct generic_pm_domain_data (we
> > have void pointer there for storing these kind of things).
> >
> > Additionally, we need implement the ->stop() and ->start() callbacks
> > of genpd, which is where we "power on/off" devices, rather than using
> > the
> > ->power_on|off() callbacks.
> >
> > Now the problem is current attach_dev() has no idea to parse the
> > correct power domain containing the "resource id".
> > That's why I stored it in per-device struct generic_pm_domain_data
> > before calling
> > attach_dev() in this patch implementation.
> >
> > Any ideas?
> 
> Again, thanks for clarifying!
> 
> See my ideas above.
> 
> Kind regards
> Uffe
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
