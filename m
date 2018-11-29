Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B04BC43610
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:51:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB7BA21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mRF/hE0x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KEysZzFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7BA21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=3VGheSLqVsOiq+4NM0X/B4jlvSA7mOhKE5e5ss73K+I=; b=mRF/hE0xNgJVK0V8yBPHoD2QNU
	/35B6xBzLKr31BXDKo4VYD8ZkObalhHnr4SSfLP0g0gLLWWxToLZY2gDrhUAfKeYOL8XqDLiKMF1e
	zf6ZCsCqP9e9VOQIXRJTX7ilvY2o3Mw78nvqGF/65BPKyEm3jX83Lq9xdupLUeN/nONigznd/p91+
	MDzoCQV3x3jcUQ8v2m7LCd++I+3U8NFNjALMVZ/yA1A13FxhuhpsTkcI28rk1B/774WqVKr1P4FfI
	QLWDU+2QYyaIe5hc/BZOp/GTXGRiDEG20voFmMpMCAUGzphUQSXqdwRyoSMX05BmCNzMQtWB+WThw
	G6KMoMNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQT0-0005iZ-BO; Thu, 29 Nov 2018 17:51:10 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQPh-0001O9-Hl
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:47:54 +0000
Received: by mail-lj1-x243.google.com with SMTP id v1-v6so2548915ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 09:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=e32vtX78zxUwZdARdRnc8l3DtzZQ8eqcggPXtqP0zBQ=;
 b=KEysZzFGJmbrVuXD6nyO5z9OhL9wjdJKpDDxNsGW3Xgb9aX/264Uhdj0nKKs97L4ox
 anBSD7NPURP8VxEu6uWdPd2fm6kavvkoA1uBrrGUDbRl4rI13BDoJqG6CbcElhabT+FI
 xOigQqnmHK5Shk2fhopOfyi7YxBVDwo69yhhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=e32vtX78zxUwZdARdRnc8l3DtzZQ8eqcggPXtqP0zBQ=;
 b=d+0g4q6m5lw0qIwjSeVLuuLebJB8qpt9IFqaNFKz1vTcGb+HdJEDNYkqlSYxxU3Hwt
 YS2YyQITO84GQC4gVaxBa6BjeePxM1qLBO2FSVzciMy5VTrac0sdX5ogE5RL330ZYTXp
 DE2PLmAPiWEqEJifnYz9sfFHOgAir6pZd8rAZYbEaYsjtonvQEj8+Q3UeSO1gUQ4ZJEK
 AwYGSNSra5rBBTodRxyfvDFunx1pqEM2jhT4R+HQ6VZ2GeUmrs2yctHkZTt85z4MD7lQ
 bfLjmti7ITGz3T718bM4uy32DXvAaTfkXv2N7ffrz3sLiCpfNoqZnUSMKsv26UjYfIM4
 5iGA==
X-Gm-Message-State: AA+aEWbxUKHWUwlkt/rugbf4D71rUjJut7PR8YSYqUpd2Dm4jpqNRh+I
 upDwXFNuSdPUevuGbMpuFErWuA==
X-Google-Smtp-Source: AFSGD/XAh5uAfM3h1tYCGpFtPOIr3uABpAC4dKUb+fC3N4O4NUkkG8U5ov3ggi0lwmKgkwM1KtFTYQ==
X-Received: by 2002:a2e:9f56:: with SMTP id
 v22-v6mr1708430ljk.114.1543513660054; 
 Thu, 29 Nov 2018 09:47:40 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 09:47:39 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v10 18/27] drivers: firmware: psci: Add support for PM domains
 using genpd
Date: Thu, 29 Nov 2018 18:46:51 +0100
Message-Id: <20181129174700.16585-19-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_094746_540917_9B94EF20 
X-CRM114-Status: GOOD (  30.47  )
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
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 linux-arm-msm@vger.kernel.org,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When the hierarchical CPU topology layout is used in DT, we need to setup
the corresponding PM domain data structures, as to allow a CPU and a group
of CPUs to be power managed accordingly. Let's enable this by deploying
support through the genpd interface.

Additionally, when the OS initiated mode is supported by the PSCI FW, let's
also parse the domain idle states DT bindings as to make genpd responsible
for the state selection, when the states are compatible with
"domain-idle-state". Otherwise, when only Platform Coordinated mode is
supported, we rely solely on the state selection to be managed through the
regular cpuidle framework.

If the initialization of the PM domain data structures succeeds and the OS
initiated mode is supported, we try to switch to it. In case it fails,
let's fall back into a degraded mode, rather than bailing out and returning
an error code.

Due to that the OS initiated mode may become enabled, we need to adjust to
maintain backwards compatibility for a kernel started through a kexec call.
Do this by explicitly switch to Platform Coordinated mode during boot.

