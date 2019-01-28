Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5599DC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:46:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248092148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AkcddMmz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUk3Secd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248092148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=2HWbvJtAzdVZOLifB6p1pkGyt5UaBH2hYf5GvLAqmQ0=; b=AkcddMmzr0IYnBmVlzhzMgUzGe
	xZ9J5VqIVdJ9eErCSNENHOYt/cSWkxSXgkO0yVmx/ISotDH5Oq7o2bSuF2xatKQz5AJ8CRQT3sF7F
	s7Fc+U6NowpUJIExQJIftxmmE2YeLLjvpUHqp1RDhTCRZouF6B3w5FnmMmGRcSVyJdVvoqW1+vVEA
	zEBgJIAaOK5OLB+yrjJgSz4UlGZrer1m+lNsncSCoynCtl7WEQNplucaNIYp+CZ92RxJxE5JrWMw8
	BgRTtQ9+ntC4pJ/m8mai+/l5uJ/ENByxVYjzQmpjqA8lh1MXRs6g80mvzqkVI7Rdj6inZsPFTVbh6
	8xKETL3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go0gl-0007VS-45; Mon, 28 Jan 2019 06:46:35 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go0gh-0007Ug-O0
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 06:46:33 +0000
Received: by mail-wr1-x442.google.com with SMTP id v13so16672673wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 22:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=xA//1FlkdsXmsx5auTFeNL+jjZLqfN7vDldrYpONvm4=;
 b=HUk3SecdrvnJ83/Xwlvn4vLndaLEzSF546horDbu3kzayiHpAMhQUxQh8YokSO51GK
 7zRXduNluXbueiKMdet2oOnFHJiqcONC2veU8IZoqsZG7m7eRyINj69EzaVuRX15m966
 RP07Bw3PXe9tjtUejQGr/ESceHxIkDJ78SA38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:in-reply-to:references;
 bh=xA//1FlkdsXmsx5auTFeNL+jjZLqfN7vDldrYpONvm4=;
 b=FBYpU9VRWUZgyXlBnA7GrJEIA9p/B2FmSlAXjpXsKqOZ9wmz06nDPgkamDngiWCmfB
 y2z/8lJPo1MIjdRgd4TUBb3zJvph1YARTBx1QEMMoXV2uQkmD48cenPoD/sF8sR4FyL+
 XjZyhv+JOn/p+oamFIJqu05wrvThyWRiYGsCRlWfsMNexfyolyzdj6acJyQgP4DKLuKQ
 qFqRo6Wdpps5btcVcqwYPjVXsZDj+tcwJs6CH/RmB+J8R4T8gSKj69i17X3VAq8JWuke
 mMrcdK84nnz8MGi0MbxcA8JG9UU6KaZ+RDxskOE45yAl84FyxH7CnpI5ztiqPZ89tjWl
 qTFQ==
X-Gm-Message-State: AHQUAua9gSBd9K7/c/NEMmDsnu2HC3bjOk0gWaL/oSpWUSODiI25Fe9x
 Fj2KQRf/6hlkibbPRiAqcsfatQ==
X-Google-Smtp-Source: AHgI3IZW+2kBArB+s9SO6B1BpdG+Vt1j/1Dnfp7JT6pEHjRi2XQV0E9VRiDSM4zsTrDgFjSbzOP2sg==
X-Received: by 2002:adf:f401:: with SMTP id g1mr15063951wro.103.1548657990362; 
 Sun, 27 Jan 2019 22:46:30 -0800 (PST)
Received: from localhost ([49.248.191.44])
 by smtp.gmail.com with ESMTPSA id 67sm185539371wra.37.2019.01.27.22.46.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 27 Jan 2019 22:46:29 -0800 (PST)
From: Amit Kucheria <amit.kucheria@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/9] cpufreq: scmi: Use auto-registration of thermal
 cooling device
Date: Mon, 28 Jan 2019 12:11:33 +0530
Message-Id: <81d81c0016fb275728b7b604020c22d8f53991b1.1548654899.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548654899.git.amit.kucheria@linaro.org>
References: <cover.1548654899.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548654899.git.amit.kucheria@linaro.org>
References: <cover.1548654899.git.amit.kucheria@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_224631_777334_5813F07C 
X-CRM114-Status: GOOD (  13.17  )
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
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 242c3370544e..b19e9d129f8f 100644
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
+		  CPUFREQ_AUTO_REGISTER_COOLING_DEV,
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
