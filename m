Return-Path: <SRS0=kGow=PH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBB3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 10:43:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CDFF20866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 10:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PiSDN85P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy1v4zbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDFF20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9eABQrw6uPVsABerIwQ2mlu4quqeTYUH4K7jnyexrtA=; b=PiSDN85PRUTzwI
	OlsuXKfPVY6NvqoOR3wrTgJwZ5XISvZesvC0zRsvXzle6XVJmpYXtztzctb6n6/zIxgxShxPcGfg9
	dwidWamYWRZVNdxRaVjODzMQtMszOaVQQRsCsSNPtcTrATjhXx43Bz7WemeWC1mX9sJTPZxcXdMaR
	ADmuanLiqZ8czgySqUn6l+GHYA0d3PeV5BEaKM3yegZhF74wsiTFDG95Wbu7H4R4NXZbI0SZe/UA6
	2QI1RqwiHMI7TLg/4NWhUmaWV+wiqClVXWmtB+juq474Eoq3XgTQP0tH+fBigg+uhttDUFs0jENEg
	DeFu2oMNK9xdfU8RoG4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdYYl-0001hT-3x; Sun, 30 Dec 2018 10:43:07 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdYYh-0001gG-Ec
 for linux-arm-kernel@lists.infradead.org; Sun, 30 Dec 2018 10:43:04 +0000
Received: by mail-pf1-x444.google.com with SMTP id b7so12240698pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 30 Dec 2018 02:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0XgghK1nd2s2qo2RWUpMVObrnXaajFF0lB8CRb1jtwQ=;
 b=gy1v4zbXScgnaff6he+BmRb6STOERDK/cAPglgOxhXuNBOvl8kqC+X/Dm7XmRyxiTY
 O9VJJOT0UdKQs3hGQkLkZrgBixCafhvYWSumrValDFYqNkJhCTMLFkGJ8DhvT892CbG1
 0L+uLsDNhwaLuharBcklhagccgk37Qc8gmWyM68ugr7RNxDex6GvrEc/KkTuV3q9b59M
 w9ZKK9sS95N2IqA2Ew+jlnWOyhBiuApGOCPVaMJAEPp6xXpvo8wFOGpbKshNOmaEvVhW
 IFoTcPYe4J+5+cDuWJRtgLqNx880nHFAZnODtsWV46NDQJC/6DD6JeW8aEcxVqP+d9PH
 S1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0XgghK1nd2s2qo2RWUpMVObrnXaajFF0lB8CRb1jtwQ=;
 b=rYJrDBloSYWfrInmPn/k7Zh22SDJjm6BMV7QJHfjliaTrYZ1RNyc1aF0mOrajoMN+r
 bE94JTqsWAMq/HZI6ceAiM19QPwn0QqrTk8OcWm3XOC3OCm3XdGcBrlblFoBxis2xU2B
 NfZGWvTg1EfjWVNIsAytteBz3oCYrtIYEKpNq2bc86TzrmkxgWex0RiMwXqO2zXQu4jr
 tHEjYYO65iqwXQgqDKHEUfs6pqHSsad0RefPjsMKo5Ww5bySL3t+MufqZ7tpdoem2Hdz
 3nuSFlVaXG7e/7GeNnZUv5cLxnuUzKWRxvRdTih6jdwMV/jwr0WfoRkQP9eYT0SX9NGA
 1/fA==
X-Gm-Message-State: AJcUukfiws85RVoLUQ5aLs7T5aEpxqAeHOjVrjmNRAjnS3BFl3VdVOSj
 RJFW8bdHn098m6T0+XdSD/bUofLdPAH6DSR21tM=
X-Google-Smtp-Source: ALg8bN696aSK9qlYReLCuD7oSB0tO2TFFr/sQab2hDnuHaUv5jjc+ui1jJWM4BKbm6bbbNxQhD4LDJq3eqc7cuZWIOs=
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr4125571pgh.265.1546166571329; 
 Sun, 30 Dec 2018 02:42:51 -0800 (PST)
MIME-Version: 1.0
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
 <20181228215620.120672-1-swboyd@chromium.org>
In-Reply-To: <20181228215620.120672-1-swboyd@chromium.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 30 Dec 2018 12:42:39 +0200
Message-ID: <CAHp75Ve9YSPy14hwKOsjChZ6JhRYokLqm-RNs6xgu-RG-5QctA@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: platform: Add an error message to
 platform_get_irq*()
To: Stephen Boyd <swboyd@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181230_024303_495179_7F185838 
X-CRM114-Status: GOOD (  13.82  )
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

On Fri, Dec 28, 2018 at 11:56 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> A grep of the kernel shows that many drivers print an error message if
> they fail to get the irq they're looking for. Furthermore, those drivers
> all decide to print the device name, or not, and the irq they were
> requesting, or not, etc. Let's consolidate all these error messages into
> the API itself, allowing us to get rid of the error messages in each
> driver.

> +static int __platform_get_irq(struct platform_device *dev, unsigned int num, bool warn)
>  {

> +error:
> +       if (warn)
> +               dev_err(&dev->dev, "IRQ index %u not found\n", num);
> +
> +       return ret;
> +}
> +
> +/**
> + * platform_get_irq - get an IRQ for a device
> + * @dev: platform device
> + * @num: IRQ number index
> + */
> +int platform_get_irq(struct platform_device *dev, unsigned int num)
> +{
> +       return __platform_get_irq(dev, num, true);

Hmm... Why not just  do
int  ret = __plaform_get_irq();
if (ret)
 dev_err();
return ret;

instead of big refactoring of platform_get_irq()?

>  }



-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
