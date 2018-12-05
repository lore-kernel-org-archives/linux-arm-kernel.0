Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7388C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:51:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 771DB2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cYQI0WM2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ktM8Wipb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771DB2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ix0BBUhuuLCBxv0Bih58iVuYeOtg2j51jrLA94XZdvQ=; b=cYQI0WM2//fWos
	BpX1QReKPHTk+GLssXUfBbMahaahqW0+9mKjwRSNU3gPwPmUsGP4TgC5cy2mV4hQnJ8YXjSnDHEzZ
	Yq21np0bLyE5A3/YYXiZoh95UYUanc4WNLDI7y3Gd//Y7OEVVQ/4k0B/p/D8EL3Pzg4UtI58J3eoS
	UHyz9dfmosSvt9kVM3/EHdfnh6GIz5K+PaQtNFPeLdahp51sVJdfp3VhRlCBMDanFwfuaAMV2NoqN
	h9DSqfFzRtWj1kfPMObLkQQ1NUFfxOSIvl8gCYRU9g076U1UzMPjJkId1mUT1hhhXrBXOT60oHJOf
	xVNnlNtupuTtAMQ+39Fg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUaOM-00065X-0l; Wed, 05 Dec 2018 16:51:18 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUaOI-0005ss-HB
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 16:51:16 +0000
Received: by mail-wm1-x343.google.com with SMTP id y185so12197281wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 08:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=X3usTYZfXX3aofxjmqxFblGcRfhazquZXhm963dbMrs=;
 b=ktM8WipbQJl5wlH6V7gNIKev6w46mkvOWrxj91dyiMYUB4dETwsvrxy04ao4wSbYW3
 2ZkmCSi4RWucBWMbiy7/SYaHqa0GkDUUKBfIKavXIzDVN20DFrsGrtsoafj9gKll0VkB
 TyFumMtKKRbsl+ZOCuOanK1ab/KzjLGIRug24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X3usTYZfXX3aofxjmqxFblGcRfhazquZXhm963dbMrs=;
 b=gsnZjA1YB21nK8gz2zy7NtINCDN3K9dvMIBmc/wE6SlBrqfStl/WsCTQUkCpVv28kc
 q7GhUCf13q7ub4goyoAebJ3WKtFe56tEL3LDtgroaYfH0K0iM7s/Xl7NwlUPH5L8jD69
 OoTOUo6mxPxhb4xX2Ho7xj4Fani/ZTWFe5YxjU+j49DSXYP5xcY/Uc3zikBqYuI0O6kw
 MK8cL1gsrJ5NY9e5QJCTQx0KH8Jt9Tpn/axdaR5tYzDZeSAi5Lgbl3AXVQqbYqw3c+av
 4CdS4qtNWDV5e/IAgU0uUs/GIdlT2Y7U8Q5gLgcUHqj2oHUT1t1HfornW1KvPCLNab9/
 NZEw==
X-Gm-Message-State: AA+aEWaREGkhvECDTOm2eMvcXUYCssYSGt6VvuykHfH5rOFmHo3gFB2/
 evgU3Q44oZEAXGS8QY+JaqeEPA==
X-Google-Smtp-Source: AFSGD/UJpdQWHApOQuYpYGrVCW0xR1hvPGGJAkmDJUtns3fWcIK6SSm+V55y9VwpD1upHmbJsc8qFg==
X-Received: by 2002:a1c:a183:: with SMTP id k125mr16037876wme.25.1544028661746; 
 Wed, 05 Dec 2018 08:51:01 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
 by smtp.googlemail.com with ESMTPSA id z8sm18922728wrr.52.2018.12.05.08.51.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 08:51:01 -0800 (PST)
Subject: Re: [PATCH 1/1] drm/msm/a6xx: Add support for an interconnect path
To: Jordan Crouse <jcrouse@codeaurora.org>
References: <20181129172636.12839-1-jcrouse@codeaurora.org>
 <20181129172636.12839-2-jcrouse@codeaurora.org>
From: Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <915ddc93-5cc1-e648-8862-afefde2bd225@linaro.org>
Date: Wed, 5 Dec 2018 18:51:00 +0200
MIME-Version: 1.0
In-Reply-To: <20181129172636.12839-2-jcrouse@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_085114_578409_392FFC50 
X-CRM114-Status: GOOD (  28.79  )
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
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jordan,

Thanks for the patch!

On 11/29/18 19:26, Jordan Crouse wrote:
> Try to get the interconnect path for the GPU and vote for the maximum
> bandwidth to support all frequencies. This is needed for performance.
> Later we will want to scale the bandwidth based on the frequency to
> also optimize for power but that will require some device tree
> infrastructure that does not yet exist.
> 
> v3: Absolute bandwidth values should be specified in KBps

btw. now i have also included macros in the header, that can be used to
specify the bandwidth units. So now you can now use kBps_to_icc or
MBps_to_icc etc. If we decide at some point that we change the units we
use internally, we will not have update all the users.

> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
>  drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 546599a7ab05..fe0f5b10fd9c 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -3,6 +3,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/pm_opp.h>
> +#include <linux/interconnect.h>
>  #include <soc/qcom/cmd-db.h>

Alphabetic order maybe?

>  #include "a6xx_gpu.h"
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
> +	 * for now leave it t at max so that the performance is nominal.

An extra t above.

> +	 */
> +	icc_set(gpu->icc_path, 0, 7216000);
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
> +	icc_set(gpu->icc_path, 0, 3072000);

Here you can do:
	icc_set(gpu->icc_path, 0, MBps_to_icc(3072));

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
> index 93d70f4a2154..9bab491912cf 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -21,6 +21,7 @@
>  #include <linux/kernel.h>
>  #include <linux/pm_opp.h>
>  #include <linux/slab.h>
> +#include <linux/interconnect.h>

Alphabetic order?

>  #include "adreno_gpu.h"
>  #include "msm_gem.h"
>  #include "msm_mmu.h"
> @@ -695,6 +696,11 @@ static int adreno_get_pwrlevels(struct device *dev,
>  
>  	DBG("fast_rate=%u, slow_rate=27000000", gpu->fast_rate);
>  
> +	/* Check for an interconnect path for the bus */
> +	gpu->icc_path = of_icc_get(dev, "port0");

I was wondering if port0 is appropriate name here. I assume this is the
port to DDR. Maybe we could name it gfx-mem or gpu-mem. Are there any
other interconnects that need to be scaled on the a6xx?

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
> index f82bac086666..7b04d1665555 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -20,6 +20,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/interconnect.h>

Alphabetic order?

>  
>  #include "msm_drv.h"
>  #include "msm_fence.h"
> @@ -119,6 +120,8 @@ struct msm_gpu {
>  	struct clk *ebi1_clk, *core_clk, *rbbmtimer_clk;
>  	uint32_t fast_rate;
>  
> +	struct icc_path *icc_path;
> +
>  	/* Hang and Inactivity Detection:
>  	 */
>  #define DRM_MSM_INACTIVE_PERIOD   66 /* in ms (roughly four frames) */

Can this driver be a module or is always built-in? If it is built-in and
the interconnect support is a module we will have a problem. Maybe add
something like this in the Kconfig:
	depends on INTERCONNECT || !INTERCONNECT

Thanks,
Georgi

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
