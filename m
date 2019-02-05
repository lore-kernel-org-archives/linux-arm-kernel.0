Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF88C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:26:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47058217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NpevjTXG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nKSAFr42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47058217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=2knl0441I+czmo1qrVtHQMmCqOIN13MgiAW0CDsAMl0=; b=NpevjTXGCJfVBgZ4qgazR55hEj
	T0xYUHXYaFz4FDSRlrrMvGdh4Rnp+4uns6fLoVmdoeZEVPZVEH4ICltrDZw3DN3XIYIdJrl8qXtPs
	qF2aacKpJhADOL4/M7ZwDoiLHhUypenz5dID7M2Kt7VsB2QEra1Mqrlnjt5M5UlTn5h6wjzRUQDX1
	GP4gLymghyIOHX0ceTZssozZR4wUhCO2949YXCS6l/6lGZ99fTfPrbqXx4d2XiLWQl6OQcjBZ+n9a
	VmqLzz2amYd/sMmSh61J1UFtMW04JaH1MisJzVkCXeG1KclKz5YrE9UZqHcqJvhanAxb0Cx2oLrgA
	LGzTmhsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grA6n-0001WT-0u; Tue, 05 Feb 2019 23:26:29 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grA5T-0007pI-HQ
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 23:25:17 +0000
Received: by mail-pf1-x443.google.com with SMTP id c123so2237819pfb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 15:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=N6pe95av2ZaxCRt4t70S8VXcNlePxrKU9faHcT9k6+Q=;
 b=nKSAFr42nOBNte/OECKW7C/3ULUCj/hdXa4iDp84xR69pqTX0DkvGCui5oBwVKqDCq
 IZfdzIesQdAroG1WnMQUiVjtqbt76/Ipf0REoBuyDlMN2cKbjja4KB3ObAm3xcZVIB7w
 nh6MdNPclZNb9XvNH9ADuxJWmuhs9j4g0kQ/rF/EfIFdomcDKoSOmhamCbQFjSdX/qSY
 DZK8fx2xXkSlQfJRzpVDGiWbUMJHWGe751F0A9z4+sv39gSXu4iFBcWb7rCrWUmNDjPG
 QEUWRv644vXdp690L5BF8N9P3WAH1Sk5nIC7xV0vCwTvx53tYq7x/3N+1Mumz61J0fqv
 XxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=N6pe95av2ZaxCRt4t70S8VXcNlePxrKU9faHcT9k6+Q=;
 b=qxOOujh3RQD+xecvyjj6nvdm6jgnh+anIj5wE2nVPcxgVxzvxED5Tas4HMmeoBcspZ
 XB2+xqn3ODyfC1gMgt0fcb/U6IO3KKC1QJHRdKiwXA5qef6abPYLoDBghB98qu/6oFdA
 MZQ60o0v9jCRd1v0gAIDcnVEZOVpIWSWL/bP11IBuBGIPWVG9OfLJkty+n08mJaWFuIX
 a+k2kUT3WAZgozVtjz9yRhbUwk+dsCqDj9GlFdAEXFSA4qrEX+TDPe06W6ytaEMGuMOt
 W/Tf1hUjvIuWVa3SmfaD/1dnMp0DybHsDLMXfIa9WcaMJCarUF4HIm4OuOXukee6Dj4I
 sfcg==
X-Gm-Message-State: AHQUAuYpAm5zsK7vSXc8wkN1mAKPhsZ1C+WcBG0P4JYIo+AzATsqpSC7
 +grgwdyAN3vqGIbaeKOoTe955A==
X-Google-Smtp-Source: AHgI3IbFAxB6fKRFfmp9yWT1Of894Cj7WwBvmlXO2Rvihw1xL1AuKvGTzBkDcY8aNr+fXZtIxWidaA==
X-Received: by 2002:a63:1c09:: with SMTP id c9mr6598223pgc.200.1549409106867; 
 Tue, 05 Feb 2019 15:25:06 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id g136sm5926917pfb.154.2019.02.05.15.25.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 15:25:06 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH 6/6] coresight: Use event attributes for sink selection
