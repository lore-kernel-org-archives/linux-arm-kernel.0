Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C98FC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:57:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E10E3213F2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FCkpzS1P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANgcHEZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10E3213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ELGPcsaJa/GxOJ5DO+Ob2mnLku11Ku1mAoqyYOlz5WE=; b=FCkpzS1PkqAoUc
	m1pMLv9ArOrG+k/2k8iMIOjAUDSWDbtfnM0qy62Uewu1wvGRbxdAsiSZBCrkvRQTJL04s7/Ro99Q3
	+B6fszWJrMTmZ9c9ykdWUGIjVIwkli4+0jK1nhEobDgvSwSO+gYtcnlkOUA6TWgJI4gq0QI++Ea4p
	cuCdxG5mWPO7iXOxqUUmKj3uA88lsVTcac30eLqNC+oSfUyxSIT8V8xfwc/IuKHmk8s668IhhJ1UN
	K4xAO/mjRqnxzAVhL65NcNmqq9CPV8IE7hnqOBE5xfMeEBsivvbUWG7aMfaDQDNAsJ6ZH7ZgKnorL
	Jhq/C8QmUh6foVjXB4Yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghfWS-0000D3-9T; Thu, 10 Jan 2019 18:57:44 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghfWP-0000CP-C6
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 18:57:42 +0000
Received: by mail-it1-x144.google.com with SMTP id h65so154054ith.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 10:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZCHJ/TvwzF0ThhfFXbmNmVm1YbERtS5kXlpqZlpNyCE=;
 b=ANgcHEZBrNT721hW/GfEtszNfqcPceiM7DNUXGU4oJSlRB07TDvf/Kpfh73ZKQhL1T
 G9x8WXvL6aE8V50fP8oNmTHGJkusCsd4/ZnP6ebKgst8p4+5ubeHl4KjcPnb5ASpe16e
 iB72cAOUnZnrImrSIdq/Q5T5lcQMzw5ZDuc+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZCHJ/TvwzF0ThhfFXbmNmVm1YbERtS5kXlpqZlpNyCE=;
 b=QlSOGn9Amfz2ku3S0eRYhVC89nDeoFgNxuH0n76aCkOhQmiu2kIuvIwysHfrMENN09
 PN348faOLNRdOXknpmfoPs4GDJnCL0x3xlvm7NKARo5u89t/gF63kLrUSLm1oGBn1YKL
 36RO4kwzNo3el8/77Et1v0udclraGB23DmL+RzBmIL0o9DiAvjL4aMmxr6Kbol9rGtFE
 WhrlQoFKlR6M+HShlDGyvTyvPtPRxLKI/VekqVng9b0s0zmw6jAMtEpa9Br1cGDeuUDB
 pMl+O1CE1tq5vYuaJYZ9yldC8ZM9Ygj9IBhb2AzxGeIojB72ylztMkyJC3dpuQQCDwN/
 92qA==
X-Gm-Message-State: AJcUukeXW+xvps1TtVXT3JAZVU3fdIWeVqPE6uT9JV1jl4xrzwlIs/xn
 XAbLO/ZN1imk7Ot1LK5+5jeRildEAipaChYfwgRXrA==
X-Google-Smtp-Source: ALg8bN70O57ml7NqAXy6P5IzR/pHoeiIXe9+fryzWmoJz5X7s8TIF7WOBc8aLAGBHlFW8b/qQG+RtRwhvL1jY5rvxBo=
X-Received: by 2002:a24:6f42:: with SMTP id x63mr24331itb.152.1547146660173;
 Thu, 10 Jan 2019 10:57:40 -0800 (PST)
MIME-Version: 1.0
References: <20190109172336.GA1711@lenoch>
 <CAJZ5v0iZRUaAb-eiodgByZiEAe8AWxk9G2p8zHK45J-LuXgaAA@mail.gmail.com>
 <20190109231944.GA21177@lenoch>
In-Reply-To: <20190109231944.GA21177@lenoch>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 10 Jan 2019 19:57:29 +0100
Message-ID: <CAKfTPtAEu9ApVquRQbcobxOYMc3OEPF3cFUEHOtcrr=nEBXhQg@mail.gmail.com>
Subject: Re: [PATCH v2] PM/runtime: Fix 'jiffies' in comments after move to
 hrtimers
To: Ladislav Michl <ladis@linux-mips.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_105741_415343_E1CF26D5 
X-CRM114-Status: GOOD (  17.48  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linux PM <linux-pm@vger.kernel.org>,
 Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 10 Jan 2019 at 00:19, Ladislav Michl <ladis@linux-mips.org> wrote:
>
> PM-runtime now uses the hrtimers infrastructure for autosuspend, however
> comments still reference 'jiffies'.
>
> Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  Changes:
>  -v2: Reword comment accoring to Rafael's suggestion
>
>  drivers/base/power/runtime.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 70624695b6d5..a282e74d1a16 100644
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
> @@ -905,7 +905,10 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
>         spin_lock_irqsave(&dev->power.lock, flags);
>
>         expires = dev->power.timer_expires;
> -       /* If 'expire' is after 'jiffies' we've been called too early. */
> +       /*
> +        * If 'expires' is after the current time, we've been called
> +        * too early.
> +        */
>         if (expires > 0 && expires < ktime_to_ns(ktime_get())) {
>                 dev->power.timer_expires = 0;
>                 rpm_suspend(dev, dev->power.timer_autosuspends ?
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
