Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A26DC43610
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:52:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F04721019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bRpjLOys";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CSiWZltn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F04721019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=oKWxQCvREzPAoSqdeHUdXTtnXXO9jK5jdkl2/x1h0IU=; b=bRpjLOysxgPXmyvqvbURIQ+wRw
	wfGrUczpItOdRaKNwAeRDigamuCutLjoGiw0X/7LMJJ+haQ6cZK+GP69YyLxiMqN36vWIgsSHfdza
	bnPDYmCCXJLiHJEu+sXySD2pUo4h6jOWSakwsoxcLkQfy8nu+HnAwh0Qe3j0SVM0PUJyyzgEgHqMM
	VuiVej33AXDq9GgWCuEZM2Y/IIIQqq6UsgdXwfMR+XpowT0T8/9F/NKJdeclKUlIFpnsEl6Y5TyxY
	XX+aMq7VXgI8p7YCqqI1r7iGriSjU9BVP35T4dqP7qSAzDleq/0/CjO5aldBsmLS8EQaTR7BPeMqc
	VIn8qoLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQU1-0006kr-R3; Thu, 29 Nov 2018 17:52:13 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQPp-0001Q4-Hf
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:48:06 +0000
Received: by mail-lj1-x244.google.com with SMTP id l15-v6so2520824lja.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 09:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IgJavhFwHTt+c7Cc5oNvleI06smw6L91MXyG+WFxJOs=;
 b=CSiWZltnAlLzdpYUc1gNl1J+emspCgZO2e02blv0N8vsACNO2aEjoWM/zxVWgKFOrE
 6vx2z6Ui/2c0Fuv5GGiX9/da15QuPJJAGfEcryeMjyxdE/mm8/xzUH6OjBPA8HcihktD
 Gm0ST9kFrA/gO8Sxpq05sccvaHDJ4FMgzyxFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=IgJavhFwHTt+c7Cc5oNvleI06smw6L91MXyG+WFxJOs=;
 b=p0onn+XuXmD4YeUWF0jlskLQkxu1xsSZ3sKRI/X6kiVQR9zMZMLvMxe+/o7N7HLXV4
 y9ugxnmBCIYxyMnO1gFn7NzjgKktVEi0JWkdmCW9jNsamvUyKErToVlCUTl+wRre1uOs
 JUYf75NzpwDAIB3Cqg5lgFwpRRL/dy5t3U0Jzq6JFgFb3TialKW9G0W8k6vaooMn2Z71
 FtKy2PTQd6P6QWmpteJu91n+pVODvLrMQfAkYH2D4fGVdEvWH/4cf+4MzcM8UhkPfMr5
 3vxchfWvCNLDl0AdWpFrKWlMTVgiJGDksSWde4ZCleaWUOB5tJfpTLGguuMlRQ3QvdUH
 odqQ==
X-Gm-Message-State: AA+aEWbdiJXw34bx0nJQKya8VhgNVDveyW/uzIGWMM6JYCH5fLuyFlUB
 Hdmb0lUo9hlQmy9rmxBBXPFkYw==
X-Google-Smtp-Source: AFSGD/UfIe05lJVzFSG/PvTzE4YY5lDne785Bt93puLTSNvnIF11d0n/xy28bKWTKOUrcHm1iyKeHg==
X-Received: by 2002:a2e:9b15:: with SMTP id
 u21-v6mr1683452lji.29.1543513661629; 
 Thu, 29 Nov 2018 09:47:41 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 09:47:41 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v10 19/27] drivers: firmware: psci: Add hierarchical domain
 idle states converter
Date: Thu, 29 Nov 2018 18:46:52 +0100
Message-Id: <20181129174700.16585-20-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_094754_050216_C6ED2961 
X-CRM114-Status: GOOD (  19.49  )
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

If the hierarchical CPU topology is used, but the OS initiated mode isn't
supported, we rely solely on the regular cpuidle framework to manage the
idle state selection.

For this reason, introduce a new PSCI DT helper function,
psci_dt_pm_domains_parse_states(), which converts the hierarchically
described domain idle states, into regular flattened cpuidle states.

During the conversion, let's also insert the converted states into the
cpuidle driver's array of idle states, as to enables the cpuidle framework
to manage them.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- New patch.

---
 drivers/firmware/psci/psci.h           |   2 +
 drivers/firmware/psci/psci_pm_domain.c | 108 +++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
index 8cf6d7206fab..05af462cc96e 100644
--- a/drivers/firmware/psci/psci.h
+++ b/drivers/firmware/psci/psci.h
@@ -13,6 +13,8 @@ int psci_dt_parse_state_node(struct device_node *np, u32 *state);
 
 #ifdef CONFIG_CPU_IDLE
 int psci_dt_init_pm_domains(struct device_node *np);
