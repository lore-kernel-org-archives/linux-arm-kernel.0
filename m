Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C2FC61CE8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 23:58:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D83982086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 23:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qIgr9syM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83982086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iTXEIMjNjUfMawnYrvPpcH+iwHGfMwKtNkbbK//glAM=; b=qIgr9syMVsrccF
	ndS5GzpaadafvE47RV1pvjvWeDFden9Z2qMdfFBr3SvU0n0b/9qKAQ2AGrg29wfYzaXo3B+ZBWhYS
	TOHvVHjFwH62WTzJs13bC/uYVwBQRJI5a/mmC0LHXpKb0X1ZKFm/QIvM2gdUeudW+HB37VtevoqPr
	OeNb2JuuHwhpsWlI2+2VxL36wm9yRvKTeP04Zfu5Qnfr+CTwgemnF6Fs5a6H36vEyZxT9OyeFxAR8
	/G0cYkToSlfrrHnIwYkIgeh5HAp4aNhq8e2bTm7/fqtrEPrQ1xpmUs07hNyThWQSwkV+mAOTzLPws
	c6MXMYJOjT9lDAplpeYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gl0VZ-0006Cz-5J; Sat, 19 Jan 2019 23:58:37 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gl0VV-0006CZ-Mu
 for linux-arm-kernel@lists.infradead.org; Sat, 19 Jan 2019 23:58:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAA341596;
 Sat, 19 Jan 2019 15:58:32 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FC983F6A8;
 Sat, 19 Jan 2019 15:58:31 -0800 (PST)
Date: Sat, 19 Jan 2019 23:58:27 +0000
From: Will Deacon <will.deacon@arm.com>
To: chenwandun <chenwandun@huawei.com>
Subject: Re: [Qestion] Softlockup when send IPI to other CPUs
Message-ID: <20190119235825.GG26876@brain-police>
References: <95C141B25E7AB14BA042DCCC556C0E6501620A47@dggeml529-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <95C141B25E7AB14BA042DCCC556C0E6501620A47@dggeml529-mbx.china.huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_155833_774407_19747567 
X-CRM114-Status: GOOD (  16.87  )
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
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "Wangkefeng \(Kevin\)" <wangkefeng.wang@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 anshuman.khandual@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[+Anshuman]

On Thu, Jan 17, 2019 at 07:42:44AM +0000, chenwandun wrote:
> Recently, I do some tests on linux-4.19 and hit a softlockup issue.
> 
> I find some CPUs get the spinlock in the __split_huge_pmd function and
> then send IPI to other CPUs, waiting the response, while several CPUs
> enter the __split_huge_pmd function, want to get the spinlock, but always
> in queued_spin_lock_slowpath,
> 
> Because long time no response to the IPI, that results in a softlockup.
> 
> As to sending IPI, it was in the patch
> 3b8c9f1cdfc506e94e992ae66b68bbe416f89610.  The patch is mean to send IPI
> to each CPU after invalidating the I-cache for kernel mappings.  In this
> case, after modify pmd, it sends IPI to other CPUS to sync memory
> mappings.
> 
> No stable test case to repeat the result, it is hard to repeat the test procedure.
> 
> The environment is arm64, 64 CPUs. Except for idle CPU, there are 6 kind
> of callstacks in total.

This looks like another lockup that would be solved if we deferred our
I-cache invalidation when mapping user-executable pages, and instead
performed the invalidation off the back of a UXN permission fault, where we
could avoid holding any locks.

Will

