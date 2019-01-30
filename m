Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1A8C282D5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:17:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1005A2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MeKUEal2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OftG1KsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1005A2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=l6LoRqFxwjQWZeXvApWyfFFv2mnFEIgYgQCrpG9iVTM=; b=MeK
	UEal2D6U7/3JKXlLdfohN6QpBk2rlRoG20tBRXe2p0MUXYiFjDseYsG6Dil1P8e9PBATgxYSu61p9
	tvSCpVRkLCBPEqYb/tkrLNyk9iN3/ANv9A1HxVNxq9nCoIHpYjNZsXMGQ2lwBwB8CFU09lnoXtXqE
	4SfRNGHSKvrvRH1/aUg7ivPoPo2LicMzdMsdd9LfSMsZiAwERrYTLoA/nn7up8qZ3vV/emyYFLAhV
	lFYTr/HXZlK8GloW3IIyXAgWlz2w3Lx05qQ6YaCYiMP9Uv2yv8Iq1r5UAZ3/rGG3IkdeSWNTPH+ON
	KoFYuwmblx8SA9xwRJVT7meqSVtIx9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gol3d-0001Pk-Ud; Wed, 30 Jan 2019 08:17:17 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gol3I-0001Eg-Jd
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 08:17:03 +0000
Received: by mail-wm1-x343.google.com with SMTP id y185so14838515wmd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 00:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=6lyGIVRnQ1BZvQ2ddIjLm1Fs9ngmnkEvH1AhMLp+N2Y=;
 b=OftG1KsKOarpHCwPtS6SGEeDQz//JSHkDh6FbZgPEbNADXVGHgC7QcGsFawMwIj557
 tdY1JNElo/xPW/bzdizrfqcxKwEEKbLw88AIqyNPKXDEO7OuF4GIt73+VD+IfaSNcib+
 hWe/H80y1eYeD7Z2WmAN6MnWTRGlZgg5hEP4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=6lyGIVRnQ1BZvQ2ddIjLm1Fs9ngmnkEvH1AhMLp+N2Y=;
 b=Hd5JZTFGD4sAbGpe5n2T1h6FTrtJFpKfKg3bq1q9IQe4iM1Iw4kESneH4wf3PK8JkV
 PJgUQsVJHw/0RvgD0nRcU3B4KKbpW/RdtcZcUMmR58CROALqkcey5IcyM7dExf0pLiHs
 OVXo+5mIRNK4PHU7UqhGBjHjmSUKTum04IdowAgDJmeZ2r67BrPiyDuo7eAsguM9yZ38
 GatxjDSdljDxwpaiGV2A6LrE1XxpQacEYv14OO3VtcGGJVQerVunkhd2x0DlGX7a2TzI
 gV1P9iMtnFgQiOTi48izI4zZSKRa1csqbOmPaocUi5OxSwv4SDgDK8DWKmShCN/p2EPO
 Gqeg==
X-Gm-Message-State: AJcUuke/s732F3nYTZkQYnFcpPYWE/iYEORz7uTqprANcC0ORKPbqiMo
 zICmas9U/S4GV3gZv3w9TqY5Cw==
X-Google-Smtp-Source: ALg8bN4X9PAHIE82svv2XmbTltSN2N7UeURKnK285EY/7L5ZaBqwYT92eBN53UCyQgudHlAmYKAjiA==
X-Received: by 2002:a1c:67c2:: with SMTP id b185mr22603694wmc.96.1548836214254; 
 Wed, 30 Jan 2019 00:16:54 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:79e5:6689:e4d2:d212])
 by smtp.gmail.com with ESMTPSA id t5sm1952500wmd.15.2019.01.30.00.16.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 30 Jan 2019 00:16:53 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
 rjw@rjwysocki.net, ulf.hansson@linaro.org, biju.das@bp.renesas.com
Subject: [PATCH] PM-runtime: fix deadlock with ktime
Date: Wed, 30 Jan 2019 09:16:34 +0100
Message-Id: <1548836194-15264-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_001657_075238_6682463E 
X-CRM114-Status: GOOD (  13.42  )
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
Cc: linux-renesas-soc@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>, geert@linux-m68k.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A deadlock has been seen when swicthing clocksources which use PM runtime.
The call path is:
change_clocksource
    ...
    write_seqcount_begin
    ...
    timekeeping_update
        ...
        sh_cmt_clocksource_enable
            ...
            rpm_resume
                pm_runtime_mark_last_busy
                    ktime_get
                        do
                            read_seqcount_begin
                        while read_seqcount_retry
    ....
    write_seqcount_end

Although we should be safe because we haven't yet changed the clocksource
at that time, we can't because of seqcount protection.

Use ktime_get_mono_fast_ns instead which is lock safe for such case

Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
Reported-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/power/runtime.c | 10 +++++-----
 include/linux/pm_runtime.h   |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 457be03..708a13f 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -130,7 +130,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
 {
 	int autosuspend_delay;
 	u64 last_busy, expires = 0;
-	u64 now = ktime_to_ns(ktime_get());
+	u64 now = ktime_get_mono_fast_ns();
 
 	if (!dev->power.use_autosuspend)
 		goto out;
@@ -909,7 +909,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
 	 * If 'expires' is after the current time, we've been called
 	 * too early.
 	 */
-	if (expires > 0 && expires < ktime_to_ns(ktime_get())) {
+	if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
 		dev->power.timer_expires = 0;
 		rpm_suspend(dev, dev->power.timer_autosuspends ?
 		    (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
@@ -928,7 +928,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
 int pm_schedule_suspend(struct device *dev, unsigned int delay)
 {
 	unsigned long flags;
-	ktime_t expires;
+	u64 expires;
 	int retval;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
@@ -945,8 +945,8 @@ int pm_schedule_suspend(struct device *dev, unsigned int delay)
 	/* Other scheduled or pending requests need to be canceled. */
 	pm_runtime_cancel_pending(dev);
 
-	expires = ktime_add(ktime_get(), ms_to_ktime(delay));
-	dev->power.timer_expires = ktime_to_ns(expires);
+	expires = ktime_get_mono_fast_ns() + (u64)delay * NSEC_PER_MSEC);
+	dev->power.timer_expires = expires;
 	dev->power.timer_autosuspends = 0;
 	hrtimer_start(&dev->power.suspend_timer, expires, HRTIMER_MODE_ABS);
 
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 54af4ee..fed5be7 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -105,7 +105,7 @@ static inline bool pm_runtime_callbacks_present(struct device *dev)
 
 static inline void pm_runtime_mark_last_busy(struct device *dev)
 {
-	WRITE_ONCE(dev->power.last_busy, ktime_to_ns(ktime_get()));
+	WRITE_ONCE(dev->power.last_busy, ktime_get_mono_fast_ns());
 }
 
 static inline bool pm_runtime_is_irq_safe(struct device *dev)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
