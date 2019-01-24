Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E614C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:07:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1ED021872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lX59bII1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="jJ4UHDOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1ED021872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=omWsocQS/poE59zF6nahZxvOSkaNq+HqqJBO/QPnoTI=; b=lX59bII1lWDFmn
	Fy1iuR0jv6z/lhAAW7z688ocvj1WK+xd4F+yDZKXr2iPe/J4SK1unAbbVW714BFpi/SRRVbQjTgFw
	FzZUkIe14F+36UuUslOS8XBXdmGmsU0QCIX8ONggcK3EnPvhao2Lajxwlu8YyrQS1CKvdKEVWqIGz
	U3iiRTe4i3CE5e9CsttMUl/PZqLbQmGwCYggJUgasbtcEOXcTk8IsaID0DtTUGijjbR0F80R7cciM
	AMBy9ImJUT1A2RAbGpWRuN7zWQwx/L93zdi4YILsi8DWbrHTg6DFI56vKKFZl7T/1NGTOHBuEnOPB
	siuDkwN9a1L2W2gxSjrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmgbj-0006aS-MU; Thu, 24 Jan 2019 15:07:55 +0000
Received: from mail-eopbgr50077.outbound.protection.outlook.com ([40.107.5.77]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgbf-0006Zs-6v
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:07:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IO2UpFqfv9hLZKkAmNtaGmA/S4gLT7ardzgbz6Nqa4=;
 b=jJ4UHDOtcFKvRDPR2RQsBQ7fJ27tMLrpzT8ZPJ+XyVCpylBCl3/4otHu89o/Bmup3sQkvTfdHhbZramwKwLzKYpnRoHulGi0QrdKnlBsZT9gjoC68owRLujwT4RzsETa2Dd9OHqnBcO6PdBiKefwVLS9Aj4rabKAv6Ks+yGvjpg=
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com (10.175.232.149) by
 DB6PR05MB4581.eurprd05.prod.outlook.com (10.168.24.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Thu, 24 Jan 2019 15:07:45 +0000
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d935:9a6c:c7a3:1320]) by DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d935:9a6c:c7a3:1320%2]) with mapi id 15.20.1558.016; Thu, 24 Jan 2019
 15:07:45 +0000
From: Liming Sun <lsun@mellanox.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v4 3/4] dt-bindings: soc: Add TmFifo binding for Mellanox
 BlueField SoC
Thread-Topic: [PATCH v4 3/4] dt-bindings: soc: Add TmFifo binding for Mellanox
 BlueField SoC
Thread-Index: AQHUa8L4R5p04GYdNE6+AU/cuXsBMKUwGGGAgAHRpxCAABTLAICNFRDg
Date: Thu, 24 Jan 2019 15:07:45 +0000
Message-ID: <DB6PR05MB3223E186F175CB50D7F03A0FA19A0@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1540403734-137721-1-git-send-email-lsun@mellanox.com>
 <1540403734-137721-3-git-send-email-lsun@mellanox.com>
 <CAK8P3a1K7BjgZRyBMKFrqWfcr-Bb3HQus+QE7qTpd27voE9e0A@mail.gmail.com>
 <AM4PR05MB3220F4E5EEB673F0CC97C11DA1F00@AM4PR05MB3220.eurprd05.prod.outlook.com>
 <CAK8P3a21y1jm+1aZ8is7Rp=Re++BxL3mJM-Zj=_3c-Lq4y_Few@mail.gmail.com>