To try to initiate the PM domain data structures, the PSCI driver shall
call the new function, psci_dt_init_pm_domains(). However, this is done
from following changes.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in V10:
	- Enable the PM domains to be used for both PC and OSI mode.
	- Fixup error paths.
	- Move the management of kexec started kernels into this patch.
	- Rewrite changelog.

---
 drivers/firmware/psci/Makefile         |   2 +-
 drivers/firmware/psci/psci.c           |   7 +-
 drivers/firmware/psci/psci.h           |   6 +
 drivers/firmware/psci/psci_pm_domain.c | 262 +++++++++++++++++++++++++
 4 files changed, 275 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/psci/psci_pm_domain.c

diff --git a/drivers/firmware/psci/Makefile b/drivers/firmware/psci/Makefile
index 1956b882470f..ff300f1fec86 100644
--- a/drivers/firmware/psci/Makefile
+++ b/drivers/firmware/psci/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
+obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o psci_pm_domain.o
 obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 623591b541a4..19af2093151b 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -704,9 +704,14 @@ static int __init psci_1_0_init(struct device_node *np)
 	if (err)
 		return err;
 
-	if (psci_has_osi_support())
+	if (psci_has_osi_support()) {
 		pr_info("OSI mode supported.\n");
 
+		/* Make sure we default to PC mode. */
+		invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
+			       PSCI_1_0_SUSPEND_MODE_PC, 0, 0);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
index 7d9d38fd57e1..8cf6d7206fab 100644
--- a/drivers/firmware/psci/psci.h
+++ b/drivers/firmware/psci/psci.h
@@ -11,4 +11,10 @@ void psci_set_domain_state(u32 state);
 bool psci_has_osi_support(void);
 int psci_dt_parse_state_node(struct device_node *np, u32 *state);
 
+#ifdef CONFIG_CPU_IDLE
+int psci_dt_init_pm_domains(struct device_node *np);
+#else
+static inline int psci_dt_init_pm_domains(struct device_node *np) { return 0; }
+#endif
+
 #endif /* __PSCI_H */
