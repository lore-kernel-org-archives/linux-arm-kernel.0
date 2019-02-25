Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F4CC10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:21:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B2902184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lZQpDwvE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MO2mrfIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2902184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d1xYGUFqDlMCKLRoLCYpaPeAAvRJ/3PonNvOVfvxBg8=; b=lZQpDwvERLqClx
	jgqCR67mj4ViJrh7/Iu1ZvOTWF9nSk9H3+664wpb6idyP3nTk52mXotqQArFxcwI3Q9xy2C1wGjac
	M45oNLZHEt0rDMbgqTkXclH7tHEsJwFIPCMSiUwUbL9bb3NoLVw/AtI/B0S03e0PXRPpp6EbkcVtb
	MhxuzyDyN6vec7u165PbEOciDh5iNuJyPFw4X0lfwraRMBDBsZK3bpnuDtujiYF5lMlfXK+GQfJK7
	H5S0Hf1i+N0oeKt/tN5EafK1D+fKF8X7goIo3nwNpiGNdu5MjMAGHEm2hd2Jld/lPOmtR83TG4DZq
	+Jv80dZa+oht7JvHR1KA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyQV0-0002AF-BE; Tue, 26 Feb 2019 00:21:30 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyQUw-00029U-Qj
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 00:21:28 +0000
Received: by mail-lf1-x142.google.com with SMTP id x206so280942lff.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 16:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/cHvJz/lFIgbpCR1endu87T6pP0PHpJtFHp0QcdQTyo=;
 b=MO2mrfIGnMt0DrgiT3cbOzkV8YHPyYhrBJ4ZMTuNLD2o3UtuIo6Q+7rprD6GIw+y/c
 edfwxRfiVaLszBWXr0qn8UAToIcRs3wJwSD30LRc/f08p8VVfqakAxaARyXDO4YUdgBY
 THuRgKZxfjnQ5Y9SX4lGZU+RkZyVyOxwR4HOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/cHvJz/lFIgbpCR1endu87T6pP0PHpJtFHp0QcdQTyo=;
 b=oDIxg8IHgDmVQ/ab5zQZXiRJSDgmV81qVcE+p2kty6OZk/n40wW0GniAf3BepZiSrO
 RGhWl5UzD7rLIUAJA/fsyJIaUQUXY1pNWrLZO8ZqGX7mUSrJpCweiw4ZliV+cWS7jHWt
 Psd1DGZpdM4BQKQotHhKRLkrHIlES65bxXQRGg9Dx3CoSHRmycQkL7LMYGqseQJ6i72u
 boUhAgMEbHkHXEZAq/4F+eoLoEro7SC+e+4ia2vsxFOMrTnRGp1FnrDUu3tICA8xrUB8
 gqY8vVDREiGnaNBQh7CE27ckRI1QBsFGGYNJuie2cg+41tgmwMJmdqUzvTkDFmXZ568o
 GqJA==
X-Gm-Message-State: AHQUAuaT7xsPwx9zrEmDhcFIn+KJOTPpb6w8gqfE5Us8IFRWjB4fhWbG
 m9D1XeMi3Cew0+ltd+6vJqoM41CgQ2Y=
X-Google-Smtp-Source: AHgI3IaZpCIvAN9AGfY7K9KGqcCgvkeeva7zExNihRIYug1qIPjHQvWowSOkBucXyKPxDWVteZZf9g==
X-Received: by 2002:a19:cbc6:: with SMTP id b189mr8806177lfg.34.1551140484997; 
 Mon, 25 Feb 2019 16:21:24 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com.
 [209.85.208.179])
 by smtp.gmail.com with ESMTPSA id d3sm2740722lfj.39.2019.02.25.16.21.24
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 16:21:24 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id j19so9142651ljg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 16:21:24 -0800 (PST)
X-Received: by 2002:a2e:99c9:: with SMTP id l9mr11485651ljj.60.1551139025774; 
 Mon, 25 Feb 2019 15:57:05 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-12-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-12-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 25 Feb 2019 15:56:29 -0800
X-Gmail-Original-Message-ID: <CAE=gft4Z_C0NRmP0A_rnDzvB3txt3cGV=rvZhJOQZk_1qahiQQ@mail.gmail.com>
Message-ID: <CAE=gft4Z_C0NRmP0A_rnDzvB3txt3cGV=rvZhJOQZk_1qahiQQ@mail.gmail.com>
Subject: Re: [PATCH 11/13] iommu/mediatek: Use builtin_platform_driver
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_162126_863316_46190E96 
X-CRM114-Status: GOOD (  16.91  )
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
Cc: youlin.pei@mediatek.com,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 31, 2018 at 8:53 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> MediaTek IOMMU should wait for smi larb which need wait for the
> power domain(mtk-scpsys.c) and the multimedia ccf who both are
> module init. Thus, subsys_initcall for MediaTek IOMMU is not helpful.
> Switch to builtin_platform_driver.
>
> Meanwhile, the ".remove" can be removed. Move its content to
> ".shutdown".
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c    | 23 ++---------------------
>  drivers/iommu/mtk_iommu_v1.c | 16 ++--------------
>  2 files changed, 4 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 735ae8d..2798b12 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -690,7 +690,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>         return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
>  }
>
> -static int mtk_iommu_remove(struct platform_device *pdev)
> +static void mtk_iommu_shutdown(struct platform_device *pdev)
>  {
>         struct mtk_iommu_data *data = platform_get_drvdata(pdev);
>
> @@ -703,12 +703,6 @@ static int mtk_iommu_remove(struct platform_device *pdev)
>         clk_disable_unprepare(data->bclk);
>         devm_free_irq(&pdev->dev, data->irq, data);
>         component_master_del(&pdev->dev, &mtk_iommu_com_ops);
> -       return 0;
> -}
> -
> -static void mtk_iommu_shutdown(struct platform_device *pdev)
> -{
> -       mtk_iommu_remove(pdev);

Is there a reason all these things are happening in shutdown()? Don't
we normally just not clean things up and let the machine turn off?
Normally I'm a big advocate of proper symmetric teardown, so it hurts
a little to ask.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
