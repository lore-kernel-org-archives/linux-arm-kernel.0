Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB756C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:35:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86DE920675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i7dvLbWc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BV5H3UB0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="fHiifil9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86DE920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=agHy7u4j3C/juWtbOahDtCvSdK6OVfjKjeZLUxjJvFA=; b=i7dvLbWcN5+ziV
	6z6np+ziHhPBavQbN5xX8RgC407O6O36QBtfEBXx13Hhwvpgpf/pL95cjUDedbmcxqQkZGllVShRj
	ihl80mWeuM6MUMgxcVz0hoUghGNyA/Qv0XSROZ3P8IcIVs9nj5SWZ8TCcYQHuVKqdujNQy3j2IXPr
	vgq9/4B7uMZNMouFjUmZJUfPhclzkdY9g05WxIluWoVxPZqOxJ9BFAM4B5jp2Cq24T9/iIM+7xbE5
	FoKWvFkHiyUxwHsGgEnufy8VpQBdvJYlOI37jhh8Sq7sOXD3AsvcGXj+Ueo0N43MWzrUbSSmUnml5
	2boy7OUgdEt+5lJPqT+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf8lt-0003m9-QQ; Thu, 03 Jan 2019 19:35:13 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf8lr-0002NT-Nw
 for linux-arm-kernel@bombadil.infradead.org; Thu, 03 Jan 2019 19:35:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jaZcTt/fzcNjlPHLZXenxLbLylkL5pHWkwNhnjpGmC8=; b=BV5H3UB0Tb3pS1Kd4z+8ffC9g0
 tTvdqCLB4L0K0tlYDhtaTqdjAEiwH+ZJSYg/mhX0IXEWfY6PNjaKfNveKCI60spu7vSRR9zRYvpfM
 SoBQtPQVB8ML2PWG3cswrLB7JT0SCbv8z2iDO3/ByHfZ38ZmH7otrQmgW9xvc9Q4t58+xuMqWOMmK
 E9SeujDqUP6o1tqI7yN4FMoZ8oRe18Ri1r/yaRud1Yu0vWBB2Qx12XQcR26ZJVETnxUBuS2q6q6qk
 yyWqKce5YxF8MlbUIQQ8m/7lHnynduXUadsXKvQSelhSJ0Fc+m8jwZxWWV9Caglj2ysaBTO6ks47b
 RgTdBibQ==;
Received: from mail-am5eur03on0603.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::603]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf8Xg-0007i3-8E
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 19:20:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaZcTt/fzcNjlPHLZXenxLbLylkL5pHWkwNhnjpGmC8=;
 b=fHiifil9lkbveD04gdaglwVHSK76KFcQUz7mdJ6WlQ4rTjxrAzUR9m6z9DcDTTkGfp+qSVMKzB5P/vc17jCvaQiKRrLnvo3xGck9IvCgfDv04+ZNnb9kexWL94cRmEQtjC3BfBWfkTqZ6R2H6y2J4LrFsqooCyag5GONLn+7h1Q=
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com (10.175.232.149) by
 DB6PR05MB3335.eurprd05.prod.outlook.com (10.170.221.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 19:20:27 +0000
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::434:e856:a94a:3847]) by DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::434:e856:a94a:3847%5]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 19:20:26 +0000
From: Liming Sun <lsun@mellanox.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, "y@bu-lab53.mtbu.labs.mlnx"
 <y@bu-lab53.mtbu.labs.mlnx>, Olof Johansson <olof@lixom.net>, Arnd Bergmann
 <arnd@arndb.de>, David Woods <dwoods@mellanox.com>, Robin Murphy
 <robin.murphy@arm.com>, arm-soc <arm@kernel.org>
Subject: RE: [PATCH v6 1/9] soc: Add TmFifo driver for Mellanox BlueField Soc
Thread-Topic: [PATCH v6 1/9] soc: Add TmFifo driver for Mellanox BlueField Soc
Thread-Index: AQHUcgL19IXAwWJbf0GhGYLkfBKW0KV7+vIAgCJTYKA=
Date: Thu, 3 Jan 2019 19:20:26 +0000
Message-ID: <DB6PR05MB3223FDA372C153FEF4E34D90A18D0@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1541089431-175572-1-git-send-email-lsun@mellanox.com>
 <23fff14b-0e44-651c-1dfd-8f8e07c7eaee@gmail.com>
