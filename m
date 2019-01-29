Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848EDC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:58:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B02F20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dWAkzAsA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="anE2vDQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B02F20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=DEeqAtBqBndf4UkmxF36E30eca38LXPMqphRS7YwOUc=; b=dWAkzAsAiXAB/Y4TL53G+UAQ4Q
	pTwu6q8qNpLeQHduMJZviHHhfrq0Oec6EY8bnrtDv8oj98pdOMKKPZFJCJLMAYdrX+kU+IgD1S2PM
	xblFPl+gxkbEoasjFcmwbsJQgkYP8rOHIVFNsiVXCVj+8EagdNXhZhQTfeUmQBoXqwoTGlyvQoZq/
	cDL/JW5uUiuzogKqPFvU0RwAo8VJJpJymXndUoikewUTpsopJDkLNeF8lAMZzbQguPJmBZwHAtWL7
	XEEZllWfxE4sLX/MBmDWkFSL4qlL7ybV2Vn0qQs7Jtp/ZNJTrjzWff3ZyYcqtNvjoHoOcBR5yI1y5
	8CKEtCWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goLTX-0003SD-B8; Tue, 29 Jan 2019 04:58:19 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goLTU-0003RW-QI
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 04:58:18 +0000
Received: by mail-wr1-x444.google.com with SMTP id l9so20452767wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 20:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=+jPKZ9vp1qOYYm4MVv+7Bda22318qKzwckjJAKIOCi0=;
 b=anE2vDQFGsF1XAH9CF3uxaknWOljYGMhl2CzciW+AY/hDoFhzqbpIBHB4a7QW3S8bl
 LzXlRKbR2mul+a6Puig7aadA8sQiu9FpEqXSzZhq+1XVpFjjltMi6bf+tkeo1p+ipT3C
 cQp2f1YPstwlKD2T7RT2Mdhqp+4aAANaszQ+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:in-reply-to:references;
 bh=+jPKZ9vp1qOYYm4MVv+7Bda22318qKzwckjJAKIOCi0=;
 b=aW17KDgvccn3Wj79poY0KbBIeKdrfu9TXxCCWgiLpLu8D71fllc5cXBPIoP1hxRJo2
 cLVSY6C+36pzaR5QpQCAqpwL/fr8LCe5aL4YXIeN2xI11SOYEjHxWM5m0o/ZrLOzW4KV
 rToDYfQoesbobVXzlM2kOhLhTJYIBoIayfFs7XFuUNIhK/rK0ONQpYVkLJCAcHD9ogAz
 Gsfsd3kS267EsmAc4p1i0UlYuxZhXcgAzXHqHcdfyvCRkEvdV+1FkW+kJuKeQHlExaoz
 e/kk27+QPgf1+5hH/KC3FK2rGmJOVJM1tZeoXEcYJXiz30pxuZSubA3BsVNYCcIYEvld
 aj0w==
X-Gm-Message-State: AJcUukeTUjfuvOqascuTP9bIgvFmDeGlnr4bn3/cDQ/Cfwke8PI4IA3C
 pjleaMK4sKE/6frmQDxNSaMmxA==
X-Google-Smtp-Source: ALg8bN5iW0BV+F0TjrVK5FWW51JWwOc6PxD2qUoFZ3RJ9thGLu66KEy7/JexxnljuVPUMsceXISG3A==
X-Received: by 2002:adf:f449:: with SMTP id f9mr24838998wrp.40.1548737895053; 
 Mon, 28 Jan 2019 20:58:15 -0800 (PST)
Received: from localhost ([49.248.171.30])
 by smtp.gmail.com with ESMTPSA id a8sm2977581wme.23.2019.01.28.20.58.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 20:58:14 -0800 (PST)
From: Amit Kucheria <amit.kucheria@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/9] cpufreq: mediatek: Use auto-registration of thermal
 cooling device
Date: Tue, 29 Jan 2019 10:25:12 +0530
Message-Id: <36eb429112e84263bdbd26d8ea3027f71eeb862e.1548737236.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_205816_847111_3EB86D08 
X-CRM114-Status: GOOD (  13.38  )
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
Cc: Sean Wang <sean.wang@mediatek.com>, linux-pm@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use the CPUFREQ_IS_COOLING_DEV flag to allow cpufreq core to
automatically register as a thermal cooling device.

This allows removal of boiler plate code from the driver.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpufreq/mediatek-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index eb8920d39818..4229fcc31310 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -14,7 +14,6 @@
 
 #include <linux/clk.h>
 #include <linux/cpu.h>
-#include <linux/cpu_cooling.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/module.h>
@@ -48,7 +47,6 @@ struct mtk_cpu_dvfs_info {
 	struct regulator *sram_reg;
 	struct clk *cpu_clk;
 	struct clk *inter_clk;
-	struct thermal_cooling_device *cdev;
 	struct list_head list_head;
 	int intermediate_voltage;
 	bool need_voltage_tracking;
@@ -307,13 +305,6 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 
 #define DYNAMIC_POWER "dynamic-power-coefficient"
 
-static void mtk_cpufreq_ready(struct cpufreq_policy *policy)
-{
-	struct mtk_cpu_dvfs_info *info = policy->driver_data;
-
-	info->cdev = of_cpufreq_cooling_register(policy);
-}
-
 static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 {
 	struct device *cpu_dev;
@@ -472,7 +463,6 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct mtk_cpu_dvfs_info *info = policy->driver_data;
 
-	cpufreq_cooling_unregister(info->cdev);
 	dev_pm_opp_free_cpufreq_table(info->cpu_dev, &policy->freq_table);
 
 	return 0;
@@ -480,13 +470,13 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver mtk_cpufreq_driver = {
 	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
-		 CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
+		 CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+		 CPUFREQ_IS_COOLING_DEV,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = mtk_cpufreq_set_target,
 	.get = cpufreq_generic_get,
 	.init = mtk_cpufreq_init,
 	.exit = mtk_cpufreq_exit,
-	.ready = mtk_cpufreq_ready,
 	.name = "mtk-cpufreq",
 	.attr = cpufreq_generic_attr,
 };
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
