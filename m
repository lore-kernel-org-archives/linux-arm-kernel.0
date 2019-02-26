Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7414EC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:54:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3033220C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dbieR72G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yEhuYlCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3033220C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=+kRL+eMGUCRJTJyX5WXdDXs4p//TTiNqEdEb7J7T+/0=; b=dbi
	eR72GhEO7IMw/C58miS5jlBHtup92DQSKUGp/bCdJCQKENDoGuRc4XC+lVxl60DCUU5if38DQ4eOq
	aVyMFwAskBEBo+PC32PfcyB58eVLxi0X7tnW6KcywAViD/4272TrYf1iE8sgQxgWeCx4Qu/jLjUel
	ozMxUIqkeV7uukLB+B61MxJKUa5LYBKZNEYLnVIGvJERl+KrD3J3pVFi8uo78YNpse6F3PsYeQrKF
	MpKuMCtloGe85W4FB/bKvjK1Ml4DC8uefO1thDA8QvF65MfmgIyBFCRrtK1ysRgNA1xpVC5MmYP8R
	MGcq8J+xh9qhZ36Cf6Rg1YcYwx5kFUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gye88-0005Yl-Fk; Tue, 26 Feb 2019 14:54:48 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gye7v-0005Ne-Rd
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 14:54:37 +0000
Received: by mail-lj1-x244.google.com with SMTP id d24so10750123ljc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 06:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=bAWEQtmf+fggjn633EQ0gBHasaIotZNQ6JNtd1TnYlY=;
 b=yEhuYlCnoHOeoTTeypOCSSGycNr6eghlJAYY/0Qk/w47J4Xm7zDOZWXf3VzOryDoFH
 JUK9D/277P9gzy0yI1MPay9RVdBQBSrIIqwFVv/mnGXNTCWa3O84uGSBtMAt5Rbp8/sU
 QhhjCK7dXpC+PmeW5EF7+3YKj7RZyPEHoZEtKbuHv0dA8+Zk6uaoqmEnUu9XdBrRd657
 Qp6OrgrPjz4PBgXbIowa4MZAZIYLGSiRyKtuL9sXs+yMInHRPT+XHbXSJXLLn44zr/n2
 HppDP59Xbtzej/fU50ecScZMDnuAVHKTTjw79ZYu9ACC36wh7VFAtudJ4Dq8a2eivgkc
 uidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=bAWEQtmf+fggjn633EQ0gBHasaIotZNQ6JNtd1TnYlY=;
 b=R1wpIz6nfh6SL6ZdvQYL0WUssnkTGiqu+vu3wpc3wTEEInIaKA+/OdNxxveCh9ePwW
 3H/heMGXKt9Py3GTDcSrp4fWcqUOvPKb8F6W7jjGXt/2DV342TKCbRWQSc4yy0PfJtSM
 v2kYdOwATPDv6fxd71sIf2njdwrQtl8mLm1UF/H84qahW0keIYJvA6RsJP7Rc+HvIhKF
 +U84OqZDmijl6gXW6PNPM9Lfix+tKd3Jb4XN8bvsxzhuYs/8FA/dQ/0AUii0l7APUC8k
 IvkZ8uvBVuRnC1q0Ax0DkJsRcWaPNIHm7KC987OOuEZKYm85AVYfRwntHN8NSkOygHCI
 gezA==
X-Gm-Message-State: AHQUAuap5ZNcV8GUgvHc5Ty9zQBtT7L6whBurvMncMq7h9q9UHrYuVlc
 3CHRtlk5qNGSyIPnmnyecooTLQ==
X-Google-Smtp-Source: AHgI3IY7Fh/iJB1rM3CbMbsCZao4labBAhvTuxuXpfkMpQyUIWovpYBREFulbYA+w07Ewxce5yxHLA==
X-Received: by 2002:a2e:964b:: with SMTP id z11mr12327938ljh.138.1551192871604; 
 Tue, 26 Feb 2019 06:54:31 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id t11sm2206554ljj.92.2019.02.26.06.54.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 06:54:30 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH v11 0/8] PM / Domains: Support hierarchical CPU arrangement
 (PSCI/ARM)
Date: Tue, 26 Feb 2019 15:54:07 +0100
Message-Id: <20190226145415.19411-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_065436_017301_5F8B1289 
X-CRM114-Status: GOOD (  21.67  )
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

Daniel Lezcano (4):
  time: tick-sched: Provide helpers to get the next timer expiration
  cpuidle: menu: Convert to tick_nohz_get_next_timer|hrtimer()
  cpuidle: teo: Convert to tick_nohz_get_next_timer()
  time: tick-sched: Remove tick_nohz_get_sleep_length()

Ulf Hansson (4):
  PM / Domains: Add a generic data pointer to the genpd_power_state
    struct
  PM / Domains: Add support for CPU devices to genpd
  cpuidle: Pre-store next timer/tick before selecting an idle state
  PM / Domains: Add genpd governor for CPUs

 drivers/base/power/domain.c          | 78 ++++++++++++++++++++++++++--
 drivers/base/power/domain_governor.c | 62 +++++++++++++++++++++-
 drivers/cpuidle/cpuidle.c            |  2 +
 drivers/cpuidle/governors/menu.c     | 14 ++++-
 drivers/cpuidle/governors/teo.c      |  4 +-
 include/linux/cpuidle.h              |  2 +
 include/linux/pm_domain.h            | 20 ++++++-
 include/linux/tick.h                 | 11 ++--
 kernel/time/tick-sched.c             | 71 +++++++++++++++++--------
 9 files changed, 229 insertions(+), 35 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
