Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570FFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:11:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216A22173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G6QG5jj+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="03aEGsGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216A22173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=bWjLJ5nWRuQfL5cBbLnGErTYTdI7LN65UeTw9Rxzwf8=; b=G6QG5jj+4Q9PYgGqECH+T5Z3Cv
	BvkZt/vg5E2fd0iogqsuP2b/4S+vtA760l/n5v9zsQnPOv4Gz2fM50pLDL3lyslYoMmEOzOZoFuh2
	omQivkdTvmmqdyKCQzHbTzCCNl9e60es5ytb6drQbtQINYMS7j60HdcFPunHpGWUVNrWUbEr/YVFS
	h7G0HD9pyS0UYjucg1+472tWB6OSTXdSGdGs47xPXfB3sZ9d7b3GCpM+tJNw+M36OB/uCazP3rPKp
	5Gw+6ZbzMNkbR70y3/bF0se9VjxYu/CIfAmMeJPH7uIe6OGGNBfNu065VJ8xlUhw0TAZIYuKNEq0C
	rbGg0bQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggYQe-0007Kd-RT; Mon, 07 Jan 2019 17:11:08 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggYQd-0007KM-Dn
 for linux-arm-kernel@bombadil.infradead.org; Mon, 07 Jan 2019 17:11:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i+PqXO072Eyix07CoDDBZK4bnWca3tDEnKhp/TAz9Mw=; b=03aEGsGDqWV/nNFYNYzetp2GC
 AK19qAnUtPibwxz1pib8n0xE0PQU9cI8OKbhWT5/1nwYjX7r2CP6BcyNxlbtbuoQ/0rt0begtgCa0
 3yJsCtSE1evDXMhVv+b9LUaoLnU8w+k2LLNW7f579qIm/0p4lFSTcAI0shAn5GurEyHsXPbcN/Cc6
 Uo7tQwWvvDMa3BIgj7RVmRJVvPZmid263sNAHhS1ScUHltULr2RgnPjCNk9/HaMLBsuQutjraiDcR
 sSbvzSV34mgsSA4OpAsqc+YOWMV6RRyk1bCeo+beHfIJ0/sgusdt3JJ0hQRGMDc7eMPohbKSZQ9qp
 zmUjfe6fQ==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggXlV-0006TL-T1
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 16:28:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 141621688;
 Mon,  7 Jan 2019 08:28:34 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92C713F5A0;
 Mon,  7 Jan 2019 08:28:29 -0800 (PST)
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
Subject: [PATCH v4 11/13] x86: perf/core: use PERF_PMU_CAP_NO_EXCLUDE for
 exclude incapable PMUs
Date: Mon,  7 Jan 2019 16:27:28 +0000
Message-Id: <1546878450-20341-12-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
References: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_112838_097565_9083B9B4 
X-CRM114-Status: GOOD (  18.59  )
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

For x86 PMUs that do not support context exclusion let's advertise the
PERF_PMU_CAP_NO_EXCLUDE capability. This ensures that perf will
prevent us from handling events where any exclusion flags are set.
Let's also remove the now unnecessary check for exclusion flags.

This change means that amd/iommu and amd/uncore will now also
indicate that they do not support exclude_{hv|idle} and intel/uncore
that it does not support exclude_{guest|host}.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/x86/events/amd/iommu.c    | 6 +-----
 arch/x86/events/amd/uncore.c   | 7 ++-----
 arch/x86/events/intel/uncore.c | 9 +--------
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 3210fee..7635c23 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -223,11 +223,6 @@ static int perf_iommu_event_init(struct perf_event *event)
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
-	/* IOMMU counters do not have usr/os/guest/host bits */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_host || event->attr.exclude_guest)
-		return -EINVAL;
-
 	if (event->cpu < 0)
 		return -EINVAL;
 
@@ -414,6 +409,7 @@ static const struct pmu iommu_pmu __initconst = {
 	.read		= perf_iommu_read,
 	.task_ctx_nr	= perf_invalid_context,
 	.attr_groups	= amd_iommu_attr_groups,
+	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 };
 
 static __init int init_one_iommu(unsigned int idx)
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 398df6e..79cfd3b 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -201,11 +201,6 @@ static int amd_uncore_event_init(struct perf_event *event)
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
-	/* NB and Last level cache counters do not have usr/os/guest/host bits */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_host || event->attr.exclude_guest)
-		return -EINVAL;
-
 	/* and we do not enable counter overflow interrupts */
 	hwc->config = event->attr.config & AMD64_RAW_EVENT_MASK_NB;
 	hwc->idx = -1;
@@ -307,6 +302,7 @@ static struct pmu amd_nb_pmu = {
 	.start		= amd_uncore_start,
 	.stop		= amd_uncore_stop,
 	.read		= amd_uncore_read,
+	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 };
 
 static struct pmu amd_llc_pmu = {
@@ -317,6 +313,7 @@ static struct pmu amd_llc_pmu = {
 	.start		= amd_uncore_start,
 	.stop		= amd_uncore_stop,
 	.read		= amd_uncore_read,
+	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 };
 
 static struct amd_uncore *amd_uncore_alloc(unsigned int cpu)
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 27a4614..d516161 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -695,14 +695,6 @@ static int uncore_pmu_event_init(struct perf_event *event)
 	if (pmu->func_id < 0)
 		return -ENOENT;
 
-	/*
-	 * Uncore PMU does measure at all privilege level all the time.
-	 * So it doesn't make sense to specify any exclude bits.
-	 */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-			event->attr.exclude_hv || event->attr.exclude_idle)
-		return -EINVAL;
-
 	/* Sampling not supported yet */
 	if (hwc->sample_period)
 		return -EINVAL;
@@ -800,6 +792,7 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
 			.stop		= uncore_pmu_event_stop,
 			.read		= uncore_pmu_event_read,
 			.module		= THIS_MODULE,
+			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 		};
 	} else {
 		pmu->pmu = *pmu->type->pmu;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
