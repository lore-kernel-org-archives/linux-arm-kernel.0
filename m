Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9B5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:53:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E28C21873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dnCmnKq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E28C21873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2wK9oCTVPLqHNW2R9SI3Jcj54DOTcgdNr8h8LoHNsrE=; b=dnCmnKq1k6Ckcf
	gI/mj2CSJ7tqHYyZSt8AWCfOqq5dTINvMXi7bfK2Dr2zPMFVmROVXqjtRuZI0aKj5Cn10UxF5Afbu
	LhAaXfHrwaIAvjqz7RVum9lbssZvwaCmvJT9E2i/Z7r2iz8v6cvQXdvlgpLxVnjVRm6Cr7WvLMiAs
	0/4lnfiVkrBRPhnFBL8ln6eKd5vQjRmHe01sDivZlb2EmMOCacw4t9V0cpDQHXEqHAS9kHqHouPrL
	g0mPQ1dKjtYIISnvYWhPrMdiiETs/9lOf6XB+0q4m9A4y06w6MjsCg5vZ4py6FZ7MYDzaV90wii2A
	wrf5qs3qcauTc3bwPwSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gykei-0003gm-J8; Tue, 26 Feb 2019 21:52:52 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gykee-0003eS-EX
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 21:52:49 +0000
Received: by mail-oi1-f194.google.com with SMTP id t206so11702177oib.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 13:52:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aZ0vdhu4OSNTZ1Xtlcnd8Gwn2tIT2qEa6s/zqooA5GM=;
 b=HG2KmU2CYFwwsnGkP2WLklvQtoK3flb/pIKi3CUTGRC5vhvatI/YKb1PeS6Q6D/CEa
 YGVMgTMpV1TJOdwdKsnVw9n2IazobvSPMUIL2FKFm5wD6olzqlkMvBSKNagXiCA0B3v1
 VYPcCmptTIsGtdMPgOGBkLfVZPSMDYrnpR9eDG9b6jgiarHXrypQTS0NlDb7fj5Oo80r
 ZN/zFmE0D6QbNOKLEYReYrgpT2+d1FXbyyI8j/7VDr+gAn66UHv38sse5vm/xMGUXMVP
 wYgEfXqmVOurOVPI8sarBayliE7RaI5rmzHDI8Oca16f09W8ZpK5CHGzr96wVSN/MvoX
 M/4Q==
X-Gm-Message-State: AHQUAua/9dg3nD/09Qrg0KQVmwMVa0SgiSIWSKMQ3kLqCYg2ijpHnGR2
 E4rDGUMi9Bi9egjaHJNR8VfSaW4tTdE302VTSUU=
X-Google-Smtp-Source: AHgI3IaJrQUjRbYVqGFNCg9Dq/B3y0Q8h/eDz7MRzU2Cxsecmz9TxiJUSZiWOhnsVKSoJnQ+KkI+zgqnnjAi++41/qo=
X-Received: by 2002:aca:88b:: with SMTP id 133mr3822130oii.95.1551217967444;
 Tue, 26 Feb 2019 13:52:47 -0800 (PST)
MIME-Version: 1.0
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
 <CAJZ5v0jiUWsYeQm8xoGf=WpM+yWdnPnkGK0+amPb=3PUE+APfg@mail.gmail.com>
 <CAPDyKFonaODSwNLTOxx=94S2ZNPy5VT07b+niJag0RH=QDatpw@mail.gmail.com>
In-Reply-To: <CAPDyKFonaODSwNLTOxx=94S2ZNPy5VT07b+niJag0RH=QDatpw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 Feb 2019 22:52:35 +0100
Message-ID: <CAJZ5v0gHZ5OiMGxpagp5X-LfShc_3AX=fgBPxf=PQ9p4cMQV8Q@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To: Ulf Hansson <ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_135248_484786_AD515E17 
X-CRM114-Status: GOOD (  24.91  )
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

On Tue, Feb 26, 2019 at 10:31 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 26 Feb 2019 at 18:50, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Feb 26, 2019 at 3:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > Changes in v11:
> > >  - This version contains only the infrastructure changes that is needed for
> > > deployment. The PSCI/ARM changes have also been updated and tested, but I will
> > > post them separately. Still, to provide completeness, I have published a branch
> > > containing everything to a git tree [1], feel free to have a look and test.
> > >  - The v10 series contained a patch, "timer: Export next wakeup time of a CPU",
> > > which has been replaced by a couple of new patches, whom reworks the existing
> > > tick_nohz_get_sleep_length() function, to provide the next timer expiration
> > > instead of the duration.
> > >  - More changelogs are available per patch.
> >
> > NAK for patches [4-6/8].
> >
> > The code as is specifically avoids calling ktime_get() from the
> > governors as that can be quite expensive, so these patches potentially
> > make things worse.
>
> Yeah, good point! What do you think about folding in a patch into the
> series, like below, and then let the cpuidle governors use it?

It is not objectionable as it stands, but that also depends on what
the new function is used for.

In particular, I don't really think that the menu and teo governors
need to call it at all.

> One questions about when CONFIG_NO_HZ_COMMON is unset for the below
> suggested code, does it make sense to "return -1" for that case, or
> should I return ktime_get()? Does it matter?

Again, it may or may not matter depending on what the caller is going
to do with the value returned by it.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
