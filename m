Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142A9C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:26:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B82C217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KhitBWOc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LK6FWzrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B82C217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=8iRDfgnhPaoQ6+vVdPBCqjYyzefslYO4Ra46BxpvUv8=; b=KhitBWOcCHJGyBjD6xB/6XQG9K
	2O/EiLkoKQd1ZR3xHyH1UrTcOLa3mTsA/fYywG3STtA0nTum8ZCYAXeQF+rlVZW5n4mprZy70bLNq
	KHIpCdRHMiloNCi/3RcXxYxutuLRdL2qUgc0ILqspkFA6gNgSAyQQ35U2abb8qLtxC225kXXig1P5
	/HnhVWBDrZo8XMCYkTx/E2ptKpJAwLic77L9h0dq4V5Cp1j+pxk8nYV6TWEWw8scPVx+VhbcYB7UZ
	u9+J1mldy0CRUyXvmOXlPkrVztZvXQu387JNlaEaSy8qK0jo+/amfE+wl/2QvynW2sriLxEYhTDCh
	0eR5MGtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grA6H-0000ub-Iz; Tue, 05 Feb 2019 23:25:57 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grA5S-0007FR-Co
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 23:25:08 +0000
Received: by mail-pg1-x543.google.com with SMTP id y4so2073968pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 15:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Ccqi0PrQP2++Gk2Iw5QSemotnIhaAp8U4DdCM+tifrE=;
 b=LK6FWzrII6f/kojrANilyG8yDT0cJQUmHYQy+ONwR4BZjGOyuMLSRwnQ47LBWWn6cB
 0MLGXbPqSzhkKsyg9a8NxwITiigYQP/f7ve6TGh1qrudVfLZTH2yfBzDMFO85YJGQFJa
 zGzlUAz9kS8dkIN67FaYTVzrfF8aA5+S703q2xlWUJl7e6l6ZR9QKQP6Dn69s4ao044W
 /AiV0jptZRgjqy1cAx39FyGFO76UA9vp073L/nOJEObkGN+EGe69kp80BTiDn4MP3lW7
 944PlZsE6w+hirYywhI+P9Ot2/h8SFgPEsZPCgYMhNIMyJUIxzl6LbG+6014b0wUw67S
 tXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Ccqi0PrQP2++Gk2Iw5QSemotnIhaAp8U4DdCM+tifrE=;
 b=p8lQE/OD0AYizqOyCJnYzXXG/8w5XjUXlmGPUtwwIZVbEH/sabDD+ybQcYxzxgVndz
 fn7IMKpUDoBVPAPU7nm5XIYo1GLu2niyAsVQIIlkrxYZZeC4GBohKh1qo0qdvRd66yWf
 7zbtWn/FWVWw7SwNh8dw1cJ3c9s82Ve8Rz0FrmTlT+xrm6UEVRPvklAyzEPhfIELq2ue
 2S5IyVzqLOGb0w/zmoxlK71P0TTty/s0FIcfYEbrAut2fRek/g6ozQG2B6TaOH5YTUbe
 jxhN4d7AIRLRZgUCz+B9dbPCqlb14IpfQdbA3t4U3Xt0AWERD3KTtlRvFqA/KmhWVTyY
 uTrw==
X-Gm-Message-State: AHQUAuYK1tmVmu8tcNVCL7qXktlXXeJahDOSfjXld+NzsEt/5/gdksg7
 2EeWgoyLJgLtSwLEEcruyB6S5w==
X-Google-Smtp-Source: AHgI3IYOw7BBC0PRVuH7x0KhBzpKVLHVU+AJXBxtBGrXpkPyIXo9kinLZw2ZFYGBz7osbCg8LgGG4Q==
X-Received: by 2002:a63:4706:: with SMTP id u6mr6534664pga.95.1549409101607;
 Tue, 05 Feb 2019 15:25:01 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id g136sm5926917pfb.154.2019.02.05.15.25.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 15:25:00 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH 1/6] coresight: cpu-debug: Support for CA73 CPUs
Date: Tue,  5 Feb 2019 16:24:53 -0700
Message-Id: <20190205232458.7074-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205232458.7074-1-mathieu.poirier@linaro.org>
References: <20190205232458.7074-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_152506_453659_F99E8D70 
X-CRM114-Status: GOOD (  13.16  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

This patch is to add the AMBA device ID for CA73 CPU, so that CPU debug
module can be initialized successfully when a SoC contain CA73 CPUs.

This patch has been verified on 96boards Hikey960.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cpu-debug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 45b2460f3166..e8819d750938 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -668,6 +668,10 @@ static const struct amba_id debug_ids[] = {
 		.id	= 0x000bbd08,
 		.mask	= 0x000fffff,
 	},
+	{       /* Debug for Cortex-A73 */
+		.id	= 0x000bbd09,
+		.mask	= 0x000fffff,
+	},
 	{ 0, 0 },
 };
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