diff --git a/drivers/firmware/psci/psci_pm_domain.c b/drivers/firmware/psci/psci_pm_domain.c
new file mode 100644
index 000000000000..d0dc38e96f85
--- /dev/null
+++ b/drivers/firmware/psci/psci_pm_domain.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PM domains for CPUs via genpd - managed by PSCI.
+ *
+ * Copyright (C) 2018 Linaro Ltd.
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *
+ */
+
+#define pr_fmt(fmt) "psci: " fmt
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/pm_domain.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "psci.h"
+
+#ifdef CONFIG_CPU_IDLE
+
+struct psci_pd_provider {
+	struct list_head link;
+	struct device_node *node;
+};
+
+static LIST_HEAD(psci_pd_providers);
+static bool osi_mode_enabled;
+
+static int psci_pd_power_off(struct generic_pm_domain *pd)
+{
+	struct genpd_power_state *state = &pd->states[pd->state_idx];
+	u32 *pd_state;
+	u32 composite_pd_state;
+
+	/* If we have failed to enable OSI mode, then abort power off. */
+	if (psci_has_osi_support() && !osi_mode_enabled)
+		return -EBUSY;
+
+	if (!state->data)
+		return 0;
+
+	/* When OSI mode is enabled, set the corresponding domain state. */
+	pd_state = state->data;
+	composite_pd_state = *pd_state | psci_get_domain_state();
+	psci_set_domain_state(composite_pd_state);
+
+	return 0;
+}
+
+static int psci_pd_parse_state_nodes(struct genpd_power_state *states,
+				int state_count)
+{
+	int i, ret;
+	u32 psci_state, *psci_state_buf;
+
+	for (i = 0; i < state_count; i++) {
+		ret = psci_dt_parse_state_node(to_of_node(states[i].fwnode),
+					&psci_state);
+		if (ret)
+			goto free_state;
+
+		psci_state_buf = kmalloc(sizeof(u32), GFP_KERNEL);
+		if (!psci_state_buf) {
+			ret = -ENOMEM;
+			goto free_state;
+		}
+		*psci_state_buf = psci_state;
+		states[i].data = psci_state_buf;
+	}
+
+	return 0;
+
+free_state:
+	while (i >= 0) {
+		kfree(states[i].data);
+		i--;
+	}
+	return ret;
+}
+
+static int psci_pd_parse_states(struct device_node *np,
+			struct genpd_power_state **states, int *state_count)
+{
+	int ret;
+
+	/* Parse the domain idle states. */
+	ret = of_genpd_parse_idle_states(np, states, state_count);
+	if (ret)
+		return ret;
+
+	/* Fill out the PSCI specifics for each found state. */
+	ret = psci_pd_parse_state_nodes(*states, *state_count);
+	if (ret)
+		kfree(*states);
+
+	return ret;
+}
+
+static int psci_pd_init(struct device_node *np)
+{
+	struct generic_pm_domain *pd;
+	struct psci_pd_provider *pd_provider;
+	struct dev_power_governor *pd_gov;
+	struct genpd_power_state *states = NULL;
+	int i, ret = -ENOMEM, state_count = 0;
+
+	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		goto out;
+
+	pd_provider = kzalloc(sizeof(*pd_provider), GFP_KERNEL);
+	if (!pd_provider)
+		goto free_pd;
+
+	pd->name = kasprintf(GFP_KERNEL, "%pOF", np);
+	if (!pd->name)
+		goto free_pd_prov;
+
+	/*
+	 * For OSI mode, parse the domain idle states and let genpd manage the
+	 * state selection for those being compatible with "domain-idle-state".
+	 */
+	if (psci_has_osi_support()) {
+		ret = psci_pd_parse_states(np, &states, &state_count);
+		if (ret)
+			goto free_name;
+	}
+
+	pd->name = kbasename(pd->name);
+	pd->power_off = psci_pd_power_off;
+	pd->states = states;
+	pd->state_count = state_count;
+	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
+
+	/* Use governor for CPU PM domains if it has some states to manage. */
+	pd_gov = state_count > 0 ? &pm_domain_cpu_gov : NULL;
+
+	ret = pm_genpd_init(pd, pd_gov, false);
+	if (ret)
+		goto free_state;
+
+	ret = of_genpd_add_provider_simple(np, pd);
+	if (ret)
+		goto remove_pd;
+
+	pd_provider->node = of_node_get(np);
+	list_add(&pd_provider->link, &psci_pd_providers);
+
+	pr_debug("init PM domain %s\n", pd->name);
+	return 0;
+
+remove_pd:
+	pm_genpd_remove(pd);
+free_state:
+	for (i = 0; i < state_count; i++)
+		kfree(states[i].data);
+	kfree(states);
+free_name:
+	kfree(pd->name);
+free_pd_prov:
+	kfree(pd_provider);
+free_pd:
+	kfree(pd);
+out:
+	pr_err("failed to init PM domain ret=%d %pOF\n", ret, np);
+	return ret;
+}
+
+static void psci_pd_remove(void)
+{
+	struct psci_pd_provider *pd_provider, *it;
+	struct generic_pm_domain *genpd;
+	int i;
+
+	list_for_each_entry_safe(pd_provider, it, &psci_pd_providers, link) {
+		of_genpd_del_provider(pd_provider->node);
+
+		genpd = of_genpd_remove_last(pd_provider->node);
+		if (!IS_ERR(genpd)) {
+			for (i = 0; i < genpd->state_count; i++)
+				kfree(genpd->states[i].data);
+			kfree(genpd->states);
+			kfree(genpd);
+		}
+
+		of_node_put(pd_provider->node);
+		list_del(&pd_provider->link);
+		kfree(pd_provider);
+	}
+}
+
+static int psci_pd_init_topology(struct device_node *np)
+{
+	struct device_node *node;
+	struct of_phandle_args child, parent;
+	int ret;
+
+	for_each_child_of_node(np, node) {
+		if (of_parse_phandle_with_args(node, "power-domains",
+					"#power-domain-cells", 0, &parent))
+			continue;
+
+		child.np = node;
+		child.args_count = 0;
+
+		ret = of_genpd_add_subdomain(&parent, &child);
+		of_node_put(parent.np);
+		if (ret) {
+			of_node_put(node);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+int psci_dt_init_pm_domains(struct device_node *np)
+{
+	struct device_node *node;
+	int ret, pd_count = 0;
+
+	/*
+	 * Parse child nodes for the "#power-domain-cells" property and
+	 * initialize a genpd/genpd-of-provider pair when it's found.
+	 */
+	for_each_child_of_node(np, node) {
+		if (!of_find_property(node, "#power-domain-cells", NULL))
+			continue;
+
+		ret = psci_pd_init(node);
+		if (ret)
+			goto put_node;
+
+		pd_count++;
+	}
+
+	/* Bail out if not using the hierarchical CPU topology. */
+	if (!pd_count)
+		return 0;
+
+	/* Link genpd masters/subdomains to model the CPU topology. */
+	ret = psci_pd_init_topology(np);
+	if (ret)
+		goto remove_pd;
+
+	/* Try to enable OSI mode if supported. */
+	if (psci_has_osi_support())
+		osi_mode_enabled = psci_set_osi_mode();
+
+	pr_info("Initialized CPU PM domain topology\n");
+	return pd_count;
+
+put_node:
+	of_node_put(node);
+remove_pd:
+	if (pd_count)
+		psci_pd_remove();
+	pr_err("failed to create CPU PM domains ret=%d\n", ret);
+	return ret;
+}
+#endif
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
