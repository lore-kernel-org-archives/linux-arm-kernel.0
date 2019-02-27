Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71AFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:58:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34DB204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WE4YLZxG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LHC0cawg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34DB204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=35zaUZoeVuYgEPPaTdB3DkAXoqAlgrD9gujnifNrxwU=; b=WE4
	YLZxG5XqsnjUTgIzcmx5wq6OlGLZQxyDfBcnVMr9Uu4GbufT0H8Qnm2kQV0bzwWV7r7Txxj5pEl5S
	ix09g4GE7Pj1hWF6I6kTEzSFlUd6hbI3fmgJq6yUsCPRPgbt4R+XrdL/YA8odmNPf8/HUUtM76w2H
	5UJeRJ0GwBVpQJAo2L9qlisKG9fFE4pe6ELPX1vwgK1lEzCaEDMGaKukjEiIBOGwMzuRsrO4GOoFR
	6DqC2c9yFNQHOoBkpDm2UuQvhwCcee9tMewGgmMgfoJlL31ebwDVJYoGqlLvWsZMRNKIFL+0vk8Iy
	+0UuWSCccv2vafYdlM+mx5I1j0KttDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz5Lr-00077n-Qe; Wed, 27 Feb 2019 19:58:47 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz5Ln-00076m-Jo
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 19:58:45 +0000
Received: by mail-lj1-x241.google.com with SMTP id l5so15016606lje.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 11:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=E+SW/FzCToYtA2IYYZgzpn69wj9GD9/vb8yka3Fu1rA=;
 b=LHC0cawgZgGXdf0YwSx8zusmDieSvGvjJwI0LerpUVk2TeKuKHJTcjUKtj1ZU+5Ipo
 6wR4tj0qNZjDUCWLWBz3YuJdEtRJId1t7BdanHHP4nCrhs3DzaNFaHDIrERH2plbsJua
 UUbnZLpz0W/2lwkOsZe9OmNqtwtH42Exqse/6vtQWMp8EmiF0h3Sk60mhNTdb8/2ttKZ
 P5EoJ/DeNTxAvMukjoPiQmeZ+sTeHBjW4kSwJmrGX1Inuoy9ix30bHfvT6Dpl9ne/xBO
 wbDfpVSq2uQxzjlP0a3u403cf75UwjzbOvmQZ3k8ZZfw/jJbQYdq8jE5Syw3H4MXwYUk
 7OJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=E+SW/FzCToYtA2IYYZgzpn69wj9GD9/vb8yka3Fu1rA=;
 b=eoQQAzZafq6j4hHvaNpFmFj1ZmB/4aqns6XOc7HvBv33WIfIbaWv7z5OPfTAeGQEMB
 O/CbcdYW6tefy9ty1d4VjpojIgBnCQv9Gp3XgoemRqzmRrlQ2i8fq8DdwiSCoGhE7+W4
 np/Rhupg9hRw3ZUNuS6211R/ZfR6GO11xdSZsJ6JU0zI77XLqDiORvuoD/DWPkxu6DfV
 ENQ719VztJTxAqworVHzCKi7fSJ8E25004bkP5TiXz6uJ6XQzhHQXQH74eEzmv+/BYrP
 WP2JsQJ/IbiW1jL8XJ1pn5HcdUMkmBr3tFGDdtwvRcncm1183aGkF6Ge2o9eMk2nq+Zy
 9MxQ==
X-Gm-Message-State: AHQUAuYH4vEHtuuacS443/ura02W4hc8rN9CcsclL6zBJyrHkuk46Y13
 1icjvykjsWlFpdXfuY9msopeQw==
X-Google-Smtp-Source: APXvYqw53mdCCWDHLmI+zZBzRlW+bF8UGhtaXLrep4fwgKErZhI4r8naM3JxZjlYs+G1aEny6inl7g==
X-Received: by 2002:a2e:21d1:: with SMTP id h78mr2213515lji.49.1551297520660; 
 Wed, 27 Feb 2019 11:58:40 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id z128sm723802lfa.60.2019.02.27.11.58.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 Feb 2019 11:58:39 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH v12 0/4] PM / Domains: Support hierarchical CPU arrangement
 (PSCI/ARM)
