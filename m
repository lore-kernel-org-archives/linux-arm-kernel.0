Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB1AC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:36:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF4E20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KMQ6Rau7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knjiomJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF4E20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=KdF2CT8V+vCu0jKbNpm3xfpmYt10wAgBjFOB4z1R9vc=; b=KMQ6Rau7pHKx/wau9fSHcvafP/
	w4/zi1WLLe5hZ9je/lXnLX98C9BOeTx3nOQTXbDrB6CljkO34Bn2f0+rE8YMyGbC5M1Izg29uteWa
	omwidlGq5ObNIrCjcNI3ReROcGf28FzOUIDW/cfOK1jzPTX24PFcfaztc/EEhlsRBmmDIFkBs6nP4
	ghxWEqQVYOr8FPQT16jsNAnWEyCy4sbqZEo+ZVeKdQWc0Tvc8BtfrLF+KTxoYIDyvH3/+ul+w+T0M
	+Q0aXjag5n10reIZxyb7HWw8zxJV8teXH50cQ8gk4qu2fZHfDSHILkmSvk7XNnSzz8HYKRL5Iv5+p
	Hp72zs2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVLuq-0007Ac-MK; Fri, 07 Dec 2018 19:36:00 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVLum-00077G-7C
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 19:35:58 +0000
Received: by mail-it1-x143.google.com with SMTP id p197so8838382itp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 11:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=beCD05nZWbeYcBnFZ9Uyu0lGvx1BqGCDThwyEpjQx8U=;
 b=knjiomJ4UMkK/3PkMMhE0rThQ0KFk7Get+MJaa9SNAav1DySr8p/NfohU5xq+0a86o
 V/eMbIpwM/c+Kn0U5HBv559ZKcO+dSv9LpVz8NyyGWWn6wMaY2ICOuIkKqCpepFrS+ya
 QFWJST1mR3IPQVswcZi2H7oS7iKIB/9UYj7ryXUGbghIcmxijO9VcZ7yCxVrEbcSVgB0
 7n79/bAxUjgGuJDv3eQEox3yKShBahJk4xhGyjI/sI6+rl2yv/k4xtU2px/NpDW919YU
 elELuSQWL0ppS5/9GAovO2YaOGdrTQrbGA7TfWHhWwSi+DAsAAsyHWR/mfRnrbdeg1KI
 OClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=beCD05nZWbeYcBnFZ9Uyu0lGvx1BqGCDThwyEpjQx8U=;
 b=c9YMsWcBUJ2EST80Nx9U52xFvVTHadbej2a7qM3ZnMrlVrKXNW2YGpfogTthfrnUwO
 oWMZF2zcf2LuvDbPHO1Ae40OREETAZDy7iqKDgqEkaYj9FjKgDdnWgp4UofEBu8GhEtL
 Nc1ETYBC/N6bD2nKWdoN1XGnETd5vpx0W2WUX5Anb3TGg1CbonebjbF9o3aS9v2s6FQV
 c+ZIJDn91k5aYhlE6/KqTuYbA0UyW9qYMoUFlsVn5FUs/UkJLR4TIs0RJ9wbuSZrI0/R
 mFNwJGYm9g0XmVhL+qNDclmAhDp10ygqPFH0UV9gMvOTV7snMCUghNMKokMxorEO7vFG
 2tLw==
X-Gm-Message-State: AA+aEWYW/4ZKenknxUsyX9v/9sxvu3S6qdfuSI9I3Fupv8EyMjRMWQZr
 2Bes0cYnnAJQUg2ecp7FyHvZtI4iERxvgroLjdE=
X-Google-Smtp-Source: AFSGD/URPAkPenSJKLIphnjqmSWE3o2fwnXC6XSgdJGvbOf/8HQ1LdEUsdcK+h9H3jPWX+KxgZKmpwNHLhllSau0N4I=
X-Received: by 2002:a02:3da:: with SMTP id e87mr2737637jae.78.1544211344235;
 Fri, 07 Dec 2018 11:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20181207170656.13208-1-jcrouse@codeaurora.org>
 <20181207180712.GC20602@jcrouse-lnx.qualcomm.com>
In-Reply-To: <20181207180712.GC20602@jcrouse-lnx.qualcomm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 7 Dec 2018 14:35:32 -0500
Message-ID: <CAF6AEGvRQ9h4b8329oddaJZQeK4+P3xZb-LXwAvKAHfSWBBoDQ@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH] drm/msm/a6xx: Add support for an interconnect
 path
