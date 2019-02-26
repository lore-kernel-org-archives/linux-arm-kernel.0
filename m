Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966B1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:56:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66ED220C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hULDaMJo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LcfqNnOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66ED220C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=hn71MhHZL6KXERpbmrvjC2W/qzDZPPb8OTSb0oO9BiM=; b=hULDaMJoXtjGqyY95MuJyLlh0M
	YiZPnMZU9mnQcMkEfWTJ1k0rhFpwg8TiSbzPGoYyJuTObDjT2avIxvcFcUM47GL9sZkK6dLyIvBrm
	hL4zQ1UsqpJH5KSyWCoVdeXJlKlfdxn72+6o4B6tCqF3oVToWDzm5XI9t9kGkDNVlfgV06V4rJFVc
	S62VaC+Gpp5p7jBmkIChpJfiOZI1acYaUKbnXk5X5gGONqLA3SWCeeuqSu5mv5XZI3Y/PIODAoItd
	m8rT0xV9eld7bX8ZgbGW7VDaY3Sk5enffGMQwgwgm5286wajvzg8lT5lecVPPJ/KcA08zRGOdEj2E
	nonEvWIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gye9f-0000Ak-Mi; Tue, 26 Feb 2019 14:56:23 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gye85-0005Ux-3C
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 14:54:50 +0000
Received: by mail-lf1-x144.google.com with SMTP id x206so1827447lff.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 06:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yH4pjF02915u7o7IIseXUbpxw7HKHFLB85eZ2Pu4HjQ=;
 b=LcfqNnOPimrzqobeUbqhTtKZ1YN1ejQMSpxKzAFD9I+5AHFqLvX9WTAorjPQH2Pgf7
 R2STDsz2lwqog2F/WWcF4LHVfD8Mf/Njvu6dfMmgpoYwhuGGZQA402/oOsbBFGf4223F
 pkyRbiC7EZwV6bLwFgnuuskyI1X5hYnS+bo0SNpHjVzHfEg7JAyhxbAtAEnYEKdTScsH
 p4SP1K4+GwVeNtefCEb97Hq2CYW50QS1xIVd/QOHePoTGqocjgxhKnopL0SGUMSUMW9/
 bHrFADb4TDZGr9aqyBBLiEEZ0xbNqTT63ofOfrjUJJwgVq754UrTtDLd40erGj7ou4ao
 og5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=yH4pjF02915u7o7IIseXUbpxw7HKHFLB85eZ2Pu4HjQ=;
 b=NMsGyTvl3yAoZ1nP6NeB1izjLtE8lPao97ugW7NF136fVGs2E3/IEw4u1zRp+Th+H9
 e8XjjgMykgiO/8DrmFOlGzvS9re/FJKFQz/Z2uyt9R0dC5xLGTrwCg6ZDVaYJH5xdoGS
 0f2K+VmQxkqEyZezeVsmCf5dJNCyjCDJH0wMKii08MIO4tB7eb9P9iVcPKeJuz2LIx3V
 IVkaP75ubN8OdzHHGyLjJUFgbOkFiYuDvhkuNy5thQm8zrk+nvGKIJKmMtpQOJFGgez5
 HpvUCOx33PsfqLabdwkmhLtOvsII/r9y9lOYUeioQpCKBen4RZ2cC3fbAPQh1hMGNQXr
 mU6w==
X-Gm-Message-State: AHQUAubb+JyLnhw5yze8JlYqDhOZy+TU9IpyjSR9NxmnlpdGCXSEQtdI
 V+XkP+9dgGO75mLVZ3xBnxR6zg==
X-Google-Smtp-Source: AHgI3IYVI3uMWxE1NkMGYvg/8bPIENwiMsuV5I0+KkNgjN4De5RbbW1SRU+01hAgWVNknehZ+xn3vg==
X-Received: by 2002:ac2:411a:: with SMTP id b26mr14677379lfi.169.1551192883264; 
 Tue, 26 Feb 2019 06:54:43 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id t11sm2206554ljj.92.2019.02.26.06.54.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 06:54:42 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH v11 8/8] PM / Domains: Add genpd governor for CPUs
Date: Tue, 26 Feb 2019 15:54:15 +0100
Message-Id: <20190226145415.19411-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226145415.19411-1-ulf.hansson@linaro.org>
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_065445_768544_A1797882 
X-CRM114-Status: GOOD (  23.05  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Frederic Weisbecker <fweisbec@gmail.com>, linux-arm-msm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
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
time, we use the information about the next timer/tick that is stored in
the per CPU variable, cpuidle_devices, for the related CPUs. Future wise,
this deserves to be improved, as there are obviously more reasons to why a
CPU may be woken up from idle.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v11:
	- Updated to use the data about the next timer/tick, pre-stored in the
	per CPU variable, cpuidle_devices.

---
 drivers/base/power/domain_governor.c | 62 +++++++++++++++++++++++++++-
 include/linux/pm_domain.h            |  3 ++
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 99896fbf18e4..d950ec24ed0e 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -10,6 +10,9 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
 #include <linux/hrtimer.h>
+#include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/ktime.h>
 
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
 
@@ -245,6 +251,55 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
 	return false;
 }
 
+static bool cpu_power_down_ok(struct dev_pm_domain *pd)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+	struct cpuidle_device *dev;
+	ktime_t domain_wakeup;
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
+		dev = per_cpu(cpuidle_devices, cpu);
+		if (dev && ktime_before(dev->next_timer, domain_wakeup))
+			domain_wakeup = dev->next_timer;
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
@@ -257,3 +312,8 @@ struct dev_power_governor pm_domain_always_on_gov = {
 	.power_down_ok = always_on_power_down_ok,
 	.suspend_ok = default_suspend_ok,
 };
+
+struct dev_power_governor pm_domain_cpu_gov = {
+	.suspend_ok = default_suspend_ok,
+	.power_down_ok = cpu_power_down_ok,
+};
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index a6e251fe9deb..ae7061556a26 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -118,6 +118,7 @@ struct generic_pm_domain {
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
 	bool cached_power_down_ok;
+	bool cached_power_down_state_idx;
 	int (*attach_dev)(struct generic_pm_domain *domain,
 			  struct device *dev);
 	void (*detach_dev)(struct generic_pm_domain *domain,
@@ -202,6 +203,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
+extern struct dev_power_governor pm_domain_cpu_gov;
 #else
 
 static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
@@ -245,6 +247,7 @@ static inline int dev_pm_genpd_set_performance_state(struct device *dev,
 
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
