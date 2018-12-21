Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC372C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:48:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC79621928
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iqaKiEqU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="btkXoLL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC79621928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PNO6Ih7951Ger6COV7uoZTv62sL6g+a4Qc0XJ6PMjmg=; b=iqaKiEqUOWprpz
	NJ2ySIqxlqdTK13dEXXu/ajaRNj3TAyljplZOitz+Bn/EvlglCS/FuUUrZYn56Xj2LBgrx5bMp65B
	EKBzun3O1Qnmv3z9tPbZoyJZRvPjuLP1uNYh4lW81t5VJvKaGh9ozTMliPoAUuixI5A6MJ5dB2IYb
	SGQYv6tVuwiWn3xybJYLLKU8io+aJMSF0zEx3Yp7SYvlf2LUuUNeT15vsir4JuxqFp8s2WFIpIWVT
	xIQXnifdU9zEw9aoPRfTkCB17ohE0ZUy8CJl76P1sNuYRHIH7JfR3Kd9IRN1CO5LlNYCjFuo0TEw8
	gc9QuxdTf+Uv0Sy8FaIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaTaV-0004rD-EO; Fri, 21 Dec 2018 22:48:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaTaS-0004qK-RE
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 22:48:10 +0000
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9A0E821934
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 22:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545432477;
 bh=oRyKYDLBkCt8PohvGhKj7Ezcv2YNCnLOR+AO7rpNPHg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=btkXoLL614+KGQguZ9tGRiIzzCdv5LOYKHUu4SgVXHG+YnmZk9apf61aPMRv5SK53
 HuyTKFo4/XSl+8hf5fyXSmzeSIp1ecQksBGrX9nlwOycMqrP8hLJ5cjXFao7grDkb1
 3oyIjilc/NGhglzv6FXp/u4ugy9MZQhFU8uE1Nws=
Received: by mail-wr1-f45.google.com with SMTP id q18so6748743wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 14:47:57 -0800 (PST)
X-Gm-Message-State: AJcUukdnl6LPpNp72Q762oyiiD7sKvwHeDxaKyxIKkjoJsesIlqJyE0P
 Ff4yj9ygmmPf7FlIBQE2qlYZT2+rve2WZNgpM0BOcA==
X-Google-Smtp-Source: ALg8bN4C+prqO/IZ6AbgZGngaUmdOVbjWlIi5AQimgFalbCx4TTFDuRhKuC2nhGtv+MidDVEiLOD+wi+wavrXZ9T0uQ=
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr4463016wrm.218.1545432476043; 
 Fri, 21 Dec 2018 14:47:56 -0800 (PST)
MIME-Version: 1.0
References: <20181220102247.4911-1-a.hajda@samsung.com>
 <CGME20181220102259eucas1p2f748c68e01cd4e09a266da879722e218@eucas1p2.samsung.com>
 <20181220102247.4911-2-a.hajda@samsung.com> <20181220111403.GB10978@kroah.com>
 <b9f7cb75-62a0-20f6-0e5b-1553852d81b2@samsung.com>
In-Reply-To: <b9f7cb75-62a0-20f6-0e5b-1553852d81b2@samsung.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 21 Dec 2018 16:47:44 -0600
X-Gmail-Original-Message-ID: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
Message-ID: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] driver core: add probe_err log helper
To: Andrzej Hajda <a.hajda@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_144808_917947_BA9A6085 
X-CRM114-Status: GOOD (  28.61  )
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 20, 2018 at 5:38 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> On 20.12.2018 12:14, Greg Kroah-Hartman wrote:
> > On Thu, Dec 20, 2018 at 11:22:45AM +0100, Andrzej Hajda wrote:
> >> During probe every time driver gets resource it should usually check for error
> >> printk some message if it is not -EPROBE_DEFER and return the error. This
> >> pattern is simple but requires adding few lines after any resource acquisition
> >> code, as a result it is often omited or implemented only partially.
> >> probe_err helps to replace such code sequences with simple call, so code:
> >>      if (err != -EPROBE_DEFER)
> >>              dev_err(dev, ...);
> >>      return err;
> >> becomes:
> >>      return probe_err(dev, err, ...);
> > Can you show a driver being converted to use this to show if it really
> > will save a bunch of lines and make things simpler?  Usually you are
> > requesting lots of resources so you need to do more than just return,
> > you need to clean stuff up first.
>
>
> I have posted sample conversion patch (generated by cocci) in previous
> version of this patchset [1].
>
> I did not re-posted it again as it is quite big patch and it will not be
> applied without prior splitting it per subsystem.
>
> Regarding stuff cleaning: devm_* usually makes it unnecessary, but also
> even with necessary cleaning you can profit from probe_err, you just
> calls it without leaving probe - you have still handled correctly probe
> deferring.
>
> Here is sample usage (taken from beginning of the mentioned patch):
>
> ---
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 4b900fc659f7..52e891fe1586 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -581,11 +581,8 @@ int ahci_platform_init_host(struct platform_device *pdev,
>         int i, irq, n_ports, rc;
>
>         irq = platform_get_irq(pdev, 0);
> -       if (irq <= 0) {
> -               if (irq != -EPROBE_DEFER)
> -                       dev_err(dev, "no irq\n");
> -               return irq;
> -       }
> +       if (irq <= 0)
> +               return probe_err(dev, irq, "no irq\n");

Shouldn't platform_get_irq (or what it calls) print the error message
(like we do for kmalloc), rather than every driver? We could get rid
of lots of error strings that way. I guess there are cases where no
irq is not an error and we wouldn't want to always print an error. In
some cases like that, we have 2 versions of the function.

Not what you're addressing here exactly, but what I'd like to see is
the ability to print the exact locations generating errors in the
first place. That would require wrapping all the error code
assignments and returns (or at least the common sources). If we're
going to make tree wide changes, then that might be the better place
to put the effort. If we had that, then maybe we'd need a lot fewer
error messages in drivers. I did a prototype implementation and
coccinelle script a while back that I could dust off if there's
interest. It was helpful in finding the source of errors, but did have
some false positives printed.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
