Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3852C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:03:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E800206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rzXfCCYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E800206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TpM6+4k4HqUkId2scYe6qUQKpy8Y1BnEUuQL2L1o9hA=; b=rzXfCCYSHkFQTA
	biLDhQAJ8ztlcBq8kBagYCLs/MI6Cv4R7WghMe8kLh7e/b1/squTlowJKs1QOOfxiqZSsD9MxeedZ
	hJcHqz9nRz4463cVauyf2gVULJm9ReckBk180V1rl1Pv9UfyqPksP0G1/MSecECij2nMKu5Nq0PX5
	2cKVnyLPq2mqUqgqRm0jDqBaQJtzIh2bYgzun4qT4p6zLtZCpdakMSHeICb4qeh9QKKMFjr4D9h+J
	8NlWuRwP8+lHCJnQY7/Ka88gPRG1uGzYlE6Vsndw/ZlIBTWJWqgYev+HjBq3PubJuTru1/8hE3Jct
	BlN9Lo/Hcbc28UdGrP1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghLwV-0007hP-1t; Wed, 09 Jan 2019 22:03:19 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghLwR-0007gt-Ry
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 22:03:17 +0000
Received: by mail-ot1-f66.google.com with SMTP id i20so8174247otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 14:03:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pD8lUbgsvAgC2PXrMO7w5wwrxNUokLAV2D7ynhhr574=;
 b=NIxjlzluxvuAiGlX9rnN2pYTR9FDfNq1onIwEVgNScR0MEzph0nB/9NckM0JEtA6EY
 p5UoPp9lcEmlVOJJS7VenCxkFK/AQU+2h0eazKL6CaGOzKkY3w/f51KjaCdCuvMatsew
 27GYtiONhVf5D4qHkcjtU42fjB5M2fSHsQUuxw3Bc6vGxBpBKbj3T5vjUh4Afz5+v70W
 Z1ECJQniZTkqZMl2QOCsJomd2/PUoRM/SKKFwzkuJ8HRX4Ulrf61ZT2IbQ69HDJs119P
 vjn6oQ1fjkoFmY4VL2o3Vwh64uEk2r3kx4kyeBdbhQ0Y2iPrioPYyJuZxaseySNGWr8m
 aUbA==
X-Gm-Message-State: AJcUukc/U+s9KTRTrOAX4zmIocrNhr/F1Eh7N+yv0ul9lct2ZaM6wMNC
 JCnQ5RTWerOi4fIIz7hOQUNEZZ0pn8robPA1Vf0=
X-Google-Smtp-Source: ALg8bN6JPkj8zPGL+hDj+gDB3JHRHqo/RX+LTAF3UuPg3qMzOmh0lPVUEdKMDE3ucPx79EAzbbYqPlAWArizfACxGeg=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr4884682otf.124.1547071394509; 
 Wed, 09 Jan 2019 14:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20190109172336.GA1711@lenoch>
In-Reply-To: <20190109172336.GA1711@lenoch>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Jan 2019 23:03:02 +0100
Message-ID: <CAJZ5v0iZRUaAb-eiodgByZiEAe8AWxk9G2p8zHK45J-LuXgaAA@mail.gmail.com>
Subject: Re: [PATCH] PM/runtime: Fix 'jiffies' in comments after move to
 hrtimers
To: Ladislav Michl <ladis@linux-mips.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_140315_903464_0163834A 
X-CRM114-Status: GOOD (  17.71  )
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
 Linux PM <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 9, 2019 at 6:23 PM Ladislav Michl <ladis@linux-mips.org> wrote:
>
> PM-runtime now uses the hrtimers infrastructure for autosuspend, however
> comments still reference 'jiffies'.
>
> Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  drivers/base/power/runtime.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 70624695b6d5..096f7996d914 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -121,7 +121,7 @@ static void pm_runtime_cancel_pending(struct device *dev)
>   * Compute the autosuspend-delay expiration time based on the device's
>   * power.last_busy time.  If the delay has already expired or is disabled
>   * (negative) or the power.use_autosuspend flag isn't set, return 0.
> - * Otherwise return the expiration time in jiffies (adjusted to be nonzero).
> + * Otherwise return the expiration time in nanoseconds (adjusted to be nonzero).
>   *
>   * This function may be called either with or without dev->power.lock held.
>   * Either way it can be racy, since power.last_busy may be updated at any time.
> @@ -905,7 +905,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
>         spin_lock_irqsave(&dev->power.lock, flags);
>
>         expires = dev->power.timer_expires;
> -       /* If 'expire' is after 'jiffies' we've been called too early. */
> +       /* If 'timer_expires' after 'now' we've been called too early. */

I would say "If 'expires' is after the current time, we've been called
to early" here.

>         if (expires > 0 && expires < ktime_to_ns(ktime_get())) {
>                 dev->power.timer_expires = 0;
>                 rpm_suspend(dev, dev->power.timer_autosuspends ?
> --
> 2.20.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
