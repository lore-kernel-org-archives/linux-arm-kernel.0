Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435ACC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:24:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16096218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SHhBfsHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16096218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ouWURIY03T3tEsYORPgDmkwzWnvjwwxvc7EQlluiHb8=; b=SHhBfsHDA398kM
	8NOzmRKK6+CbT/jd8lZPgFv7kBajI9zfWS9J05oezGD8W1hhzN/c9MeaP84OiIo9O8ed7enNt9Htn
	pC6uMT/1C0tzStp4D8uZuJiJtCRiK2BA+tgeBOG4opckxPnIFMWB0Ri5G1gMOmIa9ubNz098XLHQG
	5YXvlDi31d67J2cjBkfQYY8EV6W1gJe6wUwGiwPwUvr2y1T1p3p62hQA0BC8V6o2cowRXPQN5yhXA
	V6T35h57s7Jyz8pWYEBPnM5Ctrdu3JmHCh4hFADXTROFDq3qHNBZNet2+/0inJryLqoQ+RBmOqNMt
	LBU/ZssXLPJW/SvN9u9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfU96-0002Jz-VU; Fri, 04 Jan 2019 18:24:36 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfU93-0002JF-R7
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 18:24:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A0E6EBD;
 Fri,  4 Jan 2019 10:24:31 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B2953F5D4;
 Fri,  4 Jan 2019 10:24:30 -0800 (PST)
Date: Fri, 4 Jan 2019 18:24:27 +0000
From: Will Deacon <will.deacon@arm.com>
To: torvalds@linux-foundation.org
Subject: [GIT PULL] arm64: fixes for -rc1
Message-ID: <20190104182427.GD6299@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_102433_889822_1F5A84DA 
X-CRM114-Status: GOOD (  16.45  )
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
Cc: catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Linus,

I'm safely chained back up to my desk, so please pull these arm64 fixes
for -rc1 that address some issues that cropped up during the merge window.

Details in the tag.

Cheers,

Will

--->8

The following changes since commit 12f799c8c739518e12248bbd000eb0a246e8e5f8:

  arm64: kaslr: print PHYS_OFFSET in dump_kernel_offset() (2018-12-14 09:33:49 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 7e0b44e870cf265bb4a73fd25e0508c7363fcbd6:

  arm64: compat: Hook up io_pgetevents() for 32-bit tasks (2019-01-04 14:18:01 +0000)

----------------------------------------------------------------
arm64 fixes for -rc1

- Prevent KASLR from mapping the top page of the virtual address space

- Fix device-tree probing of SDEI driver

- Fix incorrect register offset definition in Hisilicon DDRC PMU driver

- Fix compilation issue with older binutils not liking unsigned immediates

- Fix uapi headers so that libc can provide its own sigcontext definition

- Fix handling of private compat syscalls

- Hook up compat io_pgetevents() syscall for 32-bit tasks

- Cleanup to arm64 Makefile (including now to avoid silly conflicts)

----------------------------------------------------------------
Dave Martin (2):
      arm64/sve: ptrace: Fix SVE_PT_REGS_OFFSET definition
      arm64/sve: Disentangle <uapi/asm/ptrace.h> from <uapi/asm/sigcontext.h>

James Morse (1):
      firmware: arm_sdei: Fix DT platform device creation

Mark Rutland (1):
      arm64: entry: remove unused register aliases

Masahiro Yamada (1):
      arm64: replace arm64-obj-* in Makefile with obj-*

Nicolas Saenz Julienne (1):
      firmware: arm_sdei: fix wrong of_node_put() in init function

Shaokun Zhang (2):
      arm64: smp: Fix compilation error
      drivers/perf: hisi: Fixup one DDRC PMU register offset

Will Deacon (3):
      arm64: compat: Avoid sending SIGILL for unallocated syscall numbers
      arm64: compat: Don't pull syscall number from regs in arm_compat_syscall
      arm64: compat: Hook up io_pgetevents() for 32-bit tasks

Yueyi Li (1):
      arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in linear region

 arch/arm64/include/asm/smp.h                  |  8 ++--
 arch/arm64/include/asm/unistd.h               |  7 +--
 arch/arm64/include/asm/unistd32.h             |  2 +
 arch/arm64/include/uapi/asm/ptrace.h          | 39 ++++++++---------
 arch/arm64/include/uapi/asm/sigcontext.h      | 56 ++++++++++++------------
 arch/arm64/include/uapi/asm/sve_context.h     | 53 +++++++++++++++++++++++
 arch/arm64/kernel/Makefile                    | 61 +++++++++++++--------------
 arch/arm64/kernel/entry.S                     | 12 +-----
 arch/arm64/kernel/sys_compat.c                | 11 +++--
 arch/arm64/kernel/syscall.c                   |  9 ++--
 arch/arm64/mm/init.c                          |  2 +-
 drivers/firmware/arm_sdei.c                   |  6 ---
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c |  4 +-
 13 files changed, 153 insertions(+), 117 deletions(-)
 create mode 100644 arch/arm64/include/uapi/asm/sve_context.h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
