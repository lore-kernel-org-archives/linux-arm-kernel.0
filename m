Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D455FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:09:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A70F820867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h4IdXzu5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Awggy/OC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70F820867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=38ZviJRJAozpW1Gj5F1cYN3vdpyBwR7uBF6MwHIL79Q=; b=h4IdXzu5ZVn2Q1
	FexiPFVOLaBW64zVRYydxzHhq7nBPnnU6x/A7MXzrzsyna70BEq9nTEU6Dadrp5DS4USDYXjgR08M
	4EW5nfmJUxFX6X/3T3Y9puYfhd+WUgJnwKXJnzOddlrbKP8J7980tjGQCFjTan1RwFYVlu6/prqUR
	kNoIjd3bh0wPYmxXlchgdOSYarexxYFyoLKBiafTYkr0g61B0K/j2DTxecjdekXdnr4hFki7to0Ah
	r/2zCy2xqZ/tjXoJiJYPHpzp1+lvhT7+m3tLwu9Cp8LYqQn9EbRcSb1kyvTBKzFbsFWPe2CiwOAph
	BwTKGPOXViUdPhEvYxyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSkQ4-0001dZ-Qk; Fri, 30 Nov 2018 15:09:28 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSkQ1-0001cg-I2
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 15:09:27 +0000
Received: by mail-lj1-x241.google.com with SMTP id s5-v6so5265397ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 07:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cevKt/iVwCRv9xli91T/QyVSDidq+ft7LMiFzNhTbQc=;
 b=Awggy/OCtNUr8kqjtPE28UJFmBPZvDO48FDcUcWjDpeHWrRglJpug7qXTQQCvQ05ER
 3mxRE/+7bidUJDNjqD7hHAVoV43JehZ2xsPfFjbcEKATeafqVHOrvmCANLYzYuDpH3r8
 rPB9SO9J5Zarads+PxHl3nlT9XF8dBjrwROTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cevKt/iVwCRv9xli91T/QyVSDidq+ft7LMiFzNhTbQc=;
 b=U/XmL7eMg8Swk0vHBee+vNg1cGhGZXX/+SrdhPulgT9tQgCFrqT5FfDJmQOYrXbstH
 3QQa1/NY4iEO6zsLuLjvHHRx14LvKXd2Z5Ass+L+IaFW/MPWLP1mm06auWtqlfv7xOBm
 WPxOlYrGYsnDXaJsx4t8XDYT/5n8S2iVJ0B6O4OWRn3tftY1Q44CDUVhbVFvBGcfPq9A
 hxovOydOqgJi6Ng/1tl+Q9C+ymf+q16F5q4CkczH7tZVXGk2lX6X0/Hz120C3MBmmZal
 vb3s7OnRVE+6II0iCA+V9cARIfI1hB97Qus5Zx1fUpO87J05Cwb3PWPdq8Nj6u3UD0HD
 vezw==
X-Gm-Message-State: AA+aEWaVyHFfR10pmQmezOI4ckr8tZ9R+bTU1oJmS4XT3lIm5w44EX2j
 V5ybJA0J+rkpfvB7OTjoXAplWA==
X-Google-Smtp-Source: AFSGD/VpYrmoJeyL8d7+PEaIv5jYwhLzngu/YEuvShEtkOCRXOuRE9OyVVKm+SuLrVdW6w4L5WrvSw==
X-Received: by 2002:a2e:568b:: with SMTP id
 k11-v6mr4225309lje.105.1543590553021; 
 Fri, 30 Nov 2018 07:09:13 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se.
 [213.113.33.115])
 by smtp.gmail.com with ESMTPSA id o26sm912850lfl.18.2018.11.30.07.09.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 07:09:12 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: keescook@chromium.org
Subject: [PATCH 1/3] stackleak: mark stackleak_track_stack() as notrace
Date: Fri, 30 Nov 2018 16:08:59 +0100
Message-Id: <20181130150859.27366-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_070925_595120_EAE3044A 
X-CRM114-Status: GOOD (  12.16  )
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
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Function graph tracing recurses into itself when stackleak is enabled,
causing the ftrace graph selftest to run for up to 90 seconds and
trigger the softlockup watchdog.

Breakpoint 2, ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:200
200             mcount_get_lr_addr        x0    //     pointer to function's saved lr
(gdb) bt
\#0  ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:200
\#1  0xffffff80081d5280 in ftrace_caller () at ../arch/arm64/kernel/entry-ftrace.S:153
\#2  0xffffff8008555484 in stackleak_track_stack () at ../kernel/stackleak.c:106
\#3  0xffffff8008421ff8 in ftrace_ops_test (ops=0xffffff8009eaa840 <graph_ops>, ip=18446743524091297036, regs=<optimized out>) at ../kernel/trace/ftrace.c:1507
\#4  0xffffff8008428770 in __ftrace_ops_list_func (regs=<optimized out>, ignored=<optimized out>, parent_ip=<optimized out>, ip=<optimized out>) at ../kernel/trace/ftrace.c:6286
\#5  ftrace_ops_no_ops (ip=18446743524091297036, parent_ip=18446743524091242824) at ../kernel/trace/ftrace.c:6321
\#6  0xffffff80081d5280 in ftrace_caller () at ../arch/arm64/kernel/entry-ftrace.S:153
\#7  0xffffff800832fd10 in irq_find_mapping (domain=0xffffffc03fc4bc80, hwirq=27) at ../kernel/irq/irqdomain.c:876
\#8  0xffffff800832294c in __handle_domain_irq (domain=0xffffffc03fc4bc80, hwirq=27, lookup=true, regs=0xffffff800814b840) at ../kernel/irq/irqdesc.c:650
\#9  0xffffff80081d52b4 in ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:205

Rework so we mark stackleak_track_stack as notrace

Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 kernel/stackleak.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index e42892926244..5de3bf596dd7 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -102,7 +102,7 @@ asmlinkage void stackleak_erase(void)
 	current->lowest_stack = current_top_of_stack() - THREAD_SIZE/64;
 }
 
-void __used stackleak_track_stack(void)
+void __used notrace stackleak_track_stack(void)
 {
 	/*
 	 * N.B. stackleak_erase() fills the kernel stack with the poison value,
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