Date: Tue,  5 Feb 2019 16:24:58 -0700
Message-Id: <20190205232458.7074-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205232458.7074-1-mathieu.poirier@linaro.org>
References: <20190205232458.7074-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_152507_864992_E5972195 
X-CRM114-Status: GOOD (  22.01  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch uses the information conveyed by perf_event::attr::config2
to select a sink to use for the session.  That way a sink can easily be
selected to be used by more than one source, something that isn't currently
possible with the sysfs implementation.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 24 +++++------
 drivers/hwtracing/coresight/coresight-priv.h  |  1 +
 drivers/hwtracing/coresight/coresight.c       | 42 +++++++++++++++++++
 3 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index cdbdb28dc175..8c88bf0a1e5f 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -31,11 +31,14 @@ static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
 PMU_FORMAT_ATTR(cycacc,		"config:" __stringify(ETM_OPT_CYCACC));
 PMU_FORMAT_ATTR(timestamp,	"config:" __stringify(ETM_OPT_TS));
 PMU_FORMAT_ATTR(retstack,	"config:" __stringify(ETM_OPT_RETSTK));
+/* Sink ID - same for all ETMs */
+PMU_FORMAT_ATTR(sinkid,		"config2:0-31");
 
 static struct attribute *etm_config_formats_attr[] = {
 	&format_attr_cycacc.attr,
 	&format_attr_timestamp.attr,
 	&format_attr_retstack.attr,
+	&format_attr_sinkid.attr,
 	NULL,
 };
 
@@ -191,6 +194,7 @@ static void etm_free_aux(void *data)
 static void *etm_setup_aux(struct perf_event *event, void **pages,
 			   int nr_pages, bool overwrite)
 {
+	u32 id;
 	int cpu = event->cpu;
 	cpumask_t *mask;
 	struct coresight_device *sink;
@@ -201,18 +205,14 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
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
+	/* First get the selected sink from user space. */
+	if (event->attr.config2) {
+		id = (u32)event->attr.config2;
+		sink = coresight_get_sink_by_id(id);
+	} else {
+		sink = coresight_get_enabled_sink(true);
+	}
+
 	if (!sink || !sink_ops(sink)->alloc_buffer)
 		goto err;
 
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 579f34943bf1..b936c6d7e13f 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -147,6 +147,7 @@ void coresight_disable_path(struct list_head *path);
 int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data);
 struct coresight_device *coresight_get_sink(struct list_head *path);
 struct coresight_device *coresight_get_enabled_sink(bool reset);
+struct coresight_device *coresight_get_sink_by_id(u32 id);
 struct list_head *coresight_build_path(struct coresight_device *csdev,
 				       struct coresight_device *sink);
 void coresight_release_path(struct list_head *path);
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index d7fa90be6f42..29cef898afba 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -11,6 +11,7 @@
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/slab.h>
+#include <linux/stringhash.h>
 #include <linux/mutex.h>
 #include <linux/clk.h>
 #include <linux/coresight.h>
@@ -541,6 +542,47 @@ struct coresight_device *coresight_get_enabled_sink(bool deactivate)
 	return dev ? to_coresight_device(dev) : NULL;
 }
 
+static int coresight_sink_by_id(struct device *dev, void *data)
+{
+	struct coresight_device *csdev = to_coresight_device(dev);
+	unsigned long hash;
+
+	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
+	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
+
+		if (!csdev->ea)
+			return 0;
+		/*
+		 * See function etm_perf_add_symlink_sink() to know where
+		 * this comes from.
+		 */
+		hash = (unsigned long)csdev->ea->var;
+
+		if ((u32)hash == *(u32 *)data)
+			return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * coresight_get_sink_by_id - returns the sink that matches the id
+ * @id: Id of the sink to match
+ *
+ * The name of a sink is unique, whether it is found on the AMBA bus or
+ * otherwise.  As such the hash of that name can easily be used to identify
+ * a sink.
+ */
+struct coresight_device *coresight_get_sink_by_id(u32 id)
+{
+	struct device *dev = NULL;
+
+	dev = bus_find_device(&coresight_bustype, NULL, &id,
+			      coresight_sink_by_id);
+
+	return dev ? to_coresight_device(dev) : NULL;
+}
+
 /*
  * coresight_grab_device - Power up this device and any of the helper
  * devices connected to it for trace operation. Since the helper devices
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
