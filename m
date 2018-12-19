Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03969C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:05:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C44C9218AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ALRkILAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44C9218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EqOjO4tPhH8vaXBS3IKSiCIOySz4qqt4KhLGYWPPV5M=; b=ALRkILAxT7GyRN
	gXXEBvAAaKm192zGKtgv6J7Ses6M+8+naxnV91rjz1LExhHW3iiqWe3bb4wcbqEwbboQOLr1r3O11
	QPjTtKImz4C74tZt08vZEgzBR6flIucu9W27Rdv3fugQ1YLXvVH2xYDNU+o74aXsQQmzNUdDulxkm
	xWkkginfL7FAETCmy7E6kJ0PW3xvpjk8/RVvwVowP7SfpuI4ihzJyUzPdyzI9gDsTTJeKldx2GgyJ
	iHfhMqercyN/blfDF5w2T5uK1s8kkSmpGH1Y7z1nOIg/FH08+3XLzkK7nHaTzEbdbbrGAPVmYA3se
	c7/c0x1iMV6bTYIyODQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZgDT-0006cn-Vx; Wed, 19 Dec 2018 18:05:08 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgCi-0005nY-TR
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 18:04:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C2F1A78;
 Wed, 19 Dec 2018 10:04:09 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F091C3F675;
 Wed, 19 Dec 2018 10:04:06 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [GIT PULL] KVM/arm updates for 4.21
Date: Wed, 19 Dec 2018 18:03:21 +0000
Message-Id: <20181219180349.242681-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_100421_111275_C27438A7 
X-CRM114-Status: GOOD (  17.26  )
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

Paolo, Radim,

This is the KVM/arm updates for 4.21. The biggest thing is the support
for 1GB PUD support for HugeTLB backed guest memory. The rest is a
bunch of cleanups and other fixes.

Please pull,

	M.

The following changes since commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436:

  Linux 4.20-rc4 (2018-11-25 14:19:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvmarm-for-v4.21

for you to fetch changes up to 8c33df1afd86c611da8473dc6fc5f3af3dabe984:

  arm: KVM: Add S2_PMD_{MASK,SIZE} constants (2018-12-19 17:48:21 +0000)

----------------------------------------------------------------
KVM/arm updates for 4.21

- Large PUD support for HugeTLB
- Single-stepping fixes
- Improved tracing
- Various timer and vgic fixups

----------------------------------------------------------------
Christoffer Dall (9):
      KVM: arm/arm64: Fix VMID alloc race by reverting to lock-less
      KVM: arm/arm64: vgic-v2: Set active_source to 0 when restoring state
      KVM: arm64: Clarify explanation of STAGE2_PGTABLE_LEVELS
      KVM: arm/arm64: vgic: Consider priority and active state for pending irq
      KVM: arm/arm64: Fixup the kvm_exit tracepoint
      KVM: arm/arm64: Remove arch timer workqueue
      KVM: arm/arm64: arch_timer: Simplify kvm_timer_vcpu_terminate
      KVM: arm64: Make vcpu const in vcpu_read_sys_reg
      KVM: arm/arm64: Fix unintended stage 2 PMD mappings

Gustavo A. R. Silva (1):
      KVM: arm/arm64: vgic: Fix off-by-one bug in vgic_get_irq()

Julien Thierry (1):
      KVM: arm/arm64: vgic: Do not cond_resched_lock() with IRQs disabled

Marc Zyngier (5):
      KVM: arm/arm64: vgic: Cap SPIs to the VM-defined maximum
      arm64: KVM: Add trapped system register access tracepoint
      arm/arm64: KVM: vgic: Force VM halt when changing the active state of GICv3 PPIs/SGIs
      arm/arm64: KVM: Add ARM_EXCEPTION_IS_TRAP macro
      arm: KVM: Add S2_PMD_{MASK,SIZE} constants

Mark Rutland (3):
      arm64: KVM: Skip MMIO insn after emulation
      arm64: KVM: Consistently advance singlestep when emulating instructions
      KVM: arm/arm64: Log PSTATE for unhandled sysregs

Punit Agrawal (8):
      KVM: arm/arm64: Share common code in user_mem_abort()
      KVM: arm/arm64: Re-factor setting the Stage 2 entry to exec on fault
      KVM: arm/arm64: Introduce helpers to manipulate page table entries
      KVM: arm64: Support dirty page tracking for PUD hugepages
      KVM: arm64: Support PUD hugepage in stage2_is_exec()
      KVM: arm64: Support handling access faults for PUD hugepages
      KVM: arm64: Update age handlers to support PUD hugepages
      KVM: arm64: Add support for creating PUD hugepages at stage 2

Will Deacon (1):
      arm64: KVM: Avoid setting the upper 32 bits of VTCR_EL2 to 1

 arch/arm/include/asm/kvm_asm.h           |   4 +
 arch/arm/include/asm/kvm_host.h          |   5 -
 arch/arm/include/asm/kvm_mmu.h           |  61 +++++
 arch/arm/include/asm/stage2_pgtable.h    |   8 +
 arch/arm/kvm/coproc.c                    |   4 +-
 arch/arm64/include/asm/kvm_arm.h         |   6 +-
 arch/arm64/include/asm/kvm_asm.h         |   7 +
 arch/arm64/include/asm/kvm_emulate.h     |  35 ++-
 arch/arm64/include/asm/kvm_host.h        |   3 +-
 arch/arm64/include/asm/kvm_mmu.h         |  48 ++++
 arch/arm64/include/asm/pgtable-hwdef.h   |   4 +
 arch/arm64/include/asm/pgtable.h         |   9 +
 arch/arm64/include/asm/stage2_pgtable.h  |  16 +-
 arch/arm64/kvm/debug.c                   |  21 --
 arch/arm64/kvm/handle_exit.c             |  14 +-
 arch/arm64/kvm/hyp/switch.c              |  43 +---
 arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c |  12 +-
 arch/arm64/kvm/sys_regs.c                |  12 +-
 arch/arm64/kvm/sys_regs.h                |   4 +
 arch/arm64/kvm/trace.h                   |  35 +++
 include/kvm/arm_arch_timer.h             |   4 -
 virt/kvm/arm/arch_timer.c                |  35 +--
 virt/kvm/arm/arm.c                       |  25 +-
 virt/kvm/arm/hyp/vgic-v3-sr.c            |   6 +-
 virt/kvm/arm/mmio.c                      |  11 +-
 virt/kvm/arm/mmu.c                       | 384 +++++++++++++++++++++++--------
 virt/kvm/arm/trace.h                     |  18 +-
 virt/kvm/arm/vgic/vgic-mmio.c            |  44 ++--
 virt/kvm/arm/vgic/vgic.c                 |  13 +-
 29 files changed, 595 insertions(+), 296 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
