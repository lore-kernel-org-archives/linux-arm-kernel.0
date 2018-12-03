Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B30C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:56:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B61D22145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JJboIv6t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RrOlJSG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61D22145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=itStHs4CUMWna+BOzqqHaTC2O3ZqoGMfnwWlZxw/kis=; b=JJboIv6tvBb4FyAeIQ7/GO7oe4
	TsKO+hOzKWuc4+gXPQc8N6i1amdVs7rc0ntwM1mzMUX1sFhJXz9EVPHMDlBv9p3amQFlz8HfGhwU3
	r/2Qsc8xiwPgzcTSI/ALYIP3+SE8QHS1NS/DiATj1Y/f6xbXSwIfYoEQEQuPjNhDo+QU3siZExPMm
	J+7VQeAxPf4Opokwa1AWL4AGTOpUPTP2+fbI/Gss2L7LNTdQm/zdCRn7/Isw5I/1jqlLEfatkwtVu
	nei/poi0I9+zZeSWXx6HhrrpvyHM/gp7unu42l2zgUre+SA/3VGz6xGc7vz2kq8TP7wyzollT2+Wv
	REMVK8jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTx8P-00040Z-O3; Mon, 03 Dec 2018 22:56:13 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTx7R-0001fZ-Dx
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 22:55:16 +0000
Received: by mail-pf1-x443.google.com with SMTP id u6so7119399pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 14:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BBqRtwO6PGFlctrxGALj04LHSsu+aeiHiAedSoB+rfE=;
 b=RrOlJSG+Y3gW+Hafk4V78OWWfljaTZ5GM8h7jKFhNzSrBGauShndYBsxuAvE5uJLyO
 4DyEUr9wBXtcSPvf43JR49GhFDGwG0cvN3+CK3ONl/CwdPAtZJjuIT6zg2bZoVSPDpuv
 870pz5JUGRNp4Yo84G2tgEbopj8SYXZGe+XCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BBqRtwO6PGFlctrxGALj04LHSsu+aeiHiAedSoB+rfE=;
 b=tOQ64OG1mp+2tVto6kqfyNG4fvOJRd5eFXREQWhuYBZlVnV5/HIMxSPa/a28llEP+b
 azJPQTpN+mbtvrhInrS7IAQYIejOCH6S5iqgj/Q3L2w8w4EXQVw/SjijXN4vINR1ePC2
 GzDkqXvY/rap7UKEsN8WfrDX4cywccDbCLOb8tICzfQCjztKB63WwmBLiIXQLPpvXBrW
 Y9R7lmGXxD84vj02pnY7AccsJYuUn9fFIMFo7+aeKdOyoM1us1M73CiNNeR/kpleAfeI
 +AusbrefjGDdNxYdmkWxx0RP56JPpfdfG3GIQBKZwIUNabMLGMR7o3PeO4a0aQao97gL
 GSaA==
X-Gm-Message-State: AA+aEWZ1n990yX9ImMQLQ5Y5tux0zgpJnKc7M0MT1HlO21uw/LBkzglc
 XURT4OXC1pHX0T/hsqmB8d9nGg==
X-Google-Smtp-Source: AFSGD/W5+iPnfp7wUKDIF0Ne85dncUb/tNL7nN1NSX3EyKppb1J6RLDsXadxXHnnvCeNj5LeEqLDfw==
X-Received: by 2002:a63:c10f:: with SMTP id w15mr14594722pgf.199.1543877702346; 
 Mon, 03 Dec 2018 14:55:02 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id v9sm20933057pfg.144.2018.12.03.14.55.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 03 Dec 2018 14:55:01 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org,
	peterz@infradead.org,
	gregkh@linuxfoundation.org
Subject: [PATCH v5 2/6] perf/core: Use ioctl to communicate driver
 configuration to kernel
Date: Mon,  3 Dec 2018 15:54:52 -0700
Message-Id: <1543877696-17174-3-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543877696-17174-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543877696-17174-1-git-send-email-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_145513_468336_DE91B9A2 
X-CRM114-Status: GOOD (  19.35  )
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

This patch adds the mechanic needed for user space to send PMU specific
configuration to the kernel driver using an ioctl() command.  That way
events can keep track of options that don't fit in the perf_event_attr
structure like the selection of a CoreSight sink to use for the session.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/perf_event.h | 38 ++++++++++++++++++++++++++
 kernel/events/core.c       | 67 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 53c500f0ca79..8e69b7e309e7 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -114,6 +114,14 @@ struct hw_perf_event_extra {
 	int		idx;	/* index in shared_regs->regs[] */
 };
 
+/*
+ * PMU driver configuration
+ */
+struct pmu_drv_config {
+	void		*config;
+	raw_spinlock_t	lock;
+};
+
 /**
  * struct hw_perf_event - performance event hardware details:
  */
