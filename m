Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C36C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:07:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308682082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gqkn6qci";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gCh8xvlV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fSCus484"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308682082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=UFDMA7SzIJnNqBWvKTnmhUrpRtqkjPpHIWWpD9ZFMjc=; b=Gqk
	n6qciT2VAI6eoh/IHxJWMSPhUTo/BhplXyvzIsMIiGb8GbdK2Ys43zM4A6moLfuqbNoMxsXhOI1H8
	pn0NnRQTUU0IkkjA3z/ldRiTw6BCUglBxHtnkLTpIi7dJvXTG/c5GWccZmV7Ust/KFFHhoyXQsGFT
	2MK0VzC04EbDh9A76aAhqYhLtIagACfNhjTjmY0W5PJDmgR2K9bB73CXfbA84LfqxibNBtyRJHpjQ
	ILmahDO26r9OK5NHeI+HrOA/HE3jd6gtR1F3RH6rFL5a4lV+xKTKtPwlE5peBZEki8NO2SvNxZ+SE
	WNsWTHteHa+IZ56P+PTsLxBYJLdcFBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVJau-0007Sx-Eo; Fri, 07 Dec 2018 17:07:16 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVJap-0007Ra-Af
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 17:07:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 196F7601D7; Fri,  7 Dec 2018 17:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544202420;
 bh=ctGa3E2FImQ/l5c/QYJfD6LwEaRRe8nR8VQJ3p8Aesw=;
 h=From:To:Cc:Subject:Date:From;
 b=gCh8xvlVRClxKD2Exvcr44dLMyr3BkVbbYE+OIEwFUUClcMyd6XGOVPNfA4pdEpr8
 QYt36hl7G1DMFvnznfXb+zNm4QPxHRbh7ThEI3hfHQXjw3hYm2ypMa0A4m//Sr6sEW
 W3V6Yfidnhqz+AFqj0MDxr4X3SQIKyr5WF3wdUE4=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id E640D6063A;
 Fri,  7 Dec 2018 17:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544202419;
 bh=ctGa3E2FImQ/l5c/QYJfD6LwEaRRe8nR8VQJ3p8Aesw=;
 h=From:To:Cc:Subject:Date:From;
 b=fSCus484AruRjOiHKSQeQHP3SC5u8vl5USGgnultqGJ2wu1Bc9MGGfobc2/3krPhQ
 Kkf/r1puGUEIzfbDUr2HBsmQryIfBYvLOzf9MDt7iIvgbvvVntHO0FMobrTuLX/wAz
 EO6SIUZAJzZl0Y0YMNWYXsopOc4dnOJEKHACIRnM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E640D6063A
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org
Subject: [PATCH] drm/msm/a6xx: Add support for an interconnect path
Date: Fri,  7 Dec 2018 10:06:56 -0700
Message-Id: <20181207170656.13208-1-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_090711_403983_C30C95B8 
X-CRM114-Status: GOOD (  18.21  )
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

v3: Use macros and change port string per Georgi Djakov

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/gpu/drm/msm/Kconfig             |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
 4 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index 843a9d40c05e..990c4350f0c4 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -5,6 +5,7 @@ config DRM_MSM
 	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
 	depends on OF && COMMON_CLK
 	depends on MMU
+	depends on INTERCONNECT || !INTERCONNECT
 	select QCOM_MDT_LOADER if ARCH_QCOM
 	select REGULATOR
 	select DRM_KMS_HELPER
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 546599a7ab05..f37a9bfe5c30 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2017-2018 The Linux Foundation. All rights reserved. */
 
 #include <linux/clk.h>
+#include <linux/interconnect.h>
 #include <linux/pm_opp.h>
 #include <soc/qcom/cmd-db.h>
 
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
+	 * for now leave it at max so that the performance is nominal.
+	 */
+	icc_set(gpu->icc_path, 0, MBps_to_icc(7216));
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
+	icc_set(gpu->icc_path, 0, MBps_to_icc(3072));
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
index 93d70f4a2154..7403ade9aabc 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/ascii85.h>
+#include <linux/interconnect.h>
 #include <linux/kernel.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
@@ -695,6 +696,11 @@ static int adreno_get_pwrlevels(struct device *dev,
 
 	DBG("fast_rate=%u, slow_rate=27000000", gpu->fast_rate);
 
+	/* Check for an interconnect path for the bus */
+	gpu->icc_path = of_icc_get(dev, "gfx-mem");
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
index f82bac086666..12fc5b1cb39d 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -19,6 +19,7 @@
 #define __MSM_GPU_H__
 
 #include <linux/clk.h>
+#include <linux/interconnect.h>
 #include <linux/regulator/consumer.h>
 
 #include "msm_drv.h"
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
