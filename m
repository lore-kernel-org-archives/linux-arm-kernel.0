Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7670C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:12:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F422082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ply9Y+Ye";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="FCD+dTQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F422082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TSS+eRHzLuOW6sW/0ZLxZqRAgwABSq5GZWHyjO8Y+Bo=; b=ply9Y+Ye9ibMPU
	8vC0CA4n4qLqYdsRtBuMDcRj/w7Db9vDip38KLzrComxds9w/glS/07YLOXzWlFVhyfiiSeK/c/2x
	gWJOPOakSnDqht6EBczqhickg1PAMvsP81uvthZhVacIPPHO69IXziF/9Tt3fptYeVqFpcHmaplc5
	QCpykiUO4DXfclBu/2eFXFwW6JV/FnApgsB8HQzxvHj3SRbxqVd6bsRprZr63cpx6p88/k6LCgpyQ
	eWHUHtkJmc8v/y/lqvmAquCZj/VdhrKbE0hTEG9P14+w2B3IkHlb9N3bxjgpC5YDlGMlb3eZj6tYo
	R9ObaAqmLTneH1ycOS0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUIvV-0006ss-E4; Tue, 04 Dec 2018 22:12:21 +0000
Received: from mail-eopbgr70088.outbound.protection.outlook.com ([40.107.7.88]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUIvR-0006ry-5j
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 22:12:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KKl1HyTv+C0tzoD1wMeJ3LzHejf8FzvTq67oI2jfRg=;
 b=FCD+dTQR0Q7gZDcbJPXb4tvw30O95/7ySaaP7t6PBHIKy3ELCMlj6Bf5YPdJr0t7UEHdjrcmYUA+VuodSEmGsytnPietFa/QzvnreYyR89sI9amqZRtuspSEO/9sTf8YZpx+PoRrsIS5pZnhT9x3yecYhyeODIE9l1iYw1zGLXk=
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com (10.175.232.149) by
 DB6PR05MB3464.eurprd05.prod.outlook.com (10.170.223.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Tue, 4 Dec 2018 22:12:00 +0000
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d16b:3dcb:b890:1504]) by DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d16b:3dcb:b890:1504%2]) with mapi id 15.20.1404.019; Tue, 4 Dec 2018
 22:12:00 +0000
From: Liming Sun <lsun@mellanox.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v4 1/4] soc: Add TmFifo driver for Mellanox BlueField Soc
Thread-Topic: [PATCH v4 1/4] soc: Add TmFifo driver for Mellanox BlueField Soc
Thread-Index: AQHUa8LQWzm4kH4yZEq8H9KDd+P1HKUwH2kAgD9D8xA=
Date: Tue, 4 Dec 2018 22:12:00 +0000
Message-ID: <DB6PR05MB3223F3BF022DE61725C98D66A1AF0@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1540403734-137721-1-git-send-email-lsun@mellanox.com>
 <CAK8P3a0VJkQgqaq7na1_KTQzVs4-PvxYghv5_LysW7EdeBM7fw@mail.gmail.com>
In-Reply-To: <CAK8P3a0VJkQgqaq7na1_KTQzVs4-PvxYghv5_LysW7EdeBM7fw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB6PR05MB3464;
 6:hvUHWhSFJ0nY/yUy6jAKueSJAn2MOZDchaZGIYmRf/rSs1vnTB6sh4vvj0v418GWh1oUOy4MMEKB0OfUff39u20n+nzkju+yyxlmXrtVqgx1SfCwy/wSCZ803V7FfieFIDhplshwJBDcJmFK3TfqkzLvdyS1leY08v3BZ2NizUcLL9sSUDLzT7X5L2Wd5qHLZTzOaI5WtkA+APyZAwNzr/YEsE3bVrrbeQstpr8IFPTavumDw47KNPfi9WwG6YAJKq5TypwIJ7uw+X5Fn5NkGy5d4GaWcOnO9xkHlu4fq2hrZlwx8qNrd5669KpREjabZKJ5dhqcaF2VxIGQaOc9xjxg74vN9UwCAlg9LCrrX72/2D7gWpoX/A0y5xBz14e6KQdI0mnXAaGdJPQ5Jk7yKhZHEJgINkemxCrfPId1RZVchCUUgJYfud0UYq0Bx4D+e67o6MspWtM1gVaZmZU7HQ==;
 5:xW7h2PLH+U+guFlVm1c6cBKXSbVkdXWnY57kzg7mkaaoBvwoPmfRydKYda8TgY6OMk//H7DQKY6a/QaGCFQhhvOBjxbYUO0ofkxAzutiHpn4Myk/4t+6UoP5qUycgmOhDnzY3WoXIFDTQTtI51bouV8//1soCOsst3xBD+haC+w=;
 7:Me78SjF2BI9Ml9AVPb+tfACVD1AG3RqHVwBRvslaggc5ygimT5vixYAco964QcjwFXSC47LdKKYujekS2xOu5PZLw1cXr/OysuaeuJ+8nEBYJlPnF0j4GhSAurUA1j50a27tAZC09suaE5BLv3EmQw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 36abbb78-1187-4726-9814-08d65a35836b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB6PR05MB3464; 