@@ -178,6 +186,9 @@ struct hw_perf_event {
 	/* Last sync'ed generation of filters */
 	unsigned long			addr_filters_gen;
 
+	/* PMU driver configuration */
+	struct pmu_drv_config		drv_config;
+
 /*
  * hw_perf_event::state flags; used to track the PERF_EF_* state.
  */
@@ -447,6 +458,17 @@ struct pmu {
 	 * Filter events for PMU-specific reasons.
 	 */
 	int (*filter_match)		(struct perf_event *event); /* optional */
+
+	/*
+	 * Validate complex PMU configuration that don't fit in the
+	 * perf_event_attr struct.  Returns a PMU specific pointer or an error
+	 * value < 0.
+	 *
+	 * As with addr_filters_validate(), runs in the context of the ioctl()
+	 * process and is not serialized with the rest of the PMU callbacks.
+	 */
+	void *(*drv_config_validate)	(struct perf_event *event,
+					 u64 value);
 };
 
 enum perf_addr_filter_action_t {
@@ -1235,6 +1257,11 @@ static inline bool has_addr_filter(struct perf_event *event)
 	return event->pmu->nr_addr_filters;
 }
 
+static inline bool has_drv_config(struct perf_event *event)
+{
+	return event->pmu->drv_config_validate;
+}
+
 /*
  * An inherited event uses parent's filters
  */
@@ -1249,6 +1276,17 @@ perf_event_addr_filters(struct perf_event *event)
 	return ifh;
 }
 
+static inline struct pmu_drv_config *
+perf_event_get_drv_config(struct perf_event *event)
+{
+	struct pmu_drv_config *cfg = &event->hw.drv_config;
+
+	if (event->parent)
+		cfg = &event->parent->hw.drv_config;
+
+	return cfg;
+}
+
 extern void perf_event_addr_filters_sync(struct perf_event *event);
 
 extern int perf_output_begin(struct perf_output_handle *handle,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 84530ab358c3..af7a53c97744 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5003,6 +5003,8 @@ static inline int perf_fget_light(int fd, struct fd *p)
 static int perf_event_set_output(struct perf_event *event,
 				 struct perf_event *output_event);
 static int perf_event_set_filter(struct perf_event *event, void __user *arg);
+static int perf_event_set_drv_config(struct perf_event *event,
+				     void __user *arg);
 static int perf_event_set_bpf_prog(struct perf_event *event, u32 prog_fd);
 static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			  struct perf_event_attr *attr);
@@ -5089,6 +5091,10 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 
 		return perf_event_modify_attr(event,  &new_attr);
 	}
+
+	case PERF_EVENT_IOC_SET_DRV_CONFIG:
+		return perf_event_set_drv_config(event, (void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
@@ -9128,6 +9134,66 @@ static int perf_event_set_filter(struct perf_event *event, void __user *arg)
 	return ret;
 }
 
+static void perf_drv_config_replace(struct perf_event *event, void *drv_data)
+{
+	unsigned long flags;
+	struct pmu_drv_config *drv_config = &event->hw.drv_config;
+
+	if (!has_drv_config(event))
+		return;
+
+	/* Children take their configuration from their parent */
+	if (event->parent)
+		return;
+
+	/* Make sure the PMU doesn't get a handle on the data */
+	raw_spin_lock_irqsave(&drv_config->lock, flags);
+	drv_config->config = drv_data;
+	raw_spin_unlock_irqrestore(&drv_config->lock, flags);
+}
+
+static int
+perf_event_process_drv_config(struct perf_event *event, u64 value)
+{
+	int ret = -EINVAL;
+	void *drv_data;
+
+	/* Make sure ctx.mutex is held */
+	lockdep_assert_held(&event->ctx->mutex);
+
+	/* Children take their configuration from their parent */
+	if (WARN_ON_ONCE(event->parent))
+		goto out;
+
+	drv_data = event->pmu->drv_config_validate(event, value);
+	if (IS_ERR(drv_data)) {
+		ret = PTR_ERR(drv_data);
+		goto out;
+	}
+
+	perf_drv_config_replace(event, drv_data);
+
+	ret = 0;
+out:
+	return ret;
+}
+
+static int perf_event_set_drv_config(struct perf_event *event, void __user *arg)
+{
+	int ret;
+	u64 value;
+
+	if (!has_drv_config(event))
+		return -EINVAL;
+
+	if (copy_from_user(&value, arg, sizeof(value)))
+		return -EFAULT;
+
+	ret = perf_event_process_drv_config(event, value);
+
+	return ret;
+}
+
 /*
  * hrtimer based swevent callback
  */
@@ -10052,6 +10118,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (attr->freq && attr->sample_freq)
 		hwc->sample_period = 1;
 	hwc->last_period = hwc->sample_period;
+	raw_spin_lock_init(&hwc->drv_config.lock);
 
 	local64_set(&hwc->period_left, hwc->sample_period);
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
