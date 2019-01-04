Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C12C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:50:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF4521871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QSe2Ra/V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzxXJ2N3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF4521871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:
	References:In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=GwDm/54BbpmcXuFEet6KqFFsBexyeqHoxfJrI0g5pck=; b=QSe2Ra/VbPbYKixWyh0fG6ToQs
	GBfSAqHnaUIPNFlXrHTTpg/AGQ3fzgsKBdz7jBp3+wGbCyeuIbaRADhGN6oJkSjAOgG8oxcdvbI7x
	6QJU453wH036o3DD2EUn3TRSYOReGF6HcS6PLbSY/BFKZVFJa/eHOzdzspc+tDykTfidFZ1AirtBo
	PEVnNBZssBGkPdttM9IFdyOq0EfWVNsAtKssJlca3cPEyvAoncl2ZgeykKUny1EVU2CdZZlOz6HZr
	4Lk728fATz2O4aM4mlazYVf/KEyQ0fR+0i6HgUCF0un9PU1wDhTYsbiiiVzNgJ2g2wxgtsfVJsmBw
	OCN3Th2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfHRA-0001Fu-OJ; Fri, 04 Jan 2019 04:50:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfHQv-00013C-SY
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 04:50:11 +0000
Received: from localhost (unknown [23.100.24.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 757522087F;
 Fri,  4 Jan 2019 04:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546577407;
 bh=HAi4ksgEhNzgfWSSQLYDDyzZEOhmvs9WcgWvhjLhKx8=;
 h=Date:From:To:To:To:Cc:Cc:Cc:Cc:Cc:Subject:In-Reply-To:References:
 From;
 b=hzxXJ2N3LyqTfXxKA+9I7WQx2SEU2t0DVKCN6VNXbKlnwzs8MHiFcKi5dgzefsoay
 J9mb6SH5GCjpJwHlram3zAqHjwdjnhIn7azAk1/+kmUN2eLeJtG60fZIB23DKciByp
 HfpNoQ8t+FXuWKIXYHhXfdc82NjvP2O1L8Ohx2Sw=
Date: Fri, 04 Jan 2019 04:50:06 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Will Deacon <will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] arm64: compat: Don't pull syscall number from regs in
 arm_compat_syscall
In-Reply-To: <1546539240-20647-3-git-send-email-will.deacon@arm.com>
References: <1546539240-20647-3-git-send-email-will.deacon@arm.com>
Message-Id: <20190104045007.757522087F@mail.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_205009_969728_D76DFA01 
X-CRM114-Status: UNSURE (   9.26  )
X-CRM114-Notice: Please train this message.
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
Cc: , stable@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
 Pi-Hsun Shih <pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has tested the following trees: v4.20.0, v4.19.13, v4.14.91, v4.9.148, v4.4.169, v3.18.131, 

v4.20.0: Failed to apply! Possible dependencies:
    caf41328c3a5 ("arm64: compat: Avoid sending SIGILL for unallocated syscall numbers")

v4.19.13: Failed to apply! Possible dependencies:
    6fa998e83ef9 ("signal/arm64: Push siginfo generation into arm64_notify_die")
    caf41328c3a5 ("arm64: compat: Avoid sending SIGILL for unallocated syscall numbers")

v4.14.91: Failed to apply! Possible dependencies:
    1fc5dce78ad1 ("arm64/sve: Low-level SVE architectural state manipulation functions")
    2923f5ea7738 ("nds32: Exception handling")
    2c9120f3a86a ("arm64: signal: Make force_signal_inject more robust")
    3eb0f5193b49 ("signal: Ensure every siginfo we send has all bits initialized")
    3f7c86b2382e ("arm64: Update fault_info table with new exception types")
    42dbf54e8890 ("arm64: consistently log ESR and page table")
    4fb158f65ac5 ("powerpc: track allocation status of all pkeys")
    526c3ddb6aa2 ("signal/arm64: Document conflicts with SI_USER and SIGFPE,SIGTRAP,SIGBUS")
    532826f3712b ("arm64: Mirror arm for unimplemented compat syscalls")
    664eec400bf8 ("nds32: MMU fault handling and page table management")
    6fa998e83ef9 ("signal/arm64: Push siginfo generation into arm64_notify_die")
    76d2a0493a17 ("RISC-V: Init and Halt Code")
    92e3da3cf193 ("powerpc: initial pkey plumbing")
    92ff0674f5d8 ("arm64: mm: Rework unhandled user pagefaults to call arm64_force_sig_info")
    94ef7ecbdf6f ("arm64: fpsimd: Correctly annotate exception helpers called from asm")
    af40ff687bc9 ("arm64: signal: Ensure si_code is valid for all fault signals")
    bc0ee4760364 ("arm64/sve: Core task context handling")
    c5cc1f4df6b1 ("powerpc/ptrace: Add memory protection key regset")

v4.9.148: Failed to apply! Possible dependencies:
    0e3a9026396c ("arm64: mm: Update perf accounting to handle poison faults")
    32015c235603 ("arm64: exception: handle Synchronous External Abort")
    3eb0f5193b49 ("signal: Ensure every siginfo we send has all bits initialized")
    3f7c86b2382e ("arm64: Update fault_info table with new exception types")
    4e2648db9c5f ("ARM: remove indirection of asm/mach-types.h")
    526c3ddb6aa2 ("signal/arm64: Document conflicts with SI_USER and SIGFPE,SIGTRAP,SIGBUS")
    532826f3712b ("arm64: Mirror arm for unimplemented compat syscalls")
    5b53696a30d5 ("ACPI / APEI: Switch to use new generic UUID API")
    67ce16ec15ce ("arm64: mm: print out correct page table entries")
    6bc51cbaa9d7 ("signal: Remove non-uapi <asm/siginfo.h>")
    6fa998e83ef9 ("signal/arm64: Push siginfo generation into arm64_notify_die")
    7edda0886bc3 ("acpi: apei: handle SEA notification type for ARMv8")
    80dce5e37493 ("signal/ia64: Document a conflict with SI_USER with SIGFPE")
    83016b204225 ("arm64: mm: print file name of faulting vma")
    92ff0674f5d8 ("arm64: mm: Rework unhandled user pagefaults to call arm64_force_sig_info")
    96a8fae0fe09 ("ARM: convert to generated system call tables")
    a8ada146f517 ("arm64: Update the synchronous external abort fault description")
    af40ff687bc9 ("arm64: signal: Ensure si_code is valid for all fault signals")
    b9253a43370e ("signal: Move copy_siginfo_to_user to <linux/signal.h>")
    bbcc2e7b642e ("ras: acpi/apei: cper: add support for generic data v3 structure")
    c07ab957d9af ("arm64: Call __show_regs directly")
    cc731525f26a ("signal: Remove kernel interal si_code magic")
    cc9f72e474a4 ("signal/sparc: Document a conflict with SI_USER with SIGFPE")
    e2bd64d92a10 ("signal/alpha: Document a conflict with SI_USER for SIGTRAP")
    e7c600f149b8 ("arm64: hwpoison: add VM_FAULT_HWPOISON[_LARGE] handling")
    ea1b75cf9138 ("signal/mips: Document a conflict with SI_USER with SIGFPE")

v4.4.169: Failed to apply! Possible dependencies:
    09a6adf53d42 ("arm64: mm: unaligned access by user-land should be received as SIGBUS")
    0a8ea52c3eb1 ("arm64: Add HAVE_REGS_AND_STACK_ACCESS_API feature")
    0e3a9026396c ("arm64: mm: Update perf accounting to handle poison faults")
    2dd0e8d2d2a1 ("arm64: Kprobes with single stepping support")
    3eb0f5193b49 ("signal: Ensure every siginfo we send has all bits initialized")
    3eca86e75ec7 ("arm64: Remove fixmap include fragility")
    532826f3712b ("arm64: Mirror arm for unimplemented compat syscalls")
    67ce16ec15ce ("arm64: mm: print out correct page table entries")
    6fa998e83ef9 ("signal/arm64: Push siginfo generation into arm64_notify_die")
    83016b204225 ("arm64: mm: print file name of faulting vma")
    92ff0674f5d8 ("arm64: mm: Rework unhandled user pagefaults to call arm64_force_sig_info")
    bbb1681ee365 ("arm64: mm: mark fault_info table const")
    c07ab957d9af ("arm64: Call __show_regs directly")
    cab15ce604e5 ("arm64: Introduce execute-only page access permissions")
    d59bee887231 ("arm64: Add more test functions to insn.c")
    e04a28d45ff3 ("arm64: debug: re-enable irqs before sending breakpoint SIGTRAP")
    e7c600f149b8 ("arm64: hwpoison: add VM_FAULT_HWPOISON[_LARGE] handling")

v3.18.131: Failed to apply! Possible dependencies:
    04597a65c5ef ("arm64: Track system support for mixed endian EL0")
    1b907f46db07 ("arm64: kconfig: move emulation option under kernel features")
    2d888f48e056 ("arm64: Emulate SETEND for AArch32 tasks")
    338d4f49d6f7 ("arm64: kernel: Add support for Privileged Access Never")
    359b706473b4 ("arm64: Extract feature parsing code from cpu_errata.c")
    3eb0f5193b49 ("signal: Ensure every siginfo we send has all bits initialized")
    532826f3712b ("arm64: Mirror arm for unimplemented compat syscalls")
    587064b610c7 ("arm64: Add framework for legacy instruction emulation")
    6fa998e83ef9 ("signal/arm64: Push siginfo generation into arm64_notify_die")
    7209c868600b ("arm64: mm: Set PSTATE.PAN from the cpu_enable_pan() call")
    736d474f0faf ("arm64: Consolidate hotplug notifier for instruction emulation")
    870828e57b14 ("arm64: kernel: Move config_sctlr_el1")
    92ff0674f5d8 ("arm64: mm: Rework unhandled user pagefaults to call arm64_force_sig_info")
    94a9e04aa16a ("arm64: alternative: Introduce feature for GICv3 CPU interface")
    9b79f52d1a70 ("arm64: Add support for hooks to handle undefined instructions")
    a4980448ed65 ("arm: Remove signal translation and exec_domain")
    bd35a4adc413 ("arm64: Port SWP/SWPB emulation support from arm")
    c852f3205846 ("arm64: Emulate CP15 Barrier instructions")
    c9453a3ab1a3 ("arm64: alternatives: fix pr_fmt string for consistency")
    e7c600f149b8 ("arm64: hwpoison: add VM_FAULT_HWPOISON[_LARGE] handling")


How should we proceed with this patch?

--
Thanks,
Sasha

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
