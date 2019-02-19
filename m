Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DADEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:15:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6FC2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ShJx0pjF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLQH/9ym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6FC2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6pse+w+pS805I3wj+ImAIZjyWVc2t7/R4wWSbXTU0Aw=; b=ShJx0pjF2CAuXm
	29EwB2+BFZ7IzKyEzf3cs4Q7VnyKS1luDAyj0AMNewU+3p6s8DMXNXq+tfSa/4niR6rAR6V2KoDXF
	EhCsTtsJ/aLO3uVz9nzO1TisFLKbdRG3nZUMXFpREoomBYt7xpoL0+w/s4+sv4E9y8MKbF4PtSI0x
	7i6toK0K9OSl4KFG6BDcXf/gqjPIGfGScTD6zfIWSlu53cP7FNiVz/nTubaRBelNRJWA/we6k1LtV
	j8aul/iqaiJAPmpMOAJjjydtPRM82n+eJDXrm4uLvXbx+TE2/toFEr/N3MgxaxqOc/kLks0TKX7ZZ
	5vM6kpMZnzdTMQnccX5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvvsE-0006GO-Iq; Tue, 19 Feb 2019 03:15:10 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvvsA-0005bQ-TB
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 03:15:08 +0000
Received: by mail-lf1-x142.google.com with SMTP id m11so13792375lfc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 19:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hdLUwKcokxRXXPlKQmoqNF6GD0kvrlp4gDbhl0FFC/I=;
 b=XLQH/9ymu8qh8L/POSn+XYvYovnWZdMpr+aUpTSXKpaSZVTA6mVdnUezm4SEqRu2hM
 MvOZ6Lj+Eytgr8yr8/lROc450iMU6j0qUcAh4NMW8bAfuOwGiqsaQTpETQW9BaV/Td1u
 GZmaH7+G5PtZ2IFLmKLSGbqs+AI2bMWVx4BbyNY7q6AH7DpBRPUz8Rr4oz3Jqh+dcFaS
 E3i1TVjquKOpj4RwTE9vXwT0i1BsESm+rlYZq/AGRVo6mGYql5X/EYqqRDDf3VJGGXYE
 R4BD56opgWhKDjN3mu3+S2tCErVtwS2HuA3VAurl/s6UiS8OvHRfX5eLTvaI3+GECu/3
 kGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hdLUwKcokxRXXPlKQmoqNF6GD0kvrlp4gDbhl0FFC/I=;
 b=NOGitWIciO9T9p9sS6U6bpRqMB5QP9yIlYWv3yWxd7ip9X/jkp0g/nO04hfBtgrTk8
 NQ+XK4P6sldCYK0cpQlHSTl72UBFF37H2/32vSzEUSHesWOveIGRwVxvS4s1RDw8emUJ
 NJcrSvNWcf7kkV60c4tU3O+kmE0C0pZTGUaMwygeIwBWRatQ6S3AcV8PgXbaZ958q2uP
 8Z/IvQ/BTSoMSSwJW0oYjbFFWf4oK84bOE20eKT9nWRSDA+4/MTphVw09/4sfLIYbb3R
 Z1oiM72BEuc0hDGrmVU0jyyPYmwZzJFncRlBtUGvEgBIzfpV32Sd0nBO1XVD8a0N4oWe
 kQlA==
X-Gm-Message-State: AHQUAuZHf7il5+b90oSrPvg65HdoA4jnmDMrKAIpiIYv8pezi5KmTOXB
 pNL6MagqW91qlPOAB4y3nDCf+EekttJ6kDJ7zDmD0A==
X-Google-Smtp-Source: AHgI3IYf9jlsfP7yffLtGOuw872rkg3k9NN6vlY7WDqxUmPkbrGWtyJ7hlT5m/yQKgtcCrB8IKI9/xGmxpb3wIcCpuE=
X-Received: by 2002:a19:e601:: with SMTP id d1mr16582477lfh.71.1550546103805; 
 Mon, 18 Feb 2019 19:15:03 -0800 (PST)
