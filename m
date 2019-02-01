Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F5BC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:54:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 418BD2082C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UaU0FPuV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BajNbnwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418BD2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1+uMUTwQYi9ZLaqOpCPiXKEDZT0ETgKyY7c8FuU0hA4=; b=UaU0FPuVWJQAtl
	7decsOVBQRNjwVEauoJV1r9c/F3uEkkjL5Q2I5f8ywF4hQqQW0bTe6dZgtuY9roIc69555kYY5u3I
	qmmQ45j78AF8L996yKM6ZmsXMKFBp9/pmvX+BgrTUrDgKlrEoXBk8aWpdA9XjYPJTzRSnXgsy3E55
	OWFlIA9mC0NLQST8vEOO3JAfkBy6PdQcYDpbQC8dmWdg8IWfx4Vfe6Px1yocnUaamT1CL/2G5Xeq5
	eCbu2l7lPPusz5p4gFA41T0dgRhm8Gp6ZOOMNRpmcpQvkuStRMJgNwBfjUm8Exg5lTFXNbWdN02og
	321kJG8zQv7NoBurW++w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpXOT-0001Y1-3u; Fri, 01 Feb 2019 11:54:01 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpXOP-0001XE-Q1
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 11:53:59 +0000
Received: by mail-lf1-x144.google.com with SMTP id l10so4817740lfh.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 03:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xpRTTMlXvo5iJGg8Z+QDezDrFBfn1zKTvs291ylpF/k=;
 b=BajNbnwafd+Y9vEr27RgET3wODGRDc8jo1IJ41kPua5DIUQskDKod/VXbJ0NMIV2vs
 qMpLQ5Z6vsyNcUBOyiAirDLn7utambUZ0qMy4QmcZdqQP3uKqrFT+fEph5y0QzOs6IxN
 9FGw5VjpU0Qvl3R0j3PxUH34pIMWfxgZthTGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xpRTTMlXvo5iJGg8Z+QDezDrFBfn1zKTvs291ylpF/k=;
 b=Oj/lk+4Q6udcQZtTKkEpG7PUdjfEzAFoQIeFNcahkCTi0RO5eNN96vO4lX7fUKCoUz
 tO1op9IuP+BaY/kZ2CqUha2rBn+a2o8m4JTmcilbwGn757CPA6QcNBYRshmuElVimq/3
 WG89sNzVqK0m20+m/vPJEQREmpHiYrlSHOT4xWvSutWPiLdnd0au6uR9ekIHK3Nf+RoG
 1YRYEBDLkWPQ/zN2ImqOUYCfDQJSxIxozrn0excpz4jMEM7rFq1ZcSUFH+LBRmQz8VlV
 6ApzpJ6QCccIK75yeML/ArAQkNG7AzDon4tiWgsrY70wkkEnrE4umIJW0j2l8NLcLVnD
 POog==
X-Gm-Message-State: AHQUAuYJS/SCTPtSZwEwBMHOAB3GF+bX/spW8dX0SMMh7IW0U1vqepwg
 Vm/lvX/J0vtz+vqr8x7/wYlONMERqi5JHYaC0M81TQ==
X-Google-Smtp-Source: AHgI3IZdhQBgZpxs/IBN5+9GwRe8RZuo48hCOuYc/lZTwNWld+Ik8lnQVZcFXW3aUzFxZO5vfpkypX71H28UTOEBaAY=
X-Received: by 2002:a19:f013:: with SMTP id p19mr3305023lfc.61.1549022033248; 
 Fri, 01 Feb 2019 03:53:53 -0800 (PST)
MIME-Version: 1.0
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
 <CAK8P3a2zkhrZLMi5KZ5=fGJCt85dad3_pZC0o7GqcwJkk4es9w@mail.gmail.com>
In-Reply-To: <CAK8P3a2zkhrZLMi5KZ5=fGJCt85dad3_pZC0o7GqcwJkk4es9w@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Fri, 1 Feb 2019 19:53:42 +0800
Message-ID: <CAMz4ku+PR4bHtcPu2uT2f974+FWJVi8Tp3WzmuqE1TS-M-QawQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Add one new cell to present
 hardware slave id
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_035357_857751_BEB60D7A 
X-CRM114-Status: GOOD (  22.13  )
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
On Thu, 31 Jan 2019 at 00:52, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jan 22, 2019 at 2:21 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > The DMA engine clients can trigger DMA engine automatically by setting
> > the corresponding hardware slave id for the DMA engine. Thus add one
> > cell to present the hardware slave id for DMA clients.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/dma/sprd-dma.txt |   12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/sprd-dma.txt b/Documentation/devicetree/bindings/dma/sprd-dma.txt
> > index 7a10fea..7812cf0 100644
> > --- a/Documentation/devicetree/bindings/dma/sprd-dma.txt
> > +++ b/Documentation/devicetree/bindings/dma/sprd-dma.txt
> > @@ -6,8 +6,8 @@ Required properties:
> >  - compatible: Should be "sprd,sc9860-dma".
> >  - reg: Should contain DMA registers location and length.
> >  - interrupts: Should contain one interrupt shared by all channel.
> > -- #dma-cells: must be <1>. Used to represent the number of integer
> > -       cells in the dmas property of client device.
> > +- #dma-cells: must be <2>. Used to represent the channel id and slave id
> > +       of integer cells in the dmas property of client device.
> >  - #dma-channels : Number of DMA channels supported. Should be 32.
> >  - clock-names: Should contain the clock of the DMA controller.
> >  - clocks: Should contain a clock specifier for each entry in clock-names.
> > @@ -28,14 +28,16 @@ apdma: dma-controller@20100000 {
> >
> >  Client:
> >  DMA clients connected to the Spreadtrum DMA controller must use the format
> > -described in the dma.txt file, using a two-cell specifier for each channel.
> > -The two cells in order are:
> > +described in the dma.txt file, using a three-cell specifier for each channel.
> > +The three cells in order are:
> >  1. A phandle pointing to the DMA controller.
> >  2. The channel id.
> > +3. The hardware slave id which is used for clients to trigger DMA engine
> > +automatically.
>
> I notice that this is an incompatible binding change. Is that necessary?
> If the current code works, I'd suggest allowing both #dma-cells=<2>
> and <3>, and then implementing both in the driver.

Yes, this is necessary.

Yes, current code can work, but the problem is that the DMA clients
must add one property (something like "sprd,slave-id") to specify the
slave id. So considering this, we want to change the dma-cells to 2,
including dma channel and dma slave id, which can avoid introducing
some similar properties for DMA clients.

Now there are no DMA clients in mainline for Spreadtrum platform, and
we want to upstream our first DMA clients: SPI controller. So no other
drivers need to change when we changing dma cells. Thanks.

-- 
Baolin Wang
Best Regards

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
