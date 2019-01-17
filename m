Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7F7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:44:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D4B420652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f/YD2iwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4B420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N7xulH4dAMmMsSU0IM6kMTzhlfkXNtg6rQKEky6uiZM=; b=f/YD2iwEgjPG5m
	vJOfVxqqyZOBR0XPi0gUBzNjD77/4YYkewfVn7dJHF1J+r2PCXqbwlDoUrfwqgMnOxsQer4jRL/lc
	yknwDsWWr6+f+gtlJnhL3J0v6I9aLU1L+pMOrGkJGN6BtXZ6eJ6DLVUVDkgqhKERYW8Dz2bx8bEEr
	3dvdZjUJkZI+mJ1KOumklAuxBKSyLrZsdi46uBhF0xsNcPHSD3mdqPVVwKhyKagdg3vvKjtZVTkEW
	99yy9LDfHXQOs6SSBEtmW1YYqoI3dxAOyOlslVWDUzAgWgyrq2c3BhKBpYJBJN3x/uYTmV8c6QXVs
	ryFJfVXiVF2Emw4guxBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkBiO-0005DC-Oq; Thu, 17 Jan 2019 17:44:28 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkBiK-0005CU-CK
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 17:44:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACF8A80D;
 Thu, 17 Jan 2019 09:44:21 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB8053F557;
 Thu, 17 Jan 2019 09:44:18 -0800 (PST)
Date: Thu, 17 Jan 2019 17:44:10 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 00/27] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
Message-ID: <20190117174410.GA8839@e107155-lin>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20190103120612.GC23511@e107155-lin>
 <CAPDyKFp-JB85TZOs+oso0iidaAsm1A=UDrg=gv+QZ4VJ9gW=fA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPDyKFp-JB85TZOs+oso0iidaAsm1A=UDrg=gv+QZ4VJ9gW=fA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_094424_492049_7215D234 
X-CRM114-Status: GOOD (  36.82  )
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
 Viresh Kumar <viresh.kumar@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>,
 Lina Iyer <ilina@codeaurora.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tony Lindgren <tony@atomide.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 10:10:08AM +0100, Ulf Hansson wrote:
> On Thu, 3 Jan 2019 at 13:06, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Thu, Nov 29, 2018 at 06:46:33PM +0100, Ulf Hansson wrote:
> > > Over the years this series have been iterated and discussed at various Linux
> > > conferences and LKML. In this new v10, a quite significant amount of changes
> > > have been made to address comments from v8 and v9. A summary is available
> > > below, although let's start with a brand new clarification of the motivation
> > > behind this series.
> >
> > I would like to raise few points, not blockers as such but need to be
> > discussed and resolved before proceeding further.
> > 1. CPU Idle Retention states
> >         - How will be deal with flattening (which brings back the DT bindings,
> >           i.e. do we have all we need) ? Because today there are no users of
> >           this binding yet. I know we all agreed and added after LPC2017 but
> >           I am not convinced about flattening with only valid states.
>
> Not exactly sure I understand what you are concerned about here. When
> it comes to users of the new DT binding, I am converting two new
> platforms in this series to use of it.
>

Yes that's exactly my concern. So if someone updates DT(since it's part
of the kernel still), but don't update the firmware(for complexity reasons)
the end result on those platform is broken CPUIdle which is a regression/
feature break and that's what I am objecting here.

> Note, the flattened model is still a valid option to describe the CPU
> idle states after these changes. Especially when there are no last man
> standing activities to manage by Linux and no shared resource that
> need to prevent cluster idle states, when it's active.

Since OSI vs PC is discoverable, we shouldn't tie up with DT in anyway.

>
> >         - Will domain governor ensure not to enter deeper idles states based
> >           on its sub-domain states. E.g.: when CPUs are in retention, so
> >           called container/cluster domain can enter retention or below and not
> >           power off states.
>
> I have tried to point this out as a known limitation in genpd of the
> current series, possibly I have failed to communicate that clearly.
> Anyway, I fully agree that this needs to be addressed in a future
> step.
>

