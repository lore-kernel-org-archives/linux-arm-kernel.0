Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CE4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:56:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C9821848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nsR5y/Qw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n7uIvug2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C9821848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=nAtAZpm4ZNTrNrNSGbGBJ0UP5V4rzKoldHcboHkoPro=; b=nsR5y/QwRWptw4aC2MbPkthmCt
	8ldPw/HTMfCviJ8wTBLRcnlcO9UIjfdeh3GOZk6LuOnLMRZeCN0f+Ow+AZhZya6l1LRd1rrGQwbIT
	jDXmvw0w2/22mcfQ007Ah9Vkyr6XXS91yda4u0nEvpBLFwG9Qsbpg9fbQPsPZRGlLk3paIb1QDbJM
	XKyCuYcwFLR7PaFstxpSiuRRKhfAY+pREcRKMQ3BcwzoSkOChJYZckaTAdJySERiRBpizE0tPO+PT
	Y5axgwe4ip9uNRwjJMzdc7pbf/eSkFYUdO+jFgbgUUahymoztaiF+UpRax/MGN1do0DQ2oUFfVS+J
	+Xnp/04Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gye9J-00088n-Ok; Tue, 26 Feb 2019 14:56:01 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gye81-0005RA-W3
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 14:54:48 +0000
Received: by mail-lj1-x241.google.com with SMTP id z25so11019713ljk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 06:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7Kl3KIsTbVNnLIJETkqUkswPckk4QEkcaiOEMLrmE0U=;
 b=n7uIvug2vs/kr0RJhQcdk7BSHrob5nvRXyL0xNSxYnHFnnMKjuMDRuby6EvZhP8bIQ
 sEYAZFh2urn9DNVCLN5raj4+lCcuGxSZHrQSdsISgzZi+LnkU7Y9EAiAT0yLLDsNv/91
 yJK71O7bWyCWWNnL5495Puaw0fpepx6aL4venBxoepro1Y72A1ytEOBcfjDqI48F+zmU
 Oh1P6GO0N+LiCwNlB7ssEj9oyJ9A9Oa1ROLwtEV+BbUuGmXb+kMWjx22hoV7q+XLdaOA
 3CjmUKkM6RiMFGcf6nXNVb/hmr2vZCCmETUMiDFJ59GXm/VtpI8sEPIBPKj33vsL/sPW
 sPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7Kl3KIsTbVNnLIJETkqUkswPckk4QEkcaiOEMLrmE0U=;
 b=O+GZDoSSHACEuLpV0rROr+RQLmka1/WFhOZs7pvqPB74R1o5ZPHyysZXHyiUfwcuOO
 7/ELkiFmYkkl/OrLAyGyDgkEypZvm8w1Q/qk+J1tH0MZc3KDuFdWgdBS9dYfU4zqeX5r
 e44XHu/ilTG4L3e7YXrwgSVDiQdMqR6GgqPKL1F499J3z360gIsnCD+ZHRdw/b1sYdhA
 Hz3G+yb3krf7A9v+w4ueNkT0NgtVre8FKconRfAzHeEZrrzGV6MxZo00YJClJ4uDeQMN
 uXLDJetN4ekTbyG1qHoRXZuVcNI7SdljitPGIt1NmbsgIaZX49zcvU8jjLM01od+rjJF
 /Ycg==
X-Gm-Message-State: AHQUAuYBOONNeYZAXVb01/zR4I0xlpGu5qEN3Tar/t2EtEi2/SHcSeZj
 KHQLvyTtDj7Ozl2wQnAcJTW9Ag==
X-Google-Smtp-Source: AHgI3IatimNXxbZ0UlAUMjP41vSG7rroGtk09LV0giyDGyOxLDbucKAoH6kRcU7fitCx8KE+Ma61NQ==
X-Received: by 2002:a2e:4285:: with SMTP id h5mr13819746ljf.32.1551192880350; 
 Tue, 26 Feb 2019 06:54:40 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id t11sm2206554ljj.92.2019.02.26.06.54.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 06:54:39 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH v11 6/8] time: tick-sched: Remove tick_nohz_get_sleep_length()
Date: Tue, 26 Feb 2019 15:54:13 +0100
Message-Id: <20190226145415.19411-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226145415.19411-1-ulf.hansson@linaro.org>
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_065442_371079_1A351EBB 
X-CRM114-Status: GOOD (  14.28  )
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

From: Daniel Lezcano <daniel.lezcano@linaro.org>

There are no longer any users of tick_nohz_get_sleep_length(), so let's
drop it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
[Ulf: Clarified information in changelog]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v11:
	- New patch.

---
 include/linux/tick.h     |  6 ------
 kernel/time/tick-sched.c | 39 ---------------------------------------
 2 files changed, 45 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 5b10a0e4acbb..1a0158736072 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -124,7 +124,6 @@ extern void tick_nohz_idle_enter(void);
 extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
 extern bool tick_nohz_idle_got_tick(void);
-extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
 extern ktime_t tick_nohz_get_next_timer(void);
 extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
@@ -153,11 +152,6 @@ static inline ktime_t tick_nohz_get_next_timer(void)
 	return tick_nohz_get_next_hrtimer();
 }
 
-static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
-{
-	*delta_next = TICK_NSEC;
-	return *delta_next;
-}
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
 
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 9966be665074..a376c7db26ce 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1088,45 +1088,6 @@ ktime_t tick_nohz_get_next_timer(void)
 	return min_t(u64, next_hrtimer, next_timer);
 }
 
-/**
- * tick_nohz_get_sleep_length - return the expected length of the current sleep
- * @delta_next: duration until the next event if the tick cannot be stopped
- *
- * Called from power state control code with interrupts disabled
- */
-ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
-{
-	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
-	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
-	int cpu = smp_processor_id();
-	/*
-	 * The idle entry time is expected to be a sufficient approximation of
-	 * the current time at this point.
-	 */
-	ktime_t now = ts->idle_entrytime;
-	ktime_t next_event;
-
-	WARN_ON_ONCE(!ts->inidle);
-
-	*delta_next = ktime_sub(dev->next_event, now);
-
-	if (!can_stop_idle_tick(cpu, ts))
-		return *delta_next;
-
-	next_event = tick_nohz_next_event(ts, cpu);
-	if (!next_event)
-		return *delta_next;
-
-	/*
-	 * If the next highres timer to expire is earlier than next_event, the
-	 * idle governor needs to know that.
-	 */
-	next_event = min_t(u64, next_event,
-			   hrtimer_next_event_without(&ts->sched_timer));
-
-	return ktime_sub(next_event, now);
-}
-
 /**
  * tick_nohz_get_idle_calls_cpu - return the current idle calls counter value
  * for a particular CPU.
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
