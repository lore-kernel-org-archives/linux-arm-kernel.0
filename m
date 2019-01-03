Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E559C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:06:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394AF2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OW/SEmNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394AF2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=brpXiP4R9wdHeiXr4Wfymm2mK+KsT7Y8HGEsIExCaaY=; b=OW/SEmNyjAXRVW
	7dmZ84vMNLM/oriSi3umISEsI8To9g204TG7LkWDHQnrmx0YaLDk0rpIHtckaECIdZU34KP2a6eyQ
	uR+Acl5smbH+IiW3HRLgFiGMefXUC4DuW3OmU4tPwHU3P3qFovcFJ3s0Gnpnp8YP4BxStZaAjcBT9
	VcnjgHU0OMCb4McPjJi3J8Ozu8S33I0F4d1WORUlNwcc9X5l/CjphF2c/Zlm9HOuvd057O1iPphbN
	V+rpHQDTBY9BQTUNzk3yx802+Y+WLRoBJRMmxvmA/68WPepa3kRyKOefzRsxxuhU64zW3CjENyq4Q
	cvxdL4/sxu2Nn6iVKShA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf1lW-0005Fn-Bf; Thu, 03 Jan 2019 12:06:22 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf1lS-0005FK-Sv
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 12:06:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFDB9A78;
 Thu,  3 Jan 2019 04:06:17 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B65493F5D4;
 Thu,  3 Jan 2019 04:06:14 -0800 (PST)
Date: Thu, 3 Jan 2019 12:06:12 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 00/27] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
Message-ID: <20190103120612.GC23511@e107155-lin>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_040618_937571_B2F86485 
X-CRM114-Status: GOOD (  13.75  )
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
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-arm-msm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, linux-kernel@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 06:46:33PM +0100, Ulf Hansson wrote:
> Over the years this series have been iterated and discussed at various Linux
> conferences and LKML. In this new v10, a quite significant amount of changes
> have been made to address comments from v8 and v9. A summary is available
> below, although let's start with a brand new clarification of the motivation
> behind this series.

I would like to raise few points, not blockers as such but need to be
discussed and resolved before proceeding further.
1. CPU Idle Retention states
	- How will be deal with flattening (which brings back the DT bindings,
	  i.e. do we have all we need) ? Because today there are no users of
	  this binding yet. I know we all agreed and added after LPC2017 but
	  I am not convinced about flattening with only valid states.
	- Will domain governor ensure not to enter deeper idles states based
	  on its sub-domain states. E.g.: when CPUs are in retention, so
	  called container/cluster domain can enter retention or below and not
	  power off states.
	- Is the case of not calling cpu_pm_{enter,exit} handled now ?

2. Now that we have SDM845 which may soon have platform co-ordinated idle
   support in mainline, I *really* would like to see some power comparison
   numbers(i.e. PC without cluster idle states). This has been the main theme
   for most of the discussion on this topic for years and now we are close
   to have some platform, we need to try.

3. Also, after adding such complexity, we really need a platform with an
   option to build and upgrade firmware easily. This will help to prevent
   this being not maintained for long without a platform to test, also
   avoid adding lots of quirks to deal with broken firmware so that newer
   platforms deal those issues in the firmware correctly.

--
Regards,
Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