x-ms-traffictypediagnostic: DB6PR05MB3464:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com; 
x-microsoft-antispam-prvs: <DB6PR05MB3464991374352CEB564378C0A1AF0@DB6PR05MB3464.eurprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(944501514)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:DB6PR05MB3464; BCL:0; PCL:0; RULEID:; SRVR:DB6PR05MB3464; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(6029001)(39860400002)(346002)(366004)(136003)(396003)(376002)(199004)(189003)(13464003)(71200400001)(14444005)(71190400001)(9686003)(6916009)(229853002)(476003)(8936002)(966005)(11346002)(486006)(4326008)(81156014)(81166006)(8676002)(256004)(6436002)(6306002)(66066001)(55016002)(446003)(478600001)(25786009)(53936002)(6246003)(2906002)(68736007)(86362001)(7736002)(305945005)(54906003)(99286004)(14454004)(106356001)(6506007)(102836004)(7696005)(186003)(74316002)(76176011)(33656002)(316002)(6116002)(26005)(53546011)(5660300001)(105586002)(97736004)(3846002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR05MB3464;
 H:DB6PR05MB3223.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: a04LMr9r651warHlEWeng7Cj7st16F1ib59tVgVFQqHRGjdqcCccJOEjIF19SGHMfPWiM9QAPqJIKX8waZTqGfieaytd3abjEBd+Hv3YxruF7GVXsKLSbSPfx1avCWuOID4y8/JYxx89ESS6M6zH/n3oKoaw7ybGK1ZFxSj+nPNfjjmgHQ8O4EXDNm2OJlATDApQgKKCtHgO6vhen8ZRjgLZC0PS6TyGFmEWBw37BF6phbQsTXzbT9CC8b7KkfP7icmucHJ5epDjpbxPMAHSqFSRh8FvJHFoOZE8EW4DM/izYWJEXcwCJ7zXO0/HrfMhxB3f3UT8g/n1gqm66CT7REnK+DEb9CAlvQ1G4BtzExc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36abbb78-1187-4726-9814-08d65a35836b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 22:12:00.2776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3464
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_141217_279513_34C98523 
X-CRM114-Status: GOOD (  26.35  )
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
 David Woods <dwoods@mellanox.com>, arm-soc <arm@kernel.org>,
 Olof Johansson <olof@lixom.net>, Robin Murphy <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Just an update that I have uploaded new patch series v6, which includes the other half of the driver that runs on the external USB host machine, and also tries to resolve the previous comments.

The v6 patches could also be found at
https://patchwork.kernel.org/project/linux-arm-kernel/list/?submitter=176699

Thanks!

-----Original Message-----
From: arndbergmann@gmail.com <arndbergmann@gmail.com> On Behalf Of Arnd Bergmann
Sent: Thursday, October 25, 2018 11:58 AM
To: Liming Sun <lsun@mellanox.com>
Cc: Olof Johansson <olof@lixom.net>; David Woods <dwoods@mellanox.com>; Robin Murphy <robin.murphy@arm.com>; arm-soc <arm@kernel.org>; devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/4] soc: Add TmFifo driver for Mellanox BlueField Soc

On 10/24/18, Liming Sun <lsun@mellanox.com> wrote:
> This commit adds the TmFifo driver for Mellanox BlueField Soc.
> TmFifo is a shared FIFO which enables external host machine to 
> exchange data with the SoC via USB or PCIe. The driver is based on 
> virtio framework and has console and network access enabled.
>
> Reviewed-by: David Woods <dwoods@mellanox.com>
> Signed-off-by: Liming Sun <lsun@mellanox.com>

I definitely like the idea of using virtio-net and virtio-console here, this is a great way of reusing the existing high-level drivers, and i similar in concept (but also much simpler) to what we have in drivers/misc/mic/ for another Linux-running machine that can be a PCIe add-on card.

Have you also posted the other half of this driver? I'd like to see how it all fits together.

A few style comments:

> +
> +#define TMFIFO_GET_FIELD(reg, mask)	FIELD_GET(mask, reg)
> +
> +#define TMFIFO_SET_FIELD(reg, mask, value) \
> +	((reg & ~mask) | FIELD_PREP(mask, value))

I think it would be nicer to use FIELD_GET/FIELD_PREP in the code directly, and avoid adding extra wrappers around them.

> +/* Vring size. */
> +#define TMFIFO_VRING_SIZE			1024
> +
> +/* Console Tx buffer size. */
> +#define TMFIFO_CONS_TX_BUF_SIZE			(32 * 1024)
> +
> +/* Use a timer for house-keeping. */
> +static int tmfifo_timer_interval = HZ / 10;
> +
> +/* Global lock. */
> +static struct mutex tmfifo_lock;

Maybe use 'static DEFINE_MUTEX(tmfifo_lock) here and remove the initialization call.

