Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A89C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:57:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5320920823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YOJP83ca";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aUE6cW53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5320920823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dCTCY9GVn3zhFuM9CpJV4HHuFeY+Rl1Mh8JCmhznEaU=; b=YOJP83canV1ULh
	9KPr5LuNsfVd/9DlWhh23LPRwmAY05n0YYKpgxIqMJAIe+AhmtBI4VmeJ5ehR/amn83rnfxXwWgJP
	yKLqn65ivL5MutOsAu6UCddhHoSbCblPSHJHKj7WJGn9XCVhrjfs8xMPTZH6my7dO3urgkOuWY43m
	ieHeNMq2w2iVewd95g44D2l3VHAV/mHp4TWgipooSSB0hZThTZPJSXKvMbJ/g17Luv1sgJRLFGcwF
	q5AhHte1OUZSunEvM7PNag3w+tjJOmNnOVj2Da3lrHQBkMpSQzpUeRBF93HupP6/74GLtGkyudIgO
	ZTofUyEYLmXX2kBj1l7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkSlh-0005nf-2F; Fri, 18 Jan 2019 11:57:01 +0000
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkSld-0005nC-9x
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 11:56:59 +0000
Received: by mail-ua1-x944.google.com with SMTP id t8so4600053uap.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 03:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3ONW9bfE6i1Oa5o6/qTPyn+92p86n1PcxECQuQGQfmQ=;
 b=aUE6cW53PrYI/10aWB4ZONz1hFTb/yhaoXDZaQRO1Pf4HZGwfGiUecZJammlKoUtNt
 593WN0tSeNVgXYe0/a8Cs7vMHcmKwWLF+MCpKOjfnA0Suh7w6L4j1jiM8UIC9xdteKfm
 e+Tjrfl7ZU4/PSY/VMowqgONnLiLHIJr4deHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3ONW9bfE6i1Oa5o6/qTPyn+92p86n1PcxECQuQGQfmQ=;
 b=aYE65IXdTDKlFK7oHIJdSApAhjBrgdEvdF3CfbfWlQpKB71YRIcOpe3EPyo5NU9zjZ
 /CGiOmWDDFeIZvBWMCzlojGDO8I6si7JrmXHFK7ruJBNRNF4RAd1aSbYNTqDppwh1JrV
 KUDfxGqh3dvwUUd5a6DamBb8XvP89QeqgNBpEAucKvgSGS4km8i7hd/LhbopJRDuHfzX
 DM3dfoVoewpPrjMbCXEZqxzCDyufxIVpwJBQNV0eJ08M3ZVe8DIJ+WYuI1UyHxkQnycB
 12YAkyo1LjvmowLVmQornMp/CMqG+m9ChOSaUxHl01rzK8HEDNITQ2qkQksgtQcX5a5r
 DxCA==
X-Gm-Message-State: AJcUukd4EU4pi/wKa+8K4PBwDodZbZKeFrg3Aiwra/IhZ+x9peanEd3N
 TnByhybzbpf3Jmf71I6dX3PNLmH41l98CJcUt7096Q==
X-Google-Smtp-Source: ALg8bN4n8QkzAWlLGs/JxMN+adW915f5e6mZgKyx2R8DNhqginJfToHmOkKMm31QuCbC3Zmbxl5+kJZhkKDRxhogAiM=
X-Received: by 2002:ab0:526:: with SMTP id 35mr7486129uax.25.1547812615297;
 Fri, 18 Jan 2019 03:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20190103120612.GC23511@e107155-lin>
 <CAPDyKFp-JB85TZOs+oso0iidaAsm1A=UDrg=gv+QZ4VJ9gW=fA@mail.gmail.com>
 <20190117174410.GA8839@e107155-lin>
In-Reply-To: <20190117174410.GA8839@e107155-lin>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 18 Jan 2019 12:56:18 +0100
Message-ID: <CAPDyKFqhQnDJzp4UAwLBNRj2kQbxtJxfm4QOi7wPWzcwA=b2mg@mail.gmail.com>
Subject: Re: [PATCH v10 00/27] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To: Sudeep Holla <sudeep.holla@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_035657_350189_B01BA0B9 
X-CRM114-Status: GOOD (  44.49  )
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

