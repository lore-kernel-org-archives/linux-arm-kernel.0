Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48097C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 06:43:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F9A521019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 06:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jI5T1OWa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="juRBSjDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9A521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x+z743KCpRiitofWdjBsIAs5CRyckFYBxE+BN0JK6To=; b=jI5T1OWahHmxEC
	iF6eA2zAw8K8ay5rdmIFmljpmXhO8RC6fpRTOh4nmtTMVn8mO4obfNiWmOLRBCJZPdzP+IlJh7/sU
	ckDqP5uyetawFsqRGidtrbTVx0z7B7SCvJGqMsH2zTPJAX/WcN5Ip5p7ez/BVR1zA1/A+yIsHiy+E
	R4+VudIb8uk6f8s7ixl3U7m8pLj9eksPD51RdAbQ0rSK1SviubkVa8BD8UtSRr5Dm4mSqAXor+zag
	TxYttdL32rF6T28Lb43tjvpMij9D1jTbttQd3+ob9K1hwqaLXcbhMXVx6FvRsMslTD9HQl2tryLV8
	j9Cm0AERSlXl+doX6CgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd8LM-0002M8-Su; Sat, 29 Dec 2018 06:43:32 +0000
Received: from mail-eopbgr60061.outbound.protection.outlook.com ([40.107.6.61]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd8LI-0002LA-0c
 for linux-arm-kernel@lists.infradead.org; Sat, 29 Dec 2018 06:43:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veswk+/XjmLYf+8SZlgAr/WM/ImhyNc4o58mVaKR5sI=;
 b=juRBSjDHp2Vq+W1OfRx3KVqEFiIjYClvcZVZ6dKheUGz+lwX4S+03aR4EJDZdSWgiJT2NoOEMwCbhYkaQMf+Pz67SxCrLfNXs96aIj/QBpGimdAB5BClEDaZlvZxKvEGCaDvBx7tkkQXiy6Prg61XH+PdZ5zswMp+7QQ6aomGV0=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5028.eurprd04.prod.outlook.com (20.177.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.24; Sat, 29 Dec 2018 06:43:09 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%7]) with mapi id 15.20.1471.019; Sat, 29 Dec 2018
 06:43:09 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [RFC PATCH 1/1] PM / Domains: Add multi PM domains support for
 attach_dev
Thread-Topic: [RFC PATCH 1/1] PM / Domains: Add multi PM domains support for
 attach_dev
Thread-Index: AQHUngerKaedheUOE0OdzOpUuVXDP6WUSj8AgAD3l8A=
Date: Sat, 29 Dec 2018 06:43:08 +0000
Message-ID: <AM0PR04MB42117D773477A408462D19D180B00@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1545930550-9906-1-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFrP8HOum_4S0-4Bx+sYbTNSyctv3rQDB78zozeNWOuv=A@mail.gmail.com>
In-Reply-To: <CAPDyKFrP8HOum_4S0-4Bx+sYbTNSyctv3rQDB78zozeNWOuv=A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5028;
 6:Ek57ulknvn0HcXKSkPNvNFQRHbgui/PsjHxoE4Z9qRZTt/0g+LJ3C1UwGy9JUY7zu6eJvSwUy3paq+rGJbS5UIisTCJVE8jDsagCGmGVToX/rPZiWJoHDgFCO2+z4OdNV1MZZWhBChJAcKiQS8SRq5eKr/VV+X54BxLbja0d5HG8s3C2S8K44SjyZ/kTPLH6ayqxsK/YcVCBHq3MZ2Ml3ZrBkzcO7F9q1GmJJU2HSWViCuDCFJfY68tXLvJND2HeBZcl5MVn+havijpmPa98jxRaslqFE9DraaZVnegkwZ07TOQtm7vNeMjT2nPK2gjv2nlqBm36Wnkszb+Mvv+8cT4fDXfBmA/Cob3KvmQmZv1DmWgRZilhOABTVOHMOFwS+b71R/PnZGmr1/HHGn3/fLwOYNQcI7RBaUaa6X5xfTulFH1gTq7sPExSYpWmGnPgSQqCKcfTL2OjvzpfRm+drA==;
 5:rlDlCwlWY9kc5FO1tHvjgAuW/UeF0kJnskpfUS+ftD/p97ec0HyzwZlpZfN3GrDG7VMcwwGjcvNzY8Rb++S/sHH9xPvBRue1tsrri7wiWNxKLE/ONP/4w7g+Rh/+8ZsyKIRCfrhFBAQlvA+4pW+SzSh+kJ8Uv7EXW/NqUX9/Jro=;
 7:ymUticdfiTm52/0gvMDwHsmZjoKHO8V8e5GQfGagZnPd9M1ndWRImYLu443Pi/g0XCO6y/7EyUG2XXNIpFl3kvEWACBUGfQpTQK4pRa7MVLBBlArnOT0mEk14/oErngtw7cE3myHSvPyvMM3vr9ayw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f4107000-b374-4bb2-499a-08d66d58e56b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5028; 
