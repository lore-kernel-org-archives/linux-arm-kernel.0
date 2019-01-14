Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1D8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:45:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868B920659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L+7ialcK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iX5plELL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868B920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f8x0FO6+tVFMDs/K7vvsGNfTl2uyCLxwi19GLoSbY9U=; b=L+7ialcKhLE+Fx
	WP4uJlESyYME/B+F63jVJdN70/WpUUPxuNiCu4rvjTJmjvrzQ7kbNDIm9unDuFmjCQ7cnD8oPCtAp
	teggvB9vpW6CzgQRXVn63lSdAJu2JpT3TNX17wTbw7XnuutklQGuc7P1zOiKzE7buGFKcOUXbw225
	awP9WsWCrE3bxpMrons33Vli2vF4Lxgfjl2HgbCk4C1SiBpYE+ABL92g3B4iBZshwWsnLcQHu+fSl
	GVGGavicVrL07Z4QQuFdNdJ6i+qhYu9+Q5PYVaoyavC+Y4VaOglJ8NpGV0sE8QgKf+YzDocEnd1CE
	BoOLGZA6h3XCu0Ep1LfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj0gQ-0004sb-Bi; Mon, 14 Jan 2019 11:45:34 +0000
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj0fq-0002jQ-TY
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 11:45:16 +0000
Received: by mail-ua1-x941.google.com with SMTP id t8so6965284uap.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 03:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=50Wbm4gczF2A7a6FcceYj6mrH1bTkWbRyvluupXYCjg=;
 b=iX5plELLPNga1iduPiOMLGm49vT/bGL1H9ru9WnFAccpTUPEUYtEwIfKSy8pg6YuOZ
 8sXp3/WywDy8jNGYa9jC9s18DeoGuCH7teJjoQM/0IDUzbeznluYyzESLIt4tCRmljdq
 9uJerTqAx31OP+ZF89eL7gr9rjxj04vSxKKjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=50Wbm4gczF2A7a6FcceYj6mrH1bTkWbRyvluupXYCjg=;
 b=mDoOrctmTI7ss7luOYJjilfA8aPXc6aGa7+pDKyuYtC1o7DA9o/eaCaQBUttVkzFtZ
 zsl9c0vlbejQhL3vz1TAYGZuKpbW48dcRf223rwcDRVDY76fk6glLfcRfI8Xm7tCrFPr
 VIcOWuCXB7NUd7Px5Sp5SDNIPUzUkk4zR6h9SHN2TJ85CiYQRDWqFUNe8AvEo0qjkP5l
 NxZzKlvQnQch6aAShBMr6+/0oakZe8+WJHsW8ke8+j71XuCn3VaWF9FvYn7Xu2rmYHfg
 VZjDkmV3xlB6YW70eMUspKTo3vjLL5l653s18ilfhkV1urlFh/6mEK7IhqszRuRV0KqL
 WdIw==
X-Gm-Message-State: AJcUukewSbz9U2lpYQV5mlmRcRgUnl04kdxB9sXvRVOHvDcPaGlNMhV6
 7P9iiYezJhB1CSeYYJZ2r01j9nIrS33MEVeki2wImA==
X-Google-Smtp-Source: ALg8bN49V2kVSO/7xHrgk4IQQ7FBnjTz7l/CIzESfcJvCO875kIkuai4lxh3nHViQQ2hZ/crPqvfo60r1K+gO7qga+Q=
X-Received: by 2002:a9f:2244:: with SMTP id 62mr8774878uad.119.1547466297079; 
 Mon, 14 Jan 2019 03:44:57 -0800 (PST)
MIME-Version: 1.0
References: <1545598758-4502-1-git-send-email-stefan.wahren@i2se.com>
 <1545598758-4502-2-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1545598758-4502-2-git-send-email-stefan.wahren@i2se.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 14 Jan 2019 12:44:21 +0100
Message-ID: <CAPDyKFotvqtZ53QmPMQ8HXEAM4gVfZwD723dmAVHNJoPsg8Y+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-brcmstb: handle mmc_of_parse() errors
 during probe
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_034459_654854_4F1BB3A1 
X-CRM114-Status: GOOD (  20.27  )
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
 Adrian Hunter <adrian.hunter@intel.com>, Eric Anholt <eric@anholt.net>,
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
> We need to handle mmc_of_parse() errors during probe otherwise the
> MMC driver could start without proper initialization (e.g. power sequence).
>
> Fixes: 476bf3d62d5c ("mmc: sdhci-brcmstb: Add driver for Broadcom BRCMSTB SoCs")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Hi,
> since i don't have this hardware, so it is only compile tested.
> Would be nice to get a Tested-by.
>
> Regards
> Stefan
>
>
>  drivers/mmc/host/sdhci-brcmstb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 552bddc..1cd1035 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -55,7 +55,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>         }
>
>         sdhci_get_of_property(pdev);
> -       mmc_of_parse(host->mmc);
> +       res = mmc_of_parse(host->mmc);
> +       if (res)
> +               goto err;
>
>         /*
>          * Supply the existing CAPS, but clear the UHS modes. This
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