In-Reply-To: <23fff14b-0e44-651c-1dfd-8f8e07c7eaee@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB6PR05MB3335;
 6:ASuCLLzUDqkfYc9CTlgVtc4WfpngTKAc7+0uU2fS0y0QPxUsZSgm3g9q0X5HbtmvoQTSpv9lOZy62bZNruqOm+XvEloIL8fELjtMwkvMh28eM2a9bMleElVv/JtAYHCG1Tcvx9wy2NNKmctnR7SamJRues3228E7nPk7/WbTHKiYDlr7jySZ2JLiB/0RKwiGFWFQHFmtqzHoVhnu+3mAB5YwaKfSksIVWl0bk2RGEOMaYhl9rwogbLkMcX3cl7I2B5nqVBNXSy5X6jaQFjfWMkP0xnRJUTy368n6p7z+EtqIyqKUXXKcrhGrFFmkk2C26XFgs4QNGj/xYDNW/MsRpQAIFEfXy1xCIemYDn3oT/ymhAYINXq4aoOPLzNavdRyro/2KINrFTSFcdOryiIjtDB4grxsfRm/79PNwsIb13yXBcDUiZLDDk15dNKNuM3B6oSP/ADu47wg4sixbP7crw==;
 5:MvLD5k0bl2yX33mzp3umtvYzM74mEysrISGxVVSk1+8Limbbs/V6mmGJKrhTRUQM0H50qpOHiRMsoejoas0wYiFX1QMwqijdVJ5T9OTsH39JaIX+fwBYLw96a6RH1uaqonm/e5eMlziHyCRIFqvBK2Nsr+Kzi/tmTtCZptNE00CTgETfNlyGVoQik8RmmbU9ESBa14b8+sTPqq+TjW+50g==;
 7:ZREzaOp9SpVbhIhK6IcQuBaAd2BNHkuPNdcQ+5+o1Y7WY9SxYapbxscLdWzsH9ovLhy5NLPWTQ+Q6igsR3/TvYanCmo0KDgI2D8Mvx2W9VkhVZKLtTu0NdQvzJ/kFy7v3OJVmeYx0fJwFluASNHs2A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 321bb6ae-1429-45ed-5475-08d671b08462
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB6PR05MB3335; 
x-ms-traffictypediagnostic: DB6PR05MB3335:
x-microsoft-antispam-prvs: <DB6PR05MB3335046EC2F3C8D50BA10771A18D0@DB6PR05MB3335.eurprd05.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:DB6PR05MB3335; BCL:0; PCL:0; RULEID:; SRVR:DB6PR05MB3335; 
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(6029001)(366004)(396003)(39860400002)(136003)(376002)(346002)(13464003)(199004)(189003)(110136005)(54906003)(316002)(4326008)(256004)(14444005)(86362001)(68736007)(106356001)(105586002)(33656002)(8936002)(2906002)(6246003)(66066001)(39060400002)(2501003)(229853002)(71190400001)(99286004)(71200400001)(6436002)(5660300001)(8676002)(476003)(446003)(11346002)(53936002)(74316002)(55016002)(478600001)(9686003)(25786009)(81166006)(81156014)(97736004)(3846002)(102836004)(76176011)(6506007)(53546011)(6116002)(486006)(7736002)(305945005)(7696005)(186003)(26005)(14454004)(781001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR05MB3335;
 H:DB6PR05MB3223.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0avxtDIDQJsbTAiz/7Sk7mEDHjVZl5W5hfXFytzYcrKp8wo1BFpjFkIa+PzAHiPd1VSlTpRMngLkDRx29L7b3Azdco2njRAD8cE2Fa+1PKN11X8pOEiZ6YzkxK24A2ZMZfuZhBt7zqPvx8KVXEsNGRcJ4F2kSg1ImiQmNIw3/E+xIhcY3iDPyxFZgFPULbat0ZrKoB2zTiWQe4o0KlxeApk7OjMi2w4Kpkg7B+IVOWzwnz1xK7w5Fgcvhgd6LRDbVGpB+G4Ajjrg8gyEzDYQpraGBP07Wdy7dLtO1CGzDPlt9+xStQaPeYn6QwhoVRRa
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 321bb6ae-1429-45ed-5475-08d671b08462
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 19:20:26.7122 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3335
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_192032_422758_F2FD2E81 
X-CRM114-Status: GOOD (  30.31  )
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
 "mbrugger@suse.com >> Matthias Brugger" <mbrugger@suse.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Thanks Matthias for the comments and sorry for the holiday delay.
The recommended changes have been posted in patch v7 1/9.

Thanks,
Liming

> -----Original Message-----
> From: Matthias Brugger <matthias.bgg@gmail.com>
> Sent: Wednesday, December 12, 2018 6:08 PM
> To: Liming Sun <lsun@mellanox.com>; y@bu-lab53.mtbu.labs.mlnx; Olof Johansson <olof@lixom.net>; Arnd Bergmann <arnd@arndb.de>;
> David Woods <dwoods@mellanox.com>; Robin Murphy <robin.murphy@arm.com>; arm-soc <arm@kernel.org>
> Cc: devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; mbrugger@suse.com >> Matthias Brugger <mbrugger@suse.com>
> Subject: Re: [PATCH v6 1/9] soc: Add TmFifo driver for Mellanox BlueField Soc
> 
> 
> 
> On 01/11/2018 17:23, Liming Sun wrote:> This commit adds the TmFifo driver for
> Mellanox BlueField Soc.
> > TmFifo is a shared FIFO which enables external host machine to
> > exchange data with the SoC via USB or PCIe. The driver is based on
> > virtio framework and has console and network access enabled.
> >
> > Reviewed-by: David Woods <dwoods@mellanox.com>
> > Signed-off-by: Liming Sun <lsun@mellanox.com>
> > ---
> >  drivers/soc/Kconfig                |    1 +
> >  drivers/soc/Makefile               |    1 +
> >  drivers/soc/mellanox/Kconfig       |   18 +
> >  drivers/soc/mellanox/Makefile      |    5 +
> >  drivers/soc/mellanox/tmfifo.c      | 1236 ++++++++++++++++++++++++++++++++++++
> >  drivers/soc/mellanox/tmfifo_regs.h |   76 +++
> >  6 files changed, 1337 insertions(+)
> >  create mode 100644 drivers/soc/mellanox/Kconfig
> >  create mode 100644 drivers/soc/mellanox/Makefile
> >  create mode 100644 drivers/soc/mellanox/tmfifo.c
> >  create mode 100644 drivers/soc/mellanox/tmfifo_regs.h
> >
> 
> [...]
> 
> > +
> > +/* Interrupt handler. */
> > +static irqreturn_t tmfifo_irq_handler(int irq, void *dev_id)
> > +{
> > +	int i = (uintptr_t)dev_id % sizeof(void *);
> > +	struct tmfifo *fifo = dev_id - i;
> > +
> > +	if (i < TM_IRQ_CNT && !test_and_set_bit(i, &fifo->pend_events))
> > +		schedule_work(&fifo->work);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> [...]
> > +
> > +/* Probe the TMFIFO. */
> > +static int tmfifo_probe(struct platform_device *pdev)
> > +{
> > +	u64 ctl;
> > +	struct tmfifo *fifo;
> > +	struct resource *rx_res, *tx_res;
> > +	struct virtio_net_config net_config;
> > +	int i, ret;
> > +
> > +	/* Get the resource of the Rx & Tx FIFO. */
> > +	rx_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	tx_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +	if (!rx_res || !tx_res) {
> > +		ret = -EINVAL;
> > +		goto err;
> > +	}
> > +
> > +	if (request_mem_region(rx_res->start,
> > +			       resource_size(rx_res), "bf-tmfifo") == NULL) {
> > +		ret = -EBUSY;
> > +		goto early_err;
> > +	}
> > +
> > +	if (request_mem_region(tx_res->start,
> > +			       resource_size(tx_res), "bf-tmfifo") == NULL) {
> > +		release_mem_region(rx_res->start, resource_size(rx_res));
> > +		ret = -EBUSY;
> > +		goto early_err;
> > +	}
> > +
> > +	ret = -ENOMEM;
> > +	fifo = kzalloc(sizeof(struct tmfifo), GFP_KERNEL);
> > +	if (!fifo)
> > +		goto err;
> > +
> > +	fifo->pdev = pdev;
> > +	platform_set_drvdata(pdev, fifo);
> > +
> > +	spin_lock_init(&fifo->spin_lock);
> > +	INIT_WORK(&fifo->work, tmfifo_work_handler);
> > +
> > +	timer_setup(&fifo->timer, tmfifo_timer, 0);
> > +	fifo->timer.function = tmfifo_timer;
> > +
> > +	for (i = 0; i < TM_IRQ_CNT; i++) {
> > +		fifo->irq[i] = platform_get_irq(pdev, i);
> > +		ret = request_irq(fifo->irq[i], tmfifo_irq_handler, 0,
> > +				  "tmfifo", (u8 *)fifo + i);
> 
> I think it would be better if you create a struct that passes a pointer to fifo
> and the ID instead of "hiding" the ID inside the address.
> 
> Regards,
> Matthias
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
