Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBFAC43610
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:49:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A9CB21104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G03rzrMu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dILkK4RW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9CB21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=DWwiyghC/FDXzaoeEL9W8BT5P7mkhHzK8C8kLn6x/NE=; b=G03rzrMu1HDN1HEyuZ++Zr1AgK
	Ui7NvOsw44iNFrvDd7V4GKyD9zRVlMfq2BPMiFICBO14GXhQT+gg50NxIBgfrsoyjyfEEtFYEvEsE
	HLAbHUtW/8+8XmVAwpp8zN5S7rji7tSinSTmnN4j+BAsgvuh/vXlifRv7igrIUbXKdYDm+7jAVD3i
	8enX1uTcH8dMbv2ZZ0pe1RgCI/Bt+0J0xN/eBZsjo8r/JuNHYlneW8019l6PSLUYs8Ed2ULfsDpTO
	6/ufp1p7oJ0I7ZTL9AMMmPGMEtz5NiSrRf9UeADpWJwj9P2TcPuTj7I4p/xhffT2zlQGUJbrMBBVU
	OimyYu2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQRN-0002yp-O6; Thu, 29 Nov 2018 17:49:29 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQPP-00016o-EC
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:47:31 +0000
Received: by mail-lj1-x241.google.com with SMTP id c19-v6so2529975lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 09:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=LzzPQT8slGTRdAVsQgdHTCQbGTst2gOxOptahoBqO9s=;
 b=dILkK4RWalKTSDKmHx8vHWZzFrLAYdDwsijfwltyCZ5q81SUkAbXChhyYAH690o8uT
 YXrNqbelHdj7mx78PYx8fMaH0V6BiqOJPLNifA9NX2ReN9IupraVd9AnS3YdarHdguIV
 vPW5aGAjRw2YW+/7qfV8LJFKjibK4f+JLgKNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=LzzPQT8slGTRdAVsQgdHTCQbGTst2gOxOptahoBqO9s=;
 b=UgvXbrhE2/g2WUltIGHGzhoc783oN/qBvvum2bN64Vb9DFQy6fkvwrT+XLa6QHXJ3T
 RU8mK5igFo/b16kPb8qonwnCjyS+sMJGtkkKZwZ2n2z0yHA0iNwiGizcWzbbwtk0l6F1
 YsuzuZ9EdCf/pyP7I9evdZtXnXfhmBGaYfCvQilm/sxnu2iCwyMMGLAEiZar/8m06rzK
 3i+pKua64WQ0592oLP0G5doi5rzKdVT+/gYSHK3omQO8uQOmHlF4IMyggPuc/DodXILj
 p7xcxlrmT2voKzFNEzPVwBIEKSZ6TWwsAmtq/9iO2IJnn5uZ5GlKrK1L/32iCroGX3eG
 wcTw==
X-Gm-Message-State: AA+aEWYVtipYoihIQh0XSkTZnALvmk7r27yrB/SMFRXI+6Qfff1Y0Qei
 wTUs6JXBaNkHHIpokbjBgYwcTQ==
X-Google-Smtp-Source: AFSGD/XpXCMxYWmRpXFvesL23Sbaaj0TtiVDelVwR/zWUS9DrajaWZlFr/9hlupx5uyQBOILggxyJQ==
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr1748886ljj.9.1543513635515; 
 Thu, 29 Nov 2018 09:47:15 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 09:47:14 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v10 04/27] PM / Domains: Add genpd governor for CPUs