> The callstack of 3 CPUs:
> 
>  
> 
> PID: 37265  TASK: ffff801626006c80  CPU: 9   COMMAND: "QThread"
> 
> #0 [ffff00000804bb20] __crash_kexec at ffff000008198c60
> 
> #1 [ffff00000804bcb0] panic at ffff0000080e466c
> 
> #2 [ffff00000804bd90] watchdog_timer_fn at ffff0000081cdc90
> 
> #3 [ffff00000804be10] __hrtimer_run_queues at ffff000008173c50
> 
> #4 [ffff00000804be90] hrtimer_interrupt at ffff000008174a98
> 
> #5 [ffff00000804bf00] arch_timer_handler_phys at ffff000008bd591c
> 
> #6 [ffff00000804bf20] handle_percpu_devid_irq at ffff000008155c2c
> 
> #7 [ffff00000804bf60] generic_handle_irq at ffff00000814edd8
> 
> #8 [ffff00000804bf80] __handle_domain_irq at ffff00000814f6d4
> 
> #9 [ffff00000804bfc0] gic_handle_irq at ffff0000080816cc
> 
> --- <IRQ stack> ---
> 
> #10 [ffff000034b039c0] el1_irq at ffff0000080833ec
> 
>      PC: ffff00000818d228  [smp_call_function_many+824]
> 
>      LR: ffff00000818d1e8  [smp_call_function_many+760]
> 
>      SP: ffff000034b039d0  PSTATE: 80000005
> 
>     X29: ffff000034b039d0  X28: ffff000009592184  X27: ffff801ffbf52f08
> 
>     X26: 0000000000001000  X25: 0000000000000000  X24: ffff00000818c890
> 
>     X23: 0000000000000001  X22: ffff0000095897b8  X21: ffff801ffbf52d08
> 
>     X20: ffff801ffbf52d00  X19: ffff000009592184  X18: 0000000000000000
> 
>     X17: 0000000000000000  X16: 0000000000000000  X15: 0000000000000000
> 
>     X14: 0000000000000000  X13: 0000000000100077  X12: 00280018f7e0bb53
> 
>     X11: 0000fffccb000000  X10: ffff7e005fb39940   X9: 0000000000000000
> 
>      X8: ffff801ffbf53108   X7: 0000000000000000   X6: 000000000000003f
> 
>      X5: 0000000000000000   X4: fffffffffffffdff   X3: 0000000000000000
> 
>      X2: ffff80affbea42f8   X1: 0000000000000003   X0: 0000000000000038
> 
> #11 [ffff000034b039d0] smp_call_function_many at ffff00000818d224
> 
> #12 [ffff000034b03a40] kick_all_cpus_sync at ffff00000818d36c
> 
> #13 [ffff000034b03a50] sync_icache_aliases at ffff0000080a5488
> 
> #14 [ffff000034b03a70] __sync_icache_dcache at ffff0000080a5548
> 
> #15 [ffff000034b03aa0] __split_huge_pmd_locked at ffff0000082e093c
> 
> #16 [ffff000034b03b70] __split_huge_pmd at ffff0000082e3578
> 
> #17 [ffff000034b03bc0] unmap_page_range at ffff00000829890c
> 
> #18 [ffff000034b03c70] unmap_single_vma at ffff000008298c50
> 
> #19 [ffff000034b03cb0] zap_page_range at ffff000008299068
> 
> #20 [ffff000034b03d90] __arm64_sys_madvise at ffff0000082b19f4
> 
> #21 [ffff000034b03e60] el0_svc_common at ffff0000080979dc
> 
> #22 [ffff000034b03ea0] el0_svc_handler at ffff000008097a9c
> 
> #23 [ffff000034b03ff0] el0_svc at ffff000008084044
> 
>      PC: 0000ffffb974f018   LR: 0000ffffbaca2520   SP: 0000fffccaffe3c0
> 
>     X29: 0000fffccaffe3c0  X28: 0000fffccaffebe0  X27: 000000000000000f
> 
>     X26: 0000fffcca800000  X25: 00000000007ff3c0  X24: 0000fffccb7fe1e8
> 
>     X23: 0000fffccb7fe157  X22: 0000fffccb7fe156  X21: 0000ffffbacc2000
> 
>     X20: 0000fffccb7fe1e8  X19: 0000fffccaffebe0  X18: 0000000000000000
> 
>     X17: 0000ffffb974f010  X16: 0000ffffbacc31d8  X15: 0000000000000292
> 
>     X14: 0000fffccafff2d0  X13: 000000000000005f  X12: 0000ffffb97d2000
> 
>     X11: 0000000000000007  X10: 0000ffffbacf4948   X9: 0000fffcc0000b10
> 
>      X8: 00000000000000e9   X7: 0000000000000000   X6: 0000000000000000
> 
>      X5: 00000000ffffffff   X4: 0000000000000000   X3: 0000fffcca800000
> 
>      X2: 0000000000000004   X1: 00000000007de000   X0: 0000fffcca800000
> 
> ORIG_X0: 0000fffcca800000  SYSCALLNO: e9  PSTATE: 20000000
> 
>  
> 
> The callstack of 7 CPUs:
> 
>  
> 
> PID: 37299  TASK: ffff801b522d8000  CPU: 0   COMMAND: "QThread"
> 
> #0 [ffff000008003d90] crash_save_cpu at ffff00000819904c
> 
> #1 [ffff000008003f50] handle_IPI at ffff000008096ce4
> 
> #2 [ffff000008003fc0] gic_handle_irq at ffff00000808179c
> 
> --- <IRQ stack> ---
> 
> #3 [ffff000034e43b40] el1_irq at ffff0000080833ec
> 
>      PC: ffff0000081447b0  [queued_spin_lock_slowpath+416]
> 
>      LR: ffff0000082e35dc  [__split_huge_pmd+380]
> 
>      SP: ffff000034e43b50  PSTATE: 00000005
> 
>     X29: ffff000034e43b50  X28: ffff000009313000  X27: ffff801930554a58
> 
>     X26: 0000fffca97de000  X25: 0000fffca9800000  X24: 0000000000000000
> 
>     X23: 0000000000000000  X22: ffff801930554a58  X21: ffff801f9c625b00
> 
>     X20: 0000000000280101  X19: ffff801c03fd805c  X18: 0000000000000000
> 
>     X17: 0000000000000000  X16: 0000000000000000  X15: 0000000000000000
> 
>     X14: 0000000000000000  X13: 0000000000000000  X12: 0000000000000000
> 
>     X11: 0000000000000000  X10: 0000000000000000   X9: 0000000000000000
> 
>      X8: ffff801ffbe687c0   X7: 0000000000000000   X6: ffff801ffbed07c0
> 
>      X5: 0000000000040000   X4: 0000000000000001   X3: 0000000000000000
> 
>      X2: ffff801ffbe687c0   X1: ffff00000956f000   X0: 00000000000c0001
> 
> #4 [ffff000034e43b50] queued_spin_lock_slowpath at ffff0000081447ac
> 
> #5 [ffff000034e43b70] __split_huge_pmd at ffff0000082e35d8
> 
> #6 [ffff000034e43bc0] unmap_page_range at ffff00000829890c
> 
> #7 [ffff000034e43c70] unmap_single_vma at ffff000008298c50
> 
> #8 [ffff000034e43cb0] zap_page_range at ffff000008299068
> 
> #9 [ffff000034e43d90] __arm64_sys_madvise at ffff0000082b19f4
> 
> #10 [ffff000034e43e60] el0_svc_common at ffff0000080979dc
> 
> #11 [ffff000034e43ea0] el0_svc_handler at ffff000008097a9c
> 
> #12 [ffff000034e43ff0] el0_svc at ffff000008084044
> 
>      PC: 0000ffffb974f018   LR: 0000ffffbaca2520   SP: 0000fffca97fe3c0
> 
>     X29: 0000fffca97fe3c0  X28: 0000fffca97febe0  X27: 000000000000000f
> 
>     X26: 0000fffca9000000  X25: 00000000007ff3c0  X24: 0000fffca9ffe1e8
> 
>     X23: 0000fffca9ffe157  X22: 0000fffca9ffe156  X21: 0000ffffbacc2000
> 
>     X20: 0000fffca9ffe1e8  X19: 0000fffca97febe0  X18: 0000000000000000
> 
>     X17: 0000ffffb974f010  X16: 0000ffffbacc31d8  X15: 0000000000000292
> 
>     X14: 0000000000000027  X13: ffffffffffffffff  X12: 0000fffca8ffebe0
> 
>     X11: 00000000003d0f00  X10: 0000ffffbacf4948   X9: 0000fffc88000b10
> 
>      X8: 00000000000000e9   X7: 0000000000000000   X6: 0000000000000000
> 
>      X5: 00000000ffffffff   X4: 0000000000000000   X3: 0000fffca9000000
> 
>      X2: 0000000000000004   X1: 00000000007de000   X0: 0000fffca9000000
> 
>     ORIG_X0: 0000fffca9000000  SYSCALLNO: e9  PSTATE: 20000000
> 
>  
> 
> The callstack of 6 CPUS:
> 
>  
> 
> PID: 38541  TASK: ffff8022a1a5ae80  CPU: 16  COMMAND: "QThread"
> 
> #0 [ffff00000a0abd90] crash_save_cpu at ffff00000819904c
> 
> #1 [ffff00000a0abf50] handle_IPI at ffff000008096ce4
> 
> #2 [ffff00000a0abfc0] gic_handle_irq at ffff00000808179c
> 
> --- <IRQ stack> ---
> 
> #3 [ffff00003741ba00] el1_irq at ffff0000080833ec
> 
>      PC: ffff00000818d228  [smp_call_function_many+824]
> 
>      LR: ffff00000818d1e8  [smp_call_function_many+760]
> 
>      SP: ffff00003741ba10  PSTATE: 80000005
> 
>     X29: ffff00003741ba10  X28: ffff000009592184  X27: ffff802ffbe69f08
> 
>     X26: 0000000000001000  X25: 0000000000000000  X24: ffff00000818c890
> 
>     X23: 0000000000000001  X22: ffff0000095897b8  X21: ffff802ffbe69d08
> 
>     X20: ffff802ffbe69d00  X19: ffff000009592184  X18: 0000000000000000
> 
>     X17: 0000000000000000  X16: 0000000000000000  X15: 0000000000000000
> 
>     X14: ffff8023173a8d90  X13: 0000000000000040  X12: 0000000000000228
> 
>     X11: 0000000000000000  X10: 0000000000000000   X9: 0000000000000000
> 
>      X8: ffff802ffbe6a108   X7: 0000000000000000   X6: 000000000000003f
> 
>      X5: 0000000000000000   X4: fffffffffffeffff   X3: 0000000000000000
> 
>      X2: ffff801ffbf573d8   X1: 0000000000000003   X0: 0000000000000009
> 
> #4 [ffff00003741ba10] smp_call_function_many at ffff00000818d224
> 
> #5 [ffff00003741ba80] kick_all_cpus_sync at ffff00000818d36c
> 
> #6 [ffff00003741ba90] sync_icache_aliases at ffff0000080a5488
> 
> #7 [ffff00003741bab0] __sync_icache_dcache at ffff0000080a5548
> 
> #8 [ffff00003741bae0] alloc_set_pte at ffff00000829a904
> 
> #9 [ffff00003741bb30] filemap_map_pages at ffff0000082533a8
> 
> #10 [ffff00003741bbc0] __handle_mm_fault at ffff00000829d174
> 
> #11 [ffff00003741bc90] handle_mm_fault at ffff00000829d7e8
> 
> #12 [ffff00003741bcc0] do_page_fault at ffff000008e39d8c
> 
> #13 [ffff00003741bdc0] do_translation_fault at ffff000008e3a124
> 
> #14 [ffff00003741bdf0] do_mem_abort at ffff0000080812c4
> 
> #15 [ffff00003741bff0] el0_da at ffff000008083a8c
> 
>      PC: 0000ffff9291def8   LR: 0000ffff9291e0ac   SP: 0000fffcb22d94c0
> 
>     X29: 0000fffcb22d94c0  X28: 0000fffca4125410  X27: 0000000000000009
> 
>     X26: 0000fffca405db20  X25: 0000fffca40e87a8  X24: 0000fffca414e5e0
> 
>     X23: 0000fffca413e930  X22: 0000fffca413e918  X21: 000000000000001b
> 
>     X20: 0000fffca413e808  X19: 0000000000000000  X18: 93fa57e40000ffff
> 
>     X17: 0000ffffa621ec68  X16: 0000ffff93f152c0  X15: 0000fffcb22d94a8
> 
>     X14: 0000fffcb22e22d0  X13: 000000000000000f  X12: 0000ffffa62f4000
> 
>     X11: 0000000000000002  X10: 0000000000000000   X9: 0000ffff93c8c410
> 
>      X8: 0000ffffa62f65b8   X7: 00000000000004d0   X6: 0000ffff934c5818
> 
>      X5: 0000fffca413e810   X4: 0000ffff934a6170   X3: 0000fffca413e918
> 
>      X2: 000000000000005e   X1: 0000000000000000   X0: 0000fffca413e808
> 
> ORIG_X0: 0000fffca413f000  SYSCALLNO: ffffffff  PSTATE: 80000000
> 
>  
> 
>  
> 
> The callstack of 33 CPUs:
> 
>  
> 
> PID: 37099  TASK: ffff80adb2299f00  CPU: 63  COMMAND: "QThread"
> 
> #0 [ffff00000a223d90] crash_save_cpu at ffff00000819904c
> 
> #1 [ffff00000a223f50] handle_IPI at ffff000008096ce4
> 
> #2 [ffff00000a223fc0] gic_handle_irq at ffff00000808179c
> 
> --- <IRQ stack> ---
> 
> #3 [ffff0000324bba30] el1_irq at ffff0000080833ec
> 
>      PC: ffff0000080bae74  [kvm_arch_vcpu_ioctl_run+580]
> 
>      LR: ffff0000080bae70  [kvm_arch_vcpu_ioctl_run+576]
> 
>      SP: ffff0000324bba40  PSTATE: 60000005
> 
>     X29: ffff0000324bba40  X28: ffff80af38f90000  X27: 0000000000000000
> 
>     X26: ffffff800833c538  X25: ffffff800833c53c  X24: ffff0000095ad000
> 
>     X23: ffff000009589000  X22: ffff80ad8581a000  X21: ffff80a9e5a9a000
> 
>     X20: ffff000009e61ed8  X19: ffff80a9e5a98000  X18: 0000000000000000
> 
>     X17: 0000000000000000  X16: 0000000000000000  X15: 0000000000000000
> 
>     X14: 00000000ecfc015d  X13: ffffffc26c5e5488  X12: 0000000000000000
> 
>     X11: 0000000000000006  X10: 0000000000000000   X9: ffffffc26c5e56d0
> 
>      X8: ffffffc272cd6a50   X7: 0000000001000000   X6: 00000000002a1df3
> 
>      X5: 0000000000000000   X4: 0000000000000000   X3: 0000000000001d70
> 
>      X2: ffff80af38d39438   X1: 000000000000001b   X0: 0000000000000004
> 
> #4 [ffff0000324bba40] kvm_arch_vcpu_ioctl_run at ffff0000080bae70
> 
> #5 [ffff0000324bbb00] kvm_vcpu_ioctl at ffff0000080aec04
> 
> #6 [ffff0000324bbd70] do_vfs_ioctl at ffff000008320298
> 
> #7 [ffff0000324bbe00] ksys_ioctl at ffff000008320b10
> 
> #8 [ffff0000324bbe40] __arm64_sys_ioctl at ffff000008320b4c
> 
> #9 [ffff0000324bbe60] el0_svc_common at ffff0000080979dc
> 
> #10 [ffff0000324bbea0] el0_svc_handler at ffff000008097a9c
> 
> #11 [ffff0000324bbff0] el0_svc at ffff000008084044
> 
>      PC: 0000ffffaeabed0c   LR: 00000000005ebeac   SP: 0000ffff6abea200
> 
>     X29: 0000ffff6abea200  X28: 0000000000df43d8  X27: 000000000000000f
> 
>     X26: 0000ffff6c8c6840  X25: 00000000007ff3c0  X24: 0000ffff9484c4e8
> 
>     X23: 0000ffff9484c457  X22: 0000ffff6c8be8e6  X21: 0000000000000000
> 
>     X20: 0000ffff6c8be840  X19: 0000ffffb0060000  X18: 000000000157ab30
> 
>     X17: 0000ffffaeabed00  X16: 00000000010b3a40  X15: 00000000000000f9
> 
>     X14: 0000ffff6abeb2d0  X13: 0000000000000000  X12: 0000ffff6c0c984c
> 
>     X11: 0000ffff6c0c9858  X10: 0101010101010101   X9: 0000000000000004
> 
>      X8: 000000000000001d   X7: 0000000000000001   X6: 0000000000000001
> 
>      X5: 0000000000000000   X4: 000000000114b428   X3: 0000000000000000
> 
>      X2: 0000000000000000   X1: 000000000000ae80   X0: 0000000000000022
> 
> ORIG_X0: 0000000000000022  SYSCALLNO: 1d  PSTATE: 60000000
> 
>  
> 
>  
> 
> The callstack of 1 CPU:
> 
>  
> 
> PID: 36979  TASK: ffff80a6a6ecae80  CPU: 48  COMMAND: "QThread"
> 
> #0 [ffff00000a1abd90] crash_save_cpu at ffff00000819904c
> 
> #1 [ffff00000a1abf50] handle_IPI at ffff000008096ce4
> 
> #2 [ffff00000a1abfc0] gic_handle_irq at ffff00000808179c
> 
> --- <IRQ stack> ---
> 
> #3 [ffff000033d43930] el1_irq at ffff0000080833ec
> 
>      PC: ffff0000080a51a0  [invalidate_icache_range+40]
> 
>      LR: ffff0000080be568  [invalidate_icache_guest_page+144]
> 
>      SP: ffff000033d43940  PSTATE: 80000005
> 
>     X29: ffff000033d43940  X28: 0000000000000020  X27: 0000000000000000
> 
>     X26: ffff80aabaca0000  X25: 000000a422e007fd  X24: 0000000000000000
> 
>     X23: 0000ffff1b6ac000  X22: ffff80aa043d8000  X21: 0000000000000503
> 
>     X20: 000000000a422e00  X19: 0000000000200000  X18: 0000000000000001
> 
>     X17: 00000077579c5dac  X16: 0000007757a311d0  X15: 0000000000000000
> 
>     X14: ffff7e02908b8034  X13: 0000000000000001  X12: 0000ffff5b6ac000
> 
>     X11: 0000000000000000  X10: 0000000000000041   X9: ffff80a5b7c976e0
> 
>      X8: 0000000000002218   X7: 0000000ffc000000   X6: 0000000000000018
> 
>      X5: ffff000009ffdde8   X4: ffff000009ffdc98   X3: ffff80a422f92ec0
> 
>      X2: 0000000000000040   X1: ffff80a423000000   X0: ffff80a422e00000
> 
> #4 [ffff000033d43940] invalidate_icache_range at ffff0000080a519c
> 
> #5 [ffff000033d43960] kvm_handle_guest_abort at ffff0000080c0ae4
> 
> #6 [ffff000033d43a10] handle_exit at ffff0000080c4fe0
> 
> #7 [ffff000033d43a40] kvm_arch_vcpu_ioctl_run at ffff0000080baec8
> 
> #8 [ffff000033d43b00] kvm_vcpu_ioctl at ffff0000080aec04
> 
> #9 [ffff000033d43d70] do_vfs_ioctl at ffff000008320298
> 
> #10 [ffff000033d43e00] ksys_ioctl at ffff000008320b10
> 
> #11 [ffff000033d43e40] __arm64_sys_ioctl at ffff000008320b4c
> 
> #12 [ffff000033d43e60] el0_svc_common at ffff0000080979dc
> 
> #13 [ffff000033d43ea0] el0_svc_handler at ffff000008097a9c
> 
> #14 [ffff000033d43ff0] el0_svc at ffff000008084044
> 
>      PC: 0000ffff94bd8d0c   LR: 00000000005ebeac   SP: 0000ffff4b7fe200
> 
>     X29: 0000ffff4b7fe200  X28: 0000000000df43d8  X27: 000000000000000f
> 
>     X26: 0000ffff589459b0  X25: 00000000007ff3c0  X24: 0000ffff6e7fd4e8
> 
>     X23: 0000ffff6e7fd457  X22: 0000ffff5893da56  X21: 0000000000000000
> 
>     X20: 0000ffff5893d9b0  X19: 0000ffff7c0a3000  X18: 000000000157ab30
> 
>     X17: 0000ffff94bd8d00  X16: 00000000010b3a40  X15: 000000000157ab28
> 
>     X14: 0000000000000000  X13: 3038343d79746973  X12: 6e65645f64636c2e
> 
>     X11: 0000000000000003  X10: 0000000000000004   X9: 0000000000000004
> 
>      X8: 000000000000001d   X7: 0000000000000000   X6: 0000000000000001
> 
>      X5: 0000000000000000   X4: 000000000114b428   X3: 0000000000000000
> 
>      X2: 0000000000000000   X1: 000000000000ae80   X0: 0000000000000024
> 
> ORIG_X0: 0000000000000024  SYSCALLNO: 1d  PSTATE: 60000000
> 
>  
> 
> The callstack of 1 CPU:
> 
>  
> 
> PID: 37276  TASK: ffff80ac9f3edd00  CPU: 53  COMMAND: "QThread"
> 
> #0 [ffff00000a1d3d90] crash_save_cpu at ffff00000819904c
> 
> #1 [ffff00000a1d3f50] handle_IPI at ffff000008096ce4
> 
> #2 [ffff00000a1d3fc0] gic_handle_irq at ffff00000808179c
> 
> --- <IRQ stack> ---
> 
> #3 [ffff000033f23830] el1_irq at ffff0000080833ec
> 
>      PC: ffff00000817345c  [hrtimer_active+92]
> 
>      LR: ffff000008174614  [hrtimer_try_to_cancel+52]
> 
>      SP: ffff000033f23840  PSTATE: 60000005
> 
>     X29: ffff000033f23840  X28: ffff80ad86210000  X27: ffff80ac9f3edd00
> 
>     X26: ffff000008e3309c  X25: ffff80ac9f3ee440  X24: 0000000000000001
> 
>     X23: ffff000009560018  X22: 000080aff28e2000  X21: ffff80a3b74c1e20
> 
>     X20: ffff80a3b74c1ea8  X19: ffff80a3b74c1ea8  X18: 0000000000000001
> 
>     X17: 0000007ca33c45d0  X16: 0000007ca3430be0  X15: 0000000000000000
> 
>     X14: ffff7e02901f8034  X13: 0000000000000001  X12: 0000ffff60a02000
> 
>     X11: 0000000000000003  X10: 0000000000000040   X9: ffff0000095c4008
> 
>      X8: ffff801fbb400920   X7: ffff801fbb400960   X6: 0000000000000018
> 
>      X5: ffff801fbb400920   X4: 0000000000000000   X3: 0000000000000001
> 
>      X2: 000000002035d71c   X1: ffff80affbe16e40   X0: 0000000000000000
> 
> #4 [ffff000033f23840] hrtimer_active at ffff000008173458
> 
> #5 [ffff000033f23860] hrtimer_try_to_cancel at ffff000008174610
> 
> #6 [ffff000033f238a0] hrtimer_cancel at ffff000008174780
> 
> #7 [ffff000033f238c0] phys_timer_emulate at ffff0000080dc4f0
> 
> #8 [ffff000033f238e0] kvm_timer_vcpu_load at ffff0000080dc8b8
> 
> #9 [ffff000033f23910] kvm_arch_vcpu_load at ffff0000080ba890
> 
> #10 [ffff000033f23940] kvm_sched_in at ffff0000080ad758
> 
> #11 [ffff000033f23960] finish_task_switch at ffff000008116b18
> 
> #12 [ffff000033f239a0] __schedule at ffff000008e32638
> 
> #13 [ffff000033f23a20] _cond_resched at ffff000008e33098
> 
> #14 [ffff000033f23a40] kvm_arch_vcpu_ioctl_run at ffff0000080bace4
> 
> #15 [ffff000033f23b00] kvm_vcpu_ioctl at ffff0000080aec04
> 
> #16 [ffff000033f23d70] do_vfs_ioctl at ffff000008320298
> 
> #17 [ffff000033f23e00] ksys_ioctl at ffff000008320b10
> 
> #18 [ffff000033f23e40] __arm64_sys_ioctl at ffff000008320b4c
> 
> #19 [ffff000033f23e60] el0_svc_common at ffff0000080979dc
> 
> #20 [ffff000033f23ea0] el0_svc_handler at ffff000008097a9c
> 
> #21 [ffff000033f23ff0] el0_svc at ffff000008084044
> 
>      PC: 0000ffffa15c9d0c   LR: 00000000005ebeac   SP: 0000ffff5d6d5200
> 
>     X29: 0000ffff5d6d5200  X28: 0000000000df43d8  X27: 000000000000000f
> 
>     X26: 0000ffff648c6840  X25: 00000000007ff3c0  X24: 0000ffff6f5fd4e8
> 
>     X23: 0000ffff6f5fd457  X22: 0000ffff648be8e6  X21: 0000000000000000
> 
>     X20: 0000ffff648be840  X19: 0000ffffa2b6b000  X18: 0000000000000001
> 
>     X17: 0000ffffa15c9d00  X16: 00000000010b3a40  X15: 0000000000000000
> 
>     X14: 0000ffff5d6d62d0  X13: 000000000000003f  X12: 0000ffffa1651000
> 
>     X11: 0000000000000005  X10: 00000000000000db   X9: 0000000000000004
> 
>      X8: 000000000000001d   X7: 0000000000000001   X6: 0000000000000001
> 
>      X5: 0000000000000000   X4: 000000000114b428   X3: 0000000000000000
> 
>      X2: 0000000000000000   X1: 000000000000ae80   X0: 0000000000000022
> 
> ORIG_X0: 0000000000000022  SYSCALLNO: 1d  PSTATE: 60000000
> 
>  
> 
> I will be appreciated if you could give me some suggestion.
> 
>  
> 
> Thanks,
> 
> Wandun Chen
> 
>  
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
