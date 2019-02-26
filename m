Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C940C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:31:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC5121873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lKL92re0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJ2Ffgn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC5121873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I6cnz6yWmFKF1qn1N9t00vHkW/rML6nL/fqH40DujJs=; b=lKL92re0Y0tOkh
	ZI+FNrYwLFXHZOKy5xsARbGSel3LUGaMSXhKp8jCj9f1ZSQ5gM4HqIP5aqoy8W+oHQIWeD6RDbMEm
	AKVoAdymjXpEpcayEoDFALW3596tvJw8QEaHXE76m+IjpzWYuqGXPYOLTyACxV/HuTSp+Zd0Dym5l
	48gyLbINzYpLfXxQg3pU7gT/91omOaL4abqM+fgeXZTbmwj4dr1kHRaXR+G9R+/YVVTrVs9WIfN0x
	NefGlVfXp5ePj796GudXKschwgOezvreYArkT+jiRsjt6w8+jMU33NCRg11kH/+pk4QHtqZdEkO+D
	Mmd3KoixrbACsRlCeI7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gykKH-0004Bb-9J; Tue, 26 Feb 2019 21:31:45 +0000
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gykKD-0004B7-P5
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 21:31:43 +0000
Received: by mail-ua1-x943.google.com with SMTP id a42so13345708uad.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 13:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MNH3w69WqOSu5UatortvtlpMyhV0iCePp1B4bd4pGfs=;
 b=QJ2Ffgn4FYd7FSlHQz91s6PQgtgw+rPb61PgEwN4WzyhUMWLJii9JQcEeiAs36H4LS
 LkaXYYmHaxnU8GqdNcbWdPnCoFJ+6WqKydbHioNPOLEA3vXVWONyP0yelY9lPABalgmi
 ei9GwvdiMkdcolQViBk8dV4jEY2//v0P3oseX2k0AIKLESHaSHc8SvQDgIji97WTG9Ga
 ah6y7dbAq6XSQkN8JtlfuROFw4EEaibZGdSF2BnSK9oVteZsRTbKiSLnLv1dtlhB5+aE
 bxROEqFhr274NMBUztCBgOL4waw7vCPvuhaIOT0PY92rqGZMw8Sg670dRVOTpkWd7+B1
 zidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MNH3w69WqOSu5UatortvtlpMyhV0iCePp1B4bd4pGfs=;
 b=NuT0Ud6rCdugISkAma30aEwnfauzlRAeSqbJ8FeCyrPNxGDeS3ND66BF17mYWnGKn8
 jrez0xKa64+85x8ldISs7/qsnZvc0dFy6WX7ZWEmwSswnG5Fno/PXTkTwgRlXTJkgboo
 ij64MSuD+lKhIc8wpX2/iRgKLvgNXZjUsT84oVhAkuLWHKLWDa4YL0PUa32RMq0vtGMo
 tmcyyvhYVfVg9yt8WuWGbGn2+b9Zjj+IknE9o0jvBhWt4EEFbhbHj8Jwa6koDv3q9vKq
 v0W9rlVtqFgfJy6ClXeq8sux/qUXCnYGj3vViZwQzEX9nc/LYpZ8n3DgdEyuWrLZCHjS
 mDkw==
X-Gm-Message-State: APjAAAWAoiA7qRsaETqr7ciPDYP7tx09JfBubxaTsnnbc+ujQIBmq+4V
 oZPZRD7cRwoagBHT1jDKleolzoMEW7XJEgC29CBb3yE8+pQ=
X-Google-Smtp-Source: AHgI3IbC+CmzOj2j1U6/4V1XOEpVwIa7h8kXAQjncLu4b+RVHmgehpiOjjOd3fhofYEGHeRdaRs0MjEE2bVOj7hOPN4=
X-Received: by 2002:a9f:3707:: with SMTP id z7mr130372uad.25.1551216698112;
 Tue, 26 Feb 2019 13:31:38 -0800 (PST)
MIME-Version: 1.0
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
 <CAJZ5v0jiUWsYeQm8xoGf=WpM+yWdnPnkGK0+amPb=3PUE+APfg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jiUWsYeQm8xoGf=WpM+yWdnPnkGK0+amPb=3PUE+APfg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 26 Feb 2019 22:31:01 +0100
Message-ID: <CAPDyKFonaODSwNLTOxx=94S2ZNPy5VT07b+niJag0RH=QDatpw@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To: "Rafael J. Wysocki" <rafael@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_133141_849106_D0D73CDF 
X-CRM114-Status: GOOD (  25.10  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>,
 Lina Iyer <ilina@codeaurora.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 26 Feb 2019 at 18:50, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Feb 26, 2019 at 3:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Changes in v11:
> >  - This version contains only the infrastructure changes that is needed for
> > deployment. The PSCI/ARM changes have also been updated and tested, but I will
> > post them separately. Still, to provide completeness, I have published a branch
> > containing everything to a git tree [1], feel free to have a look and test.
> >  - The v10 series contained a patch, "timer: Export next wakeup time of a CPU",
> > which has been replaced by a couple of new patches, whom reworks the existing
> > tick_nohz_get_sleep_length() function, to provide the next timer expiration
> > instead of the duration.
> >  - More changelogs are available per patch.
>
> NAK for patches [4-6/8].
>
> The code as is specifically avoids calling ktime_get() from the
> governors as that can be quite expensive, so these patches potentially
> make things worse.

Yeah, good point! What do you think about folding in a patch into the
series, like below, and then let the cpuidle governors use it?

One questions about when CONFIG_NO_HZ_COMMON is unset for the below
suggested code, does it make sense to "return -1" for that case, or
should I return ktime_get()? Does it matter?

Thanks for reviewing!

Kind regards
Uffe

From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 26 Feb 2019 21:43:46 +0100
Subject: [PATCH] time: tick-sched: Add a helper function returning the idle
 entry time

To avoid calling ktime_get() unnecessary times during the idle path, let's
export the timestamp we stored in the per CPU variable,
tick_cpu_sched.idle_entrytime, at the point when we entered idle.

Following changes to the cpuidle governors makes use of this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/tick.h     |  2 ++
 kernel/time/tick-sched.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 5b10a0e4acbb..b641f6e4a50f 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -126,6 +126,7 @@ extern void tick_nohz_irq_exit(void);
 extern bool tick_nohz_idle_got_tick(void);
 extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
 extern ktime_t tick_nohz_get_next_timer(void);
+extern ktime_t tick_nohz_get_idle_entrytime(void);
 extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
@@ -158,6 +159,7 @@ static inline ktime_t
tick_nohz_get_sleep_length(ktime_t *delta_next)
        *delta_next = TICK_NSEC;
        return *delta_next;
 }
+static inline ktime_t tick_nohz_get_idle_entrytime(void) { return -1; }
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 9966be665074..e5d66b618bfa 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1127,6 +1127,16 @@ ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
        return ktime_sub(next_event, now);
 }

+/**
+ * tick_nohz_get_idle_entrytime - return the time when we entered idle
+ *
+ * Called from power state control code with interrupts disabled
+ */
+ktime_t tick_nohz_get_idle_entrytime(void)
+{
+       return __this_cpu_read(tick_cpu_sched.idle_entrytime);
+}
+
 /**
  * tick_nohz_get_idle_calls_cpu - return the current idle calls counter value
  * for a particular CPU.
-- 
2.17.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
