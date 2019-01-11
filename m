Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD85C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:09:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1642177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bpy/Dtmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1642177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=09Js93Vn0KwD3VcK5AgCxeGxWbp+c6YWwxyXhRK+23E=; b=Bpy/Dtmpb2QHxr
	s9wOyvVDtMk/DdpE8t3hvgXOYb865mv+i43+suuAeyZxNu2Q80tJMrnrzgllX5VLRCVL78yfuM4y2
	hCN0iRkdTEXp2kD8I2C+5Ig3F5g0bJfRgixGhYzOhoWn1doBh4AiAluj1z1SYUZCQuKoGTI27xydB
	vdt84vZtMHIAY8OT7G2xtypSI99xTuwHzWZcMSfH9Zzv8uTTDkdYbw5e1wuRBFa1zQYokkhb6fWKk
	//vYUhRe21CwPDUqzmun9fUPXUIVUuNPy+vLX7a+2I7kLKmgScGHPTLS5+s7PPBYBVSOMwLvZw6qe
	9T0Vy0DzbC49V1hnPeDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghugq-00009F-Ig; Fri, 11 Jan 2019 11:09:28 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghugj-00008D-Mn
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 11:09:26 +0000
Received: from 79.184.254.168.ipv4.supernova.orange.pl (79.184.254.168) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 0a8fb58d82abfe8c; Fri, 11 Jan 2019 12:09:19 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 00/27] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
Date: Fri, 11 Jan 2019 12:08:32 +0100
Message-ID: <2260944.bWjCqvLuxn@aspire.rjw.lan>
In-Reply-To: <CAPDyKFpV0uQhZnJhSg79RxmCq+0PFUeaXCgmBgRU5aNF8WNoDw@mail.gmail.com>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <CAPDyKFpV0uQhZnJhSg79RxmCq+0PFUeaXCgmBgRU5aNF8WNoDw@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_030925_491116_2BBBBB22 
X-CRM114-Status: GOOD (  24.57  )
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
 Viresh Kumar <viresh.kumar@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Kevin Hilman <khilman@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Monday, December 17, 2018 5:12:54 PM CET Ulf Hansson wrote:
> Rafael, Sudeep, Lorenzo, Mark,
> 
> On Thu, 29 Nov 2018 at 18:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Over the years this series have been iterated and discussed at various Linux
> > conferences and LKML. In this new v10, a quite significant amount of changes
> > have been made to address comments from v8 and v9. A summary is available
> > below, although let's start with a brand new clarification of the motivation
> > behind this series.
> >
> > For ARM64/ARM based platforms CPUs are often arranged in a hierarchical manner.
> > From a CPU idle state perspective, this means some states may be shared among a
> > group of CPUs (aka CPU cluster).
> >
> > To deal with idle management of a group of CPUs, sometimes the kernel needs to
> > be involved to manage the last-man standing algorithm, simply because it can't
> > rely solely on power management FWs to deal with this. Depending on the
> > platform, of course.
> >
> > There are a couple of typical scenarios for when the kernel needs to be in
> > control, dealing with synchronization of when the last CPU in a cluster is about
> > to enter a deep idle state.
> >
> > 1)
> > The kernel needs to carry out so called last-man activities before the
> > CPU cluster can enter a deep idle state. This may for example involve to
> > configure external logics for wakeups, as the GIC may no longer be functional
> > once a deep cluster idle state have been entered. Likewise, these operations
> > may need to be restored, when the first CPU wakes up.
> >
> > 2)
> > Other more generic I/O devices, such as an MMC controller for example, may be a
> > part of the same power domain as the CPU cluster, due to a shared power-rail.
> > For these scenarios, when the MMC controller is in use dealing with an MMC
> > request, a deeper idle state of the CPU cluster may needs to be temporarily
> > disabled. This is needed to retain the MMC controller in a functional state,
> > else it may loose its register-context in the middle of serving a request.
> >
> > In this series, we are extending the generic PM domain (aka genpd) to be used
> > for also CPU devices. Hence the goal is to re-use much of its current code to
> > help us manage the last-man standing synchronization. Moreover, as we already
> > use genpd to model power domains for generic I/O devices, both 1) and 2) can be
> > address with its help.
> >
> > Moreover, to address these problems for ARM64 DT based platforms, we are
> > deploying support for genpd and runtime PM to the PSCI FW driver - and finally
> > we make some updates to two ARM64 DTBs, as to deploy the new PSCI CPU topology
> > layout.
> >
> > The series has been tested on the QCOM 410c dragonboard and the Hisilicon Hikey
> > board. You may also find the code at:
> >
> > git.linaro.org/people/ulf.hansson/linux-pm.git next
> 
> It's soon been three weeks since I posted this and I would really
> appreciate some feedback.
> 
> Rafael, I need your feedback on patch 1->4.

Sorry for the delay, I've replied to the patches.

The bottom line is that the mechanism introduced in patch 3 and used
in patch 4 doesn't look particularly clean to me.

Cheers,
Rafael


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
