From: shiraz.linux.kernel@gmail.com (shiraz hashim)
Date: Fri, 11 Feb 2011 17:01:06 +0530
Subject: reboot not working on linux-2.6.37 for ARMv7
Message-ID: <AANLkTi=FCJr-0aF0LG92PC4Q7J4R5PDU7xobnvCgDHy8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am using linux-2.6.37 on our ARM Cortex A9 (dual core) SMP platform
with PL310 as Level 2 cache. We observe that on reboot the control
is not able to reach to the arch_reset.

The problem happens when L1 cache is disabled in
arm_machine_restart, through cpu_proc_fin() and L2 cache is flushed.
L2 cache flushing takes a spinlock and our platform doesnot have monitor
support at L2 thus failing strex instruction. The strex (and hence spin locks)
behave sanely when L1 is enabled as monitor associated with SCU takes
care of it.

-- 
regards
Shiraz Hashim