Date: Thu, 29 Nov 2018 18:46:37 +0100
Message-Id: <20181129174700.16585-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_094728_009746_BF18587C 
X-CRM114-Status: GOOD (  24.08  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 Lina Iyer <ilina@codeaurora.org>, Frederic Weisbecker <fweisbec@gmail.com>,
 Tony Lindgren <tony@atomide.com>, linux-arm-msm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

As it's now perfectly possible that a PM domain managed by genpd contains
devices belonging to CPUs, we should start to take into account the
residency values for the idle states during the state selection process.
The residency value specifies the minimum duration of time, the CPU or a
group of CPUs, needs to spend in an idle state to not waste energy entering
it.

To deal with this, let's add a new genpd governor, pm_domain_cpu_gov, that
may be used for a PM domain that have CPU devices attached or if the CPUs
are attached through subdomains.

The new governor computes the minimum expected idle duration time for the
online CPUs being attached to the PM domain and its subdomains. Then in the
state selection process, trying the deepest state first, it verifies that
the idle duration time satisfies the state's residency value.

It should be noted that, when computing the minimum expected idle duration
time, we use the information from tick_nohz_get_next_wakeup(), to find the
next wakeup for the related CPUs. Future wise, this may deserve to be
improved, as there are more reasons to why a CPU may be woken up from idle.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- Fold in patch that extended the new genpd CPU governor to cope with
	  QoS constraints, as to avoid confusion.
	- Simplified the code according to suggestions from Rafael.

---
 drivers/base/power/domain_governor.c | 61 +++++++++++++++++++++++++++-
 include/linux/pm_domain.h            |  3 ++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 99896fbf18e4..61a7c3c03c98 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -10,6 +10,9 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
 #include <linux/hrtimer.h>
+#include <linux/cpumask.h>
+#include <linux/ktime.h>
+#include <linux/tick.h>
 
 static int dev_update_qos_constraint(struct device *dev, void *data)
 {
@@ -211,8 +214,10 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
 	struct gpd_link *link;
 
-	if (!genpd->max_off_time_changed)
+	if (!genpd->max_off_time_changed) {
+		genpd->state_idx = genpd->cached_power_down_state_idx;
 		return genpd->cached_power_down_ok;
+	}
 
 	/*
 	 * We have to invalidate the cached results for the masters, so
@@ -237,6 +242,7 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 		genpd->state_idx--;
 	}
 
+	genpd->cached_power_down_state_idx = genpd->state_idx;
 	return genpd->cached_power_down_ok;
 }
 
@@ -245,6 +251,54 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
 	return false;
 }
 
+static bool cpu_power_down_ok(struct dev_pm_domain *pd)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+	ktime_t domain_wakeup, cpu_wakeup;
+	s64 idle_duration_ns;
+	int cpu, i;
+
+	/* Validate dev PM QoS constraints. */
+	if (!default_power_down_ok(pd))
+		return false;
+
+	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
+		return true;
+
+	/*
+	 * Find the next wakeup for any of the online CPUs within the PM domain
+	 * and its subdomains. Note, we only need the genpd->cpus, as it already
+	 * contains a mask of all CPUs from subdomains.
+	 */
+	domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
+	for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
+		cpu_wakeup = tick_nohz_get_next_wakeup(cpu);
+		if (ktime_before(cpu_wakeup, domain_wakeup))
+			domain_wakeup = cpu_wakeup;
+	}
+
+	/* The minimum idle duration is from now - until the next wakeup. */
+	idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, ktime_get()));
+	if (idle_duration_ns <= 0)
+		return false;
+
+	/*
+	 * Find the deepest idle state that has its residency value satisfied
+	 * and by also taking into account the power off latency for the state.
+	 * Start at the state picked by the dev PM QoS constraint validation.
+	 */
+	i = genpd->state_idx;
+	do {
+		if (idle_duration_ns >= (genpd->states[i].residency_ns +
+		    genpd->states[i].power_off_latency_ns)) {
+			genpd->state_idx = i;
+			return true;
+		}
+	} while (--i >= 0);
+
+	return false;
+}
+
 struct dev_power_governor simple_qos_governor = {
 	.suspend_ok = default_suspend_ok,
 	.power_down_ok = default_power_down_ok,
@@ -257,3 +311,8 @@ struct dev_power_governor pm_domain_always_on_gov = {
 	.power_down_ok = always_on_power_down_ok,
 	.suspend_ok = default_suspend_ok,
 };
+
+struct dev_power_governor pm_domain_cpu_gov = {
+	.suspend_ok = default_suspend_ok,
+	.power_down_ok = cpu_power_down_ok,
+};
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 5a4673605d22..969a9b36c0db 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -116,6 +116,7 @@ struct generic_pm_domain {
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
 	bool cached_power_down_ok;
+	bool cached_power_down_state_idx;
 	int (*attach_dev)(struct generic_pm_domain *domain,
 			  struct device *dev);
 	void (*detach_dev)(struct generic_pm_domain *domain,
@@ -195,6 +196,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
+extern struct dev_power_governor pm_domain_cpu_gov;
 #else
 
 static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
@@ -238,6 +240,7 @@ static inline int dev_pm_genpd_set_performance_state(struct device *dev,
 
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
+#define pm_domain_cpu_gov		(*(struct dev_power_governor *)(NULL))
 #endif
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS_SLEEP
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