x-ms-traffictypediagnostic: AM0PR04MB5028:
x-microsoft-antispam-prvs: <AM0PR04MB5028A2A1DD06512F2D4FA97980B00@AM0PR04MB5028.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5028; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5028; 
x-forefront-prvs: 09011458FC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(39860400002)(396003)(376002)(346002)(52314003)(189003)(199004)(54534003)(51914003)(97736004)(106356001)(7696005)(76176011)(2906002)(4326008)(39060400002)(305945005)(229853002)(6506007)(6116002)(71200400001)(105586002)(9686003)(86362001)(7736002)(102836004)(25786009)(33656002)(6246003)(53936002)(55016002)(71190400001)(3846002)(6436002)(68736007)(186003)(81156014)(478600001)(7416002)(8936002)(66066001)(44832011)(14454004)(5024004)(14444005)(256004)(81166006)(99286004)(26005)(74316002)(8676002)(446003)(486006)(5660300001)(11346002)(54906003)(316002)(6916009)(217873002)(476003)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5028;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZjInEnlVQBVQCLH9buAEWONiwyfS9VNqnbyNZ7pjssxjryI7kqmH5Ppk6G1p3p20bBt6bcophcFG3Bbc953Ye45VjtCPNkd2jNM6saichr3wrGTrBRc25s3e5AHnDPYX4nsfMp/UpfWAv9++EPbdmFjsIlZ6OG1/3DUoJyAJsiSyeqB9O9S+W/NqE5P4ujGwIWzjBjjDUvw4co2DLw25I7lNFOZTXjpe5xGXTCL2nPGCmXPtUbfGd6W2wPPVq5tDRjTgLJlPhtNveomqTc4uuNZTxu+QHyTn38JFeRZe4C4tpsZrQ2bGlytO1UBVgKYy
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4107000-b374-4bb2-499a-08d66d58e56b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2018 06:43:09.2116 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5028
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_224328_197958_D1F7CB3F 
X-CRM114-Status: GOOD (  41.46  )
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
> Sent: Friday, December 28, 2018 11:37 PM
> 
> On Thu, 27 Dec 2018 at 18:14, Aisheng Dong <aisheng.dong@nxp.com>
> wrote:
> >
> > Currently attach_dev() in power domain infrastructure still does not
> > support multi domains case as the struct device *dev passed down from
> > genpd_dev_pm_attach_by_id() is a virtual PD device, it does not help
> > for parsing the real device information from device tree, e.g.
> > Device/Power IDs, Clocks and it's unware of which real power domain
> > the device should attach.
> 
> Thanks for working on this!
> 
> I would appreciate if the changelog could clarify the problem a bit.
> Perhaps something along the lines of the below.
> 

Sounds good to me.
I will add them in commit message.
Thanks for the suggestion.

