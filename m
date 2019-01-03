Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977C4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:52:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD1C204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sC/wtnuR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cjzrpj/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD1C204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rXO8s80z3Tf79HDA32ee2nWsv/86GYB8owtJho9M5wk=; b=sC/wtnuRim98SD
	+5suDvfqKoVVZAOXcP0ff2IC6qSW2RRGRASKmEQEVnEehbezZcXDs9dKXng4U3TDxaXuN72wjEISo
	G0kU9sZc0aVWPeMJM2RStyiCojODwILWll7cie1n3WcFFRvJBid8skR4lAuAqGb+Wf8X8zBn+f5nU
	eCYMEvqWSiPKxaL59JfbpmgxZLwLJua/Ae9QnMUxGGsi4FWhLDAw9AvUj2iyOcv9Tm9URyeRGIyhS
	FasqN64pDsguJwtbHaO4gE4esDP343+b3U0TA8CYoDxLbKAn+VSaF2PM3hYeh/zo6kv7KBP0cfw1A
	eELMi/KYC9/lwZt8BTmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf7AA-0004xK-IO; Thu, 03 Jan 2019 17:52:10 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf7A6-0004wf-8z
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 17:52:07 +0000
Received: by mail-pf1-x444.google.com with SMTP id q1so17001290pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 09:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yDz7QBjISpr2/aHFIwizHIIDXcaqwxB6hC8+SZOWP/0=;
 b=Cjzrpj/SYRCh77oTd6unz6v1o1fRXQfyDrIOTXXGHsRmNKEDp/hUYK8KVi1Xq9FC39
 PIfEDvMIJAxFdvKxHuGifLOTwmKCoKkGpeuW+NGac5CXAZSwxvZM80PB1aU0N0YlAafI
 1YU/HZVAy60g4jA/JEaJVh5vxXcLjEPfUVnjdPm7rINY1F5uvVookWMW+DcyWjEjKZj9
 NRjttIeig7ENxJwrYjN0Ge3qlMoZ/WRW5cPCIxRmhQZ22YfjHvErrSb2UpxmcVFenJfj
 OnbMdh8AcotpfI4NwHK88hA16PXY08AN88x8nhBtx9iefwc3Ll5YU5+ElGQ3qzudL65C
 bx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yDz7QBjISpr2/aHFIwizHIIDXcaqwxB6hC8+SZOWP/0=;
 b=U8KAZuhma7nKbN+xP+oxvjtzNpg6oyLWhEzrNgRzNEm8+IW7OwAG+yErblBnbJSgc/
 NkoCS0PaW3DUT9T+DgKPHnE0dP+0B8bSxUPPs8Gkw3mmZMA/ic24nUmuPGi5GpCCV8Vw
 dQbBYIZnaGMrzuuUs2KArlBnZ8PJtjqIejAxh5GziogrhAC8hk30LbcaektqgT38B4Ts
 CqSnEbuO84MeliEOoGYhKrHB8kxOZzq4F920PeRLEQqY9w7HKumEz0nNBdQ77HIAjDQ5
 adsS1effFV6E7jyvzSrdwpfsVSkH8VKWRIz/iQ1wXraSPVbFabRusznPj1zOdUBCvia1
 uT6A==
X-Gm-Message-State: AJcUukdPY0RJScBYmahDs1B8WPmkhVHMZWXzD21RT21NQRYq+Gye5eNl
 9qGSfSt/SOLgGBBvZ0CEf5aomkizTMzUb2575Z4=
X-Google-Smtp-Source: ALg8bN417ey2bSZMnQ9ofltp8fY8ruvdXELY6WXzIGlzq45Sx9FiS/M15kB2PoE+rOp5PU5bAj79EfG9rb2eOgP6ON0=
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr17680040pgh.265.1546537925039; 
 Thu, 03 Jan 2019 09:52:05 -0800 (PST)
MIME-Version: 1.0
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
 <20190102185106.56913-1-swboyd@chromium.org>
In-Reply-To: <20190102185106.56913-1-swboyd@chromium.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 3 Jan 2019 19:51:53 +0200
Message-ID: <CAHp75VcRD__AhOM0sZjuNwsPGe-1_Cnreo+CSWgPrykFg_we1w@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: platform: Add an error message to
 platform_get_irq*()
To: Stephen Boyd <swboyd@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_095206_378529_1CC43193 
X-CRM114-Status: GOOD (  20.90  )
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
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrzej Hajda <a.hajda@samsung.com>, Mark Brown <broonie@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 2, 2019 at 8:51 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> A grep of the kernel shows that many drivers print an error message if
> they fail to get the irq they're looking for. Furthermore, those drivers
> all decide to print the device name, or not, and the irq they were
> requesting, or not, etc. Let's consolidate all these error messages into
> the API itself, allowing us to get rid of the error messages in each
> driver.
>

Thanks,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

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


-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
