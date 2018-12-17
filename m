Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9955EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:22:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 684692133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hKzwLsIn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C4nqGzh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684692133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=itStHs4CUMWna+BOzqqHaTC2O3ZqoGMfnwWlZxw/kis=; b=hKzwLsIndPdqgWpb9W/ed9Uh7P
	mARXhpniPOviMpvmZRiBRvlvl3KYG3R27PcLAc2XGSuBpMwb4x19FHQn/atw3PL4DnbnAbghP9w9y
	dk8BX9gpD433P464F/VkF9JrpJU8AoO3tv+3DC82ZYkTstHxMKigF7H7YsWx39RvYy1MbbvZoyKeK
	F4PpB3EL7l7+Xol8kp4Q47oMlSjZW/FIlblNeyzf8nZPxKceU8CQACCRy0R/SZYv18qfPlzHk3c31
	BI9u7Yaw58qmUEpiaJz0wecGQIqEg73EmKIy/8Bo7hZyCfMmYIvyoeuqqOy7Utb0fPCJLP4LCawW0
	UfY3b1Aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYwbT-0004V8-Oq; Mon, 17 Dec 2018 17:22:51 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYwah-0003mG-LM
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 17:22:08 +0000
Received: by mail-pl1-x644.google.com with SMTP id gn14so6435546plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 09:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BBqRtwO6PGFlctrxGALj04LHSsu+aeiHiAedSoB+rfE=;
 b=C4nqGzh5cPKSL5/IPhN70S1CecaokCmGiC2UXWLUIX8Jb+zGXeG8cV3FViYapKUt9P
 JtXBFdraKVQej2cL9Lsa2nSV/XFm0HcIRBNqSIoye+CvqslcB3S9Hu7O2Q+1Ljkw7MqG
 +LqxmQIWHJywbSjjqIz9NvNmGwKFJsf96HVaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BBqRtwO6PGFlctrxGALj04LHSsu+aeiHiAedSoB+rfE=;
 b=hx0FFKkiD+Vsr1rxBYAfjqO5JzGT3SeES7AEUC2j5poth2MKoZXrVeC0CnZzdt2v+C
 EkZCrXolCMEiYYT5801BGvh6F8RyOXL+kh2LJnPLleOPG+4V62G0y1huKzccjeGrZkS8
 KJKHYVHo7jmbrUqgQSVyNkTR9aYP0Mx0snnBjC4/K4tJ5VQ4XQcvq4dcguHpPOlzduk1
 RUma8cSEmiRZ99QEm84MNEX2M8p2l9eoCYbVw5/fThyL1TPUUaM16FH8jWLW1olAXiZ6
 Umfrw6alUj9/z49F4wjUsXAZduwH0cxdik4L0s4pIWG4wenjZJRN0g6LewGWzOz6kjTa
 bw7w==
X-Gm-Message-State: AA+aEWY45mT1Etykt0pRhS3ZTjAKVBN1jt6W4TADyRCmMJjDrAn2YuV3
 Als8cj5wDwu1sk8jAT7kfZ4vXg==
X-Google-Smtp-Source: AFSGD/VQdQ5g0qC8bZxRHPUXsx85VHoFCrYhPxSv0pYoQzQQtJHyVLA+jZdwJzZiMX/6Y9UnrBEAxQ==
X-Received: by 2002:a17:902:128c:: with SMTP id
 g12mr12797936pla.146.1545067312998; 
 Mon, 17 Dec 2018 09:21:52 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id j6sm20526648pfg.126.2018.12.17.09.21.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 17 Dec 2018 09:21:52 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org,
	peterz@infradead.org,
	gregkh@linuxfoundation.org
Subject: [RESEND PATCH v5 2/6] perf/core: Use ioctl to communicate driver
 configuration to kernel
Date: Mon, 17 Dec 2018 10:21:42 -0700
Message-Id: <1545067306-31687-3-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_092203_709267_3002BF70 
X-CRM114-Status: GOOD (  18.77  )
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
