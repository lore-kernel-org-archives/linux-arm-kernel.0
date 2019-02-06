Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AA6C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:15:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F892080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DW4G4ksZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GzJesEv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F892080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HVDIe6KwJPCBX4x5UUoriicPnU+LkwmXguVn8m+o5S8=; b=DW4G4ksZYHSqqD
	OGP6jO4mLI/jrDkIQqHgs2DdjYA0lh2Xz9AAm6c2Gwh+zVltWzhwvJTPNVFvIOWEHzRv+S5QApXw2
	dndy2DBTv/oqw4u0gSZgIoiTV1VaNvTg1YrWGi25lClNorPKbAwcckVtEBW9Jp4qcRayu3iV2hWxO
	4qzC7+8yi142UxQxIoFSVHe+hYrIE/bJ5UgdTYRBnFhkohcRw96ItQfgRuJOVwWmNQd5ZCMHclXjF
	dVwd74dTqAntgVWJWwAnnXiMSblELBgTuMdYc++JsBO1jZvhYvhd6dqb0IJDFQbok6yq7vMiKfjB4
	H3Ho6T/0iPmwpZ2puyeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grOuu-0004Gq-Gk; Wed, 06 Feb 2019 15:15:12 +0000
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grOuq-0003lL-Nz
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 15:15:10 +0000
Received: by mail-vk1-xa44.google.com with SMTP id r127so312241vkf.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 07:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rOLpN+UPyqi3jWVs1lK5bodoiB7hCCj3LPiz8kTnc9U=;
 b=GzJesEv8L88m2tX+QPApEgdEind3pCZzlPeZWVXX/rQbwYocOfQBQi3cqOA0H21On1
 sHqmTkoHLpLVw0ysf3TPQaw2KYfjlkTT0AplL7H3DBNsDUSJlgZVjdGH4ihmKlgaEp4y
 jL/ZIoZW1dGIMUe5YHG6n0vKJRH4XDs1b38wkBsG7QXsuJO+ThtgJaR6uvxMus6Ttew9
 DmQieTmSYxHilM+mtfhdPBbLnJxzpbpd8ocial5a9TV9O39m1vn+j0972r4eRXPd0t58
 POlA8gh6jaRJm9XIiqjQc6BiU8Z/vROztYQNxzCi1x6+RWobZF4+Ejh6fJSxMMpxHKij
 qLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rOLpN+UPyqi3jWVs1lK5bodoiB7hCCj3LPiz8kTnc9U=;
 b=roUU/G1sUN3ebqrxHmE0HAJiUdytZ4ihIu0uiQbw/oRnR1gXOktjWvvKEKC7SlHR8f
 0Y81T8DZeYbC13ku56aAhGaaH4lfLFhLbSrGtUMif0Ne9kAEpMjkynoJ23N/FuYUueQS
 um/Ko4jCU454n8lxh9QN3w8gu4dibZPa254t4G6K1QKo4Vwc9tW/wWtky65+D1SI1SOD
 WPYaF85pDIQ0Ejkzi8SN5lJ/h/TftiVMbkH/YqB9rtIGNmmDKyg6VwgacRLndCry6SCd
 y8fK+zQzwJKIwMxc2coDUKdYLgBWKhJI8fsMKGWj1Pnn9r8hc43d2gdKXVRYXGBUse6n
 2/3g==
X-Gm-Message-State: AHQUAubN0i7bv1HTkgqvIRg7DhB6FYn4TSYfgcOEI6UEhkjAg4qAXFA3
 p4wNF6eJpQmn2ztWsgAnhOSL4toJn99MwkkP5fInSw==
X-Google-Smtp-Source: AHgI3Ib3ugbbM2J77i0603ijXnbiapcjFbQgHQTN4TnBePBlhST/J7RnZhON4+u8AImspWH8bjlE+ROCaUmN54zHp3w=
X-Received: by 2002:a1f:8e49:: with SMTP id q70mr2914628vkd.40.1549466106949; 
 Wed, 06 Feb 2019 07:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20190205154225.14264-1-wens@csie.org>
 <20190205154225.14264-2-wens@csie.org>
In-Reply-To: <20190205154225.14264-2-wens@csie.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 6 Feb 2019 16:14:29 +0100
Message-ID: <CAPDyKFq0RbeFXcK71x_NUE6=EbqGyoCp-ac5vuTgYh85o+X61Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mmc: sunxi: Disable HS-DDR mode for H5 eMMC
 controller by default
To: Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_071508_793737_7646F7D9 
X-CRM114-Status: GOOD (  18.41  )
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
> Some H5 boards seem to not have proper trace lengths for eMMC to be able
> to use the default setting for the delay chains under HS-DDR mode. These
> include the Bananapi M2+ H5 and NanoPi NEO Core2. However the Libre
> Computer ALL-H3-CC-H5 works just fine.
>
> For the H5 (at least for now), default to not enabling HS-DDR modes in
> the driver, and expect the device tree to signal HS-DDR capability on
> boards that work.
>
> Reported-by: Chris Blake <chrisrblake93@gmail.com>
> Fixes: 07bafc1e3536 ("mmc: sunxi: Use new timing mode for A64 eMMC controller")
> Cc: <stable@vger.kernel.org>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sunxi-mmc.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 279e326e397e..7415af8c8ff6 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1399,7 +1399,16 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>         mmc->caps              |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
>                                   MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
>
> -       if (host->cfg->clk_delays || host->use_new_timings)
> +       /*
> +        * Some H5 devices do not have signal traces precise enough to
> +        * use HS DDR mode for their eMMC chips.
> +        *
> +        * We still enable HS DDR modes for all the other controller
> +        * variants that support them.
> +        */
> +       if ((host->cfg->clk_delays || host->use_new_timings) &&
> +           !of_device_is_compatible(pdev->dev.of_node,
> +                                    "allwinner,sun50i-h5-emmc"))
>                 mmc->caps      |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
>
>         ret = mmc_of_parse(mmc);
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
