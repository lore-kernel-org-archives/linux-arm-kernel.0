Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F71C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:13:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 757E3206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EbNF51ib";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QEOjlK8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757E3206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HienJsIaDFHpraZyE4J8TmeU9BnGpNK7eEpPFuX0V08=; b=EbNF51ibobP53U
	+Ao+1Vjx02wU84+7UTHxgaAM00UhdHBpwdMp/UViG1rPCKYjh0z6voC+nElegAs4l8drjxqNy1swh
	ilLr3esfcF9uWLkffqxnkgBWNJ/99j6V9Goo4bhnOL+eljcl4rd7+QLof74dBu/tBKB0ClMZLyLo8
	KC+H23dgXOQ0BEEBA34Xh5PpXPbTFYeq/e3qxO/CKNDkIqiHj3zhMAePxLkb7P87Qdcbt7S5b37vB
	AEckKvyMkOdB5GEQ76q0UFPfW8LJl5i6MoagG4tAusOIL+SFz3HegMg8TWpA9CdEzjdbX5JqZy0jU
	ZjZJnpkGdaVVWtPEHxHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwIJm-0008I6-Uf; Wed, 20 Feb 2019 03:13:06 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwIJh-0008HH-Tv
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 03:13:05 +0000
Received: by mail-lf1-x144.google.com with SMTP id j1so16429166lfb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 19:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z2LXbrHOldUTY/jAdGPp9j2Yl3u+b4VB1Kty9L2vXX0=;
 b=QEOjlK8bT/e0l8yy6k559RMnGVM/tdyO3vBxCW0qTiQnYxDYumZVw7SfNnV/EGQlvS
 w024CbU5wFjRj9PaeBmY/3cI8VxwwUZ85cRPLumNTizEd4qa6ZDJFQhyfJqEeTTvNiX/
 jddttdJfznYMARA7jWLZTAn/26boTiy5n+MvD/M8XMbqVg90BYVJaCM0CzclEqGxHbx9
 smnPS1KNU+tk2CxVViAdwILhHgi31F+PrNOah10179nJHlCgdww2jvtsy3swB5q/5KP5
 bN7prSkWhEgUJTMAJeqFBoHJNzgrfq2e9CLddv/T0yWWSA0/0mTD2MGPyh9gTP6sIB4K
 EV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z2LXbrHOldUTY/jAdGPp9j2Yl3u+b4VB1Kty9L2vXX0=;
 b=FulTWJE2iZhbm3/wv7ZX22Gv5Yp6DAmD7MOxQov9QF7iBZJ6ReuW0z6bxUTpPcMS9K
 rjBN1gCs8n3R+Lrce3pbOB4oePmiCdfsOcIJfxkGkNd7KYDONwHqzneUWKLxF28thxFx
 96i7erul/PjFl5lmBWgn49Oz4ed83zHt60vETE3kMFEJTqi91klTDyFKT851g9/kk2L5
 AOJOyexBx4oi8JxLswe+Vlf7yUUIjEgSOiOuC2vkJ5lPQMoRFd7xuW9qrEPKnA5O6r6E
 rNHDLwbNCYGNE9JIBvgnPtCFDRDXnPaB7+8QmlJ6HSYOWjmLQwLO6ARVPo6oXCYGYbVJ
 6yoA==
X-Gm-Message-State: AHQUAuabm4mvPDh9yRg9+NRp9MtF9WVcOV46NWPODkZ5e0WKJLO3jA9p
 M68hEzO+Ds5po1yiNonlTXHdzPAKCHEjju19yDW1tg==
X-Google-Smtp-Source: AHgI3IYySOP2QK3THCYbax0egKVgeTezd6tne4uTPWvbwr3K7qHpkaM9UufqdNmaOGvyNtQvPWLNGZEG1/tTPiiyriQ=
X-Received: by 2002:a19:5205:: with SMTP id m5mr18907054lfb.61.1550632378836; 
 Tue, 19 Feb 2019 19:12:58 -0800 (PST)
