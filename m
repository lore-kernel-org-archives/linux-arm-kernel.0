Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025BFC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:24:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C80852064A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EK5iCtr8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f9x34NV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80852064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+h0UnaXRZm46pr+xwXRLyN9hS/w/Qj3Wjm1oUVOHMeA=; b=EK5iCtr8DbB9cY
	AZV62Tr8a2MNJnso0uRdwMLuzoKWAOatisyy5/mUFp4NiG2mnPK5TQmzXNgrjhPQCGdWbsmzzpLOU
	1I1dnUwuBXf97PbnLSgrea9KkLn3IrmJyZ8L+VRiW27F7YTWdu15e+Xqf953evS0auDFfAoINbiir
	6E2BGU5k+hUcZT/l7phpauM+proANPdHXp8W0LS2V162g81YIyrKCh40gZZXZXE5d50wjivxnuwJB
	hQO/meQUjLVWvFe3qSv2EPszRwzOP/SXje2wriQvjdkHPlakVDE2Sn3jAKorcUwX4cX+c/t7/0rEF
	y5mNgVby8InZD7tnq9ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUY6c-0005P4-VI; Wed, 05 Dec 2018 14:24:50 +0000
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUY6R-00057E-Go
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 14:24:48 +0000
Received: by mail-ua1-x944.google.com with SMTP id z23so7160391uam.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 06:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vU+1DymT0hEbhZE+aC5foMQklWH3FSZCCg/zl0KH5/o=;
 b=f9x34NV+1XndHnc3GjC/kpOcNdD147sghGSZiyTkpxwClkvi9brq8hjb+HIQybVc51
 cSBb3w+ooGhaCKYkqsCMXHJ4YD2QsSZyZGijksAht1Vyh518QA2p0YqJ2dkUSh4GlDth
 tLCQKEADc2AlhXfjalidDimT1VP7q2IzwdXJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vU+1DymT0hEbhZE+aC5foMQklWH3FSZCCg/zl0KH5/o=;
 b=nX9A6mkP5FhPut9g8cemUGN+52dSnkPz3adycAF9hNta45lRUt5P3ybCLH7V8wu3g7
 Z/Va3H32ufDFMUvn5T6WwcG689m5BH3lpiHBS3e7Ax2Tz2Aeznn3wRm5gUsUpkCBTmkF
 SlJm8vBDEGDYxEgXcLJwqypYz8gvcSXvgwVZe+7v8OSqv4Xd4LP26o35LtIi8eb24NgL
 NQFmwC3Ai0y78CLgOK5mK6UGqSrOfrW3ZU0vWgCLzdxGvVAWoOaIkWQ3+Jr1uWDrfxaG
 p0ncfiLKZy/K2PJzbX7meaDa70FzRp0fDmq86ApJkmrIyqr+y/pQG9T1YpzwauBujXj0
 pOxg==
X-Gm-Message-State: AA+aEWYUK6gdOmhU8VMBXrOTtoorYibhNn9vTgNcIQ0RG2lLGniS6WQ3
 gEBsNZx14R3Vn8Tlez6pj6dsUr/PVBPhMYWPtj1+OQ==
X-Google-Smtp-Source: AFSGD/UAcGwOxBo05xwx2+fT13TPm66Iy+FPvgInC1AkScYYfUq8QMqv/baih8Nvh+jjXKVBTnbvQOoYJ+rdYh+vkEk=
X-Received: by 2002:ab0:526:: with SMTP id 35mr11276901uax.25.1544019867917;
 Wed, 05 Dec 2018 06:24:27 -0800 (PST)
MIME-Version: 1.0
References: <1542879319-2196-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1542879319-2196-1-git-send-email-hofrat@osadl.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 5 Dec 2018 15:23:52 +0100
Message-ID: <CAPDyKFpWevQkGncmeJjnsusTBWOc6xecUGsP_8oUMeAwwF4D7Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-mx-sdio: check devm_kasprintf for failure
To: Nicholas Mc Guire <hofrat@osadl.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_062439_850625_08DA1E18 
X-CRM114-Status: GOOD (  16.88  )
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
Cc: Kevin Hilman <khilman@baylibre.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Carlo Caione <carlo@caione.org>,
 "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 22 Nov 2018 at 10:40, Nicholas Mc Guire <hofrat@osadl.org> wrote:
>
> devm_kasprintf() may return NULL on failure of internal allocation thus
> the assignments to  init.name  are not safe if not checked. On error
> meson_mx_mmc_register_clks() returns negative values so -ENOMEM in the
> (unlikely) failure case of devm_kasprintf() should be fine here.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: ed80a13bb4c4 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")

Applied for next, thanks!

Kind regards
Uffe

> ---
>
> Problem located with an experimental coccinelle script
>
> Patch was compile tested with: multi_v7_defconfig (implies ARCH_MESON=y &
> MMC_MESON_MX_SDIO=y)
>
> Patch is against 4.20-rc3 (localversion-next is next-20181122)
>
>  drivers/mmc/host/meson-mx-sdio.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index abe253c..ec980bd 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -596,6 +596,9 @@ static int meson_mx_mmc_register_clks(struct meson_mx_mmc_host *host)
>         init.name = devm_kasprintf(host->controller_dev, GFP_KERNEL,
>                                    "%s#fixed_factor",
>                                    dev_name(host->controller_dev));
> +       if (!init.name)
> +               return -ENOMEM;
> +
>         init.ops = &clk_fixed_factor_ops;
>         init.flags = 0;
>         init.parent_names = &clk_fixed_factor_parent;
> @@ -612,6 +615,9 @@ static int meson_mx_mmc_register_clks(struct meson_mx_mmc_host *host)
>         clk_div_parent = __clk_get_name(host->fixed_factor_clk);
>         init.name = devm_kasprintf(host->controller_dev, GFP_KERNEL,
>                                    "%s#div", dev_name(host->controller_dev));
> +       if (!init.name)
> +               return -ENOMEM;
> +
>         init.ops = &clk_divider_ops;
>         init.flags = CLK_SET_RATE_PARENT;
>         init.parent_names = &clk_div_parent;
> --
> 2.1.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
