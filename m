Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11E7C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:52:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85AF521019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rmnOTWtS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dKE3qxiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AF521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=GDIdWN7d2GCrNOGneqHLiTB8+jUUZnYr9f9ftWemy2Y=; b=rmnOTWtSYWF/N5nr6lLx41/oEh
	BnXSK3aM8kW0eQkNUKfS32QiOXGH+IV4+zyKq61EUBz6OpdzgeuSFz9IjzuVzqnnG2qzN8SvivDiB
	DBxfhmRM5xw+ZKIDP3Ud/8kn/xoJCtgf78uj+Y05NyLkAIY0xnJ0BbCKDWjRwItAW8nFJhoX/imbD
	R0j0djTRQ7T6MGSGEkBt0onV85KyyaqQTBZ6EDazWNnmAyO4EPku5ewkhKdQHcO6DhwYXp1gKIlN/
	WFKP26EKfrqlMiwcP45wa52dMNDNS98dAl+vY1ZKbbe+Fyfnt6y2l7cSJlcbIAT9MWiHdn12217lj
	Z/dccO5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQUV-0007FC-Cb; Thu, 29 Nov 2018 17:52:43 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQPx-0001Yp-1N
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:48:10 +0000
Received: by mail-lj1-x242.google.com with SMTP id t9-v6so2523372ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 09:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=00sBAXywF3WZULK8cp3GDi0TaSy7ngQJNGllHojB6lk=;
 b=dKE3qxiTNFTTGb5T+hiqrOqJFim4aiRChTUuNwS2xw3/dZuh9DAHSNXaDLW74AS3pg
 lqi8hr2A4WN5tItntkMx4nEIWt69NUtA+5ATJ2GbhiBDjsUni1YWaOPqKXDu+4lgVcZ6
 8HF0CsduMwAzz1Xj7pFRsv+e/Vp0FqO7xL5UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=00sBAXywF3WZULK8cp3GDi0TaSy7ngQJNGllHojB6lk=;
 b=ViDGsr6Z6t5N3z9y2MQFxS94+dikhFPJ4WLvq0oAcjTP10cgrg1cZewD89JNUi3aET
 qlf355BNCwi/hRT2fJ8G6J2cOkS0RCtqCrffS4XooVanpWzdjclsqcUk8CwSya7pBIA5
 Vs7xc8ohceqp2dPMKq4aJiNpgF81IcewrfqbRQTu3eWHKIdJlhzTkHjA6/CawlLkfIVo
 ckElOl/OKJqleT1ub7xiJ6DUUUyoXQ1Lt0jba6wobuOnhoacKe5GkODv1JxCc/mWT7IR
 9FMB632qbyQqtRuIDKL0z4UcbM8MND6fogMkVY07PYeZipE6fNcghSv6em9uuLBw3kHy
 yypQ==
X-Gm-Message-State: AA+aEWYmyGYMyvGphEJ8Ic1FgP8itUdCdyM4gILDNcRbIuNZCqEqD40u
 xWmgCnLB7kE2lbW9VXHvyuGh7Q==
X-Google-Smtp-Source: AFSGD/XFzpmZt9P+s57VsvnAF06eON+JaheyOilxYXLdRGfV6H6Nt3KWs6+j8OeMMOH0S0u5nu6hVw==
X-Received: by 2002:a2e:3509:: with SMTP id z9-v6mr1668038ljz.54.1543513669095; 
 Thu, 29 Nov 2018 09:47:49 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 09:47:48 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v10 23/27] drivers: firmware: psci: Manage runtime PM in the
 idle path for CPUs
Date: Thu, 29 Nov 2018 18:46:56 +0100
Message-Id: <20181129174700.16585-24-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_094801_370617_70CB0FA9 
X-CRM114-Status: GOOD (  19.80  )
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

When the hierarchical CPU topology layout is used in DT, let's allow the
CPU to be power managed through its PM domain and via runtime PM. In other
words, let's deploy runtime PM support to the PSCI driver during idle
management of the CPU.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- New patch: Replaces the earlier patch "kernel/cpu_pm: Manage runtime
	  PM in the idle path for CPUs". In the end it seemed like a better
	  idea to start with something specific to PSCI, rather than (ab?)using
	  the generic functions cpu_pm_enter|exit().
	- Do runtime PM get/put for the deepest idle state for the CPU.

---
 drivers/firmware/psci/psci.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 94cd0431b004..b03bccce0a5d 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -20,6 +20,7 @@
 #include <linux/linkage.h>
 #include <linux/of.h>
 #include <linux/pm.h>
+#include <linux/pm_runtime.h>
 #include <linux/printk.h>
 #include <linux/psci.h>
 #include <linux/reboot.h>
@@ -319,6 +320,7 @@ int psci_dt_parse_state_node(struct device_node *np, u32 *state)
 
 #ifdef CONFIG_CPU_IDLE
 static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
+static DEFINE_PER_CPU_READ_MOSTLY(u32, psci_rpm_state_id);
 
 static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 			struct device_node *cpu_node, int cpu)
@@ -369,6 +371,9 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 		ret = psci_dt_attach_cpu(cpu);
 		if (ret)
 			goto free_mem;
+
+		/* Store index of deepest state to later for runtime PM. */
+		per_cpu(psci_rpm_state_id, cpu) = drv->state_count - 1;
 	}
 
 	/* Idle states parsed correctly, initialize per-cpu pointer */
@@ -466,7 +471,9 @@ int psci_cpu_suspend_enter(unsigned long index)
 {
 	int ret;
 	u32 *state = __this_cpu_read(psci_power_state);
-	u32 composite_state = state[index - 1] | psci_get_domain_state();
+	u32 composite_state, rpm_state_id;
+	bool runtime_pm = false;
+	struct device *dev = NULL;
 
 	/*
 	 * idle state index 0 corresponds to wfi, should never be called
@@ -475,11 +482,29 @@ int psci_cpu_suspend_enter(unsigned long index)
 	if (WARN_ON_ONCE(!index))
 		return -EINVAL;
 
+	/*
+	 * Do runtime PM if we are using the hierarchical CPU toplogy, but only
+	 * when cpuidle have selected the deepest idle state for the CPU.
+	 */
+	if (psci_dt_topology) {
+		rpm_state_id = __this_cpu_read(psci_rpm_state_id);
+		runtime_pm = rpm_state_id == index;
+		if (runtime_pm) {
+			dev = get_cpu_device(smp_processor_id());
+			pm_runtime_put_sync_suspend(dev);
+		}
+	}
+
+	composite_state = state[index - 1] | psci_get_domain_state();
+
 	if (!psci_power_state_loses_context(composite_state))
 		ret = psci_ops.cpu_suspend(composite_state, 0);
 	else
 		ret = cpu_suspend(index, psci_suspend_finisher);
 
+	if (runtime_pm)
+		pm_runtime_get_sync(dev);
+
 	/* Clear the domain state to start fresh when back from idle. */
 	psci_set_domain_state(0);
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
