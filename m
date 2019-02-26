Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A83C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:06:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F6C20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bmyhDRD2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQskpJUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F6C20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u1SxGLTnHNuUQJrRQMNBxuRM0GGQkDpKpcdWp3+6Z60=; b=bmyhDRD2FfItnw
	eWB7odOM4xDAqt1V9XLMp/2yz0l0bGlDO0hediOWeXc3s3/eCFT/FpLvauQyDDdRy9hNwjhiYEwrE
	+HPsP+2/RfE040aI3+yJcp59U6m4F8H67F135F+BFJu0uT0XmYa+a2nVAL+GLRRJJjRsf7GgE8O9S
	rGFktwoN/lNhv8cwAXUsmo1vrKV7kbruNcmXs5EceHrsJFmirPPMOlyqShu+FbQs0KKhQKv1BqU82
	MI1Jpv2IRinDPFhcXwWPbtSzvb4zjL15Mo7d730PKyIuUHgyXDME9SrGWSZteyEonAOM1foEfs7Rq
	SCJU4dU2udURPWSBbfxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyksG-0001b0-I0; Tue, 26 Feb 2019 22:06:52 +0000
Received: from mail-vk1-xa41.google.com ([2607:f8b0:4864:20::a41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyksB-0001a2-DR
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 22:06:49 +0000
Received: by mail-vk1-xa41.google.com with SMTP id b6so3372962vkf.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 14:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TOoMc+RHFWBGA09XwS2pL1BaJP8tf8CR+s4qdrY5Ne4=;
 b=AQskpJUtFcL/F3Z8L1NY+K5hk3qkO5snkL/6VsIrShZ2S6jIyaRlPXMHa0C3Qdk73v
 U0WjqyMOSOdti80l55nrghwh+N8wZf7+OYIM7KKU/c54Ft/BO+dEDpVhV/1a0S+qKUzh
 kMihLf6BCsURqM9c8hARJlinTq2AmjoETe4UmKwOTqUKdHLGOGFjoqdcSzrneRwkXynr
 o35HU9KafsHnLskU8L4gPVKd7IKl/vb0VaEGgIgDtdexIvZofiF1ahsvrrFdUQ99suwb
 4+GyMAgeIVM/w98kz7XiydJaeuD80kNtlhazPL6tX/UBeFHnKfx8WcMOqEsZurZKe83a
 mWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TOoMc+RHFWBGA09XwS2pL1BaJP8tf8CR+s4qdrY5Ne4=;
 b=CAGJx89FylpNmCmUv4pWcSN0EomyfWaQODaqbTPjM/0Np+wmz71aZX62nsKcBIVFK5
 A1T1nlEqoDrztMsboviEAlyJeyLVDF5lHptie8RnBlpKlzd3jkzSZ0t8P4kAvTA2lKOv
 J1RSX2L67MOcTbBzBg54golG0HPAIMWy/q+IhEtvO3Ax0PAaHJ6poHVQV33pct78dVLK
 +aWOW5+8go+cxzp6Qafds730CWoNoaTyH7ef28kwfUhhPJ9HsQfhIt6XjrW8WOi5rc23
 jMYmuMbeXjpshbZUH0VIJbWK+YHA5jWgMtp7dk6DKwiYEKrI8Q1jRWt5vg796/AZmRYH
 ramA==
X-Gm-Message-State: AHQUAub6O/H3xlz1La3pRAAbVovvDvmcR7CaNYgUjRXKlASBKLQrTbBQ
 m+F3ooOj8nCecQUzRfoB4fbC4n9kRJ18/2wMY5KI/w==
X-Google-Smtp-Source: AHgI3IYEbprrKCKEqqJhs+OdwQp0CJViKLaDWPwMuL1W9FrZ2wLSedF5zlj3LCmYJAKdJuWcKx2PEw9JQszmk4i0Cg8=
X-Received: by 2002:a1f:3253:: with SMTP id y80mr2825850vky.17.1551218805888; 
 Tue, 26 Feb 2019 14:06:45 -0800 (PST)
MIME-Version: 1.0
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
 <CAJZ5v0jiUWsYeQm8xoGf=WpM+yWdnPnkGK0+amPb=3PUE+APfg@mail.gmail.com>
 <CAPDyKFonaODSwNLTOxx=94S2ZNPy5VT07b+niJag0RH=QDatpw@mail.gmail.com>
 <CAJZ5v0gHZ5OiMGxpagp5X-LfShc_3AX=fgBPxf=PQ9p4cMQV8Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0gHZ5OiMGxpagp5X-LfShc_3AX=fgBPxf=PQ9p4cMQV8Q@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 26 Feb 2019 23:06:10 +0100
Message-ID: <CAPDyKFoxEA09ZKAb=zu_xO13Li-6=ipnxcJDe1B9PWyxKsUxcQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To: "Rafael J. Wysocki" <rafael@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_140647_592352_4C1DDD42 
X-CRM114-Status: GOOD (  29.69  )
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

On Tue, 26 Feb 2019 at 22:52, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Feb 26, 2019 at 10:31 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 26 Feb 2019 at 18:50, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Tue, Feb 26, 2019 at 3:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > Changes in v11:
> > > >  - This version contains only the infrastructure changes that is needed for
> > > > deployment. The PSCI/ARM changes have also been updated and tested, but I will
> > > > post them separately. Still, to provide completeness, I have published a branch
> > > > containing everything to a git tree [1], feel free to have a look and test.
> > > >  - The v10 series contained a patch, "timer: Export next wakeup time of a CPU",
> > > > which has been replaced by a couple of new patches, whom reworks the existing
> > > > tick_nohz_get_sleep_length() function, to provide the next timer expiration
> > > > instead of the duration.
> > > >  - More changelogs are available per patch.
> > >
> > > NAK for patches [4-6/8].
> > >
> > > The code as is specifically avoids calling ktime_get() from the
> > > governors as that can be quite expensive, so these patches potentially
> > > make things worse.
> >
> > Yeah, good point! What do you think about folding in a patch into the
> > series, like below, and then let the cpuidle governors use it?
>
> It is not objectionable as it stands, but that also depends on what
> the new function is used for.
>
> In particular, I don't really think that the menu and teo governors
> need to call it at all.

Well, if we are going to re-work the code as suggested in the series,
then how would you suggest to get rid of the calls to ktime_get() that
is introduced in patch 4 and patch5?

BTW, at a closer look I am even tempted to squash patch3 to patch6
(including the part I attached earlier) as this part of the series is
really a re-work of tick_nohz_get_sleep_length() and its users.

>
> > One questions about when CONFIG_NO_HZ_COMMON is unset for the below
> > suggested code, does it make sense to "return -1" for that case, or
> > should I return ktime_get()? Does it matter?
>
> Again, it may or may not matter depending on what the caller is going
> to do with the value returned by it.

Well, so far this is only for teo/menu - instead of calling ktime_get().

Any other suggestions of how to move forward here is welcome, of course!

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
