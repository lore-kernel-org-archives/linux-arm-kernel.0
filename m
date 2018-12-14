Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C4DC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:08:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93ECA2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rg5Nhe7h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="KiTlePbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93ECA2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Jhqz55r0VFJqPsj0KJKxFKHvWno96+cKhavBccHEkzE=; b=Rg5Nhe7h2DrPmNkMd9hvDDkowG
	BVU/1fHv93Nu0QFrhlKHyRhXNedtbbzs/Rho0qJOBKNlyaFgGGOO89rgj38iut0RiI2btqQY3bijU
	VRY0vLEJWzy6BmwEl3nZgVRHyQ77ccsV74yqEn+gpCVm9LPE1wNiPXi3HvfIC+67ngJFJLz23LAi/
	uTZ93yMdrzpTHEfvEWcjdBytX2l7mBkEHsrsVOJq1Sihn9LKY4H/VtefrPC0086UfAVT8gz2JODT3
	DWyuKCPfizCOJyUUNT0N+/yO4ISch9g/NBWGBABcOQNCFPfpMQ7Fxo6kamVo7PHBF2rXTEUQZwgPQ
	Z6XAWr9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXemQ-0008A3-Cf; Fri, 14 Dec 2018 04:08:50 +0000
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXemN-000892-Az
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 04:08:48 +0000
Received: by mail-qk1-x744.google.com with SMTP id q8so332988qke.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 20:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WVG1s8uPH9QZYQD2OxlIfEzK4+hEPnhFvyzAce4PHvA=;
 b=KiTlePbBFxTtN7GPW74DQYa3U94/yABfYM3zZIOuI69NzSPIQBYAzaShj+ppeMi+WH
 Ex5BlTolbeCmfdDOTUZGrMHUp0HhkKFVlx9gesOnb2GaI0rY28SoyqaNtYZO3NFWSYes
 o/rIvaOz7G8sxScqFfBnO5cqGsShimouIf374zek1l3VlKdWppY9msOLDxMKLuaDzhi6
 aQJ+Q5XmZR0+TnkbaOatMAOmhbuBkIAQEtkJbK+W+mT79gDOuDik9SehQ17AhlPEz4AY
 4A2aPewPqCIdYjz9IsQXN9ezSpHpWPfcYFjRYjFvwdV7SwAtCkLfqW8o+9Ye52J2aI6o
 058w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WVG1s8uPH9QZYQD2OxlIfEzK4+hEPnhFvyzAce4PHvA=;
 b=sVKrQoFIa1VCbxfuS5xC7eLYIwm36hS3UsCytHYLWWnyyegxtpr28IA3S9ISulX1Pz
 jya8oi+yDljDQKI3uAfRG89jOUal91Z7xqse3i3q2Af0ISjmdTFu9lsBCmwG8pBD8HTw
 El/zFA3zOs0nRm3jefh60IoajJjZk4DYJ720MQixey6k7P2RK4LvXysNWUs1+3OZP18z
 wKWJvfzf34RC/ZrWx+U+jacUiyJIfnadS1sfWg+Ba8MqDRquGPyFIZH4jqYPXYjl2hKh
 H7Xym+bUqhwKt2Me6C+XCFc73V0h88vX+iuzBOb7Z6kAy3uHYbhKj9EuEA0OmPg2aT8k
 JhCg==
X-Gm-Message-State: AA+aEWZZJ14ZLX+xOsZ/9jpuzmhdKcJL1YwvB8j3AdflneUYalaMl9fn
 sggg504LQ9A9zn3yHH3egxkvmw==
X-Google-Smtp-Source: AFSGD/VfQUhFS+ZhtP6Rq287/qYBYAPaa8NsHUt0SEnoxZvu1baeVGS/bEtXoSh5T/Ub1wfMeq/ycA==
X-Received: by 2002:a37:2e42:: with SMTP id u63mr1208090qkh.249.1544760515746; 
 Thu, 13 Dec 2018 20:08:35 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id a185sm2201187qkb.1.2018.12.13.20.08.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Dec 2018 20:08:35 -0800 (PST)
From: Qian Cai <cai@lca.pw>
To: catalin.marinas@arm.com,
	will.deacon@arm.com
Subject: [PATCH v2] arm64: invalidate TLB just before turning MMU on
Date: Thu, 13 Dec 2018 23:08:19 -0500
Message-Id: <20181214040819.58625-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20181213052259.56352-1-cai@lca.pw>
References: <20181213052259.56352-1-cai@lca.pw>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_200847_376633_6C5CB283 
X-CRM114-Status: GOOD (  15.14  )
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
Cc: ard.biesheuvel@linaro.org, marc.zyngier@arm.com, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, takahiro.akashi@linaro.org, james.morse@arm.com,
 Qian Cai <cai@lca.pw>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On this HPE Apollo 70 arm64 server with 256 CPUs, triggering a crash
dump just hung. It has 4 threads on each core. Each 2-core share a same
L1 and L2 caches, so that is 8 CPUs shares those. All CPUs share a same
L3 cache.

It turned out that this was due to the TLB contained stale entries (or
uninitialized junk which just happened to look valid) before turning the
MMU on in the second kernel which caused this instruction hung,

msr	sctlr_el1, x0

Although there is a local TLB flush in the second kernel in
__cpu_setup(), it is called too early. When the time to turn the MMU on
later, the TLB is dirty again from some reasons.

Also tried to move the local TLB flush part around a bit inside
__cpu_setup(), although it did complete kdump some times, it did trigger
"Synchronous Exception" in EFI after a cold-reboot fairly often that
seems no way to recover remotely without reinstalling the OS. For
example, in those places,

ENTRY(__cpu_setup)
+	isb
	tlbi	vmalle1
	dsb	nsh

or

	mov	x0, #3 << 20
	msr	cpacr_el1, x0
+	tlbi    vmalle1
+	dsb     nsh

Since it is only necessary to flush local TLB right before turning the
MMU on, just re-arrage the part a bit like the one in __primary_switch()
within CONFIG_RANDOMIZE_BASE path, so it does not depends on other
instructions in between that could pollute the TLB, and it no longer
trigger "Synchronous Exception" as well.

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: merge the similar part from __cpu_setup() pointed out by James.

 arch/arm64/kernel/head.S | 4 ++++
 arch/arm64/mm/proc.S     | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4471f570a295..7f555dd4577e 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -771,6 +771,10 @@ ENTRY(__enable_mmu)
 	msr	ttbr0_el1, x2			// load TTBR0
 	msr	ttbr1_el1, x1			// load TTBR1
 	isb
+
+	tlbi	vmalle1				// invalidate TLB
+	dsb	nsh
+
 	msr	sctlr_el1, x0
 	isb
 	/*
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 2c75b0b903ae..14f68afdd57f 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -406,9 +406,6 @@ ENDPROC(idmap_kpti_install_ng_mappings)
  */
 	.pushsection ".idmap.text", "awx"
 ENTRY(__cpu_setup)
-	tlbi	vmalle1				// Invalidate local TLB
-	dsb	nsh
-
 	mov	x0, #3 << 20
 	msr	cpacr_el1, x0			// Enable FP/ASIMD
 	mov	x0, #1 << 12			// Reset mdscr_el1 and disable
-- 
2.17.2 (Apple Git-113)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
