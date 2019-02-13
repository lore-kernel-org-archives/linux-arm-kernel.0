Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49994C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:35:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19ECA222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WG17qa7Y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NiYilG5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19ECA222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lYGm77x7LP77FK8q9QJ0KdxpPyLckbbpr1Nl6Ckbiy8=; b=WG17qa7Yhe/Pdo
	wCjAwUlbogKk+gPIcA2w32f606QNUyvjLXvjNtDwnIF3qtmCxUNaVZTL2iEbLXAbU6BxzK7hkoaiU
	Zir/WvmG4AezR4zDjdkGbP7JSAAR4zLxzOXnz/T9E8qE7VjuKk1KKZgyuKHvSNqkHNtiCysQMFDcb
	MK2sLwWmmd7scYDwLQSY/SCZhroU1IC0G+n+uLrHwPcBQjjinhxsrOJw/o4H4314qF1sk2hkLsULV
	4Ji+56u7+XvETVhj5M/4soE4pyKNe53C4Hu8LVrNYEWj5S/vpZ49dT+uHo4DJ4qu7swqI8qKC1Ew6
	5Mgcoz6BP2m4L2DMJL1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtq11-0003nj-Ki; Wed, 13 Feb 2019 08:35:35 +0000
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtq0x-0003mA-NX
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 08:35:33 +0000
Received: by mail-vk1-xa44.google.com with SMTP id f206so349882vke.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 00:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HEJuA/CVqOqdf11K8MVRUa43ahzsWGYc2vCTimjDMLs=;
 b=NiYilG5ovc0665+noLtRsqe0pseSDEkhmjPOTzzquRnwDuIVQRLnTQQStaNK3TR/5S
 +x3Xfb09BgVElGMIGVvc76O+8WhYooUUQgEDmsoVkWTa1YY55NSFbXKpeT5jEJ4pYbgv
 DIwRcnN9BgP7n2REXfzhMQfJRlOQL8Dt7wtveGE0wTybBMcL81Ycoq4mr59ubkWOgBzX
 evBxxxZpK/K9Q7ilQucAQphIBvQN9bBX8KHOEbobRZkOg2Z9Ub0o8A8/3bWMRYmSNHso
 lfdymKcz06V2dVNLwPucP5KniSRAIPyc5MX77S7fn1pnaS6AvBJlYiZfP/6ol2OXPt3p
 IsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HEJuA/CVqOqdf11K8MVRUa43ahzsWGYc2vCTimjDMLs=;
 b=U6rtDBxJd5s4cCuuhJa9LuNxT/25CUi0QhORxPTgB4LtxPVGQXNsV4HJ5s2fq/Rnmq
 /JjiEExEmmvt5biKc5OjZvCcF9Acfz4ooYOj8iCYzinUbJYfUmKeupLKDvXQNI5cj4/S
 m7xkW3uXvnmaAnB8n0g9mRnNB3xCmfxvRJ0/8Jd0CNvtJiAlPgDb5o9S9AJ+uCcfokP5
 Y47HXgC/k7UvliVwdw/dGK9pljV4EqNu6tq0doeflKMZtewJYOoVRP+7GHqyKH8pKB6q
 Kw/U8gmOEm/A1QUX1EpQ8VRjwiGUEG7t958tnaspmqzfqKR/mT9iv96qlMn/sg67bSW7
 zr5A==
X-Gm-Message-State: AHQUAubM4vLVte9m5bWTWlTB7yNlr0/Zusmk5eDTPZUnP+ziqAmHIXdd
 yK+Y+idedjcu4Tg7eHQ6h6Fdm51h4bQug13yB6NKOw==
X-Google-Smtp-Source: AHgI3Iar92uKrY1QBRsuFskKuq94w5IqhEeacxpal0VDIQnOgJ/IDgoOQ+OsbEdosDF8mg1mEBswkcoVF3C6zbYTSIw=
X-Received: by 2002:a1f:1c81:: with SMTP id c123mr3370687vkc.52.1550046930571; 
 Wed, 13 Feb 2019 00:35:30 -0800 (PST)
MIME-Version: 1.0
References: <20190209005850.11457-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190209005850.11457-1-martin.blumenstingl@googlemail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 13 Feb 2019 09:34:54 +0100
Message-ID: <CAPDyKFqFt4FPfWcpYzKsae_fPMuPtovxFdNUHviS_2vm5-YAYQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: fix interrupt name
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_003531_773894_812BA28F 
X-CRM114-Status: GOOD (  16.86  )
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
Cc: Elie Roudninski <xademax@gmail.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Remi Pommarel <repk@triplefau.lt>,
 "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, 9 Feb 2019 at 01:59, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Commit bb364890323cca ("mmc: meson-gx: Free irq in release() callback")
> changed the _probe code to use request_threaded_irq() instead of
> devm_request_threaded_irq().
> Unfortunately this removes a fallback for the interrupt name:
> devm_request_threaded_irq() uses the device name as fallback if the
> given IRQ name is NULL. request_threaded_irq() has no such fallback,
> thus /proc/interrupts shows "(null)" instead.
>
> Explicitly pass the dev_name() so we get the IRQ name shown in
> /proc/interrupts again.
> While here, also fix the indentation of the request_threaded_irq()
> parameter list.
>
> Fixes: bb364890323cca ("mmc: meson-gx: Free irq in release() callback")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index f19ec60bcbdc..2eba507790e4 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1338,7 +1338,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
>                host->regs + SD_EMMC_IRQ_EN);
>
>         ret = request_threaded_irq(host->irq, meson_mmc_irq,
> -                       meson_mmc_irq_thread, IRQF_SHARED, NULL, host);
> +                                  meson_mmc_irq_thread, IRQF_SHARED,
> +                                  dev_name(&pdev->dev), host);
>         if (ret)
>                 goto err_init_clk;
>
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
