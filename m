From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 28 Sep 2016 11:41:41 -0600
Subject: Crash seen on ARM Juno r1 with 4.8-rc8 when Coresight is enabled
In-Reply-To: <CAGhh56EPK0BYbjV_v7cehT+yuB=L3O-AkFR2mLQMDAS66zDgDg@mail.gmail.com>
References: <CAGhh56EPK0BYbjV_v7cehT+yuB=L3O-AkFR2mLQMDAS66zDgDg@mail.gmail.com>
Message-ID: <CANLsYkypz383Smuqv3B5K3i9mzGxMdc1OJdc_tWQZ5qHWQCeJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 September 2016 at 10:35, Venkatesh Vivekanandan
<venkatesh.vivekanandan@broadcom.com> wrote:
> Hi All,
>
> I am trying to boot 4.8-rc8 in ARM Juno r1 board with coresight
> enabled and could see crash. When coresight is disabled at kernel
> config, then it boots to the linux prompt with rootfs in USB.
>
> I am using UEFI binary that came along with Juno-r1 board.
>
> Used following Image and dtb,
>
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> <------ git repo
> arch/arm64/boot/Image   <------ Kernel image
> arch/arm64/boot/dts/arm/juno-r1.dtb   <-------- dtb
>
> Attached both kernel config and complete crash log.
>
> Seen the same issue with arm64 repo also,
> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
>
> [    4.513529] atkbd serio1: keyboard reset failed on 1c070000.kmi
> [    5.479353] Unable to handle kernel NULL pointer dereference at
> virtual address 00000000
> [    5.487372] pgd = ffff000008db1000
> [    5.490739] [00000000] *pgd=00000009ffffe003,
> *pud=00000009ffffd003, *pmd=0000000000000000
> [    5.498940] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [    5.504451] Modules linked in:
> [    5.507474] CPU: 0 PID: 449 Comm: kworker/0:1 Not tainted 4.8.0-rc8-dirty #1
> [    5.514447] Hardware name: ARM Juno development board (r1) (DT)
> [    5.520310] Workqueue: events amba_deferred_retry_func
> [    5.525394] task: ffff800976bfd780 task.stack: ffff8009760bc000
> [    5.531253] PC is at strcmp+0x1c/0x160
> [    5.534962] LR is at coresight_orphan_match+0x78/0xc8
> [    5.539957] pc : [<ffff00000835f14c>] lr : [<ffff00000870231c>]
> pstate: 40000145
> [    5.547272] sp : ffff8009760bfa00
> [    5.550547] x29: ffff8009760bfa00 x28: ffff8009762c7f00
> [    5.555807] x27: ffff000008d66e46 x26: 0000000000000000
> [    5.561066] x25: 0000000000000001 x24: ffff000008702048
> [    5.566325] x23: 0000000000000000 x22: ffff800973ce5000
> [    5.571584] x21: ffff800973ce0800 x20: 0000000000000000
> [    5.576843] x19: ffff800976b08600 x18: 0000000000000000
> [    5.582101] x17: 0000000000000000 x16: ffff000008e52fff
> [    5.587360] x15: ffff000008e52fff x14: ffffffffffffffff
> [    5.592619] x13: ffff000008ca5000 x12: 0000000000000008
> [    5.597878] x11: 0000000000000020 x10: 0101010101010101
> [    5.603137] x9 : 0000000000000000 x8 : 7fff7f7f7f7f7f7f
> [    5.608396] x7 : 0000000000000000 x6 : 000000008008cb22
> [    5.613655] x5 : 22cb080000000000 x4 : ffff800973ce0828
> [    5.618914] x3 : 0000000000000000 x2 : 3030303031303032
> [    5.624173] x1 : 0000000000000000 x0 : ffff8009760f1d08
> [    5.629432]

Thanks you for reporting this Vankatesh,

Sudeep and Suzuki, can you guys help me with this - I don't have an R1
to test with.

Mathieu

>
>
> Thanks,
> Venkatesh.
