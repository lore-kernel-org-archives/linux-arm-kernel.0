From: labbott@redhat.com (Laura Abbott)
Date: Mon, 7 Mar 2016 16:48:44 -0800
Subject: commit dfd55ad8 breaks Seattle B0
In-Reply-To: <56DE0115.9040101@redhat.com>
References: <56DE0115.9040101@redhat.com>
Message-ID: <56DE216C.8000902@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/2016 02:30 PM, Mark Langsdorf wrote:
> Hi Ard,
>
> I get the following error when booting v4.5-rc7 on Seattle B0
> using the same config file that boots successfully on v4.5-rc6.
>
> Removing commit dfd55ad8 allows v4.5-rc7+ to boot successfully.
>

Just as a note, Greg has this queued up for 4.4.5 stable. You should
let him know if this should be dropped by Thur Mar 10.

Thanks,
Laura

> --Mark Langsdorf
>
> [    0.000000] cma: Reserved 512 MiB at 0x00000080e0000000
> [    0.000000] Unable to handle kernel paging request at virtual address fffffd0
> [    0.000000] pgd = fffffe0001320000
> [    0.000000] [fffffdff60ff0000] *pgd=00000083fffa0003, *pud=00000083fffa0003,0
> [    0.000000] Internal error: Oops: 96000007 [#1] SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.5.0-rc7.upstream #4
> [    0.000000] Hardware name: AMD Seattle (RevB) Development Board (Overdrive) )
> [    0.000000] task: fffffe0000b72280 ti: fffffe0000b30000 task.ti: fffffe0000b
> [    0.000000] PC is at memmap_init_zone+0xd4/0x11c
> [    0.000000] LR is at memmap_init_zone+0xb4/0x11c
> [    0.000000] pc : [<fffffe0000a95a60>] lr : [<fffffe0000a95a40>] pstate: 8000
> [    0.000000] sp : fffffe0000b33d50
> [    0.000000] x29: fffffe0000b33d50 x28: 0000000000000001
> [    0.000000] x27: fffffe000094b8e8 x26: fffffe0000aba9c0
> [    0.000000] x25: fffffe0000b60000 x24: 0000000000840000
> [    0.000000] x23: 0000000000000000 x22: 4000000000000000
> [    0.000000] x21: 0000000000000001 x20: 00000000ffffffff
> [    0.000000] x19: 000000000083fd00 x18: 0000000000000009
> [    0.000000] x17: 0000008400000000 x16: 0000000000000008
> [    0.000000] x15: 0000000000000018 x14: 00000083ffe50000
> [    0.000000] x13: fffffe00012a0a18 x12: 0000000000180000
> [    0.000000] x11: 0000000700000008 x10: 00000083fffd8780
> [    0.000000] x9 : 0000000000000000 x8 : fffffe03fefde780
> [    0.000000] x7 : 00000000045a0000 x6 : fffffe000129fe18
> [    0.000000] x5 : 0000000000001d00 x4 : 0000000000000009
> [    0.000000] x3 : fffffdff60000000 x2 : 0000000000ff0000
> [    0.000000] x1 : 0000000000000001 x0 : 0000000000000001
> [    0.000000]
> [    0.000000] Process swapper (pid: 0, stack limit = 0xfffffe0000b30020)
> [    0.000000] Stack: (0xfffffe0000b33d50 to 0xfffffe0000b34000)
> [    0.000000] 3d40:                                   fffffe0000b33da0 fffffe0c
> [    0.000000] 3d60: fffffe0000c5cb80 000000000002ff40 fffffe0000c5d188 fffffe00
> [    0.000000] 3d80: fffffe0000b16d90 fffffe000073c808 0000000000030000 fffffe00
> [    0.000000] 3da0: fffffe0000b33e30 fffffe0000a54f58 fffffe0000b60000 fffffe00
> [    0.000000] 3dc0: 0000000000840000 0000000000800100 0000000000000018 fffffe00
> [    0.000000] 3de0: fffffe0000c90000 0000008002320000 fffffe0000081198 0000008c
> [    0.000000] 3e00: 0000000000030000 fffffe000094b9a8 fffffe000094b918 fffffe00
> [    0.000000] 3e20: 0000000000081198 0000000000810000 fffffe0000b33ea0 fffffe08
> [    0.000000] 3e40: fffffe000129fef0 0000000000000018 fffffe0000bbc000 fffffe00
> [    0.000000] 3e60: fffffe0000935820 fffffe0000a55200 000000000000ff00 00000000
> [    0.000000] 3e80: 0000000000000000 0000000000000000 0000000000000000 00000000
> [    0.000000] 3ea0: fffffe0000b33f00 fffffe0000a52ee0 fffffdfffa800000 fffffe08
> [    0.000000] 3ec0: fffffe0000080000 fffffe0000b60000 fffffe0000b60000 00000080
> [    0.000000] 3ee0: fffffdfffa800000 fffffe03feff0000 fffffe0000080000 00000080
> [    0.000000] 3f00: fffffe0000b33fa0 fffffe0000a50684 0000000000000000 fffffe08
> [    0.000000] 3f20: 000000801fe00000 00000083f0f15228 fffffe0000b60000 00000080
> [    0.000000] 3f40: 00000080022f0000 0000008002320000 fffffe0000081198 00000008
> [    0.000000] 3f60: 00000083f0f155a0 fffffe00007200b0 0000000000000001 00000080
> [    0.000000] 3f80: ffffffffffffffff 8080808000000000 0000000080808080 fefefeff
> [    0.000000] 3fa0: 0000000000000000 fffffe00000811b4 00000083f0f155a0 00000002
> [    0.000000] 3fc0: 000000801fe00000 00000083f0f15228 00000083f0f1523d 00000080
> [    0.000000] 3fe0: 0000000000000000 fffffe0000a98628 0000000000000000 00000000
> [    0.000000] Call trace:
> [    0.000000] Exception stack(0xfffffe0000b33b90 to 0xfffffe0000b33cb0)
> [    0.000000] 3b80:                                   000000000083fd00 0000000f
> [    0.000000] 3ba0: fffffe0000b33d50 fffffe0000a95a60 00000083fffd8780 00000000
> [    0.000000] 3bc0: 0000000000000018 0000000000000000 fffffe0000b33c40 fffffe04
> [    0.000000] 3be0: 00000083fffd8780 0000000000006000 fffffe0000a6ac78 00000000
> [    0.000000] 3c00: 0000000000000000 0000000000000000 0000000000010000 fffffe00
> [    0.000000] 3c20: fffffe000094e9c8 00000083fffd8780 0000000000000001 00000001
> [    0.000000] 3c40: 0000000000ff0000 fffffdff60000000 0000000000000009 00000000
> [    0.000000] 3c60: fffffe000129fe18 00000000045a0000 fffffe03fefde780 00000000
> [    0.000000] 3c80: 00000083fffd8780 0000000700000008 0000000000180000 fffffe08
> [    0.000000] 3ca0: 00000083ffe50000 0000000000000018
> [    0.000000] [<fffffe0000a95a60>] memmap_init_zone+0xd4/0x11c
> [    0.000000] [<fffffe0000a95d1c>] free_area_init_node+0x274/0x2bc
> [    0.000000] [<fffffe0000a54f58>] bootmem_init+0x158/0x198
> [    0.000000] [<fffffe0000a55368>] paging_init+0xec/0x1a4
> [    0.000000] [<fffffe0000a52ee0>] setup_arch+0x110/0x5a4
> [    0.000000] [<fffffe0000a50684>] start_kernel+0xac/0x3e0
> [    0.000000] [<fffffe00000811b4>] 0xfffffe00000811b4
> [    0.000000] Code: cb424262 f2dfbfe3 d37ae442 f2ffffe3 (f8636840)
> [    0.000000] ---[ end trace cb88537fdc8fa200 ]---
> [    0.000000] Kernel panic - not syncing: Fatal exception
> [    0.000000] ---[ end Kernel panic - not syncing: Fatal exception
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
