Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D3EC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:07:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C378121473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gtfp6gSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C378121473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KGZjngZOgXIW+LXIWe7ygBbZVZJeAkmKSYO2qXQmIZI=; b=Gtfp6gSArYu9++
	37NhAamUgwWOSF08B82wCC39FGPyniqVwk2iX0m5/0UzXfcIu4epktGK1YjbIu8Vnf/AtTCnpoFfS
	Jc5/EnHx+48iR1cF3cyIZCIOFhT4QQE7q/ILY4S1fjPlB2hACsGR4Lfwq4twsSC6YvRtgCYvC4sh5
	PSgr6Y1XiJVdfQ+w7F31zluynLE8qDlQpfof8wWcNl5tJcc5qEc1qFwO27gKUsOGPzYgmJvMyYjhn
	2i6GefhjJfa5YE0FBXjb+dFQRs37WE5sa81d7UdluMS33QSX5lNoNTDP9YeAMJI0ISCY3+6O2TAQp
	wL27rGNujEoCHaf2GiRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gopai-0005cb-8E; Wed, 30 Jan 2019 13:07:44 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gopZM-0004cm-KU
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 13:06:36 +0000
Received: by mail-ot1-f65.google.com with SMTP id s13so21025392otq.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 05:06:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L/xB8+fKGsHNHqt+qw739geAKACge/qKuZW9F1aYPGU=;
 b=kSPtuki95rw1gFmgUC8rHQ/wb0R2z0eapOgYKwOlWehGMEczoVIGhVhRxN6Ao619Xu
 R+10f+HfrrpX+yKWsEdysbR7K2tIGH8VwLVvshUs6iv0OvwBKgBRv2nh5nQci2KqxDCL
 FFWflRG39kCBMdnNGVbyaP2tthx2wNJfDXe0xqt0OKnUAEJZcsUG7TbgaT7SSHHrybjc
 ilBFq9mudVSMO64mIVFZlscpMAkSJL1hr9b+I9XsL5Q00kMcOpMJlgiZ1WAGFy9Rv4RA
 q8ZOqu5Qw4yaQP6kWirL85QAn5S75BoMlpDVQ7bgFzIr/jnNkkHP0J4UMwW+8L14lV6a
 oNiw==
X-Gm-Message-State: AJcUukcYCp6vlZ/1dOai37mm6SNgR3PqKmTcryWYb7MsKzIZv38M69dG
 DpRzlbg+fsXvEd+fMuJ3BJ8qe52Fpj8HKh42J8ctedz0
X-Google-Smtp-Source: ALg8bN6Ty+Fh1ghF2ukWnelA6x0UzMZrPDCzhSDkSe54qYG+eYjZ+xTo79yOyzGKpEBSvadJ2z5deMxrHbIxP9Bb3wQ=
X-Received: by 2002:a9d:63c1:: with SMTP id e1mr21471175otl.119.1548853579044; 
 Wed, 30 Jan 2019 05:06:19 -0800 (PST)
MIME-Version: 1.0
References: <1548846984-2044-1-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1548846984-2044-1-git-send-email-vincent.guittot@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 Jan 2019 14:06:07 +0100
Message-ID: <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
Subject: Re: [PATCH v2 ] PM-runtime: fix deadlock with ktime
To: Vincent Guittot <vincent.guittot@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_050621_376692_CA8179C8 
X-CRM114-Status: GOOD (  22.60  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ladislav Michl <ladis@linux-mips.org>,
 Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Biju Das <biju.das@bp.renesas.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 12:16 PM Vincent Guittot
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

I've queued this one up as a fix for 5.0, but unfortunately it clashes
with the patch from Ladislav Michl at
https://patchwork.kernel.org/patch/10755477/ which has been dropped
now.

Can you or Ladislav please rebase that patch on top of this one and repost?

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