In-Reply-To: <CAK8P3a21y1jm+1aZ8is7Rp=Re++BxL3mJM-Zj=_3c-Lq4y_Few@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB6PR05MB4581;
 6:3CTeTnSkc0vNVgiI/Z1cWQpopgEojnojzWYv1F+/I3rP5c+JhG89wbIfMxDjTwcaybneUDSEJPVmAqDH0Hr1Xs4LTMSR8+LbLhmJV0Dec0IHI4x44B5WSAjRx/MKJmO7mVjcfCKOM11Log+gCUvTvoVD4MPwSb23OkIcJOuJ3R+7Ye2t6/zAY4zs3etNKKAALqadTlcyOD6PlR4LQKw6HthkQb+gJYJgkKoYl4Urgm0hX5QUgr6cW9V8eqp/9xTMw7L/Bvj4hMJ9ULj+hptW+PFCFZghpYCx+tdCyWapRhGPIjgI1XiGH5n21+EazYLaNsMdYC5JoCw3qTX+IGWGomhq9vrmn8pWJSezdeLr3NNpH6lMc7Q7BSL8Vk/CdKKPYaY1rwOFdFBj6I9kjKZxWlzlVL5rD38wM6kiPHJjP7qGf8PwJO/Fkl/I28ebNmYpqb3Ai+mGJBDFM0q/62yEuQ==;
 5:USnltBJOkQHZx6A7cbjsOxtqPmXf2ADE6p6W8m88wsmVA9ONVap3Wq5rDEiUlTr+AM5rJqGqJKDK/XnsKcZAa1noVTeZBMCO8/kTKqJ1RmHjixYX9q7X4pTXmbrhAv1ATbsBr4sc1RRlCfwGOy+JtHUs7psbeOQqWenwyO1s1NvCfMLLSRosKRZCmHK9OpmA3xqquk87C/M4o9QszlEgWg==;
 7:xpTRtszVFibgiIIPHwPwP0RkKYQAyfUjwPbeZ9ufHurDPX8r2DZMknCfDgvy7mike6eb13noIFW6nIXsm/pl+lq44GEKeN5OTG5Xov6XFAzmibkmTDdsOwI/TK0rzAtX0Pjh9Rngd9nIh2kb3ftOLQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 98ced682-e6b2-4f96-1b4a-08d6820db258
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB6PR05MB4581; 
x-ms-traffictypediagnostic: DB6PR05MB4581:
x-microsoft-antispam-prvs: <DB6PR05MB4581B1F6891EC5C82195EB9BA19A0@DB6PR05MB4581.eurprd05.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(6029001)(346002)(396003)(376002)(366004)(39860400002)(136003)(51444003)(13464003)(189003)(199004)(81156014)(81166006)(6506007)(8676002)(486006)(305945005)(33656002)(68736007)(7736002)(53546011)(6116002)(3846002)(476003)(74316002)(71200400001)(71190400001)(256004)(14444005)(93886005)(446003)(8936002)(186003)(76176011)(11346002)(316002)(54906003)(7696005)(86362001)(6916009)(55016002)(25786009)(106356001)(2906002)(102836004)(9686003)(6436002)(229853002)(99286004)(478600001)(105586002)(97736004)(4326008)(14454004)(66066001)(26005)(53936002)(6246003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR05MB4581;
 H:DB6PR05MB3223.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c5wcHIYHQaKo0fESxtRoVwQMciIRju5xySiMmXisGuAgadwrQZLI8LVusLqLUAyX701imlXkLRcOqZbOzSk+N1g/QK+KXt6KEcSmR4t0RMj70j6jRNMLDzpY/gfGfr32gqw+LV3JLraE97j0PUZjzC5tOXmA/hAFjqou1Ksss0JSn4+B78phf5H+S3opR8JU27GVUNBUbThWtMttErij2JEOugdvQpdYeVw6edXX1dWOvy+a8vwdCWFmrOqpwgg2nX4lvsYm8elzXK+fo+CRVXDYQ5vmFNkX/3AgM8ufdIjyUx763MyhnmRXsgO312VpsNI0Q6BD7uLP9WFwnn/UzUYq5sBkcqLu/VlrKzVx02gumkQBCe8d6WhnoKkJ5ZP5SaZlFw2FW9sxTgj7ypLX8AHP/HCV701VzHe4VTSuLVg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ced682-e6b2-4f96-1b4a-08d6820db258
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 15:07:45.6727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB4581
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_070751_303978_4EC7139B 
X-CRM114-Status: GOOD (  30.20  )
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
Cc: DTML <devicetree@vger.kernel.org>, David Woods <dwoods@mellanox.com>,
 Vadim Pasternak <vadimp@mellanox.com>, arm-soc <arm@kernel.org>,
 Andy Shevchenko <andy@infradead.org>, Olof Johansson <olof@lixom.net>,
 Darren Hart <dvhart@infradead.org>, Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Arnd,

According to the emails and discussions I saw recently, I think that your comments "Finally, drivers/platform/mellanox might be a reasonable choice, and it would let you keep both sides of the driver in one place." does make more sense.

I'll try to resubmit the changes under the drivers/platform/mellanox directory.

Thanks!
Liming

> -----Original Message-----
> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Friday, October 26, 2018 4:34 PM
> To: Liming Sun <lsun@mellanox.com>
> Cc: Olof Johansson <olof@lixom.net>; David Woods <dwoods@mellanox.com>; Robin Murphy <robin.murphy@arm.com>; arm-soc
> <arm@kernel.org>; DTML <devicetree@vger.kernel.org>; Linux ARM <linux-arm-kernel@lists.infradead.org>
> Subject: Re: [PATCH v4 3/4] dt-bindings: soc: Add TmFifo binding for Mellanox BlueField SoC
> 
> On Fri, Oct 26, 2018 at 9:36 PM Liming Sun <lsun@mellanox.com> wrote:
> > > -----Original Message-----
> > > From: arndbergmann@gmail.com [mailto:arndbergmann@gmail.com] On
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/soc/mellanox/tmfifo.txt
> > > > @@ -0,0 +1,23 @@
> > > > +* Mellanox BlueField SoC TmFifo
> > > > +
> > > > +BlueField TmFifo provides a shared FIFO between the target and the
> > > > +external host machine, which can be accessed by external host via
> > > > +USB or PCIe. In the current tmfifo driver, this FIFO has been demuxed
> > > > +to implement virtual console and network interface based on the virtio
> > > > +framework.
> > > > +
> > > > +Required properties:
> > > > +
> > > > +- compatible:      Should be "mellanox,bf-tmfifo"
> > > > +- reg:             Physical base address and length of Rx/Tx block
> > > > +- interrupts:      The interrupt number of Rx low water mark, Rx high water
> > > > mark
> > > > +           Tx low water mark, Tx high water mark respectively.
> > >
> > >
> > > This sounds like it might fit into the mailbox subsystem, and perhaps
> > > it should use the mailbox DT bindings. Have you had a look at that?
> >
> > This commit of dt-bindings is mainly to solve the warning of checkpatch.pl.
> > Like the response to patch 2/4, ACPI is actually used now instead of device tree.
> > The TMFIFO definition in the ACPI DSDT table would be something like below.
> >
> >     // RShim TMFIFO
> >     Device(RSH0) {
> >       Name(_HID, "MLNXBF01")
> >       Name(_UID, Zero)
> >       Name(_CCA, 1)
> >       Name(_CRS, ResourceTemplate() {
> >         Memory32Fixed(ReadWrite, 0x00800a20, 0x00000018)
> >         Memory32Fixed(ReadWrite, 0x00800a40, 0x00000018)
> >         Interrupt(ResourceConsumer, Edge, ActiveHigh, Exclusive)
> >           { BF1_RSH0_TM_HTT_LWM_INT,
> >             BF1_RSH0_TM_HTT_HWM_INT,
> >             BF1_RSH0_TM_TTH_LWM_INT,
> >             BF1_RSH0_TM_TTH_HWM_INT
> >           }
> >       })
> >     }
> >
> > Any suggestion how it should be added into Linux Documentation, or maybe I
> > should just remove this commit from this patch series?
> 
> Maybe the best way here would be to not use ACPI for the case
> where bluefin is integrated into a PCIe endpoint, since ACPI is
> not as flexible here and generally relies on having an SBSA
> compliant hardware that you no longer have if you require
> random platform devices for booting from and for your console.
> 
> For the case where a bluefin SoC is used in a standalone system,
> having ACPI makes more sense, as that lets you install Red Hat
> Linux or other operating systems that rely on SBBR and SBSA.
> 
> > As for the sub-component of this driver, the "soc" might be better fit than the mailbox
> > for some reasons. It's a communication between extern machines and the SoC via
> > USB / PCIe,  like pushing boot stream, console and network mgmt. Some of the features,
> > like pushing boot stream, doesn't communicate with the ARM core. The boot stream
> > is pushed to the SoC HW logic directly. I'll add the host-side virtio-based driver in patch v5.
> 
> Right, the drivers/mailbox subsystem was not the right idea here,
> I noticed that myself after actually reading the driver. Drivers/soc
> may also not be the best fit, since this is not really about it being
> a SoC, but rather a way to encapsulate virtual devices. The
> mic driver I mentioned is in drivers/misc, but I don't like to add stuff
> there if we can avoid it.
> 
> drivers/virtio, drivers/bus or drivers/mfd might also be an option that
> could fit better than drivers/soc, or you could have your own subdir
> below drivers/ as some others do. Finally, drivers/platform/mellanox
> might be a reasonable choice, and it would let you keep both sides
> of the driver in one place.
> 
>        Arnd
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
