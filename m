Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA5CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:43:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82FC0206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BnJCDfsr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CZRSEX9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FC0206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=smaPsntxjDGrSQXYrjdNaC2dwSWWCSFD58c1vVmmAiI=; b=BnJCDfsr/NvTXvLm8FbKKS7mZW
	Ejpf5Rs1gb/K52UNNmt5aHI/KZj8VAJTbERwsOu6DmTq0TbfaGHT5LOpi4CSh3CMC/XXDXB47CxdX
	K1gJXTt3xX5gdxRSa6otOTRa9JndvZ0rQFX1VWt1OpfGeDGKibmgXu7PDGSmn6cHhidnb3omAt7mj
	a+nbfuPHYYmb+MZRi9uNee8eMmgVNKwhoPHqaDk2m+3hDtyeJ9o8v+ApQy+4x3bRj/JEohy0ST5LB
	2Bb+c1a7znLL3L8RXKL3QLBjR0hBWRxLZ7WOPQyD86If1iaXWppbmdH9ZyzrVynOgFKVCkK5oyS8C
	17sZicLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj5L0-0008H2-TM; Mon, 14 Jan 2019 16:43:46 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj5Kk-00085Y-GH
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 16:43:44 +0000
Received: by mail-wr1-x443.google.com with SMTP id s12so23685728wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 08:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=8jUWUXinqrIEk2wbCrHnyISvXX2O3vcX46RGBCRFza8=;
 b=CZRSEX9xhalKjgqG4U+P2MSdMyDo7y7Xr/ytxGZM78A+F/9DrRIo/KhQWHyj5c1d9U
 i7GpifF0VdNNm1c/Ky6ueBZzsUWSqv1swnoeLzzbJJIe6CwwmAHNO2t6g0/JRxI3QeEk
 0VHkhylq59Tre+6qsnnEjgjbSOedrDEZjKMFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:in-reply-to:references;
 bh=8jUWUXinqrIEk2wbCrHnyISvXX2O3vcX46RGBCRFza8=;
 b=EA0OBHLqEW41CUP7AmdcrseyownMdcWATskMREKOFXUabl6fyWsEWR7YhyCm2wtXIl
 4CkoVfeDH/hVxzDjxW6K9Trg/Z96Qa8HkZMD9UKCPtcnvkR3XddF91QKRgR/OFnWRep8
 k/e8J2YD6ddv6OI8DKegV+C748TEWQeIKfioFhkWIlTUsOq0lfl6hpbWWvLSBw+787rN
 8HKEbdlpG0cizSEGkh5zqCbVxX99vFcmxgkJaUJGI6VElYZzqV58CaVxZPDjE5v4ZU6m
 RhLz6zWYs9q09EoHYbq8NAuPoUgtIXiorGQ32xBjyWw4tmeTZ+1q/Lwj4S5jwtNrmwV7
 FzSA==
X-Gm-Message-State: AJcUukePRPuvAqr0kAR801KV6mmJKTx9zxYp/k811H3YEEoU+CnWdK+8
 mwecqG8peCrUaKlpFWavDIKdRA==
X-Google-Smtp-Source: ALg8bN7gnnHsFpYDNmwBC+drqi83as5YoAeuieSwHayKGL0PkzLBbetQmfvTApWSP/zr++6WgEITyw==
X-Received: by 2002:adf:80cf:: with SMTP id 73mr25037001wrl.57.1547484208974; 
 Mon, 14 Jan 2019 08:43:28 -0800 (PST)
Received: from localhost ([49.248.190.171])
 by smtp.gmail.com with ESMTPSA id f10sm7842762wmb.35.2019.01.14.08.43.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 14 Jan 2019 08:43:28 -0800 (PST)
From: Amit Kucheria <amit.kucheria@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 10/10] cpufreq: scpi: Use auto-registration of thermal
 cooling device
Date: Mon, 14 Jan 2019 22:05:02 +0530
Message-Id: <ddb8e8a94da197fa4b8d4d03450bcadef49c9820.1547481320.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547481320.git.amit.kucheria@linaro.org>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547481320.git.amit.kucheria@linaro.org>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_084331_147110_DB444D9B 
X-CRM114-Status: GOOD (  13.15  )
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
 mka@chromium.org, viresh.kumar@linaro.org,
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
 drivers/cpufreq/scpi-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 87a98ec77773..c01c63a342c9 100644
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
