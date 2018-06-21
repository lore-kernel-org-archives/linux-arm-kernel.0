From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 21 Jun 2018 10:00:38 +0100
Subject: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
In-Reply-To: <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
Message-ID: <5fb40691-e887-a446-8e84-bfdfeaae2e78@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/06/18 09:38, James Morse wrote:

>> (joyx at Turing-Arch-b) (gcc version 4.9.1 20140505 (prerelease) (crosstool-NG
>> linaro-1.13.1-4.9-2014.05 - Linaro GCC 4.9-2014.05)) #10 SMP PREEMPT Wed Jun 20
>> 23:59:05 CST 2018
> 
>> ??? [??? 0.000000] CPU0: using LPI pending table @0x000000007d860000
>> ??? [??? 0.000000] GIC: PPI11 is secure or misconfigured
>> ??? [??? 0.000000] arch_timer: WARNING: Invalid trigger for IRQ3, assuming level
>> low
>> ??? [??? 0.000000] arch_timer: WARNING: Please fix your firmware
>> ??? [??? 0.000000] arch_timer: cp15 timer(s) running at 100.00MHz (virt).
> 
> (No idea what these mean, but I doubt they are relevant)

Old (and buggy) QEMU. Nothing to worry about, the kernel (and the vgic)
will do the right thing. A modern QEMU presents the guest with a fixed
DT, removing the warning altogether.

Nothing to do with the issue at hand anyway.

	M.
-- 
Jazz is not dead. It just smells funny...
