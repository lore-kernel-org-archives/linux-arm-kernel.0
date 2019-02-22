Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51371C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:11:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C4420700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ufB+vs/G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cpUUEqPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C4420700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VbhFqI67G8dl2Ve/qu87Jcsy+cxhZoCGPnLRlGHlwqU=; b=ufB+vs/GpatRvD
	EkgKshfNyUHHIenoSmY/FU6BQAnSy+J0/NSac9xp/ce3OQQh7adUK6waT10nPESCYWHz1/w51GJCF
	h4733ZpE4aGhxAgHo1Nf6WCQMvHVP6OkMey4YRX57i8HEwpdl0dleOrBHsg+Uyu3keYUKSRumaLOE
	dEOhkWMUfFg3TubSrcohA4eANukp4xIkNwMHtcTUXRQF0XItTgfSsPegI3BX1D2LnfLnmtM+ohnCk
	Ao91nkZU1oDjbhkvGthraxRJwZCE1AZ3Tw7nCy5SPSOn5+AAzC4uv3PjHrqKdEJ10DdpQC75kzOBv
	4qa7ImxwSg9frTuu5XWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxELr-0003i3-JV; Fri, 22 Feb 2019 17:11:07 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxELb-0003PD-Ld
 for linux-arm-kernel@bombadil.infradead.org; Fri, 22 Feb 2019 17:10:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kMZheYnhCyTasembsFvjyhmtjMPifFdYYfvqjPVgweU=; b=cpUUEqPkS0rYDKMKR7g5RxJMCP
 caanP2TJHC0FmDOnyz2zgiWhJYlXw+kvMuhP9eI8ZCEMdu0AgpDjWGe2IzTnKw0XsN+jh4NPEsaM2
 MWWKXhFgw3pbWWczuOpcX/9TIEyHMr3OVgkWSmjouCaJ6voqsxoWtzWx6KQ2Bg7Je/InocAS165Lr
 yaXZCOMM56RWjlLQ/WVJ1z6qrEp1VEcceYdVWC95zTPlCiJ2tsgkMIAwtAy4Z9XfLUxFskw1bDlQ+
 0w4658/1qvIezUj7by7PP9EXriQ7ZNKEdQTih+PXyg+3U0SNItF4LqKOKWzJvPv3gqFLb+N0lkjg8
 RW4wW5Gg==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxDgZ-0004C9-RT
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 16:28:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 372C31682;
 Fri, 22 Feb 2019 08:28:27 -0800 (PST)
Received: from big-swifty.lan (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 D4C163F5C1; Fri, 22 Feb 2019 08:28:21 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 17/27] arm64: KVM: Describe data or unified caches as having 1
 set and 1 way
Date: Fri, 22 Feb 2019 16:25:55 +0000
Message-Id: <20190222162605.5054-18-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222162605.5054-1-marc.zyngier@arm.com>
References: <20190222162605.5054-1-marc.zyngier@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_112828_070130_FCFBDEB7 
X-CRM114-Status: GOOD (  16.38  )
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
Cc: Julien Thierry <julien.thierry@arm.com>, kvm@vger.kernel.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 Shaokun Zhang <zhangshaokun@hisilicon.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org,
 Zenghui Yu <yuzenghui@huawei.com>, Colin Ian King <colin.king@canonical.com>,
 Dave Martin <Dave.Martin@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

On SMP ARM systems, cache maintenance by set/way should only ever be
done in the context of onlining or offlining CPUs, which is typically
done by bare metal firmware and never in a virtual machine. For this
reason, we trap set/way cache maintenance operations and replace them
with conditional flushing of the entire guest address space.

Due to this trapping, the set/way arguments passed into the set/way
ops are completely ignored, and thus irrelevant. This also means that
the set/way geometry is equally irrelevant, and we can simply report
it as 1 set and 1 way, so that legacy 32-bit ARM system software (i.e.,
the kind that only receives odd fixes) doesn't take a performance hit
due to the trapping when iterating over the cachelines.

Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_emulate.h |  3 ++-
 arch/arm64/kvm/sys_regs.c            | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 9acccb1e3746..d3842791e1c4 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -78,7 +78,8 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 	if (!vcpu_el1_is_32bit(vcpu))
 		vcpu->arch.hcr_el2 |= HCR_TID3;
 
-	if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE))
+	if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE) ||
+	    vcpu_el1_is_32bit(vcpu))
 		vcpu->arch.hcr_el2 |= HCR_TID2;
 }
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 45a07cfc57ed..81a342679e60 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1186,6 +1186,21 @@ static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 
 	csselr = vcpu_read_sys_reg(vcpu, CSSELR_EL1);
 	p->regval = get_ccsidr(csselr);
+
+	/*
+	 * Guests should not be doing cache operations by set/way at all, and
+	 * for this reason, we trap them and attempt to infer the intent, so
+	 * that we can flush the entire guest's address space at the appropriate
+	 * time.
+	 * To prevent this trapping from causing performance problems, let's
+	 * expose the geometry of all data and unified caches (which are
+	 * guaranteed to be PIPT and thus non-aliasing) as 1 set and 1 way.
+	 * [If guests should attempt to infer aliasing properties from the
+	 * geometry (which is not permitted by the architecture), they would
+	 * only do so for virtually indexed caches.]
+	 */
+	if (!(csselr & 1)) // data or unified cache
+		p->regval &= ~GENMASK(27, 3);
 	return true;
 }
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
