Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB449C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:08:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D718208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KZDU1/8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D718208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rdXucZcyAEtCzIcE9dIffk0V/D3XUFMWYinqBVXGYYg=; b=KZDU1/8wtv7go7
	y9orX6yrJE29aq7MyDqZyRoEEDJlZnNvJlChEjZEuMKDTq8qCD4DheopyIMBPR7A6UcVi4nHRTabc
	J/+YE9RW/Zn/jG2HKSBZ+8vDvyCLrhD6ju97edZqpm4inr1e5Hw41IZ3QtuYX0/6gpG8i7GhPiGl7
	61CuZxUTU1Dyra2aDyWXLVxCKSjzYqfjLXdOPnhVd0YmmCv250ap3xaGSGE8NiLJpVROSSqEHRDjZ
	3tiCugTV7VotkxrytahTlWp/lzyoeHf9uJwfq45F6xnQrwH+h4uFj18wPwCOjx3eFk7OqVylpVuDq
	aL84HdnzI95dqRwSj/fA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwNrL-0005K0-Ec; Wed, 20 Feb 2019 09:08:07 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwNrI-0005Je-9a
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 09:08:05 +0000
Received: by mail-qt1-f195.google.com with SMTP id z25so4609239qti.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 01:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5mUECuGflbT+3OtT6Ql/vTgnLCOiUQ5tsdWlat+sv/Y=;
 b=aCDoWigPCT8F8m1PGXSHn4SAnSw68x80JGLCgfOcsF+BzyaIntJvgb5ZZ3EW+ebDHe
 UoKbbdul5JVIKskRP4b0NOZWUmxhfnaRb63697KO5T561uj7Wnwv3L5bB6oB860d8XlR
 xdeHWylz7yweNPWZ7LjDTx4eQIQpc5zC8kwxBCcksqCd9KDGghi/xAfz5O1/EV70qvZo
 iCyxjt5SdQe+NfS369h0iBwToRCz7ErwnB8v4OPkm60bxRFMMpWnwpzwgh/EKZQFvu52
 tNwGuw1Rwt3x1bk50WsBpuM9SaxRhzLuQvhiwCl+a5aNg4cSTnclZPhBIcSKGx5n2WCe
 5FUA==
X-Gm-Message-State: AHQUAubQFjD4LZnRUL8fn7kzaRETw5CoS36A7cJzJBhW+7kaIij2xVWo
 rPnqB+DHuTREJ8Vf9xqb5cCyGzIz7uH+kf/tD0GyRPBG
X-Google-Smtp-Source: AHgI3IZWXZxDXh+oD/tkm0U25m4N156z1aOGikcR6Ar0JR2Zc7I+/44wb6s1Aub2dRK2i/9nNcSLWUWa4b4WDaEaffM=
X-Received: by 2002:ac8:445a:: with SMTP id m26mr25849852qtn.212.1550653682931; 
 Wed, 20 Feb 2019 01:08:02 -0800 (PST)
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
In-Reply-To: <CAMz4kuK89AyL6PA2dRF1t=tR6-fKXKp+x3oi+cKDqSqi08xv0Q@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 Feb 2019 10:07:45 +0100
Message-ID: <CAK8P3a0z4YSr2BCnM91gBNduhODmx25fF7y6_wgsc_u3i_5YEg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Add one new cell to present
 hardware slave id
To: Baolin Wang <baolin.wang@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_010804_331541_F698B162 
X-CRM114-Status: GOOD (  24.33  )
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

On Wed, Feb 20, 2019 at 4:13 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> On Tue, 19 Feb 2019 at 20:20, Vinod Koul <vkoul@kernel.org> wrote:
> > On 19-02-19, 17:49, Baolin Wang wrote:
> > > On Tue, 19 Feb 2019 at 17:30, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Tue, Feb 19, 2019 at 4:15 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > On Mon, 18 Feb 2019 at 20:23, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > On Mon, Feb 18, 2019 at 11:52 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > > > > > On Mon, 18 Feb 2019 at 18:31, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > I did understand the need for a slave-id, I was instead wondering about
> > > > > > the channel-id number. On many SoCs, all channels are equal, and you
> > > > > > just have to pick one of those with the right capabilities for a particular
> > > > > > slave.
> > > > >
> > > > > Yes, all channels are equal. We just set a unique slave id for the
> > > > > channel for a particular slave. For example, the SPI slave can use
> > > > > channel 10 for tx transfer by setting slave id 11, or it also can use
> > > > > channel 9 for tx transfer by setting same slave id 11.
> > > >
> > > > So the channel selection is software policy, not hardware description, and
> > > > thus doesn't belong in DT?
> > > >
> > > > Can't the DMA engine driver allocate channels dynamically, removing the
> > > > need to specify this in DT?
> > >
> > > In theory we can do as you suggested. But we still want to
> > > manage/assign the DMA channel resources manually for one SoC, we can
> > > make sure some important DMA slaves (such as audio)  can request a DMA
> > > channel at runtime firstly, another benefit is that it is easy to
> > > debug since we can easily know which channel is assigned for this
> > > slave.
> >
> > Are  you suggesting that you have more users than channels available?
>
> Until now we have not met this issue, but we can not make sure if this
> can happen in future. Moreover DMA channel resources are belonging to
> the DMA engine's hardware resources, I think it should be described in
> DT like many other drivers did.

As far as I can tell, most platforms do not describe the assignment
of resources in DT for dma engines, the numbers in there are meant to
describe whatever is fixed, and most platforms should do it that way.

The naming is sometimes a bit confusing, as a dma request line
assignment can be called a slave-id or a channel-id depending whose
documentation you read. The drivers/dma/virt-dma.c implementation
is used in some cases to represent request numbers as virtual
channels, so a dmaengine driver can allow one dma_request_chan()
per slave, and then assign the hardware channels dynamically
while doing a transfer, rather than having a fixed channel assignment
when we first ask for a channel.

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
