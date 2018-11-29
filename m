Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E299C43610
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:22:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A97120989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aHG4cgP4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L+A6W0Wp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kXYqICyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A97120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=1IJwt/1XtZ5XyCiWpNCbANglnstlovHwsjrVTrxiDhA=; b=aHG4cgP4L+UApWR140XbfEXYeK
	dDofS2HhmO59L8TZBdqts41isWaxszU2uYkVe7+da1ff15w9a7ygl2IW5sDGR9hGaODoqY7Hix0Vn
	UZEpNmLvcH5MR6JYqe3itn+DngjD+pUlAkqblG6MVSNred7DBhDbVEcizFdXjloSAUgRvGy4GPMGs
	OASyglIZyDZm1EP8zFAYzPurbDWOtmTn+LdfqjYhh8at6bEqL1zLirEo6P8tXWOGPMaiIe5MC24qb
	jmD2ooHEqJ1YneBHxu4QbcFoYjXVWtqCgS0fZ9pUkV97gJHwZu7h+O8yX9KEKIsBZLgDqdmQynyPo
	f3kVTFFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQ0j-0005CR-3q; Thu, 29 Nov 2018 17:21:57 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQ0T-0004r5-QA
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:21:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id EE3A761327; Thu, 29 Nov 2018 17:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543512091;
 bh=NFUgxHICUN5E14dYRFKcVoC/UBmWHlL+Dni+4jISyRo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L+A6W0WpHvh5GoTROx4IxanuGJ+be9XHlrBB87eKuqdrDSJQDgik9JZ/O2NcNKTrG
 mcimSwR/sn02sksdYSTj1wQ1HSv2bSm3mdLx/apnu9AZRwsrbmCXTCoGgStBFJ7Hdu
 C7vRzY2+k6zbk7Db6VKplG9ELjUarZv8J6Ot9zfA=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id C0C2561330;
 Thu, 29 Nov 2018 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543512089;
 bh=NFUgxHICUN5E14dYRFKcVoC/UBmWHlL+Dni+4jISyRo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kXYqICyo/Yaqt8vRtvDPz6lqw2C93Y0LJYmg2F87wvUDBICX/5NHx0XEQ3/CKWm5Q
 mB8flNpCCimFen0DSCXw4encqJrZaWyf+XAApL60s9rIE+6qFRRPPwilsPDnpgyhYE
 yssOoSdzHGdOy2CWVCqZ1/Py4xbMF9hXB30pchbI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0C2561330
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: georgi.djakov@linaro.org
Subject: [PATCH 1/1] drm/msm/a6xx: Add support for an interconnect path
Date: Thu, 29 Nov 2018 10:21:24 -0700
Message-Id: <20181129172124.6851-2-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181129172124.6851-1-jcrouse@codeaurora.org>
References: <20181129172124.6851-1-jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_092141_890241_1CD1F467 
X-CRM114-Status: GOOD (  18.00  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Try to get the interconnect path for the GPU and vote for the maximum
bandwidth to support all frequencies. This is needed for performance.
Later we will want to scale the bandwidth based on the frequency to
also optimize for power but that will require some device tree
infrastructure that does not yet exist.

v2: Absolute bandwidth values should be in KBps

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
 3 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 546599a7ab05..b96ae2ab04bb 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -3,6 +3,7 @@
 
 #include <linux/clk.h>
 #include <linux/pm_opp.h>
+#include <linux/interconnect.h>
 #include <soc/qcom/cmd-db.h>
 
 #include "a6xx_gpu.h"
@@ -63,6 +64,9 @@ static bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
 
 static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
 {
+	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
 	int ret;
 
 	gmu_write(gmu, REG_A6XX_GMU_DCVS_ACK_OPTION, 0);
@@ -85,6 +89,12 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
 		dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
 
 	gmu->freq = gmu->gpu_freqs[index];
+
+	/*
+	 * Eventually we will want to scale the path vote with the frequency but
+	 * for now leave it t at max so that the performance is nominal.
+	 */
+	icc_set(gpu->icc_path, 0, 7216000000);
 }
 
 void a6xx_gmu_set_freq(struct msm_gpu *gpu, unsigned long freq)
@@ -680,6 +690,8 @@ int a6xx_gmu_reset(struct a6xx_gpu *a6xx_gpu)
 
 int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 {
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	int status, ret;
 
@@ -695,6 +707,9 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 	if (ret)
 		goto out;
 
+	/* Set the bus quota to a reasonable value for boot */
+	icc_set(gpu->icc_path, 0, 3072000000);
+
 	a6xx_gmu_irq_enable(gmu);
 
 	/* Check to see if we are doing a cold or warm boot */
@@ -735,6 +750,8 @@ bool a6xx_gmu_isidle(struct a6xx_gmu *gmu)
 
 int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
 {
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	u32 val;
 
@@ -781,6 +798,9 @@ int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
 	/* Tell RPMh to power off the GPU */
 	a6xx_rpmh_stop(gmu);
 
+	/* Remove the bus vote */
+	icc_set(gpu->icc_path, 0, 0);
+
 	clk_bulk_disable_unprepare(gmu->nr_clocks, gmu->clocks);
 
 	pm_runtime_put_sync(gmu->dev);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 93d70f4a2154..9bab491912cf 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
+#include <linux/interconnect.h>
 #include "adreno_gpu.h"
 #include "msm_gem.h"
 #include "msm_mmu.h"
@@ -695,6 +696,11 @@ static int adreno_get_pwrlevels(struct device *dev,
 
 	DBG("fast_rate=%u, slow_rate=27000000", gpu->fast_rate);
 
+	/* Check for an interconnect path for the bus */
+	gpu->icc_path = of_icc_get(dev, "port0");
+	if (IS_ERR(gpu->icc_path))
+		gpu->icc_path = NULL;
+
 	return 0;
 }
 
@@ -733,10 +739,13 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
 {
+	struct msm_gpu *gpu = &adreno_gpu->base;
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(adreno_gpu->info->fw); i++)
 		release_firmware(adreno_gpu->fw[i]);
 
+	icc_put(gpu->icc_path);
+
 	msm_gpu_cleanup(&adreno_gpu->base);
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index f82bac086666..7b04d1665555 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -20,6 +20,7 @@
 
 #include <linux/clk.h>
 #include <linux/regulator/consumer.h>
+#include <linux/interconnect.h>
 
 #include "msm_drv.h"
 #include "msm_fence.h"
@@ -119,6 +120,8 @@ struct msm_gpu {
 	struct clk *ebi1_clk, *core_clk, *rbbmtimer_clk;
 	uint32_t fast_rate;
 
+	struct icc_path *icc_path;
+
 	/* Hang and Inactivity Detection:
 	 */
 #define DRM_MSM_INACTIVE_PERIOD   66 /* in ms (roughly four frames) */
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
