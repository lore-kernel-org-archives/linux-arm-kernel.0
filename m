From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 3 Dec 2012 15:43:53 -0200
Subject: mx28: BUG: spinlock bad magic on CPU#0, swapper/0
Message-ID: <CAOMZO5CVy-+t7M-5aCUe3YhaWmP8bmFd=j0sEFw049KU7=jh+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am getting the following warning on today's linux-next
(3.7.0-rc7-next-20121203) running on a i.mx28:

[    0.076125] BUG: spinlock bad magic on CPU#0, swapper/0
[    0.076218]  lock: atomic64_lock+0xc0/0x200, .magic: 00000000,
.owner: <none>/-1, .owner_cpu: 0
[    0.076312] [<c0013e78>] (unwind_backtrace+0x0/0xf0) from
[<c01be0b8>] (do_raw_spin_lock+0x70/0x140)
[    0.076406] [<c01be0b8>] (do_raw_spin_lock+0x70/0x140) from
[<c03712cc>] (_raw_spin_lock_irqsave+0x50/0x5c)
[    0.076437] [<c03712cc>] (_raw_spin_lock_irqsave+0x50/0x5c) from
[<c01c02e0>] (atomic64_add_return+0x30/0x5c)
[    0.076500] [<c01c02e0>] (atomic64_add_return+0x30/0x5c) from
[<c00e70a4>] (alloc_mnt_ns.isra.8+0x48/0xd4)
[    0.076562] [<c00e70a4>] (alloc_mnt_ns.isra.8+0x48/0xd4) from
[<c00e7270>] (create_mnt_ns+0xc/0x54)
[    0.076656] [<c00e7270>] (create_mnt_ns+0xc/0x54) from [<c04eb5a0>]
(mnt_init+0x120/0x1dc)
[    0.076687] [<c04eb5a0>] (mnt_init+0x120/0x1dc) from [<c04eb198>]
(vfs_caches_init+0xdc/0x108)
[    0.076750] [<c04eb198>] (vfs_caches_init+0xdc/0x108) from
[<c04e06e4>] (start_kernel+0x244/0x2a0)
[    0.076812] [<c04e06e4>] (start_kernel+0x244/0x2a0) from
[<40008074>] (0x40008074)
[    5.794750] BUG: spinlock lockup suspected on CPU#0, swapper/0
[    5.794812]  lock: atomic64_lock+0xc0/0x200, .magic: 00000000,
.owner: <none>/-1, .owner_cpu: 0
[    5.794875] [<c0013e78>] (unwind_backtrace+0x0/0xf0) from
[<c01be140>] (do_raw_spin_lock+0xf8/0x140)
[    5.794937] [<c01be140>] (do_raw_spin_lock+0xf8/0x140) from
[<c03712cc>] (_raw_spin_lock_irqsave+0x50/0x5c)
[    5.794968] [<c03712cc>] (_raw_spin_lock_irqsave+0x50/0x5c) from
[<c01c02e0>] (atomic64_add_return+0x30/0x5c)
[    5.795031] [<c01c02e0>] (atomic64_add_return+0x30/0x5c) from
[<c00e70a4>] (alloc_mnt_ns.isra.8+0x48/0xd4)
[    5.795093] [<c00e70a4>] (alloc_mnt_ns.isra.8+0x48/0xd4) from
[<c00e7270>] (create_mnt_ns+0xc/0x54)
[    5.795156] [<c00e7270>] (create_mnt_ns+0xc/0x54) from [<c04eb5a0>]
(mnt_init+0x120/0x1dc)
[    5.795218] [<c04eb5a0>] (mnt_init+0x120/0x1dc) from [<c04eb198>]
(vfs_caches_init+0xdc/0x108)
[    5.795250] [<c04eb198>] (vfs_caches_init+0xdc/0x108) from
[<c04e06e4>] (start_kernel+0x244/0x2a0)
[    5.795312] [<c04e06e4>] (start_kernel+0x244/0x2a0) from
[<40008074>] (0x40008074)


Is it a known issue?

Regards,

Fabio Estevam
