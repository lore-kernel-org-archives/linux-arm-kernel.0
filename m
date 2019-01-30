Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F43C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:26:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFD7120869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TuW9dcdS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PX4Vmspc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD7120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=6aHvpLZcNhRbQQgtJsiAsmZVuwZ2n80Qkz3u1/8tSAA=; b=TuW9dcdS6FaM2BJw/RZYTrVEjJ
	TYE6PX+sLNC87Tvta0fI/bsNfXLW9fVezzu2z2rC+ZxoDf8Gc/WVkM/JAnC7rji7VfUts9zYva75Y
	+1qfLvTyRm4+G7yYa2NzDWRK+yxFeiP8/YoLckO+4VSxSgjsRzvwLLm4Ca516MrTBGxxvaSAVmeNS
	gjEBaEjmV/rGm0iBkPA/4GzjlSwInmZJhHva5GQ5YLNWtmHVNuro8cEcF+tAp5lGZP+YRcfCdc4JV
	aKWq7Calw/l7vm5FC7osBoI2Peo7huECzyGYKB5uLxUqts/Xj6k+DakT0rZsi1ooY1PwTopVR+j/k
	8lxPzOXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gotdC-0000OM-VG; Wed, 30 Jan 2019 17:26:34 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gotd9-0000Nj-J7
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 17:26:33 +0000
Received: by mail-wr1-x442.google.com with SMTP id t27so350810wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 09:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XrfQDMdrfjMyVkUbTxAT96m6kQZT5x+Q2hxt4/3RgHY=;
 b=PX4VmspcuGJlI5kSXkkrHEjx7uuMvuSu4Tdiq2IndHoZypWy3KWdndOmsskUfneroW
 3Qyws2Sb+LFkk61+IirdrbA+LYmcw9j2s0CzVxg0R4ZhG80+kZPM6kS2ITvdCWQTcbLo
 21xwige6RxuDBe2AkP6g5UG0Jxn/xQUpB0NDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XrfQDMdrfjMyVkUbTxAT96m6kQZT5x+Q2hxt4/3RgHY=;
 b=oQrmEYwCMhp8kzsqJoW8wnhcjQfmw4xxgW4CM8KZQz2D3e1jnZ3Th95nveNA1pvhVu
 MHllQVdFVjCe942CgL/qXJKKz7yBZXIXCBW5iFleIs5MKI78kTOtYYfXQK3/LsLjIWgT
 RTIJ/zzg+JAUXlCbJDxtI8RsJMgjKVtCVjx/uf2Ff0kFV/fyOAqHXPgzElW/UkNCxidX
 JW/rZ9NV04gHO7lw4PCBp4rL+GT+250r8kq5j2mZ/CBWcHW6596WhMb69rqNwi6Wpwew
 RyonUt83SDdX35e7wMWplfiOa9DpvAaM9WONxfhncZyY67TuDds7NlpOPQWZAoiIjf7A
 WYYA==
X-Gm-Message-State: AJcUukcX+qi78Usji58tTDrqh8zl/97YydGsgSeRO3j2sS0a+qNfIoLQ
 brKdDJPbwlGj4tdBFFn1DjeZMQ==
X-Google-Smtp-Source: ALg8bN68ANqwhXSOIdAvTUOW7+mvPYnPeOS4Rp8O780MxglHXm4mtp+q8FZlo8ZHdqHSx3rwSwwVdA==
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr33405207wrw.50.1548869189563; 
 Wed, 30 Jan 2019 09:26:29 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:79e5:6689:e4d2:d212])
 by smtp.gmail.com with ESMTPSA id n124sm3618880wmd.15.2019.01.30.09.26.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 30 Jan 2019 09:26:28 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
 rjw@rjwysocki.net, ulf.hansson@linaro.org, biju.das@bp.renesas.com
Subject: [PATCH v3] PM-runtime: fix deadlock with ktime
Date: Wed, 30 Jan 2019 18:26:02 +0100
Message-Id: <1548869162-6223-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
References: <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_092631_624047_A351AB14 
X-CRM114-Status: GOOD (  14.21  )
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

Use ktime_get_mono_fast_ns() instead which is lock safe for such case

With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
monotonic across an update and as a result can goes backward. According to
update_fast_timekeeper() description: "In the worst case, this can
result is a slightly wrong timestamp (a few nanoseconds)". For
PM runtime autosuspend, this means only that the suspend decision can
be slightly sub optimal.

Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
Reported-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

Hi Rafael,

Sorry, I sent the version with the typo mistake that generated the compilation error
reported by kbuild-test-robot

This version doesn't have the typo.

Regards,
Vincent

- v3: fix typo error that appears while updating commit message
- v2: Updated commit message to explain the impact of using 
  ktime_get_mono_fast_ns()

 drivers/base/power/runtime.c | 10 +++++-----
 include/linux/pm_runtime.h   |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 457be03..0ea2139 100644
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
+	expires = ktime_get_mono_fast_ns() + (u64)delay * NSEC_PER_MSEC;
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
