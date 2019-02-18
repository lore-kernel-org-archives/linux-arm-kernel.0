Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23B6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:05:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8362020C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lKFgpum1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8362020C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5oOncW/5fP1mASvgP4Gt0yp8PYwC5phjnj7ERcDpB7U=; b=lKFgpum1Xb8ZLF
	MVihUWYclSObldwURQuPjgRdPgdnUC8EpuJ0Nmj2PY0vX7L0V5y+IsHyGIxklWeapA2K76+78ekdS
	lyeqG6VSVB5i8GiDduqQWHFuMH71tVELdYQt2iB3Rm3E6R5KPgkF6HNzxyPCJFeeJ4rjDGjUQgdED
	0SxdkXuZZ/iCqpUiUX704EG2hMHitBXnXVNrmjcdguS2XXi9IxBWWgLCItz137gf5E2aFIcMd7Z1a
	/rLz7RYLJKFeyMafPqSOCkpcVw5ONYaGkUfIWbxIfOE20Ne+U5lbN1aQDt1Eq+A1t6E+HVI6SrYXj
	Ue4T3Vd+lMZ4nL35148Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvmMQ-00072A-2W; Mon, 18 Feb 2019 17:05:42 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvmLM-0004ep-Bf
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 17:04:41 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A72281650;
 Mon, 18 Feb 2019 09:04:27 -0800 (PST)
Received: from capper-debian.emea.arm.com (C02R32KKFVH8.manchester.arm.com
 [10.32.102.153])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5E1E83F675;
 Mon, 18 Feb 2019 09:04:06 -0800 (PST)
From: Steve Capper <steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/9] 52-bit kernel + user VAs
Date: Mon, 18 Feb 2019 17:02:36 +0000
Message-Id: <20190218170245.14915-1-steve.capper@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_090436_666290_896CEF5D 
X-CRM114-Status: GOOD (  13.92  )
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
Cc: crecklin@redhat.com, Steve Capper <steve.capper@arm.com>,
 marc.zyngier@arm.com, catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
 will.deacon@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series adds support for 52-bit kernel VAs using some of the
machinery already introduced by the 52-bit userspace VA code in 5.0.

As 52-bit virtual address support is an optional hardware feature,
software support for 52-bit kernel VAs needs to be deduced at early boot
time. If HW support is not available, the kernel falls back to 48-bit.

A significant proportion of this series focuses on "de-constifying"
VA_BITS related constants.

In order to allow for a KASAN shadow that changes size at boot time, one
must fix the KASAN_SHADOW_END for both 48 & 52-bit VAs and "grow" the
start address. Also, it is highly desirable to maintain the same
function addresses in the kernel .text between VA sizes. Both of these
requirements necessitate us to flip the kernel address space halves s.t.
the direct linear map occupies the lower addresses.

One obvious omission is 52-bit kernel VA + 48-bit userspace VA which I
can add with some more #ifdef'ery if needed.

Cheers,
-- 
Steve

Steve Capper (9):
  arm/arm64: KVM: Formalise end of direct linear map
  arm64: mm: Flip kernel VA space
  arm64: kasan: Switch to using KASAN_SHADOW_OFFSET
  arm64: mm: Replace fixed map BUILD_BUG_ON's with BUG_ON's
  arm64: dump: Make kernel page table dumper dynamic again
  arm64: mm: Introduce VA_BITS_MIN
  arm64: mm: Introduce VA_BITS_ACTUAL
  arm64: mm: Logic to make offset_ttbr1 conditional
  arm64: mm: Introduce 52-bit Kernel VAs

 Documentation/arm64/kasan-offsets.sh   | 27 ++++++++++++
 arch/arm/include/asm/memory.h          |  1 +
 arch/arm64/Kconfig                     | 46 +++++++++++++++++++-
 arch/arm64/Makefile                    |  8 ----
 arch/arm64/include/asm/assembler.h     | 17 +++++++-
 arch/arm64/include/asm/cpucaps.h       |  3 +-
 arch/arm64/include/asm/efi.h           |  4 +-
 arch/arm64/include/asm/kasan.h         | 11 ++---
 arch/arm64/include/asm/memory.h        | 33 +++++++++------
 arch/arm64/include/asm/mmu_context.h   |  4 +-
 arch/arm64/include/asm/pgtable-hwdef.h |  2 +-
 arch/arm64/include/asm/pgtable.h       |  2 +-
 arch/arm64/include/asm/processor.h     |  2 +-
 arch/arm64/kernel/cpufeature.c         | 18 ++++++++
 arch/arm64/kernel/head.S               | 25 +++++++++--
 arch/arm64/kernel/hibernate-asm.S      |  1 +
 arch/arm64/kernel/kaslr.c              |  6 +--
 arch/arm64/kvm/va_layout.c             | 14 +++----
 arch/arm64/mm/dump.c                   | 58 +++++++++++++++++++++-----
 arch/arm64/mm/fault.c                  |  4 +-
 arch/arm64/mm/init.c                   | 14 +++----
 arch/arm64/mm/kasan_init.c             | 11 +++--
 arch/arm64/mm/mmu.c                    | 13 +++---
 arch/arm64/mm/proc.S                   |  6 ++-
 virt/kvm/arm/mmu.c                     |  4 +-
 25 files changed, 247 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/arm64/kasan-offsets.sh

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