To: freedreno <freedreno@lists.freedesktop.org>, 
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Douglas Anderson <dianders@chromium.org>, 
 dri-devel <dri-devel@lists.freedesktop.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Georgi Djakov <georgi.djakov@linaro.org>, 
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_113556_265365_70CD3330 
X-CRM114-Status: GOOD (  28.58  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 7, 2018 at 1:07 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> On Fri, Dec 07, 2018 at 10:06:56AM -0700, Jordan Crouse wrote:
> > Try to get the interconnect path for the GPU and vote for the maximum
> > bandwidth to support all frequencies. This is needed for performance.
> > Later we will want to scale the bandwidth based on the frequency to
> > also optimize for power but that will require some device tree
> > infrastructure that does not yet exist.
> >
> > v3: Use macros and change port string per Georgi Djakov
>
> Rob had asked earlier if it would be appropriate and/or possible to merge this
> with the generic interconnect patches and with his blessing I would like to
> renew that request. This should merge cleanly against tip of tree and it would
> be nice to get this support in at the same time that the base patches go in.
>

Acked-by: Rob Clark <robdclark@gmail.com>

for landing this via Georgi's tree.. that seems easier than having to
do a 2nd late pull-req for drm to get the driver parts merged..

BR,
-R


> Jordan
>
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> >  drivers/gpu/drm/msm/Kconfig             |  1 +
> >  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
> >  drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
> >  4 files changed, 33 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> > index 843a9d40c05e..990c4350f0c4 100644
> > --- a/drivers/gpu/drm/msm/Kconfig
> > +++ b/drivers/gpu/drm/msm/Kconfig
> > @@ -5,6 +5,7 @@ config DRM_MSM
> >       depends on ARCH_QCOM || (ARM && COMPILE_TEST)
> >       depends on OF && COMMON_CLK
> >       depends on MMU
> > +     depends on INTERCONNECT || !INTERCONNECT
> >       select QCOM_MDT_LOADER if ARCH_QCOM
> >       select REGULATOR
> >       select DRM_KMS_HELPER
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > index 546599a7ab05..f37a9bfe5c30 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > @@ -2,6 +2,7 @@
> >  /* Copyright (c) 2017-2018 The Linux Foundation. All rights reserved. */
> >
> >  #include <linux/clk.h>
> > +#include <linux/interconnect.h>
> >  #include <linux/pm_opp.h>
> >  #include <soc/qcom/cmd-db.h>
> >
> > @@ -63,6 +64,9 @@ static bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
> >
> >  static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
> >  {
> > +     struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
> > +     struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> > +     struct msm_gpu *gpu = &adreno_gpu->base;
> >       int ret;
> >
> >       gmu_write(gmu, REG_A6XX_GMU_DCVS_ACK_OPTION, 0);
> > @@ -85,6 +89,12 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
> >               dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
> >
> >       gmu->freq = gmu->gpu_freqs[index];
> > +
> > +     /*
> > +      * Eventually we will want to scale the path vote with the frequency but
> > +      * for now leave it at max so that the performance is nominal.
> > +      */
> > +     icc_set(gpu->icc_path, 0, MBps_to_icc(7216));
> >  }
> >
> >  void a6xx_gmu_set_freq(struct msm_gpu *gpu, unsigned long freq)
> > @@ -680,6 +690,8 @@ int a6xx_gmu_reset(struct a6xx_gpu *a6xx_gpu)
> >
> >  int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
> >  {
> > +     struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> > +     struct msm_gpu *gpu = &adreno_gpu->base;
> >       struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
> >       int status, ret;
> >
> > @@ -695,6 +707,9 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
> >       if (ret)
> >               goto out;
> >
> > +     /* Set the bus quota to a reasonable value for boot */
> > +     icc_set(gpu->icc_path, 0, MBps_to_icc(3072));
> > +
> >       a6xx_gmu_irq_enable(gmu);
> >
> >       /* Check to see if we are doing a cold or warm boot */
> > @@ -735,6 +750,8 @@ bool a6xx_gmu_isidle(struct a6xx_gmu *gmu)
> >
> >  int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
> >  {
> > +     struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> > +     struct msm_gpu *gpu = &adreno_gpu->base;
> >       struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
> >       u32 val;
> >
> > @@ -781,6 +798,9 @@ int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
> >       /* Tell RPMh to power off the GPU */
> >       a6xx_rpmh_stop(gmu);
> >
> > +     /* Remove the bus vote */
> > +     icc_set(gpu->icc_path, 0, 0);
> > +
> >       clk_bulk_disable_unprepare(gmu->nr_clocks, gmu->clocks);
> >
> >       pm_runtime_put_sync(gmu->dev);
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > index 93d70f4a2154..7403ade9aabc 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > @@ -18,6 +18,7 @@
> >   */
> >
> >  #include <linux/ascii85.h>
> > +#include <linux/interconnect.h>
> >  #include <linux/kernel.h>
> >  #include <linux/pm_opp.h>
> >  #include <linux/slab.h>
> > @@ -695,6 +696,11 @@ static int adreno_get_pwrlevels(struct device *dev,
> >
> >       DBG("fast_rate=%u, slow_rate=27000000", gpu->fast_rate);
> >
> > +     /* Check for an interconnect path for the bus */
> > +     gpu->icc_path = of_icc_get(dev, "gfx-mem");
> > +     if (IS_ERR(gpu->icc_path))
> > +             gpu->icc_path = NULL;
> > +
> >       return 0;
> >  }
> >
> > @@ -733,10 +739,13 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
> >
> >  void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
> >  {
> > +     struct msm_gpu *gpu = &adreno_gpu->base;
> >       unsigned int i;
> >
> >       for (i = 0; i < ARRAY_SIZE(adreno_gpu->info->fw); i++)
> >               release_firmware(adreno_gpu->fw[i]);
> >
> > +     icc_put(gpu->icc_path);
> > +
> >       msm_gpu_cleanup(&adreno_gpu->base);
> >  }
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> > index f82bac086666..12fc5b1cb39d 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.h
> > +++ b/drivers/gpu/drm/msm/msm_gpu.h
> > @@ -19,6 +19,7 @@
> >  #define __MSM_GPU_H__
> >
> >  #include <linux/clk.h>
> > +#include <linux/interconnect.h>
> >  #include <linux/regulator/consumer.h>
> >
> >  #include "msm_drv.h"
> > @@ -119,6 +120,8 @@ struct msm_gpu {
> >       struct clk *ebi1_clk, *core_clk, *rbbmtimer_clk;
> >       uint32_t fast_rate;
> >
> > +     struct icc_path *icc_path;
> > +
> >       /* Hang and Inactivity Detection:
> >        */
> >  #define DRM_MSM_INACTIVE_PERIOD   66 /* in ms (roughly four frames) */
> > --
> > 2.18.0
> >
> > _______________________________________________
> > Freedreno mailing list
> > Freedreno@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/freedreno
>
> --
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
