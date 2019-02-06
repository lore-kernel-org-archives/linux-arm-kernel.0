Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA78FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:15:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9CF22080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mpBXZtx+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QFNGYi13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CF22080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RhyR5LIWuz7+2O0L2K+UE4J/Zl/t6yXHi7cqr9VZ7u8=; b=mpBXZtx+DH/4XO
	2gIdrt4aaNs1CJg9jkP/OpQQRtK9g1Vi4ptVMPrsz3S2gj3Vha5UlkicyQ1NlIg4nEAT1sQzTjACE
	xCaDLrer3//pOJF5YgBboV1vmwwvUKgMVSYulnh2lFESdg8dHqyEeh02qFCCiofTy+HQk2VctVMgd
	lDDfiSvfN4qSMivpYRYw8bUXUfiBwizeByDGFLXXuZWj09E0f9fjKf10Ii4VzI52UIx4oOOdXHqLk
	upRfUN5abqGvk+jUJZMFP0QcEk2jAHA+0FvVFn9oo16k6wlxsSvPNs0Ps63YJYE2TqRzPZBdRat/2
	/iuUoAqXcK3GsDdh67rQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grOv6-0004SU-Ee; Wed, 06 Feb 2019 15:15:24 +0000
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grOus-0004CD-Gw
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 15:15:11 +0000
Received: by mail-vs1-xe41.google.com with SMTP id n10so4549578vso.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 07:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Jrx3J8g78HNKbcyIhNwW/cIsTpfQf3NvO+d20dftCfo=;
 b=QFNGYi133XP51tWeU74MBEYaVAwFVprvPSz58noO+rkYLr5hJnDz5QD0K2seBsg6D5
 uKQsd57NqNJql+XYceciq2lFv48QihQk6nXuLLylgXMuGwz8p9JjFx1dsarLbhw2ATiq
 v6FWkyXAqI1UD+HYEU68UVPjRorWdaQKXAcNEgTaIil0OkNltOqRWoSzGafeIWosaqYM
 E76JzQv0/qJ0+VWm3/rFbj5wPnnvzhepShvC8pHuN6DZClEaJF/eZkPv2EM4vNtDCDAR
 FFM6vOXYDf2+mVuzPvCJkpl+TswAGrKd23szZHr978UlOZ9TYBB2FrOnyACGjszIr1ca
 DGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jrx3J8g78HNKbcyIhNwW/cIsTpfQf3NvO+d20dftCfo=;
 b=eO4Mo7pmARFtq9Yu0dAozHGGR15UBrLK+h6FE7XIp5wZMuWvgliVtfzeu72eqRUYw4
 f77okMKCzkHiEuqGG8wD8s6JHxHoSxnPpJBzlmWs5Fy17eY20mQwnPRnZP8YUkI3fb5g
 rNID+FyateSWear0VotsdYvMByfjjPRLlgyuXEBjO0+Rqv7b/ayl1UVC+aRSQlKj1uLD
 ww0vku6clzso/nuWKJO9BzKxigE23WVYzxyqxDddT0GyTE/jG6U2qmAaFgX/CgMrifWD
 L8t7A1nmlg0m5pT5KEt1PsTzeMB7o8hnqyQELeviFw+xsez+uUsbeGOx984edEEC19ln
 IIeg==
X-Gm-Message-State: AHQUAuaAf9+Jf2s6z0Zdn/F54nLdJGM89JhaYomZjnc1pwO152m1i54c
 3YWITrqpepm7U84oBtorGmuhMG8FI3Z/XsRQ5alYGw==
X-Google-Smtp-Source: AHgI3IZZYAtg5s12Ud90R3bvVoRnr4n3usuMfUADjKPW9ElCIFdhflS44o1wDq5RB+TEvYwQPnbuwgDblz3psyF+nZY=
X-Received: by 2002:a67:d00f:: with SMTP id r15mr3039586vsi.191.1549466109322; 
 Wed, 06 Feb 2019 07:15:09 -0800 (PST)
MIME-Version: 1.0
References: <20190205154225.14264-1-wens@csie.org>
 <20190205154225.14264-3-wens@csie.org>
In-Reply-To: <20190205154225.14264-3-wens@csie.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 6 Feb 2019 16:14:33 +0100
Message-ID: <CAPDyKFoZYY4O_eXExvZQvJcnyHLc+JfQMbDmUe9mxJwR6QtchA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: sunxi: Filter out unsupported modes declared
 in the device tree
To: Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_071510_562597_30F545C1 
X-CRM114-Status: GOOD (  21.12  )
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
Cc: DTML <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Chris Blake <chrisrblake93@gmail.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "# 4.0+" <stable@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 5 Feb 2019 at 16:42, Chen-Yu Tsai <wens@csie.org> wrote:
>
> The MMC device tree bindings include properties used to signal various
> signalling speed modes. Until now the sunxi driver was accepting them
> without any further filtering, while the sunxi device trees were not
> actually using them.
>
> Since some of the H5 boards can not run at higher speed modes stably,
> we are resorting to declaring the higher speed modes per-board.
>
> Regardless, having boards declare modes and blindly following them,
> even without proper support in the driver, is generally a bad thing.
>
> Filter out all unsupported modes from the capabilities mask after
> the device tree properties have been parsed.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>
> This should be backported to stable kernels in case people try to run
> new device trees (that declare newly supported modes) with old kernels.
> ---
>  drivers/mmc/host/sunxi-mmc.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 7415af8c8ff6..70fadc976795 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1415,6 +1415,21 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>         if (ret)
>                 goto error_free_dma;
>
> +       /*
> +        * If we don't support delay chains in the SoC, we can't use any
> +        * of the higher speed modes. Mask them out in case the device
> +        * tree specifies the properties for them, which gets added to
> +        * the caps by mmc_of_parse() above.
> +        */
> +       if (!(host->cfg->clk_delays || host->use_new_timings)) {
> +               mmc->caps &= ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR |
> +                              MMC_CAP_1_2V_DDR | MMC_CAP_UHS);
> +               mmc->caps2 &= ~MMC_CAP2_HS200;
> +       }
> +
> +       /* TODO: This driver doesn't support HS400 mode yet */
> +       mmc->caps2 &= ~MMC_CAP2_HS400;
> +
>         ret = sunxi_mmc_init_host(host);
>         if (ret)
>                 goto error_free_dma;
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
