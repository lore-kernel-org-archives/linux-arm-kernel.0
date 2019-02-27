Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735D8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:59:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2923E2186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r1IgG6Fj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/O0gxne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2923E2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=62RFrBeSNGaDRQtOozFDdjaP63xhow37ya9a3fYLMt4=; b=r1IgG6FjjPdBmvX0P+cwQyi6YM
	V8uWOy2zqEsxdjyJyr5m+hA1NSkNzJEnwAhd+y/Fl5WAjyV4Dgs/EwDlhw2cDkykkMjJXblWU6PJU
	B0GdzowDaXKynnDTahSEwtJprV+yNgKPDZ/RxAuvP2Rx21wszKTqBBNOT4UZ9eaN5dKQcPMKe2WPH
	b7IAQ4b6+SSFC/22UVr9LtLR2VkGYAuW22SlIz9DCacpqpVObPGEjBxvUidWZuOaTHhcsafMLXPgG
	yHZcugPXkJD+TYPpVrcspHdb232shXrwN8nj8jy6CtS7Kj3q6leYRxQT1NdLjl+tFwkOo2OnPUTwy
	JxXkkDgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz5Me-0007vH-R8; Wed, 27 Feb 2019 19:59:36 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz5Ls-00077m-So
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 19:58:52 +0000
Received: by mail-lf1-x142.google.com with SMTP id 131so4193485lfa.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 11:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=I9FC+10KjcWm9oxkGkEiLX6p0r263JrQVxFR/hZ1DCo=;
 b=W/O0gxneC3anBlV0dLqPWOeg7o1IwJkTZydODUphl9PF+b+qxDTK5l7f4ZXn2b1DYR
 uym80thZ53ZvAjzliPpxqtrKxW03+wNoOrn6q94ZVyW/bOpCqfQL2MCHA35spNnx9o84
 bTtsfBhxjP27sCt6aEktM69GsK7oUCAYi0LUtRm1ONJOEyAULFXWD4XE4f2ZW5EmaBZc
 GdBJCzQkKl6lefJAFvP/yA6X6B8CnNwXcNTyCvJNpDvV1ze9DnM9UO9rvhsU/r3kVPP5
 cEwBwvQJea5QPmhkiteaHArtPl2m/PJ3+66rk5sLzdIRW0BmGOS9W2iIqn+yBfGHbkkb
 y4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=I9FC+10KjcWm9oxkGkEiLX6p0r263JrQVxFR/hZ1DCo=;
 b=MMzIhj290MH03N636ccXhLFd68r7a8Y5xrjY9MJKYiFev5kNNl170msqlEUVa6xQ66
 bojIzNiozJTm+AU8lua/N0qQHuuAMy+lOkoEIbCXaN9HAQpQAvU1zk1bFp0xTTY7epio
 3nnLhV6sUGTljlrkABs/nOkF9lL0kLTl8NBuOVpTL9X0OOjoEePi4V43OKTqvxblIa2Z
 B25KOk7P9co/+HbEzKftbZvxT+RVsFDSJk/EK0f+zd+ym2n3gp6SkthVHeSZ4NsTwfI+
 xqWVC58xjjaJUuCYGlFjc19NX6HU+qMaugFnHdL5GoHxfJeOpPzLhJkt9blfVEN6AyVP
 o2Qg==
X-Gm-Message-State: AHQUAuaodhE6owoKoO0pVg972jNwiZ0qZ3eFkPBrtGvJnkWp4KdmpcM1
 Iq01Wc2Y/O8fCllCPMk2F/ryeA==
X-Google-Smtp-Source: AHgI3IbJrKjGluCCVPBj7ymE9kz4ZuCKVo32//FJr6Rd/I84iYd75LAeHPxnpNXEh8mDiaTThX+Zgg==
X-Received: by 2002:a19:ec0c:: with SMTP id b12mr1988765lfa.27.1551297526598; 
 Wed, 27 Feb 2019 11:58:46 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id z128sm723802lfa.60.2019.02.27.11.58.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 Feb 2019 11:58:45 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH v12 3/4] cpuidle: Export the next timer/tick expiration for a
 CPU
