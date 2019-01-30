Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9195CC4151A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:52:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD2221473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o/FwR9U6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD2221473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XaSnX0HSAzRi/jpmfZii1nszFfOpqBXHdlcf9hwrB7M=; b=o/FwR9U6p7GYjk
	o1KAUq98S9+XCZTlrwLgRbKzz+hFxEP29BMYBuFTgIPmH7jmh97lZKYs8VcrYpJpQEw7q1bmeXRgd
	F1Q7oyPL3pc80dMbKxryW+7wAGtJ2Xy7CJvGfMDpAb2RB2BsQA9YSZkCe4JrUNLdK+9Axz642QDfP
	PQCAx9yq5RgSUtLwPPB+4kttVwBlN7GtdnAhyzPyVp/Ww6wNm4IVTwBrXeyUbcqjjcZgGZcsvppCT
	U/uU2DXEzAth6EBZdGNfcNlschPuy6fmxXc7fwlQ9DqCsJZdrHF8TXu+Ccc3GC3rgfykn3DovjZvB
	kLwIIpzHtGEm4rnHNqbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1got5r-0003sh-6c; Wed, 30 Jan 2019 16:52:07 +0000
Received: from mail-qk1-f196.google.com ([209.85.222.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1got5n-0003rg-QU
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:52:05 +0000
Received: by mail-qk1-f196.google.com with SMTP id c21so127369qkl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 08:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Txd3GsWvhF9L3tb39fYpPffEJr9NibpUfMc5wNUUcHs=;
 b=c5isJ45dIA4DBMepUs7xjEZ82Wn6Xh+TyZxgRmb8HECa90RXe6YIgRYfZ4B8t5eRTq
 ZMFCHfhDO12ADC7u0RHub1k67ZCUSIjHCjGKudd/lCquRhQppYmIr0AtsaTN2+lCR1wB
 Mi3WVeAfG0mhzmxpxkKfRKCexk91Ydatqha9ehC4banmwLKLlVHXrxlhnqeVGjpuz5uV
 XkL2c9geOqj5fWaXWljsEzEZwEIaSRQdLvN6XjespDE6xexJanftdn3MiJZLtYliCxIz
 GZ3kDyaoll7niuhFl+wsJboaL5YHs2l4WT5cG1Jj8UqZtmAtfoluhmpAUz19kgd6eOoL
 XXQQ==
X-Gm-Message-State: AJcUukfKI3VQ2o2VSGcbl3sX1Q62uwWovTslUIUMmZVc+Nr+N95rJJ6r
 exArxnJ0yBYo/RcxDt5D7kc2tByzJyD1hf1B1XU=
X-Google-Smtp-Source: ALg8bN4Z9oDX+Knbk9so27sMmfvH84XqmZnR9QnaKYAn3naGHLmyoR8NJAAZJBn6qz9xFpp2Zh8ItPf50lBYabp+taw=
X-Received: by 2002:ae9:d8c2:: with SMTP id
 u185mr27031253qkf.107.1548867122620; 
 Wed, 30 Jan 2019 08:52:02 -0800 (PST)
MIME-Version: 1.0
References: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
In-Reply-To: <a9718ae1e97a5911f47874fe23c00ef297d7fed8.1548158832.git.baolin.wang@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 17:51:46 +0100
Message-ID: <CAK8P3a2zkhrZLMi5KZ5=fGJCt85dad3_pZC0o7GqcwJkk4es9w@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Add one new cell to present
 hardware slave id
To: Baolin Wang <baolin.wang@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_085203_859678_6388D646 
X-CRM114-Status: GOOD (  19.38  )
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

On Tue, Jan 22, 2019 at 2:21 PM Baolin Wang <baolin.wang@linaro.org> wrote:
>
> The DMA engine clients can trigger DMA engine automatically by setting
> the corresponding hardware slave id for the DMA engine. Thus add one
> cell to present the hardware slave id for DMA clients.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  Documentation/devicetree/bindings/dma/sprd-dma.txt |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/dma/sprd-dma.txt b/Documentation/devicetree/bindings/dma/sprd-dma.txt
> index 7a10fea..7812cf0 100644
> --- a/Documentation/devicetree/bindings/dma/sprd-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/sprd-dma.txt
> @@ -6,8 +6,8 @@ Required properties:
>  - compatible: Should be "sprd,sc9860-dma".
>  - reg: Should contain DMA registers location and length.
>  - interrupts: Should contain one interrupt shared by all channel.
> -- #dma-cells: must be <1>. Used to represent the number of integer
> -       cells in the dmas property of client device.
> +- #dma-cells: must be <2>. Used to represent the channel id and slave id
> +       of integer cells in the dmas property of client device.
>  - #dma-channels : Number of DMA channels supported. Should be 32.
>  - clock-names: Should contain the clock of the DMA controller.
>  - clocks: Should contain a clock specifier for each entry in clock-names.
> @@ -28,14 +28,16 @@ apdma: dma-controller@20100000 {
>
>  Client:
>  DMA clients connected to the Spreadtrum DMA controller must use the format
> -described in the dma.txt file, using a two-cell specifier for each channel.
> -The two cells in order are:
> +described in the dma.txt file, using a three-cell specifier for each channel.
> +The three cells in order are:
>  1. A phandle pointing to the DMA controller.
>  2. The channel id.
> +3. The hardware slave id which is used for clients to trigger DMA engine
> +automatically.

I notice that this is an incompatible binding change. Is that necessary?
If the current code works, I'd suggest allowing both #dma-cells=<2>
and <3>, and then implementing both in the driver.

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
