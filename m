Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C58FC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:58:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33A8920989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RHkUPWlm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKkw+bx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A8920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=2StlJ/HsXeW8GrUqQOvrkm6fRLSlRwFJlkCx3pSg/a0=; b=RHkUPWlm3gVcjA3bwVeyhuddTq
	oQC5lz81+9B5nM8UjuRCed5heTUqa2CL9YRZbcVlhmCmK67QH8Re/l7IgFw7FCiSt2D7r1/6MN8u1
	8E1LbqmAihxdlEZkYqp78HaS3WHC051LbJtIj0qxHZhPOPITHMQ0JvPkWNILhs4GkaoTe8HUDjNc/
	oERPimAFS4juLWMc364z3FtidZ+W2Lv7F6ZzUc5cuwb5o28OQdgK8dmX+jyJoDFzQTGH8Jp818eFY
	dG5AHz+A3m+ZCJvrW+r6t5QCWV5cffIWmjjh29crjqTOrxyA+Bf+Umen6O4/QSt6QT9Z+LU/b/ZES
	5LM32X5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goLU3-0003lG-N2; Tue, 29 Jan 2019 04:58:51 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goLU0-0003kp-3s
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 04:58:49 +0000
Received: by mail-wm1-x341.google.com with SMTP id n190so16342250wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 20:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=q0Sq1ojzps17WKcX9i43B6VWlGzaqFa3Y99XQ3cE3s0=;
 b=SKkw+bx9M7a1C7KFz6NtETyB1HBgVDEedtQCAyZlJS20Esw+cYWkadE9BRpxg7FN9v
 fSTti4bcAemIotQ72wCEHy/4Ibs01qFlFne/uFQ0/dWsQ3O4hVXI40wKT9tQNZu7s0Q9
 KZKZeWQZxlWlQ/LA/VRqGQ5c2PSEfdY4+SLDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:in-reply-to:references;
 bh=q0Sq1ojzps17WKcX9i43B6VWlGzaqFa3Y99XQ3cE3s0=;
 b=hm4Qa+30li8WwfiZCGHliq8+c9Q+I8DPzj6HbXsdyM1lnuhLQkax1GheGW4l/OzLWY
 WCEm1g61NsX/1mPuVNaG/n/TaJOZgg1HhoioEUbOEIPE/MxfcA1boJZ5rYBuXRS7SOJ+
 O06i0i76yzSpkoradudzoKqutpRkKcrc0TXibQTp0N19FQdS5CN6LwbtgLzhzLeZvYfO
 Ydx8JtrcA16ezr8H5nWplif/4zXM772I2GdHosdnsfkksvxs7C8YJf1hrciYLzjsj+mz
 6NewO+tUKu/+CKu1cH8/Y/A+LXXDqcLiVevjXpFk2EoU/SuoGU5Vpoiq+Jq2Tq8G9/ju
 +moQ==
X-Gm-Message-State: AJcUukcGqhMemUyA2IqJO1xCJcxzIEgRbEB/wWLKv+tc0aMrQN0zc7Lo
 D6y01tFI4iL4TsOLpnmM5Ij4ZQ==
X-Google-Smtp-Source: ALg8bN7lQ4NZxXpPYYyKI5DUU25o6+aZkafyPjktEveuyTl9Mfybi/gfZyuPTCpUrUcuUKYg9snh3w==
X-Received: by 2002:a1c:2314:: with SMTP id j20mr19221835wmj.142.1548737926560; 
 Mon, 28 Jan 2019 20:58:46 -0800 (PST)
Received: from localhost ([49.248.171.30])
 by smtp.gmail.com with ESMTPSA id 125sm1908131wmm.26.2019.01.28.20.58.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 20:58:46 -0800 (PST)
From: Amit Kucheria <amit.kucheria@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v5 8/9] cpufreq: scmi: Use auto-registration of thermal
 cooling device
Date: Tue, 29 Jan 2019 10:25:14 +0530
Message-Id: <a96487a516184166eadb18020b23de273100b442.1548737236.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_205848_151092_7C24A596 
X-CRM114-Status: GOOD (  13.49  )
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org,
 Sudeep Holla <sudeep.holla@arm.com>
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
 drivers/cpufreq/scmi-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 242c3370544e..66b633b48eb1 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -11,7 +11,6 @@
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
-#include <linux/cpu_cooling.h>
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/pm_opp.h>
@@ -22,7 +21,6 @@
 struct scmi_data {
 	int domain_id;
 	struct device *cpu_dev;
-	struct thermal_cooling_device *cdev;
 };
 
 static const struct scmi_handle *handle;
@@ -185,7 +183,6 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct scmi_data *priv = policy->driver_data;
 
-	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	kfree(priv);
 	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
@@ -193,17 +190,11 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void scmi_cpufreq_ready(struct cpufreq_policy *policy)
-{
-	struct scmi_data *priv = policy->driver_data;
-
-	priv->cdev = of_cpufreq_cooling_register(policy);
-}
-
 static struct cpufreq_driver scmi_cpufreq_driver = {
 	.name	= "scmi",
 	.flags	= CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
-		  CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+		  CPUFREQ_IS_COOLING_DEV,
 	.verify	= cpufreq_generic_frequency_table_verify,
 	.attr	= cpufreq_generic_attr,
 	.target_index	= scmi_cpufreq_set_target,
@@ -211,7 +202,6 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 	.get	= scmi_cpufreq_get_rate,
 	.init	= scmi_cpufreq_init,
 	.exit	= scmi_cpufreq_exit,
-	.ready	= scmi_cpufreq_ready,
 };
 
 static int scmi_cpufreq_probe(struct scmi_device *sdev)
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
