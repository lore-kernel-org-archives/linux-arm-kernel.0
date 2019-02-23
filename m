Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B91C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:09:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB24620675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iYuHK6ht";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZg4KyRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB24620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=NUKRBNjQDm8D5gGuxbio0p1UyHWNCUaC9nEwT0SDsIk=; b=iYuHK6htW2lbL+nFIoOiDCSg/m
	AqT/Mmh6GZGHqZI7+d86e5friNrT7rFHLB0zoUlV5l88YQHtUVZBgGJbBjSvZpZdP2nq4ygzAfWEb
	5GfVHcOdWnrlin+vpzUtOou1wu6BiABtzh1Yuzl/awo4cAosjKU8hxQgkC6BWCKo9mFk04YSb6AKF
	AZa17ZzkBZjfT8FTxMWfsm0raYaV7lWx8bvFqjjVG1JAV8WX3aw/dxnP42aMq5f5I4G9u75LHvxPy
	+x8HmClJsCkg4i7pFQ5DmSyagS9p1kqu08Ft4CxjI7MqzEgedbu0Z+P26WHuxQxCGKii8UAhMJ8Hx
	HX1iV+ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxX3h-00039h-Pz; Sat, 23 Feb 2019 13:09:37 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxX2N-0001ZC-3w
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 13:08:22 +0000
Received: by mail-wm1-x341.google.com with SMTP id j125so4275904wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 05:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GtXFZaf3Lxm4MFz8aDdKlTiKXkM/CBAgN7ASkzCfdj4=;
 b=HZg4KyRaou6Pwartm8ApD5A+3CMDP3VkUGmc4aspEnC7GhGGLWM5FvldLCmX8tO7HQ
 RSKNwNEfD8T2SFwhkNfpM81IbxESoOn/ebEAzPv0DeaCVHeEjSsgSEN4wEThkl7lxKwV
 NlsoRI5ttCpQeRe1a4CbVeIIcWJVYfSnqBwGATBXl98I02Z7V4Oxe3QA0nAoHcHd4O99
 1KwNYb+tNpuc28uV9ftVOm3LXb6QlkEGPkWEVgFJl98DzsoMljZvMHzYRXpSjdxSMQnP
 6g6I1gVDgtPFiVlK1ykBysgD009jWHqAR6Rn+eKpXj3A+maSbRiG76dBzQRWyHm6IFIY
 QeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GtXFZaf3Lxm4MFz8aDdKlTiKXkM/CBAgN7ASkzCfdj4=;
 b=ED46a0MGnvI3Jg2hSQ2qL1Tq6wGkci9oVoAbqn3/ieeQedA3JUCv0syfzq4XC8qgQR
 DiS9C2Lb2rvz4CngbCCTVziDFU5nu60+vvEBsUJ+8dwETMVy0xIjifQ5AkwENRXsW+Hi
 cXaQ43mokcL9yVltEVdt4Qqy6MyrQxQxScQuqLdN4ArUnv7vFbA0KdaP71Hc2k1Hxa+8
 LwHRRKYPHsz3o6WTYuJQ70p+oes4+jJJq1Vgv0Aklmu2+xjFL/QNCZqNSMeGK+riGj/v
 mEaMeiXvPfVsfxaB5G50asvPc5zXU6kC4AvxkMZCWsmtUSdhmc/5PhIlxA8LwZQ5Xdwb
 YkIg==
X-Gm-Message-State: AHQUAuZmYqhgnv1CoHXWjcxLaadj59vXLT8FH45lgTtbwDaSU6MN6uJR
 1qQQDd3N36eHwOhGLCaByxHdXA==
X-Google-Smtp-Source: AHgI3IbSAXgNrAudQGSxlpigzJIAKn5HXgB82Bp82krn1A5mPCd/fBlyKUvXKva6zpZYo3U8Aljd4A==
X-Received: by 2002:a1c:a756:: with SMTP id q83mr5358850wme.8.1550927293551;
 Sat, 23 Feb 2019 05:08:13 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
 by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.08.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 23 Feb 2019 05:08:13 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Subject: [PATCH 11/18] clocksource/drivers/exynos_mct: Remove unused header
 includes
Date: Sat, 23 Feb 2019 14:06:59 +0100
Message-Id: <20190223130707.16704-11-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_050815_945830_1FC619C6 
X-CRM114-Status: GOOD (  11.66  )
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
Cc: "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>,
 "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
 <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Krzysztof Kozlowski <krzk@kernel.org>

The driver does not use sched.h and platform_device.h.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 33e90c080877..34bd250d46c6 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -10,14 +10,12 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
-#include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/percpu.h>
 #include <linux/of.h>
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