> +/* Virtio ring size. */
> +static int tmfifo_vring_size = TMFIFO_VRING_SIZE; 
> +module_param(tmfifo_vring_size, int, 0444); 
> +MODULE_PARM_DESC(tmfifo_vring_size, "Size of the vring.");
> +
> +struct tmfifo;
> +
> +/* A flag to indicate TmFifo ready. */ static bool tmfifo_ready;
> +
> +/* Virtual devices sharing the TM FIFO. */
> +#define TMFIFO_VDEV_MAX		(VIRTIO_ID_CONSOLE + 1)
> +
> +/* Spin lock. */
> +static DEFINE_SPINLOCK(tmfifo_spin_lock);

Generally speaking, it's nicer to write a driver in a way that avoids global variables and make the flags and locks all members of a device specific structure.

> +struct tmfifo_vdev {
> +	struct virtio_device vdev;	/* virtual device */
> +	u8 status;
> +	u64 features;
> +	union {				/* virtio config space */
> +		struct virtio_console_config cons;
> +		struct virtio_net_config net;
> +	} config;
> +	struct tmfifo_vring vrings[TMFIFO_VRING_NUM];
> +	u8 *tx_buf;			/* tx buffer */
> +	u32 tx_head;			/* tx buffer head */
> +	u32 tx_tail;			/* tx buffer tail */
> +};

I suppose you did this to keep the driver simple, but it seems a little inflexible to only support two specific device types. Wouldn't we also want e.g. 9pfs or virtio_blk in some configurations?

> +
> +#define TMFIFO_VDEV_TX_BUF_AVAIL(vdev) \
> +	(((vdev)->tx_tail >= (vdev)->tx_head) ? \
> +	(TMFIFO_CONS_TX_BUF_SIZE - 8 - ((vdev)->tx_tail - (vdev)->tx_head)) : \
> +	((vdev)->tx_head - (vdev)->tx_tail - 8))
> +
> +#define TMFIFO_VDEV_TX_BUF_PUSH(vdev, len) do { \
> +	(vdev)->tx_tail += (len); \
> +	if ((vdev)->tx_tail >= TMFIFO_CONS_TX_BUF_SIZE) \
> +		(vdev)->tx_tail -= TMFIFO_CONS_TX_BUF_SIZE; \ } while (0)
> +
> +#define TMFIFO_VDEV_TX_BUF_POP(vdev, len) do { \
> +	(vdev)->tx_head += (len); \
> +	if ((vdev)->tx_head >= TMFIFO_CONS_TX_BUF_SIZE) \
> +		(vdev)->tx_head -= TMFIFO_CONS_TX_BUF_SIZE; \ } while (0)

It would be nicer to turn these into inline functions rather than macros.

> +/* TMFIFO device structure */
> +struct tmfifo {
> +	struct tmfifo_vdev *vdev[TMFIFO_VDEV_MAX];	/* virtual devices */
> +	struct platform_device *pdev;	/* platform device */
> +	struct mutex lock;
> +	void __iomem *rx_base;		/* mapped register base */
> +	void __iomem *tx_base;		/* mapped register base */
> +	int tx_fifo_size;		/* number of entries of the Tx FIFO */
> +	int rx_fifo_size;		/* number of entries of the Rx FIFO */
> +	unsigned long pend_events;	/* pending bits for deferred process */
> +	int irq[TM_IRQ_CNT];		/* irq numbers */
> +	struct work_struct work;	/* work struct for deferred process */
> +	struct timer_list timer;	/* keepalive timer */
> +	struct tmfifo_vring *vring[2];	/* current Tx/Rx ring */
> +};
> +
> +union tmfifo_msg_hdr {
> +	struct {
> +		u8 type;		/* message type */
> +		__be16 len;		/* payload length */
> +		u8 unused[5];		/* reserved, set to 0 */
> +	} __packed;
> +	u64 data;
> +};
> +
> +/*
> + * Default MAC.
> + * This MAC address will be read from EFI persistent variable if
> configured.
> + * It can also be reconfigured with standard Linux tools.
> + */
> +static u8 tmfifo_net_default_mac[6] = {0x00, 0x1A, 0xCA, 0xFF, 0xFF,
> 0x01};
> +

Is a predefined MAC address better than a random one here?

For DT based systems, we tend to also call of_get_mac_address() in order to allow setting a unique address from firmware.

> +/* Forward declaration. */
> +static void tmfifo_virtio_rxtx(struct virtqueue *vq, bool is_rx); 
> +static void tmfifo_release_pkt(struct virtio_device *vdev,
> +			       struct tmfifo_vring *vring,
> +			       struct vring_desc **desc);

Try to avoid forward declarations by reordering the functions according to how they get called.

> +
> +/* Interrupt handler. */
> +static irqreturn_t tmfifo_irq_handler(int irq, void *dev_id) {
> +	int i = (uintptr_t)dev_id % sizeof(void *);
> +	struct tmfifo *fifo = dev_id - i;
> +
> +	if (i < TM_IRQ_CNT && !test_and_set_bit(i, &fifo->pend_events))
> +		schedule_work(&fifo->work);
> +
> +	return IRQ_HANDLED;
> +}

Maybe using a request_threaded_irq() would be a better way to defer the handler into IRQ context.

        Arnd
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
