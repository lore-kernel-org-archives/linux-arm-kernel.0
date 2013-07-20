From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 20 Jul 2013 18:58:55 +0200
Subject: [RESEND PATCH v7 00/22] MBus DT binding: The return of PCIe
In-Reply-To: <1373900271-4722-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373900271-4722-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130720165855.GB26625@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 11:57:29AM -0300, Ezequiel Garcia wrote:
> Here's the new MBus DT binding, implementing the changes proposed
> by Thomas when we discussed the previous patchset:
> 
>   http://www.spinics.net/lists/arm-kernel/msg257170.html
> 
> As far as I know, this round fixes *all* the concerns raised in the past
> and therefore I'd like to get Acked-by's from all the parties involved
> on the respective patches, and particularly for the DT binding.
> 
> If there's anything left to review, we'll be glad to fix it quickly,
> so don't hesitate in providing your feedback!
> 
> I'm sure many of you are dying to test this new MBus thing, so to make
> it easier for those courageous enough, I've pushed a public branch:
> 
>   https://github.com/MISL-EBU-System-SW/mainline-public/tree/marvell-mvebu-mbus-v7

Hi Ezequiel

I just tried this in my Kirkwood QNAP.

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 3.11.0-rc1-00022-g44e8c39 (lunn at londo.lunn.ch) (gcc version 4.3.43
CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
CPU: VIVT data cache, VIVT instruction cache
Machine: Marvell Kirkwood (Flattened Device Tree), model: QNAP TS219 family
bootconsole [earlycon0] enabled
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: root=/dev/sda2 console=ttyS0,115200 earlyprintk
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 513268K/524288K available (4247K kernel code, 241K rwdata, 1148K rodata)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
    lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc054d050   (5397 kB)
      .init : 0xc054e000 - 0xc0576520   ( 162 kB)
      .data : 0xc0578000 - 0xc05b4420   ( 242 kB)
       .bss : 0xc05b4420 - 0xc064e104   ( 616 kB)
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Preemptible hierarchical RCU implementation.
NR_IRQS:114
sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 21474ms
Console: colour dummy device 80x30
Calibrating delay loop... 1587.60 BogoMIPS (lpj=7938048)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0xc040e888 - 0xc040e8c4
pinctrl core: initialized pinctrl subsystem
regulator-dummy: no parameters
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
Kirkwood: MV88F6282-Rev-A0, TCLK=200000000.
Feroceon L2: Enabling L2
Feroceon L2: Cache support initialised.
bio: create slab <bio-0> at 0
mvebu-pcie pcie-controller.1: PCIe0.0: cannot get tgt/attr for mem window
mvebu-pcie pcie-controller.1: PCIe1.0: cannot get tgt/attr for mem window
Unable to handle kernel paging request at virtual address 00001804
pgd = c0004000
[00001804] *pgd=00000000
Internal error: Oops: 805 [#1] PREEMPT ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 3.11.0-rc1-00022-g44e8c39 #35
task: df848000 ti: df84a000 task.ti: df84a000
PC is at mvebu_pcie_setup+0x84/0x2b4
LR is at mvebu_pcie_setup+0x74/0x2b4
pc : [<c05622e4>]    lr : [<c05622d4>]    psr: 20000053
sp : df84bd70  ip : 00000000  fp : 00000000
r10: 00000000  r9 : c06435f4  r8 : df84be0c
r7 : 00000000  r6 : df8359d0  r5 : df9e8410  r4 : df9e7180
r3 : 00001804  r2 : 00000000  r1 : ffffffe0  r0 : c06435f4
Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005397f  Table: 00004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xdf84a1b8)
Stack: (0xdf84bd70 to 0xdf84c000)
bd60:                                     df801e00 00000000 df8f8a10 df9e7180
bd80: df9e71a0 df8f8a00 00000000 df84be0c 00000000 00000000 df84bdb0 c000d438
bda0: 00000018 c0206e58 c04db1d8 00000000 df84bdb0 df84bdb0 df9e8410 df9e8410
bdc0: df8359d0 df8f8a00 df8f8a10 00000000 00000000 c0c89170 df9e8410 c0561f98
bde0: df9e842c df911fa0 0000a1ff 00007846 000011ab 00000604 df84be0c 00000000
be00: 00000000 00000000 00000000 c059615c 00000001 df84be34 c0562260 c01d3468
be20: 00000000 00000000 00000000 c0562230 c01d2b88 df8359d0 00000000 df8f8a10
be40: df8f8a10 00000000 c059611c c0646070 c054e380 00000000 c05b4434 c020bdd8
be60: 00000000 c020ac28 df8f8a10 df8f8a44 c059611c c020adb8 c0561d0c c020ae44
be80: 00000000 df84be90 c059611c c02093f8 df80de8c df8f9e10 df9e72d4 df804b00
bea0: df9e72a0 c059611c c059dc50 c0209c3c c04d7b78 c01cf608 c0596108 c0596108
bec0: c059611c 00000005 0000009c c020b208 00000000 c0596108 c056f73c 00000005
bee0: 0000009c c020c0e8 c05760f8 c056f73c 00000005 c0008684 c0411b70 c0638b64
bf00: 0000003f 00000000 00000000 00000000 60000053 00000000 00000000 00000000
bf20: 00000000 0000009c c052e7cc c003482c 00000004 00000004 c052de0c c0c899ef
bf40: c0589738 c05760a0 c056f73c c05760f8 c056f73c 00000005 0000009c c05b4420
bf60: c056f70c c054e2ac 00000004 00000004 c054e380 ffffffff ffffffff 00000000
bf80: c04059f4 00000000 00000000 00000000 00000000 00000000 00000000 c0405a00
bfa0: 00000000 00000000 c04059f4 c0009330 00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffffff
[<c05622e4>] (mvebu_pcie_setup+0x84/0x2b4) from [<c000d438>] (pci_common_init_d)
[<c000d438>] (pci_common_init_dev+0xb8/0x2fc) from [<c0561f98>] (mvebu_pcie_pro)
[<c0561f98>] (mvebu_pcie_probe+0x278/0x510) from [<c020bdd8>] (platform_drv_pro)
[<c020bdd8>] (platform_drv_probe+0x1c/0x24) from [<c020ac28>] (driver_probe_dev)
[<c020ac28>] (driver_probe_device+0x90/0x220) from [<c020ae44>] (__driver_attac)
[<c020ae44>] (__driver_attach+0x8c/0x90) from [<c02093f8>] (bus_for_each_dev+0x)
[<c02093f8>] (bus_for_each_dev+0x74/0x98) from [<c0209c3c>] (bus_add_driver+0xe)
[<c0209c3c>] (bus_add_driver+0xe8/0x238) from [<c020b208>] (driver_register+0x5)
[<c020b208>] (driver_register+0x5c/0x14c) from [<c020c0e8>] (platform_driver_pr)
[<c020c0e8>] (platform_driver_probe+0x1c/0xac) from [<c0008684>] (do_one_initca)
[<c0008684>] (do_one_initcall+0x2c/0x160) from [<c054e2ac>] (kernel_init_freeab)
[<c054e2ac>] (kernel_init_freeable+0xf4/0x1c8) from [<c0405a00>] (kernel_init+0)
[<c0405a00>] (kernel_init+0xc/0x164) from [<c0009330>] (ret_from_fork+0x14/0x24)
Code: e5953004 e1a09000 e2833b06 e2833004 (e583a000) 
---[ end trace 939c05c25cac6ec3 ]---


     Andrew
