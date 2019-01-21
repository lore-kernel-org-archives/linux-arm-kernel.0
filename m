Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC5EC2F441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:48:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D009D20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CVhWK6de";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="coDADYUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D009D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=LXcCpims0cde4H/eoR07WI4whLbVVqKRJ2V+Ti8tqa0=; b=CVhWK6deHouKyULmgbhPfGW8NO
	ERh40fdVJPZHJSf3hoHX3gTiJuA/4bCbGBr4BR6IcquZ0UclDh+54Sgn6SU2P9jA3OZb5wXYQ9mj6
	zVm+t3IbOWvtpZCIoFI/biCpFrZJa0wGDMS96xHoshhrR2PgfNkXAFqLmkTQy8WWUS6VxZzcaGpMg
	1+pEs7KUqOBJkxeIxoJqnsuK9K5A24MlAhrpjfERWx2oP/3ByAevYEKd7ps64I4Cbqkk7Ak+a+Goa
	4FT2LjPDmWBdeBYcrODEOnAc/OI31T+xVvqX3DTHojJo+FQxe1I/8t/O8abNDhQx7gI6V5/A13jZz
	1rIhw9YQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbnr-0003LU-Lj; Mon, 21 Jan 2019 15:47:59 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbmD-0001mq-Pb
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:46:34 +0000
Received: by mail-wm1-x344.google.com with SMTP id p6so11244468wmc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 07:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=lmDIKADatw1oUeQ5UHUMSZddpdBoEMSbYiY1RQRpnEA=;
 b=coDADYUvLFZRTbz5rB1pf5MJLNgJCkEzFO1jTwKFqWh1GA28dam5wmRCxancPw/Dp5
 GBdQkQrAkjKtJD2n5CdsmDgUylwyEBdk1BLAYCT9osd1UtM1DuYR0OzrrXAN9OAwQKBw
 MKy9m0aUUc1OTPR9tPiYejvzgnMQUEydRVX1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:in-reply-to:references;
 bh=lmDIKADatw1oUeQ5UHUMSZddpdBoEMSbYiY1RQRpnEA=;
 b=SYmTutyluToL3cZRblSiyKMGdtJrDbJkCDhsvbmgtLQJQGO831Tzoepfg4YY5vkObC
 wArK9ItRNy9u91eCyoQ4BeZjTP16DkGsLFXh+Dg/21J5OyaaRrpKN4f7k18B26bXfS+Y
 996nTOzWXazdwwrarQa6aimf+Sb7IgPEDj23Ac0vkAMOKnhoqQRN+z9F0wbjHWj/03D5
 jb3cok7oYpwWwykNO2dbPvgg3i7v8J7s+SbB3hNFsVv1wXNgIQsKZtHMT3ULtuVqVKPe
 1Aw/RCIv5DwKuLcxOKa8nNwhl/nP3f0a5K6lS9aihmJi5hi9DaFEh4ceqPMvfiZ8N7ou
 /+Yg==
X-Gm-Message-State: AJcUuke/nobdP1FAH6+tIzq2F7O5bMvhoVqeTOhi0IL6vdtK+qc5Erka
 cCsLL/KC7Ja0fvoFx+Q+VUpA6A==
X-Google-Smtp-Source: ALg8bN6KrMDLiPVFWulMBQxmdUdOwj5FwgY6rBQBghows4GKT0uTTyxiEruIFbnYJGQhzQfvpFkoKg==
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr25885532wmu.52.1548085575943; 
 Mon, 21 Jan 2019 07:46:15 -0800 (PST)
Received: from localhost ([49.248.61.1])
 by smtp.gmail.com with ESMTPSA id a18sm115239503wrp.13.2019.01.21.07.46.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Jan 2019 07:46:15 -0800 (PST)
From: Amit Kucheria <amit.kucheria@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] cpufreq: scpi: Use auto-registration of thermal
 cooling device
Date: Mon, 21 Jan 2019 21:10:34 +0530
Message-Id: <95506c9919bee528838016dd2c857ebb28e19152.1548084260.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548084260.git.amit.kucheria@linaro.org>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548084260.git.amit.kucheria@linaro.org>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_074618_321555_FFBA44B7 
X-CRM114-Status: GOOD (  13.22  )
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
 Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 dianders@chromium.org, swboyd@chromium.org, edubezval@gmail.com,
 mka@chromium.org, Wei Yongjun <weiyongjun1@huawei.com>,
 viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use the CPUFREQ_AUTO_REGISTER_COOLING_DEV flag to allow cpufreq core to
automatically register as a thermal cooling device.

This allows removal of boiler plate code from the driver.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/scpi-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 99449738faa4..82420e8e5f0d 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -22,7 +22,6 @@
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
-#include <linux/cpu_cooling.h>
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
@@ -34,7 +33,6 @@
 struct scpi_data {
 	struct clk *clk;
 	struct device *cpu_dev;
-	struct thermal_cooling_device *cdev;
 };
 
 static struct scpi_ops *scpi_ops;
@@ -186,7 +184,6 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct scpi_data *priv = policy->driver_data;
 
-	cpufreq_cooling_unregister(priv->cdev);
 	clk_put(priv->clk);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	kfree(priv);
@@ -195,23 +192,16 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void scpi_cpufreq_ready(struct cpufreq_policy *policy)
-{
-	struct scpi_data *priv = policy->driver_data;
-
-	priv->cdev = of_cpufreq_cooling_register(policy);
-}
-
 static struct cpufreq_driver scpi_cpufreq_driver = {
 	.name	= "scpi-cpufreq",
 	.flags	= CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
-		  CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+		  CPUFREQ_AUTO_REGISTER_COOLING_DEV,
 	.verify	= cpufreq_generic_frequency_table_verify,
 	.attr	= cpufreq_generic_attr,
 	.get	= scpi_cpufreq_get_rate,
 	.init	= scpi_cpufreq_init,
 	.exit	= scpi_cpufreq_exit,
-	.ready	= scpi_cpufreq_ready,
 	.target_index	= scpi_cpufreq_set_target,
 };
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
