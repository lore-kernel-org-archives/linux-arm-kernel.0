Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0B3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:59:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F82F2186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dbkJY923";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ptMtJ10i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F82F2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Q2IoBF4wuAzvw4e0IaUkWYlS07ldJBhL+h3WrE044QM=; b=dbkJY9233Zy4k6OENzmiGzMyNA
	INTorROa/6CCNFX7Cme5KCSP7U2kkrVHMMqOPHtQFRxMg+DsDCeM7d548QjLzXoh7gLGpMoGgf9Lr
	A1FeUdP3rZ+Qae31v88tcIpt1fVMBMQ+y+iRJ7RqQuTtzReVOzheWcdjefp/YswKCigYP+3CEBvVY
	XK5uMScrc7238WieM0W5xq3XAF3a6ar+3MEkN/Lmx4HI7W/KsrMpad/y/2dwNoLWjxqV+8LYnY7VH
	ZMcGfLO5C/LKqIsbciRSg2ZoMG6bXyn4nXno+ihdLLVMWqKo3+IcDuFigZk6xOu7PT+rvLCsr/jIn
	FMCM2p6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz5MV-0007lq-B8; Wed, 27 Feb 2019 19:59:27 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz5Lq-00077K-MW
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 19:58:48 +0000
Received: by mail-lj1-x243.google.com with SMTP id z7so14812646lji.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 11:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TSS7UyhFKusvN1QpHYAVmHi7+a3wd/308ysavr6LVN8=;
 b=ptMtJ10idarPBBhSJWQpGuBKBGhqenLNPBTdRtzkXhpfmS6x+mMhr17ciOL+E70iCh
 f6hkNEk5ggSOdY3rNEPXcfvjVfP2RHUE8RmLBSjIHlW64LOP+leTar42vorMb15WS0KH
 Zbhbmxy1QShAHAEey5J9oWA9g2IF+hUFUFoJEaLSNnMTw66MkLlN9PpxZ5vPhCCTAaY0
 FrpSm3gRN42MHHfSaVIkHXLU+c26rK/2VlbxR4jeH3HdJLamhlSrjcehBrjqw4QVAduP
 aJ0ZpL73O2xmHfSchmda2kpu7zs71c22TNcrR81SJHVIw4vlbSo6kDANGA5nJds5Zkrd
 pzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=TSS7UyhFKusvN1QpHYAVmHi7+a3wd/308ysavr6LVN8=;
 b=rkWcM3m+u5nbfo/c8cjGv6uffUfrD3BQIFZIFQeMUt9Az2RRJP+hdf6sNu5LDL18Xg
 1ZYXlUSGJaRsopc3cg79w6JsrYhSRVGT6ek70SGrhUPZiW/cjLRlAt1LbrRZ/JJYf7fy
 nZxS3YecJhyLFt0BISfZVQcPRmhh9lC12m/TYIUJ5cCdXYgjBqCH2owKUxeW81PN14yT
 YqQT/NqZgpy97jSlKirC5nOlz4hPwLP4ApMj3zbBgPaSgRC1ReigQQNxo1ZhPOZGomMi
 TIxYALzoRIirHBtDvZmQBezI0cCHe4HwSnh8U9JLfuaFlYLPkLi31ThzrJZvzXxd75FT
 dHDw==
X-Gm-Message-State: APjAAAWroIjBOEox/Z7mb3mUK3OnJHQYdsvl76bL7xaI3g1zYW3kUDB9
 THXiLvJr0iknW7lQSTueFRAFYA==
X-Google-Smtp-Source: APXvYqwjqDWE4R2b9ofz0WGKpw59wybQYlw3ncmQN1cJUrxgGYZv7N3Z4XVAGwGVIXp+yGHvffbepw==
X-Received: by 2002:a2e:12da:: with SMTP id 87mr2462983ljs.181.1551297524743; 
 Wed, 27 Feb 2019 11:58:44 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id z128sm723802lfa.60.2019.02.27.11.58.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 Feb 2019 11:58:44 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH v12 2/4] PM / Domains: Add support for CPU devices to genpd
Date: Wed, 27 Feb 2019 20:58:34 +0100
Message-Id: <20190227195836.24739-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227195836.24739-1-ulf.hansson@linaro.org>
References: <20190227195836.24739-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_115846_733098_BBABEF61 
X-CRM114-Status: GOOD (  24.36  )
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

To enable a device belonging to a CPU to be attached to a PM domain managed
by genpd, let's do a few changes to it, as to make it convenient to manage
the specifics around CPUs.

To be able to quickly find out what CPUs that are attached to a genpd,
which typically becomes useful from a genpd governor as following changes
is about to show, let's add a cpumask to the struct generic_pm_domain. At
the point when a CPU device gets attached to a genpd, let's update the
genpd's cpumask. Moreover, let's also propagate changes to the cpumask
upwards in the topology to the master PM domains. In this way, the cpumask
for a genpd hierarchically reflects all CPUs attached to the topology below
it.

Finally, let's make this an opt-in feature, to avoid having to manage CPUs
and the cpumask for a genpd that doesn't need it. For that reason, let's
add a new genpd configuration bit, GENPD_FLAG_CPU_DOMAIN.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v12:
	- None.

---
 drivers/base/power/domain.c | 66 ++++++++++++++++++++++++++++++++++++-
 include/linux/pm_domain.h   | 13 ++++++++
 2 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 03885c003c6a..da10052e6427 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -20,6 +20,7 @@
 #include <linux/sched.h>
 #include <linux/suspend.h>
 #include <linux/export.h>
