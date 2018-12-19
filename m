Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7A2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:21:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051AF217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NH3h9/r+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fRolmO8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051AF217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xLBZSjjP/GX197qLriNWcm4TMtaxkrPz+luXssHYZmY=; b=NH3h9/r+DHaXm3
	/AsSQ8xZO/QDgfMxxO+H6GzhPmuAMzS4CKz2BCdhDHSnvMRgc1zRJPGH7Jx7ACcwnhb2k7XKALTL6
	EAW5oHR8/Krxd7FQlvzAuAAJO1+ktFDjLu16sRJ9223t29AQxE/puL3odrpkNDFRkCvpAW8FxfRBw
	KvUB83yYDa7mw3E6JA+xYZe5UBUaXTj0AN/UhCVkjAdEILu30RRMdPX6D2m7siOg4T5GuOIZmpa4v
	0VFFCmoZ2R0EvqSu2z78z49yz4ez8ei42durFJMHQO0z/TvBQcMU+b0CLb7P3NgjCEuHBurpdFIGQ
	LQOvxeUkWJkHCrAzRotQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZgT1-0001ZO-54; Wed, 19 Dec 2018 18:21:11 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgSZ-000163-Kj
 for linux-arm-kernel@bombadil.infradead.org; Wed, 19 Dec 2018 18:20:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lPoqr4cts+2O+yfSOYGlW1JtnNFVkYitV/0BrPyIR5M=; b=fRolmO8oU9Ip12zesYKyN4A0pw
 rSp0vUDTQY2nVY6V02BTNPBLBVM8Ld4N4GcBoa8WuGNr4X0egafQ3Z8m9jmWebY2UsXxr6ETTMC+w
 IDtalXkK8m6vqnKSgrNLrPkEDpkyypAQnFYDDxd/pi8Gwwj/dkMS2hfdORduOrD23r9iENtYtRJWN
 LJBPGn3LmaMiSEfU2Vjyl0rhcIJ1TuBMkjadPZ38pRSweF+OBqjji5aPLK7hf2wxBLvbGr7/antlr
 3KNpWyw1B46y13oqPV0zD8E1iRUGXU7BPHXH7FG2sfpyPJa0f5VslPnpwkdce9+F17t4y5OBQnG03
 tbreJ5ng==;
Received: from foss.arm.com ([217.140.101.70])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgDg-0008GI-Ao
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 18:05:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFE63168F;
 Wed, 19 Dec 2018 10:05:07 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5074F3F675;
 Wed, 19 Dec 2018 10:05:05 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 21/28] KVM: arm/arm64: arch_timer: Simplify
 kvm_timer_vcpu_terminate
Date: Wed, 19 Dec 2018 18:03:42 +0000
Message-Id: <20181219180349.242681-22-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219180349.242681-1-marc.zyngier@arm.com>
References: <20181219180349.242681-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_180520_505280_8A3A768E 
X-CRM114-Status: GOOD (  11.91  )
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

From: Christoffer Dall <christoffer.dall@arm.com>

kvm_timer_vcpu_terminate can only be called in two scenarios:

 1. As part of cleanup during a failed VCPU create
 2. As part of freeing the whole VM (struct kvm refcount == 0)

In the first case, we cannot have programmed any timers or mapped any
IRQs, and therefore we do not have to cancel anything or unmap anything.

In the second case, the VCPU will have gone through kvm_timer_vcpu_put,
which will have canceled the emulated physical timer's hrtimer, and we
do not need to that here as well.  We also do not care if the irq is
recorded as mapped or not in the VGIC data structure, because the whole
VM is going away.  That leaves us only with having to ensure that we
cancel the bg_timer if we were blocking the last time we called
kvm_timer_vcpu_put().

Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/arch_timer.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index da261f5e2a91..b07ac4614e1c 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -772,11 +772,8 @@ int kvm_timer_hyp_init(bool has_gic)
 void kvm_timer_vcpu_terminate(struct kvm_vcpu *vcpu)
 {
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
-	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
 
 	soft_timer_cancel(&timer->bg_timer);
-	soft_timer_cancel(&timer->phys_timer);
-	kvm_vgic_unmap_phys_irq(vcpu, vtimer->irq.irq);
 }
 
 static bool timer_irqs_are_valid(struct kvm_vcpu *vcpu)
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
