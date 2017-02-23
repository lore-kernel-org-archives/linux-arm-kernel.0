From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Thu, 23 Feb 2017 15:34:22 -0600
Subject: [PATCH v2] arm64: Fix the kernel panic() on QDF2400 platform
In-Reply-To: <a6fa565f-28ce-f488-dd1e-b5d010c6409a@codeaurora.org>
References: <1487880125-1371-1-git-send-email-shankerd@codeaurora.org>
 <4d97310a-4b91-07ac-1ce0-faacb8da03b0@codeaurora.org>
 <3fb32277-9d9e-c84d-4e98-c19ace690433@codeaurora.org>
 <a6fa565f-28ce-f488-dd1e-b5d010c6409a@codeaurora.org>
Message-ID: <6eae1d36-621e-4b6c-b2f0-1862f4847c92@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Timur,


On 02/23/2017 03:11 PM, Timur Tabi wrote:
> On 02/23/2017 03:05 PM, Shanker Donthineni wrote:
>> Why do you want keep 'pre_ttbr0_update_workaround' in subject, nothing
>> wrong with macro definition itself. Problem with the caller, not passing
>> the right arguments.
>
> Ok, how about this:
>
> arm64: qcom: do not use x1 when calling pre_ttbr0_update_workaround
>
> "Fix the kernel panic() on QDF2400 platform" could mean almost 
> anything. There could plenty of future kernel panics on the QDF2400.
>
> Also, I think our legal review would insist on saying "Qualcomm 
> Technologies QDF2400", which would make the line too long.
>

I don't understand why do you want to insert keyword 'qcom' in subject. 
None of the commits "git log --oneline arch/arm64/mm/proc.S" shows 
platform specific keywords.
I would like to see comments from Will Deacon, and follow his suggestions.

38fd94b arm64: Work around Falkor erratum 1003
f33bcf0 arm64: Factor out TTBR0_EL1 post-update workaround into a 
specific asm macro
623b476 arm64: move sp_el0 and tpidr_el1 into cpu_suspend_ctx
6ba3b55 arm64: use alternative auto-nop
744c6c3 arm64: kernel: Fix unmasked debug exceptions when restoring 
mdscr_el1
b611303 arm64: vmlinux.ld: Add mmuoff data sections and move mmuoff text 
into idmap
2ce39ad arm64: debug: unmask PSTATE.D earlier
cabe1c8 arm64: Change cpu_resume() to enable mmu early then access 
sleep_sp by va
7b7293a arm64: Fold proc-macros.S into assembler.h
104a0c0 arm64: Add workaround for Cavium erratum 27456
50e1881 arm64: mm: add code to safely replace TTBR1_EL1
f436b2a arm64: kernel: fix architected PMU registers unconditional access
60792ad arm64: kernel: enforce pmuserenr_el0 initialization and restore
f00083c arm64: mm: place __cpu_setup in .text
44eaacf arm64: Add 16K page size support
5aec715 arm64: mm: rewrite ASID allocator and MM context-switching code
fa7aae8 arm64: proc: de-scope TLBI operation during cold boot
d8d23fa arm64: mdscr_el1: avoid exposing DCC to userspace
8d446c8 arm64/mm: Add PROT_DEVICE_nGnRnE and PROT_NORMAL_WT
8ec4198 arm64: mm: ensure patched kernel text is fetched from PoU
4b3dc96 arm64: force CONFIG_SMP=y and remove redundant #ifdefs
2f4b829 arm64: Add support for hardware updates of the access and dirty 
pte bits

Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
