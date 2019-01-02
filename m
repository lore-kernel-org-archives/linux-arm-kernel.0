Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D877C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:30:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE39B21871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VNGOiT5z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I7e52gwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE39B21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fuOG1L9Mpst7PFJrzofsms0UaUHGeqxkz7igTCIIeQ4=; b=VNGOiT5zXXH61f
	3UXZ++BpWJjMmYEKAKpRiEtWFANFinrAShfys+9+Pn1i1YB74fwwdwPrk5BilPZzXVp2A261PPRDN
	Wfg14mt4lSckMvs6QTBpY1N/BlszPXoYZMIE7YgAesTVTF4plX/o4PoBlKgMS5G3Ow9M/1ICuVUhK
	g5SJVL57d2mf71zpIwwTVbRIlLEzy9YJKt2PL9NLj3NYliPg6YUSKf1bZwRwTicTEzvSyJmxL62ES
	W0JB/N7NRGV/rRMGpz8T2N1+m+pgwSGS7r98oZmS+37453jJq+W2XbQh2BDdUA6jZ8K6pZxwoNudN
	CRJ0ZSVYsh1eX7FaIpFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gejP2-0006n7-8w; Wed, 02 Jan 2019 16:29:56 +0000
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gejOw-0006m6-66
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 16:29:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puLPhN0xx7eZSJ+mz+4foNcr/FprDpQGvXjuSAAedfA=;
 b=I7e52gwLW6G88QHQRjpUeOJQI/JyMc4JZXIiL5ih+RFY7inHT2cHafmy2dnPreuMfZfbWFbLEnSnE3iczebq2JdsY95Qm17N7qEpnrFEoQOCHyhEO+QKM10SHjFknLQV8vO2XZiUhV0j23Lw8ciffwWOskQsESCwJ7RsrBij+MY=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5220.eurprd04.prod.outlook.com (20.177.42.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Wed, 2 Jan 2019 16:29:41 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%4]) with mapi id 15.20.1495.005; Wed, 2 Jan 2019
 16:29:41 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [RFC PATCH 1/1] PM / Domains: Add multi PM domains support for
 attach_dev
Thread-Topic: [RFC PATCH 1/1] PM / Domains: Add multi PM domains support for
 attach_dev
Thread-Index: AQHUngerKaedheUOE0OdzOpUuVXDP6WUSj8AgAD3l8CABpO7AIAASp8g
Date: Wed, 2 Jan 2019 16:29:41 +0000
Message-ID: <AM0PR04MB421124AE755C01CEEC0CF31D808C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1545930550-9906-1-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFrP8HOum_4S0-4Bx+sYbTNSyctv3rQDB78zozeNWOuv=A@mail.gmail.com>
 <AM0PR04MB42117D773477A408462D19D180B00@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAPDyKFq4eji_FVKrRJ2k=c1iKuVP_3aERspy6vpXQzeFdBYt9w@mail.gmail.com>
