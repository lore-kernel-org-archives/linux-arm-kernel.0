Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5D1C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:31:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79B52082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="txHcxh/A";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pJXfV9JW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rzzQVRDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79B52082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZzUo+aHzMNlb7ymtRWMZf425WEKgm9WSE+cOEQeliW4=; b=txHcxh/AIu029D
	636xPcqv9+/yMkomdcNxnakkmbikN7uNEDV/e6BvdagRhNfDT+UKrudAhHyVz5s0iL25aXKXVevJM
	HDusfCcSTKU6o1g13HzGEUauOgx9qRtAxh7SNrSWnAxz0wt7QD5wOf+XSksNw8Us9mdvQdNgdZiui
	9D3zwVZTo6DcZsPuHSBXFGc00IETbj0IULOQvHrVfxVtseLZJEkK9nq22IfNbYcEchqr0KgHd8GIK
	qzd4HdTNcFtuDIzD2D3NT1OEKiJG6vnll5a5cZ8rGnRKSuTD9S724OsYh+lsbskIotKMvUTHTUm7s
	PkHHd/rRprSlveRqdtPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU7zC-0007Dl-P5; Tue, 04 Dec 2018 10:31:26 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU7zA-0007DW-Lo
 for linux-arm-kernel@bombadil.infradead.org; Tue, 04 Dec 2018 10:31:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NvN/KDNRRS98311dJ46mtWdl8jkrMlrtUquskicRCqQ=; b=pJXfV9JWFpj5ptlBBLL6LnPcxn
 iRp8xkIPByfAV+g+RPafbZynuddijkG2pfv1bjnTX7/9wrlH2p7MZNHXbSOS8FIpiwj9BGCR0bhvg
 I5cF9a6tbdX5FgcWHr12ri0nybqzv3ZCpLaX9J6dRutNrQe2kQMQXwSB+rbG5ThL+e1YpMwt4uEv/
 cgQ3pfgn8/BY8STTCyH1KKdIoN4DIqjpbeFfSCf6ySrYjSwFk05BL2ZnecqINA6XDIWRlSnJHpqg1
 4DhDJV4aLGo06KHeQ+/UHjQCs0EULcEu/KIIBshKXE8gl1e9myaIYGCQDJztv3nwXAA78v1c8Uf+x
 oeFenPgQ==;
