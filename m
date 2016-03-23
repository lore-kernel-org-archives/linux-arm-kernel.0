From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 23 Mar 2016 11:12:41 +0800
Subject: Question about PCI I/O space in ARM64
Message-ID: <56F209A9.4040304@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all?

If no pci, the PCI I/O space(16M) is mapped into an irrelevant mem space(right ?), not a right IO space,
that is, no one call pci_remap_iospace() to remap the memory mapped I/O space, once driver
like f71805f loaded, write value to IO space(see f71805f_init->f71805f_find->superio_enter->outb),
we met following oops,
------------------------
Unable to handle kernel paging request at virtual address ffffffbffee0002e
pgd = ffffffc1d68d4000
[ffffffbffee0002e] *pgd=0000000000000000, *pud=0000000000000000
Internal error: Oops: 94000046 [#1] PREEMPT SMP
Modules linked in: f71805f(+) hwmon
CPU: 3 PID: 1659 Comm: insmod Not tainted 4.5.0+ #88
Hardware name: linux,dummy-virt (DT)
task: ffffffc1f6665400 ti: ffffffc1d6418000 task.ti: ffffffc1d6418000
PC is at f71805f_find+0x6c/0x358 [f71805f]
------------------------

I am not clear about PCI I/O, but if this is indeed a bug, how to solve this issue,
any advice will be appreciated.

Thanks
Kefeng