MIME-Version: 1.0
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
 <CAK8P3a2zkhrZLMi5KZ5=fGJCt85dad3_pZC0o7GqcwJkk4es9w@mail.gmail.com>
 <CAMz4ku+PR4bHtcPu2uT2f974+FWJVi8Tp3WzmuqE1TS-M-QawQ@mail.gmail.com>
 <CAMz4kuLEut0LqZ4bSAGJDufE8xHr6DgZ3Z1RCLQ10q_k6MUesw@mail.gmail.com>
 <CAK8P3a1Zq6XjymG3sAaHGeNRxU5UXPfJPbi0A9s47cTVK7vC3g@mail.gmail.com>
 <CAMz4kuL=B53xLk4SFbrwWeUhp4P9zbUfOmXgftQCEjVSwOnD5A@mail.gmail.com>
 <CAK8P3a03rPjWQvGrDupoTAywVmjCZdpSJpqW9Sv=NVPR2uwZeQ@mail.gmail.com>
In-Reply-To: <CAK8P3a03rPjWQvGrDupoTAywVmjCZdpSJpqW9Sv=NVPR2uwZeQ@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Tue, 19 Feb 2019 11:14:52 +0800
Message-ID: <CAMz4kuKnVppCB0-9LVgq8bya6=iWPhMcrHL_N53QfiU5Kn9YAA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Add one new cell to present
 hardware slave id
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_191506_978424_CB2A868D 
X-CRM114-Status: GOOD (  28.58  )
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

On Mon, 18 Feb 2019 at 20:23, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Feb 18, 2019 at 11:52 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > On Mon, 18 Feb 2019 at 18:31, Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Tue, Feb 12, 2019 at 9:25 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > On Fri, 1 Feb 2019 at 19:53, Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > On Thu, 31 Jan 2019 at 00:52, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > On Tue, Jan 22, 2019 at 2:21 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > > >
> > > > > > >  Client:
> > > > > > >  DMA clients connected to the Spreadtrum DMA controller must use the format
> > > > > > > -described in the dma.txt file, using a two-cell specifier for each channel.
> > > > > > > -The two cells in order are:
> > > > > > > +described in the dma.txt file, using a three-cell specifier for each channel.
> > > > > > > +The three cells in order are:
> > > > > > >  1. A phandle pointing to the DMA controller.
> > > > > > >  2. The channel id.
> > > > > > > +3. The hardware slave id which is used for clients to trigger DMA engine
> > > > > > > +automatically.
> > > > > >
> > > > > > I notice that this is an incompatible binding change. Is that necessary?
> > > > > > If the current code works, I'd suggest allowing both #dma-cells=<2>
> > > > > > and <3>, and then implementing both in the driver.
> > > > >
> > > > > Yes, this is necessary.
> > > > >
> > > > > Yes, current code can work, but the problem is that the DMA clients
> > > > > must add one property (something like "sprd,slave-id") to specify the
> > > > > slave id. So considering this, we want to change the dma-cells to 2,
> > > > > including dma channel and dma slave id, which can avoid introducing
> > > > > some similar properties for DMA clients.
> > > > >
> > > > > Now there are no DMA clients in mainline for Spreadtrum platform, and
> > > > > we want to upstream our first DMA clients: SPI controller. So no other
> > > > > drivers need to change when we changing dma cells. Thanks.
> > > >
> > > > Do you have any other concerns about this patch set? If not, I think
> > > > Vinod can apply this patch set. Thanks.
> > >
> > > Sorry for the late reply. Yes, this makes sense since there are no
> > > existing users then. For the DT changes going through the dmaengine
> > > tree
> > >
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Thanks for your reviewing.
> >
> > >
> > > One more question, to make sure we don't need to edit it again:
> > > Why do you need both a 'channel id' and a 'slave id' here? Is this
> > > a strict hardware requirement for your DMA engine? In many
> > > other designs, only a DMA request line number needs to
> > > be described, and I think this would correspond to what you
> > > call the 'hardware slave id' in your documentation.
> >
> > I try to explain why we need the slave id.
> >
> > For our DMA engine driver, we have software request mode and hardware
> > request mode. For software request mode, the DMA engine driver need
> > trigger DMA to start transfer manually. But for hardware request mode,
> > we just set one unique slave id corresponding to the slave hardware to
> > the DMA engine, then the slave hardware can trigger DMA automatically.
> > And the slave id is not always same with the channel id according to
> > the SoC design, so we add one cell to specify the slave id.
>
> I did understand the need for a slave-id, I was instead wondering about
> the channel-id number. On many SoCs, all channels are equal, and you
> just have to pick one of those with the right capabilities for a particular
> slave.

Yes, all channels are equal. We just set a unique slave id for the
channel for a particular slave. For example, the SPI slave can use
channel 10 for tx transfer by setting slave id 11, or it also can use
channel 9 for tx transfer by setting same slave id 11.

-- 
Baolin Wang
Best Regards

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
