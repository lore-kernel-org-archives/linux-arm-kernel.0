Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BD7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:11:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4498C218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b5glTeS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4498C218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KK2h4crwhBQIpq/h9CnqAGQ0p0EiyKIDGn4d7Lcv6JU=; b=b5glTeS+pXqZEJ
	lYZthgKaMIh0POIXTcK9TT/4luE7zT2ZZLtD8AmKAsRRtn5pI6hc9E0iKohc/pbC8N9XvtbiHTF4H
	JaZvJSjnNeVB1P/KyiGrgllXFWdGWajWVI+uXrBOYkHSPlvarO85Lv2BKK5n1DbWGNnIZC2AN6BEQ
	TaD7zy6snnd052bbaQ8d1bcgVC/Y+gLZr+F4JIKR8PdSegxdqR+3tMZ+G/MJ1VQS2kSIg0Oht01sn
	Zh/Q71l1q4ofIEURZ8+Nb+d8DH6hA5oSbJxMeUb73z+BHyx6Wym+zlL4OWxI9UyzgUIFjeHyitVan
	xgS2sCGWPSXn7JIQozHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gykwq-0003dW-Jg; Tue, 26 Feb 2019 22:11:36 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gykwm-0003ct-SZ
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 22:11:34 +0000
Received: by mail-oi1-f193.google.com with SMTP id b4so11751807oif.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 14:11:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IINA/hllyo9vqhgF5Pi1jx3T2WsGGNckh4bq0dzFHBk=;
 b=qoE0miw1iNAxDWOE/tpeJ88lpSlJQVvHe84PIoWQ0lSbrhm6m3iZUrvIoDpEiABbEz
 28o1DcPSHRNqcQZCT8qZxcLSmPL6fp1JpxpT9lz58G4xPDgYDu9ShT0dGCJhrOw87sdH
 OGP+nsJG7P5yL1aUYRp7X4YtsKU5Znltjq25ZBG8VSM0AajlKkedNJs7i39FdbnN3d8B
 g1BvszZFPKYAIpm6ma8Y5cv72Dq2qe6mQHpRO+o+AEgcH0Sly9bvcZUtHVqY22DDzZA/
 a8hbZMc3HMq+TKMm3dx4pz1b8h/u0j8TV8W8qgP9JT6Hks7FaZnYODYa8o7XG1spapDc
 B2zA==
X-Gm-Message-State: AHQUAua7ODGlq7RE5uTC58fytwkCTSrgUBYftqma1Rg1UWUEJgcHvuzZ
 fe/XLqcIPg9r7hfllx5iH9hlZAEXr8pzsJr5Ovc=
X-Google-Smtp-Source: AHgI3IbRu8kzwyq5aDQt9KLm/BVxZmnu2I7fpqBnPUufdesoi+hhHEsOC7GjJiz9bo01KD3iAi/EyJay9K1ghwnDUlE=
X-Received: by 2002:aca:88b:: with SMTP id 133mr3868685oii.95.1551219091906;
 Tue, 26 Feb 2019 14:11:31 -0800 (PST)
MIME-Version: 1.0
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
 <CAJZ5v0jiUWsYeQm8xoGf=WpM+yWdnPnkGK0+amPb=3PUE+APfg@mail.gmail.com>
 <CAPDyKFonaODSwNLTOxx=94S2ZNPy5VT07b+niJag0RH=QDatpw@mail.gmail.com>
 <CAJZ5v0gHZ5OiMGxpagp5X-LfShc_3AX=fgBPxf=PQ9p4cMQV8Q@mail.gmail.com>
 <CAPDyKFoxEA09ZKAb=zu_xO13Li-6=ipnxcJDe1B9PWyxKsUxcQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoxEA09ZKAb=zu_xO13Li-6=ipnxcJDe1B9PWyxKsUxcQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 Feb 2019 23:11:20 +0100
Message-ID: <CAJZ5v0g8Do3v_+0EE1W=8LCi6RsXc5s1HaRUXSbr6mXFPsFKVg@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To: Ulf Hansson <ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_141132_921993_FCB824C1 
X-CRM114-Status: GOOD (  27.76  )
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

On Tue, Feb 26, 2019 at 11:06 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 26 Feb 2019 at 22:52, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Feb 26, 2019 at 10:31 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Tue, 26 Feb 2019 at 18:50, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Tue, Feb 26, 2019 at 3:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > Changes in v11:
> > > > >  - This version contains only the infrastructure changes that is needed for
> > > > > deployment. The PSCI/ARM changes have also been updated and tested, but I will
> > > > > post them separately. Still, to provide completeness, I have published a branch
> > > > > containing everything to a git tree [1], feel free to have a look and test.
> > > > >  - The v10 series contained a patch, "timer: Export next wakeup time of a CPU",
> > > > > which has been replaced by a couple of new patches, whom reworks the existing
> > > > > tick_nohz_get_sleep_length() function, to provide the next timer expiration
> > > > > instead of the duration.
> > > > >  - More changelogs are available per patch.
> > > >
> > > > NAK for patches [4-6/8].
> > > >
> > > > The code as is specifically avoids calling ktime_get() from the
> > > > governors as that can be quite expensive, so these patches potentially
> > > > make things worse.
> > >
> > > Yeah, good point! What do you think about folding in a patch into the
> > > series, like below, and then let the cpuidle governors use it?
> >
> > It is not objectionable as it stands, but that also depends on what
> > the new function is used for.
> >
> > In particular, I don't really think that the menu and teo governors
> > need to call it at all.
>
> Well, if we are going to re-work the code as suggested in the series,
> then how would you suggest to get rid of the calls to ktime_get() that
> is introduced in patch 4 and patch5?
>
> BTW, at a closer look I am even tempted to squash patch3 to patch6
> (including the part I attached earlier) as this part of the series is
> really a re-work of tick_nohz_get_sleep_length() and its users.

Which is unnecessary IMO - see my reply to patch [7/8].

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
