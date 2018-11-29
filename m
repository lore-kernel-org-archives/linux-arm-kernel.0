Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925FAC43610
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:52:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6716621019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hOZJ062I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmLH+XoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6716621019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=25tIrzHA+tQmWgns7HafSRrNGz15RJKpLJvmtj2rZAw=; b=hOZJ062IbsMkFpA39pr1XalGb2
	13LpWpQoSaTu5wrb/atPFZTDZk9WsE3OADEVI3msqj7kYHNlvbw8hnn5zFgQK+ellSCkAZHQmx1Dk
	NeVRAtKUCJ6NE0vEtJPitqsUk1NmSYDl3M9+9RafCvBz42IiPYhTBOd4Ge4qHNSDR96gaDFi/o0PC
	EUWnXhICqPhx3KYaUkkgt2rozk+OlaSNIy96fGC/mh5EWkaAuHn8U22WkI5siwSW2HRtR+Cuv7YhU
	1R7z4jkEMn7UsXhnC7IgEIAICzx9pZyCD9aRHKcCa2DVhdAjIuRuKdUq94Hlc9FZ50cmfyvxc+WCA
	6YpvgdJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQTn-0006Vm-JG; Thu, 29 Nov 2018 17:51:59 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQPm-0001Ls-09
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:48:02 +0000
Received: by mail-lf1-x143.google.com with SMTP id c16so2097325lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 09:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0f5FNvFNr+ywaXHgyrdJbA+WYJaJrfnYBdOhsBxudf4=;
 b=XmLH+XoAJtA/XlML6wE1maPOYx/UgMy3QdCOO/C9Bbgo4OSb13ZU3C9qDH+QoTZRxf
 Rke2l20UnNvvrcOTsXud9ZDQpFCo249MLeMQtK5qGGiMWjG0Ge1brJ8dElp8nTQNPGnp
 p/t3f3qeclrknlZT72MhdAwxwbHzyXVyPCRQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0f5FNvFNr+ywaXHgyrdJbA+WYJaJrfnYBdOhsBxudf4=;
 b=SIHOhVfkQGRT5Q4nFSE7IZOfQ+ayqLVYQ4dpPnOUpFcf3O/3BLfCt/sETV+/VGKq2N
 oqP3LJS9W3vKNfx55Wz90MuMYcMTOBxXy8bRQf0t9Gc+3MsFsGQaM3fl1p8zdzwR8viO
 VyCWttTXcESAN68g3Mz+I2lHAL0+YfmIpy913FnHInWNSQA5Y9WsqA/SmCgM5/QU+JVD
 26G7CHosgTZh/XxmBOmX8hmrk8ocGaHZFblOChW+r9MMYdVgbfx4gmmdy+/wWgbZNzSc
 4iytSoJeQq3yZQkiSRldJTlkqtXgRW5ZorYON74TRRQ1V5Pnu0Zpp/3tcWdh/Ypfi5rV
 OqqQ==
X-Gm-Message-State: AA+aEWa7t/nwh4oce1eWjDyjWCCtmjq68YWCDQdyMIiVVjnHp2uzyC9s
 MXOFOmEAPl+GHQdPMcjpuOKBug==
X-Google-Smtp-Source: AFSGD/Wc/z4ksBJs3vHmhXh16mPBFgtQnbNX6FwOcO14wj444TX9p972mzxxNkllouBu8ScnYN8TbQ==
X-Received: by 2002:a19:8fce:: with SMTP id s75mr1590227lfk.151.1543513658259; 
 Thu, 29 Nov 2018 09:47:38 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 09:47:37 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v10 17/27] drivers: firmware: psci: Prepare to support PM
 domains
Date: Thu, 29 Nov 2018 18:46:50 +0100
Message-Id: <20181129174700.16585-18-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_094750_644326_2079CB84 
X-CRM114-Status: GOOD (  19.66  )
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

Following changes are about to implement support for PM domains to PSCI.
Those changes are mainly going to be implemented in a new separate file,
hence a couple of the internal PSCI functions needs to be shared to be
accessible. So, let's do that via adding new PSCI header file.

Moreover, the changes deploying support for PM domains, needs to be able to
switch the PSCI FW into the OS initiated mode. For that reason, let's add a
new function that deals with this and share it via the new PSCI header
file.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- New patch. Re-places the earlier patch: "drivers: firmware: psci:
	  Share a few internal PSCI functions".

---
 drivers/firmware/psci/psci.c | 28 +++++++++++++++++++++-------
 drivers/firmware/psci/psci.h | 14 ++++++++++++++
 2 files changed, 35 insertions(+), 7 deletions(-)
 create mode 100644 drivers/firmware/psci/psci.h

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 8dbcdecc2ae4..623591b541a4 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -34,6 +34,8 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 
+#include "psci.h"
+
 /*
  * While a 64-bit OS can make calls with SMC32 calling conventions, for some
  * calls it is necessary to use SMC64 to pass or return 64-bit values.
@@ -90,23 +92,35 @@ static u32 psci_function_id[PSCI_FN_MAX];
 static DEFINE_PER_CPU(u32, domain_state);
 static u32 psci_cpu_suspend_feature;
 
-static inline u32 psci_get_domain_state(void)
+u32 psci_get_domain_state(void)
 {
 	return __this_cpu_read(domain_state);
 }
 
-static inline void psci_set_domain_state(u32 state)
+void psci_set_domain_state(u32 state)
 {
 	__this_cpu_write(domain_state, state);
 }
 
+bool psci_set_osi_mode(void)
+{
+	int ret;
+
+	ret = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
+			PSCI_1_0_SUSPEND_MODE_OSI, 0, 0);
+	if (ret)
+		pr_warn("failed to enable OSI mode: %d\n", ret);
+
+	return !ret;
+}
+
 static inline bool psci_has_ext_power_state(void)
 {
 	return psci_cpu_suspend_feature &
 				PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK;
 }
 
-static inline bool psci_has_osi_support(void)
+bool psci_has_osi_support(void)
 {
 	return psci_cpu_suspend_feature & PSCI_1_0_OS_INITIATED;
 }
@@ -285,10 +299,7 @@ static int __init psci_features(u32 psci_func_id)
 			      psci_func_id, 0, 0);
 }
 
-#ifdef CONFIG_CPU_IDLE
-static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
-
-static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
+int psci_dt_parse_state_node(struct device_node *np, u32 *state)
 {
 	int err = of_property_read_u32(np, "arm,psci-suspend-param", state);
 
@@ -305,6 +316,9 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
 	return 0;
 }
 
+#ifdef CONFIG_CPU_IDLE
+static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
+
 static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 			struct device_node *cpu_node, int cpu)
 {
diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
new file mode 100644
index 000000000000..7d9d38fd57e1
--- /dev/null
+++ b/drivers/firmware/psci/psci.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __PSCI_H
+#define __PSCI_H
+
+struct device_node;
+
+bool psci_set_osi_mode(void);
+u32 psci_get_domain_state(void);
+void psci_set_domain_state(u32 state);
+bool psci_has_osi_support(void);
+int psci_dt_parse_state_node(struct device_node *np, u32 *state);
+
+#endif /* __PSCI_H */
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
