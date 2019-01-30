Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBE4C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:15:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE8042175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XAHfufd5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UxVzKZW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8042175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+lLt2AOA+pyx0llQZgoR3XYHikvXv4bJt+lZQB+rR5Y=; b=XAHfufd5Qns1hK
	15cnUVl22jeW5lzwP/yqsMC4fsjdyIW733rYB4QLX+BeHsU7sBRWTB6qQI4XAx/tkbbzUoC4eivE4
	MQNAsqcC3aW8n6UoH2KpMXsqfOSFkLGnpfwurTOQiW39f7Cyelj2FBpLpcCFEOCnI4k3KP7/+x+Q5
	7XW2wPNGVaLBe8ZckC62yJcCywE1qjvjXIkCoJxmMws3Pzaedq7aob7/uUttyeKTjxxNdvuT7Abos
	kj3ssnVObygM0qQeIcc8VeKNak581DDhsFzEcLfrHBtrTou+NBAIputyz47C2VgYebFi/NktrFqMM
	eu4+WusJIMpF1e9aIIBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goomB-000855-Sa; Wed, 30 Jan 2019 12:15:31 +0000
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goom7-00084W-Sj
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 12:15:29 +0000
Received: by mail-vs1-xe41.google.com with SMTP id b74so14074923vsd.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 04:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yhJIweRM2BZxSTmYhsNSrIUGbPfdVazOuW402hLMoKk=;
 b=UxVzKZW5aZmGz307vl6v9NV3GscZ6l+KqNMlR4pyFyllXfciQTJVBcUk5h5bYcBl2o
 4FoAQcQVPzqt2J4W1rJCI7kMllk5fvaQda0yYh0dSlJaUu6dN/vHnE5/3NmmEUv4Qp+T
 /7O9TbFkTvwQYZVSIfxeTVDLR/YIO3N9wCGss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yhJIweRM2BZxSTmYhsNSrIUGbPfdVazOuW402hLMoKk=;
 b=VC524FcgvAwG13yDSUVJwfNzT3IkYT2+w/b8p5tUojw3aJlASwlevXljB8wb/fDbmn
 69iMjv0I8EVuWzq+Or2636iMeMSv4b9vejMMna52H+DedtUZfxAoY/Xet2VKsp3xutp9
 p8dswHHW839H+wZcX5vTA4Ht9PAB49UKk32fDujFrr4V1VYDBzBzSQqf4UQK5gfWAUyH
 CoFT5Y3gKm4MVXwolFdQyDkCPXCbr95HYg38dU22iiy598p4xV4DYyzrmsK1KCflHwD4
 Cw0LfUj5ZT6UEJZO79t/A+A0gg4/in5iOtRJb4nA7AABEkGLo/k156P1nlvxJrgIj+yu
 ccWQ==
X-Gm-Message-State: AJcUukdOcgZGcANE1nX6SN04WjQjMd67OMXZtkva98qRVTYXjr+Brjnr
 KvcJy1Q8EPFV+VhtU8rR/4oof/ZN1e34Blwye8PCFQ==
X-Google-Smtp-Source: ALg8bN5QbH0Ql4qXN7O9XHvt/0NWaNloJutDmm0PPaU0Qp8kFtS2lvjorhUfQWeYhGA7xuldxvOFgabR9w6eokQLpP8=
X-Received: by 2002:a67:b245:: with SMTP id s5mr12414544vsh.200.1548850522081; 
 Wed, 30 Jan 2019 04:15:22 -0800 (PST)
