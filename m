Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6A2C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:09:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E04F222AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p7orTwdG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s/+MFZFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E04F222AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KQKuwLlXgIBcJ0ZNNh2jwYvBcNb71m7JNMSXHaHAK4s=; b=p7orTwdG7zo4bB
	A3OAgU+RMEfd90LSVbmkKOkPxVLH/EzmwqeYHlhqHOm7cbIAjL8Q5DJI5lmhJMTbShysLNgakzXhb
	khVFA27vvuxbziVjmjP7I1R3XdWdaY68r+h/Rv+3UKKoLQcVMVz42jzwnzuUBcnkFEVFv/AmbNtbK
	tKhesyR5sRebZhKS1H4cVVIsD6G6MoXSiiQbFiIxdTcIGoZrobPewSmK2Sc3OS4n81u8sTS+svNLL
	drMPusTcMFyRu+ZVxjA1+pVycJGfJapLX3tQ3/Z6WmfHP4WerOVnBbohBy1R3bjqXaj4z32npqeWg
	lS/wBjvfdZAvuSkUvmvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gttLx-0005Av-EG; Wed, 13 Feb 2019 12:09:25 +0000
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gttLt-00059m-92
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 12:09:22 +0000
Received: by mail-ua1-x944.google.com with SMTP id e16so671876uam.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 04:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Tomadc5NLuTEZWSBt9A/Z/OxsLDygmn8C6sD5u1RnAk=;
 b=s/+MFZFQdJ5wc+fCrcDEdY98PFQKR/CkdOol5xVzknngHj2Mf6EjCRTZYeMbClJyXJ
 Vt1zdHaQp/xFOIFVa/MV3L5vdiG0+9av6+IYIy8Dgm7NEoBag56GjgFoGq8Vhz0k3lMV
 F9fShJEFK1IFPGdiXCL8bz0JvsMJqDbig1PH31wnLCSs61EY7WEOi3JST6O6obqQWC4s
 jApFMc5UjrgfNgTLUr0kFKH29B6thd5h0CLSvIwFGEL2xY0Ik9VFUbOv4nKg5clbUOhn
 vujiF7hqOujrN3GA+B/IqO0klktNmmlJj4SEV8Zq/xGHFF+ItvbDFeNUXPRkrfEx54aL
 1P9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Tomadc5NLuTEZWSBt9A/Z/OxsLDygmn8C6sD5u1RnAk=;
 b=JN5YXQHhOv8vZsrsgeRfsmGnAbV8oDVzNv8KOqXr+Vi3Us0JGyibP1AVy8AO8e6D1w
 aho4cHqItMxW0JJrnRfAP6WgVtkYnmGQ3NpEYg7Hm8dkIy6ZyVNSGwkVANMF50j6e1PF
 4ajeZAfs7/DAowRr/OkyvowbYBiiwOTn/fI96J8PBBnbdtXo5GSxdXVJUBgUMwOVZ+3d
 pQk5I0hmXp/DPMjQSjg0qw9tVW9qXHYgbJh/vRGxM1l6booK85ZWVn1O+W2EcdYa+fo9
 72MVhfO36algxuz/n8M0ghV+9/6AAk3Z6tfsA9pcUMLpQdCi+6hQnenl0jK2vMBixynf
 ZR/g==
X-Gm-Message-State: AHQUAuaG1D/XXr4GZvq4Ua6SbrJd3BYEy/FTlBOQDWB68P69uRImzr5R
 d0VQvUFB6stjie9czDi7P8xtik0xk1PBbsMSLojzoQ==
X-Google-Smtp-Source: AHgI3IYKJI/LELk31xcRwzxAgH9EsF+YE5I4BAcQjqNLWWzOUqdfVYoErIEDJkKVxxDYnIhK0mxyOLo6njWBHweJTaw=
X-Received: by 2002:ab0:238e:: with SMTP id b14mr48222uan.119.1550059759809;
 Wed, 13 Feb 2019 04:09:19 -0800 (PST)
MIME-Version: 1.0
References: <1550048812-29068-1-git-send-email-chaotian.jing@mediatek.com>
In-Reply-To: <1550048812-29068-1-git-send-email-chaotian.jing@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 13 Feb 2019 13:08:43 +0100
Message-ID: <CAPDyKFpNEhXT0dD_p85Ab2H_nHtr5r86BLcvkLVUsdwtYLUs4g@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
To: Chaotian Jing <chaotian.jing@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_040921_332436_9B51AC1E 
X-CRM114-Status: GOOD (  23.06  )
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
Cc: srv_heupstream <srv_heupstream@mediatek.com>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-mediatek@lists.infradead.org,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Hongjie Fang <hongjiefang@asrmicro.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Simon Horman <horms+renesas@verge.net.au>,
 Kyle Roeschley <kyle.roeschley@ni.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 13 Feb 2019 at 10:07, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
> Therefore, any commands sent to the card should use HS400 timing.
> reduce clock frequency to 50Mhz but without host timming change
> may cause CMD6 response CRC error. because host still running at
> hs400 mode, and it's hard to find a suitable setting for all eMMC
> cards when clock frequency reduced to 50Mhz but card & host still
> in hs400 mode.
> this patch refers to mmc_select_hs400(), make the reduce clock frequency
> after card timing change.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> Fixes: ef3d232245ab ("mmc: mmc: Relax checking for switch errors after HS200 switch")
> ---
>  drivers/mmc/core/mmc.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 09c688f..00adc2d 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1239,20 +1239,37 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>         int err;
>         u8 val;
>
> -       /* Reduce frequency to HS */
> -       max_dtr = card->ext_csd.hs_max_dtr;
> -       mmc_set_clock(host, max_dtr);
> -
>         /* Switch HS400 to HS DDR */
>         val = EXT_CSD_TIMING_HS;
>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
>                            val, card->ext_csd.generic_cmd6_time, 0,
>                            true, false, true);
> -       if (err)
> -               goto out_err;
> +       /*
> +        * as we are on the way to do re-tune, so if the CMD6 got response CRC
> +        * error, do not treat it as error.
> +        */
> +       if (err) {
> +               if (err == -EILSEQ) {
> +                       /*
> +                        * card will busy after sending out response and host
> +                        * driver may not wait busy de-assert when get
> +                        * response CRC error. so just wait enough time to
> +                        * ensure card leave busy state.
> +                        */
> +                       mmc_delay(card->ext_csd.generic_cmd6_time);
> +                       pr_debug("%s: %s switch to HS got CRC error\n",
> +                                mmc_hostname(host), __func__);
> +               } else {
> +                       goto out_err;
> +               }
> +       }
>
>         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
>
> +       /* Reduce frequency to HS */
> +       max_dtr = card->ext_csd.hs_max_dtr;
> +       mmc_set_clock(host, max_dtr);
> +

What Adrian suggested was to not to move this part, but instead, only
allow CRC errors from the CMD6 as above.

I guess it didn't work for you?

>         err = mmc_switch_status(card);
>         if (err)
>                 goto out_err;
> --
> 1.8.1.1.dirty
>

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
