Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B767C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:29:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 427592147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XyNBELn1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYTfXEaP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427592147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9FaAOq+EXsQyiXm7mIM6XH49Td8f8BYUYVgkuya+hBg=; b=XyNBELn1bZpWJ3
	cahpfntqHEsaVH8V4j7cdbzDJcR6Itmfr6SppDp4YyHB035Pt9IfTaBDFxFytor9w2jrfRUWrxT4r
	YlyfEDKIh3OKAVFw/VbGvE9YbLAoNEoa848H6yh0fy1pN9JrxdMXd2Bwky9pt9Ykr8YtsJt0Pg40U
	YR4ESO4Zh67+o9PemzUm/+Vngv1KWGVjsG/Sqwx4kgl9FMJe6KXSzXwaSHzXaPxeJB/k3Usqhx7fq
	oq9zzHM+bsxEsDTi41CGi3mI0TSvmwZQGcIBGarihg6Xt0InyIRKAJWVgBlA0Ox3mrDZy+R5A/tk7
	WdSpAiRQVhXRgWm1zjUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwQ4J-0008Ht-Ut; Wed, 20 Feb 2019 11:29:39 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwQ4G-0008GZ-QO
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 11:29:38 +0000
Received: by mail-lj1-x241.google.com with SMTP id l5so17076588lje.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 03:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0ekYov34e3h7u4UagIP+Zwo8KjjfYo+mnO834hleTZ4=;
 b=HYTfXEaPkaICjJnZ4jr8pRdKYfpJNSFMHI8bCK02hqnq5Ibjj4ZZGTU7D4fXTqJzXS
 U5kXaWRwI28r8buinjdqah6lA6jNn2yJU74clGfzkZnViqBKQ45qcvctt20YxUx6cxIm
 s3T5Wc+fci5nTIZdZ4vurnByMBEDoihIfwGDsTf8r7NjcVvr52M3yagkQugubIdiq6Ky
 yfa6ownOi8PUg1lQSUfBfEEsEf8yaa/eheO/9JrIMY000UiwP7WOTzP2SE7sU4/z8Wfy
 giO+nbJr2fM+sctHb7T4UvqhlodCx51nMMkzx/2fE7RwS300qN2ehJGh2Cxs1+ZK3YGS
 AWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0ekYov34e3h7u4UagIP+Zwo8KjjfYo+mnO834hleTZ4=;
 b=E+MHXgwY85/3OVwy2RgI8ltx0UY/tQRkgfgP/cubQ0MU7Ca5zrX5c1gjI14XTwrXhg
 u5ldqvmrQXgmJyQzyf34cLIVpgqGuTO7uEC7Uh93a6vrjHeBhiG9zmKQToTV5CyDmfbd
 XiUNj6XYdLZoXecudj2CUvP+JND+baj53JGsj+fShyUO2ZpAePX+Dppi8XSUmmR+43e/
 yKAbpye+0zbOYq2Mxz8/rIvvlckjH5A/XXt5CBVZmmIrXhjeP2DqBngFEVPHdXw+Xk/i
 aGV9SKQnA0lm2l3BfzhTqhxageh+IOv5HP2AP/KfiN9gEO8KsamkocC4usiys2uIv0UK
 LMZQ==
X-Gm-Message-State: AHQUAubG5uaPQ1lUoXOi/NlzqGAN2MiZRfFdYOY6z6IbrEdsVzN6HM1U
 BIeU+b6f7CsS2SkT6DrcuK4Kfut0YS7gnAR6yFvBDsb0puUDmA==