MIME-Version: 1.0
References: <1548846984-2044-1-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1548846984-2044-1-git-send-email-vincent.guittot@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 30 Jan 2019 13:14:46 +0100
Message-ID: <CAPDyKFpyg7oGoDZA+=SG7R3yL874Geeqs5LWrsAf50csxsE05A@mail.gmail.com>
Subject: Re: [PATCH v2 ] PM-runtime: fix deadlock with ktime
To: Vincent Guittot <vincent.guittot@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_041527_946178_E789BA72 
X-CRM114-Status: GOOD (  20.05  )
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
Cc: Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Biju Das <biju.das@bp.renesas.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-omap <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 30 Jan 2019 at 12:16, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> A deadlock has been seen when swicthing clocksources which use PM runtime.
> The call path is:
> change_clocksource
>     ...
>     write_seqcount_begin
>     ...
>     timekeeping_update
>         ...
>         sh_cmt_clocksource_enable
>             ...
>             rpm_resume

Hmm, isn't this already a problem in genpd then?

In genpd's ->runtime_resume() callback (genpd_runtime_resume()) we
call ktime_get() to measure the latency of running the callback.

Or, perhaps irq_safe_dev_in_no_sleep_domain() returns true for the
genpd + device in question, which means the ktime thingy is skipped.

Geert?


>                 pm_runtime_mark_last_busy
>                     ktime_get
>                         do
>                             read_seqcount_begin
>                         while read_seqcount_retry
>     ....
>     write_seqcount_end
>
> Although we should be safe because we haven't yet changed the clocksource
> at that time, we can't because of seqcount protection.
>
> Use ktime_get_mono_fast_ns() instead which is lock safe for such case
>
> With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
> monotonic across an update and as a result can goes backward. According to
> update_fast_timekeeper() description: "In the worst case, this can
> result is a slightly wrong timestamp (a few nanoseconds)". For
> PM runtime autosuspend, this means only that the suspend decision can
> be slightly sub optimal.
>
> Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> Reported-by: Biju Das <biju.das@bp.renesas.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> - v2: Updated commit message to explain the impact of using
>   ktime_get_mono_fast_ns()
>
>  drivers/base/power/runtime.c | 10 +++++-----
>  include/linux/pm_runtime.h   |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 457be03..708a13f 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -130,7 +130,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
>  {
>         int autosuspend_delay;
>         u64 last_busy, expires = 0;
> -       u64 now = ktime_to_ns(ktime_get());
> +       u64 now = ktime_get_mono_fast_ns();
>
>         if (!dev->power.use_autosuspend)
>                 goto out;
> @@ -909,7 +909,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
>          * If 'expires' is after the current time, we've been called
>          * too early.
>          */
> -       if (expires > 0 && expires < ktime_to_ns(ktime_get())) {
> +       if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
>                 dev->power.timer_expires = 0;
>                 rpm_suspend(dev, dev->power.timer_autosuspends ?
>                     (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
> @@ -928,7 +928,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
>  int pm_schedule_suspend(struct device *dev, unsigned int delay)
>  {
>         unsigned long flags;
> -       ktime_t expires;
> +       u64 expires;
>         int retval;
>
>         spin_lock_irqsave(&dev->power.lock, flags);
> @@ -945,8 +945,8 @@ int pm_schedule_suspend(struct device *dev, unsigned int delay)
>         /* Other scheduled or pending requests need to be canceled. */
>         pm_runtime_cancel_pending(dev);
>
> -       expires = ktime_add(ktime_get(), ms_to_ktime(delay));
> -       dev->power.timer_expires = ktime_to_ns(expires);
> +       expires = ktime_get_mono_fast_ns() + (u64)delay * NSEC_PER_MSEC);
> +       dev->power.timer_expires = expires;
>         dev->power.timer_autosuspends = 0;
>         hrtimer_start(&dev->power.suspend_timer, expires, HRTIMER_MODE_ABS);
>
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 54af4ee..fed5be7 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -105,7 +105,7 @@ static inline bool pm_runtime_callbacks_present(struct device *dev)
>
>  static inline void pm_runtime_mark_last_busy(struct device *dev)
>  {
> -       WRITE_ONCE(dev->power.last_busy, ktime_to_ns(ktime_get()));
> +       WRITE_ONCE(dev->power.last_busy, ktime_get_mono_fast_ns());
>  }
>
>  static inline bool pm_runtime_is_irq_safe(struct device *dev)
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
