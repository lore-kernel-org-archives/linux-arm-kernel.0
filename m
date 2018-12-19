Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52599C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:32:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23EF120672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ghkqBWpo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bGABbsOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23EF120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bSdOE+ngpv/F+1Vm3JlmPVyzESMlPVgtIFCV1YAFvOg=; b=ghkqBWpodNY8/6
	Oiayqo+FFlam6LOksBQZGPH7VkU0aB+xM5C4Y+rgfm02Z+sREsbXgIIujbnO2lPpk3gYeueDKQX0n
	oHl71QCdyqKxs45mmqbBUqMN+gtAJrpffNls/xUIc4gykgLAOy/F1+WlX9Pod3FFXb4vIWB9+1b0i
	My3rJxmeSjWvu16pcvoScO/rLTtBhMbEJU/x+46diopsLRA/micQNjQ+Qs5CIlHANO9JN/NpZ/UN1
	xosrrohPPeav4Rsypi9GH2L0o/hFgHWcejxDvvEHrkZKqjafhh4u2XExY/l8JRcpGePA5G2MJegFD
	j+2sbJoUqF9HFJFcFhIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZgdo-0006nH-MI; Wed, 19 Dec 2018 18:32:20 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgdJ-0006KA-6L
 for linux-arm-kernel@bombadil.infradead.org; Wed, 19 Dec 2018 18:31:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BXWhHuhX+x4xBADO7N5ADK+bYV4iMSFeePIA2K3GFiE=; b=bGABbsOYJieZZFRB5hShdhBYxR
 CQU5xNiDpunLrV/PY9plic4fob6n1pOHQlJappESejsCLR/TO+zlTuSZDXRvEuwztW2vt4JFDX9/j
 EKwd6lpY5V4E6O2Jmhg5y8vxoZXISSH3q0HYw44J7rqc0sWK7o6GiiytJHHE1BK3v3GafNRHlH7iS
 iwKJGx7tAWw0cVADOHQDsyH2EBAbb8hEtoUoCaR3cl+lBqAM7bTMe32YI/1M5YYtbyorCwGFCXq74
 enx4mK627IBHE4xo51Fc2SFCr6GqBn3c4WESj5xlD0Me5Go8YOcpIpdxqwGLy3s4VJUKfhk9i2wSJ
 Y1MK6ImA==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgDZ-0000Th-HL
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 18:05:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60DD11684;
 Wed, 19 Dec 2018 10:05:13 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4DA53F675;
 Wed, 19 Dec 2018 10:05:10 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 23/28] arm64: KVM: Add trapped system register access
 tracepoint
Date: Wed, 19 Dec 2018 18:03:44 +0000
Message-Id: <20181219180349.242681-24-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219180349.242681-1-marc.zyngier@arm.com>
References: <20181219180349.242681-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_130513_835221_7227196A 
X-CRM114-Status: GOOD (  17.60  )
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

We're pretty blind when it comes to system register tracing,
and rely on the ESR value displayed by kvm_handle_sys, which
isn't much.

Instead, let's add an actual name to the sysreg entries, so that
we can finally print it as we're about to perform the access
itself.

The new tracepoint is conveniently called kvm_sys_access.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/sys_regs.c |  2 ++
 arch/arm64/kvm/sys_regs.h |  4 ++++
 arch/arm64/kvm/trace.h    | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 965c6f1706d6..a1f57fcb1bdb 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1850,6 +1850,8 @@ static void perform_access(struct kvm_vcpu *vcpu,
 			   struct sys_reg_params *params,
 			   const struct sys_reg_desc *r)
 {
+	trace_kvm_sys_access(*vcpu_pc(vcpu), params, r);
+
 	/*
 	 * Not having an accessor means that we have configured a trap
 	 * that we don't know how to handle. This certainly qualifies
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index cd710f8b63e0..3b1bc7f01d0b 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -35,6 +35,9 @@ struct sys_reg_params {
 };
 
 struct sys_reg_desc {
+	/* Sysreg string for debug */
+	const char *name;
+
 	/* MRS/MSR instruction which accesses it. */
 	u8	Op0;
 	u8	Op1;
@@ -130,6 +133,7 @@ const struct sys_reg_desc *find_reg_by_id(u64 id,
 #define Op2(_x) 	.Op2 = _x
 
 #define SYS_DESC(reg)					\
+	.name = #reg,					\
 	Op0(sys_reg_Op0(reg)), Op1(sys_reg_Op1(reg)),	\
 	CRn(sys_reg_CRn(reg)), CRm(sys_reg_CRm(reg)),	\
 	Op2(sys_reg_Op2(reg))
diff --git a/arch/arm64/kvm/trace.h b/arch/arm64/kvm/trace.h
index 3b82fb1ddd09..eab91ad0effb 100644
--- a/arch/arm64/kvm/trace.h
+++ b/arch/arm64/kvm/trace.h
@@ -3,6 +3,7 @@
 #define _TRACE_ARM64_KVM_H
 
 #include <linux/tracepoint.h>
+#include "sys_regs.h"
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm
@@ -152,6 +153,40 @@ TRACE_EVENT(kvm_handle_sys_reg,
 	TP_printk("HSR 0x%08lx", __entry->hsr)
 );
 
+TRACE_EVENT(kvm_sys_access,
+	TP_PROTO(unsigned long vcpu_pc, struct sys_reg_params *params, const struct sys_reg_desc *reg),
+	TP_ARGS(vcpu_pc, params, reg),
+
+	TP_STRUCT__entry(
+		__field(unsigned long,			vcpu_pc)
+		__field(bool,				is_write)
+		__field(const char *,			name)
+		__field(u8,				Op0)
+		__field(u8,				Op1)
+		__field(u8,				CRn)
+		__field(u8,				CRm)
+		__field(u8,				Op2)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_pc = vcpu_pc;
+		__entry->is_write = params->is_write;
+		__entry->name = reg->name;
+		__entry->Op0 = reg->Op0;
+		__entry->Op0 = reg->Op0;
+		__entry->Op1 = reg->Op1;
+		__entry->CRn = reg->CRn;
+		__entry->CRm = reg->CRm;
+		__entry->Op2 = reg->Op2;
+	),
+
+	TP_printk("PC: %lx %s (%d,%d,%d,%d,%d) %s",
+		  __entry->vcpu_pc, __entry->name ?: "UNKN",
+		  __entry->Op0, __entry->Op1, __entry->CRn,
+		  __entry->CRm, __entry->Op2,
+		  __entry->is_write ? "write" : "read")
+);
+
 TRACE_EVENT(kvm_set_guest_debug,
 	TP_PROTO(struct kvm_vcpu *vcpu, __u32 guest_debug),
 	TP_ARGS(vcpu, guest_debug),
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
