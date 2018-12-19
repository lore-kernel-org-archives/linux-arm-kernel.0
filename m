Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300C9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:24:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C97B720989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SN1yPiVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97B720989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=UApyTdUEgYYkMA6dKtCvr4tl6bhR8Z2u/l1IJ1xUaTA=; b=SN1yPiVbh49X0jE3ar4b+brQGk
	incDP2euyNAXvmPbqi8Y/Sy4czq/hM0wWY9sYJeywl2HGwUFJLkeuThfzQ3UvGiztDFaTiZYj+4U/
	WJcn53ClyzpXTyLOGiuYzomf0V85cIq/stqLmhHHGXJqRYYDPqlpFLcZBzB+3uw32Mh26WWDq65HV
	fG95KbDrc9i2aCDqo6jMc1guzjdF5JBnZivqthUQYz/7mr7CN9JTQDh/2wnyLTgUrpUCX3Jsx7fKa
	aKtkzPGgl9Qih8htqf1EM83w3R8Cfq527SLyiNz57a+Ng8m8rtU0vywOw0o9dtPqNwchhyYzT3Pk+
	/JqBML9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZgWZ-0002yK-UK; Wed, 19 Dec 2018 18:24:51 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgW2-0002Tq-84
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 18:24:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F72F15BE;
 Wed, 19 Dec 2018 10:24:12 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com
 [10.1.194.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 716353F59C;
 Wed, 19 Dec 2018 10:24:10 -0800 (PST)
From: Valentin Schneider <valentin.schneider@arm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Revert "sched/core: Take the hotplug lock in
 sched_init_smp()"
Date: Wed, 19 Dec 2018 18:23:16 +0000
Message-Id: <1545243796-23224-3-git-send-email-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545243796-23224-1-git-send-email-valentin.schneider@arm.com>
References: <1545243796-23224-1-git-send-email-valentin.schneider@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_102418_300607_D27DF19D 
X-CRM114-Status: GOOD (  12.32  )
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
Cc: mark.rutland@arm.com, cai@gmx.us, marc.zyngier@arm.com,
 daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, peterz@infradead.org,
 longman@redhat.com, tglx@linutronix.de, mingo@kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This reverts commit 40fa3780bac2b654edf23f6b13f4e2dd550aea10.

Now that we have a system-wide muting of hotplug lockdep during init,
this is no longer needed.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e4ca15d..144b778 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5854,14 +5854,11 @@ void __init sched_init_smp(void)
 	/*
 	 * There's no userspace yet to cause hotplug operations; hence all the
 	 * CPU masks are stable and all blatant races in the below code cannot
-	 * happen. The hotplug lock is nevertheless taken to satisfy lockdep,
-	 * but there won't be any contention on it.
+	 * happen.
 	 */
-	cpus_read_lock();
 	mutex_lock(&sched_domains_mutex);
 	sched_init_domains(cpu_active_mask);
 	mutex_unlock(&sched_domains_mutex);
-	cpus_read_unlock();
 
 	/* Move init over to a non-isolated CPU */
 	if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_DOMAIN)) < 0)
--
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