+#include <linux/cpu.h>
 
 #include "power.h"
 
@@ -126,6 +127,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 #define genpd_is_irq_safe(genpd)	(genpd->flags & GENPD_FLAG_IRQ_SAFE)
 #define genpd_is_always_on(genpd)	(genpd->flags & GENPD_FLAG_ALWAYS_ON)
 #define genpd_is_active_wakeup(genpd)	(genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
+#define genpd_is_cpu_domain(genpd)	(genpd->flags & GENPD_FLAG_CPU_DOMAIN)
 
 static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
@@ -1452,6 +1454,56 @@ static void genpd_free_dev_data(struct device *dev,
 	dev_pm_put_subsys_data(dev);
 }
 
+static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
+				   int cpu, bool set, unsigned int depth)
+{
+	struct gpd_link *link;
+
+	if (!genpd_is_cpu_domain(genpd))
+		return;
+
+	list_for_each_entry(link, &genpd->slave_links, slave_node) {
+		struct generic_pm_domain *master = link->master;
+
+		genpd_lock_nested(master, depth + 1);
+		__genpd_update_cpumask(master, cpu, set, depth + 1);
+		genpd_unlock(master);
+	}
+
+	if (set)
+		cpumask_set_cpu(cpu, genpd->cpus);
+	else
+		cpumask_clear_cpu(cpu, genpd->cpus);
+}
+
+static void genpd_update_cpumask(struct generic_pm_domain *genpd,
+				 struct device *dev, bool set)
+{
+	int cpu;
+
+	if (!genpd_is_cpu_domain(genpd))
+		return;
+
+	for_each_possible_cpu(cpu) {
+		if (get_cpu_device(cpu) == dev) {
+			__genpd_update_cpumask(genpd, cpu, set, 0);
+			return;
+		}
+	}
+}
+
+static void genpd_set_cpumask(struct generic_pm_domain *genpd,
+			      struct device *dev)
+{
+	genpd_update_cpumask(genpd, dev, true);
+}
+
+static void genpd_clear_cpumask(struct generic_pm_domain *genpd,
+				struct device *dev)
+{
+	genpd_update_cpumask(genpd, dev, false);
+}
+
 static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 			    struct gpd_timing_data *td)
 {
@@ -1473,6 +1525,8 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (ret)
 		goto out;
 
+	genpd_set_cpumask(genpd, dev);
+
 	dev_pm_domain_set(dev, &genpd->domain);
 
 	genpd->device_count++;
@@ -1534,6 +1588,7 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 	if (genpd->detach_dev)
 		genpd->detach_dev(genpd, dev);
 
+	genpd_clear_cpumask(genpd, dev);
 	dev_pm_domain_set(dev, NULL);
 
 	list_del_init(&pdd->list_node);
@@ -1767,11 +1822,18 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	if (genpd_is_always_on(genpd) && !genpd_status_on(genpd))
 		return -EINVAL;
 
+	if (genpd_is_cpu_domain(genpd) &&
+	    !zalloc_cpumask_var(&genpd->cpus, GFP_KERNEL))
+		return -ENOMEM;
+
 	/* Use only one "off" state if there were no states declared */
 	if (genpd->state_count == 0) {
 		ret = genpd_set_default_power_state(genpd);
-		if (ret)
+		if (ret) {
+			if (genpd_is_cpu_domain(genpd))
+				free_cpumask_var(genpd->cpus);
 			return ret;
+		}
 	} else if (!gov) {
 		pr_warn("%s : no governor for states\n", genpd->name);
 	}
@@ -1817,6 +1879,8 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 	list_del(&genpd->gpd_list_node);
 	genpd_unlock(genpd);
 	cancel_work_sync(&genpd->power_off_work);
+	if (genpd_is_cpu_domain(genpd))
+		free_cpumask_var(genpd->cpus);
 	if (genpd->free_states)
 		genpd->free_states(genpd->states, genpd->state_count);
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 8e1399231753..a6e251fe9deb 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/notifier.h>
 #include <linux/spinlock.h>
+#include <linux/cpumask.h>
 
 /*
  * Flags to control the behaviour of a genpd.
@@ -42,11 +43,22 @@
  * GENPD_FLAG_ACTIVE_WAKEUP:	Instructs genpd to keep the PM domain powered
  *				on, in case any of its attached devices is used
  *				in the wakeup path to serve system wakeups.
+ *
+ * GENPD_FLAG_CPU_DOMAIN:	Instructs genpd that it should expect to get
+ *				devices attached, which may belong to CPUs or
+ *				possibly have subdomains with CPUs attached.
+ *				This flag enables the genpd backend driver to
+ *				deploy idle power management support for CPUs
+ *				and groups of CPUs. Note that, the backend
+ *				driver must then comply with the so called,
+ *				last-man-standing algorithm, for the CPUs in the
+ *				PM domain.
  */
 #define GENPD_FLAG_PM_CLK	 (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
 #define GENPD_FLAG_ALWAYS_ON	 (1U << 2)
 #define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
+#define GENPD_FLAG_CPU_DOMAIN	 (1U << 4)
 
 enum gpd_status {
 	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
@@ -94,6 +106,7 @@ struct generic_pm_domain {
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
 	unsigned int performance_state;	/* Aggregated max performance state */
+	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
 	struct opp_table *opp_table;	/* OPP table of the genpd */
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