On Thu, 17 Jan 2019 at 18:44, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jan 16, 2019 at 10:10:08AM +0100, Ulf Hansson wrote:
> > On Thu, 3 Jan 2019 at 13:06, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Thu, Nov 29, 2018 at 06:46:33PM +0100, Ulf Hansson wrote:
> > > > Over the years this series have been iterated and discussed at various Linux
> > > > conferences and LKML. In this new v10, a quite significant amount of changes
> > > > have been made to address comments from v8 and v9. A summary is available
> > > > below, although let's start with a brand new clarification of the motivation
> > > > behind this series.
> > >
> > > I would like to raise few points, not blockers as such but need to be
> > > discussed and resolved before proceeding further.
> > > 1. CPU Idle Retention states
> > >         - How will be deal with flattening (which brings back the DT bindings,
> > >           i.e. do we have all we need) ? Because today there are no users of
> > >           this binding yet. I know we all agreed and added after LPC2017 but
> > >           I am not convinced about flattening with only valid states.
> >
> > Not exactly sure I understand what you are concerned about here. When
> > it comes to users of the new DT binding, I am converting two new
> > platforms in this series to use of it.
> >
>
> Yes that's exactly my concern. So if someone updates DT(since it's part
> of the kernel still), but don't update the firmware(for complexity reasons)
> the end result on those platform is broken CPUIdle which is a regression/
> feature break and that's what I am objecting here.

There is not going to be a regression if that happens, you have got
that wrong. Let me clarify why.

For Hikey example, which is one of those platforms I convert into
using the new hierarchical DT bindings for the CPUs. It still uses the
existing PSCI FW, which is supporting PSCI PC mode only.

In this case, the PSCI FW driver, observes that there is no OSI mode
support in the FW, which triggers it to convert the hierarchically
described idle states into regular flattened cpuidle states. In this
way, the idle states can be manged by the cpuidle framework per CPU,
as they are currently.

So, why convert Hikey to the new DT bindings? It makes Linux aware of
the topology, thus it can monitor when the last CPU in the cluster
enters idle - and then take care of "last man activities".

>
> > Note, the flattened model is still a valid option to describe the CPU
> > idle states after these changes. Especially when there are no last man
> > standing activities to manage by Linux and no shared resource that
> > need to prevent cluster idle states, when it's active.
>
> Since OSI vs PC is discoverable, we shouldn't tie up with DT in anyway.

As stated above, we aren't. OSI and PC mode are orthogonal to the DT bindings.

>
> >
> > >         - Will domain governor ensure not to enter deeper idles states based
> > >           on its sub-domain states. E.g.: when CPUs are in retention, so
> > >           called container/cluster domain can enter retention or below and not
> > >           power off states.
> >
> > I have tried to point this out as a known limitation in genpd of the
> > current series, possibly I have failed to communicate that clearly.
> > Anyway, I fully agree that this needs to be addressed in a future
> > step.
> >
>
> Sorry, I might have missed to read. The point is if we are sacrificing
> few retention states with this new feature, I am sure PC would perform
> better that OSI on platforms which has retention states. Another
> reason for having comparison data or we should simply assume and state
> clearly OSI may perform bad on such system until the support is added.

I now understand that I misread your question. We are not scarifying
any idle states at all. Not in PC mode and not in OSI mode.

>
> > Note that, this isn't a specific limitation to how idle states are
> > selected for CPUs and CPU clusters by genpd, but is rather a
> > limitation to any hierarchical PM domain topology managed by genpd
> > that has multiple idle states.
> >
>
> Agreed, but with flattened mode we compile the list of valid states so
> the limitation is automatically eliminated.

What I was trying to point out above, was a limitation in genpd and
with its governors. If the PM domains have multiple idle states and
also have multiple sub-domain levels, the selection of idle state may
not be correct. However, that scenario doesn't exist for Hikey/410c.

Apologize for the noise, I simply thought it was this limitation you
referred to.

