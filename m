Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7766C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:06:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79ACC20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="re0MduWp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CU1pgPwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79ACC20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=ZNhfjxCe3+0lOza+4GUvXzJCQvBOENbA5iqEouSBDDo=; b=re0
	MduWpvXa4I3O4BwEFzvHFeKs6Kld+YyhvnKmB98XjPX5KfrFBpCeMQWN7kQJMjpKCFxMAc1wRIYt+
	OP9Ef2IKv4SoIndmaKmceelOTIRhFcJ8WhNKnLO3pv7jmPWV5OlIXhapVZzcMW21AGt0WSwMN16dw
	g21AyYkky3DXk30u16AbRkfJtrIYsV7izsVXApJ6JcbUzM6JAUrqUsNG8hGCa1HMYH0LNuqCpc4Aq
	uf1n9gEin9wAN+uuuDqnN3H5YLXxM7x5F40JhUSeid/LJ4mA/wrdGby6ZPy4S1fG4e9KqoHs91Jlp
	JUkPP/R4pa3rjxzvhpOhBTu1zUMfxMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glWTO-0007yt-Ez; Mon, 21 Jan 2019 10:06:30 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glWTH-0007y9-OK
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 10:06:28 +0000
Received: by mail-wr1-x441.google.com with SMTP id s12so22581833wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 02:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=ywAKA7XPaADxrBcsFMk+tbkoWLax4ZTEel24lBBuNN4=;
 b=CU1pgPwdJuBHiqIkLzqPe3O5BRFdhqNL8zM5PR0fDMSAOkMednRyPq5b/5Amwrhp36
 Iqe5iuZo6CAn77BXugWM0s5p2Y9tSZQkKVc1ZRQgxL0T93Puxwf3XPkYJ3bHbNa/DBDE
 oEotYZRM4hs6LvE56qEz3YWK0QqqswLR1+wYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ywAKA7XPaADxrBcsFMk+tbkoWLax4ZTEel24lBBuNN4=;
 b=VJZEG+TA2TQlVZFO0R7M+0N6GsSyezm/p/Ha+pVcxEPFj7CgReoJ4sX/EfV2pRmQlo
 N3HvT6XEX5e0BVaf7Ujs2IYH3mUDxyxLE4QvlOn/cAUK3qTbxZsV6IerwTXlzXj/g9vC
 kcitQr+RMdAoNOm1sr7mUmcCddjJFWu7zSMhzxM6RM1waDrgg0iLunQXwtFTTU6k2lLm
 lFAzqZZHpmototCyGAZcS4nF9BLw+fNigwLBWoUayBY0xTXRej7Mkle2Zvvi5j5YRzrm
 DnR99I4ZIE47PVuO1qp+YbKffICT8nnF6TpHHvW+SVAC/Tc0azN0CzI8LdNF+QN8d0FH
 JY7A==
X-Gm-Message-State: AJcUukfo7+OmNaYNN3OR5hlToTracUws5aTFTptbrJSQ3FtQWQaeomOh
 LG59HcUDCdpcEYVgJ1wgCe1HH2EVYdjdpg==
X-Google-Smtp-Source: ALg8bN4T35PTJmcoWBiZz43SdGIQsaQWsyH81wjzgvRlM2FU6AmVs9duzGMsQsXUR8oVF8GpbavgMw==
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr29375533wrw.50.1548065181082; 
 Mon, 21 Jan 2019 02:06:21 -0800 (PST)
Received: from dogfood.home ([2a01:cb1d:112:6f00:789e:cc70:7004:686b])
 by smtp.gmail.com with ESMTPSA id f22sm4541857wmj.26.2019.01.21.02.06.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jan 2019 02:06:20 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH] drm: disable WC optimization for cache coherent devices
 on non-x86
Date: Mon, 21 Jan 2019 11:06:17 +0100
Message-Id: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_020623_827240_C0342346 
X-CRM114-Status: GOOD (  16.71  )
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
Cc: Will Deacon <will.deacon@arm.com>, David Zhou <David1.Zhou@amd.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Michel Daenzer <michel.daenzer@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Junwei Zhang <Jerry.Zhang@amd.com>,
 Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Michael Ellerman <mpe@ellerman.id.au>,
 Alex Deucher <alexander.deucher@amd.com>, Sean Paul <sean@poorly.run>,
 Christian Koenig <christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently, the DRM code assumes that PCI devices are always cache
