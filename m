Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69626C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:46:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36810218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hGHRxpDE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="pG90tigs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36810218EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=48m+OBft/BwNCEw817cg1TIwOlGDXowdiOWUUne3hjQ=; b=hGHRxpDEu2acOG
	rRysnzbh0fMRJD4+DwDmyQre50jaBj6jh81SlBAjN4Fdne7yQR9dDzvARqSLWEURtp1U+qMltgb+G
	DAC1K8gpfvzjDivMBV5qqXn8Ve/IMQ0mfXrnACBVtZ29Q79v7zI3RBBAeb8up21XX7B5UGEfDigio
	emQbhbUTtPU8fNaxnN+iQpsgl4m0nOxaVYtVzJ5dhB/TfRLMInCxycQAXWdoKvRMFg3cbOXia7oF4
	X+dtT6823oqXWhKyI50dFTA2H/ueRXXIvb3DQuj6eFVCEBTIMhisyTnZcxseNgP9NYR7rVNivqUIO
	YoDCEE/iCGOfmFmO/riQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcCJu-0004hf-0N; Wed, 26 Dec 2018 16:46:10 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcCJE-00043P-IU
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 16:45:30 +0000
Received: by mail-qt1-x842.google.com with SMTP id i7so17732015qtj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 08:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=w3KbIJQiIOy8N3UGEAqIqz0OpXOEfKfCNsBPN7OzZGI=;
 b=pG90tigs07wpuGuq2rTMB/CcCulJi9YnbL+1kJRO1c6yL0SozoJNJTn7jUq2uv0wfU
 0t8g37/BhzyS5UiZ/lO0fY4Az2oXeysv2dZptLDNkM4mRTK/8FYY3LhHTMEkGkb3v32N
 SVSYeo1dEevLcJ9SdKFKxKjFLqX3IXZqoR6hOWErdd3Nu0u5JfXJbwsoLfv4WFS00pfO
 u85TqDKnr3pWyZ2yQLRIMDXHPtgS7LCCd9JXQykXLSNvS+jC55DvgB7tybectCRo+8Iz
 oroQK2w5UCz95qLK0A8ngmXfAv6VDcEeAqWQi62l2CTxVIdr09LvDVFBNjWaiGvlQ6qu
 WT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w3KbIJQiIOy8N3UGEAqIqz0OpXOEfKfCNsBPN7OzZGI=;
 b=QsGU8J9fbN2sw8Kx8bP2pphAcz1TJazxUGXu7io3CzmHcFDRokM2Pn2ytBKWqPWs6k
 CXiWEm4ClYhPZRTGGEiq0rU41o8QKZu5MP/R/Z/P+HwO2NFTWenwfGZdu14pB4OvLEup
 IS+3Wrmg78ZvQ4364Rny4X/YzKqkBiKrqtrYKAaDEM4vnOdaDJ8+TDPLoSTeg433zuvL
 Y+dCPiPbX4euc9wn1y18kBbTEv6nvxbb/PQbqg8Dh3cqirUgSRU8DjchPzJQZuYv8hcB
 I9G4fAVXISGVQU0F3YQoZ9VKo18TC9kSTFGIib+rtMiNQ3Jll/CvlIH/re4HHcfzDpmu
 LEMg==
X-Gm-Message-State: AJcUukcpq1Nus4TH6z+uc+Z8rbnRN1BEuHshDHQlUZONaEXOxKPeO5/J
 ++wsR7IUeVvGdeoMrKliT5C6JQ==
X-Google-Smtp-Source: AFSGD/UIqZDh/l43NNC/5cSPHlmqbsSACc21s6yjEK3DUaREi7HP/Ds2QeOZzJnO1QuQ+Lnr3yYz3A==
X-Received: by 2002:ac8:2a06:: with SMTP id k6mr19372341qtk.245.1545842715640; 
 Wed, 26 Dec 2018 08:45:15 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net.
 [73.69.118.222])
 by smtp.gmail.com with ESMTPSA id m41sm17874920qtc.58.2018.12.26.08.45.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Dec 2018 08:45:15 -0800 (PST)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
To: catalin.marinas@arm.com, will.deacon@arm.com, akpm@linux-foundation.org,
 rppt@linux.vnet.ibm.com, mhocko@suse.com, ard.biesheuvel@linaro.org,
 andrew.murray@arm.com, james.morse@arm.com, marc.zyngier@arm.com,
 sboyd@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com
Subject: [PATCH v3 3/3] arm64: Early boot time stamps
Date: Wed, 26 Dec 2018 11:45:09 -0500
Message-Id: <20181226164509.22916-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181226164509.22916-1-pasha.tatashin@soleen.com>
References: <20181226164509.22916-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_084528_891447_4457AA96 
X-CRM114-Status: GOOD (  11.60  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Allow printk time stamps/sched_clock() to be available from the early
boot.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/setup.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 4b0e1231625c..28126facc4ed 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -40,6 +40,7 @@
 #include <linux/efi.h>
 #include <linux/psci.h>
 #include <linux/sched/task.h>
+#include <linux/sched_clock.h>
 #include <linux/mm.h>
 
 #include <asm/acpi.h>
@@ -279,8 +280,32 @@ arch_initcall(reserve_memblock_reserved_regions);
 
 u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
 
+/*
+ * Get time stamps available early in boot, useful to identify boot time issues
+ * from the early boot.
+ */
+static __init void sched_clock_early_init(void)
+{
+	u64 (*read_time)(void) = arch_counter_get_cntvct;
+	u64 freq = arch_timer_get_cntfrq();
+
+	/*
+	 * The arm64 boot protocol mandates that CNTFRQ_EL0 reflects
+	 * the timer frequency. To avoid breakage on misconfigured
+	 * systems, do not register the early sched_clock if the
+	 * programmed value if zero. Other random values will just
+	 * result in random output.
+	 */
+	if (!freq)
+		return;
+
+	sched_clock_register(read_time, ARCH_TIMER_NBITS, freq);
+}
+
 void __init setup_arch(char **cmdline_p)
 {
+	sched_clock_early_init();
+
 	init_mm.start_code = (unsigned long) _text;
 	init_mm.end_code   = (unsigned long) _etext;
 	init_mm.end_data   = (unsigned long) _edata;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