Sorry, I might have missed to read. The point is if we are sacrificing
few retention states with this new feature, I am sure PC would perform
better that OSI on platforms which has retention states. Another
reason for having comparison data or we should simply assume and state
clearly OSI may perform bad on such system until the support is added.

> Note that, this isn't a specific limitation to how idle states are
> selected for CPUs and CPU clusters by genpd, but is rather a
> limitation to any hierarchical PM domain topology managed by genpd
> that has multiple idle states.
>

Agreed, but with flattened mode we compile the list of valid states so
the limitation is automatically eliminated.

> Do note, I already started hacking on this and intend to post patches
> on top of this series, as these changes isn't needed for those two
> ARM64 platforms I have deployed support for.
>

Good to know.

> >         - Is the case of not calling cpu_pm_{enter,exit} handled now ?
>
> It is still called, so no changes in regards to that as apart of this series.
>

OK, so I assume for now we are not going to support retention states with OSI
for now ?

> When it comes to actually manage the "last man activities" as part of
> selecting an idle state of the cluster, that is going to be addressed
> on top as "optimizations".
>

OK

> In principle we should not need to call cpu_pm_enter|exit() in the
> idle path at all,

Not sure if we can do that. We need to notify things like PMU, FP, GIC
which have per cpu context too and not just "cluster" context.

> but rather only cpu_cluster_pm_enter|exit() when a cluster idle state is
> selected.

We need to avoid relying on concept of "cluster" and just think of power
domains and what's hanging on those domains. Sorry for naive question, but
does genpd have concept of notifiers. I do understand that it's more
bottom up approach where each entity in genpd saves the context and requests
to enter a particular state. But with CPU devices like GIC/VFP/PMU, it
needs to be more top down approach where CPU genpd has to enter a enter
so it notifies the devices attached to it to save it's context. Not ideal
but that's current solution. Because with the new DT bindings, platforms
can express if PMU/GIC is in per cpu domain or any pd in the hierarchy and
we ideally need to honor that. But that's optimisation, just mentioning.

> That should improve latency when
> selecting an idle state for a CPU. However, to reach that point
> additional changes are needed in various drivers, such as the gic
> driver for example.
>

Agreed.

> >
> > 2. Now that we have SDM845 which may soon have platform co-ordinated idle
> >    support in mainline, I *really* would like to see some power comparison
> >    numbers(i.e. PC without cluster idle states). This has been the main theme
> >    for most of the discussion on this topic for years and now we are close
> >    to have some platform, we need to try.
>
> I have quite recently been talking to Qcom folkz about this as well,
> but no commitments are made.
>

Indeed that's the worrying. IMO, this is requested since day#1 and not
even simple interest is shown, but that's another topic.

> Although I fully agree that some comparison would be great, it still
> doesn't matter much, as we anyway need to support PSCI OSI mode in
> Linux. Lorenzo have agreed to this as well.
>

OK, I am fine if others agree. Since we are sacrificing on few (retention)
states that might disappear with OSI, I am still very much still interested
as OSI might perform bad that PC especially in such cases.

> >
> > 3. Also, after adding such complexity, we really need a platform with an
> >    option to build and upgrade firmware easily. This will help to prevent
> >    this being not maintained for long without a platform to test, also
> >    avoid adding lots of quirks to deal with broken firmware so that newer
> >    platforms deal those issues in the firmware correctly.
>
> I don't see how this series change anything from what we already have
> today with the PSCI FW. No matter of OSI or PC mode is used, there are
> complexity involved.
>

I agree, but PC is already merged, mainitained and well tested regularly
as it's default mode that must be supported and TF-A supports/maintains
that. OSI is new and is on platform which may not have much commitments
and can be thrown away and any bugs we find in future many need to worked
around in kernel. That's what I meant as worrying.

> Although, of course I agree with you, that we should continue to try
> to convince ARM vendors about moving to the public version of ATF and
> avoid proprietary FW binaries as much as possible.
>

Indeed.

--
Regards,
Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
