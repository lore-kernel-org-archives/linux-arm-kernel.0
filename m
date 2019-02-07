Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E421FC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:19:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A024821908
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SIN7lRhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A024821908
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9c4BI10m/FDUezyqwIIQueKHRUWe5pp2NXfWCS+t3ZQ=; b=SIN7lRhMw2tf+t
	zmbpm/ZKdWSijtYSlAH8S1bMQel5VrdN1vqeMG9fcMRpzDwalBet065X4hGDSVNzggEhAMygJUzrJ
	gDPKSfXs1UiRRHgqLkpotNqZA8xf1e+dUlLIK2CrCFG1z2iGgDnURCcru9uy0FHpo26tY4Q1OMnFj
	743KZ+Hdce752aVnAPzNo+jlCmLlXA7AuaQj9GnP4ty/WiCmuLYfJqP0f1oG4zDFwloIGVOZa1cWP
	kGJ9unONM/0ISfRV5I2baVFNlsOS05OEbocW0lMWlmQNdlrnKiWtOQ/kK/lRJC3bBQpqxzQEVHUfT
	QR+V+ca223qKWllx+FBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grja3-00022j-Nb; Thu, 07 Feb 2019 13:19:03 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grjZz-00021j-Rt
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 13:19:01 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2CEFA78;
 Thu,  7 Feb 2019 05:18:57 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com
 (filthy-habits.cambridge.arm.com [10.1.196.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B88723F675;
 Thu,  7 Feb 2019 05:18:55 -0800 (PST)
From: Marc Zyngier <marc.zyngier@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [GIT PULL] KVM/ARM updates for 5.0-rc6
Date: Thu,  7 Feb 2019 13:18:32 +0000
Message-Id: <20190207131843.157210-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_051859_913839_72AB7E80 
X-CRM114-Status: GOOD (  11.71  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 kvm@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>, James Morse <james.morse@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Paolo, Radim,

This is hopefully the last drop of KVM/ARM patches for 5.0. We have
fixes to the vcpu reset code, a fix for a corner case of the VGIC
init, better LORegion handling compliance, more configurations where
we allow PUD mappings, a set of kprobe exclusions, and the required
fixes to be able to run KVM with PREEMPT_RT.

Please pull,

	M.

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-fixes-for-5.0

for you to fetch changes up to 7d82602909ed9c73b34ad26f05d10db4850a4f8c:

  KVM: arm64: Forbid kprobing of the VHE world-switch code (2019-02-07 11:44:47 +0000)

----------------------------------------------------------------
KVM/ARM fixes for 5.0:

- Fix the way we reset vcpus, plugging the race that could happen on VHE
- Fix potentially inconsistent group setting for private interrupts
- Don't generate UNDEF when LORegion feature is present
- Relax the restriction on using stage2 PUD huge mapping
- Turn some spinlocks into raw_spinlocks to help RT compliance

----------------------------------------------------------------
Christoffer Dall (2):
      KVM: arm/arm64: Reset the VCPU without preemption and vcpu state loaded
      KVM: arm/arm64: vgic: Always initialize the group of private IRQs

James Morse (1):
      KVM: arm64: Forbid kprobing of the VHE world-switch code

Julien Thierry (3):
      KVM: arm/arm64: vgic: Make vgic_irq->irq_lock a raw_spinlock
      KVM: arm/arm64: vgic: Make vgic_dist->lpi_list_lock a raw_spinlock
      KVM: arm/arm64: vgic: Make vgic_cpu->ap_list_lock a raw_spinlock

Marc Zyngier (4):
      arm64: KVM: Don't generate UNDEF when LORegion feature is present
      arm/arm64: KVM: Allow a VCPU to fully reset itself
      arm/arm64: KVM: Don't panic on failure to properly reset system registers
      arm: KVM: Add missing kvm_stage2_has_pmd() helper

Suzuki K Poulose (1):
      KVM: arm64: Relax the restriction on using stage2 PUD huge mapping

 arch/arm/include/asm/kvm_host.h       |  10 +++
 arch/arm/include/asm/stage2_pgtable.h |   5 ++
 arch/arm/kvm/coproc.c                 |   4 +-
 arch/arm/kvm/reset.c                  |  24 +++++++
 arch/arm64/include/asm/kvm_host.h     |  11 ++++
 arch/arm64/kvm/hyp/switch.c           |   5 ++
 arch/arm64/kvm/hyp/sysreg-sr.c        |   5 ++
 arch/arm64/kvm/reset.c                |  50 +++++++++++++-
 arch/arm64/kvm/sys_regs.c             |  50 ++++++++------
 include/kvm/arm_vgic.h                |   6 +-
 virt/kvm/arm/arm.c                    |  10 +++
 virt/kvm/arm/mmu.c                    |   9 ++-
 virt/kvm/arm/psci.c                   |  36 +++++------
 virt/kvm/arm/vgic/vgic-debug.c        |   4 +-
 virt/kvm/arm/vgic/vgic-init.c         |  30 +++++----
 virt/kvm/arm/vgic/vgic-its.c          |  22 +++----
 virt/kvm/arm/vgic/vgic-mmio-v2.c      |  14 ++--
 virt/kvm/arm/vgic/vgic-mmio-v3.c      |  12 ++--
 virt/kvm/arm/vgic/vgic-mmio.c         |  34 +++++-----
 virt/kvm/arm/vgic/vgic-v2.c           |   4 +-
 virt/kvm/arm/vgic/vgic-v3.c           |   8 +--
 virt/kvm/arm/vgic/vgic.c              | 118 +++++++++++++++++-----------------
 22 files changed, 303 insertions(+), 168 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
