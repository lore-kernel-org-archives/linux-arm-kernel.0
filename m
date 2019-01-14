Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D62EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:42:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B49E206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mLNcvhuc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vn/oqcY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B49E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Yhx6Ry4LKReMxVAcDiOUkbPdfSiEwXCOP46x3YvFAlM=; b=mLNcvhucj5FFBhQez7uu26jdKu
	IgrO0m3/rM5AWmvgc5h83Uy8zCBm1Qm5csMWcdXFs9/MhrfO9BWGYR3GG5ZbYq/xufzJi/sSenhWH
	7koYYJ0Rp1Qhuz4Gy87o46u2L9fSS7Fm/tQPOT19OvjI4jUz/GcDtEk6bx0noOzHdIaueRulOaYee
	CJfnqYnsFkDsCIzp7e9QinUkTPYdz5zUQ4O0N8/SIqmQ+0w1UN7hF3kOom0Dswdjo9alFTL4LVCLZ
	XVLe22gppZ+g3408pUT1MVK28dI6vQPMBpX0aLxnOp5e+LIONgk1ibqqHRdjBibw6vo6LEKYAh9Ei
	EP572hNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj5JS-0006wd-PZ; Mon, 14 Jan 2019 16:42:10 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj5JO-0006vE-HM
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 16:42:08 +0000
Received: by mail-wm1-x344.google.com with SMTP id g67so229049wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 08:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=QV55M5UT9ckgy/+9mgu7lB9S5ppe7rLYbFWvyS23/Cg=;
 b=Vn/oqcY/P63zY8ZUM+xRQ9jA/yok6Av41I0Nbd/XBcMYaybRLswoqC+bZ7zFthiL99
 AD8roHRXIq4z/jltTQDQy+bZ3SYq2XsqBoRpBPDqUlr3MrNNQ8pHTqOE2xiKwhPFJy1I
 +jhPvzj5X/ykiwTALhSNyEO8GSfyjhARHv/Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:in-reply-to:references;
 bh=QV55M5UT9ckgy/+9mgu7lB9S5ppe7rLYbFWvyS23/Cg=;
 b=pFaseorXSUFR2YZ5OfGo2fRcBJVl/3mckAayQXapACca+XT+mF7vQZtzSBl2oz2rdr
 vJivPbdzezs5c8iDTC+k3AYFt6+u/ccadOoscB5KBmegkcEe/Xhl5wal2CXUQGlA2o6D
 8Qb6JX2H97sSYQ/mGJkarGviOKuR57rPxTHRyCNbeYXfeydz3Ju5OsUs+ArQ+SX2UqLJ
 7JHnLcIQYylqgNg8+TWYlEq/EwnvTmvy5JLZiCXMc5YlJxiCiQcLRSyf2W1o4la2B8l4
 6rK4c28Sa/Gttw7IQ7JUtVHwIPu5KQs0fKS/xbhmmlOcIvt/p3qs4BoU/0cEJSlsAgbp
 x1kQ==
X-Gm-Message-State: AJcUukffE+laQnZufGLTDqYcOEtUOp6X5cL6xn7nyK01qGWkr9CCqgNd
 ggDwK7iEOHp7WGc7j+YXpl2Q5g==
X-Google-Smtp-Source: ALg8bN7mqoKQiOsb2WAqJ6DGUQ8jr6Te4CeoL5mDym674Xao19ig/KGBq4YHGSzRMedmhyjopdmoEQ==
X-Received: by 2002:a1c:2007:: with SMTP id g7mr12266919wmg.79.1547484124495; 
 Mon, 14 Jan 2019 08:42:04 -0800 (PST)
Received: from localhost ([49.248.190.171])
 by smtp.gmail.com with ESMTPSA id k3sm110603159wrm.7.2019.01.14.08.42.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 14 Jan 2019 08:42:03 -0800 (PST)
From: Amit Kucheria <amit.kucheria@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 07/10] cpufreq: mediatek: Use auto-registration of thermal
 cooling device
Date: Mon, 14 Jan 2019 22:04:59 +0530
Message-Id: <a9e1ac5a60b5c99be1f90df822c5b02c4ab7fa13.1547481320.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547481320.git.amit.kucheria@linaro.org>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547481320.git.amit.kucheria@linaro.org>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_084206_573288_5B6DB0EA 
X-CRM114-Status: GOOD (  13.45  )
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
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Sean Wang <sean.wang@mediatek.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 dianders@chromium.org, swboyd@chromium.org, edubezval@gmail.com,
 mka@chromium.org, linux-mediatek@lists.infradead.org, viresh.kumar@linaro.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use the CPUFREQ_AUTO_REGISTER_COOLING_DEV flag to allow cpufreq core to
automatically register as a thermal cooling device.

This allows removal of boiler plate code from the driver.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/cpufreq/mediatek-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index eb8920d39818..9a937f4c63e7 100644
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
+		 CPUFREQ_AUTO_REGISTER_COOLING_DEV,
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
