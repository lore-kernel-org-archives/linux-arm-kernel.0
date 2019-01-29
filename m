Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB38DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:59:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FCCF20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xg4FRblZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OIQOgBgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCCF20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=E02L41O5HKiYNl6wtJdMjL61bIERhcerSes4jtTDOzI=; b=Xg4FRblZpCDPz8ySch13I0B5yc
	MnqOx7T8XKxX0eBWrwwoUoOq5kCCiS5Ai7zSoEl/acYfnIcI6+7sGpJVP633+5J8YgFC25IoZNfXx
	HPZjhMqRa/EsH7j679HKNoffHE8hc/DjXw7paJ5+ERXOwR71beoTbzrNVkT66IMCetSUsfz18LHAK
	F0eTQwC4Uual3AutZBzCFQhGE8KCRG29tzdCWmblxo/jZBhzyb4U3t4xSEDhpJfFoH1+8zGCPGwCm
	CK+AwNlR2gCa9hWDa0wKAIcunEZy/nz/McFPlbcIlsndqtJWJ44jI7UrZs4HRl0PniVXDN9Q9TqKq
	lB9LRs6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goLUO-00041L-LJ; Tue, 29 Jan 2019 04:59:12 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goLUL-00040d-Gn
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 04:59:10 +0000
Received: by mail-wm1-x341.google.com with SMTP id y139so16188138wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 20:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=vcvqDibFD4J+UsvLzl4IPLt3+45i56JFsvwQyIv7Ies=;
 b=OIQOgBgIYGQMD5MsHLsxxua0J6GIoPteH87r+Nqm3iXi33wmq5/SA3xu6C8XWZeUE8
 5BEPB+ixLyvmyN1VSzTniLJcAQ+MjLrbckzu2gqa6qKrt5+DdT5GzOYGwqFuuE/b8D9+
 9tSK6SeE3Z0bHjhe2bBP4bRqYLweIzNozPMnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:in-reply-to:references;
 bh=vcvqDibFD4J+UsvLzl4IPLt3+45i56JFsvwQyIv7Ies=;
 b=UGNo0yJMlLVTs1clH+iRFfwwevBVPvIYuilR/T5uOwAPRH8bFNBxYHPzzErYnkL8pC
 8V75YMbejMFzpkIDM7bKEqI6+RYDNbKD0wTjTl9v2aGFv5ZPTIGkMbnhMjdJDQqG50Gy
 eBOlXXcX+7yoMQmh2sRi01YgLjJc3lIgjvGBpcQPDC/natTllTVwmgtmOndC+gUBuXt5
 I/Kv8DmZn+kLx/zvgKzxIeewOIDQBt1JY3Moeq2cDqydfxYGD3Lp3z7OyMw5PfBjvyXC
 mrNSFT0/tvJ2CBHHtl51Npp1zK8Sc31Ivs79ir098yFTjROJlZnBsanTElgiUQTezSSi
 75Zg==
X-Gm-Message-State: AJcUukdHeSWR9byw4irzZ45J0FKSDPm1U2u2KNhdVSDIAjVQryN2hfW/
 yIAC680kxVELYxCwDD3+XLoU3SRaKOY=
X-Google-Smtp-Source: ALg8bN6bI6kCxC4BqxUEiUgTYI6W6CiLIOnshiFU+e/0Ybp+o8c7bUzIrCsxiftfkgC9xU9EH8URjQ==
X-Received: by 2002:a1c:7dd6:: with SMTP id y205mr7116773wmc.121.1548737948077; 
 Mon, 28 Jan 2019 20:59:08 -0800 (PST)
Received: from localhost ([49.248.171.30])
 by smtp.gmail.com with ESMTPSA id n127sm1733195wmd.20.2019.01.28.20.59.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 20:59:07 -0800 (PST)
From: Amit Kucheria <amit.kucheria@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v5 9/9] cpufreq: scpi: Use auto-registration of thermal
 cooling device
Date: Tue, 29 Jan 2019 10:25:15 +0530
Message-Id: <082a9bae988061ea5465f7cdb4b0c61b4230cd59.1548737236.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_205909_577831_CAFA8978 
X-CRM114-Status: GOOD (  13.08  )
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
Cc: linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>,
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
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpufreq/scpi-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 99449738faa4..1db2f6927e13 100644
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
+		  CPUFREQ_IS_COOLING_DEV,
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
