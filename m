Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3527C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:27:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813AE20665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YKoYdc8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813AE20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Hgoskpweyumk3bAQPM9uGrP3BPyoQVQSdklslQh0GFU=; b=YKoYdc8f7HSIcJ
	qjD8wb9SWVLDPa+NT8S4ZZsulFqWYTV9+VQFgtDGyFUhn7tm5ZQSCVRQhu21Ny4xeLyFMTB8br/PD
	DRQXViHoxcv5g9twzMtt1o1kL5slI13mbHZw+PJkZF5V8SUqp9894mBzSADL4lXh+iODSarIdXjEG
	msRgfdUKuWOINFEXaN42J2UHBGvCPpdCwCR1+MuZRfJax0BOuN6LKL/ZpF5zRb19v5VgXsZ+FYHAx
	Z4N/J4pzzkWalcfoPOs+HzIXrZR3UyKxx13wCTeQk9m2O284fFvazqWBBp8KoFRfcVHNYNnSItRkH
	f+lWbhVG2UJAmmxLrvuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxDf6-0006na-R7; Fri, 22 Feb 2019 16:26:56 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxDf3-0006mm-LG
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 16:26:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87DE280D;
 Fri, 22 Feb 2019 08:26:50 -0800 (PST)
Received: from big-swifty.lan (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 02E1B3F5C1; Fri, 22 Feb 2019 08:26:45 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [GIT PULL] KVM/arm updates for Linux v5.1
Date: Fri, 22 Feb 2019 16:25:38 +0000
Message-Id: <20190222162605.5054-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_082653_706917_330FC75C 
X-CRM114-Status: GOOD (  15.90  )
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

Paolo, Radim,

This is the KVM/arm updates for Linux v5.1, much smaller than expected, as
most of the stuff we were hoping to queue missed the merge window. Oh well,
5.2 will be "interesting".

This time, we have a bunch of changes that prepare the landing of the some
of the nested virt code, some optimisations on the timer emulation (direct
assignment of the physical timer on VHE systems), some better type-safety
checks for the HYP code, Set/Way optimisations for silly 32bit guests, and a
bunch of cleanups here and there. Oh, and a MAINTAINERS update to officially
mention that we have a set of dedicated reviewers working with us!

Note that the first patch hits code that is outside of the KVM tree, but
that Daniel has agreed to us taking directly given that it was required for
a lot of other things in this drop.

Please pull,

	M.

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvmarm-for-v5.1

for you to fetch changes up to c88b093693ccbe41991ef2e9b1d251945e6e54ed:

  arm64: KVM: Fix architecturally invalid reset value for FPEXC32_EL2 (2019-02-22 09:59:20 +0000)

----------------------------------------------------------------
KVM/arm updates for Linux v5.1

- A number of pre-nested code rework
- Direct physical timer assignment on VHE systems
- kvm_call_hyp type safety enforcement
- Set/Way cache sanitisation for 32bit guests
- Build system cleanups
- A bunch of janitorial fixes

----------------------------------------------------------------
Andre Przywara (2):
      clocksource/arm_arch_timer: Store physical timer IRQ number for KVM on VHE
      KVM: arm/arm64: consolidate arch timer trap handlers

Ard Biesheuvel (2):
      arm64: KVM: Expose sanitised cache type register to guest
      arm64: KVM: Describe data or unified caches as having 1 set and 1 way

Christoffer Dall (6):
      KVM: arm/arm64: Factor out VMID into struct kvm_vmid
      KVM: arm/arm64: Simplify bg_timer programming
      KVM: arm/arm64: timer: Rework data structures for multiple timers
      KVM: arm/arm64: arch_timer: Assign the phys timer on VHE systems
      KVM: arm/arm64: Rework the timer code to use a timer_map
      KVM: arm/arm64: Move kvm_is_write_fault to header file

Colin Ian King (1):
      KVM: arm/arm64: fix spelling mistake: "auxilary" -> "auxiliary"

Dave Martin (1):
      arm64: KVM: Fix architecturally invalid reset value for FPEXC32_EL2

Marc Zyngier (9):
      arm/arm64: KVM: Introduce kvm_call_hyp_ret()
      arm64: KVM: Allow for direct call of HYP functions when using VHE
      arm64: KVM: Drop VHE-specific HYP call stub
      ARM: KVM: Teach some form of type-safety to kvm_call_hyp
      arm/arm64: KVM: Statically configure the host's view of MPIDR
      KVM: arm64: Fix ICH_ELRSR_EL2 sysreg naming
      KVM: arm64: Reuse sys_reg() macro when searching the trap table
      KVM: arm/arm64: arch_timer: Mark physical interrupt active when a virtual interrupt is pending
      KVM: arm/arm64: Update MAINTAINERS entries

Masahiro Yamada (3):
      KVM: arm/arm64: Fix TRACE_INCLUDE_PATH
      KVM: arm/arm64: Remove -I. header search paths
      KVM: arm/arm64: Prefix header search paths with $(srctree)/

Shaokun Zhang (2):
      KVM: arm/arm64: Remove unused gpa_end variable
      KVM: arm/arm64: Remove unused timer variable

Zenghui Yu (1):
      KVM: arm64: Fix comment for KVM_PHYS_SHIFT

 MAINTAINERS                          |  18 +-
 arch/arm/include/asm/arch_gicv3.h    |   4 +-
 arch/arm/include/asm/kvm_emulate.h   |   8 +
 arch/arm/include/asm/kvm_host.h      |  53 ++-
 arch/arm/include/asm/kvm_hyp.h       |   4 +
 arch/arm/include/asm/kvm_mmu.h       |   9 +-
 arch/arm/kvm/Makefile                |   5 +-
 arch/arm/kvm/coproc.c                |  23 +-
 arch/arm/kvm/hyp/cp15-sr.c           |   1 -
 arch/arm/kvm/hyp/hyp-entry.S         |   2 +-
 arch/arm/kvm/hyp/switch.c            |   2 +-
 arch/arm/kvm/hyp/tlb.c               |   4 +-
 arch/arm/kvm/interrupts.S            |   4 +-
 arch/arm64/include/asm/kvm_emulate.h |  12 +
 arch/arm64/include/asm/kvm_host.h    |  48 ++-
 arch/arm64/include/asm/kvm_hyp.h     |   3 +-
 arch/arm64/include/asm/kvm_mmu.h     |  13 +-
 arch/arm64/include/asm/sysreg.h      |   7 +-
 arch/arm64/kvm/Makefile              |   4 +-
 arch/arm64/kvm/debug.c               |   2 +-
 arch/arm64/kvm/hyp.S                 |   3 -
 arch/arm64/kvm/hyp/hyp-entry.S       |  12 -
 arch/arm64/kvm/hyp/sysreg-sr.c       |   1 -
 arch/arm64/kvm/sys_regs.c            | 168 ++++++----
 drivers/clocksource/arm_arch_timer.c |  11 +-
 include/clocksource/arm_arch_timer.h |   1 +
 include/kvm/arm_arch_timer.h         |  68 ++--
 virt/kvm/arm/arch_timer.c            | 608 ++++++++++++++++++++++++-----------
 virt/kvm/arm/arm.c                   |  64 ++--
 virt/kvm/arm/hyp/vgic-v3-sr.c        |   2 +-
 virt/kvm/arm/mmu.c                   |  18 +-
 virt/kvm/arm/trace.h                 | 107 +++++-
 virt/kvm/arm/vgic/vgic-v3.c          |   4 +-
 33 files changed, 909 insertions(+), 384 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
