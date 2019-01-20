Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300F8C61CE4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 09:59:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 012952084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 09:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M3FdNQ3w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFql+9qp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012952084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dQDp3DzblIOb/d2JYGak3gpf7+J4tyGtqVvw3xRuQu4=; b=M3FdNQ3wdXtkev
	b+Hd+sP6MxHJINj9H9x/yXjZfYtu+WxHQk2xJaXh4pO4T83FWRjm+rdmHW82Srmxy21ELEWvlW8a8
	ztqpygy+D68yKJhy0NEG91PDHtltzcgvmNwfMfYTZlVwcZUStZRT7dZrUin1PfwOAYOKoOnsKfNQ+
	stLNr8R3sn18+KUJZHk1LKHnc0pv7K20qD6bHly9PAgU9cuIxCp6CN+EfqQHyZiaaIGsa0txQhYX/
	70+3qLlFnjNd7RBhJ9Yt8oeiHG5ifl90NvI05xLud0kYuqycSox9Cu5IOOS8E3vn+vBJmiy4/a8bF
	/SHdHlIzPpDHzBVEZwFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gl9sX-00058C-Vp; Sun, 20 Jan 2019 09:58:57 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gl9sU-00057l-8y
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 09:58:55 +0000
Received: by mail-ed1-x543.google.com with SMTP id y56so14325848edd.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 01:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NVKj1nMfR7j7/ER9sbODVHGhgpdJAj3BE1AU8ok7UWk=;
 b=oFql+9qplfj7TakBWabCSYfXBQ+otJlOVcJ7VHsrN6VUZNywoL6ocwCNRBgLKCk1m6
 gaaO8TUEJZD5DdD77veodrt48ah3M1g0ko2vuJUC0gKvx2P4Ms4XCr/JgVvUOiavFj7Z
 gJq4+YMRCumK12dW9nMQgFe4ahxe696wtFM1SeZcPeu5MgncfF8M8syz5i8tK3GDP170
 bL7dkDCcWpmWAx1yqZ0FWeXP1+qhPWywA5wYKuk5MLkClsSF3DSCsAfSQjKz/vKzaBIR
 b9q7ndEvTrDfkmg5c0EU23JUzHhb7OdyycRt8aNiQDmDmZmuR20xIwlQPt8YCi3imxnj
 r8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NVKj1nMfR7j7/ER9sbODVHGhgpdJAj3BE1AU8ok7UWk=;
 b=cbOVeD58DMscsVIiWcwWBnpHtBIRcnVvpbPZe+gzqvk/lygoefIC5Ezq+2lOFqQ1pa
 UgUgAS6zSO7qJ8U5EImnGWUftYbZmKV80TuR36WoXtvAaHKZMTmRUX3M9ZLcpQyi1du/
 8gMg7GPcY5ytmU8OsJbx/1ZvvaheW7CvhHi0JwzgO94LLtM5GtTvp64iZGN9xchFDoTO
 nkrc0eW7B4+Rb5o6R+ZkkHZuwjoJeqP3clLlpLpE01cjuzPbZ9B2Ynn0VwOKG9aGK0KR
 L/ptH3bZs/DpzU96mrO0aid7B/EpXDsmU0s2xiUdwVsrwXHCNVeFviBhTX9VItfrvP8m
 WOcw==
X-Gm-Message-State: AJcUukfnAcZPq/Omd5XkWNrmxY1sOBRmL/NtIHW8lRjMwchwUU/urZst
 UlRUSGhIB9CUTy3IWdBljlFPuRBwnZw8WzOFosM=
X-Google-Smtp-Source: ALg8bN5UApHLmg96dAlZzW0RNAhQnfCA2dLBZ/j7mELlZEERmbJF5icxPUKEU1fHAV8PJW+0TPGZSr7d0nNbk3fUph4=
X-Received: by 2002:a50:b356:: with SMTP id r22mr22806949edd.164.1547978332774; 
 Sun, 20 Jan 2019 01:58:52 -0800 (PST)
