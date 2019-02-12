Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B720C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:25:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 077172070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gFxz+fMs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qnh8semr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077172070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/GU2ZFMtThorcjvEcBD8MdRCOKuqq3p5BkyS3OKFSNo=; b=gFxz+fMsZBx/0h
	0LNTm3CN7bs77L7w1V39+dnKQerpiUYsS54OroqZeAszeBzS05jdjHgWphIEgs9dizMgc926tV08y
	9kfCgvHhDSGMt9s7lHwagPuc9kLfCBGh+wPBzCuwFiUJ6IL/rF1Oma5pyfvWSZRK3lrWNTTm6u7Oe
	ZuMDlu4yIEuZBfCeXpAEBTjFvzK6BDGsED7/NoaaatHTf6Tml3w7VU4Qm1dMtiIxflHIESA1xvJiw
	etjEePQpzO6l6vXlXiMbyaeD3hlWiPkmJSyMl5qt491E+qoa4vSOd059IXgLuEFDEEGRorjWTeaD0
	+XRWTDfTqXsSXind3Sxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtTNO-0008Mf-GM; Tue, 12 Feb 2019 08:25:10 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtTNK-0007p9-7o
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 08:25:08 +0000
Received: by mail-lf1-x141.google.com with SMTP id f5so1268358lfc.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 00:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wktXpzSXXJvpSrZpX4mhoTSLqogh/PevmF85W+dF9cM=;
 b=Qnh8semrh1DcHuUkDn5qlRRsHDJtErWfRjfO0x5CZad7WonhInbg3jmEkYvfRyWr25
 KfC+FMr6Zytqe8TroVrLAsmbRNO+QVtYvZN4k+vPsRELO/BpNsEkvilYGbUzaT431WAu
 MxYMmoeN0xDvQLLJREa4eQV97ehPXqe0x6TnT9KwtvMYNLanvKjr4no5lI19yFDp0SXQ
 j8j+L6HMY6i628yPGr2c8yF9I2e7XHzPRTHkqYJ1Ane9yuMiM+VIFhTpAC+06mQ23yFk
 ht/Du1kNG1fcJQHZ0kHR7Nc56WuBOf8P1hPIVjzWeQv8QharGPdSrVKLlZGGY0ssE3h9
 lp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wktXpzSXXJvpSrZpX4mhoTSLqogh/PevmF85W+dF9cM=;
 b=GiRY6giOktek+yv4mfMEDWNswAAbMzrD+KC2PqxGOHHlKHPbY7PhAd/QMY7iAdZLRF
 nd9P3LXtR/Ffgt2tdMupsZ4dALZed0ty/+2yWnqyoxMyX5FSbn2gDBaH5rXTbDUE5AoM
 C/ACThxrVth92HDdQfQEArfSP5F7TW7lNW/Z3ktyXyjhgek/x4Iw7s2Ky/pZzDWyh3Sd
 jRJZGe3c8w92fpSwS39J+exlK+hWzVK7QW4rPeGkxoMQvlE0wyxxc2dJBiZP6dB2+ljh
 hZ0kinzuSHL0NtbTiq+aU8G7FT4LsIe+v2FUJGzG96VyaAq1J/dpDCaL0SBEF/CAO+CG
 i1Pg==
X-Gm-Message-State: AHQUAuahxbMzaOvPPY7WdLhtWANe9wsRJsxhFl0h5HSQ0yqgdI5v/A1l
 sKgzfX/V35s4ST3QSlkckE08goC8FZX8gOLk5+iq/A==
X-Google-Smtp-Source: AHgI3IYYib9XJLsQp00hGP3I2v1BP6kkaVEtUEkfH7PpxS7yItLf9x3za9NEjPM/h8WYvpIMMI/RdGWDDMekSQyqATo=
X-Received: by 2002:ac2:42c5:: with SMTP id n5mr1565426lfl.115.1549959903405; 
 Tue, 12 Feb 2019 00:25:03 -0800 (PST)
