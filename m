Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA19AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:56:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 737E020C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IsbpxhrQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WXbnVH1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737E020C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Wt+b5LsmlXwIxAsuF3oXhnfH5hixL6xnxk2iUBZXLWU=; b=IsbpxhrQq/mMeAv8tnELLZrnDn
	Y/qNIQ/56LszuH6c2gEiCrmeV1JlJ9qJgUDgYjuaVhTJJSuOv++2LG3HMqgPFtxnYxIP7jq9PUdXm
	nVCiOEvsb/R+6SeQApWaGOmJxqrHHDKqww7RsOmLGSeMizwBLGVtfk8Lgs3aSIac7ZdfDdIuCQgmZ
	FkUIhDCjbD8QlHcw0rGZfS5S11XpNaQvj3wWPc1MpVibjyEjFxqjqBLBdSmg3+ruHchUuVwamd9LZ
	8o/wizBYJNr6IoOw75ZcDXB0JppfUQu+NeN19pxgxUJERPNe+BvEj4UeIDtcUCBCttHQ8pxO+HzCq
	B3H73h8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gye9U-0008NJ-EF; Tue, 26 Feb 2019 14:56:12 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gye84-0005TI-0P
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 14:54:50 +0000
Received: by mail-lf1-x144.google.com with SMTP id q12so9864490lfm.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 06:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AMYIr19DhL7wC893nIVn3Y+H+G175+i8XlmQ/dWB4wQ=;
 b=WXbnVH1bnHlmFW3O8yFUbl6Uw3ZNLM4we+2msBhbMMZoJTPSnF7TyZVvnUuqKPCXpx
 V1+/lFSM8P0nVXxaNK7jld1v/1f5rPMP1nUihV6qSwvNUskToK5HM7OvZFJZ6QyXD8B/
 X3XdzTBVLG+TGrdb9bpWwV6YdS7dUoi9AEZKmGa1m7AOFq+rqYkZMX4erNtlKmkiu4Ld
 PHX76Ti+FlXmTILcikEJSWJcoTZh/Hu52AVe7t3KkL5eJM1//lF4ZvF0lt+CkXZWNNMO
 ECX5oXpDzSw7kqPYIDSZH4kzNlYhbt4LafqJAdFzNtkcUXJInTkeNx5CDxOTL8gcOmwk
 USXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AMYIr19DhL7wC893nIVn3Y+H+G175+i8XlmQ/dWB4wQ=;
 b=DYYTbSxEKLW3kZpGNTsO6ww9XWWkV3LpD2Ua22aHJnnd8BbSDfMsego+ZSdeqDqLF2
 /M2OUYH+eF7TrFuyCMwI+pG5dQqxMA0OZp0liIUAv/aTSxo8RCrAqewN1W4V1QG9iKgB
 /3cxufBl6mASW5ZEVnDQhDpPZKmrms0YZbueAgDHbBrQEVqLXp+hXu+1O6blh/SDdSi7
 F4qyrOoDYUEkHRIW2cZp/pAE/r3U6ys7onbURx68iXx7Ry/ceWT5Q3UnJY+HJDjwU3qS
 92Eh11OERWkiIVjW9scE3j0y5wuGPZqpP0ggDWLFHPQOuoMN3YtxiK0ILiL4GpKlEeyv
 S7+w==
X-Gm-Message-State: AHQUAubgThjga7C7aWENOBV7giWnHnHdWFpPeyWgiGVd16LW9I6hoBs8
 2ZkU2M2uiFZq5nY5cwW9KA1l0Ky31Ck=
X-Google-Smtp-Source: AHgI3IaNV91xIKeFyKjyyZRkFvds0amqlzky1w/KDmal/FUD1TWohEu1I+qqz3hzqvkCZV5Je/GfQw==
X-Received: by 2002:a19:9a47:: with SMTP id c68mr7984024lfe.139.1551192881912; 
 Tue, 26 Feb 2019 06:54:41 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id t11sm2206554ljj.92.2019.02.26.06.54.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 06:54:41 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH v11 7/8] cpuidle: Pre-store next timer/tick before selecting
 an idle state