> "A genpd provider's ->attach_dev() callback may be invoked with a so called
> virtual device, which is created by genpd, at the point when a device is being
> attached to one of its corresponding multiple PM domains.
> 
> In these cases, the genpd provider fails to look up any resource, by a
> clk_get() for example, for the virtual device in question. This is because, the
> virtual device that was created by genpd, does not have the virt_dev->of_node
> assigned."
> 
> >
> > Extend the framework a bit to store the multi PM domains information
> > in per-device struct generic_pm_domain_data, then power domain driver
> > could retrieve it for necessary operations during attach_dev().
> >
> > Two new APIs genpd_is_mpd_device() and dev_gpd_mpd_data() are also
> > introduced to ease the driver operation.
> >
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Kevin Hilman <khilman@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > This patch is a follow-up work of the earlier discussion with Ulf
> > Hansson about the multi PM domains support for the attach_dev() function
> [1].
> > After a bit more thinking, this is a less intrusive implementation
> > with the mininum impact on the exist function definitions and calling
> follows.
> > One known little drawback is that we have to use the device driver
> > private data (device.drvdata) to pass down the multi domains
> > information in a earlier time. However, as multi PD devices are
> > created by domain framework, this seems to be safe to use it in domain
> > core code as device driver is not likely going to use it.
> > Anyway, if any better ideas, please let me know.
> >
> > With the two new APIs, the using can be simply as:
> > static int xxx_attach_dev(struct generic_pm_domain *domain,
> >                           struct device *dev) {
> >         ...
> >         if (genpd_is_mpd_device(dev)) {
> >                 mpd_data = dev_gpd_mpd_data(dev);
> >                 np = mpd_data->parent->of_node;
> >                 idx = mpd_data->index;
> >                 //dts parsing
> >                 ...
> >         }
> >         ...
> 
> I think we can make this a lot less complicated. Just assign virt_dev->of_node =
> of_node_get(dev->of_node), somewhere in
> genpd_dev_pm_attach_by_id() and before calling __genpd_dev_pm_attach().
> 
> Doing that, would mean the genpd provider's ->attach_dev() callback, don't
> have to distinguish between virtual and non-virtual devices.
> Instead they should be able to look up resources in the same way as they did
> before.
> 

Yes, that seems like a smart way.
But there's still a remain problem that how about the domain index information
needed for attach_dev()?

Regards
Dong Aisheng

> Kind regards
> Uffe
> 
> > }
> >
> > ---
> >  drivers/base/power/domain.c | 31 +++++++++++++++++++++++++++++++
> >  include/linux/pm_domain.h   | 23 +++++++++++++++++++++++
> >  2 files changed, 54 insertions(+)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 7f38a92..1aa0918 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -1343,6 +1343,9 @@ static struct generic_pm_domain_data
> *genpd_alloc_dev_data(struct device *dev,
> >         gpd_data->td.effective_constraint_ns =
> PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
> >         gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
> >
> > +       if (genpd_is_mpd_device(dev))
> > +               gpd_data->mpd_data = dev_get_drvdata(dev);
> > +
> >         spin_lock_irq(&dev->power.lock);
> >
> >         if (dev->power.subsys_data->domain_data) { @@ -2179,6 +2182,7
> > @@ EXPORT_SYMBOL_GPL(of_genpd_remove_last);
> >
> >  static void genpd_release_dev(struct device *dev)  {
> > +       kfree(dev->driver_data);
> >         kfree(dev);
> >  }
> >
> > @@ -2320,6 +2324,20 @@ int genpd_dev_pm_attach(struct device *dev)
> > EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
> >
> >  /**
> > + * genpd_is_mpd_device - Check if a device is associated with multi
> > + PM domains
> > + * @dev: Device to check.
> > + */
> > +
> > +bool genpd_is_mpd_device(struct device *dev) {
> > +       if (!dev || (dev && !dev->bus))
> > +               return false;
> > +
> > +       return dev->bus == &genpd_bus_type; };
> > +EXPORT_SYMBOL_GPL(genpd_is_mpd_device);
> > +
> > +/**
> >   * genpd_dev_pm_attach_by_id - Associate a device with one of its PM
> domains.
> >   * @dev: The device used to lookup the PM domain.
> >   * @index: The index of the PM domain.
> > @@ -2338,6 +2356,7 @@ EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
> >  struct device *genpd_dev_pm_attach_by_id(struct device *dev,
> >                                          unsigned int index)  {
> > +       struct pm_domain_mpd_data *mpd_data;
> >         struct device *genpd_dev;
> >         int num_domains;
> >         int ret;
> > @@ -2366,6 +2385,18 @@ struct device
> *genpd_dev_pm_attach_by_id(struct device *dev,
> >                 return ERR_PTR(ret);
> >         }
> >
> > +       /* Allocate multi power domains data */
> > +       mpd_data = kzalloc(sizeof(*mpd_data), GFP_KERNEL);
> > +       if (!mpd_data) {
> > +               device_unregister(genpd_dev);
> > +               return ERR_PTR(-ENOMEM);
> > +       }
> > +
> > +       mpd_data->parent = dev;
> > +       mpd_data->index = index;
> > +
> > +       dev_set_drvdata(genpd_dev, mpd_data);
> > +
> >         /* Try to attach the device to the PM domain at the specified index.
> */
> >         ret = __genpd_dev_pm_attach(genpd_dev, dev->of_node, index,
> false);
> >         if (ret < 1) {
> > diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> > index 3b5d728..106d4e7 100644
> > --- a/include/linux/pm_domain.h
> > +++ b/include/linux/pm_domain.h
> > @@ -144,6 +144,11 @@ struct gpd_timing_data {
> >         bool cached_suspend_ok;
> >  };
> >
> > +struct pm_domain_mpd_data {
> > +       struct device *parent;
> > +       unsigned int index;
> > +};
> > +
> >  struct pm_domain_data {
> >         struct list_head list_node;
> >         struct device *dev;
> > @@ -151,6 +156,7 @@ struct pm_domain_data {
> >
> >  struct generic_pm_domain_data {
> >         struct pm_domain_data base;
> > +       struct pm_domain_mpd_data *mpd_data;
> >         struct gpd_timing_data td;
> >         struct notifier_block nb;
> >         unsigned int performance_state; @@ -262,10 +268,17 @@
> unsigned
> > int of_genpd_opp_to_performance_state(struct device *dev,
> >                                 struct device_node *np);
> >
> >  int genpd_dev_pm_attach(struct device *dev);
> > +bool genpd_is_mpd_device(struct device *dev);
> >  struct device *genpd_dev_pm_attach_by_id(struct device *dev,
> >                                          unsigned int index);  struct
> > device *genpd_dev_pm_attach_by_name(struct device *dev,
> >                                            char *name);
> > +
> > +static inline struct pm_domain_mpd_data *dev_gpd_mpd_data(struct
> > +device *dev) {
> > +       return dev_gpd_data(dev)->mpd_data; }
> > +
> >  #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */  static inline int
> > of_genpd_add_provider_simple(struct device_node *np,
> >                                         struct generic_pm_domain
> > *genpd) @@ -311,6 +324,11 @@ static inline int
> genpd_dev_pm_attach(struct device *dev)
> >         return 0;
> >  }
> >
> > +static bool genpd_is_mpd_device(struct device *dev) {
> > +       return false;
> > +}
> > +
> >  static inline struct device *genpd_dev_pm_attach_by_id(struct device *dev,
> >                                                        unsigned
> int
> > index)  { @@ -323,6 +341,11 @@ static inline struct device
> > *genpd_dev_pm_attach_by_name(struct device *dev,
> >         return NULL;
> >  }
> >
> > +static inline struct pm_domain_mpd_data *dev_gpd_mpd_data(struct
> > +device *dev) {
> > +       return ERR_PTR(-ENOSYS);
> > +}
> > +
> >  static inline
> >  struct generic_pm_domain *of_genpd_remove_last(struct device_node
> > *np)  {
> > --
> > 2.7.4
> >
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
