Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3C1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:08:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F67218D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pZ1eb9bq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldoOAqeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F67218D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QBVVJCtCCYImyTgml3W7tFZON8EfiTptdxff96C36ic=; b=pZ1eb9bq5VLf25
	DUd0UPnX2UtCYH50HWTNDI1nZVgQRVHnkqchkXa/Yf4DpvuXUFFTYxaeVZFGqe8gy/9GlqMUsXT69
	BowkTxQxtx4zj7C4+ALjBcppbifNB5ckhDnP06G4MlV+z/xws76Hrk7FeXr13t9qJ4pMf+8s9DIVi
	lqyVz9Tkh3BiqPX4NKyh+BKxxqg7qWA+8n7iojBPWj/XQgnR9qePyMBmk1XwEKQ4AtCJp9aElXCDN
	WFhAl13oUOEkJKhhbq548KDxmgQZ29QMYVOqPtuwAPZJj5+SO+laJOGRfPhxQIStAdv+8Y4LgKb65
	3+9tr2pRLI2FTLKa6COQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gymlp-0002w0-0H; Wed, 27 Feb 2019 00:08:21 +0000
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gymll-0002vX-UE
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 00:08:19 +0000
Received: by mail-vk1-xa43.google.com with SMTP id w85so1550246vkw.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 16:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Gz3WVXcko/jr6moLk0tMcJhOoECoPiEwbK1uAm8C2Zo=;
 b=ldoOAqehLlnSNgnMYgeoEwFp27pfYgtCTMiITBb/lBj1YzL+HQnTYCsIHolI4oX3PU
 RyPCzVjmXf5WTFimQ6ljY9WbGj3JckKPEJAd2B+lYZjd9iuUaf+td+Z2jNnnLj71hhKW
 Gjk+mMSIsH1TxBuU3pmGSqSi1vRi2jw1SRX6DzUordijgNglRZRFIivSW5v1tpEyTZkc
 Uaqud3XjeP8fxSeomcCQzdw9o3OHU02jKW3+I5AwWlwjQD6u0q4M1m0lHZM9lrlzrLbz
 6nxyvxlEl2X1eLPgoiADAn9zegFXCbFebXPIQXDjlpPnmgaiRnr7aYZ4LX24zn0am4XJ
 3VHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Gz3WVXcko/jr6moLk0tMcJhOoECoPiEwbK1uAm8C2Zo=;
 b=UB0mzhPB0sRXfRYnhBDPYBwgsqQAdlARNJdh1h9sZw+sRTwZTRq5S+0ywzNkdWHxYv
 dUS3xqCa3tUFT1oME4mJnOl/QWtmF/yTKuABqx3rPZqK/SQ/NlviwURK9I9elyq9kZa1
 9ro36VRXscyP3Sy8J1KxyUtbSU/cVmQv5wCNnwQBl1oiO/8ex5RaGDh9aG9UvZtla+mo
 jPTAXDxWbWPaX3e+4wOAafW5H956RVz7YVnWiGBLoe2s6GeqDFAn7RXkNKOJGrnfkTLy
 qQHO6ZuvSSlinaHM1RJOz2rWc3qVcAdeKr6Hnn2nqULGLcdfDdzcsrZOJNTadsgqXUap
 GnVQ==
X-Gm-Message-State: AHQUAua3IC80mFNF7WW31xQIDPJ9BGv7fJLP1fLLJVOfPUBalAcnWLp/
 PlbAT9wGszrty2RgQdLI6afAMesVdBUlatVfGrqF3A==
X-Google-Smtp-Source: AHgI3IaZ1ZQDjqhvFCY5BBaJBaJrJlVI7mH5lxh93eMSGYrakuI6TVdwSw2x/2qO5nrS1dCi4PDdIZdPX09KVwAjvm0=
X-Received: by 2002:a1f:3253:: with SMTP id y80mr3077923vky.17.1551226095107; 
 Tue, 26 Feb 2019 16:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
 <20190226145415.19411-8-ulf.hansson@linaro.org>
 <CAJZ5v0j=ddMEwvr8rt=PxxPpxoAHary7cYLYgTBbcuBuiGbTZA@mail.gmail.com>
 <CAPDyKFoFmnxWo7XhvAeB08xkDzSqUsmX_Zr=Zh6cmJWq=++0_Q@mail.gmail.com>
 <CAJZ5v0hPiQe_mrPAAqRwTTdb-X4=-WQAdfC-peWb9zsc_wU5yw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hPiQe_mrPAAqRwTTdb-X4=-WQAdfC-peWb9zsc_wU5yw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 27 Feb 2019 01:07:39 +0100
Message-ID: <CAPDyKFoNJhfxMEa+HpjupUWaT3-JQ2dUgy6iBwqjxFergUzPaw@mail.gmail.com>
Subject: Re: [PATCH v11 7/8] cpuidle: Pre-store next timer/tick before
 selecting an idle state
To: "Rafael J. Wysocki" <rafael@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_160818_067295_7B77DC69 
X-CRM114-Status: GOOD (  24.53  )
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

On Wed, 27 Feb 2019 at 00:41, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Feb 27, 2019 at 12:16 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 26 Feb 2019 at 23:08, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Tue, Feb 26, 2019 at 3:54 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > A common piece of data used by cpuidle governors, is the information about
> > > > when the next timer/tick is going to fire. Rather than having each governor
> > > > calling tick_nohz_get_next_timer|hrtimer() separately, let's consolidate
> > > > the code by calling these functions before invoking the ->select() callback
> > > > of the governor - and store the output data in the struct cpuidle_device.
> > >
> > > That misses the point IMO.
> > >
> > > You don't need to store two values in struct cpuidle_device, but just
> > > one, and not before running ->select(), but before invoking the
> > > driver's ->enter() callback.
> >
> > Okay! Thanks for letting me know!
> >
> > >
> > > At that point, the decision on whether or not to stop the scheduler
> > > tick has been made already and it should be sufficient to store the
> > > return value of tick_nohz_get_next_hrtimer() introduced by patch
> > > [3/8], because that value represents the next timer regardless of what
> > > has been decided with respect to the tick.
> >
> > Just to make sure I get this correctly, because it seems like I have
> > missed a few points here....
> >
> > If we decided to keep the tick running, then
> > tick_nohz_get_next_hrtimer() gives the next tick or the next hrtimer,
> > whatever that comes first. There are no other timer that can expire
> > earlier than this, right!?
> >
> > If we decided to stop the tick, then tick_nohz_get_next_hrtimer() will
> > give us the next hrtimer. Again, then there are no other timer that
> > can't expire earlier than this, right!?
>
> Right in both cases.
>
> IOW, that is the event that will wake up the CPU unless any other
> (non-timer) interrupts (or equivalent events) occur in the meantime.
>
> > >
> > > And you won't need the tick_nohz_get_next_timer() any more then.
> >
> > Alright, this kind of brings this hole thing back closer to v10 - and
> > then we should stick to use tick_nohz_get_sleep_length() as is for the
> > cpuidle governors. That is what you are saying?
>
> For the menu and teo governors - yes.  IMO
> tick_nohz_get_sleep_length() is as good as it gets in there.

Okay, got it! Thanks for your helpful answers!

I will post a v12 as soon as I can, so we can look into the other
parts of the series.

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