Date: Tue, 26 Feb 2019 15:54:14 +0100
Message-Id: <20190226145415.19411-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226145415.19411-1-ulf.hansson@linaro.org>
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_065444_630152_F4A321BE 
X-CRM114-Status: GOOD (  18.10  )
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

A common piece of data used by cpuidle governors, is the information about
when the next timer/tick is going to fire. Rather than having each governor
calling tick_nohz_get_next_timer|hrtimer() separately, let's consolidate
the code by calling these functions before invoking the ->select() callback
of the governor - and store the output data in the struct cpuidle_device.

Besides the consolidation benefit, the purpose of this change is also to
make the information about the next timer/tick, available outside the
cpuidle framework. Following changes that implements a new genpd governor,
makes use of this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v11:
	- New patch.

---
 drivers/cpuidle/cpuidle.c        | 2 ++
 drivers/cpuidle/governors/menu.c | 6 ++----
 drivers/cpuidle/governors/teo.c  | 6 ++----
 include/linux/cpuidle.h          | 2 ++
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 7f108309e871..3b148253036b 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -312,6 +312,8 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		   bool *stop_tick)
 {
+	dev->next_timer = tick_nohz_get_next_timer();
+	dev->next_hrtimer = tick_nohz_get_next_hrtimer();
 	return cpuidle_curr_governor->select(drv, dev, stop_tick);
 }
 
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 95e9122d6047..cdbe434e783d 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -287,8 +287,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	unsigned long nr_iowaiters;
 	ktime_t delta_next;
 	ktime_t now = ktime_get();
-	ktime_t next_hrtimer = tick_nohz_get_next_hrtimer();
-	ktime_t next_timer = tick_nohz_get_next_timer();
 
 	if (data->needs_update) {
 		menu_update(drv, dev);
@@ -298,14 +296,14 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	/*
 	 * Compute the duration before the next timer, whatever the origin
 	 */
-	delta_next = ktime_sub(next_timer, now);
+	delta_next = ktime_sub(dev->next_timer, now);
 	data->next_timer_us = ktime_to_us(delta_next);
 
 	/*
 	 * Compute the duration before next hrtimer which is the tick
 	 * or an earliest hrtimer
 	 */
-	delta_next = ktime_sub(next_hrtimer, now);
+	delta_next = ktime_sub(dev->next_hrtimer, now);
 
 	nr_iowaiters = nr_iowait_cpu(dev->cpu);
 	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index bef1e95c597e..7af9851d9d40 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -245,8 +245,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	int max_early_idx, idx, i;
 	ktime_t delta_tick;
 	ktime_t now = ktime_get();
-	ktime_t next_hrtimer = tick_nohz_get_next_hrtimer();
-	ktime_t next_timer = tick_nohz_get_next_timer();
 
 	if (cpu_data->last_state >= 0) {
 		teo_update(drv, dev);
@@ -255,8 +253,8 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
 	cpu_data->time_span_ns = local_clock();
 
-	cpu_data->sleep_length_ns = ktime_sub(next_timer, now);
-	delta_tick = ktime_sub(next_hrtimer, now);
+	cpu_data->sleep_length_ns = ktime_sub(dev->next_timer, now);
+	delta_tick = ktime_sub(dev->next_hrtimer, now);
 	duration_us = ktime_to_us(cpu_data->sleep_length_ns);
 
 	count = 0;
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 3b39472324a3..81ec924206f0 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -83,6 +83,8 @@ struct cpuidle_device {
 	unsigned int		use_deepest_state:1;
 	unsigned int		poll_time_limit:1;
 	unsigned int		cpu;
+	ktime_t			next_timer;
+	ktime_t			next_hrtimer;
 
 	int			last_residency;
 	struct cpuidle_state_usage	states_usage[CPUIDLE_STATE_MAX];
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