MIME-Version: 1.0
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
 <CAK8P3a2zkhrZLMi5KZ5=fGJCt85dad3_pZC0o7GqcwJkk4es9w@mail.gmail.com>
 <CAMz4ku+PR4bHtcPu2uT2f974+FWJVi8Tp3WzmuqE1TS-M-QawQ@mail.gmail.com>
 <CAMz4kuLEut0LqZ4bSAGJDufE8xHr6DgZ3Z1RCLQ10q_k6MUesw@mail.gmail.com>
 <CAK8P3a1Zq6XjymG3sAaHGeNRxU5UXPfJPbi0A9s47cTVK7vC3g@mail.gmail.com>
 <CAMz4kuL=B53xLk4SFbrwWeUhp4P9zbUfOmXgftQCEjVSwOnD5A@mail.gmail.com>
 <CAK8P3a03rPjWQvGrDupoTAywVmjCZdpSJpqW9Sv=NVPR2uwZeQ@mail.gmail.com>
 <CAMz4kuKnVppCB0-9LVgq8bya6=iWPhMcrHL_N53QfiU5Kn9YAA@mail.gmail.com>
 <CAMuHMdWPZGYpvANL_V=YszPWjtTA+ZnU6GVDmn188LC=eC005Q@mail.gmail.com>
 <CAMz4ku+yzwaww5o06tz9-8n99UfiVh6d5UB2L12RYMpTow6K3w@mail.gmail.com>
 <20190219122027.GA21884@vkoul-mobl>
In-Reply-To: <20190219122027.GA21884@vkoul-mobl>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 20 Feb 2019 11:12:47 +0800
Message-ID: <CAMz4kuK89AyL6PA2dRF1t=tR6-fKXKp+x3oi+cKDqSqi08xv0Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Add one new cell to present
 hardware slave id
To: Vinod Koul <vkoul@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_191301_977760_0CF201E4 
X-CRM114-Status: GOOD (  34.50  )
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
 eric.long@unisoc.com, arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Lyra Zhang <zhang.lyra@gmail.com>, Mark Brown <broonie@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 Orson Zhai <orsonzhai@gmail.com>, Dan Williams <dan.j.williams@intel.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 19 Feb 2019 at 20:20, Vinod Koul <vkoul@kernel.org> wrote:
>
> On 19-02-19, 17:49, Baolin Wang wrote:
> > Hi Geert,
> >
> > On Tue, 19 Feb 2019 at 17:30, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > Hi Baolin,
> > >
> > > On Tue, Feb 19, 2019 at 4:15 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > On Mon, 18 Feb 2019 at 20:23, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > On Mon, Feb 18, 2019 at 11:52 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > > On Mon, 18 Feb 2019 at 18:31, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > >
> > > > > > > On Tue, Feb 12, 2019 at 9:25 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > > > > On Fri, 1 Feb 2019 at 19:53, Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > > > > > On Thu, 31 Jan 2019 at 00:52, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > > > > > On Tue, Jan 22, 2019 at 2:21 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > >  Client:
> > > > > > > > > > >  DMA clients connected to the Spreadtrum DMA controller must use the format
> > > > > > > > > > > -described in the dma.txt file, using a two-cell specifier for each channel.
> > > > > > > > > > > -The two cells in order are:
> > > > > > > > > > > +described in the dma.txt file, using a three-cell specifier for each channel.
> > > > > > > > > > > +The three cells in order are:
> > > > > > > > > > >  1. A phandle pointing to the DMA controller.
> > > > > > > > > > >  2. The channel id.
> > > > > > > > > > > +3. The hardware slave id which is used for clients to trigger DMA engine
> > > > > > > > > > > +automatically.
> > > > > > > > > >
> > > > > > > > > > I notice that this is an incompatible binding change. Is that necessary?
> > > > > > > > > > If the current code works, I'd suggest allowing both #dma-cells=<2>
> > > > > > > > > > and <3>, and then implementing both in the driver.
> > > > > > > > >
> > > > > > > > > Yes, this is necessary.
> > > > > > > > >
> > > > > > > > > Yes, current code can work, but the problem is that the DMA clients
> > > > > > > > > must add one property (something like "sprd,slave-id") to specify the
> > > > > > > > > slave id. So considering this, we want to change the dma-cells to 2,
> > > > > > > > > including dma channel and dma slave id, which can avoid introducing
> > > > > > > > > some similar properties for DMA clients.
> > > > > > > > >
> > > > > > > > > Now there are no DMA clients in mainline for Spreadtrum platform, and
> > > > > > > > > we want to upstream our first DMA clients: SPI controller. So no other
> > > > > > > > > drivers need to change when we changing dma cells. Thanks.
> > > > > > > >
> > > > > > > > Do you have any other concerns about this patch set? If not, I think
> > > > > > > > Vinod can apply this patch set. Thanks.
> > > > > > >
> > > > > > > Sorry for the late reply. Yes, this makes sense since there are no
> > > > > > > existing users then. For the DT changes going through the dmaengine
> > > > > > > tree
> > > > > > >
> > > > > > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > > > >
> > > > > > Thanks for your reviewing.
> > > > > >
> > > > > > >
> > > > > > > One more question, to make sure we don't need to edit it again:
> > > > > > > Why do you need both a 'channel id' and a 'slave id' here? Is this
> > > > > > > a strict hardware requirement for your DMA engine? In many
> > > > > > > other designs, only a DMA request line number needs to
> > > > > > > be described, and I think this would correspond to what you
> > > > > > > call the 'hardware slave id' in your documentation.
> > > > > >
> > > > > > I try to explain why we need the slave id.
> > > > > >
> > > > > > For our DMA engine driver, we have software request mode and hardware
> > > > > > request mode. For software request mode, the DMA engine driver need
> > > > > > trigger DMA to start transfer manually. But for hardware request mode,
> > > > > > we just set one unique slave id corresponding to the slave hardware to
> > > > > > the DMA engine, then the slave hardware can trigger DMA automatically.
> > > > > > And the slave id is not always same with the channel id according to
> > > > > > the SoC design, so we add one cell to specify the slave id.
> > > > >
> > > > > I did understand the need for a slave-id, I was instead wondering about
> > > > > the channel-id number. On many SoCs, all channels are equal, and you
> > > > > just have to pick one of those with the right capabilities for a particular
> > > > > slave.
> > > >
> > > > Yes, all channels are equal. We just set a unique slave id for the
> > > > channel for a particular slave. For example, the SPI slave can use
> > > > channel 10 for tx transfer by setting slave id 11, or it also can use
> > > > channel 9 for tx transfer by setting same slave id 11.
> > >
> > > So the channel selection is software policy, not hardware description, and
> > > thus doesn't belong in DT?
> > >
> > > Can't the DMA engine driver allocate channels dynamically, removing the
> > > need to specify this in DT?
> >
> > In theory we can do as you suggested. But we still want to
> > manage/assign the DMA channel resources manually for one SoC, we can
> > make sure some important DMA slaves (such as audio)  can request a DMA
> > channel at runtime firstly, another benefit is that it is easy to
> > debug since we can easily know which channel is assigned for this
> > slave.
>
> Are  you suggesting that you have more users than channels available?

Until now we have not met this issue, but we can not make sure if this
can happen in future. Moreover DMA channel resources are belonging to
the DMA engine's hardware resources, I think it should be described in
DT like many other drivers did.

> I dont think it is hard to debug if channels are dynamic in
> nature (for example we can print channel number and you know which one
> are you talking about, fwiw i have worked on a such a system where we
> grabbed the free channel)
>
> --
> ~Vinod



-- 
Baolin Wang
Best Regards

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
