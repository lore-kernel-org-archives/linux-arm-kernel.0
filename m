Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD028C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:56:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EFEE2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P4vQAsgC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0Y2zniI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFEE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Y1WolXd+tz+yWsJQiEuafU1cKtiZOcfGyVGueC5LHSs=; b=P4vQAsgC7x1uL1sDm6Q7nbs0nI
	nSvJ6nOyeGpGXZb9D5mdb4CyR9yVQ/0kkJhcUMYcC1F2pQoKotlMvSNPxiGwLpzpjckApABq9Qdcp
	DDaFNff+ch6rZTofRaYpkSQKPpUxbQNn6xVg0UVZInkHr4+g5DnFHNpSr8wBcK2/IVXQNlxUKKeYV
	K6j+MvPCYiTDKeVWYMjLdW5cQ9z9PmZM9UUcbpHUgi7JPBDXXn8rqERdifjLIvFmvlWCTwQwNsa4P
	71FXGZCPMdeJjeWPEmG5s9bGDMJFWD3pXitKS8pVOLXbvuhFASnRtbvQbVOWoa3r7+dTE6rVI7SHm
	TVDLq4tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTx8m-0004Ls-C9; Mon, 03 Dec 2018 22:56:36 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTx7U-0001yq-En
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 22:55:23 +0000
Received: by mail-pf1-x442.google.com with SMTP id b7so7128565pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 14:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vffhfUlrlCExin749UjB4Nm/CBeftT0GbW0095v/Xho=;
 b=g0Y2zniIHZPqzPi34F5QEJl2yeW/0zodTAfxbNORnXJt0S0KVyxJvSv4H1g1CLWEtm
 aROXaan93OC+wAYKmna1xkqior+VTPWlgj/X4hyf3FQiKsvn8NsHb/aTjW9pbXMU9nrX
 qPPwBX1Dx2qyas9w4R2jmHOAfQQA5z5UJnTQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vffhfUlrlCExin749UjB4Nm/CBeftT0GbW0095v/Xho=;
 b=kT/5EFOAoXEP9EgZVfsaXPo6HTNwDbS6WKUr/XHGqO1KnG8XYRGr1Tfp3jNBPo+YdO
 8N4ili+M/byt/9D2Iorbp+3ijO/t3YotW7jB9Bad7kAycrbMhSaOnP/e9URcQqzbOumU
 jGJUcVvia2mL+bOe4vOzIKAWZz2F6CLZkAUw0DgQY2LDjVagkHgACkmqz14gjUyKeeti
 35CUKNHiioDfnyXO7BpcPnVg+sswp8WpyhTFMbVuGibOAESBXvkJmXeEkQbzcKFQn6Hx
 6pepOfac4bDszVNJzgGa+kUBaZrP6S8faGkJBzlOAWm6NJ3Ba+jOiRtq6+Wl7aow2N/V
 fvvg==
X-Gm-Message-State: AA+aEWZjGOouOW54fEyqtKBlA3s9AioAWtac9Ac840L7I0tx7lhiby/T
 8LlgmS9QvSAvjLLG9HuMlXk1kg==
X-Google-Smtp-Source: AFSGD/WXjj84V5bsTkqdXGWIIhi0mIIVNlIc3VCFLbUOfb3zvj34cd+Ccm5uTI67MvRwm3S9IqExAw==
X-Received: by 2002:a63:e156:: with SMTP id h22mr13684257pgk.255.1543877705853; 
 Mon, 03 Dec 2018 14:55:05 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id v9sm20933057pfg.144.2018.12.03.14.55.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 03 Dec 2018 14:55:05 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org,
	peterz@infradead.org,
	gregkh@linuxfoundation.org
Subject: [PATCH v5 4/6] coresight: Use PMU driver configuration for sink
 selection
Date: Mon,  3 Dec 2018 15:54:54 -0700
Message-Id: <1543877696-17174-5-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543877696-17174-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543877696-17174-1-git-send-email-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_145516_880433_5A0F38F2 
X-CRM114-Status: GOOD (  21.14  )
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
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org,
 alexander.shishkin@linux.intel.com, will.deacon@arm.com,
 heiko.carstens@de.ibm.com, adrian.hunter@intel.com, ast@kernel.org,
 mingo@redhat.com, linux-arm-kernel@lists.infradead.org, hpa@zytor.com,
 schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de,
 suzuki.poulosi@arm.com, jolsa@redhat.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch uses the PMU driver configuration held in event::hw::drv_config
