Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9B8C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:55:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C478213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gERWKbyC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iEOSQK3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C478213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=EtWYxgvbulAPZjWYc+3xSLqyedib10X8YmWQHvPiKL4=; b=gERWKbyCcwKauDBGZvNvI6kg55
	+9d1r83I59s0kjSPzwrZIgvPXEId9wC0W3Yjv6NzFEoccJ5+A7dEEMliBRqh+HabE7pFqqnA2+c4T
	axhUf4dwdf1Dhdh5yWg/sbXz+oYPi7VXWnwH23SWR3JqogEbaERAE7IAOA98INnpNHGLSn8p/4Gw2
	buNYrh+1mFtCQCQoe8L4T7K4YLglgUNo1fs0Y7PwV1Wb/GftrTAOkK/tQq4QO6MzojwVsVo0Xbhfu
	v2W4GcZ+szcDyssjTo63kuVU6QLVppM9kwqVIMF9yn+TpXFUcZy2WMsaFCpxAJ3v7aE4FCfO59JEx
	Zlb5mGtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQWl-0000CI-Ai; Thu, 29 Nov 2018 17:55:03 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQPM-00017z-Fb
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:47:26 +0000
Received: by mail-lj1-x244.google.com with SMTP id l15-v6so2520120lja.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 09:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2+/Zg5CnveDZt6Y9DJWaO1vjEPhkATmRTkbujkSrrhk=;
 b=iEOSQK3L6vH/uOYYq+9t3pvIzAUY7UHAKzKIcFHnTZJEOxlNO/oikkLhR4EVwmumAc
 IR1XEudU9idovUSdmo1vxpLNMJEHWCjwyfFGtbZ0CeTN9dbq/4hh3UC4Wc9zpBltMazF
 G0dFliU25cJCtVXS/hBWoMX5uPYpX9qscltpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2+/Zg5CnveDZt6Y9DJWaO1vjEPhkATmRTkbujkSrrhk=;
 b=AQnlCoQrnl6d0M/mUFwViQDU+LwV+DtpH5gwaHXN3U30Yr29daQrMQuXeofHJEqU85
 HCeGEfiN9MdqPvUlMEwjdCrgsJMLX6aYrh0AOyqeTpxZAxHd5i3MC3oZJM/81hW2ZpiB
 d+BlAzFeChLFn+0PA5qnHM9vYNQY54b809D3MWh5qZVYNbEh9vPjbh6jiFODDymBN8Ww
 Vi1nSDwRG9SDdP/l1JWHSy2b0Ai05NJY+22KhF3tIL6KCwLgUFjLGu6fbjLJx2qdsOWZ
 lhrdfDMsaHGuCAi8XbwQALK75MWj/PuaeiR6fnl0L5dCtRAn/2dKOhpGLirmDo4+wKyz
 goSA==
X-Gm-Message-State: AA+aEWYPk8L6332zXlr7F0vRRc4hXAlla1sNZjdwzZxPj0MwpQ4ja/I9
 eVDCtb1s2KW1p/j+5NricYxz+g==
X-Google-Smtp-Source: AFSGD/Xvkon2TF8iGxwU58DFFLy/SGEybzfzgTkfgjGfzUCOI7vqWKeP0Zb6u3Yyoq4tmsx3lkVgMA==
X-Received: by 2002:a2e:97d7:: with SMTP id
 m23-v6mr1886895ljj.18.1543513642839; 
 Thu, 29 Nov 2018 09:47:22 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 09:47:22 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v10 08/27] ARM/ARM64: cpuidle: Let back-end init ops take the
 driver as input
Date: Thu, 29 Nov 2018 18:46:41 +0100
Message-Id: <20181129174700.16585-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_094724_808675_8F677BA2 
X-CRM114-Status: GOOD (  23.67  )
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
Cc: David Brown <david.brown@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>,
 Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-arm-msm@vger.kernel.org,
 Andy Gross <andy.gross@linaro.org>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

To allow arch back-end init ops to operate on the cpuidle driver for the
corresponding CPU, let's pass along a pointer to the struct cpuidle_driver*
and forward it the relevant layers of callbacks for ARM/ARM64.

