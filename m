Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCA6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:53:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF432176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PzNnJKkq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQ0FVTAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF432176F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5RRM0cDru7oIjGntqSJbePae66l8eyaM97zLdtfXoz8=; b=PzNnJKkqXvl/CG
	zEsomkvyn2CzLfm7H3PCRXJjDcKheAKfOiYpGXR4p0YR9d4a0pYmRzJGbxn03hiwANYSm4VfV8WAe
	dLSza3dOzDJAuPgmqkf4tbVozRu5Ep3aUTvEPjUaFyOk2UVU9KBCl4lCMbn1IrLqYhDt/fz2rktqK
	Z+ZAGOKojxLcmd5p2xO6nrmoYi61Ajea0RTPwFgOfDYaIcBVD3X3NgxKq2gUrt4Znp37YQruUkmvw
	gxHjURuF+Bs447k/PkGf9QpOZoXfMvZaVCLgc03Xq04fB3tx8E2p2je0QbmVFx70FFjY1oStGS082
	k/ZvrGWeAm1ZBAV/IXYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvgXj-0001sI-Oh; Mon, 18 Feb 2019 10:52:59 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvgXg-0001rv-KT
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 10:52:58 +0000
Received: by mail-lj1-x243.google.com with SMTP id z25so6108622ljk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 02:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CC6KdorLKJMkicgELgpTwOMSFBb61BLug+n8sMHlNNE=;
 b=aQ0FVTAgAh1AmDGYYGeP5HNVOgDbZIQteYFysIV8WjWXEkf1yp+T7u04DWjDBhBOeo
 14Ldk8cyUD6YCbdrD+Np+wqszjJuxDSsLR2piGuurRL2X2MDsqJCY8Yg5bhDRMvnf/ek
 IQ3PAP/UcBLPGe0d+Ldgq0M2H1kWdAuTnAzRU/GBEdBRV6JAR91lol1oisE5AFj5Oq8h
 1M/9FHtT4DgRDJYVHERn7BGIWyY+CHDJ0kW6xa4eiHuKrgr0lTJHbwiGR84G1VzeTtim
 6Fc1Bx/zf8ohHxVTFHY6bdBgXmhm3bsmb0pEcwQOLAt3ck0x0SOrPqphy9XJv7mhFwvO
 lj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CC6KdorLKJMkicgELgpTwOMSFBb61BLug+n8sMHlNNE=;
 b=TCok9Rn83YF4k+moXFZOb+INluOPUfOrRFSEUyR389UX6ZO9xKqT4kDdlrqk7X5zbi
 5n4jSWajBsu+4oNdMGYoUhrA7Trchfn+x7Y8HECKrpEw+mujVFNH3FDJNjiOgG+14OiX
 nd/mT3cJG05xKZAuW1b+zGRdV5YO3g2TxV0JkekNrlhH+MPAT43DwPWTfA3gH0xGUbA0
 DructiyCo5Cup1/aBaneYuVoKjG7e00z6G7vF7PF3r42nRaKPgbIKQpK6LjM0H9kiXaK
 glcVy0BygJnm4PIRauKVHJZ3G6ZCj2OGNECMKsmHYTm/AAitH2rsR1W+egZzteBXrQKU
 BJUw==
X-Gm-Message-State: AHQUAuahpC7IYzfdk540piZLQ5IriXNFTjgfWu+N9HwsmLE7PG24N0eQ
 7j0LjNVl8Ug4nFAVgcTu/YM2/RaT05o3ewKEmS5L8g==
X-Google-Smtp-Source: AHgI3Ian99yzYlQaqTBpe48UhUpXkh7SKZMzNP8m7UWC+tojep5CMiISRwWf0mHl2AoC0RY96Ps/vRq/UiAyHfwNaY4=
X-Received: by 2002:a2e:6a18:: with SMTP id f24mr14330316ljc.97.1550487174177; 
 Mon, 18 Feb 2019 02:52:54 -0800 (PST)
