Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6D4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:31:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D278213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gpnjf02Z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rt+n9xiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D278213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yV4OEUANC8mMLz0/TtPJLNrfs0tTTBSiYxok6tPmK0c=; b=gpnjf02ZDOFztM
	S681Shi86nfEZIfAKkr9SJyubKVKoLw3HO2JS8OHOvDle1xGqSMgXGxcTX79PaZhUShz4XnI1Hcbn
	PgOuh03rmGjvwvWL4+nbnvn68mF+CjjeOF1lHfEc/t+ZuIOVk822zJf0ZTECk3wgo9E1dnOkBIbzK
	0DL4nOqujNqW75rOdZfZlL+1u7iv5ARcf+x6rJma+Yl5sNQ4xkrka1BK5BGjXvHDCN5FPw3IYPDqa
	pXH+v0K3jYfaUITI4Qs7bYj/kslOX4gMFMvObDlET1WtRutbmup3LpMY6l1Nw75s8wDmbiy3nQtLl
	0TiAjv1Hmxd7Nm/3GouA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyGMH-0007cF-UQ; Mon, 25 Feb 2019 13:31:49 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyGME-0007bL-3T
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 13:31:47 +0000
Received: by mail-ed1-x544.google.com with SMTP id m35so7527245ede.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 05:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=57oQ2o4V5orS4cTes6nGMZZBv36lxjCx8o3Sf9yfq78=;
 b=rt+n9xiGzBU1qD2mExYcd8nvdtdLLUwrBScMh6pnrtB4o2gAUnomVw2iXH0CoLTY/S
 LteGFI4FMGru0KnJp6sMB2q9EC6Y/fCZUpT8OA/k8gUwBNF212AMmH4GfcKn0EgegFua
 Eh+86LjP3fJNEyG3ZkP2SvmVypkEJa1yaGb2eKYQ0HPYHgeiwko6XZji4QmEOkkB866k
 g6S4JxL7c3nA050+SwShC+OWIKmrzv2jEePqUy0KmC4I8Ns0cYt11AtKMBP8Uqa1fRpt
 g6QF4FhYMAy07HBlG5Bbkh/JaWfojwVOWHFaGnu+qPMg3/oTpkHaoPaFZNS/Kkm1bDOq
 fBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=57oQ2o4V5orS4cTes6nGMZZBv36lxjCx8o3Sf9yfq78=;
 b=Mudxd93bjP4p5q50y0yLTATR+xXHQhsn3BztWCKjNFPGPfYf5Mhd1KoDMw566i7niT
 PwPHjn2MatO4xonL7ulEOuiHxvpZxUaMVnsRJjDIhy9GDQCnkl94KJPV9U0WtPh8I9Ts
 YeZv3scNN691vWQkgfjLV31E7lJ925nNr9VT/TSKQ11dmZf635hoktTZoiTjDjP/sd99
 RHWuuGeG0cC6usAhmcytpRfszPUkQf8RbTKZOAf97mS2+eYIdBUHWo0S4e4JLj7LSDok
 78wnYnGtv1nBXabHvOupK0sM4uCg9Vyf+3TbLwCu6O2YMGuzl0itnuZsGuFViPhia9uz
 clUg==
X-Gm-Message-State: AHQUAubzdidJ8jw6EuaRcbOapfef/6pBcatVTUk0p5XCGdtIXNlPBK1W
 B4zlsCe41dnQ1Nn1DMrmHqo7zG3Ky8GURwDUJ70=
X-Google-Smtp-Source: AHgI3IY7bXbCLZIso2EcuMRIPiXC7nAYQg5j9xgV2vgIIoW8jpq6j31e++PDwfdvKVUentvVl1dOs0Pvhg2wLpqEgmo=
X-Received: by 2002:a17:906:f1d8:: with SMTP id
 gx24mr13013720ejb.227.1551101503721; 
 Mon, 25 Feb 2019 05:31:43 -0800 (PST)
MIME-Version: 1.0
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190128160323.28170-1-angus@akkea.ca>
 <20190128160323.28170-3-angus@akkea.ca>
In-Reply-To: <20190128160323.28170-3-angus@akkea.ca>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 25 Feb 2019 15:31:32 +0200
Message-ID: <CAEnQRZCPuSgfSWctDrLAXANVAjoN=4AHfoecj=K=2dsWJoVUTw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] dmaengine: imx-sdma: add a test for imx8mq multi
 sdma devices
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_053146_169771_67BE3437 
X-CRM114-Status: GOOD (  18.93  )
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
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, angus.ainslie@puri.sm,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 28, 2019 at 6:04 PM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> On i.mx8mq, there are two sdma instances, and the common dma framework
> will get a channel dynamically from any available sdma instance whether
> it's the first sdma device or the second sdma device. Some IPs like
> SAI only work with sdma2 not sdma1. To make sure the sdma channel is from
> the correct sdma device, use the node pointer to match.
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Thanks Angus for the patch!

Tested-by: Daniel Baluta <daniel.baluta@nxp.com>


> ---
>  drivers/dma/imx-sdma.c                | 6 ++++++
>  include/linux/platform_data/dma-imx.h | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 757fad2fbfae..d2fae53be689 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1914,11 +1914,16 @@ static int sdma_init(struct sdma_engine *sdma)
>  static bool sdma_filter_fn(struct dma_chan *chan, void *fn_param)
>  {
>         struct sdma_channel *sdmac = to_sdma_chan(chan);
> +       struct sdma_engine *sdma = sdmac->sdma;
>         struct imx_dma_data *data = fn_param;
>
>         if (!imx_dma_is_general_purpose(chan))
>                 return false;
>
> +       /* return false if it's not the right device */
> +       if (sdma->dev->of_node != data->of_node)
> +               return false;
> +
>         sdmac->data = *data;
>         chan->private = &sdmac->data;
>
> @@ -1946,6 +1951,7 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
>          * be set to sdmac->event_id1.
>          */
>         data.dma_request2 = 0;
> +       data.of_node = ofdma->of_node;
>
>         return dma_request_channel(mask, sdma_filter_fn, &data);
>  }
> diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
> index 7d964e787299..9daea8d42a10 100644
> --- a/include/linux/platform_data/dma-imx.h
> +++ b/include/linux/platform_data/dma-imx.h
> @@ -55,6 +55,7 @@ struct imx_dma_data {
>         int dma_request2; /* secondary DMA request line */
>         enum sdma_peripheral_type peripheral_type;
>         int priority;
> +       struct device_node *of_node;
>  };
>
>  static inline int imx_dma_is_ipu(struct dma_chan *chan)
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
