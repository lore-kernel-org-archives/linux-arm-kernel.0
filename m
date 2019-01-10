Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD0BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:12:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68AD4214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LVUITy6A";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eW8EvGum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AD4214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=UGcQoDoWpRL3KNIvK3llthEcyFlHgkmD5TS7EI33Y8U=; b=LVUITy6AG7D3ESyRUniQhwHAdu
	ikHX45rfvvOgH9DSLCiaoIHQCC1wupd3cH97Ap7g5X+I4VSblFqw9nHQ7nDJZHDI72WNxjo75uWqS
	KuAhVh8Iu8kgFTV/BuNlS2MZT1KDvrmtgFiKjz4x7Sj5zgnwa7OOSH+8jeAWgPZTKiHj1AxOQWEZl
	0x3gs/W8UoujSTIZLB90dJ+gRbelJo0oFZpyEQjnnUNOaV2rmRCLlo99doxxJCI41K5iCemAi3Bsx
	dKk79a7TW/6g4RQuwcQ/Z7A93e2b9NsqzSvyTJCpk43JjO9m6TWkPywhBlG5zFtUCIFeN3SvEDsOw
	U6R2CdwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghb4W-0008IS-0m; Thu, 10 Jan 2019 14:12:36 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghb3a-0007Bt-5U
 for linux-arm-kernel@bombadil.infradead.org; Thu, 10 Jan 2019 14:11:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ik+EAB54T9RQFtkpbycqvLuiqEhoguYJpEw8OUm68RU=; b=eW8EvGumCStUojsRax5jUHOCk
 w3dcb9o8qxjc+OwJ/cEE4f1jIyaRWT/E2C2luMo93OlmYOgTd1IbDnZjHn2dDChbGk3xolk0XSuix
 sTv0d8UI92t32oFsjsKYDvsS+mFgaCAXTGGEh2xkQfC2lKjX14ukEUO25tAJClgyMTEMUKO8rMSGs
 E1KMVs6sUlR+bR+yLJ+vSMUm+4oYue62nNMfAXmr3+2caPLxahk31RAYgwPCwtsE3DfWwnsGz8diT
 rW8qxgR7Mp19ifW+DrhbfmLzWOl+mNDQ7aQ2vdMO9GikQpC+OaAI5aLGzKcjjZxour88OmkfeMWTl
 CZ2AWivgA==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghamf-0006Jf-QD
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 13:54:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A1B21596;
 Thu, 10 Jan 2019 05:54:09 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEFBA3F5AF;
 Thu, 10 Jan 2019 05:54:04 -0800 (PST)
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
Subject: [PATCH v5 05/12] arm: perf: conditionally use PERF_PMU_CAP_NO_EXCLUDE
Date: Thu, 10 Jan 2019 13:53:27 +0000
Message-Id: <1547128414-50693-6-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547128414-50693-1-git-send-email-andrew.murray@arm.com>
References: <1547128414-50693-1-git-send-email-andrew.murray@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_135410_037242_9AF0551C 
X-CRM114-Status: GOOD (  16.78  )
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

The ARM PMU driver can be used to represent a variety of ARM based
PMUs. Some of these PMUs do not provide support for context
exclusion, where this is the case we advertise the
PERF_PMU_CAP_NO_EXCLUDE capability to ensure that perf prevents us
from handling events where any exclusion flags are set.

Where an ARM PMU driver has the set_event_filter function implemented,
we rely on it to perform exclusion checks. At present some of these
functions do not test for all of the available exclude flags.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index d0b7dd8..eec75b9 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -357,13 +357,6 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 }
 
 static int
-event_requires_mode_exclusion(struct perf_event_attr *attr)
-{
-	return attr->exclude_idle || attr->exclude_user ||
-	       attr->exclude_kernel || attr->exclude_hv;
-}
-
-static int
 __hw_perf_event_init(struct perf_event *event)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
@@ -393,9 +386,8 @@ __hw_perf_event_init(struct perf_event *event)
 	/*
 	 * Check whether we need to exclude the counter from certain modes.
 	 */
-	if ((!armpmu->set_event_filter ||
-	     armpmu->set_event_filter(hwc, &event->attr)) &&
-	     event_requires_mode_exclusion(&event->attr)) {
+	if (armpmu->set_event_filter &&
+	    armpmu->set_event_filter(hwc, &event->attr)) {
 		pr_debug("ARM performance counters do not support "
 			 "mode exclusion\n");
 		return -EOPNOTSUPP;
@@ -867,6 +859,9 @@ int armpmu_register(struct arm_pmu *pmu)
 	if (ret)
 		return ret;
 
+	if (!pmu->set_event_filter)
+		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_EXCLUDE;
+
 	ret = perf_pmu_register(&pmu->pmu, pmu->name, -1);
 	if (ret)
 		goto out_destroy;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
