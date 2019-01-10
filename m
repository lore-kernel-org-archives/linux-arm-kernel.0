Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67602C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:56:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC2E206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KbPhwOfB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SyFN34cb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC2E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/Sy2140HrBpdkFcT5Ami67xfIi5pMcvGbNTJZS9Wmiw=; b=KbPhwOfB04FPEw
	s5kgQ4EpwwlGxove3r0/t8bHMB+z+D+9kC9YF3OCoWBsYdW393i5T2yOmerwYdHhxo92GfhbwY9d5
	R1fqWWZFRl0rbFQg+NksC23bZF5WhE6zWbkBXhUDuMxzXVPMYqPhknzSAQMzxySbCU0BpGcLTWm29
	WxaUfMb0q5KW0KO4Abd0EpFwBgk91eDGvTVn+Mb45fAUtLzVvq20+zRLDj4klZwauyeyGEIBkIYQ2
	o1Y9cJUeygxf3iQUFAnMKdNlUmcZmKwznVfb6GYbIDyLx6sdCOAKTC1dnJ38FKuHcBSHo9k56+wdw
	Ey/3MS0FLkYumcMxU0ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghfVL-0008MZ-VC; Thu, 10 Jan 2019 18:56:35 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghfVI-0008M0-EZ
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 18:56:34 +0000
Received: by mail-io1-xd41.google.com with SMTP id b16so9832086ior.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 10:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7BgF4kh9Xmlpw50K9SbfmwVdmpzqbAle3GfrvnRfGmk=;
 b=SyFN34cb6X7nCgBYzsAzXOb9UUWhX+NfdDJaApUeY6oM0bWGvd2oAhEfM9LwF34glr
 +4GvkzgsPgfa2jenE6CcTmKmCeASazCXEvWf8L9Hj8JRtISD6JrrM0WNb2B7+hROCg/D
 yQEX7hQmhZkDylS2lChIBGRE2u+M+Q3+58T8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7BgF4kh9Xmlpw50K9SbfmwVdmpzqbAle3GfrvnRfGmk=;
 b=eRNgIniuyJV7Cfuzpb+Hu39JsbvlL1AQZ5HWDI+GRAe7Nj6Tu+f/IJWyuJGIKNLFpg
 avlmeqdYCV/hWSJsrZdHNvstiYyO9LaH0FcMWJLKrMaH/jSoxAUbXmNAygTnwVDVh59Y
 zeJd/zEpu6NC6BHFrFLziAcRoEhXZ2Cz3wbkGJiDJJ8nwrHuTTwb3AdVeb1spGhR3me0
 WAIK/BGvvRrCcTa/EkJ/NfiFAiAcb5rSAcezHorO6bDAM4DTdo8ACh/t1yoWwSnxjBX4
 DLXu97uhrZ/sYyoKTCLaFXE4LZFgW5BSo/YNTiPVHgK+O1RiUau/2xFeK2t4cJhsbUyI
 64PQ==
X-Gm-Message-State: AJcUukfa704vy5b4ZaIZOr9Vge5Y+9EMJT+WKY3WIS664hjewlfzudMw
 Bhxqh9Xsk3ykRAgDBD8vVPk5HhhaMZPmjpK4WN5NvQ==
X-Google-Smtp-Source: ALg8bN6EBRB2D+ruHx7MaylPDpx+z+ZfTSkB8UjltZZWghyOWFgN0Ivly2UPnBQY0eqcH3TV+og4p1w1Gb6VGwE8/a8=
X-Received: by 2002:a6b:6b02:: with SMTP id g2mr7195717ioc.18.1547146590880;
 Thu, 10 Jan 2019 10:56:30 -0800 (PST)
MIME-Version: 1.0
References: <20190110095125.GA4491@lenoch>
In-Reply-To: <20190110095125.GA4491@lenoch>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 10 Jan 2019 19:56:19 +0100
Message-ID: <CAKfTPtCV=PYAqG=LavafTpMxvXdr7W-bfsOkpP+04EtOaicjyg@mail.gmail.com>
Subject: Re: [PATCH] PM/runtime: Do not needlessly call ktime_get
To: Ladislav Michl <ladis@linux-mips.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_105632_490463_7AB28201 
X-CRM114-Status: GOOD (  16.97  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linux PM <linux-pm@vger.kernel.org>,
 Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 10 Jan 2019 at 10:51, Ladislav Michl <ladis@linux-mips.org> wrote:
>
> pm_runtime_autosuspend_expiration calls ktime_get even when
> its returned value may be unused. Therefore get current time
> later and remove gotos while there.
>
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  NOTE: Depends on Vincent's "[PATCH v2] PM/runtime: Fix autosuspend_delay
>        on 32bits arch"!
>
>  drivers/base/power/runtime.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 457be03b744d..836b1b8784eb 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -129,24 +129,21 @@ static void pm_runtime_cancel_pending(struct device *dev)
>  u64 pm_runtime_autosuspend_expiration(struct device *dev)
>  {
>         int autosuspend_delay;
> -       u64 last_busy, expires = 0;
> -       u64 now = ktime_to_ns(ktime_get());
> +       u64 expires;
>
>         if (!dev->power.use_autosuspend)
> -               goto out;
> +               return 0;
>
>         autosuspend_delay = READ_ONCE(dev->power.autosuspend_delay);
>         if (autosuspend_delay < 0)
> -               goto out;
> -
> -       last_busy = READ_ONCE(dev->power.last_busy);
> +               return 0;
>
> -       expires = last_busy + (u64)autosuspend_delay * NSEC_PER_MSEC;
> -       if (expires <= now)
> -               expires = 0;    /* Already expired. */
> +       expires  = READ_ONCE(dev->power.last_busy);
> +       expires += (u64)autosuspend_delay * NSEC_PER_MSEC;
> +       if (expires > ktime_to_ns(ktime_get()))
> +               return expires; /* Expires in the future */
>
> - out:
> -       return expires;
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_autosuspend_expiration);
>
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
