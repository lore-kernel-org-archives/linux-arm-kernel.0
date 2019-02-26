Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D92EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:41:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B848218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LPBfCsvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B848218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dw586Y3f/lHplmiJWnwVv4NRjScVXIwJWBUjaOedz28=; b=LPBfCsvYp+cv3L
	Ei9gyFJ9awJW4KxjHUF2irZn30vuSg4+ld2DtXtgytF8oaKCjjfRJ19vE+wPd7vntGXul0SZN8ttR
	jrXwwIi6PBamsHJJlvADFxokoCWkEjDCFGeX1eWkYpXY0OFpxSnV0yarQnuktyfN5dJnGkYW0NImP
	5zU+tggRkwa22nUJHIkPJcbkkZPTYtM/JAtfbumzjoF5s0t/5zSFejJvsnONQLMnLFt7vwtUJlmAc
	bx4bez0BI7AMI2SrocmGGFLqzQVylmKj7xonxtCgQDtpveAE2n6cred/97B4HjS0IkGyurnVl6a+u
	CPEeKdR7MEUJ2tMsXMUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gymLV-0002IH-FM; Tue, 26 Feb 2019 23:41:09 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gymLS-0002Hr-Fc
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 23:41:07 +0000
Received: by mail-oi1-f196.google.com with SMTP id i8so11909907oib.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 15:41:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=epJM6HtzQ2OfC7XTiRTHdv/WmhwMHpOkziIIKw/BBW8=;
 b=rEHSfAGUx7iKAI+EN5xzlld48rZ1S7PqtvSflGtl9ZU3kkT0fjni9GrlEK44Wvm+Sw
 lM7UXD3ZGr9jH16HnKlFg0yGdPHjtA9oM56j2TQ1fIoGlt+3UrrtWEzo2WTAvf0o7Ech
 dbYLxpUQnvDT0RyFXzSnTNdrcD9LHhRLfEwGCUSGtEFOEFSssolc9UUViGqcN8l43N+X
 HwkPR6yT0Jb4RMhlK/3edhlhIFFTj7LzhvuTShpHzPKaVVRH30FqpovQqnW2G39x42Ho
 VvWl3b7cH5pb9sm4fj+MIKQqJuD1BmX4wwFLMokqbhnNh0S9S/lmzsyWvp9R+r7agxnk
 YxfQ==
X-Gm-Message-State: AHQUAuYSVBYxraD/07Hu+upyheKmrBaM9hD6YNVdtMUq/ICPuDXey2tO
 G80B761jujvVeGooa0u5rOCy9pUw5KEAoYT0FpgHyza8
X-Google-Smtp-Source: AHgI3IbjPplUAm+aVWnmZI5/MQeCGYPCjW+5hu1qhcjl2DYuTYQwAA3fyJg5KHjdxJ/Q7i15gvFLTECKDuiSOMCgA/U=
X-Received: by 2002:aca:f4d3:: with SMTP id s202mr3998542oih.178.1551224465277; 
 Tue, 26 Feb 2019 15:41:05 -0800 (PST)
MIME-Version: 1.0
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
 <20190226145415.19411-8-ulf.hansson@linaro.org>
 <CAJZ5v0j=ddMEwvr8rt=PxxPpxoAHary7cYLYgTBbcuBuiGbTZA@mail.gmail.com>
 <CAPDyKFoFmnxWo7XhvAeB08xkDzSqUsmX_Zr=Zh6cmJWq=++0_Q@mail.gmail.com>
In-Reply-To: <CAPDyKFoFmnxWo7XhvAeB08xkDzSqUsmX_Zr=Zh6cmJWq=++0_Q@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Feb 2019 00:40:53 +0100
Message-ID: <CAJZ5v0hPiQe_mrPAAqRwTTdb-X4=-WQAdfC-peWb9zsc_wU5yw@mail.gmail.com>
Subject: Re: [PATCH v11 7/8] cpuidle: Pre-store next timer/tick before
 selecting an idle state
To: Ulf Hansson <ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_154106_516808_517E076A 
X-CRM114-Status: GOOD (  22.91  )
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
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Wed, Feb 27, 2019 at 12:16 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 26 Feb 2019 at 23:08, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Feb 26, 2019 at 3:54 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > A common piece of data used by cpuidle governors, is the information about
> > > when the next timer/tick is going to fire. Rather than having each governor
> > > calling tick_nohz_get_next_timer|hrtimer() separately, let's consolidate
> > > the code by calling these functions before invoking the ->select() callback
> > > of the governor - and store the output data in the struct cpuidle_device.
> >
> > That misses the point IMO.
> >
> > You don't need to store two values in struct cpuidle_device, but just
> > one, and not before running ->select(), but before invoking the
> > driver's ->enter() callback.
>
> Okay! Thanks for letting me know!
>
> >
> > At that point, the decision on whether or not to stop the scheduler
> > tick has been made already and it should be sufficient to store the
> > return value of tick_nohz_get_next_hrtimer() introduced by patch
> > [3/8], because that value represents the next timer regardless of what
> > has been decided with respect to the tick.
>
> Just to make sure I get this correctly, because it seems like I have
> missed a few points here....
>
> If we decided to keep the tick running, then
> tick_nohz_get_next_hrtimer() gives the next tick or the next hrtimer,
> whatever that comes first. There are no other timer that can expire
> earlier than this, right!?
>
> If we decided to stop the tick, then tick_nohz_get_next_hrtimer() will
> give us the next hrtimer. Again, then there are no other timer that
> can't expire earlier than this, right!?

Right in both cases.

IOW, that is the event that will wake up the CPU unless any other
(non-timer) interrupts (or equivalent events) occur in the meantime.

> >
> > And you won't need the tick_nohz_get_next_timer() any more then.
>
> Alright, this kind of brings this hole thing back closer to v10 - and
> then we should stick to use tick_nohz_get_sleep_length() as is for the
> cpuidle governors. That is what you are saying?

For the menu and teo governors - yes.  IMO
tick_nohz_get_sleep_length() is as good as it gets in there.

Cheers,
Rafael

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