>
> > Do note, I already started hacking on this and intend to post patches
> > on top of this series, as these changes isn't needed for those two
> > ARM64 platforms I have deployed support for.
> >
>
> Good to know.
>
> > >         - Is the case of not calling cpu_pm_{enter,exit} handled now ?
> >
> > It is still called, so no changes in regards to that as apart of this series.
> >
>
> OK, so I assume for now we are not going to support retention states with OSI
> for now ?
>
> > When it comes to actually manage the "last man activities" as part of
> > selecting an idle state of the cluster, that is going to be addressed
> > on top as "optimizations".
> >
>
> OK
>
> > In principle we should not need to call cpu_pm_enter|exit() in the
> > idle path at all,
>
> Not sure if we can do that. We need to notify things like PMU, FP, GIC
> which have per cpu context too and not just "cluster" context.
>
> > but rather only cpu_cluster_pm_enter|exit() when a cluster idle state is
> > selected.
>
> We need to avoid relying on concept of "cluster" and just think of power
> domains and what's hanging on those domains.

I fully agree. I just wanted to use a well know term to avoid confusion.

> Sorry for naive question, but
> does genpd have concept of notifiers. I do understand that it's more
> bottom up approach where each entity in genpd saves the context and requests
> to enter a particular state. But with CPU devices like GIC/VFP/PMU, it
> needs to be more top down approach where CPU genpd has to enter a enter
> so it notifies the devices attached to it to save it's context.

No, genpd don't have on/off notifiers . There have been attempts to
add them, but those didn't make it.

Anyway, it's nice that you brings this up! The problem is well
described and the approach you suggest may very well be the right one.

In principle, I am also worried that the cpu_cluster_pm_enter|exist()
notifiers, doesn't scale. We may fire them when we shouldn't and
consumers may get them when they don't need them.

> Not ideal
> but that's current solution. Because with the new DT bindings, platforms
> can express if PMU/GIC is in per cpu domain or any pd in the hierarchy and
> we ideally need to honor that. But that's optimisation, just mentioning.

Overall, it's great that you mention this - and I just want to
confirm. I have this in mind when I am thinking of the next steps.

In regards to the next steps, hopefully we can move forward with
$subject series soon, so we really can start discussing the next steps
for real. I even think we need some of them to be implemented, before
we can see the full benefits made to latency and energy efficiency.

>
> > That should improve latency when
> > selecting an idle state for a CPU. However, to reach that point
> > additional changes are needed in various drivers, such as the gic
> > driver for example.
> >
>
> Agreed.
>
> > >
> > > 2. Now that we have SDM845 which may soon have platform co-ordinated idle
> > >    support in mainline, I *really* would like to see some power comparison
> > >    numbers(i.e. PC without cluster idle states). This has been the main theme
> > >    for most of the discussion on this topic for years and now we are close
> > >    to have some platform, we need to try.
> >
> > I have quite recently been talking to Qcom folkz about this as well,
> > but no commitments are made.
> >
>
> Indeed that's the worrying. IMO, this is requested since day#1 and not
> even simple interest is shown, but that's another topic.

Well, at least we keep talking about it and I am sure we will be able
to compare at some point.

Another option is simply to implement support for OSI mode in the
public ARM Trusted Firmware, any of us could do that. That would open
up for testing for a bunch of "open" platforms, like Hikey for
example.

>
> > Although I fully agree that some comparison would be great, it still
> > doesn't matter much, as we anyway need to support PSCI OSI mode in
> > Linux. Lorenzo have agreed to this as well.
> >
>
> OK, I am fine if others agree. Since we are sacrificing on few (retention)
> states that might disappear with OSI, I am still very much still interested
> as OSI might perform bad that PC especially in such cases.
>
> > >
> > > 3. Also, after adding such complexity, we really need a platform with an
> > >    option to build and upgrade firmware easily. This will help to prevent
> > >    this being not maintained for long without a platform to test, also
> > >    avoid adding lots of quirks to deal with broken firmware so that newer
> > >    platforms deal those issues in the firmware correctly.
> >
> > I don't see how this series change anything from what we already have
> > today with the PSCI FW. No matter of OSI or PC mode is used, there are
> > complexity involved.
> >
>
> I agree, but PC is already merged, mainitained and well tested regularly
> as it's default mode that must be supported and TF-A supports/maintains
> that. OSI is new and is on platform which may not have much commitments
> and can be thrown away and any bugs we find in future many need to worked
> around in kernel. That's what I meant as worrying.

I see what you are saying. Hopefully my earlier answers above will
make you less worry. :-)

>
> > Although, of course I agree with you, that we should continue to try
> > to convince ARM vendors about moving to the public version of ATF and
> > avoid proprietary FW binaries as much as possible.
> >
>
> Indeed.
>
> --
> Regards,
> Sudeep

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