to select a sink for each event that is created (the old sysFS way of
working is kept around for backward compatibility).

By proceeding in this way a sink can be used by multiple sessions
without having to play games with entries in sysFS.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 74 ++++++++++++++++++++----
 1 file changed, 62 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f21eb28b6782..a7e1fdef07f2 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -4,6 +4,7 @@
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
 
+#include <linux/amba/bus.h>
 #include <linux/coresight.h>
 #include <linux/coresight-pmu.h>
 #include <linux/cpumask.h>
@@ -11,6 +12,7 @@
 #include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <linux/perf_event.h>
 #include <linux/percpu-defs.h>
 #include <linux/slab.h>
@@ -177,6 +179,26 @@ static void etm_free_aux(void *data)
 	schedule_work(&event_data->work);
 }
 
+static struct coresight_device *etm_drv_config_sync(struct perf_event *event)
+{
+	struct coresight_device *sink = NULL;
+	struct pmu_drv_config *drv_config = perf_event_get_drv_config(event);
+
+	/*
+	 * Make sure we don't race with perf_drv_config_replace() in
+	 * kernel/events/core.c.
+	 */
+	raw_spin_lock(&drv_config->lock);
+
+	/* Copy what we got from user space if applicable. */
+	if (drv_config->config)
+		sink = drv_config->config;
+
+	raw_spin_unlock(&drv_config->lock);
+
+	return sink;
+}
+
 static void *etm_setup_aux(struct perf_event *event, void **pages,
 			   int nr_pages, bool overwrite)
 {
@@ -190,18 +212,11 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		return NULL;
 	INIT_WORK(&event_data->work, free_event_data);
 
-	/*
-	 * In theory nothing prevent tracers in a trace session from being
-	 * associated with different sinks, nor having a sink per tracer.  But
-	 * until we have HW with this kind of topology we need to assume tracers
-	 * in a trace session are using the same sink.  Therefore go through
-	 * the coresight bus and pick the first enabled sink.
-	 *
-	 * When operated from sysFS users are responsible to enable the sink
-	 * while from perf, the perf tools will do it based on the choice made
-	 * on the cmd line.  As such the "enable_sink" flag in sysFS is reset.
-	 */
-	sink = coresight_get_enabled_sink(true);
+	/* First get the sink config from user space. */
+	sink = etm_drv_config_sync(event);
+	if (!sink)
+		sink = coresight_get_enabled_sink(true);
+
 	if (!sink || !sink_ops(sink)->alloc_buffer)
 		goto err;
 
@@ -454,6 +469,40 @@ static void etm_addr_filters_sync(struct perf_event *event)
 	filters->nr_filters = i;
 }
 
+static int etm_drv_config_find_sink(struct device *dev, void *data)
+{
+	struct amba_device *adev = to_amba_device(dev->parent);
+	struct resource *res = &adev->res;
+	u64 value = *((u64 *)data);
+
+	/*
+	 * The HW mapping of a component is unique.  If the value we've been
+	 * given matches the component's start address, then we must have found
+	 * the device we are looking for.
+	 */
+	if (res->start == value)
+		return 1;
+
+	return 0;
+}
+
+static void *etm_drv_config_validate(struct perf_event *event, u64 value)
+{
+	struct device *dev;
+	struct coresight_device *sink;
+
+	/* Look for the device with a res->start equal to @value. */
+	dev = bus_find_device(&coresight_bustype, NULL,
+			      &value, etm_drv_config_find_sink);
+	if (!dev)
+		return ERR_PTR(-EINVAL);
+
+	sink = to_coresight_device(dev);
+	put_device(dev);
+
+	return sink;
+}
+
 int etm_perf_symlink(struct coresight_device *csdev, bool link)
 {
 	char entry[sizeof("cpu9999999")];
@@ -498,6 +547,7 @@ static int __init etm_perf_init(void)
 	etm_pmu.addr_filters_sync	= etm_addr_filters_sync;
 	etm_pmu.addr_filters_validate	= etm_addr_filters_validate;
 	etm_pmu.nr_addr_filters		= ETM_ADDR_CMP_MAX;
+	etm_pmu.drv_config_validate	= etm_drv_config_validate;
 
 	ret = perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
 	if (ret == 0)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
