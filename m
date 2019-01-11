Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1200FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:58:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9377206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="owZN7pCO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="eqbQ4Eyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9377206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jpcmqWUJOmQQnqdNfUM4WnUYiL06Ja1jfPlFqVACC7Y=; b=owZN7pCOg3kVEQ
	WoNShLUH8L0rvcPkFSM6CP6fV19y8GJVIPeLi+TiR3sbrKUX/b60Bib3SzKdksWIHMJboChkcNk7N
	6xr2+s4i6lfZShEkliaMItWsDMO5gHaG3aguN8t902PK2j4xPBis/EcGc40dM5IUL33Ki2M/IdFd0
	ohINMLOFJUjTiJt9YQIjzs7kLrfQ94NXMiS3WfNtAUOdVuyUQ/MEa34FnakOI/aQDcbf4P3taVeDD
	AomBY2IRQPiIUUudeK2T1ivdh5MUV95LCfnhjB/3QTc2mvXa5chla29jRHL2xcKxeMVh79d+apyaZ
	IaUx6UOhsC2cNdGAjHTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghl9b-0005vt-0i; Fri, 11 Jan 2019 00:58:31 +0000
Received: from mail-eopbgr810049.outbound.protection.outlook.com
 ([40.107.81.49] helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghl9X-0005vJ-EZ
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 00:58:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPhWs/HSyOIgzZczKf0f3dLYRdGbiPE+tbKEm5vnYcU=;
 b=eqbQ4Eyyk8LmVFKdZyKtOdhVInv/Dv2omFL8/w2vFK2TnZvt4vuy1hLau3NWO3ZK3B+inf3i3IXaqoFnUZXr6KJJl4N+x4w4yp2UUofAwbELAvph/kdZq13YYAqR9rh7GZLcgpo2pNRXhwh4HBtGQrVWoQdl03rG+a5MDFJh2vY=
Received: from DM6PR02MB4890.namprd02.prod.outlook.com (20.176.111.31) by
 DM6PR02MB4171.namprd02.prod.outlook.com (20.176.75.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Fri, 11 Jan 2019 00:58:24 +0000
Received: from DM6PR02MB4890.namprd02.prod.outlook.com
 ([fe80::c82f:9b1a:ef99:f465]) by DM6PR02MB4890.namprd02.prod.outlook.com
 ([fe80::c82f:9b1a:ef99:f465%7]) with mapi id 15.20.1495.011; Fri, 11 Jan 2019
 00:58:23 +0000
From: Jiaying Liang <jliang@xilinx.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
Subject: RE: [PATH v7 1/2] mailbox: ZynqMP IPI mailbox controller
Thread-Topic: [PATH v7 1/2] mailbox: ZynqMP IPI mailbox controller
Thread-Index: AQHUmIoMbXFldAnYYUa0QY5wFWy3vaWKAvQAgB9XyMA=
Date: Fri, 11 Jan 2019 00:58:22 +0000
Message-ID: <DM6PR02MB489091D3804F93A9440AA8FEB0850@DM6PR02MB4890.namprd02.prod.outlook.com>
References: <1545327149-22331-1-git-send-email-wendy.liang@xilinx.com>
 <1545327149-22331-2-git-send-email-wendy.liang@xilinx.com>
 <CABb+yY27K8V-Mg_0kvQFvvAGhzdXG+7Zcz9tGDe_1FTStvra3Q@mail.gmail.com>
In-Reply-To: <CABb+yY27K8V-Mg_0kvQFvvAGhzdXG+7Zcz9tGDe_1FTStvra3Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jliang@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM6PR02MB4171;
 6:7AU3T6PfxbeU4VVeI43da2ARnUwLG/t7BM3Q6FJ+g0Z45eteu1kfXEx6dUKnOXuKldL9kntY8z5W8koVP34I2z+bDPGGx9pQFO4xBAIALJBZAlh5s8SsA0cLNM3zEjNJnMWIm7MC0BRnEo+kv8WBlfiRSHF+ZRHogv2xNc/fTxnMvx0ZjoCyv7phJUJfUMOyZPVH/4GCFElRjBHzYpjKX4iz/Rl9lWDUg98j9nKogMvADN4QCwSkWkWA/16MyPK1542VOa21IyrICL4eMyfTxFEV7gYDbR1QysTMHjKxNCNugwqr550oJaJ8SALcodfY4YVp9H9+WIorFDBFrD38v+dXbEcVtAtP6wRXkCrllRlCwv2BERIUWA52+QMvmoVPJvUb58WXGpJ5b074KktHb3pa5M0zAeWYmwD50vjqRnpeIj96YFDK/J+XNi3zoauB5FyA+YWywDlKBbbdyCQa7g==;
 5:prE5ozolqXMYRh+gZuTfaT1+d9f2DIuEX9pBjl3ISVpahvrmG6WS6THjeaMhK3jFgrWaX9fuYqGWP8WmiUKdtTVs5L+O10aoMsR5PjkwbuLqwLKbk3L/s+Gg9hVmwULogHUut756bRxr4gmNNTwDtth5Ap0x/uoN8hwdZOD2fPEA9VDmJQdfkt3CK/0TTtqt7Ri0wwsIO9MWvZyzpPzgqw==;
 7:EXwzGKOSRKou9cSFIAWNvyk2s8aO3lYSq+e4+NVvjeLlv1YwfqhV9XssEqinePUpGSWFx5sbPzS/IAhcx1SkymvyWSFjXZKrZhMlLDRt9EXJK9IrM1N9bp/Xp8tezCnQvQaAfFvAG5QJyT5mawfGWw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI; SCL:-1; SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(366004)(199004)(189003)(13464003)(8936002)(71190400001)(71200400001)(99286004)(2906002)(86362001)(9686003)(66066001)(6436002)(55016002)(446003)(15650500001)(53936002)(26005)(3846002)(6116002)(11346002)(25786009)(6506007)(53546011)(102836004)(33656002)(5660300001)(14444005)(4326008)(8676002)(14454004)(305945005)(81156014)(486006)(476003)(81166006)(478600001)(105586002)(76176011)(7736002)(97736004)(7696005)(229853002)(316002)(39060400002)(1411001)(54906003)(74316002)(256004)(6246003)(68736007)(106356001)(6916009)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR02MB4171;
 H:DM6PR02MB4890.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-office365-filtering-correlation-id: d3588569-01fa-4f4b-5b9a-08d6775fe2d2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DM6PR02MB4171; 
x-ms-traffictypediagnostic: DM6PR02MB4171:
x-microsoft-antispam-prvs: <DM6PR02MB41711C744DADC106595EFEFDB0850@DM6PR02MB4171.namprd02.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rjF/6uEdnyCr3nFt7b+eH4XDW7E2bTJ7jt4n1gBHNW4gPE29eKpiz9UWuRYTvJipkP9IDNHaXmK47eYjj6swOc3/IeTHeB8nMXU3bhSN6WAh6OqtGHSdzDZVl2daU+Jd7NF8dDHp3qqArfLIVuu8JUhj5aSXsQ3g23naaX3xMVVsbaCqWmcGySqzoguJAhhPACZYTUwQ9jekaJEnm7QZQAjiVjZNyp9NOOjAnsvOy4OFLfiJQmQvNb8R7mYvY06wx1lcQHtmj5OOvDC8B9yAAuVQnjJRDpaDZ4k5n+d3TfrUb4jU96APV7ee4D5pk5BqBJfBFImQZ8FCjflWlv4M33NaSu5F67USBJnTQaojHI32YPqSHNkuJYnrV1x9loPG2yiFpntgGzRZiOr9q8Trhec/paU8FFRO4mhBLaSltDM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3588569-01fa-4f4b-5b9a-08d6775fe2d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 00:58:22.9298 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4171
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_165827_884370_BE751EFA 
X-CRM114-Status: GOOD (  27.76  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Devicetree List <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Michal Simek <michals@xilinx.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



> -----Original Message-----
> From: Jassi Brar [mailto:jassisinghbrar@gmail.com]
> Sent: Friday, December 21, 2018 6:00 PM
> To: Jiaying Liang <jliang@xilinx.com>
> Cc: Michal Simek <michals@xilinx.com>; Rob Herring <robh+dt@kernel.org>;
> Mark Rutland <mark.rutland@arm.com>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; linux-arm-kernel@lists.infradead.org; Devicetree
> List <devicetree@vger.kernel.org>
> Subject: Re: [PATH v7 1/2] mailbox: ZynqMP IPI mailbox controller
> 
> On Thu, Dec 20, 2018 at 11:32 AM Wendy Liang <wendy.liang@xilinx.com>
> wrote:
> 
> 
> > diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c
> > b/drivers/mailbox/zynqmp-ipi-mailbox.c
> > new file mode 100644
> > index 0000000..bbddfd5
> > --- /dev/null
> > +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> > @@ -0,0 +1,764 @@
> 
> ......
> > +
> > +/* IPI SMC Macros */
> > +#define IPI_SMC_OPEN_IRQ_MASK          0x00000001UL /* IRQ enable bit
> in IPI
> > +                                                     * open SMC call
> > +                                                     */
> > +#define IPI_SMC_NOTIFY_BLOCK_MASK      0x00000001UL /* Flag to
> indicate if
> > +                                                     * IPI notification needs
> > +                                                     * to be blocking.
> > +                                                     */
> > +#define IPI_SMC_ENQUIRY_DIRQ_MASK      0x00000001UL /* Flag to
> indicate if
> > +                                                     * notification interrupt
> > +                                                     * to be disabled.
> > +                                                     */
> > +#define IPI_SMC_ACK_EIRQ_MASK          0x00000001UL /* Flag to indicate
> if
> > +                                                     * notification interrupt
> > +                                                     * to be enabled.
> > +                                                     */
> > +
> The first two are unused.
[Wendy] Will remove the unused macros

> 
> 
> > +struct zynqmp_ipi_pdata {
> > +       struct device *dev;
> > +       int irq;
> > +       unsigned int method;
> >
> 'method' doesn't track the HVC option in the driver. Please have a look.
[Wendy] I will add one more checking in the function implementation
to check HVC and error if it is neither SMC nor HVC.
> 
> ......
> > +
> > +static void zynqmp_ipi_fw_call(struct zynqmp_ipi_mbox *ipi_mbox,
> > +                              unsigned long a0, unsigned long a3,
> > +                              unsigned long a4, unsigned long a5,
> > +                              unsigned long a6, unsigned long a7,
> > +                              struct arm_smccc_res *res)
> >
> [a4,a7] are always 0, so maybe just drop them?
[Wendy] Will drop them from the API, and set them to 0.
> 
> 
> > +static bool zynqmp_ipi_last_tx_done(struct mbox_chan *chan) {
> > +       struct device *dev = chan->mbox->dev;
> > +       struct zynqmp_ipi_mbox *ipi_mbox = dev_get_drvdata(dev);
> > +       struct zynqmp_ipi_mchan *mchan = chan->con_priv;
> > +       int ret;
> > +       u64 arg0;
> > +       struct arm_smccc_res res;
> > +       struct zynqmp_ipi_message *msg;
> > +
> > +       if (WARN_ON(!ipi_mbox)) {
> > +               dev_err(dev, "no platform drv data??\n");
> > +               return false;
> > +       }
> > +
> > +       if (mchan->chan_type == IPI_MB_CHNL_TX) {
> > +               /* We only need to check if the message been taken
> > +                * by the remote in the TX channel
> > +                */
> > +               arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
> > +               zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, 0, 0, 0, 0, &res);
> > +               /* Check the SMC call status, a0 of the result */
> > +               ret = (int)(res.a0 & 0xFFFFFFFF);
> > +               if (ret < 0 || ret & IPI_MB_STATUS_SEND_PENDING)
> > +                       return false;
> > +
> OK, but ...
> 
> > +               msg = mchan->rx_buf;
> > +               msg->len = mchan->resp_buf_size;
> > +               memcpy_fromio(msg->data, mchan->resp_buf, msg->len);
> > +               mbox_chan_received_data(chan, (void *)msg);
> >
> .... wouldn't this be done from zynqmp_ipi_interrupt()?
[Wendy] The IPI hardware supports both the synchronous mode and
Asynchronous mode.
The rx interrupt used for remote to notify host, or for responding asynchronous
Request. In synchronous mode, the IPI hardware allow remote to write response
To the tx response buffer, and the host side can poll the observation register
And get the response if the remote has acked.
The last_tx_done is implemented for this purpose.
> 
> 
> 
> > +static int zynqmp_ipi_send_data(struct mbox_chan *chan, void *data) {
>   .........
> > +               /* Enquire if the mailbox is free to send message */
> > +               arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
> > +               timeout = 10;
> > +               if (msg && msg->len) {
> > +                       timeout = 10;
> > +                       do {
> > +                               zynqmp_ipi_fw_call(ipi_mbox, arg0,
> > +                                                  0, 0, 0, 0, 0, &res);
> > +                               ret = res.a0 & 0xFFFFFFFF;
> > +                               if (ret >= 0 &&
> > +                                   !(ret & IPI_MB_STATUS_SEND_PENDING))
> > +                                       break;
> > +                               usleep_range(1, 2);
> > +                               timeout--;
> > +                       } while (timeout);
> > +                       if (!timeout) {
> > +                               dev_warn(dev, "chan %d sending msg timeout.\n",
> > +                                        ipi_mbox->remote_id);
> > +                               return -ETIME;
> > +                       }
> > +                       memcpy_toio(mchan->req_buf, msg->data, msg->len);
> > +               }
> >
> This check should be done in last_tx_done, and not here.
> send_data is never called unless last_tx_done returns true.
[Wendy] will remove it.
> 
> > +               /* Kick IPI mailbox to send message */
> > +               arg0 = SMC_IPI_MAILBOX_NOTIFY;
> > +               zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, 0, 0, 0, 0, &res);
> > +       } else {
> > +               /* Send response message */
> > +               if (msg && msg->len > mchan->resp_buf_size) {
> > +                       dev_err(dev, "channel %d message length %u > max %lu\n",
> > +                               mchan->chan_type, (unsigned int)msg->len,
> > +                               mchan->resp_buf_size);
> > +                       return -EINVAL;
> > +               }
> > +               if (msg && msg->len)
> > +                       memcpy_toio(mchan->resp_buf, msg->data,
> > + msg->len);
> >
> 
> > +               arg0 = SMC_IPI_MAILBOX_NOTIFY;
> > +               arg0 = SMC_IPI_MAILBOX_ACK;
> >
> This is obviously wrong.
[Wendy] will fix
> 
> ....
> > +       mbox->chans = chans;
> > +       chans[IPI_MB_CHNL_TX].con_priv = &ipi_mbox-
> >mchans[IPI_MB_CHNL_TX];
> > +       chans[IPI_MB_CHNL_RX].con_priv = &ipi_mbox-
> >mchans[IPI_MB_CHNL_RX];
> > +       ipi_mbox->mchans[IPI_MB_CHNL_TX].chan_type = IPI_MB_CHNL_TX;
> > +       ipi_mbox->mchans[IPI_MB_CHNL_RX].chan_type = IPI_MB_CHNL_RX;
> > +       ret = mbox_controller_register(mbox);
> >
> while at it, you may want to start using
> devm_mbox_controller_register() recently added by Thierry.
[Wendy] will take a look at this function call
> 
> > +       if (ret)
> > +               dev_err(mdev,
> > +                       "Failed to register mbox_controller(%d)\n", ret);
> > +       else
> > +               dev_info(mdev, "Probed ZynqMP IPI Mailbox driver.\n");
> >
> You may want to also print something instance specific here.
[Wendy] will add more information such as the number of channels.
> 
> 
> > +static int zynqmp_ipi_probe(struct platform_device *pdev) {
> > +       struct device *dev = &pdev->dev;
> > +       struct device_node *nc, *np = pdev->dev.of_node;
> > +       struct zynqmp_ipi_pdata *pdata;
> > +       struct zynqmp_ipi_mbox *mbox;
> > +       int i, ret = -EINVAL;
> > +
> > +       i = 0;
> > +       for_each_available_child_of_node(np, nc)
> > +               i++;
> >
> of_get_child_count() ?
[Wendy] Will change.

Thanks,
Wendy
> 
> 
> Thnx
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
