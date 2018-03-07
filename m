From: alex.shi@linaro.org (Alex Shi)
Date: Wed, 7 Mar 2018 12:43:37 +0800
Subject: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
In-Reply-To: <20180306172525.GA6618@kroah.com>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com>
 <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
 <20180302165415.GB8704@kroah.com> <20180305124638.GG8588@sirena.org.uk>
 <20180305130859.GB17802@kroah.com> <20180306142634.GC13586@sirena.org.uk>
 <20180306172525.GA6618@kroah.com>
Message-ID: <f626d6a8-41c9-7481-e21c-7b8b8fe2e277@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/07/2018 01:25 AM, Greg KH wrote:
> I suggest looking at the backports in the android-common tree that are
> needed for this "feature" to work properly, and pull them out and test
> them if you really want it in your Linaro trees.  If you think some of
> them should be added to the LTS kernels, I'll be glad to consider them,
> but don't do a hack to try to work around the lack of these features,
> otherwise you will not be happy in the long-run.
> 

Thanks for response! :)

If we want the life easy for Linaro, we don't do backporting for LTS
first, that cause more trouble to skip features which are merged in our
tree already, like kaslr, software pan. Backporting to lts first make
double trick when merge it back. We did this just because, we believe
LTS need this.

And further more, android skip tooooo much fix patch for this 2 bugs:
some main commits are following:
for metldown:

arm64: kpti: Add ->enable callback to remap swapper using nG mappings
arm64: kpti: Make use of nG dependent on arm64_kernel_unmapped_at_el0()
arm64: Turn on KPTI only on CPUs that need it

For spectre, which is totally missing in android.

arm64: Kill PSCI_GET_VERSION as a variant-2 workaround
arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support
arm/arm64: smccc: Implement SMCCC v1.1 inline primitive
arm/arm64: smccc: Make function identifiers an unsigned quantity
arm64: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling
arm64: KVM: Report SMCCC_ARCH_WORKAROUND_1 BP hardening support
arm/arm64: KVM: Turn kvm_psci_version into a static inline
arm64: KVM: Increment PC after handling an SMC trap
arm64: Implement branch predictor hardening for affected Cortex-A CPUs
arm64: entry: Apply BP hardening for suspicious interrupts from EL0
arm64: entry: Apply BP hardening for high-priority synchronous exceptions
arm64: KVM: Use per-CPU vector when BP hardening is enabled
arm64: Move BP hardening to check_and_switch_context
arm64: Add skeleton to harden the branch predictor against aliasing attacks
arm64: cpufeature: Pass capability structure to ->enable callback
arm64: uaccess: Mask __user pointers for __arch_{clear, copy_*}_user
arm64: uaccess: Don't bother eliding access_ok checks in __{get, put}_user
arm64: barrier: Add CSDB macros to control data-value prediction
arm64: alternatives: apply boot time fixups via the linear mapping

Thanks!
Alex
