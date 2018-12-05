Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD60C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:24:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AA8720878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q9mpFSvO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ago62cqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA8720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mI2BoddHvrYj0896y+wXVRJbHbmQXhrq7D1uflyurDg=; b=q9mpFSvOZQRpWM
	X5ZHgtXCP23It9OOn+SF9zA0UeBah/17UJPqjC48kmEsITOk+ABEmIfeQ1O+OtSxfEeCMRnjqqrQk
	4dcoQ5RqP7c+5UugLGmcqJeg1NZCkAZEE/pE3UQVguGgace34gmyxnZaSO0eYAaoyyMDCmleFaWnY
	CicQ/gHV+teuLcRB6r/JDAxLQ8em7l4EWD8+gZbQmhF4OOAWn6SFVFXcQx02ZEui/bMYiJA5HG8/+
	b2S8GJSCimFTbLFkcPA1aNLbH3faDcYC3/D8fBrALwIg75WObf4wfdyYCLGZ3/L3io92GKD3vUhbL
	IDa4hN4QnlDUThLnLcWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUaug-0003OC-3s; Wed, 05 Dec 2018 17:24:42 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUaud-0003NE-An
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 17:24:40 +0000
Received: by mail-it1-x142.google.com with SMTP id a6so21403366itl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 09:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zJIU5qPm0FWz6VlyDVJI6HhxPQrbh3vWQhdmJaDqXII=;
 b=ago62cqjasKEph8jw6fM4KZisk1vJjJIjahBE4+/dyxc3gT7rtjWjC7pF17I7qFK3U
 A9b3rcDm/sJdTEiAJu8W3tDpX2TukaU60/ji5yHcGcif27VyGZqePxtJhEYD/qn7x/+4
 cmwcCjKK/VMRxDTnZKldfbE6P34E6btP6VrwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zJIU5qPm0FWz6VlyDVJI6HhxPQrbh3vWQhdmJaDqXII=;
 b=iSKeTp+yaWK+UAJcz6K/Rn8d1KSCKSW+xY+UgDrssBwZvW4UoPZGRZyHUQeItV92ag
 mv2h0uI2tGcshUFy8HZPOI9eIX6xSe6VSKVL/gzxgVIfBFlVO3rKdWjiajXhPBMS+Lar
 v/Cp9Q1E8njbLNKn7lFGWKHFln+g1+brU/mVQl5xO040MAPACn7RZHMaCgiJ5g9uoJKK
 tHA8UHZBzsGAWywFahMAivfQjoHORp0lNtbicbIXkud2vuH1OUnhCg/PNqcoIIp0HKFb
 NV3nJxTGem82F6xP6bsre61wteSviId1+9thVn7GGIAvXuUHR5o4zRY5XqPQVXdt4zyl
 Y8TQ==
X-Gm-Message-State: AA+aEWZPhxB/9qiJHDoeV5Li0GdG1Pv1DqhiA5GvO2tYIJjJUfHsr5U9
 mCRHGf7qnL3s9qgOqJR52NbNGnMHNTgxa5sg6926H4oh
X-Google-Smtp-Source: AFSGD/WndxEYCJe+B1h3fR8jRvsFAGkt6W2jotSAufegGWj/fUHQf3BmDj+/l2qzbsos2R9cXU5JoQFqVi/T+nWA5X0=
X-Received: by 2002:a05:660c:34f:: with SMTP id
 b15mr16466076itl.146.1544030668000; 
 Wed, 05 Dec 2018 09:24:28 -0800 (PST)
MIME-Version: 1.0
References: <1543653585-108277-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1543653585-108277-1-git-send-email-yuehaibing@huawei.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 5 Dec 2018 10:24:16 -0700
Message-ID: <CANLsYkzyVCrV8UG7Fim0an2Rto2a4WTd6fSZLr8tt=gLZACesA@mail.gmail.com>
Subject: Re: [PATCH -next] coresight: stm: remove set but not used variable
 'res_size'
To: yuehaibing@huawei.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_092439_369258_D6692D11 
X-CRM114-Status: GOOD (  14.65  )
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
Cc: Alexandre TORGUE <alexandre.torgue@st.com>,
 "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 kernel-janitors@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, 1 Dec 2018 at 01:31, YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/hwtracing/coresight/coresight-stm.c: In function 'stm_probe':
> drivers/hwtracing/coresight/coresight-stm.c:796:9: warning:
>  variable 'res_size' set but not used [-Wunused-but-set-variable]
>
> It never used since introduction in commit
> 237483aa5cf4 ("coresight: stm: adding driver for CoreSight STM component")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied - thanks,
Mathieu

> ---
>  drivers/hwtracing/coresight/coresight-stm.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index ef339ff..f07825d 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -793,7 +793,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>         struct stm_drvdata *drvdata;
>         struct resource *res = &adev->res;
>         struct resource ch_res;
> -       size_t res_size, bitmap_size;
> +       size_t bitmap_size;
>         struct coresight_desc desc = { 0 };
>         struct device_node *np = adev->dev.of_node;
>
> @@ -833,15 +833,11 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>
>         drvdata->write_bytes = stm_fundamental_data_size(drvdata);
>
> -       if (boot_nr_channel) {
> +       if (boot_nr_channel)
>                 drvdata->numsp = boot_nr_channel;
> -               res_size = min((resource_size_t)(boot_nr_channel *
> -                                 BYTES_PER_CHANNEL), resource_size(res));
> -       } else {
> +       else
>                 drvdata->numsp = stm_num_stimulus_port(drvdata);
> -               res_size = min((resource_size_t)(drvdata->numsp *
> -                                BYTES_PER_CHANNEL), resource_size(res));
> -       }
> +
>         bitmap_size = BITS_TO_LONGS(drvdata->numsp) * sizeof(long);
>
>         guaranteed = devm_kzalloc(dev, bitmap_size, GFP_KERNEL);
>
>
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