In-Reply-To: <CAPDyKFq4eji_FVKrRJ2k=c1iKuVP_3aERspy6vpXQzeFdBYt9w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5220;
 6:2qEiRyQFFKTgtBFykD8lsTLXVYvtOUSVLxLslZ+itXt0LZHm6HORgDjPrOaKsSuTcd+YYv8k9blmqWmmdfshcFOGxgZc38Xm608/9HgOllMq4ej73a5MAdiA7+NKPe5HFfQc8M8kvgRY0T+JKKv1UT9zAIKOpsk0xmzFC+owOh2Y1Fx81C1NGZC17LACJUkimfpn+CwbQfndm2tlsU6zBJH2owCYbibzupNF2KFNgGplbFznE08P1J0CIrxDsD/kJM+/bFFNRVtMfQDqmEWVIqgrNWesItzfZZ/ToZLcjV/IjQ5X8PfoI62F691RcZOFiO9S0688OTAAFVHAwAnrmT1YnTwEZkM3MYsOn43uWplZaN0iccvno2ZiMZMXNko3AlzxR1KZLTRs/8lAM3/wkkOy4ICIAfJ86wFV0F9OY5mpqfWSzl/NuyaIS8ICLFrbHD8E3Nsl+afF+x6VzGS2HQ==;
 5:+pPrtzryJb0HzYKdEiR1P/knrPN2o4+9LEMvp1QQngkFAlEsDPFBqyq7HU1smAAAERGL+cBKj40ne+nX9UvDPEDJEt6Xj1bL3jKLJXFRNcV0xrEp2M+YHdD2YmvE9PkxUCouU4s2aN9pEE67+E78SiD0kwwte+BjkDnhxAmUO0M=;
 7:7EMWsUy+fTsWjEj53rHDwayk+/bjJOsZ1e514APnn+uIzcEJJEiLVqCaFS5q1vK8VMZx5Lw0OE71keyAY64GvYfYk1SVO1ZtVKJZN8+mT7B/QhSTQ3TNGUw7YIwtZuD2VBMmTihXpfXFBA4LxOKMrQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2d746053-0c12-429a-9089-08d670cf7f47
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5220; 
x-ms-traffictypediagnostic: AM0PR04MB5220:
x-microsoft-antispam-prvs: <AM0PR04MB5220CC6861678148D23E4C70808C0@AM0PR04MB5220.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5220; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5220; 
x-forefront-prvs: 0905A6B2C7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(136003)(39860400002)(376002)(346002)(52314003)(199004)(51914003)(189003)(13464003)(54534003)(8936002)(102836004)(66066001)(6506007)(14454004)(7696005)(81166006)(3846002)(81156014)(6116002)(76176011)(5660300001)(186003)(256004)(486006)(44832011)(5024004)(217873002)(6916009)(26005)(8676002)(478600001)(7416002)(11346002)(446003)(7736002)(476003)(2906002)(86362001)(305945005)(39060400002)(6246003)(74316002)(99286004)(25786009)(106356001)(6436002)(316002)(9686003)(68736007)(54906003)(97736004)(93886005)(229853002)(71190400001)(53936002)(55016002)(33656002)(71200400001)(105586002)(4326008)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5220;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GWoHWDHrsLdNWtlp7GdEhmwAXN/0KiwHlmP5asjjIe4Sc5Da1cmTLzxflc3rnSA+hd2U9he/JM5Kvi6bsyZ0gWq6Va9apq9xO9cvuvsyMGQhB1F1Y+UcSe4QRmSn5+z3nfJ3/9TwF0rPSQrSFbVsPzwoi24nSDKCtzsgIJ3I1egs6sW+WRGYfvilU2MbH4+4h9//hd8XliRpyDbMc5SWID34BbIBlvmQ/0EXpX8qYG8MIbeJN4efWu7KBz/fFNsCHjHSpyRaSNEkg5OAWGwx37TEml0iux7R2G0OomqiwYYJQ2f2yTxmMtCC6t6+otdk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d746053-0c12-429a-9089-08d670cf7f47
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2019 16:29:41.4816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5220
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_082950_477218_F2C228E7 
X-CRM114-Status: GOOD (  41.48  )
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

> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> Sent: Wednesday, January 2, 2019 6:49 PM
>
> On Sat, 29 Dec 2018 at 07:43, Aisheng Dong <aisheng.dong@nxp.com> wrote:
> >
> > > From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> > > Sent: Friday, December 28, 2018 11:37 PM
> > >
> > > On Thu, 27 Dec 2018 at 18:14, Aisheng Dong <aisheng.dong@nxp.com>
> > > wrote:
> > > >
> > > > Currently attach_dev() in power domain infrastructure still does
> > > > not support multi domains case as the struct device *dev passed
> > > > down from
> > > > genpd_dev_pm_attach_by_id() is a virtual PD device, it does not
> > > > help for parsing the real device information from device tree, e.g.
> > > > Device/Power IDs, Clocks and it's unware of which real power
> > > > domain the device should attach.
> > >
> > > Thanks for working on this!
> > >
> > > I would appreciate if the changelog could clarify the problem a bit.
> > > Perhaps something along the lines of the below.
> > >
> >
> > Sounds good to me.
> > I will add them in commit message.
> > Thanks for the suggestion.
> >
> > > "A genpd provider's ->attach_dev() callback may be invoked with a so
> > > called virtual device, which is created by genpd, at the point when
> > > a device is being attached to one of its corresponding multiple PM
> domains.
> > >
> > > In these cases, the genpd provider fails to look up any resource, by
> > > a
> > > clk_get() for example, for the virtual device in question. This is
> > > because, the virtual device that was created by genpd, does not have
> > > the virt_dev->of_node assigned."
> > >
> > > >
> > > > Extend the framework a bit to store the multi PM domains
> > > > information in per-device struct generic_pm_domain_data, then
> > > > power domain driver could retrieve it for necessary operations during
> attach_dev().
> > > >
> > > > Two new APIs genpd_is_mpd_device() and dev_gpd_mpd_data() are also
> > > > introduced to ease the driver operation.
> > > >
> > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > Cc: Kevin Hilman <khilman@kernel.org>
> > > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > > ---
> > > > This patch is a follow-up work of the earlier discussion with Ulf
> > > > Hansson about the multi PM domains support for the attach_dev()
> > > > function
> > > [1].
> > > > After a bit more thinking, this is a less intrusive implementation
> > > > with the mininum impact on the exist function definitions and
> > > > calling
> > > follows.
> > > > One known little drawback is that we have to use the device driver
> > > > private data (device.drvdata) to pass down the multi domains
> > > > information in a earlier time. However, as multi PD devices are
> > > > created by domain framework, this seems to be safe to use it in
> > > > domain core code as device driver is not likely going to use it.
> > > > Anyway, if any better ideas, please let me know.
> > > >
> > > > With the two new APIs, the using can be simply as:
> > > > static int xxx_attach_dev(struct generic_pm_domain *domain,
> > > >                           struct device *dev) {
> > > >         ...
> > > >         if (genpd_is_mpd_device(dev)) {
> > > >                 mpd_data = dev_gpd_mpd_data(dev);
> > > >                 np = mpd_data->parent->of_node;
> > > >                 idx = mpd_data->index;
> > > >                 //dts parsing
> > > >                 ...
> > > >         }
> > > >         ...
> > >
> > > I think we can make this a lot less complicated. Just assign
> > > virt_dev->of_node = of_node_get(dev->of_node), somewhere in
> > > genpd_dev_pm_attach_by_id() and before calling
> __genpd_dev_pm_attach().
> > >
> > > Doing that, would mean the genpd provider's ->attach_dev() callback,
> > > don't have to distinguish between virtual and non-virtual devices.
> > > Instead they should be able to look up resources in the same way as
> > > they did before.
> > >
> >
> > Yes, that seems like a smart way.
> > But there's still a remain problem that how about the domain index
> > information needed for attach_dev()?
> >
> 
> What do you mean by domain index?
>

As we're using multi power domains in Devicetree, attach_dev() needs to 
know which power domain the device is going to attach.
e.g.
sdhc1: mmc@5b010000 {
        compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
        power-domains = <&pd IMX_SC_R_SDHC_0>, <&pd IMX_SC_R_SDHC_1>;   // for test only
        ...     
};
Then attach_dev() can parse the correct "resource id" (e.g. IMX_SC_R_SDHC_1) from device tree
And store it in per-device struct generic_pm_domain_data for later start()/stop() using.

> The ->attach_dev() is given both the device and the genpd in question as
> in-parameters. Could you store the domain index as part of your genpd struct?
> No?
> 

AFAICT no.
With the only device and the genpd as in-parameters, the ->attach_dev() don't know
which power domain to to parse from device tree.
Thus no way to store it in genpd struct.

> If you are talking about using the "power-domains" specifier from the DT node
> of the device, that should then work, similar to as been done
> in:
> 
> drivers/soc/ti/ti_sci_pm_domains.c
> ti_sci_pd_attach_dev()
> 

TI actually does not use multi PM domains. So they can always parse
the first power domains to get the correct "resource id" / power id..

wdt: wdt@02250000 {
        compatible = "ti,keystone-wdt", "ti,davinci-wdt";
        power-domains = <&k2g_pds 0x22>;
};  

static int ti_sci_pd_attach_dev(struct generic_pm_domain *domain,
                                struct device *dev)
{
        ...
		// the index is always 0
        ret = of_parse_phandle_with_args(np, "power-domains",
                                         "#power-domain-cells", 0, &pd_args);
        idx = pd_args.args[0];
        ...
}

> You may also provide your own xlate callback for your genpd provider, like
> what is done in drivers/soc/tegra/powergate-bpmp. - if that helps!?
> 

I'm afraid no.
Per our earlier discussion, we're going to use a single global power domain
(Tegra is not) and implement the ->attach|detach_dev() callback for the genpd
and use the regular of_genpd_add_provider_simple().

From within the ->attach_dev(), we could get the OF node for the device that is
being attached and then parse the power-domain cell containing the "resource id"
and store that in the per device struct generic_pm_domain_data (we have void pointer
there for storing these kind of things).

Additionally, we need implement the ->stop() and ->start() callbacks of genpd,
which is where we "power on/off" devices, rather than using the
->power_on|off() callbacks.

Now the problem is current attach_dev() has no idea to parse the correct power domain
containing the "resource id".
That's why I stored it in per-device struct generic_pm_domain_data before calling
attach_dev() in this patch implementation.

Any ideas?

Regards
Dong Aisheng

> Or am I missing something?
> 
> [...]
> 
> Kind regards
> Uffe
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