MIME-Version: 1.0
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190120023150.17138-3-angus@akkea.ca>
In-Reply-To: <20190120023150.17138-3-angus@akkea.ca>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Sun, 20 Jan 2019 11:58:41 +0200
Message-ID: <CAEnQRZBLLKotGy2t-f3rURnoUCjkxfuwrtYkirv6+kdAzidaFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dma: imx-sdma: add clock ratio 1:1 check
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_015854_334322_34423381 
X-CRM114-Status: GOOD (  20.15  )
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, dmaengine@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Jan 20, 2019 at 4:32 AM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> On i.mx8 mscale B0 chip, AHB/SDMA clock ratio 2:1 can't be supportted,
> since SDMA clock ratio has to be increased to 250Mhz, AHB can't reach
> to 500Mhz, so use 1:1 instead.
>
> based on NXP commit MLK-16841-1

Hi Angus,

Thanks for doing this!

I'm not sure specifying the MLK here helps. I think it would be better
to somehow add the original Signed-off-by and mention that the commit
was pulled from NXP linux-imx tree.
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt  |  1 +
>  drivers/dma/imx-sdma.c                        | 20 +++++++++++++++----
>  2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> index 3c9a57a8443b..17544c1820b7 100644
> --- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> +++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> @@ -67,6 +67,7 @@ Optional properties:
>      reg is the GPR register offset.
>      shift is the bit position inside the GPR register.
>      val is the value of the bit (0 or 1).
> +- fsl,ratio-1-1: AHB/SDMA core clock ration 1:1, 2:1 without this.
>
>  Examples:
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 0b3a67ff8e82..65dada21d3c1 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -440,6 +440,8 @@ struct sdma_engine {
>         unsigned int                    irq;
>         dma_addr_t                      bd0_phys;
>         struct sdma_buffer_descriptor   *bd0;
> +       /* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
> +       bool                            clk_ratio;
>  };
>
>  static int sdma_config_write(struct dma_chan *chan,
> @@ -662,8 +664,14 @@ static int sdma_run_channel0(struct sdma_engine *sdma)
>                 dev_err(sdma->dev, "Timeout waiting for CH0 ready\n");
>
>         /* Set bits of CONFIG register with dynamic context switching */
> -       if (readl(sdma->regs + SDMA_H_CONFIG) == 0)
> -               writel_relaxed(SDMA_H_CONFIG_CSM, sdma->regs + SDMA_H_CONFIG);
> +       if (readl(sdma->regs + SDMA_H_CONFIG) == 0) {
> +               if (sdma->clk_ratio)
> +                       reg = SDMA_H_CONFIG_CSM | SDMA_H_CONFIG_ACR;
> +               else
> +                       reg = SDMA_H_CONFIG_CSM;
> +
> +               writel_relaxed(reg, sdma->regs + SDMA_H_CONFIG);
> +       }
>
>         return ret;
>  }
> @@ -1880,8 +1888,10 @@ static int sdma_init(struct sdma_engine *sdma)
>         writel_relaxed(0x4050, sdma->regs + SDMA_CHN0ADDR);
>
>         /* Set bits of CONFIG register but with static context switching */
> -       /* FIXME: Check whether to set ACR bit depending on clock ratios */
> -       writel_relaxed(0, sdma->regs + SDMA_H_CONFIG);
> +       if (sdma->clk_ratio)
> +               writel_relaxed(SDMA_H_CONFIG_ACR, sdma->regs + SDMA_H_CONFIG);
> +       else
> +               writel_relaxed(0, sdma->regs + SDMA_H_CONFIG);
>
>         writel_relaxed(ccb_phys, sdma->regs + SDMA_H_C0PTR);
>
> @@ -1975,6 +1985,8 @@ static int sdma_probe(struct platform_device *pdev)
>         if (!sdma)
>                 return -ENOMEM;
>
> +       sdma->clk_ratio = of_property_read_bool(np, "fsl,ratio-1-1");
> +
>         spin_lock_init(&sdma->channel_0_lock);
>
>         sdma->dev = &pdev->dev;
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
