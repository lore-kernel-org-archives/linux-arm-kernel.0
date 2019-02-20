Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884FEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:55:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 572E82075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k3QImPRs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="UYFX0F0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572E82075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=k5n2eX3AAy2FPGm7iACQfmHiBuU6gyDRzRqiHqc+pSo=; b=k3QImPRsxnLvwH
	QZPOwcRzK55Ld76QSU1IiYYrmMJl2jy5T8SlXVMXiHMrbjOAzgxfn5Enwd24aVyypLipiBRX6jpgz
	UTxvDxnxWDOWb0uL1rpc8oIjrNxBzFd2dXMd8iyROGONbGWFwpJVeIE4wHgobkzijLs36a0eqU/s7
	1bx3iFLas53+N9igrOkFXN9J41gWGkRbH01mFNh23xu/1knPphOxg+5BEx1R3LKmUoEJdH45X7vL+
	UjrriXIaiA7G/bmD/e3df510rc9tXEwhWrx4JlfbgtWv+8HfH1KAqFw78/gK57hU3p3yAkrMccmUK
	aGNC5rqgHO4J06ZAYYmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwUDX-0007Op-V8; Wed, 20 Feb 2019 15:55:27 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwUDU-0007OT-PV
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 15:55:26 +0000
Received: by mail-wr1-x443.google.com with SMTP id i12so26654240wrw.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 07:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WYT38OLrPVg9S6X2MhbH3YDUija7usseRIKSRWILMjE=;
 b=UYFX0F0OThw7N0PyeqCyt0irylizzHeD9kLgxsa8k+zjiaCPAzarRJ/HkE6XJ9KCjk
 lKxBE5kvHvbEjQZUTewsDE0gcg0U9ddWJ11dhS2mUWkEsSaQGYh9dcJVnMXk1rRhWx0V
 796niuhMXoifCIGOX3KHMZgkigOQIoQgBXD3LklyqToxv8aMxOKMXHU6JbnZlgDE59Qf
 Edc8+Mb4a7tCtVUcPONrdth2cPdbDKf5K/toe5YIpkMrrLA6RYiiAYUnxD0QsLWlBQOW
 Xv5cvVvJaUiSehf0vBMlnbvASYBXSUc+rxERYW7IF4up0ZjC2UtZM5FqtQzE2a2zGrph
 EKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WYT38OLrPVg9S6X2MhbH3YDUija7usseRIKSRWILMjE=;
 b=WRf6mc0CXRnfCy1JdQbDXR7TkW5wpZGuKVl5mFTPiSoVZrI2txZUaKqwi83wXtw4/L
 9nLFkFPxEsZEDb+2dtVyblDUX+3VAprByEngVjD7E+ZeRY8pV+wbN6HsYEBoPvwkrsb7
 3uxx/lG5CUyWwGG5fuQyam5knapWNJT2qFOgfwj3mQoq05F85Ly019qMKU+otxmNGZT2
 jDc8DpwVqFpNz2MLMDY1aVeJj5uq6bScoGTOof8ejsgtkesp/fx8rb7ayD+U4EbD7AnD
 JIyK96PyWCoPopAQqTP5cOckwwADbbRYT+UkzRbknMiR4kiirnYYXQ1EFI5/nhy5auN6
 Vozw==
X-Gm-Message-State: AHQUAuaPjKN83Fjwlh+lbYQvwNiOqkA2eURI8VTgjBY1L6OJ5TdFFhFI
 lg6eB2NIUC0MtZYfEauLKz2vgw==
X-Google-Smtp-Source: AHgI3Ib7iotiEeNe3DMKzry1okFfh8qa+obGm4GtHqr2CY6I9l57NhS0zMjAvSlHCbguN8qtlDB2wQ==
X-Received: by 2002:adf:f305:: with SMTP id i5mr19396335wro.161.1550678122707; 
 Wed, 20 Feb 2019 07:55:22 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com
 ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
 by smtp.gmail.com with ESMTPSA id r15sm23730158wrt.37.2019.02.20.07.55.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 Feb 2019 07:55:21 -0800 (PST)
From: Andrey Konovalov <andreyknvl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrey Konovalov <andreyknvl@google.com>,
 Miles Chen <miles.chen@mediatek.com>, James Morse <james.morse@arm.com>,
 Andrew Murray <andrew.murray@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org
Subject: [PATCH] kasan: fix random seed generation for tag-based mode
Date: Wed, 20 Feb 2019 16:55:18 +0100
Message-Id: <1f815cc914b61f3516ed4cc9bfd9eeca9bd5d9de.1550677973.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_075524_823975_1EA1CF8B 
X-CRM114-Status: GOOD (  15.20  )
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
Cc: Kostya Serebryany <kcc@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Qian Cai <cai@lca.pw>,
 Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There are two issues with assigning random percpu seeds right now:

1. We use for_each_possible_cpu() to iterate over cpus, but cpumask is
   not set up yet at the moment of kasan_init(), and thus we only set
   the seed for cpu #0.

2. A call to get_random_u32() always returns the same number and produces
   a message in dmesg, since the random subsystem is not yet initialized.

Fix 1 by calling kasan_init_tags() after cpumask is set up.

Fix 2 by using get_cycles() instead of get_random_u32(). This gives us
lower quality random numbers, but it's good enough, as KASAN is meant to
be used as a debugging tool and not a mitigation.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/kernel/setup.c  | 3 +++
 arch/arm64/mm/kasan_init.c | 2 --
 mm/kasan/tags.c            | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index d09ec76f08cf..009849328289 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -339,6 +339,9 @@ void __init setup_arch(char **cmdline_p)
 	smp_init_cpus();
 	smp_build_mpidr_hash();
 
+	/* Init percpu seeds for random tags after cpus are set up. */
+	kasan_init_tags();
+
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 	/*
 	 * Make sure init_thread_info.ttbr0 always generates translation
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 4b55b15707a3..f37a86d2a69d 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -252,8 +252,6 @@ void __init kasan_init(void)
 	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 
-	kasan_init_tags();
-
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
 	pr_info("KernelAddressSanitizer initialized\n");
diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
index 0777649e07c4..63fca3172659 100644
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -46,7 +46,7 @@ void kasan_init_tags(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		per_cpu(prng_state, cpu) = get_random_u32();
+		per_cpu(prng_state, cpu) = (u32)get_cycles();
 }
 
 /*
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
