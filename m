Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E935CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:45:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD1020659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nVsIQFFN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WqppQ9oc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD1020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KeuWPDkRQaAehCWSSf8WVZ+/I+SEvoGeze4Y1gqM4Tk=; b=nVsIQFFNs2nUA1
	iKhb6pTaunuRnEgeKuTzH5HeCQXvxnOcf5cd63R0B8kmIO93iSGrMdav9cpGd9/2LH/EMKtVcQUiO
	REriYEjK7+lRKXrky0aKiFNwrkk2aFL0Dl5XXeanQwY552/AE+K8uvhwhzc7cLij1fsjreXxgYw6Z
	xsaxpzkCyJ8nsfEFaKo/fEcgzo0+RWT3duuQaJoEVRDZbVd0AkaRfCL7dbKMXWlyz1qAeLea/T1mp
	z6v+oBQ/OO+cBRVPRZoUHF6XUbqRiw7ql7BgvSv4aOfg0bTd5IHHxG8D0OGhQq+KXsJW+dc9+fkxH
	iedb1Z5R86zDDmCPADug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj0g3-0003L3-GJ; Mon, 14 Jan 2019 11:45:11 +0000
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj0fj-0002Yw-HC
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 11:45:06 +0000
Received: by mail-vs1-xe42.google.com with SMTP id y27so13454570vsi.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 03:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M/GPN+W9Qm4l4qSG23KM57QgLaYUka4/vuAsghNSZKo=;
 b=WqppQ9oc9PRCbFjudLIsWw52Z9zZuUMg2NE6HKMpZlp35adFYLGJH3qRhIT9GMvbu8
 VxTdX3aSr3Wd8cO3AObh25lezopyvizEiwO3OM0kcr+Mt3EKBFyoDW46LQZ9NeKgjAgL
 /CXyB52bstBXMbKVN/PZFKklqdp5KJDxVLpX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M/GPN+W9Qm4l4qSG23KM57QgLaYUka4/vuAsghNSZKo=;
 b=Ti6Uc4UvRq2iYDIj8UT48vRrFIl15dc9BFQXsK49c7wdF9tbiXgPsYjL+YmQh1yvEJ
 /dtunPDrKBxJ06scOoNqIZyJjSjaTk4A1Df0Fz2BxvghvaE/TN3TJdu5sC+8xiIeEc9n
 EpO7zQ0boI/DNf95fbvIByJ7F3mo96BQiBlDe6OinarymDT2KtvmlgzI5zxdWiaWXcKq
 ihAUvR8xqR8Qz+N/S4AFTADbXl8hEp7rtsFC6GtQl1HPu72u3xhvJluOqrnQUalYU+PD
 HjgDeTQhPCM+qQ3EBgWDQrZSZBJaeUs4aXA3B8dLn8ysiVtQQAoUFEhXhRG72MkEgz9E
 jj/A==
X-Gm-Message-State: AJcUukdsCJ2aFUHCqbeRay4+U0ipPDLcoTw4rvP1UCqzC9noVtlN839p
 6ZqbffhGcs0Td6hYdGQwJjeKA5U2Wb6q7GUK9DW/3p4GLWk=
X-Google-Smtp-Source: ALg8bN4eNqx2LADCv6Dw5FDN+8PUvTOGH0Tw5MpFdGuSZed684aWORE2jHaV4TRPRDK8n58R+v9Hhzn5sScRScXOMXU=
X-Received: by 2002:a67:74c2:: with SMTP id p185mr3841665vsc.34.1547466290098; 
 Mon, 14 Jan 2019 03:44:50 -0800 (PST)
MIME-Version: 1.0
References: <1545598758-4502-1-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1545598758-4502-1-git-send-email-stefan.wahren@i2se.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 14 Jan 2019 12:44:14 +0100
Message-ID: <CAPDyKFpTW07CsemS1=0kTEc88-ZXb6+HUVaviGb+8eWBOyRjvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-iproc: handle mmc_of_parse() errors during
 probe
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_034451_989854_3AF921C8 
X-CRM114-Status: GOOD (  17.99  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Al Cooper <alcooperx@gmail.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, "# 4.0+" <stable@vger.kernel.org>,
 Eric Anholt <eric@anholt.net>,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 23 Dec 2018 at 22:00, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> We need to handle mmc_of_parse() errors during probe.
>
> This finally fixes the wifi regression on Raspberry Pi 3 series.
> In error case the wifi chip was permanently in reset because of
> the power sequence depending on the deferred probe of the GPIO expander.
>
> Fixes: b580c52d58d9 ("mmc: sdhci-iproc: add IPROC SDHCI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-iproc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 0db9905..9d12c06 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -296,7 +296,10 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>
>         iproc_host->data = iproc_data;
>
> -       mmc_of_parse(host->mmc);
> +       ret = mmc_of_parse(host->mmc);
> +       if (ret)
> +               goto err;
> +
>         sdhci_get_property(pdev);
>
>         host->mmc->caps |= iproc_host->data->mmc_caps;
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
