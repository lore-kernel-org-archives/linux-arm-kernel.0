Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E4FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:43:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 841E82087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y6mNd85B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qQmXGpBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841E82087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=9OjdGXvC/3W29iEW2A0DxoLFFwR6f+KvjS7jFZJDflQ=; b=Y6mNd85BA0R1eAmB1KBoMrzGir
	G1AJq4QaenKT2kza8JmRMxA/IhVYIzi00Bow51ML5DesWfsZvr78ur1sKXjNDSHi3TaHfXcpOh2am
	dHUFlwRlzm9M4mPPqk9M5/cokhvxDXqkVD06sLzemKI6mCeJUoiCLA2Tvzzyh1pNNN1LWn6Me8URu
	uF6EunYmt0IFTgLQ50EuSaO5SjnSW/Wtzsx/Cn/i1P3lQwqDVgZWrRQv9qqaWhXtdouhZKpoZ05Jk
	s3N40AK/fqfH0gNfasvoOXqF6N+NcnE9DDo5v98fktd2PSny+0q7rp8zZ2IEjF6b4Cji1S9jYwxKU
	5V5wTUGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggY09-0003dd-6A; Mon, 07 Jan 2019 16:43:45 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggY07-0003Rt-MT
 for linux-arm-kernel@bombadil.infradead.org; Mon, 07 Jan 2019 16:43:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w6FSjctzAYOsgegCkjDRpJljWraQ1JCOXR+S6jLFRHM=; b=qQmXGpBpVrB0X59Izy2L4iXUj
 fev+eH2ZiPzhY3y0M2q+nacaUa0i/Q33Jt1LmzB3L/22xrhjBXrJ3FF3PSCOscnezdKQ796wgLVOq
 AYyHf+TuFdrjV8u4Vd+O7M3MbjlyFhhMZGXwpkRgYuhiXIIBkO7CSqnMBxgq+fW1Ho/rwaTHZmGNs
 pBAMpjban16sDGvabKSsDaQUlnPvxIjBbcidqM0YhddXRhv6fOrjHSBV0jmVevaPE8ryUfNsjocbb
 hUScD7oRsrrDnbQSVMKhh7314T7Yu7hoOqNQGxRq8WWgkhuVkicjhK/6pF+Q9AR5R+7edgSDkv6KH
 DgUxSm8jA==;
Received: from foss.arm.com ([217.140.101.70])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggXlO-0001E6-02
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 16:28:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46EDB1596;
 Mon,  7 Jan 2019 08:28:29 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C345C3F5A0;
 Mon,  7 Jan 2019 08:28:24 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Will Deacon <will.deacon@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Russell King <linux@armlinux.org.uk>,
 suzuki.poulose@arm.com, robin.murphy@arm.com,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v4 10/13] x86: perf/core: use PERF_PMU_CAP_NO_EXCLUDE for
 exclude incapable PMUs
Date: Mon,  7 Jan 2019 16:27:27 +0000
Message-Id: <1546878450-20341-11-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
References: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_162830_452890_7839BF6F 
X-CRM114-Status: GOOD (  16.72  )
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
Cc: x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

For drivers that do not support context exclusion let's advertise the
PERF_PMU_CAP_NOEXCLUDE capability. This ensures that perf will
prevent us from handling events where any exclusion flags are set.
Let's also remove the now unnecessary check for exclusion flags.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/x86/events/amd/ibs.c          | 13 +------------
 arch/x86/events/amd/power.c        | 10 ++--------
 arch/x86/events/intel/cstate.c     | 12 +++---------
 arch/x86/events/intel/rapl.c       |  9 ++-------
 arch/x86/events/intel/uncore_snb.c |  9 ++-------
 arch/x86/events/msr.c              | 10 ++--------
 6 files changed, 12 insertions(+), 51 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index d50bb4d..62f317c 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -253,15 +253,6 @@ static int perf_ibs_precise_event(struct perf_event *event, u64 *config)
 	return -EOPNOTSUPP;
 }
 