Date: Wed, 27 Feb 2019 20:58:32 +0100
Message-Id: <20190227195836.24739-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_115843_773038_C14ABBF2 
X-CRM114-Status: GOOD (  23.18  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Frederic Weisbecker <fweisbec@gmail.com>, linux-arm-msm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Changes in v12:
 - Drop the patches for restructuring tick_nohz_get_sleep_length(). Instead
replace them all with a new timer/cpuidle patch, according to suggestions by
Rafael.
 - The entire v12 series, including the PSCI/ARM changes are available in a
git branch [2].

Changes in v11:
 - This version contains only the infrastructure changes that is needed for
deployment. The PSCI/ARM changes have also been updated and tested, but I will
post them separately. Still, to provide completeness, I have published a branch
containing everything to a git tree [1], feel free to have a look and test.
 - The v10 series contained a patch, "timer: Export next wakeup time of a CPU",
which has been replaced by a couple of new patches, whom reworks the existing
tick_nohz_get_sleep_length() function, to provide the next timer expiration
instead of the duration.
 - More changelogs are available per patch.

Changes in v10:
 - Quite significant changes have been to the PSCI driver deployment. According
   to an agreement with Lorenzo, the hierarchical CPU layout for PSCI should be
   orthogonal to whether the PSCI FW supports OSI or not. This has been taken
   care of in this version.
 - Drop the generic attach/detach helpers of CPUs to genpd, instead make that
   related code internal to PSCI, for now.
 - Fix "BUG: sleeping for invalid context" for hotplug, as reported by Raju.
 - Addressed various comments from version 8 and 9.
 - Clarified changelogs and re-wrote the cover-letter to better explain the
   motivations behind these changes.

Background:

For ARM64/ARM based platforms CPUs are often arranged in a hierarchical manner.
From a CPU idle state perspective, this means some states may be shared among a
group of CPUs (aka CPU cluster).

To deal with idle management of a group of CPUs, sometimes the kernel needs to
be involved to manage the last-man standing algorithm, simply because it can't
rely solely on power management FWs to deal with this. Depending on the
platform, of course.

There are a couple of typical scenarios for when the kernel needs to be in
control, dealing with synchronization of when the last CPU in a cluster is about
to enter a deep idle state.

1)
The kernel needs to carry out so called last-man activities before the
CPU cluster can enter a deep idle state. This may for example involve to
configure external logics for wakeups, as the GIC may no longer be functional
once a deep cluster idle state have been entered. Likewise, these operations
may need to be restored, when the first CPU wakes up.

2)
Other more generic I/O devices, such as an MMC controller for example, may be a
part of the same power domain as the CPU cluster, due to a shared power-rail.
For these scenarios, when the MMC controller is in use dealing with an MMC
request, a deeper idle state of the CPU cluster may needs to be temporarily
disabled. This is needed to retain the MMC controller in a functional state,
else it may loose its register-context in the middle of serving a request.

In this series, we are extending the generic PM domain (aka genpd) to be used
for also CPU devices. Hence the goal is to re-use much of its current code to
help us manage the last-man standing synchronization. Moreover, as we already
use genpd to model power domains for generic I/O devices, both 1) and 2) can be
address with its help.

Moreover, to address these problems for ARM64 DT based platforms, we are
deploying support for genpd and runtime PM to the PSCI FW driver - and finally
we make some updates to two ARM64 DTBs, as to deploy the new PSCI CPU topology
layout.

The series has been tested on a Qcom 410c dragonboard and on a Hisilicon Hikey
board. The first one uses PSCI OS-initiated mode, while the second uses the PSCI
Platform-Coordinated mode.

Kind regards
Ulf Hansson

[1]
git.linaro.org/people/ulf.hansson/linux-pm.git next_v11
[2]
git.linaro.org/people/ulf.hansson/linux-pm.git next_v12

Ulf Hansson (4):
  PM / Domains: Add a generic data pointer to the genpd_power_state
    struct
  PM / Domains: Add support for CPU devices to genpd
  cpuidle: Export the next timer/tick expiration for a CPU
  PM / Domains: Add genpd governor for CPUs

 drivers/base/power/domain.c          | 78 ++++++++++++++++++++++++++--
 drivers/base/power/domain_governor.c | 62 +++++++++++++++++++++-
 drivers/cpuidle/cpuidle.c            |  8 +++
 include/linux/cpuidle.h              |  1 +
 include/linux/pm_domain.h            | 20 ++++++-
 include/linux/tick.h                 |  7 ++-
 kernel/time/tick-sched.c             | 12 +++++
 7 files changed, 182 insertions(+), 6 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