Following changes for the PSCI firmware driver starts making use of this.

Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- New patch!

I am seeking an ack from relevant maintainers. Please ping me if you need
further information about the hole series.

Thanks!
Ulf Hanssson

---
 arch/arm/include/asm/cpuidle.h   | 4 ++--
 arch/arm/kernel/cpuidle.c        | 5 +++--
 arch/arm64/include/asm/cpu_ops.h | 4 +++-
 arch/arm64/include/asm/cpuidle.h | 6 ++++--
 arch/arm64/kernel/cpuidle.c      | 6 +++---
 drivers/cpuidle/cpuidle-arm.c    | 2 +-
 drivers/firmware/psci.c          | 7 ++++---
 drivers/soc/qcom/spm.c           | 3 ++-
 include/linux/psci.h             | 4 +++-
 9 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
index 6b2ff7243b4b..bee0a7847733 100644
--- a/arch/arm/include/asm/cpuidle.h
+++ b/arch/arm/include/asm/cpuidle.h
@@ -32,7 +32,7 @@ struct device_node;
 
 struct cpuidle_ops {
 	int (*suspend)(unsigned long arg);
-	int (*init)(struct device_node *, int cpu);
+	int (*init)(struct cpuidle_driver *, struct device_node *, int cpu);
 };
 
 struct of_cpuidle_method {
@@ -47,6 +47,6 @@ struct of_cpuidle_method {
 
 extern int arm_cpuidle_suspend(int index);
 
-extern int arm_cpuidle_init(int cpu);
+extern int arm_cpuidle_init(struct cpuidle_driver *drv, int cpu);
 
 #endif
diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
index fda5579123a8..43778c9b373d 100644
--- a/arch/arm/kernel/cpuidle.c
+++ b/arch/arm/kernel/cpuidle.c
@@ -122,6 +122,7 @@ static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
 
 /**
  * arm_cpuidle_init() - Initialize cpuidle_ops for a specific cpu
+ * @drv: the drv to be initialized
  * @cpu: the cpu to be initialized
  *
  * Initialize the cpuidle ops with the device for the cpu and then call
@@ -137,7 +138,7 @@ static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
  *  -ENXIO if the HW reports a failure or a misconfiguration,
  *  -ENOMEM if the HW report an memory allocation failure 
  */
-int __init arm_cpuidle_init(int cpu)
+int __init arm_cpuidle_init(struct cpuidle_driver *drv, int cpu)
 {
 	struct device_node *cpu_node = of_cpu_device_node_get(cpu);
 	int ret;
@@ -147,7 +148,7 @@ int __init arm_cpuidle_init(int cpu)
 
 	ret = arm_cpuidle_read_ops(cpu_node, cpu);
 	if (!ret)
-		ret = cpuidle_ops[cpu].init(cpu_node, cpu);
+		ret = cpuidle_ops[cpu].init(drv, cpu_node, cpu);
 
 	of_node_put(cpu_node);
 
diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
index 8f03446cf89f..8db870c29f1b 100644
--- a/arch/arm64/include/asm/cpu_ops.h
+++ b/arch/arm64/include/asm/cpu_ops.h
@@ -19,6 +19,8 @@
 #include <linux/init.h>
 #include <linux/threads.h>
 
+struct cpuidle_driver;
+
 /**
  * struct cpu_operations - Callback operations for hotplugging CPUs.
  *
@@ -58,7 +60,7 @@ struct cpu_operations {
 	int		(*cpu_kill)(unsigned int cpu);
 #endif
 #ifdef CONFIG_CPU_IDLE
-	int		(*cpu_init_idle)(unsigned int);
+	int		(*cpu_init_idle)(struct cpuidle_driver *, unsigned int);
 	int		(*cpu_suspend)(unsigned long);
 #endif
 };
diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpuidle.h
index 3c5ddb429ea2..3fd3efb61649 100644
--- a/arch/arm64/include/asm/cpuidle.h
+++ b/arch/arm64/include/asm/cpuidle.h
@@ -4,11 +4,13 @@
 
 #include <asm/proc-fns.h>
 
+struct cpuidle_driver;
+
 #ifdef CONFIG_CPU_IDLE
-extern int arm_cpuidle_init(unsigned int cpu);
+extern int arm_cpuidle_init(struct cpuidle_driver *drv, unsigned int cpu);
 extern int arm_cpuidle_suspend(int index);
 #else
-static inline int arm_cpuidle_init(unsigned int cpu)
+static inline int arm_cpuidle_init(struct cpuidle_driver *drv, unsigned int cpu)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index f2d13810daa8..aaf9dc5cb87a 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -18,13 +18,13 @@
 #include <asm/cpuidle.h>
 #include <asm/cpu_ops.h>
 
-int arm_cpuidle_init(unsigned int cpu)
+int arm_cpuidle_init(struct cpuidle_driver *drv, unsigned int cpu)
 {
 	int ret = -EOPNOTSUPP;
 
 	if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_suspend &&
 			cpu_ops[cpu]->cpu_init_idle)
-		ret = cpu_ops[cpu]->cpu_init_idle(cpu);
+		ret = cpu_ops[cpu]->cpu_init_idle(drv, cpu);
 
 	return ret;
 }
@@ -51,7 +51,7 @@ int arm_cpuidle_suspend(int index)
 
 int acpi_processor_ffh_lpi_probe(unsigned int cpu)
 {
-	return arm_cpuidle_init(cpu);
+	return arm_cpuidle_init(NULL, cpu);
 }
 
 int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 3a407a3ef22b..39413973b21d 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -106,7 +106,7 @@ static int __init arm_idle_init_cpu(int cpu)
 	 * Call arch CPU operations in order to initialize
 	 * idle states suspend back-end specific data
 	 */
-	ret = arm_cpuidle_init(cpu);
+	ret = arm_cpuidle_init(drv, cpu);
 
 	/*
 	 * Allow the initialization to continue for other CPUs, if the reported
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index c80ec1d03274..878c4dcf0118 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -270,7 +270,8 @@ static int __init psci_features(u32 psci_func_id)
 #ifdef CONFIG_CPU_IDLE
 static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
 
-static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
+static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
+			struct device_node *cpu_node, int cpu)
 {
 	int i, ret, count = 0;
 	u32 *psci_states;
@@ -371,7 +372,7 @@ static int __maybe_unused psci_acpi_cpu_init_idle(unsigned int cpu)
 }
 #endif
 
-int psci_cpu_init_idle(unsigned int cpu)
+int psci_cpu_init_idle(struct cpuidle_driver *drv, unsigned int cpu)
 {
 	struct device_node *cpu_node;
 	int ret;
@@ -390,7 +391,7 @@ int psci_cpu_init_idle(unsigned int cpu)
 	if (!cpu_node)
 		return -ENODEV;
 
-	ret = psci_dt_cpu_init_idle(cpu_node, cpu);
+	ret = psci_dt_cpu_init_idle(drv, cpu_node, cpu);
 
 	of_node_put(cpu_node);
 
diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index 53807e839664..6e967f0a8608 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -208,7 +208,8 @@ static const struct of_device_id qcom_idle_state_match[] __initconst = {
 	{ },
 };
 
-static int __init qcom_cpuidle_init(struct device_node *cpu_node, int cpu)
+static int __init qcom_cpuidle_init(struct cpuidle_driver *drv,
+			struct device_node *cpu_node, int cpu)
 {
 	const struct of_device_id *match_id;
 	struct device_node *state_node;
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 8b1b3b5935ab..4f29a3bff379 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -20,9 +20,11 @@
 #define PSCI_POWER_STATE_TYPE_STANDBY		0
 #define PSCI_POWER_STATE_TYPE_POWER_DOWN	1
 
+struct cpuidle_driver;
+
 bool psci_tos_resident_on(int cpu);
 
-int psci_cpu_init_idle(unsigned int cpu);
+int psci_cpu_init_idle(struct cpuidle_driver *drv, unsigned int cpu);
 int psci_cpu_suspend_enter(unsigned long index);
 
 enum psci_conduit {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
