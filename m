Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CF7C5AE5E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:05:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31CC02084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tuDFsiNq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QjhZlXAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CC02084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g5dl1KC7Dx8kaNtDwbcCpYiDp5UUXOofxHaD6L9pn5k=; b=tuDFsiNqXXM0Pp
	3v9tQ4Q8WQjbn1bKAa77jhOdc8zmWNogn9qzeEfZ/VpJEa9qd5EEx5P+J04pGjif9bFQbDNw/Us92
	jR2UWhVu79xQ1znWX9VxB3hA7UERDvDuD7a2LoW75ZmrPGJ6Kik+RktHDCJieOu6HkWpACubCT3hk
	1HTGqN0yLg1CaFiC52AVXROR10A8frYgCMdaRWZH9yhDflu9MEOVozPW2M1QrRg4mvR15zo8HTeHG
	v65Vua5tc+Jeu3AsJhysUlz7JAlzzU2TzLjlTh1CxarHCkp/RHQ0MoiBHT0eyUPo+NwfwpFKrKcGf
	yvExht4r740QjC5DlCMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkdCS-0007vt-U0; Fri, 18 Jan 2019 23:05:20 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkdCO-0007vW-CX
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 23:05:18 +0000
Received: by mail-lj1-x243.google.com with SMTP id l15-v6so12961807lja.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 15:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/K6x1sgeqVJVfiHFK0y8DH1I8j6da/Rzsjk1ZeG7CAo=;
 b=QjhZlXAlp29UqMm4hpwWlSzY6aWdxZXa+RpJmeCn1qVIuKIO9gWdtyExCYYXgqYZqn
 7cjY1+tCcAwN6XIAEssXswio0PF1VzBcXd3rykp8gex/WGSplaoG0GIXhzE4dblaHQjf
 e2qeIV6CYVzt1kjJQVQtM4oifoVVVeFXrS/8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/K6x1sgeqVJVfiHFK0y8DH1I8j6da/Rzsjk1ZeG7CAo=;
 b=UBvzULP7lHPshppfQnNclqkk2mIVAOHha5bEm4Sl/SyVCgMmYWbBRYdvKyJrW9G2gk
 3TKFjGO6wJprYCViH71yKuH96b+5inazRnMU97g6gp9cS8KDKHzRRC49U8KBMcY3J7lL
 jAwyOtcaFE1kBgGAgcU/4zrpJj2CIN4uAE+9jcHfPHcO3aNWyMAsnZYTJY9He6wOqaeV
 d1SiN34gzhI882mSZrst2vb33xszDvtdFmUR9J6d9xmpoJ6lKE51LDZCZDfvJhYLSVWn
 N5p+plE0pQGJ9L5G3Fgy2bGqMLbp+5IywG1IaBIPvucke6nX8rRwN0i76g2x0mIPWuW5
 qAeA==
X-Gm-Message-State: AJcUukdHykA3zRef5SIlnEzk+2C329y0vN8go5PzO6k0Q9QRTmyWpRYS
 81Li4NII550yGODxNO4jXw6z/zVwByg=
X-Google-Smtp-Source: ALg8bN5OOSA0zA6oFz0xJW0Yh3uyHiMmN7+fpExgfuCn11Ih5sa9n/ORmbi4aec/L7waqULp6doFRw==
X-Received: by 2002:a2e:9b84:: with SMTP id
 z4-v6mr13263776lji.93.1547852713796; 
 Fri, 18 Jan 2019 15:05:13 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com.
 [209.85.167.47])
 by smtp.gmail.com with ESMTPSA id l21-v6sm937043lji.6.2019.01.18.15.05.11
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 15:05:12 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id y14so11635636lfg.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 15:05:11 -0800 (PST)
X-Received: by 2002:a19:1019:: with SMTP id f25mr13494513lfi.54.1547852711182; 
 Fri, 18 Jan 2019 15:05:11 -0800 (PST)
