Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCE2C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:07:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB3E2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nOTKNyPw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ll6PJgso";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MH7B058Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB3E2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XbPO/VuUPVu/s0fS0IK+7vULMWfYE7calkNpDqALBfs=; b=nOTKNyPwwsr2su
	T60cxfAFsst4SF3bpDynlBmIqPtHdzDQO5jF/D12bK0vSeBrc4U0D4fKyzOtwz6rTnfQuggZm/dBU
	V9BmBrHMe835t4pPmAaQzH8dAsbxOuQZz9OG/o2gGrhUKbrTUUTYdKClhUCWA25tVumoZR3H9Ff1H
	RWv32lqxxicm8/eJO3M3zqx51k3M6GukJADasqv73tPkGiOMF68DLwSdcsFq8sbZDMLGPPV8AULSZ
	3jfqdY3PgzQfo4k+JXJWr59PoRq5ZPpgL4HROEQK5Rih0BhGRiz7W5k5QORumm4BFZW+zn42XPFtN
	uzoyKFHfTbg/u5T0b6sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKXC-00085o-Hm; Fri, 07 Dec 2018 18:07:30 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKX9-00085P-51
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:07:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 78CEF60241; Fri,  7 Dec 2018 18:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544206036;
 bh=d+8Sf8Rv3k6G6p3BPBrY23eY1qV/Qbm2/lu3L58d4zc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ll6PJgsoUxxFn3Rz8FYuuZ7Y6/+Uhsp6wzKlUNHCcJ5+D9wnGQebTuhxqosVRx+ub
 kZshu1quRi44hmVJ1VcmKJN1x0DQLBZghhwM64WcFLM295prXv+YZVMlBLvaZPFP7n
 LCP861gPt0zzu9si4qdDsRrcCHFkkWdm9FDIwRgo=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 93221606DD;
 Fri,  7 Dec 2018 18:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544206035;
 bh=d+8Sf8Rv3k6G6p3BPBrY23eY1qV/Qbm2/lu3L58d4zc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MH7B058Zca5YZo5vg3L7YwHSWyrcm82xcCmxOHBQbVB3IGkzmP/or88gYUkgC+fWZ
 zU+T1BW16E3LQswpKKBfUu/8y6Q3FJ+HA7+gDJOWp5m4f9vb/W/DOnlv3UcvCDfdQ3
 X+wikkjU766QhDBhZwHkaGIi3CJOdcIFY+FdE05g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93221606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Fri, 7 Dec 2018 11:07:12 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org, robdclark@gmail.com
Subject: Re: [Freedreno] [PATCH] drm/msm/a6xx: Add support for an
 interconnect path
Message-ID: <20181207180712.GC20602@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: freedreno@lists.freedesktop.org, robdclark@gmail.com,
 linux-arm-msm@vger.kernel.org, dianders@chromium.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 georgi.djakov@linaro.org, linux-arm-kernel@lists.infradead.org
References: <20181207170656.13208-1-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207170656.13208-1-jcrouse@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_100727_227914_3549CCFA 
X-CRM114-Status: GOOD (  28.09  )
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
Cc: linux-arm-msm@vger.kernel.org, dianders@chromium.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 georgi.djakov@linaro.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 10:06:56AM -0700, Jordan Crouse wrote:
> Try to get the interconnect path for the GPU and vote for the maximum
> bandwidth to support all frequencies. This is needed for performance.
> Later we will want to scale the bandwidth based on the frequency to
> also optimize for power but that will require some device tree
> infrastructure that does not yet exist.
> 
> v3: Use macros and change port string per Georgi Djakov

Rob had asked earlier if it would be appropriate and/or possible to merge this
with the generic interconnect patches and with his blessing I would like to
renew that request. This should merge cleanly against tip of tree and it would
be nice to get this support in at the same time that the base patches go in.

Jordan

> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/Kconfig             |  1 +
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
>  drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
>  4 files changed, 33 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index 843a9d40c05e..990c4350f0c4 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -5,6 +5,7 @@ config DRM_MSM
>  	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
>  	depends on OF && COMMON_CLK
>  	depends on MMU
> +	depends on INTERCONNECT || !INTERCONNECT
>  	select QCOM_MDT_LOADER if ARCH_QCOM
>  	select REGULATOR
>  	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 546599a7ab05..f37a9bfe5c30 100644
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
> @@ -63,6 +64,9 @@ static bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
>  
>  static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
>  {
> +	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
> +	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> +	struct msm_gpu *gpu = &adreno_gpu->base;
>  	int ret;
>  
>  	gmu_write(gmu, REG_A6XX_GMU_DCVS_ACK_OPTION, 0);
> @@ -85,6 +89,12 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
>  		dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
>  
>  	gmu->freq = gmu->gpu_freqs[index];
> +
> +	/*
> +	 * Eventually we will want to scale the path vote with the frequency but
> +	 * for now leave it at max so that the performance is nominal.
> +	 */
> +	icc_set(gpu->icc_path, 0, MBps_to_icc(7216));
>  }
>  
>  void a6xx_gmu_set_freq(struct msm_gpu *gpu, unsigned long freq)
> @@ -680,6 +690,8 @@ int a6xx_gmu_reset(struct a6xx_gpu *a6xx_gpu)
>  
>  int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
>  {
> +	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> +	struct msm_gpu *gpu = &adreno_gpu->base;
>  	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
>  	int status, ret;
>  
> @@ -695,6 +707,9 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
>  	if (ret)
>  		goto out;
>  
> +	/* Set the bus quota to a reasonable value for boot */
> +	icc_set(gpu->icc_path, 0, MBps_to_icc(3072));
> +
>  	a6xx_gmu_irq_enable(gmu);
>  
>  	/* Check to see if we are doing a cold or warm boot */
> @@ -735,6 +750,8 @@ bool a6xx_gmu_isidle(struct a6xx_gmu *gmu)
>  
>  int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
>  {
> +	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> +	struct msm_gpu *gpu = &adreno_gpu->base;
>  	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
>  	u32 val;
>  
> @@ -781,6 +798,9 @@ int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
>  	/* Tell RPMh to power off the GPU */
>  	a6xx_rpmh_stop(gmu);
>  
> +	/* Remove the bus vote */
> +	icc_set(gpu->icc_path, 0, 0);
> +
>  	clk_bulk_disable_unprepare(gmu->nr_clocks, gmu->clocks);
>  
>  	pm_runtime_put_sync(gmu->dev);
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 93d70f4a2154..7403ade9aabc 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -18,6 +18,7 @@
>   */
>  
>  #include <linux/ascii85.h>
> +#include <linux/interconnect.h>
>  #include <linux/kernel.h>
>  #include <linux/pm_opp.h>
>  #include <linux/slab.h>
> @@ -695,6 +696,11 @@ static int adreno_get_pwrlevels(struct device *dev,
>  
>  	DBG("fast_rate=%u, slow_rate=27000000", gpu->fast_rate);
>  
> +	/* Check for an interconnect path for the bus */
> +	gpu->icc_path = of_icc_get(dev, "gfx-mem");
> +	if (IS_ERR(gpu->icc_path))
> +		gpu->icc_path = NULL;
> +
>  	return 0;
>  }
>  
> @@ -733,10 +739,13 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>  
>  void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
>  {
> +	struct msm_gpu *gpu = &adreno_gpu->base;
>  	unsigned int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(adreno_gpu->info->fw); i++)
>  		release_firmware(adreno_gpu->fw[i]);
>  
> +	icc_put(gpu->icc_path);
> +
>  	msm_gpu_cleanup(&adreno_gpu->base);
>  }
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index f82bac086666..12fc5b1cb39d 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -19,6 +19,7 @@
>  #define __MSM_GPU_H__
>  
>  #include <linux/clk.h>
> +#include <linux/interconnect.h>
>  #include <linux/regulator/consumer.h>
>  
>  #include "msm_drv.h"
> @@ -119,6 +120,8 @@ struct msm_gpu {
>  	struct clk *ebi1_clk, *core_clk, *rbbmtimer_clk;
>  	uint32_t fast_rate;
>  
> +	struct icc_path *icc_path;
> +
>  	/* Hang and Inactivity Detection:
>  	 */
>  #define DRM_MSM_INACTIVE_PERIOD   66 /* in ms (roughly four frames) */
> -- 
> 2.18.0
> 
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
