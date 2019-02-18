Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5D9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:23:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C816217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RW2ztXNR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C816217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7N+1h+nXqlgcggsDU9G4Y9UrFCg7DshDC4BXnlZOa6Y=; b=RW2ztXNRF5jc84
	UftTY88VORVuqqYnSaEa57j17G32ql54hDhnVVNhe8/nvzypbBLBZ1XunFAqYeBXrxtuHjv9jfbtq
	9uVXz7hutZMUHz7Inx3WyvWdFWUFXo+5/4CS2BL/RA1ZKMGZdPlZ26yyL8H4Q6hphOOvRoh74rUeU
	h8GVLK3AklxLwxnSr/oEJ0rO8bKwpC/moqa3+F/pSpxNTEWhvPlvQhezZ+0Ep+7oCfPhYzGvzepDl
	a68aJjAZNFA4mscTGpmuWQRkDb+oVHS1f0gHtpZz5mtNbw3no2Fx8gSXfk1PEuZKEVmFADRmzgmBD
	KGySWwaelhy/c6sfFQLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvhxB-0005QL-3l; Mon, 18 Feb 2019 12:23:21 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvhx7-0005Pq-W7
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 12:23:19 +0000
Received: by mail-qk1-f194.google.com with SMTP id h28so5984803qkk.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 04:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TkxiOdlFMG2Oo/NhiwiO2IEP5PcwzbiZ5G0/wUbTDYU=;
 b=uAjmatIJgq0b1Vsu8Jd6JYDakLsy5uWfz5dpoKGVhSdh+LogepY0JYcv0l3ftRtAfk
 p6Q+5ehoAbt4lfncAQNLKgqk/yKlAmfdtv2epU6BKx/0GY+FBJb1dPE0OFvvpDYYWVsb
 ahb0JgU19l7kT8S+36w4tqY9+p08pobbdcrumQQOzbfC3JK1qCaJ/MLT/CgXH50h2RxY
 42csE115AaVJ+/lgcE7nC/+kFuIUybGbk8mwUvT4WT04mgQYzHlkPKPmjVS+d6toIZMU
 ohWcWeoAh983Om7G6eH8TrhpENasg5HJTjkOkwV91V9VYMHjNgw1T9FQyWdFmdQZcru9
 uYAA==
X-Gm-Message-State: AHQUAuYfEq36zxneoRb9XxZfJ9LYW1kvnsZv7kIAB49rP1PdhMNWN8aO
 HsoHLbJupDmG4tjP/OLxuIs+aliLIxnIeBmmm5I=
X-Google-Smtp-Source: AHgI3Ib8I5xgf1GnhTr4hL+ulfYuLTC9EM+UZjA/qQs8u9FQw/uAu3MjqoH/9MjOcrOWmnmK0LgxCbmfliyGx8vpt5Y=
X-Received: by 2002:a37:d492:: with SMTP id s18mr15615469qks.343.1550492596472; 
 Mon, 18 Feb 2019 04:23:16 -0800 (PST)
MIME-Version: 1.0
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
 <CAK8P3a2zkhrZLMi5KZ5=fGJCt85dad3_pZC0o7GqcwJkk4es9w@mail.gmail.com>
 <CAMz4ku+PR4bHtcPu2uT2f974+FWJVi8Tp3WzmuqE1TS-M-QawQ@mail.gmail.com>
 <CAMz4kuLEut0LqZ4bSAGJDufE8xHr6DgZ3Z1RCLQ10q_k6MUesw@mail.gmail.com>
 <CAK8P3a1Zq6XjymG3sAaHGeNRxU5UXPfJPbi0A9s47cTVK7vC3g@mail.gmail.com>
 <CAMz4kuL=B53xLk4SFbrwWeUhp4P9zbUfOmXgftQCEjVSwOnD5A@mail.gmail.com>
In-Reply-To: <CAMz4kuL=B53xLk4SFbrwWeUhp4P9zbUfOmXgftQCEjVSwOnD5A@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 13:23:00 +0100
Message-ID: <CAK8P3a03rPjWQvGrDupoTAywVmjCZdpSJpqW9Sv=NVPR2uwZeQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Add one new cell to present
 hardware slave id
To: Baolin Wang <baolin.wang@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_042318_033798_CA6C084D 
X-CRM114-Status: GOOD (  27.34  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 eric.long@unisoc.com, arm-soc <arm@kernel.org>,
 Lyra Zhang <zhang.lyra@gmail.com>, Mark Brown <broonie@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Olof Johansson <olof@lixom.net>,
 Orson Zhai <orsonzhai@gmail.com>, Dan Williams <dan.j.williams@intel.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 11:52 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> On Mon, 18 Feb 2019 at 18:31, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Feb 12, 2019 at 9:25 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > On Fri, 1 Feb 2019 at 19:53, Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > On Thu, 31 Jan 2019 at 00:52, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > On Tue, Jan 22, 2019 at 2:21 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > >
> > > > > >  Client:
> > > > > >  DMA clients connected to the Spreadtrum DMA controller must use the format
> > > > > > -described in the dma.txt file, using a two-cell specifier for each channel.
> > > > > > -The two cells in order are:
> > > > > > +described in the dma.txt file, using a three-cell specifier for each channel.
> > > > > > +The three cells in order are:
> > > > > >  1. A phandle pointing to the DMA controller.
> > > > > >  2. The channel id.
> > > > > > +3. The hardware slave id which is used for clients to trigger DMA engine
> > > > > > +automatically.
> > > > >
> > > > > I notice that this is an incompatible binding change. Is that necessary?
> > > > > If the current code works, I'd suggest allowing both #dma-cells=<2>
> > > > > and <3>, and then implementing both in the driver.
> > > >
> > > > Yes, this is necessary.
> > > >
> > > > Yes, current code can work, but the problem is that the DMA clients
> > > > must add one property (something like "sprd,slave-id") to specify the
> > > > slave id. So considering this, we want to change the dma-cells to 2,
> > > > including dma channel and dma slave id, which can avoid introducing
> > > > some similar properties for DMA clients.
> > > >
> > > > Now there are no DMA clients in mainline for Spreadtrum platform, and
> > > > we want to upstream our first DMA clients: SPI controller. So no other
> > > > drivers need to change when we changing dma cells. Thanks.
> > >
> > > Do you have any other concerns about this patch set? If not, I think
> > > Vinod can apply this patch set. Thanks.
> >
> > Sorry for the late reply. Yes, this makes sense since there are no
> > existing users then. For the DT changes going through the dmaengine
> > tree
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks for your reviewing.
>
> >
> > One more question, to make sure we don't need to edit it again:
> > Why do you need both a 'channel id' and a 'slave id' here? Is this
> > a strict hardware requirement for your DMA engine? In many
> > other designs, only a DMA request line number needs to
> > be described, and I think this would correspond to what you
> > call the 'hardware slave id' in your documentation.
>
> I try to explain why we need the slave id.
>
> For our DMA engine driver, we have software request mode and hardware
> request mode. For software request mode, the DMA engine driver need
> trigger DMA to start transfer manually. But for hardware request mode,
> we just set one unique slave id corresponding to the slave hardware to
> the DMA engine, then the slave hardware can trigger DMA automatically.
> And the slave id is not always same with the channel id according to
> the SoC design, so we add one cell to specify the slave id.

I did understand the need for a slave-id, I was instead wondering about
the channel-id number. On many SoCs, all channels are equal, and you
just have to pick one of those with the right capabilities for a particular
slave.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
