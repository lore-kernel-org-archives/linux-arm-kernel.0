Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5771C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:40:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64E221019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mb8sFBx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64E221019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yS0tHif66OPk73HJvd/NXzvmKR0s+kk3nRcPcyHqh8k=; b=Mb8sFBx/b/O/Zh
	J7vw72ISciUsdUD23dni+EUTdAHQifTWta5vRAls/0WTlW5OYT5uOT3/7WAXBZR1MZZ1+hiEdudIw
	rgPGEHexRx0xKgtdwNIZlxZIND6SWjI8JnHwA0eKTpegTJCfQpeaKTaH8WTtNg5rsRG0EyeMftxxG
	UvnOvyhWa+UoCdQNkjZtkH322cK3ZgplGdpf9BblR5cB80m4g7pfXwXTLRNVmS0HOEhT4uAlmScbG
	bGXUC8Sw0KyKykDDOP/tpheX/mhTPVSLO7IPY5w5QuF++WNvNv05eteQ2IQssMDLihNVeZNsqGrM6
	IE/7+3Kcxz4XvlAoNQSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gezUY-0000V2-9U; Thu, 03 Jan 2019 09:40:42 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gezUU-0000UB-JU
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 09:40:40 +0000
Received: by mail-ot1-f65.google.com with SMTP id 81so28915295otj.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 01:40:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LNsMCQvi3YESu2jFZko6wer3qJnV5q2cyJUAqddcti8=;
 b=Mah4uep5gvrHQGepoFh8lC7jReO1lSORtlE5IE4nVxvLsN/JZX7SKWN9gsJ+lXbe4B
 WfypllPRCehPlZNv0Tlv4Mx2Wx+r5R81Sfjmaz7RGucajF3WElPkk/YB5lkja0vaWRwg
 dYCvDkBiun3lo0xufSAYwpxiLLXrwtDtfJDOl6XebXvu4L0k6HyyOo9YPNpglLqAurbT
 VWd1xabGIK6bjB4LBWHDp2Gg/RDP5lA9twb2Z7seVMSPQvwE21n7uxQdJTLgUAFP4MeC
 rQry6TSdUNFo3VCdP7HmalDvtTovTl4IzzL8ZJk+UXwX0UZlGEFkrDc23iufDq7YHZTl
 LprQ==
X-Gm-Message-State: AJcUukeVnG6xwhzseZFYU3dMj1cxndM9gPU1l1LB3eZmGN9roLGS/CMp
 mY08mqWOLjKEkMv5qrlbxG1HKypA9e2ow0W9/U0=
X-Google-Smtp-Source: ALg8bN5bNQVyXhI+pGRbcezUF6FdCyaOh0kU5aOHChNz9GMRIj1A6Qmo5giOMg5RXpXBxuSuOs8CSdB/o2l/od2QHAs=
X-Received: by 2002:a9d:7f0d:: with SMTP id j13mr30890239otq.119.1546508437044; 
 Thu, 03 Jan 2019 01:40:37 -0800 (PST)
MIME-Version: 1.0
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
 <20190102185106.56913-1-swboyd@chromium.org>
In-Reply-To: <20190102185106.56913-1-swboyd@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jan 2019 10:40:26 +0100
Message-ID: <CAJZ5v0iL_Fq0RUbLjMj9WBitDw2amNV_ybirkiPbuYb0zroGAg@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: platform: Add an error message to
 platform_get_irq*()
To: Stephen Boyd <swboyd@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_014038_649843_5F716B24 
X-CRM114-Status: GOOD (  21.47  )
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
Cc: Rob Herring <robh@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, javierm@redhat.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrzej Hajda <a.hajda@samsung.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 2, 2019 at 7:51 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> A grep of the kernel shows that many drivers print an error message if
> they fail to get the irq they're looking for. Furthermore, those drivers
> all decide to print the device name, or not, and the irq they were
> requesting, or not, etc. Let's consolidate all these error messages into
> the API itself, allowing us to get rid of the error messages in each
> driver.
>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v2:
>  * Don't refactor platform_get_irq(), just wrap it
>
> Changes from v1:
>  * Update error text to indicate irq index instead of IRQn, use %u
>
>  drivers/base/platform.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 1c958eb33ef4..388461306dd4 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -79,12 +79,7 @@ struct resource *platform_get_resource(struct platform_device *dev,
>  }
>  EXPORT_SYMBOL_GPL(platform_get_resource);
>
> -/**
> - * platform_get_irq - get an IRQ for a device
> - * @dev: platform device
> - * @num: IRQ number index
> - */
> -int platform_get_irq(struct platform_device *dev, unsigned int num)
> +static int __platform_get_irq(struct platform_device *dev, unsigned int num)
>  {
>  #ifdef CONFIG_SPARC
>         /* sparc does not have irqs represented as IORESOURCE_IRQ resources */
> @@ -130,6 +125,22 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
>         return r ? r->start : -ENXIO;
>  #endif
>  }
> +
> +/**
> + * platform_get_irq - get an IRQ for a device
> + * @dev: platform device
> + * @num: IRQ number index
> + */
> +int platform_get_irq(struct platform_device *dev, unsigned int num)
> +{
> +       int ret;
> +
> +       ret = __platform_get_irq(dev, num);
> +       if (ret < 0 && ret != -EPROBE_DEFER)
> +               dev_err(&dev->dev, "IRQ index %u not found\n", num);

Why don't you log the error code too?

> +
> +       return ret;
> +}
>  EXPORT_SYMBOL_GPL(platform_get_irq);
>
>  /**
> @@ -142,7 +153,7 @@ int platform_irq_count(struct platform_device *dev)
>  {
>         int ret, nr = 0;
>
> -       while ((ret = platform_get_irq(dev, nr)) >= 0)
> +       while ((ret = __platform_get_irq(dev, nr)) >= 0)
>                 nr++;
>
>         if (ret == -EPROBE_DEFER)
> @@ -195,7 +206,11 @@ int platform_get_irq_byname(struct platform_device *dev, const char *name)
>         }
>
>         r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
> -       return r ? r->start : -ENXIO;
> +       if (r)
> +               return r->start;
> +
> +       dev_err(&dev->dev, "IRQ %s not found\n", name);
> +       return -ENXIO;
>  }
>  EXPORT_SYMBOL_GPL(platform_get_irq_byname);
>
> --
> Sent by a computer through tubes
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
