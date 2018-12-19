Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B666BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:31:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C1452070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JEaHw8Xw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z7Y2Kz6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1452070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/1Eu1zp1etKi28GWb19F0wx8FAYiBruqYePIH6qMcA8=; b=JEaHw8XweO9DCC
	dszbPN9XoSNnZCKWD9eIjh2espPiNroFI+GdspLIHF4G1OtSacgZN4ORjpQca00pFr2Us9V9w9Fsq
	hy3zsdY+6PlvMnh4Pmob24VPP7xN30QQ1Tkb9O0d+gq0aNBkCWkD4FzVrLEZ9LHLbCkrFUGAK7qp8
	7aU+4+ZrFzWvK4nEhN3I9sh99S0qcf37mcDaLedUd1FewbCmV7zak5Fs9ilq4XzJMTbgqMrHFnPqr
	3+labA65oN7U0PEaZ8cuLddFL3QEbo8aiB7esnGjz5Zkvnj6aW12tPQbcJSKi7H1qCVd7daKa9KA5
	GeZPgBGp8lgg009/tmiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZgdG-0006LW-Hq; Wed, 19 Dec 2018 18:31:46 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgdE-0006KA-P5
 for linux-arm-kernel@bombadil.infradead.org; Wed, 19 Dec 2018 18:31:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eVscD0o+TLlHgKOb9EpPKu2KWCP7GAec8XwKON229Mw=; b=Z7Y2Kz6YT0+UOgzXz6OQAn3tGf
 kHKnRQVPrjjOyWC5CQ9nceRL+bakfsIZ11lGR/tkih6SqWzTyFAAocXbXl2z+XBKnCSXTZhbmGz/w
 kQV/zL+USaLXpC2+sc7D+/3D/eRVs8Rw5CWVXCWBasIibFmUinLWFMXI5MJCFJJnxqLQ81BRbck5h
 WgilhOe63CAUMeRmFetQ1pNB/lUv0w4rxRSMYoW1gR/yUGdYtaUc2Im8dAg6fxfOY+++SpE4o6LLK
 9VNxz+4jdVnKDfx6AEcZdMzlKxnQ+lb5GaD0cQfUMpJsIDdJSwbLYfKUpTY2uXHDuMFHTiBIgIhVH
 kx2QdDHw==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgDs-0000VF-OR
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 18:05:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 772CE1684;
 Wed, 19 Dec 2018 10:05:24 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBD5C3F675;
 Wed, 19 Dec 2018 10:05:21 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 27/28] arm/arm64: KVM: Add ARM_EXCEPTION_IS_TRAP macro
Date: Wed, 19 Dec 2018 18:03:48 +0000
Message-Id: <20181219180349.242681-28-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219180349.242681-1-marc.zyngier@arm.com>
References: <20181219180349.242681-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_130532_913815_CC5BBF22 
X-CRM114-Status: GOOD (  13.47  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Punit Agrawal <punit.agrawal@arm.com>,
 kvm@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
 "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 linux-arm-kernel@lists.infradead.org, punitagrawal@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvmarm@lists.cs.columbia.edu, Suzuki Poulose <suzuki.poulose@arm.com>,
 Lukas Braun <koomi@moshbit.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

32 and 64bit use different symbols to identify the traps.
32bit has a fine grained approach (prefetch abort, data abort and HVC),
while 64bit is pretty happy with just "trap".

This has been fine so far, except that we now need to decode some
of that in tracepoints that are common to both architectures.

Introduce ARM_EXCEPTION_IS_TRAP which abstracts the trap symbols
and make the tracepoint use it.

Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_asm.h   | 4 ++++
 arch/arm64/include/asm/kvm_asm.h | 1 +
 virt/kvm/arm/trace.h             | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index 231e87ad45d5..35491af87985 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -23,6 +23,10 @@
 
 #define ARM_EXIT_WITH_ABORT_BIT  31
 #define ARM_EXCEPTION_CODE(x)	  ((x) & ~(1U << ARM_EXIT_WITH_ABORT_BIT))
+#define ARM_EXCEPTION_IS_TRAP(x)					\
+	(ARM_EXCEPTION_CODE((x)) == ARM_EXCEPTION_PREF_ABORT	||	\
+	 ARM_EXCEPTION_CODE((x)) == ARM_EXCEPTION_DATA_ABORT	||	\
+	 ARM_EXCEPTION_CODE((x)) == ARM_EXCEPTION_HVC)
 #define ARM_ABORT_PENDING(x)	  !!((x) & (1U << ARM_EXIT_WITH_ABORT_BIT))
 
 #define ARM_EXCEPTION_RESET	  0
diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index b2e12c99db7d..f5b79e995f40 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -25,6 +25,7 @@
 
 #define ARM_EXIT_WITH_SERROR_BIT  31
 #define ARM_EXCEPTION_CODE(x)	  ((x) & ~(1U << ARM_EXIT_WITH_SERROR_BIT))
+#define ARM_EXCEPTION_IS_TRAP(x)  (ARM_EXCEPTION_CODE((x)) == ARM_EXCEPTION_TRAP)
 #define ARM_SERROR_PENDING(x)	  !!((x) & (1U << ARM_EXIT_WITH_SERROR_BIT))
 
 #define ARM_EXCEPTION_IRQ	  0
diff --git a/virt/kvm/arm/trace.h b/virt/kvm/arm/trace.h
index f21f04f8036d..3828beab93f2 100644
--- a/virt/kvm/arm/trace.h
+++ b/virt/kvm/arm/trace.h
@@ -37,7 +37,7 @@ TRACE_EVENT(kvm_exit,
 
 	TP_fast_assign(
 		__entry->ret			= ARM_EXCEPTION_CODE(ret);
-		__entry->esr_ec = (ARM_EXCEPTION_CODE(ret) == ARM_EXCEPTION_TRAP) ? esr_ec : 0;
+		__entry->esr_ec = ARM_EXCEPTION_IS_TRAP(ret) ? esr_ec : 0;
 		__entry->vcpu_pc		= vcpu_pc;
 	),
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