X-Google-Smtp-Source: AHgI3IZ6DunjBMJqeQTlyzBj4lmU5s4I2BoY2Tz1fFIKZr5d7bdtC1aCzA+7qgcnorplKV0zkhifYj1JTb48/zDEs7k=
X-Received: by 2002:a2e:81c7:: with SMTP id s7mr20131487ljg.146.1550662174696; 
 Wed, 20 Feb 2019 03:29:34 -0800 (PST)
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
 <CAMz4kuK89AyL6PA2dRF1t=tR6-fKXKp+x3oi+cKDqSqi08xv0Q@mail.gmail.com>
 <CAK8P3a0z4YSr2BCnM91gBNduhODmx25fF7y6_wgsc_u3i_5YEg@mail.gmail.com>
In-Reply-To: <CAK8P3a0z4YSr2BCnM91gBNduhODmx25fF7y6_wgsc_u3i_5YEg@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 20 Feb 2019 19:29:23 +0800
Message-ID: <CAMz4kuLZH2dt5JTB1uYcLkm4EG_Av=7mnAj51s-J1-6E8+R5CA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Add one new cell to present
 hardware slave id
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_032936_871656_FD6ECBD8 
X-CRM114-Status: GOOD (  25.44  )
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
 Rob Herring <robh+dt@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Olof Johansson <olof@lixom.net>, Orson Zhai <orsonzhai@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 20 Feb 2019 at 17:08, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Feb 20, 2019 at 4:13 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > On Tue, 19 Feb 2019 at 20:20, Vinod Koul <vkoul@kernel.org> wrote:
> > > On 19-02-19, 17:49, Baolin Wang wrote:
> > > > On Tue, 19 Feb 2019 at 17:30, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Tue, Feb 19, 2019 at 4:15 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > > On Mon, 18 Feb 2019 at 20:23, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > > On Mon, Feb 18, 2019 at 11:52 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > > > > On Mon, 18 Feb 2019 at 18:31, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > > I did understand the need for a slave-id, I was instead wondering about
> > > > > > > the channel-id number. On many SoCs, all channels are equal, and you
> > > > > > > just have to pick one of those with the right capabilities for a particular
> > > > > > > slave.
> > > > > >
> > > > > > Yes, all channels are equal. We just set a unique slave id for the
> > > > > > channel for a particular slave. For example, the SPI slave can use
> > > > > > channel 10 for tx transfer by setting slave id 11, or it also can use
> > > > > > channel 9 for tx transfer by setting same slave id 11.
> > > > >
> > > > > So the channel selection is software policy, not hardware description, and
> > > > > thus doesn't belong in DT?
> > > > >
> > > > > Can't the DMA engine driver allocate channels dynamically, removing the
> > > > > need to specify this in DT?
> > > >
> > > > In theory we can do as you suggested. But we still want to
> > > > manage/assign the DMA channel resources manually for one SoC, we can
> > > > make sure some important DMA slaves (such as audio)  can request a DMA
> > > > channel at runtime firstly, another benefit is that it is easy to
> > > > debug since we can easily know which channel is assigned for this
> > > > slave.
> > >
> > > Are  you suggesting that you have more users than channels available?
> >
> > Until now we have not met this issue, but we can not make sure if this
> > can happen in future. Moreover DMA channel resources are belonging to
> > the DMA engine's hardware resources, I think it should be described in
> > DT like many other drivers did.
>
> As far as I can tell, most platforms do not describe the assignment
> of resources in DT for dma engines, the numbers in there are meant to
> describe whatever is fixed, and most platforms should do it that way.
>
> The naming is sometimes a bit confusing, as a dma request line
> assignment can be called a slave-id or a channel-id depending whose
> documentation you read. The drivers/dma/virt-dma.c implementation
> is used in some cases to represent request numbers as virtual
> channels, so a dmaengine driver can allow one dma_request_chan()
> per slave, and then assign the hardware channels dynamically
> while doing a transfer, rather than having a fixed channel assignment
> when we first ask for a channel.

Okay, sounds reasonable to me, and I think no issues will happen if we
assign channels dynamically after some slave usages' investigation.

I will remove channel id from DT in next version. Thanks for all your help.

-- 
Baolin Wang
Best Regards

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