Date: Wed, 27 Feb 2019 20:58:35 +0100
Message-Id: <20190227195836.24739-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227195836.24739-1-ulf.hansson@linaro.org>
References: <20190227195836.24739-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_115849_153219_C9A01A59 
X-CRM114-Status: GOOD (  21.29  )
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

To be able to predict the sleep duration for a CPU that is entering idle,
knowing when the next timer/tick is going to expire, is extremely useful.
Both the teo and the menu cpuidle governors already makes use of this
information, while selecting an idle state.

Moving forward, the similar prediction needs to be done, but for a group of
idle CPUs rather than for a single idle CPU. Following changes implements a
new genpd governor, which needs this.

Support this, by sharing a new function called
tick_nohz_get_next_hrtimer(), which returns the next hrtimer or the next
tick, whatever that expires first.

Additionally, when cpuidle is about to invoke the ->enter() callback, then
call tick_nohz_get_next_hrtimer() and store its return value in the per CPU
struct cpuidle_device, as to make it available outside cpuidle.

Do note, at the point when cpuidle calls tick_nohz_get_next_hrtimer(), the
governor's ->select() callback has already made a decision whether to stop
the tick or not. In this way, tick_nohz_get_next_hrtimer() actually returns
the next timer expiration, whatever origin.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v12:
	- New patch.

---
 drivers/cpuidle/cpuidle.c |  8 ++++++++
 include/linux/cpuidle.h   |  1 +
 include/linux/tick.h      |  7 ++++++-
 kernel/time/tick-sched.c  | 12 ++++++++++++
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 7f108309e871..255365b1a6ab 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -328,6 +328,14 @@ int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 int cpuidle_enter(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		  int index)
 {
+	/*
+	 * Store the next hrtimer, which becomes either next tick or the next
+	 * timer event, whatever expires first. Additionally, to make this data
+	 * useful for consumers outside cpuidle, we rely on that the governor's
+	 * ->select() callback have decided, whether to stop the tick or not.
+	 */
+	dev->next_hrtimer = tick_nohz_get_next_hrtimer();
+
 	if (cpuidle_state_is_coupled(drv, index))
 		return cpuidle_enter_state_coupled(dev, drv, index);
 	return cpuidle_enter_state(dev, drv, index);
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 3b39472324a3..bb9a0db89f1a 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -83,6 +83,7 @@ struct cpuidle_device {
 	unsigned int		use_deepest_state:1;
 	unsigned int		poll_time_limit:1;
 	unsigned int		cpu;
+	ktime_t			next_hrtimer;
 
 	int			last_residency;
 	struct cpuidle_state_usage	states_usage[CPUIDLE_STATE_MAX];
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 55388ab45fd4..8891b5ac3e40 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -122,6 +122,7 @@ extern void tick_nohz_idle_enter(void);
 extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
 extern bool tick_nohz_idle_got_tick(void);
+extern ktime_t tick_nohz_get_next_hrtimer(void);
 extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
 extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
@@ -145,7 +146,11 @@ static inline void tick_nohz_idle_restart_tick(void) { }
 static inline void tick_nohz_idle_enter(void) { }
 static inline void tick_nohz_idle_exit(void) { }
 static inline bool tick_nohz_idle_got_tick(void) { return false; }
-
+static inline ktime_t tick_nohz_get_next_hrtimer(void)
+{
+	/* Next wake up is the tick period, assume it starts now */
+	return ktime_add(ktime_get(), TICK_NSEC);
+}
 static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 {
 	*delta_next = TICK_NSEC;
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 6fa52cd6df0b..8d18e03124ff 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1022,6 +1022,18 @@ bool tick_nohz_idle_got_tick(void)
 	return false;
 }
 
+/**
+ * tick_nohz_get_next_hrtimer - return the next expiration time for the hrtimer
+ * or the tick, whatever that expires first. Note that, if the tick has been
+ * stopped, it returns the next hrtimer.
+ *
+ * Called from power state control code with interrupts disabled
+ */
+ktime_t tick_nohz_get_next_hrtimer(void)
+{
+	return __this_cpu_read(tick_cpu_device.evtdev)->next_event;
+}
+
 /**
  * tick_nohz_get_sleep_length - return the expected length of the current sleep
  * @delta_next: duration until the next event if the tick cannot be stopped
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