-static const struct perf_event_attr ibs_notsupp = {
-	.exclude_user	= 1,
-	.exclude_kernel	= 1,
-	.exclude_hv	= 1,
-	.exclude_idle	= 1,
-	.exclude_host	= 1,
-	.exclude_guest	= 1,
-};
-
 static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -282,9 +273,6 @@ static int perf_ibs_init(struct perf_event *event)
 	if (event->pmu != &perf_ibs->pmu)
 		return -ENOENT;
 
-	if (perf_flags(&event->attr) & perf_flags(&ibs_notsupp))
-		return -EINVAL;
-
 	if (config & ~perf_ibs->config_mask)
 		return -EINVAL;
 
@@ -537,6 +525,7 @@ static struct perf_ibs perf_ibs_fetch = {
 		.start		= perf_ibs_start,
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	},
 	.msr			= MSR_AMD64_IBSFETCHCTL,
 	.config_mask		= IBS_FETCH_CONFIG_MASK,
diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
index 2aefacf..c5ff084 100644
--- a/arch/x86/events/amd/power.c
+++ b/arch/x86/events/amd/power.c
@@ -136,14 +136,7 @@ static int pmu_event_init(struct perf_event *event)
 		return -ENOENT;
 
 	/* Unsupported modes and filters. */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest  ||
-	    /* no sampling */
-	    event->attr.sample_period)
+	if (event->attr.sample_period)
 		return -EINVAL;
 
 	if (cfg != AMD_POWER_EVENTSEL_PKG)
@@ -226,6 +219,7 @@ static struct pmu pmu_class = {
 	.start		= pmu_event_start,
 	.stop		= pmu_event_stop,
 	.read		= pmu_event_read,
+	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 };
 
 static int power_cpu_exit(unsigned int cpu)
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index d2e7807..94a4b7f 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -280,13 +280,7 @@ static int cstate_pmu_event_init(struct perf_event *event)
 		return -ENOENT;
 
 	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest  ||
-	    event->attr.sample_period) /* no sampling */
+	if (event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
 	if (event->cpu < 0)
@@ -437,7 +431,7 @@ static struct pmu cstate_core_pmu = {
 	.start		= cstate_pmu_event_start,
 	.stop		= cstate_pmu_event_stop,
 	.read		= cstate_pmu_event_update,
-	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT,
+	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT | PERF_PMU_CAP_NO_EXCLUDE,
 	.module		= THIS_MODULE,
 };
 
@@ -451,7 +445,7 @@ static struct pmu cstate_pkg_pmu = {
 	.start		= cstate_pmu_event_start,
 	.stop		= cstate_pmu_event_stop,
 	.read		= cstate_pmu_event_update,
-	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT,
+	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT | PERF_PMU_CAP_NO_EXCLUDE,
 	.module		= THIS_MODULE,
 };
 
diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 91039ff..94dc564 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -397,13 +397,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest  ||
-	    event->attr.sample_period) /* no sampling */
+	if (event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
 	/* must be done before validate_group */
@@ -699,6 +693,7 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.stop		= rapl_pmu_event_stop;
 	rapl_pmus->pmu.read		= rapl_pmu_event_read;
 	rapl_pmus->pmu.module		= THIS_MODULE;
+	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
 	return 0;
 }
 
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 2593b0d..b12517f 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -397,13 +397,7 @@ static int snb_uncore_imc_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest  ||
-	    event->attr.sample_period) /* no sampling */
+	if (event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
 	/*
@@ -497,6 +491,7 @@ static struct pmu snb_uncore_imc_pmu = {
 	.start		= uncore_pmu_event_start,
 	.stop		= uncore_pmu_event_stop,
 	.read		= uncore_pmu_event_read,
+	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 };
 
 static struct intel_uncore_ops snb_uncore_imc_ops = {
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 1b9f85a..a878e62 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -160,13 +160,7 @@ static int msr_event_init(struct perf_event *event)
 		return -ENOENT;
 
 	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest  ||
-	    event->attr.sample_period) /* no sampling */
+	if (event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
 	if (cfg >= PERF_MSR_EVENT_MAX)
@@ -256,7 +250,7 @@ static struct pmu pmu_msr = {
 	.start		= msr_event_start,
 	.stop		= msr_event_stop,
 	.read		= msr_event_update,
-	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT,
+	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT | PERF_PMU_CAP_NO_EXCLUDE,
 };
 
 static int __init msr_init(void)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