MIME-Version: 1.0
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
 <CAK8P3a2zkhrZLMi5KZ5=fGJCt85dad3_pZC0o7GqcwJkk4es9w@mail.gmail.com>
 <CAMz4ku+PR4bHtcPu2uT2f974+FWJVi8Tp3WzmuqE1TS-M-QawQ@mail.gmail.com>
In-Reply-To: <CAMz4ku+PR4bHtcPu2uT2f974+FWJVi8Tp3WzmuqE1TS-M-QawQ@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Tue, 12 Feb 2019 16:24:51 +0800
Message-ID: <CAMz4kuLEut0LqZ4bSAGJDufE8xHr6DgZ3Z1RCLQ10q_k6MUesw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Add one new cell to present
 hardware slave id
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_002506_424012_E347FDA6 
X-CRM114-Status: GOOD (  27.22  )
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

Hi Arnd,

On Fri, 1 Feb 2019 at 19:53, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> Hi Arnd,
> On Thu, 31 Jan 2019 at 00:52, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Jan 22, 2019 at 2:21 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> > >
> > > The DMA engine clients can trigger DMA engine automatically by setting
> > > the corresponding hardware slave id for the DMA engine. Thus add one
> > > cell to present the hardware slave id for DMA clients.
> > >
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/dma/sprd-dma.txt |   12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/dma/sprd-dma.txt b/Documentation/devicetree/bindings/dma/sprd-dma.txt
> > > index 7a10fea..7812cf0 100644
> > > --- a/Documentation/devicetree/bindings/dma/sprd-dma.txt
> > > +++ b/Documentation/devicetree/bindings/dma/sprd-dma.txt
> > > @@ -6,8 +6,8 @@ Required properties:
> > >  - compatible: Should be "sprd,sc9860-dma".
> > >  - reg: Should contain DMA registers location and length.
> > >  - interrupts: Should contain one interrupt shared by all channel.
> > > -- #dma-cells: must be <1>. Used to represent the number of integer
> > > -       cells in the dmas property of client device.
> > > +- #dma-cells: must be <2>. Used to represent the channel id and slave id
> > > +       of integer cells in the dmas property of client device.
> > >  - #dma-channels : Number of DMA channels supported. Should be 32.
> > >  - clock-names: Should contain the clock of the DMA controller.
> > >  - clocks: Should contain a clock specifier for each entry in clock-names.
> > > @@ -28,14 +28,16 @@ apdma: dma-controller@20100000 {
> > >
> > >  Client:
> > >  DMA clients connected to the Spreadtrum DMA controller must use the format
> > > -described in the dma.txt file, using a two-cell specifier for each channel.
> > > -The two cells in order are:
> > > +described in the dma.txt file, using a three-cell specifier for each channel.
> > > +The three cells in order are:
> > >  1. A phandle pointing to the DMA controller.
> > >  2. The channel id.
> > > +3. The hardware slave id which is used for clients to trigger DMA engine
> > > +automatically.
> >
> > I notice that this is an incompatible binding change. Is that necessary?
> > If the current code works, I'd suggest allowing both #dma-cells=<2>
> > and <3>, and then implementing both in the driver.
>
> Yes, this is necessary.
>
> Yes, current code can work, but the problem is that the DMA clients
> must add one property (something like "sprd,slave-id") to specify the
> slave id. So considering this, we want to change the dma-cells to 2,
> including dma channel and dma slave id, which can avoid introducing
> some similar properties for DMA clients.
>
> Now there are no DMA clients in mainline for Spreadtrum platform, and
> we want to upstream our first DMA clients: SPI controller. So no other
> drivers need to change when we changing dma cells. Thanks.

Do you have any other concerns about this patch set? If not, I think
Vinod can apply this patch set. Thanks.

-- 
Baolin Wang
Best Regards

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