coherent for DMA, and that this can be selectively overridden for
some buffers using non-cached mappings on the CPU side and PCIe
NoSnoop transactions on the bus side.

Whether the NoSnoop part is implemented correctly is highly platform
specific. Whether it /matters/ if NoSnoop is implemented correctly or
not is architecture specific: on x86, such transactions are coherent
with the CPU whether the NoSnoop attribute is honored or not. On other
architectures, it depends on whether such transactions may allocate in
caches that are non-coherent with the CPU's uncached mappings.

Bottom line is that we should not rely on this optimization to work
correctly for cache coherent devices in the general case. On the
other hand, disabling this optimization for non-coherent devices
is likely to cause breakage as well, since the driver will assume
cache coherent PCIe if this optimization is turned off.

So rename drm_arch_can_wc_memory() to drm_device_can_wc_memory(), and
pass the drm_device pointer into it so we can base the return value
on whether the device is cache coherent or not if not running on
X86.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: David Zhou <David1.Zhou@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Junwei Zhang <Jerry.Zhang@amd.com>
Cc: Michel Daenzer <michel.daenzer@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Will Deacon <will.deacon@arm.com>
Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
This is a followup to '[RFC PATCH] drm/ttm: force cached mappings for system
RAM on ARM'

https://lore.kernel.org/linux-arm-kernel/20190110072841.3283-1-ard.biesheuvel@linaro.org/

Without t
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  2 +-
 drivers/gpu/drm/radeon/radeon_object.c     |  2 +-
 include/drm/drm_cache.h                    | 19 +++++++++++--------
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 728e15e5d68a..777fa251838f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -480,7 +480,7 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 	/* For architectures that don't support WC memory,
 	 * mask out the WC flag from the BO
 	 */
-	if (!drm_arch_can_wc_memory())
+	if (!drm_device_can_wc_memory(adev->ddev))
 		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 #endif
 
diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index 833e909706a9..610889bf6ab5 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -249,7 +249,7 @@ int radeon_bo_create(struct radeon_device *rdev,
 	/* For architectures that don't support WC memory,
 	 * mask out the WC flag from the BO
 	 */
-	if (!drm_arch_can_wc_memory())
+	if (!drm_device_can_wc_memory(rdev->ddev))
 		bo->flags &= ~RADEON_GEM_GTT_WC;
 #endif
 
diff --git a/include/drm/drm_cache.h b/include/drm/drm_cache.h
index bfe1639df02d..ced63b1207a3 100644
--- a/include/drm/drm_cache.h
+++ b/include/drm/drm_cache.h
@@ -33,6 +33,8 @@
 #ifndef _DRM_CACHE_H_
 #define _DRM_CACHE_H_
 
+#include <drm/drm_device.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/scatterlist.h>
 
 void drm_clflush_pages(struct page *pages[], unsigned long num_pages);
@@ -41,15 +43,16 @@ void drm_clflush_virt_range(void *addr, unsigned long length);
 u64 drm_get_max_iomem(void);
 
 
-static inline bool drm_arch_can_wc_memory(void)
+static inline bool drm_device_can_wc_memory(struct drm_device *ddev)
 {
-#if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
-	return false;
-#elif defined(CONFIG_MIPS) && defined(CONFIG_CPU_LOONGSON3)
-	return false;
-#else
-	return true;
-#endif
+	if (IS_ENABLED(CONFIG_PPC))
+		return IS_ENABLED(CONFIG_NOT_COHERENT_CACHE);
+	else if (IS_ENABLED(CONFIG_MIPS))
+		return !IS_ENABLED(CONFIG_CPU_LOONGSON3);
+	else if (IS_ENABLED(CONFIG_X86))
+		return true;
+
+	return !dev_is_dma_coherent(ddev->dev);
 }
 
 #endif
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