+int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
+			struct device_node *cpu_node, u32 *psci_states);
 #else
 static inline int psci_dt_init_pm_domains(struct device_node *np) { return 0; }
 #endif
diff --git a/drivers/firmware/psci/psci_pm_domain.c b/drivers/firmware/psci/psci_pm_domain.c
index d0dc38e96f85..6c9d6a644c7f 100644
--- a/drivers/firmware/psci/psci_pm_domain.c
+++ b/drivers/firmware/psci/psci_pm_domain.c
@@ -14,6 +14,10 @@
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
+
+#include <asm/cpuidle.h>
 
 #include "psci.h"
 
@@ -97,6 +101,53 @@ static int psci_pd_parse_states(struct device_node *np,
 	return ret;
 }
 
+static int psci_pd_enter_pc(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv, int idx)
+{
+	return CPU_PM_CPU_IDLE_ENTER(arm_cpuidle_suspend, idx);
+}
+
+static void psci_pd_enter_s2idle_pc(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv, int idx)
+{
+	psci_pd_enter_pc(dev, drv, idx);
+}
+
+static void psci_pd_convert_states(struct cpuidle_state *idle_state,
+			u32 *psci_state, struct genpd_power_state *state)
+{
+	u32 *state_data = state->data;
+	u64 target_residency_us = state->residency_ns;
+	u64 exit_latency_us = state->power_on_latency_ns +
+			state->power_off_latency_ns;
+
+	*psci_state = *state_data;
+	do_div(target_residency_us, 1000);
+	idle_state->target_residency = target_residency_us;
+	do_div(exit_latency_us, 1000);
+	idle_state->exit_latency = exit_latency_us;
+	idle_state->enter = &psci_pd_enter_pc;
+	idle_state->enter_s2idle = &psci_pd_enter_s2idle_pc;
+	idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
+
+	strncpy(idle_state->name, to_of_node(state->fwnode)->name,
+		CPUIDLE_NAME_LEN - 1);
+	strncpy(idle_state->desc, to_of_node(state->fwnode)->name,
+		CPUIDLE_NAME_LEN - 1);
+}
+
+static bool psci_pd_is_provider(struct device_node *np)
+{
+	struct psci_pd_provider *pd_prov, *it;
+
+	list_for_each_entry_safe(pd_prov, it, &psci_pd_providers, link) {
+		if (pd_prov->node == np)
+			return true;
+	}
+
+	return false;
+}
+
 static int psci_pd_init(struct device_node *np)
 {
 	struct generic_pm_domain *pd;
@@ -259,4 +310,61 @@ int psci_dt_init_pm_domains(struct device_node *np)
 	pr_err("failed to create CPU PM domains ret=%d\n", ret);
 	return ret;
 }
+
+int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
+			struct device_node *cpu_node, u32 *psci_states)
+{
+	struct genpd_power_state *pd_states;
+	struct of_phandle_args args;
+	int ret, pd_state_count, i, idx, psci_idx = drv->state_count - 2;
+	struct device_node *np = of_node_get(cpu_node);
+
+	/* Walk the CPU topology to find compatible domain idle states. */
+	while (np) {
+		ret = of_parse_phandle_with_args(np, "power-domains",
+					"#power-domain-cells", 0, &args);
+		of_node_put(np);
+		if (ret)
+			return 0;
+
+		np = args.np;
+
+		/* Verify that the node represents a psci pd provider. */
+		if (!psci_pd_is_provider(np)) {
+			of_node_put(np);
+			return 0;
+		}
+
+		/* Parse for compatible domain idle states. */
+		ret = psci_pd_parse_states(np, &pd_states, &pd_state_count);
+		if (ret) {
+			of_node_put(np);
+			return ret;
+		}
+
+		i = 0;
+		idx = drv->state_count;
+		while (i < pd_state_count && idx < CPUIDLE_STATE_MAX) {
+			psci_pd_convert_states(&drv->states[idx + i],
+				&psci_states[idx - 1 + i], &pd_states[i]);
+
+			/*
+			 * In the hierarchical CPU topology the master PM domain
+			 * idle state's DT property, "arm,psci-suspend-param",
+			 * don't contain the bits for the idle state of the CPU.
+			 * Take that into account here.
+			 */
+			psci_states[idx - 1 + i] |= psci_states[psci_idx];
+			pr_debug("psci-power-state %#x index %d\n",
+				psci_states[idx - 1 + i], idx - 1 + i);
+
+			kfree(pd_states[i].data);
+			i++;
+		}
+		drv->state_count += i;
+		kfree(pd_states);
+	}
+
+	return 0;
+}
 #endif
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
