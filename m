Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE15AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:51:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3B820878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EcgH0B3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3B820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LOyK52TYCFl5z1onU1rCjU6OBg0MABJNnpUpVVaQubo=; b=EcgH0B3SBCf6NE
	FtyyyxLCnFzCHyPyqTht4V9NCrPydZRdUASQW6UTRVPl74kK4eG+oPTbrGouYo9/5bDLbFKnSXFWp
	gGTh0V3afc1CAWZ8dufPKxkxBqadP7I9JKN+E041EqRIEmXbdYxzsZ35Qr+A3xdB29H0F8xp9DtAD
	v9V2W5iyaci6DCtMnw8vS9UNyIxAgzqblEkhx6tvi9lq9TOmYU8N4jFx8bwabWmv0vxVNLLBQQWJs
	X1FJhxgo7Of2sPD05g95isVFL5yZGz1CnKDtsTFpiWtV0uddm03mD9MrNVvkegHjpaN5nRMQCfOHf
	blc3VX8/K88JxRLq5DLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV2UB-0001i2-8n; Thu, 06 Dec 2018 22:51:11 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV2U6-0001ga-Ve
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:51:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55A4E1596;
 Thu,  6 Dec 2018 14:50:54 -0800 (PST)
Received: from capper-debian.arm.com (unknown [10.37.12.92])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C617E3F5AF;
 Thu,  6 Dec 2018 14:50:52 -0800 (PST)
From: Steve Capper <steve.capper@arm.com>
To: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V5 0/7] 52-bit userspace VAs
Date: Thu,  6 Dec 2018 22:50:35 +0000
Message-Id: <20181206225042.11548-1-steve.capper@arm.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_145107_038308_D902D28F 
X-CRM114-Status: GOOD (  11.61  )
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
Cc: ard.biesheuvel@linaro.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
 Steve Capper <steve.capper@arm.com>, will.deacon@arm.com, jcm@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series brings support for 52-bit userspace VAs to systems that
have ARMv8.2-LVA and are running with a 48-bit VA_BITS and a 64KB
PAGE_SIZE.

If no hardware support is present, the kernel runs with a 48-bit VA space
for userspace.

Userspace can exploit this feature by providing an address hint to mmap
where addr[51:48] != 0. Otherwise all the VA mappings will behave in the
same way as a 48-bit VA system (this is to maintain compatibility with
software that assumes the maximum VA size on arm64 is 48-bit).

This patch series applies to 4.20-rc1.

Testing was in a model with Trusted Firmware and UEFI for boot.

Changed in V5, ttbr1 offsetting code simplified. Extra patch added to
check for VA space support mismatch between CPUs.

Changed in V4, pgd_index changes dropped in favour of offsetting the
ttbr1. This is performed in a new patch, #4.

Changed in V3, COMPAT fixes added (and tested with 32-bit userspace code).
Extra patch added to allow forcing all userspace allocations to come from
52-bits (to allow for debugging and testing).

The major change to V2 of the series is that mm/mmap.c is altered in the
first patch of the series (rather than copied over to arch/arm64).


Steve Capper (7):
  mm: mmap: Allow for "high" userspace addresses
  arm64: mm: Introduce DEFAULT_MAP_WINDOW
  arm64: mm: Define arch_get_mmap_end, arch_get_mmap_base
  arm64: mm: Offset TTBR1 to allow 52-bit PTRS_PER_PGD
  arm64: mm: Prevent mismatched 52-bit VA support
  arm64: mm: introduce 52-bit userspace support
  arm64: mm: Allow forcing all userspace addresses to 52-bit

 arch/arm64/Kconfig                      | 17 +++++++++++
 arch/arm64/include/asm/assembler.h      | 30 ++++++++++++++++---
 arch/arm64/include/asm/elf.h            |  4 +++
 arch/arm64/include/asm/mmu_context.h    |  3 ++
 arch/arm64/include/asm/pgtable-hwdef.h  |  9 ++++++
 arch/arm64/include/asm/processor.h      | 36 ++++++++++++++++++----
 arch/arm64/kernel/head.S                | 40 +++++++++++++++++++++++++
 arch/arm64/kernel/hibernate-asm.S       |  1 +
 arch/arm64/kernel/smp.c                 |  5 ++++
 arch/arm64/mm/fault.c                   |  2 +-
 arch/arm64/mm/init.c                    |  2 +-
 arch/arm64/mm/mmu.c                     |  1 +
 arch/arm64/mm/proc.S                    | 14 ++++++++-
 drivers/firmware/efi/arm-runtime.c      |  2 +-
 drivers/firmware/efi/libstub/arm-stub.c |  2 +-
 mm/mmap.c                               | 25 +++++++++++-----
 16 files changed, 171 insertions(+), 22 deletions(-)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
