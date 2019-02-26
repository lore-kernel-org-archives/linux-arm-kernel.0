Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE52C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:16:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 661DF218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fHmm29w3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BJgTRYKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661DF218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1GXgDrk7Kk2kTJ8aXYEFvn16I8dsb61MVkGdRsFQKGI=; b=fHmm29w3ct5pgz
	Fo6MrRf16nfeXeSBCCposUPuiNqtcEsxoeyGA7jf2Xk3PT7iQP9HGx7xA0HY+hcvKcT1M/ej6kH/+
	5kYrOkOIJUEvQ9eRCaf1WO85vCODjzO7lPtILmNSV4JOFrwyNuHer6rpb5Xv27b64h5syzuHZxgNF
	jb5VKp3UpW9Yun4JfiBntMACqymlvjjJx27c+Czqa+iQUaVuCJ0desOXRZVj/o+Z/7ZdEQQrjH/4K
	AJ8RdgHMetRvE7CNAGztxixB6s8iUyND779KqVdKGhsprH0jMTB6ihVOVlfNVCPB3avhBrfga/RDP
	L7kfp0chTo1Zzyksv2gg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gylxe-0000Zs-Fq; Tue, 26 Feb 2019 23:16:30 +0000
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gylxa-0000ZS-AS
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 23:16:27 +0000
Received: by mail-ua1-x942.google.com with SMTP id g1so2728958uae.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 15:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=41Zrub4wVCT2G5PoRjJrsqTrwu869H7N7bztR4hcKg0=;
 b=BJgTRYKae0hazHS7A+jTV1eciLuFR/4pqeUdbnWljFo3HuMV04RmQy6NWsL2fap/tb
 HbWRib++4tUot+OW5VNSiMWISvpejsf6L5iTa5R5v2XW9h72VO2lkxOfh3nsn72Kkd3M
 7WfobJaM7IXwnGpFr1mbsyCKvgJO+M0ojE5NPKigSBEGjabmACUIIYvh3r89ONfd8D9c
 xGn5wCB02L8ZOpL/3UV46X4bHQlqayb3IiaUdrUiGzQHi4A+m+kPcl9CloaFZBEE/f/1
 LS5vm9htKPTtweH1Cqsxkosyk0Pd+oXaD4bPLron08K45cILgtfjjW25ZyrBDKwrPgp4
 aWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=41Zrub4wVCT2G5PoRjJrsqTrwu869H7N7bztR4hcKg0=;
 b=a+JHLXia54lhRckwNEtVfPDHaWQNaFPuwk/ZA3ZTyko/FG9wm7PONxOOEWlUGETtsU
 cOUhr/7eSVpD7aB7JA54IqxXuTLMc0RSyZUpZ44fsg9zoM9nduQFbYg699lt1uRJtYkJ
 TTwmXpfxKeGQjEz0Jp6baDrEUo61DAGWIrBzVyYkUZGVwA3NvbXm9z0C0lMYegX5m9m0
 HFvaajHvwXXUHG5ZIrikTaseFSARXfZRGfmUJqcoFa99f3/Phn0isd2yj7cVAaiGhc46
 2w+Am4xU6J1L84EOXah/gSGNQi7FbZwH4pNm5y7DbzarI5Cd7IfCLqYiQtq85F9PflDn
 4eiw==
X-Gm-Message-State: AHQUAubGSnYrcfyJ2TIb7BxpET7Q0BldKp+pAyy4wr2mzRbkO5Wbsx+s
 1BArFENW+frgeIHxLk+HbM54opqgQLCmb4kMzmzjEw==
X-Google-Smtp-Source: AHgI3Ib3BonZnsqURTfnizR+OnA7jsVz4uaePaJyJHnVGM39c7hyRdd1BPvj5mDyKs8J1Npu8e/W8s3Iemj9XwkliUA=
X-Received: by 2002:a67:8055:: with SMTP id b82mr172508vsd.200.1551222984686; 
 Tue, 26 Feb 2019 15:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
 <20190226145415.19411-8-ulf.hansson@linaro.org>
 <CAJZ5v0j=ddMEwvr8rt=PxxPpxoAHary7cYLYgTBbcuBuiGbTZA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j=ddMEwvr8rt=PxxPpxoAHary7cYLYgTBbcuBuiGbTZA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 27 Feb 2019 00:15:48 +0100
Message-ID: <CAPDyKFoFmnxWo7XhvAeB08xkDzSqUsmX_Zr=Zh6cmJWq=++0_Q@mail.gmail.com>
Subject: Re: [PATCH v11 7/8] cpuidle: Pre-store next timer/tick before
 selecting an idle state
To: "Rafael J. Wysocki" <rafael@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_151626_365764_15837E6B 
X-CRM114-Status: GOOD (  17.79  )
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

On Tue, 26 Feb 2019 at 23:08, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Feb 26, 2019 at 3:54 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > A common piece of data used by cpuidle governors, is the information about
> > when the next timer/tick is going to fire. Rather than having each governor
> > calling tick_nohz_get_next_timer|hrtimer() separately, let's consolidate
> > the code by calling these functions before invoking the ->select() callback
> > of the governor - and store the output data in the struct cpuidle_device.
>
> That misses the point IMO.
>
> You don't need to store two values in struct cpuidle_device, but just
> one, and not before running ->select(), but before invoking the
> driver's ->enter() callback.

Okay! Thanks for letting me know!

>
> At that point, the decision on whether or not to stop the scheduler
> tick has been made already and it should be sufficient to store the
> return value of tick_nohz_get_next_hrtimer() introduced by patch
> [3/8], because that value represents the next timer regardless of what
> has been decided with respect to the tick.

Just to make sure I get this correctly, because it seems like I have
missed a few points here....

If we decided to keep the tick running, then
tick_nohz_get_next_hrtimer() gives the next tick or the next hrtimer,
whatever that comes first. There are no other timer that can expire
earlier than this, right!?

If we decided to stop the tick, then tick_nohz_get_next_hrtimer() will
give us the next hrtimer. Again, then there are no other timer that
can't expire earlier than this, right!?

>
> And you won't need the tick_nohz_get_next_timer() any more then.

Alright, this kind of brings this hole thing back closer to v10 - and
then we should stick to use tick_nohz_get_sleep_length() as is for the
cpuidle governors. That is what you are saying?

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
