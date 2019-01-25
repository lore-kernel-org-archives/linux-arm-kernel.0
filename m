Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D5CC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:04:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D07A62184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gVe3i0YR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cKCXamQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07A62184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=2HWbvJtAzdVZOLifB6p1pkGyt5UaBH2hYf5GvLAqmQ0=; b=gVe3i0YRuX+x9i+j97Fuk4COaH
	UgaPy/2pBJdPmznK/tPMTiSRAjKUnvIqQru3cnGjZHzRqkUGwbjY7i5A3iEJUbykF6BnXLkmm9kSO
	xOnAL13fctMIvUky4rM9eRy/wTC8WI6ISd0BoPpmj3/9Rnm3EbEtcuClRYCszhAS/WppeUnNSQk7T
	2L0QXgOThInBnnTJJP6+Esd6vkizxEaJbv/X4VWJH+k9E78cZJezhE7Ds0ktfEiugXTp3el8ChYVb
	HrUruMsxUEdhpvPAN9q4+5mhDqTo5SpcXcPtGNx1hMPoEG8uNOtq+U8ltHF5/YWQEdWDcb6/xxfTC
	Y94/7o1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmvXR-0005Rg-Ro; Fri, 25 Jan 2019 07:04:29 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmvX8-0005Dl-9m
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 07:04:11 +0000
Received: by mail-ed1-x544.google.com with SMTP id p6so6600792eds.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 23:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :in-reply-to:references;
 bh=xA//1FlkdsXmsx5auTFeNL+jjZLqfN7vDldrYpONvm4=;
 b=cKCXamQs27SFMCtXHsaEBtbiosOOItfG+tsJqXFmkDoPmAf2H+e73DJevygpbblnSt
 GFq4GplluPUoT3mbrGtJ1VHYGObCo8N/odzHXnGIQQ7Q5bx0BLnO7FMcKOk8Th/v5nbm
 3jWu22wKm/ypacS7C8rwvGblxK9vpItxXi+Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:in-reply-to:references;
 bh=xA//1FlkdsXmsx5auTFeNL+jjZLqfN7vDldrYpONvm4=;
 b=F+ItMWk5kVU2jHDn7OJU55qGu0ErA9CZiCuROLbr9+DHEgWYzk/stAa3Wy4w4qbv6V
 NoSNjID2jD4PElYW+ZHx4mX7wXPDwA9U9jILUgV9F2su2z2TqJ4cGHkiFuy40Gq8wbUd
 sgaoHSeZouTauikO1r7R9tX7ulHLKgOOugmX94g5p7J1EglqRhanw+GqKBbk9JSDIs0g
 uHnGF9SmDcSmGmQqcrbmHUF/yb0iHb6w4vsqZ4MRPkjTijbXxIbUcEQ0AQA2I9Fi+KXP
 gcLOCJRv6kNZZKqjHFaS+/3tEb1etI3H+rbTXd5GF659H5eO6nIQ28PayRClUwZSnbbb
 1LwQ==
X-Gm-Message-State: AJcUukeepwOX/eBcCDv2CtNRNa6G/s8IGfdwSoAP8b3iN0/KauaiWrkf
 MazjJ5OnW53iC4NSyIjkLjJ6JA==
X-Google-Smtp-Source: ALg8bN5ZtDmNkfTzzOMEjmFZrYiQoSLYPamIAqopCNrzFwl4kUeNo57OfKlGU10wQqiNeVegNL6NEg==
X-Received: by 2002:aa7:c55a:: with SMTP id s26mr9551675edr.132.1548399848614; 
 Thu, 24 Jan 2019 23:04:08 -0800 (PST)
Received: from localhost ([49.248.181.51])
 by smtp.gmail.com with ESMTPSA id w56sm11734113edb.72.2019.01.24.23.04.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 24 Jan 2019 23:04:08 -0800 (PST)
From: Amit Kucheria <amit.kucheria@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCHv3 8/9] cpufreq: scmi: Use auto-registration of thermal cooling
 device
Date: Fri, 25 Jan 2019 12:32:28 +0530
Message-Id: <a58e42077a234bb898df23084173319dc1a1f58d.1548398851.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548398851.git.amit.kucheria@linaro.org>
References: <cover.1548398851.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548398851.git.amit.kucheria@linaro.org>
References: <cover.1548398851.git.amit.kucheria@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_230410_334290_6E19AA34 
X-CRM114-Status: GOOD (  12.84  )
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
Cc: "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 linux-arm-msm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, dianders@chromium.org,
 swboyd@chromium.org, edubezval@gmail.com, mka@chromium.org,
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