MIME-Version: 1.0
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
 <CAK8P3a2zkhrZLMi5KZ5=fGJCt85dad3_pZC0o7GqcwJkk4es9w@mail.gmail.com>
 <CAMz4ku+PR4bHtcPu2uT2f974+FWJVi8Tp3WzmuqE1TS-M-QawQ@mail.gmail.com>
 <CAMz4kuLEut0LqZ4bSAGJDufE8xHr6DgZ3Z1RCLQ10q_k6MUesw@mail.gmail.com>
 <CAK8P3a1Zq6XjymG3sAaHGeNRxU5UXPfJPbi0A9s47cTVK7vC3g@mail.gmail.com>
In-Reply-To: <CAK8P3a1Zq6XjymG3sAaHGeNRxU5UXPfJPbi0A9s47cTVK7vC3g@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Mon, 18 Feb 2019 18:52:40 +0800
Message-ID: <CAMz4kuL=B53xLk4SFbrwWeUhp4P9zbUfOmXgftQCEjVSwOnD5A@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Add one new cell to present
 hardware slave id
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_025256_676773_D766CA9F 
X-CRM114-Status: GOOD (  25.36  )
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

On Mon, 18 Feb 2019 at 18:31, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Feb 12, 2019 at 9:25 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > On Fri, 1 Feb 2019 at 19:53, Baolin Wang <baolin.wang@linaro.org> wrote:
> > > On Thu, 31 Jan 2019 at 00:52, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Tue, Jan 22, 2019 at 2:21 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > >
> > > > >  Client:
> > > > >  DMA clients connected to the Spreadtrum DMA controller must use the format
> > > > > -described in the dma.txt file, using a two-cell specifier for each channel.
> > > > > -The two cells in order are:
> > > > > +described in the dma.txt file, using a three-cell specifier for each channel.
> > > > > +The three cells in order are:
> > > > >  1. A phandle pointing to the DMA controller.
> > > > >  2. The channel id.
> > > > > +3. The hardware slave id which is used for clients to trigger DMA engine
> > > > > +automatically.
> > > >
> > > > I notice that this is an incompatible binding change. Is that necessary?
> > > > If the current code works, I'd suggest allowing both #dma-cells=<2>
> > > > and <3>, and then implementing both in the driver.
> > >
> > > Yes, this is necessary.
> > >
> > > Yes, current code can work, but the problem is that the DMA clients
> > > must add one property (something like "sprd,slave-id") to specify the
> > > slave id. So considering this, we want to change the dma-cells to 2,
> > > including dma channel and dma slave id, which can avoid introducing
> > > some similar properties for DMA clients.
> > >
> > > Now there are no DMA clients in mainline for Spreadtrum platform, and
> > > we want to upstream our first DMA clients: SPI controller. So no other
> > > drivers need to change when we changing dma cells. Thanks.
> >
> > Do you have any other concerns about this patch set? If not, I think
> > Vinod can apply this patch set. Thanks.
>
> Sorry for the late reply. Yes, this makes sense since there are no
> existing users then. For the DT changes going through the dmaengine
> tree
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your reviewing.

>
> One more question, to make sure we don't need to edit it again:
> Why do you need both a 'channel id' and a 'slave id' here? Is this
> a strict hardware requirement for your DMA engine? In many
> other designs, only a DMA request line number needs to
> be described, and I think this would correspond to what you
> call the 'hardware slave id' in your documentation.

I try to explain why we need the slave id.

For our DMA engine driver, we have software request mode and hardware
request mode. For software request mode, the DMA engine driver need
trigger DMA to start transfer manually. But for hardware request mode,
we just set one unique slave id corresponding to the slave hardware to
the DMA engine, then the slave hardware can trigger DMA automatically.
And the slave id is not always same with the channel id according to
the SoC design, so we add one cell to specify the slave id.

>
> Does each request line here correspond to a fixed channel
> id as well, or can a channel be shared between multiple

Yes, each request line corresponds to a fixed channel id.

> slave devices?
>
>       Arnd



-- 
Baolin Wang
Best Regards

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
