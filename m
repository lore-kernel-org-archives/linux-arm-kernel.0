Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9BFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:31:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5D721738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZS0QQgnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5D721738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mzMThsuSM4m881eRoFaceRmiOBRs9QZPF9cSOqOTrbw=; b=ZS0QQgnP/gSWXY
	uVNRLRaATHEVBv378E3z6ceD3JCuHxj6qZt7iNS2C6LGRNs5y6L7qWIXaZvea1cMuxWeGHLLjFM5r
	2OSems24ec9W2pyE5w+gSRIf60ym8SrGl94xPARrfxdHZ7wL6YC2AQ0mPsWre7ATC4ghTMxL9MZBy
	5mu7emlhX3TCN+4Ofw2hnkqP7HHIQfLiADl8y/T8sLTpf6djf9BzfsELHdqqNTBXib0RDNT8sGhnU
	07q7PjdOl0Ap9qGceTT/DmOTLs/iDvyUVsxxgACY/c4TUskW7gfd4wXw7derbXCb82F4k48FyID55
	o5vFVMGUZjh3Najpls3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw1jy-0008F5-Gg; Tue, 19 Feb 2019 09:31:02 +0000
Received: from mail-vs1-f68.google.com ([209.85.217.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw1jv-0008Ee-6c
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 09:31:00 +0000
Received: by mail-vs1-f68.google.com with SMTP id e81so8176302vsd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 01:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H1hqWke7hSkfFJ5YyU/r7zOfSU7Q3U0kRAuChdTv09k=;
 b=SPCWAfsqytizyfMlz0lAqoMsI44vWwFE9zzazWP0Wvi3QRfjD0enXRLlIhAoDoFg1l
 61lHCRLA8V56m0myqIj3rqD7ZAVTVlhxFP+vWEHcF6L+cPDT2YNdqIXdw5isMUGBXUvr
 C9US/My7PA8HW9w0T0D/hSOye2XH+O1XaTbtFv9QtE7S4ojIQ0wuMaW6sKbdJrWIQDZq
 REGbzo/3X4EvI8/qM9mi9nMM0f525LNShhXolKFOYdGcDEtCQdVg6RZ5a58jhRkcT6LQ
 e/Flfp5lnGRrochqdDFQx33tdP3CB7vgbiNWpSJX0L3OX7tCbUo6DqBv23n1gsWL958l
 9fBg==
X-Gm-Message-State: AHQUAub5x1r/07S1biJeJV3VR6nNiPNAiNKOFNA73xfqoqWlH85gs8uF
 Hr1oFoNcz77kSnGOi69Vaocv4eJOfnx2dw+R7VM=
X-Google-Smtp-Source: AHgI3IZxj7k6wDaxcerd0ePfHS8seMidk+JagXGSOdhHtTztuWXrbvTEy0q8/3rY6LdMH7Cx/kyQLIgLFNgKUsYsCGM=
X-Received: by 2002:a67:78ce:: with SMTP id
 t197mr13575764vsc.152.1550568657733; 
 Tue, 19 Feb 2019 01:30:57 -0800 (PST)
MIME-Version: 1.0
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
 <CAK8P3a2zkhrZLMi5KZ5=fGJCt85dad3_pZC0o7GqcwJkk4es9w@mail.gmail.com>
 <CAMz4ku+PR4bHtcPu2uT2f974+FWJVi8Tp3WzmuqE1TS-M-QawQ@mail.gmail.com>
 <CAMz4kuLEut0LqZ4bSAGJDufE8xHr6DgZ3Z1RCLQ10q_k6MUesw@mail.gmail.com>
 <CAK8P3a1Zq6XjymG3sAaHGeNRxU5UXPfJPbi0A9s47cTVK7vC3g@mail.gmail.com>
 <CAMz4kuL=B53xLk4SFbrwWeUhp4P9zbUfOmXgftQCEjVSwOnD5A@mail.gmail.com>
 <CAK8P3a03rPjWQvGrDupoTAywVmjCZdpSJpqW9Sv=NVPR2uwZeQ@mail.gmail.com>
 <CAMz4kuKnVppCB0-9LVgq8bya6=iWPhMcrHL_N53QfiU5Kn9YAA@mail.gmail.com>
In-Reply-To: <CAMz4kuKnVppCB0-9LVgq8bya6=iWPhMcrHL_N53QfiU5Kn9YAA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Feb 2019 10:30:44 +0100
Message-ID: <CAMuHMdWPZGYpvANL_V=YszPWjtTA+ZnU6GVDmn188LC=eC005Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Add one new cell to present
 hardware slave id
To: Baolin Wang <baolin.wang@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_013059_244601_556C78B6 
X-CRM114-Status: GOOD (  32.06  )
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
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Olof Johansson <olof@lixom.net>,
 Orson Zhai <orsonzhai@gmail.com>, Dan Williams <dan.j.williams@intel.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Baolin,

On Tue, Feb 19, 2019 at 4:15 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> On Mon, 18 Feb 2019 at 20:23, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Feb 18, 2019 at 11:52 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > On Mon, 18 Feb 2019 at 18:31, Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > On Tue, Feb 12, 2019 at 9:25 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > On Fri, 1 Feb 2019 at 19:53, Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > > On Thu, 31 Jan 2019 at 00:52, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > > On Tue, Jan 22, 2019 at 2:21 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > > > >
> > > > > > > >  Client:
> > > > > > > >  DMA clients connected to the Spreadtrum DMA controller must use the format
> > > > > > > > -described in the dma.txt file, using a two-cell specifier for each channel.
> > > > > > > > -The two cells in order are:
> > > > > > > > +described in the dma.txt file, using a three-cell specifier for each channel.
> > > > > > > > +The three cells in order are:
> > > > > > > >  1. A phandle pointing to the DMA controller.
> > > > > > > >  2. The channel id.
> > > > > > > > +3. The hardware slave id which is used for clients to trigger DMA engine
> > > > > > > > +automatically.
> > > > > > >
> > > > > > > I notice that this is an incompatible binding change. Is that necessary?
> > > > > > > If the current code works, I'd suggest allowing both #dma-cells=<2>
> > > > > > > and <3>, and then implementing both in the driver.
> > > > > >
> > > > > > Yes, this is necessary.
> > > > > >
> > > > > > Yes, current code can work, but the problem is that the DMA clients
> > > > > > must add one property (something like "sprd,slave-id") to specify the
> > > > > > slave id. So considering this, we want to change the dma-cells to 2,
> > > > > > including dma channel and dma slave id, which can avoid introducing
> > > > > > some similar properties for DMA clients.
> > > > > >
> > > > > > Now there are no DMA clients in mainline for Spreadtrum platform, and
> > > > > > we want to upstream our first DMA clients: SPI controller. So no other
> > > > > > drivers need to change when we changing dma cells. Thanks.
> > > > >
> > > > > Do you have any other concerns about this patch set? If not, I think
> > > > > Vinod can apply this patch set. Thanks.
> > > >
> > > > Sorry for the late reply. Yes, this makes sense since there are no
> > > > existing users then. For the DT changes going through the dmaengine
> > > > tree
> > > >
> > > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Thanks for your reviewing.
> > >
> > > >
> > > > One more question, to make sure we don't need to edit it again:
> > > > Why do you need both a 'channel id' and a 'slave id' here? Is this
> > > > a strict hardware requirement for your DMA engine? In many
> > > > other designs, only a DMA request line number needs to
> > > > be described, and I think this would correspond to what you
> > > > call the 'hardware slave id' in your documentation.
> > >
> > > I try to explain why we need the slave id.
> > >
> > > For our DMA engine driver, we have software request mode and hardware
> > > request mode. For software request mode, the DMA engine driver need
> > > trigger DMA to start transfer manually. But for hardware request mode,
> > > we just set one unique slave id corresponding to the slave hardware to
> > > the DMA engine, then the slave hardware can trigger DMA automatically.
> > > And the slave id is not always same with the channel id according to
> > > the SoC design, so we add one cell to specify the slave id.
> >
> > I did understand the need for a slave-id, I was instead wondering about
> > the channel-id number. On many SoCs, all channels are equal, and you
> > just have to pick one of those with the right capabilities for a particular
> > slave.
>
> Yes, all channels are equal. We just set a unique slave id for the
> channel for a particular slave. For example, the SPI slave can use
> channel 10 for tx transfer by setting slave id 11, or it also can use
> channel 9 for tx transfer by setting same slave id 11.

So the channel selection is software policy, not hardware description, and
thus doesn't belong in DT?

Can't the DMA engine driver allocate channels dynamically, removing the
need to specify this in DT?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
