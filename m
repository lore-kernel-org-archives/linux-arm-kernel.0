Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA678C5ACC6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:48:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC6521104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H++aTNv8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CxUDChM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC6521104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=3w6w6IUL4bMWKYujpA4ncTf1djAaFIpEzFS8Ejf3WQM=; b=H++aTNv8TXU8FpWfc8XkobMyCd
	h3WUaT2xOcgxGZ71OCbgg1LAK7FmAe0eHIDHD+OvWsVGCXInlRkIvirxTeVi2GyCcQI1N7P79kblT
	AxCbXlnEDrhBwjIlWPafht3FZu2E8tNfsIaIdnP+RjinH1gtqR69Is2gMi7Uco231pLJZH0ElgX01
	+uNRMb0viZL9J1AOdZE6AEN4X6pL6+S+euSJITGLjoMgD34CCEe1zGA5Ugaes+BGb5V1QeIklCSUp
	aIB56n/9xvOXKYoWZHjbSD5wbRHfK6PVzvwiQb4Ved/iu32RneW8q47FyhTrIH/bjGnTM9Rq69VLa
	XO+pMajw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQQA-0001ns-A2; Thu, 29 Nov 2018 17:48:14 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQPK-00016m-Lw
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:47:25 +0000
Received: by mail-lf1-x144.google.com with SMTP id i26so2122473lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 09:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=We8CaGvJmbhYNYzrL7xua655X98bhiXXYfxMtnIUbcg=;
 b=CxUDChM/RBvhrA31XzUsCNP+4FezP+eXEflQmQnd54XH4DLPYar6y05JtbZh1VkOR9
 SkqR/CZFgNzntsxd4Oe81r1RyldMKKKEpGM2IwKlpysWwwEyVbXW691jkPCx5rLzQP/r
 x2cpT4wVVole1llA1ynH/xIBV8qW3U8BBRoCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=We8CaGvJmbhYNYzrL7xua655X98bhiXXYfxMtnIUbcg=;
 b=ber2S9rx+hrrlcthy4TFLyF3SmuSy2VMU+aYCvm4raOrHXZ95VCV+PonbrbKTq+dLi
 NvZIIvWNl+cPXsxkkj651MxiZDsx5ELgk8CIhU3zFu/l35ubussDI4o++cnFaP430sgY
 WrX2c6Qm0dznkESQGCBXWaR5IfbnY1/F6UsHWt81NICoRYbJZbwzvcq9EesqQFuaUtIu
 p/Ff10kA2W4DBhbdtNmbj/dE8VbPEj9uJ4JenndzZ9S2VAPA7FwajuIFD0Wh5bOaRxSX
 TauhZhqL3Tr/avSihvxUsIOkk+zFEpbhT/hZ2/ZpwT5tnQaPJ2OxeyBq4my6FNuAYWP9
 y9CA==
X-Gm-Message-State: AA+aEWadg2PouC5495XsUVRPMQeN7u7AJLI6wmvmleLb8RUFFpFDhpvA
 Ag1uLWaE+jvgshLy6QWYi4dEuA==
X-Google-Smtp-Source: AFSGD/X5ijktJZyrJe4NVc5D4Xj3iZjspHtp3e2YPqQ10kRYH3SesOqeSLOZT9YaqgkfpSVEiZRWsQ==
X-Received: by 2002:a19:6806:: with SMTP id d6mr1607974lfc.48.1543513633779;
 Thu, 29 Nov 2018 09:47:13 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 09:47:13 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v10 03/27] timer: Export next wakeup time of a CPU
Date: Thu, 29 Nov 2018 18:46:36 +0100
Message-Id: <20181129174700.16585-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_094722_733552_E46C2B12 
X-CRM114-Status: GOOD (  15.43  )
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
 Tony Lindgren <tony@atomide.com>, Lina Iyer <lina.iyer@linaro.org>,
 linux-arm-msm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Lina Iyer <lina.iyer@linaro.org>

Knowing the sleep duration of CPUs, is known to be needed while selecting
the most energy efficient idle state for a CPU or a group of CPUs.

However, to be able to compute the sleep duration, we need to know at what
time the next expected wakeup is for the CPU. Therefore, let's export this
information via a new function, tick_nohz_get_next_wakeup(). Following
changes make use of it.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- Updated function header of tick_nohz_get_next_wakeup().

---
 include/linux/tick.h     |  8 ++++++++
 kernel/time/tick-sched.c | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 55388ab45fd4..e48f6b26b425 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -125,6 +125,7 @@ extern bool tick_nohz_idle_got_tick(void);
 extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
 extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
+extern ktime_t tick_nohz_get_next_wakeup(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
 
@@ -151,6 +152,13 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 	*delta_next = TICK_NSEC;
 	return *delta_next;
 }
+
+static inline ktime_t tick_nohz_get_next_wakeup(int cpu)
+{
+	/* Next wake up is the tick period, assume it starts now */
+	return ktime_add(ktime_get(), TICK_NSEC);
+}
+
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
 
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 69e673b88474..7a9166506503 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1089,6 +1089,19 @@ unsigned long tick_nohz_get_idle_calls(void)
 	return ts->idle_calls;
 }
 
+/**
+ * tick_nohz_get_next_wakeup - return the next wake up of the CPU
+ * @cpu: the particular CPU to get next wake up for
+ *
+ * Called for idle CPUs only.
+ */
+ktime_t tick_nohz_get_next_wakeup(int cpu)
+{
+	struct clock_event_device *dev = per_cpu(tick_cpu_device.evtdev, cpu);
+
+	return dev->next_event;
+}
+
 static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 {
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