MIME-Version: 1.0
References: <1547843058-27933-1-git-send-email-jcrouse@codeaurora.org>
In-Reply-To: <1547843058-27933-1-git-send-email-jcrouse@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Fri, 18 Jan 2019 15:04:34 -0800
X-Gmail-Original-Message-ID: <CAE=gft6RWRkSZCOrKu=qqTerfmXRW5_kNt2NG4xdfxtTn6KxYA@mail.gmail.com>
Message-ID: <CAE=gft6RWRkSZCOrKu=qqTerfmXRW5_kNt2NG4xdfxtTn6KxYA@mail.gmail.com>
Subject: Re: [PATCH v6] drm/msm/a6xx: Add support for an interconnect path
To: Jordan Crouse <jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_150517_200024_1FC4597D 
X-CRM114-Status: GOOD (  22.21  )
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
Cc: LKML <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
 Jonathan Marek <jonathan@marek.ca>, David Airlie <airlied@linux.ie>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Sharat Masetty <smasetty@codeaurora.org>,
 Doug Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Clark <robdclark@gmail.com>,
 Mamta Shukla <mamtashukla555@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Andy Gross <andy.gross@linaro.org>, Colin Ian King <colin.king@canonical.com>,
 Stephen Boyd <swboyd@chromium.org>, freedreno@lists.freedesktop.org,
 Georgi Djakov <georgi.djakov@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 12:24 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Try to get the interconnect path for the GPU and vote for the maximum
> bandwidth to support all frequencies. This is needed for performance.
> Later we will want to scale the bandwidth based on the frequency to
> also optimize for power but that will require some device tree
> infrastructure that does not yet exist.
>
> v6: use icc_set_bw() instead of icc_set()
> v5: Remove hardcoded interconnect name and just use the default
> v4: Don't use a port string at all to skip the need for names in the DT
> v3: Use macros and change port string per Georgi Djakov
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>
>  drivers/gpu/drm/msm/Kconfig             |  1 +
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
>  drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
>  4 files changed, 33 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index cf549f1..78c9e5a5 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -5,6 +5,7 @@ config DRM_MSM
>         depends on ARCH_QCOM || SOC_IMX5 || (ARM && COMPILE_TEST)
>         depends on OF && COMMON_CLK
>         depends on MMU
> +       depends on INTERCONNECT || !INTERCONNECT
>         select QCOM_MDT_LOADER if ARCH_QCOM
>         select REGULATOR
>         select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 5beb83d..c48fe46 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2017-2018 The Linux Foundation. All rights reserved. */
>
>  #include <linux/clk.h>
> +#include <linux/interconnect.h>
>  #include <linux/pm_opp.h>
>  #include <soc/qcom/cmd-db.h>
>
> @@ -84,6 +85,9 @@ bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
>
>  static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
>  {
> +       struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
> +       struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> +       struct msm_gpu *gpu = &adreno_gpu->base;
>         int ret;
>
>         gmu_write(gmu, REG_A6XX_GMU_DCVS_ACK_OPTION, 0);
> @@ -106,6 +110,12 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
>                 dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
>
>         gmu->freq = gmu->gpu_freqs[index];
> +
> +       /*
> +        * Eventually we will want to scale the path vote with the frequency but
> +        * for now leave it at max so that the performance is nominal.
> +        */
> +       icc_set_bw(gpu->icc_path, 0, MBps_to_icc(7216));
>  }
>
>  void a6xx_gmu_set_freq(struct msm_gpu *gpu, unsigned long freq)
> @@ -705,6 +715,8 @@ int a6xx_gmu_reset(struct a6xx_gpu *a6xx_gpu)
>
>  int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
>  {
> +       struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> +       struct msm_gpu *gpu = &adreno_gpu->base;
>         struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
>         int status, ret;
>
> @@ -720,6 +732,9 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
>         if (ret)
>                 goto out;
>
> +       /* Set the bus quota to a reasonable value for boot */
> +       icc_set_bw(gpu->icc_path, 0, MBps_to_icc(3072));

Does the comment mention boot because this resume call happens during
init? How come this number is different from the one in
__a6xx_gmu_set_freq? Also, you're setting an average bandwidth of 0, I
guess you don't know really what your average is, and the hardware is
fine with that setting. Is that true?
-Evan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