Received: from mail-eopbgr10040.outbound.protection.outlook.com ([40.107.1.40]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU7R8-0000F6-EA
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:56:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvN/KDNRRS98311dJ46mtWdl8jkrMlrtUquskicRCqQ=;
 b=rzzQVRDuqItQa0hgLl7v3lLqPpERLLcmJg4EvniSLZcDW03VcUgaLLE1bb080yg4Elh2M/Y5BhKrprXhiwrv6h+xR6jdhW9A3KgX6LmxKpy7S7NTUD/BdE8xBK0J4BxBTRygNte731/CM2xZUMKHMnkjfcDpTtyYnNy9Fq+67TE=
Received: from AM5PR0402MB2785.eurprd04.prod.outlook.com (10.175.41.15) by
 AM5PR0402MB2705.eurprd04.prod.outlook.com (10.175.40.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 09:55:58 +0000
Received: from AM5PR0402MB2785.eurprd04.prod.outlook.com
 ([fe80::9d72:48b9:59c6:6dfa]) by AM5PR0402MB2785.eurprd04.prod.outlook.com
 ([fe80::9d72:48b9:59c6:6dfa%4]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 09:55:58 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 2/2] soc: fsl: dpio: use a cpumask to identify which cpus
 are unused
Thread-Topic: [PATCH 2/2] soc: fsl: dpio: use a cpumask to identify which cpus
 are unused
Thread-Index: AQHUdOozdrDXEgXDnkqgugAphJD21qVthS6AgAD/22A=
Date: Tue, 4 Dec 2018 09:55:58 +0000
Message-ID: <AM5PR0402MB2785A41133A6434F4D4F053DE0AF0@AM5PR0402MB2785.eurprd04.prod.outlook.com>
References: <1541410219-9943-1-git-send-email-ioana.ciornei@nxp.com>
 <1541410219-9943-3-git-send-email-ioana.ciornei@nxp.com>
 <CADRPPNRiem+c2fK2RWyvopvre9ZBqT=6n8KxGJ1THtBpbA0d-Q@mail.gmail.com>
In-Reply-To: <CADRPPNRiem+c2fK2RWyvopvre9ZBqT=6n8KxGJ1THtBpbA0d-Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM5PR0402MB2705;
 6:4NFEqCYRYzJJTnsFZvvYcAYCW1odqkrlm6gVvFSM7KVfxYEu90G4AlypWLyssZoBcFLlm62Mix79Qu1Tsz2CuqYZMUmmSoYP6BV9+NnbBsrfddG4ZbsP6OF896SuQdgiAOTY4PiiuH3VHM9WJAO7Abb64kBlLcB20ZvrIoEctry8YxxgA6zX7vd6RIa60ns4LSDpRGxcj/lpwNXAnz5Upj8XtcxYug3WMSA9bgoYRa7+lbj6qeXRI/7cppw5JWPRwGIjVXglC283KenDlE9/imrC5vvMGRJ0sYlXhGhZqgo64n3hB8xrhO8xRzubArxdnB9mnah/BBMiC2vDPj9sm4RPKXmtvMihBkiIXRSBzFjboV7I0GFI9P9O0KuQ15/ezCkuXj+HbmcOt2RJ/BAKpop9y9fLi2m50tOUOrhV62qNtA1dNafbH4bfNjtdtK2xx5Sh1ZKk2UiaE6KFGZSRNg==;
 5:Vq0D0kh9NRf+JL9dk303gs8Obe8hjscvvOIiepa+9FJQrJMKh7K3CKP2tN85MyP4HGqPBIOmQve9earswv95WjIzjUYqbbi/AkKVpw6CXfk6vnXn3ARSa3dpmtnF6EPwrHb2YrhXzY90WJXK5sq643x9xlvbbJ+YhpGeZqJ8GyI=;
 7:JRhDF4PtF4GXzDA2W+J5lOUvl/Emz2MHgfywoq01DpU+a6Aybnt8OCwxdahjvgDBgGphUxqb6n9AGgY2MHXmwz33x1X0WdqL+zcBi/MXCFh3IyIhn9ZmxzPVFV6f2iMi8Bukoc75bwMUR6qkhKcT+w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: af7fe039-d3ef-48be-e6b2-08d659ceb0e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR0402MB2705; 
x-ms-traffictypediagnostic: AM5PR0402MB2705:
x-microsoft-antispam-prvs: <AM5PR0402MB27052178F64ADB6435482475E0AF0@AM5PR0402MB2705.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:AM5PR0402MB2705; BCL:0; PCL:0; RULEID:; SRVR:AM5PR0402MB2705; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(97736004)(6116002)(3846002)(4326008)(229853002)(14454004)(106356001)(5660300001)(105586002)(6862004)(33656002)(6636002)(68736007)(11346002)(71190400001)(9686003)(44832011)(446003)(71200400001)(486006)(476003)(55016002)(2906002)(53936002)(478600001)(14444005)(256004)(25786009)(7736002)(99286004)(305945005)(86362001)(6246003)(8936002)(7696005)(76176011)(316002)(6436002)(74316002)(81156014)(81166006)(8676002)(6506007)(102836004)(66066001)(26005)(186003)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR0402MB2705;
 H:AM5PR0402MB2785.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +6P8KM6p3qLKVbPHa8icbBDvbHiu+J5auIUAZ2DvcIgR2UltJuQb0Taek42kkx0DyrQR7PQ+CLpc1WcUJFtWHzCGHfDdMK44qK8wnhbWPcVJV6MDeQ1NHC1VcpO5zIDyEb45uue7EfnPDOK/b2/G+D602BrLNCGPCtHbD8M9dpuf1HIdHD6kfXm7nF/RlMYyflwtHY1iGTyXYDq0HGul1V6XC4DK9blwJ/iMMf/tHfS5c4tPfD6tLUmndQIvb1yjLsdc5IFKx5lgwpIKEfdSL60hzTnVG6NnAFGxNqR8SeMT5XIEsYcCQxdEqSwhvWRC83sr2PNK6BsLo/Xc4sJ1sLUEcUToybxg+Hk10tVMcvE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7fe039-d3ef-48be-e6b2-08d659ceb0e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 09:55:58.4166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2705
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_045614_498773_719705C7 
X-CRM114-Status: GOOD (  30.76  )
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
Cc: Horia Geanta <horia.geanta@nxp.com>,
 Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
 Roy Pledge <roy.pledge@nxp.com>, Youri Querry <youri.querry_1@nxp.com>,
 lkml <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC
 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> >
> > The current implementation of the dpio driver uses a static next_cpu
> > variable to keep track of the index of the next cpu available. This
> > approach does not handle well unbinding and binding dpio devices in a
> > random order. For example, unbinding a dpio and then binding it again
> > with the driver, will generate the below error:
> >
> > $ echo dpio.5 > /sys/bus/fsl-mc/drivers/fsl_mc_dpio/unbind
> > $ echo dpio.5 > /sys/bus/fsl-mc/drivers/fsl_mc_dpio/bind
> > [  103.946380] fsl_mc_dpio dpio.5: probe failed. Number of DPIOs
> > exceeds NR_CPUS.
> > [  103.955157] fsl_mc_dpio dpio.5: fsl_mc_driver_probe failed: -34
> > -bash: echo: write error: No such device
> >
> > Fix this error by keeping a global cpumask of unused cpus that will be
> > updated at every dpaa2_dpio_[probe,remove].
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> >  drivers/soc/fsl/dpio/dpio-driver.c  | 25 ++++++++++++++++---------
> > drivers/soc/fsl/dpio/dpio-service.c |  6 ++++++
> >  include/soc/fsl/dpaa2-io.h          |  2 ++
> >  3 files changed, 24 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/soc/fsl/dpio/dpio-driver.c
> > b/drivers/soc/fsl/dpio/dpio-driver.c
> > index e58fcc9..832175c 100644
> > --- a/drivers/soc/fsl/dpio/dpio-driver.c
> > +++ b/drivers/soc/fsl/dpio/dpio-driver.c
> > @@ -30,6 +30,8 @@ struct dpio_priv {
> >         struct dpaa2_io *io;
> >  };
> >
> > +static cpumask_var_t cpus_unused_mask;
> > +
> >  static irqreturn_t dpio_irq_handler(int irq_num, void *arg)  {
> >         struct device *dev = (struct device *)arg; @@ -86,7 +88,7 @@
> > static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
> >         struct dpio_priv *priv;
> >         int err = -ENOMEM;
> >         struct device *dev = &dpio_dev->dev;
> > -       static int next_cpu = -1;
> > +       int possible_next_cpu;
> >
> >         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >         if (!priv)
> > @@ -128,17 +130,14 @@ static int dpaa2_dpio_probe(struct fsl_mc_device
> *dpio_dev)
> >         desc.dpio_id = dpio_dev->obj_desc.id;
> >
> >         /* get the cpu to use for the affinity hint */
> > -       if (next_cpu == -1)
> > -               next_cpu = cpumask_first(cpu_online_mask);
> > -       else
> > -               next_cpu = cpumask_next(next_cpu, cpu_online_mask);
> > -
> > -       if (!cpu_possible(next_cpu)) {
> > +       possible_next_cpu = cpumask_first(cpus_unused_mask);
> > +       if (possible_next_cpu >= nr_cpu_ids) {
> >                 dev_err(dev, "probe failed. Number of DPIOs exceeds NR_CPUS.\n");
> >                 err = -ERANGE;
> >                 goto err_allocate_irqs;
> >         }
> > -       desc.cpu = next_cpu;
> > +       desc.cpu = possible_next_cpu;
> > +       cpumask_clear_cpu(possible_next_cpu, cpus_unused_mask);
> >
> >         /*
> >          * Set the CENA regs to be the cache inhibited area of the
> > portal to @@ -211,7 +210,7 @@ static int dpaa2_dpio_remove(struct
> > fsl_mc_device *dpio_dev)  {
> >         struct device *dev;
> >         struct dpio_priv *priv;
> > -       int err;
> > +       int err = 0, cpu;
> >
> >         dev = &dpio_dev->dev;
> >         priv = dev_get_drvdata(dev);
> > @@ -220,6 +219,9 @@ static int dpaa2_dpio_remove(struct fsl_mc_device
> > *dpio_dev)
> >
> >         dpio_teardown_irqs(dpio_dev);
> >
> > +       cpu = dpaa2_io_get_cpu(priv->io);
> > +       cpumask_set_cpu(cpu, cpus_unused_mask);
> > +
> >         err = fsl_mc_portal_allocate(dpio_dev, 0, &dpio_dev->mc_io);
> >         if (err) {
> >                 dev_err(dev, "MC portal allocation failed\n"); @@
> > -267,11 +269,16 @@ static int dpaa2_dpio_remove(struct fsl_mc_device
> > *dpio_dev)
> >
> >  static int dpio_driver_init(void)
> >  {
> > +       if (!zalloc_cpumask_var(&cpus_unused_mask, GFP_KERNEL))
> > +               return -ENOMEM;
> > +       cpumask_copy(cpus_unused_mask, cpu_online_mask);
> > +
> >         return fsl_mc_driver_register(&dpaa2_dpio_driver);
> >  }
> >
> >  static void dpio_driver_exit(void)
> >  {
> > +       free_cpumask_var(cpus_unused_mask);
> >         fsl_mc_driver_unregister(&dpaa2_dpio_driver);
> >  }
> >  module_init(dpio_driver_init);
> > diff --git a/drivers/soc/fsl/dpio/dpio-service.c
> > b/drivers/soc/fsl/dpio/dpio-service.c
> > index 21c3e32..3198265 100644
> > --- a/drivers/soc/fsl/dpio/dpio-service.c
> > +++ b/drivers/soc/fsl/dpio/dpio-service.c
> > @@ -214,6 +214,12 @@ irqreturn_t dpaa2_io_irq(struct dpaa2_io *obj)
> >         return IRQ_HANDLED;
> >  }
> >
> > +int dpaa2_io_get_cpu(struct dpaa2_io *d) {
> > +       return d->dpio_desc.cpu;
> > +}
> > +EXPORT_SYMBOL(dpaa2_io_get_cpu);
> 
> Although this function is very simple function and probably self-explanatory, it is
> required that exported APIs have a kernel-doc comment just like other functions
> in the file.

Sorry for that. Will send an updated version to fix this.

Ioana

> 
> > +
> >  /**
> >   * dpaa2_io_service_register() - Prepare for servicing of FQDAN or CDAN
> >   *                               notifications on the given DPIO service.
> > diff --git a/include/soc/fsl/dpaa2-io.h b/include/soc/fsl/dpaa2-io.h
> > index ab51e40..1c1764f 100644
> > --- a/include/soc/fsl/dpaa2-io.h
> > +++ b/include/soc/fsl/dpaa2-io.h
> > @@ -90,6 +90,8 @@ struct dpaa2_io_notification_ctx {
> >         void *dpio_private;
> >  };
> >
> > +int dpaa2_io_get_cpu(struct dpaa2_io *d);
> > +
> >  int dpaa2_io_service_register(struct dpaa2_io *service,
> >                               struct dpaa2_io_notification_ctx *ctx);
> > void dpaa2_io_service_deregister(struct dpaa2_io *service,
> > --
> > 1.9.1
> >
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
