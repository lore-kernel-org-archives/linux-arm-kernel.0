Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AA5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:33:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0347D218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L4VZHuzx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="btSkN4oA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bIfktvCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0347D218A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=rkv3XwhJloUvAWovfHAqSrjfe/jPGaOlZaU817VdErQ=; b=L4VZHuzx8GdE6AwwVOV5dg3ifb
	lia+r09es7ObMf9VjCpqWVb1PUTOLRIofE+A6BAncKwwUX86tzs9GIivwJYovkpkecE4sE15+D6UE
	tw9MnXQkeu96flcAePivnWusN3R8DQHLro8rCToJdEgYGUSg1TomDMh5PllPFb7xwmdCtFbN9FP7j
	2UmiV/d7JskKKJsWtkRad3eHl9rAkj+n0/gAGHV3e6gRkvENWGyLzt3TkceSWaZiShzXENCs7ZCIt
	CBnH6oEwLefzWTqsRbTYaYwSVFLVcwzfRPPRZ4q1ieNXuX9P/Llf06S4M5s75D/RTM3HpWSpE4ux+
	E2PbSccg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZKBW-00007t-Ka; Tue, 18 Dec 2018 18:33:38 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZKAr-0007z0-9q
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 18:33:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 55F0E60915; Tue, 18 Dec 2018 18:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545157968;
 bh=IKifwKjkPGN+iMabdaykxzQB6k0XEHLfxMrwblThn4k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=btSkN4oAdgvwCTaAnHAuQOBQzQt/aMfayaat76dwtpEf7GIQ37YEKSC2aYUjMG65h
 tSAUm2Z1eSuXELlNQjKZ1jO+Q6IPeXf3jtnZQMqWwH2ksUAkXnaiNp/mQUVZpK3oH6
 bj9Ba7SijH+1BZVjH37vuhBRiyBar/kMv2HfRCqk=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B3F860593;
 Tue, 18 Dec 2018 18:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545157967;
 bh=IKifwKjkPGN+iMabdaykxzQB6k0XEHLfxMrwblThn4k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bIfktvCarwzGz4GclRgWBxdPJUprKRYOtAuyivu2dDtxx55B3x4HERwEhqbah0XnH
 IGolUJcpIYSGBsZPVPIBAvmVe4jzP8Mp/VUDOXKCA0kfYX4iEob5OIiz3vB216cJS/
 4afuPiE8ANyL8XE3ufmVmCm7UF0+8zeQ57Cr6h00=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B3F860593
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v7 1/6] drm/msm/gpu: Remove hardcoded interrupt name
Date: Tue, 18 Dec 2018 11:32:36 -0700
Message-Id: <20181218183241.12830-2-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181218183241.12830-1-jcrouse@codeaurora.org>
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_103257_395112_696602E9 
X-CRM114-Status: GOOD (  12.55  )
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
Cc: nm@ti.com, devicetree@vger.kernel.org, rnayak@codeaurora.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, dianders@chromium.org,
 vireshk@kernel.org, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Every GPU core only has one interrupt so there isn't any
value in looking up the interrupt by name. Remove the name (which
is legacy anyway) and use platform_get_irq() instead.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 1 -
 drivers/gpu/drm/msm/msm_gpu.c           | 2 +-
 drivers/gpu/drm/msm/msm_gpu.h           | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 93d70f4a2154..bfeea50fca8a 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -713,7 +713,6 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	adreno_gpu->rev = config->rev;
 
 	adreno_gpu_config.ioname = "kgsl_3d0_reg_memory";
-	adreno_gpu_config.irqname = "kgsl_3d0_irq";
 
 	adreno_gpu_config.va_start = SZ_16M;
 	adreno_gpu_config.va_end = 0xffffffff;
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 11aac8337066..f9de09d14344 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -868,7 +868,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	}
 
 	/* Get Interrupt: */
-	gpu->irq = platform_get_irq_byname(pdev, config->irqname);
+	gpu->irq = platform_get_irq(pdev, 0);
 	if (gpu->irq < 0) {
 		ret = gpu->irq;
 		dev_err(drm->dev, "failed to get irq: %d\n", ret);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index f82bac086666..fc4040e24a6b 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -31,7 +31,6 @@ struct msm_gpu_state;
 
 struct msm_gpu_config {
 	const char *ioname;
-	const char *irqname;
 	uint64_t va_start;
 	uint64_t va_end;
 	unsigned int nr_rings;
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
