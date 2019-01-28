Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC72C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:03:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734BF20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QK42ZkLI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GNXFVutU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734BF20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5H8lmk9xFgWfLKFHN/Ig07aYox84eOsOA/loMMC5FHc=; b=QK42ZkLIKMjbOh
	/C+i6Pb/diW7XDf3tk6CGYfw6K0QGZunO/Y9e5Qm0wbK1mao0iqTpoXclF2BvSZL6rLNnMacowTAa
	QXpjb+7+XUO/Gg3RT1ui7HkvEeN6UNetT7llUoTmG5AmrGLnWweHIIwP41bkaUQsfrijfzxfRw0XC
	hhsiGvaYsri7bBvwkEz6GMfrNBic1GT58mAsVsNZ9C7kZpMmY37o0vKJiYf3d5wje/GC0m0QD+JOY
	AQr/1m81ePFye8NgTkp1+yvXAJyM6efHXUR1gekHm7k52frRDoVNTaiFDVXLTqEFu1M3ymMjs818m
	aH9umfCNpP/m0bFAqb2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go5ds-0002qd-MM; Mon, 28 Jan 2019 12:03:56 +0000
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go5do-0002po-Rt
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 12:03:54 +0000
Received: by mail-ua1-x942.google.com with SMTP id d21so5481306uap.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 04:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sByUJrKsTOxJYVww13dSB2bgQhM1gVqK4ReGQH3yoFk=;
 b=GNXFVutUcpCdIF+x7BZJlfEO1iFZLh8FqB8E6XFAXbPl6/2tbGtG43iCMOvFvuvqaa
 XEb+C51YbMXKZbWfWA6RKydxfFm5XBtULSuQyBAlPFxqQwT11ZTKleRWmEfrUupeQuxt
 Y+M6Fz+u8aBkN5eniihRN1DMq2qAj+sv9BNX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sByUJrKsTOxJYVww13dSB2bgQhM1gVqK4ReGQH3yoFk=;
 b=SrOFEDV2eO3Jr9Kd5SjjLWs0yOxhxjOHDbHTu2/xIrxUVPPUoZbO0T2iHnNpEspnUj
 4trtE+w76//X+dR/klJFapM8wahq7uqd2YNYg9Px15S1xhh8GAe+TjI+sRC4F/7nBF6J
 M9WlhkjNLE3AI7Pr4nP6dZSk67dA0tqWG6O+dRwg3S72hzMq266ABpWuL+29KGnuGoo+
 CDN4oaKAB2DK8QWI98+6HGTuHBKGo7N9wYBGwRpdHlOj56lfTvnHYMRtBzBQikI4amkH
 mhkldz2MevR6yKIg8yiZoIcpdIRpAS5E2rp4UUvobY0Ya7LJ2FGc15Xx0TOQxdf4GSWc
 ywhQ==
X-Gm-Message-State: AJcUukcQIlTcpZMM+0s7sFuqDEtSR6NCgkvAZqs24aCEve0YRtKTmF/k
 Dp/cpV1S+WR43uVh9zu6gIedrq/XIw+82qUOxJg0Pw==
X-Google-Smtp-Source: ALg8bN7cUn8ayIYSRR8QH1Dr2XY8uGoKJxJmlhbQTvSNbYqmrlvZ+PXPK+onvfJN2abZAp7wF603MtSPMOW67iWOmbM=
X-Received: by 2002:ab0:b83:: with SMTP id c3mr8378257uak.77.1548677031631;
 Mon, 28 Jan 2019 04:03:51 -0800 (PST)
MIME-Version: 1.0
References: <1548245125-31664-1-git-send-email-chaotian.jing@mediatek.com>
In-Reply-To: <1548245125-31664-1-git-send-email-chaotian.jing@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Jan 2019 13:03:15 +0100
Message-ID: <CAPDyKFoWDDrNx0+k+4AuXAThxLizmvXUUMHqmA0Cy2OgVm6iKA@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: fix incorrect register setting of
 hs400_cmd_int_delay
To: Chaotian Jing <chaotian.jing@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_040352_902639_E6AABF6B 
X-CRM114-Status: GOOD (  14.34  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>,
 srv_heupstream <srv_heupstream@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Yong Mao <yong.mao@mediatek.com>, linux-mediatek@lists.infradead.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 jjian zhou <jjian.zhou@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 23 Jan 2019 at 13:05, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> to set cmd internal delay, need set PAD_TUNE register but not PAD_CMD_TUNE
> register.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Applied for fixes, adding a fixes+stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 8afeaf8..833ef05 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -846,7 +846,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>
>         if (timing == MMC_TIMING_MMC_HS400 &&
>             host->dev_comp->hs400_tune)
> -               sdr_set_field(host->base + PAD_CMD_TUNE,
> +               sdr_set_field(host->base + tune_reg,
>                               MSDC_PAD_TUNE_CMDRRDLY,
>                               host->hs400_cmd_int_delay);
>         dev_dbg(host->dev, "sclk: %d, timing: %d\n", host->mmc->actual_clock,
> --
> 1.8.1.1.dirty
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
