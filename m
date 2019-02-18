Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9F6C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:31:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B7B214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HR60R/Yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B7B214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iNVU8pnPz7xICYkziixdg3MmNgND6tYTRsnXVL7hUvU=; b=HR60R/YqQCsafI
	t8O5zUbZZ7OFYrSlaJIbddAtz1lepAY/zb9YlQguDR7/P07M8AZRbYkCzmRsEN0QizA0nV8AOcJ27
	hxtiQW/yu51yjABDMbUhp2jwks4Bk3ffEnOIa/ZZvq6NzSQAuvgGu2/gdicjMBj+WNu8ZH3gWrtBY
	1ZjtVmpppOCmB+aSFYacJubKbRF+7BXtDlSWMRuMLEI3JeThSkxYtgA4G5FACFPTS7bVCUvh8bobM
	exlb49yu6OME5wBN3RroVfYJF+2Xwhaf4ou3Yxajoge84ldtvALhyX5nox8jhFmONLHdEu5WzQS/C
	9geruGPOgkvuZwNChIrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvgDJ-00076s-Da; Mon, 18 Feb 2019 10:31:53 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvgDG-000750-7f
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 10:31:51 +0000
Received: by mail-qt1-f194.google.com with SMTP id b8so18540121qtr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 02:31:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JeAiCwTdj8ylL6sF0x2uByC9gBRqCOAVMEnpZGUkBbU=;
 b=tAO47uwiNB03uv8VYzlRzcqWihtWYw90QJEibZDhwX8jTgq0KZomAZO2g/DQp8yYI2
 t3G5mQusg+9lt/gtsmK1Ckz1B/2Y2Bs8F6Qwgn3ssfNCTKGHMVYLq3t5nnG7FKMMyCGh
 4s6O0/188wP6wCsozLpJfF1LvyUWMh+3+t4yhMDQSq6UoctJpy5Y0pTABs3DFBoexHIQ
 lVFW2itbhZKbz3pCicttdG16Nd3jKOcds+0lAJXMADa/u7M4jmpVuQHhtyuGvCtuLZmX
 VD+FYKUsBjYJsevbqogDsAg+5TiG1WhA36xsH3Kn+Bt5vuYd9I2iK5IOxr1A25K8WCge
 xyYA==
X-Gm-Message-State: AHQUAuZha/Bg9gEmA9MYjWSAc4A3mgPwg9+/9mNQCJqYli1ofgUPeMvC
 yJ62dmJ+lgTuWWoXv+K9EGNVq7KbYSpjqNZRgAc=
X-Google-Smtp-Source: AHgI3IZjx670/rKQSNrH8eBwkan7S+nY3zbrV1tknWzuZbWoqV5NUEmuqmCi/hYmoX8yMTiCvNurMGPgE2hy0HBWVrw=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr16997325qtm.96.1550485909026; 
 Mon, 18 Feb 2019 02:31:49 -0800 (PST)
MIME-Version: 1.0
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
 <CAK8P3a2zkhrZLMi5KZ5=fGJCt85dad3_pZC0o7GqcwJkk4es9w@mail.gmail.com>
 <CAMz4ku+PR4bHtcPu2uT2f974+FWJVi8Tp3WzmuqE1TS-M-QawQ@mail.gmail.com>
 <CAMz4kuLEut0LqZ4bSAGJDufE8xHr6DgZ3Z1RCLQ10q_k6MUesw@mail.gmail.com>
In-Reply-To: <CAMz4kuLEut0LqZ4bSAGJDufE8xHr6DgZ3Z1RCLQ10q_k6MUesw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 11:31:32 +0100
Message-ID: <CAK8P3a1Zq6XjymG3sAaHGeNRxU5UXPfJPbi0A9s47cTVK7vC3g@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Add one new cell to present
 hardware slave id
To: Baolin Wang <baolin.wang@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_023150_273602_54A34331 
X-CRM114-Status: GOOD (  22.58  )
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

On Tue, Feb 12, 2019 at 9:25 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> On Fri, 1 Feb 2019 at 19:53, Baolin Wang <baolin.wang@linaro.org> wrote:
> > On Thu, 31 Jan 2019 at 00:52, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Jan 22, 2019 at 2:21 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> > > >
> > > >  Client:
> > > >  DMA clients connected to the Spreadtrum DMA controller must use the format
> > > > -described in the dma.txt file, using a two-cell specifier for each channel.
> > > > -The two cells in order are:
> > > > +described in the dma.txt file, using a three-cell specifier for each channel.
> > > > +The three cells in order are:
> > > >  1. A phandle pointing to the DMA controller.
> > > >  2. The channel id.
> > > > +3. The hardware slave id which is used for clients to trigger DMA engine
> > > > +automatically.
> > >
> > > I notice that this is an incompatible binding change. Is that necessary?
> > > If the current code works, I'd suggest allowing both #dma-cells=<2>
> > > and <3>, and then implementing both in the driver.
> >
> > Yes, this is necessary.
> >
> > Yes, current code can work, but the problem is that the DMA clients
> > must add one property (something like "sprd,slave-id") to specify the
> > slave id. So considering this, we want to change the dma-cells to 2,
> > including dma channel and dma slave id, which can avoid introducing
> > some similar properties for DMA clients.
> >
> > Now there are no DMA clients in mainline for Spreadtrum platform, and
> > we want to upstream our first DMA clients: SPI controller. So no other
> > drivers need to change when we changing dma cells. Thanks.
>
> Do you have any other concerns about this patch set? If not, I think
> Vinod can apply this patch set. Thanks.

Sorry for the late reply. Yes, this makes sense since there are no
existing users then. For the DT changes going through the dmaengine
tree

Acked-by: Arnd Bergmann <arnd@arndb.de>

One more question, to make sure we don't need to edit it again:
Why do you need both a 'channel id' and a 'slave id' here? Is this
a strict hardware requirement for your DMA engine? In many
other designs, only a DMA request line number needs to
be described, and I think this would correspond to what you
call the 'hardware slave id' in your documentation.

Does each request line here correspond to a fixed channel
id as well, or can a channel be shared between multiple
slave devices?

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
