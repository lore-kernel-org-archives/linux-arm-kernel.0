From: stillcompiling@gmail.com (Joshua Clayton)
Date: Thu, 28 May 2015 14:32:26 -0700
Subject: imx6q 3.19 kernel lockup on insert usb media
Message-ID: <2690278.XpNKcxs18p@jclayton-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Running a yocto rootfs, which automounts usb storage.
After inserting a usb stick, I got this oops, followed immediately by a hard 
lockup of the system.

-- 
~Joshua Clayton
-------------- next part --------------
[   45.630521] Unable to handle kernel paging request at virtual address efa4c914
[   45.637779] pgd = ece9c000
[   45.640494] [efa4c914] *pgd=00000000
[   45.644095] Internal error: Oops: 5 [#1] SMP ARM
[   45.648719] Modules linked in: powerboard(O) evi_fpga_driver(O)
[   45.654698] CPU: 3 PID: 206 Comm: udevd Tainted: G           O   3.19.0uniwest-evi+ #100
[   45.662793] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   45.669329] task: ece81380 ti: ecc4c000 task.ti: ecc4c000
[   45.674749] PC is at __rmqueue+0x80/0x3bc
[   45.678765] LR is at 0x3
[   45.681307] pc : [<800b5c50>]    lr : [<00000003>]    psr: 200f0093
[   45.681307] sp : ecc4dcf8  ip : ecc4dd40  fp : ecc4dd3c
[   45.692789] r10: 00000000  r9 : efa4c914  r8 : 80a4d540
[   45.698019] r7 : 00000000  r6 : ef5975f4  r5 : 0000001f  r4 : 0000000e
[   45.704551] r3 : 80a4d67c  r2 : 00000034  r1 : 00000000  r0 : 80a4d540
[   45.711084] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   45.718311] Control: 10c5387d  Table: 7ce9c04a  DAC: 00000015
[   45.724062] Process udevd (pid: 206, stack limit = 0xecc4c238)
[   45.729900] Stack: (0xecc4dcf8 to 0xecc4e000)
[   45.734272] dce0:                                                       6ddd3000 00000000
[   45.742478] dd00: 80a4d5c0 00000000 00000034 80a4d540 80703550 0000000e 0000001f ef5975f4
[   45.750682] dd20: 00000000 80a4d540 808a9770 00000000 ecc4ddc4 ecc4dd40 800b6484 800b5bdc
[   45.758886] dd40: 00000141 00041f7b 80a4e204 00000000 00000000 00000000 6ddd3000 809e92fc
[   45.767089] dd60: ee7bc2fc 00000001 00000100 80a4d5c0 ee7bc308 80a4e20c 000280d0 00000000
[   45.775294] dd80: ffffffff 00000000 809f0d80 600f0013 00000000 80a4d540 ecc4dec8 000080d0
[   45.783497] dda0: 00000000 80a4e200 00000141 00000000 00000000 00000000 ecc4de74 ecc4ddc8
[   45.791700] ddc0: 800b6944 800b5f98 00000000 00000141 80a4d540 00000000 00000000 00000000
[   45.799905] dde0: 00000000 0000001c ecc4de7c ecc4ddf8 80060748 8005f6dc 80111164 edde0398
[   45.808108] de00: ecc4dec0 00000000 ecc4de68 ecc4dec0 ffffff9c ece817d0 0000001c 00000000
[   45.816312] de20: ece817d8 00000010 ece81380 00000000 400f0013 ffffff9c 80a4d540 ecc4de48
[   45.824516] de40: 8005ff6c 8005fda8 00000000 eb424c38 eb424c38 ffffff9c ecc4dec8 ecc4df5c
[   45.832719] de60: eb4cca78 00000400 ecc4de84 ecc4de78 800b71f0 800b6854 ecc4de94 ecc4de88
[   45.840923] de80: 800b7224 800b71e4 ecc4dec4 ecc4de98 80159940 800b7218 80159924 00000400
[   45.849127] dea0: eb424c38 ffffff9c 7e8c9278 ecc4df5c eb4cca78 00000400 ecc4df44 ecc4dec8
[   45.857329] dec0: 800fc008 80159930 ecc4df18 edb18000 ecc4df18 7e8c8e78 ecc4df5c eb4cca78
[   45.865532] dee0: ecc4df14 ecc4def0 80079668 800812a4 553db665 04c4b404 00000000 00000000
[   45.873736] df00: ee26f0d0 ecc4df18 ecc4df44 ecc4df18 8010c2f8 80079654 553db665 04c4b404
[   45.881940] df20: 553db665 04c4b404 ffffffea 00004000 ffffff9c 7e8c8e78 ecc4df94 ecc4df48
[   45.890143] df40: 800f72a8 800fbfdc ecc4df5c 8000f944 ecc4df7c 7e8c9278 8005ff6c 00000000
[   45.898346] df60: ee26f0d0 eb424c38 7e8c8ec7 7e8c8e78 7e8c9278 7e8c9690 00000055 8000f944
[   45.906549] df80: ecc4c000 00000000 ecc4dfa4 ecc4df98 800f7318 800f7218 00000000 ecc4dfa8
[   45.914752] dfa0: 8000f780 800f7300 7e8c8e78 7e8c9278 7e8c8e78 7e8c9278 00000400 7e8c8ec7
[   45.922956] dfc0: 7e8c8e78 7e8c9278 7e8c9690 00000055 000313dc 00031420 012e31b0 7e8ce230
[   45.931159] dfe0: 00031208 7e8c8e64 0001d6b4 76e901cc 600f0010 7e8c8e78 dfcfe7f4 fffddbde
[   45.939349] Backtrace: 
[   45.941860] [<800b5bd0>] (__rmqueue) from [<800b6484>] (get_page_from_freelist+0x4f8/0x6cc)
[   45.950228]  r10:00000000 r9:808a9770 r8:80a4d540 r7:00000000 r6:ef5975f4 r5:0000001f
[   45.958201]  r4:0000000e
[   45.960793] [<800b5f8c>] (get_page_from_freelist) from [<800b6944>] (__alloc_pages_nodemask+0xfc/0x990)
[   45.970203]  r10:00000000 r9:00000000 r8:00000000 r7:00000141 r6:80a4e200 r5:00000000
[   45.978171]  r4:000080d0
[   45.980761] [<800b6848>] (__alloc_pages_nodemask) from [<800b71f0>] (__get_free_pages+0x18/0x34)
[   45.989563]  r10:00000400 r9:eb4cca78 r8:ecc4df5c r7:ecc4dec8 r6:ffffff9c r5:eb424c38
[   45.997532]  r4:eb424c38
[   46.000121] [<800b71d8>] (__get_free_pages) from [<800b7224>] (get_zeroed_page+0x18/0x1c)
[   46.008337] [<800b720c>] (get_zeroed_page) from [<80159940>] (kernfs_iop_follow_link+0x1c/0x194)
[   46.017160] [<80159924>] (kernfs_iop_follow_link) from [<800fc008>] (generic_readlink+0x38/0x94)
[   46.025961]  r10:00000400 r9:eb4cca78 r8:ecc4df5c r7:7e8c9278 r6:ffffff9c r5:eb424c38
[   46.033930]  r4:00000400 r3:80159924
[   46.037582] [<800fbfd0>] (generic_readlink) from [<800f72a8>] (SyS_readlinkat+0x9c/0xe8)
[   46.045689]  r7:7e8c8e78 r6:ffffff9c r5:00004000 r4:ffffffea
[   46.051471] [<800f720c>] (SyS_readlinkat) from [<800f7318>] (SyS_readlink+0x24/0x28)
[   46.059230]  r10:00000000 r9:ecc4c000 r8:8000f944 r7:00000055 r6:7e8c9690 r5:7e8c9278
[   46.067197]  r4:7e8c8e78
[   46.069789] [<800f72f4>] (SyS_readlink) from [<8000f780>] (ret_fast_syscall+0x0/0x4c)
[   46.077647] Code: e2833020 0a00002f e51b2034 e51b0030 (e599c000) 
[   46.083772] ---[ end trace f338577b30f41dca ]---
[   48.494492] BUG: spinlock lockup suspected on CPU#1, kthreadd/2
[   48.500466]  lock: contig_page_data+0x80/0xd80, .magic: dead4ead, .owner: udevd/206, .owner_cpu: 3
[   48.509453] CPU: 1 PID: 2 Comm: kthreadd Tainted: G      D    O   3.19.0uniwest-evi+ #100
[   48.517649] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   48.524193] Backtrace: [   48.524453] BUG: spinlock lockup suspected on CPU#2, evi_ctrl/746
[   48.524480]  lock: contig_page_data+0x80/0xd80, .magic: dead4ead, .owner: udevd/206, .owner_cpu: 3

[   48.541540] 
[   48.543267] [<80013170>] (dump_backtrace) from [<8001338c>] (show_stack+0x18/0x1c)
[   48.550854]  r6:80a0e294 r5:00000000 r4:00000000 r3:00000000
[   48.556648] [<80013374>] (show_stack) from [<806fc6f0>] (dump_stack+0x8c/0xa4)
[   48.563909] [<806fc664>] (dump_stack) from [<80065608>] (spin_dump+0x7c/0xa4)
[   48.571060]  r6:0039911c r5:80a4d5c0 r4:ece81380 r3:00000000
[   48.576847] [<8006558c>] (spin_dump) from [<800657bc>] (do_raw_spin_lock+0xf4/0x1b8)
[   48.584605]  r5:80a0e27c r4:80a4d5c0
[   48.588265] [<800656c8>] (do_raw_spin_lock) from [<80703690>] (_raw_spin_lock_irqsave+0x50/0x5c)
[   48.597066]  r9:808a9770 r8:80a4d540 r7:00000141 r6:800b62a4 r5:400f0013 r4:80a4d5c0
[   48.604976] [<80703640>] (_raw_spin_lock_irqsave) from [<800b62a4>] (get_page_from_freelist+0x318/0x6cc)
[   48.614472]  r6:80a4e200 r5:00000000 r4:80a4d5c0
[   48.619194] [<800b5f8c>] (get_page_from_freelist) from [<800b6944>] (__alloc_pages_nodemask+0xfc/0x990)
[   48.628603]  r10:00000000 r9:00000001 r8:00000000 r7:00000141 r6:80a4e200 r5:00000000
[   48.636569]  r4:002000d0
[   48.639158] [<800b6848>] (__alloc_pages_nodemask) from [<800b72a4>] (alloc_kmem_pages_node+0x20/0x28)
[   48.648393]  r10:edb91d40 r9:ffffffff r8:00000000 r7:80a5d500 r6:00000000 r5:ee0789c0
[   48.656359]  r4:00800711
[   48.658954] [<800b7284>] (alloc_kmem_pages_node) from [<80026a98>] (copy_process.part.57+0xd4/0x153c)
[   48.668203] [<800269c4>] (copy_process.part.57) from [<8002805c>] (do_fork+0xa8/0x40c)
[   48.676135]  r10:00000001 r9:ee082000 r8:00000000 r7:00000000 r6:80a0006c r5:00000000
[   48.684101]  r4:00800711
[   48.686685] [<80027fb4>] (do_fork) from [<800283f0>] (kernel_thread+0x30/0x38)
[   48.693923]  r10:00000001 r9:ee082000 r8:00000000 r7:80a0008c r6:80a0006c r5:ec1e8180
[   48.701889]  r4:ec1e8194
[   48.704485] [<800283c0>] (kernel_thread) from [<80044378>] (kthreadd+0xf0/0x160)
[   48.711915] [<80044288>] (kthreadd) from [<8000f850>] (ret_from_fork+0x14/0x24)
[   48.719239]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:80044288
[   48.727205]  r4:00000000 r3:00000000
[   48.730851] CPU: 2 PID: 746 Comm: evi_ctrl Tainted: G      D    O   3.19.0uniwest-evi+ #100
[   48.739225] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   48.745768] Backtrace: 
[   48.748277] [<80013170>] (dump_backtrace) from [<8001338c>] (show_stack+0x18/0x1c)
[   48.755865]  r6:80a0e294 r5:00000000 r4:00000000 r3:00000000
[   48.761652] [<80013374>] (show_stack) from [<806fc6f0>] (dump_stack+0x8c/0xa4)
[   48.768908] [<806fc664>] (dump_stack) from [<80065608>] (spin_dump+0x7c/0xa4)
[   48.776060]  r6:0039911c r5:80a4d5c0 r4:ece81380 r3:00000000
[   48.781845] [<8006558c>] (spin_dump) from [<800657bc>] (do_raw_spin_lock+0xf4/0x1b8)
[   48.789604]  r5:80a0e27c r4:80a4d5c0
[   48.793261] [<800656c8>] (do_raw_spin_lock) from [<80703690>] (_raw_spin_lock_irqsave+0x50/0x5c)
[   48.802062]  r9:808a9770 r8:80a4d540 r7:00000141 r6:800b62a4 r5:600f0013 r4:80a4d5c0
[   48.809966] [<80703640>] (_raw_spin_lock_irqsave) from [<800b62a4>] (get_page_from_freelist+0x318/0x6cc)
[   48.819462]  r6:80a4e200 r5:00000000 r4:80a4d5c0
[   48.824183] [<800b5f8c>] (get_page_from_freelist) from [<800b6944>] (__alloc_pages_nodemask+0xfc/0x990)
[   48.833591]  r10:00000000 r9:00000002 r8:00000000 r7:00000141 r6:80a4e200 r5:00000000
[   48.841557]  r4:000146d0
[   48.844143] [<800b6848>] (__alloc_pages_nodemask) from [<800b727c>] (alloc_kmem_pages+0x18/0x20)
[   48.852944]  r10:00003ee3 r9:00000000 r8:00003fc0 r7:80585314 r6:000106d0 r5:000004d0
[   48.860910]  r4:ec089b17
[   48.863498] [<800b7264>] (alloc_kmem_pages) from [<800cb620>] (kmalloc_order+0x18/0x30)
[   48.871536] [<800cb608>] (kmalloc_order) from [<800ede74>] (__kmalloc_track_caller+0x134/0x180)
[   48.880265] [<800edd40>] (__kmalloc_track_caller) from [<80585260>] (__kmalloc_reserve.isra.49+0x2c/0x78)
[   48.889846]  r10:00003ee3 r9:00000000 r8:00003fc0 r7:80585314 r6:00000000 r5:000004d0
[   48.897811]  r4:ec089b17 r3:00000000
[   48.901458] [<80585234>] (__kmalloc_reserve.isra.49) from [<80585314>] (__alloc_skb+0x68/0x15c)
[   48.910172]  r8:ee001e00 r7:000004d0 r6:00000000 r5:00003f22 r4:edb29240 r3:00000000
[   48.918061] [<805852ac>] (__alloc_skb) from [<805855e0>] (alloc_skb_with_frags+0x50/0x1dc)
[   48.926340]  r9:00000000 r8:ecf88c8c r7:00000000 r6:00000000 r5:7fffffff r4:ecf88a80
[   48.934239] [<80585590>] (alloc_skb_with_frags) from [<8057f010>] (sock_alloc_send_pskb+0x1c8/0x260)
[   48.943387]  r10:00003ee3 r9:00000000 r8:ecf88c8c[   48.947021] BUG: spinlock lockup suspected on CPU#3, udevd/206
[   48.947048]  lock: contig_page_data+0x80/0xd80, .magic: dead4ead, .owner: udevd/206, .owner_cpu: 3

[   48.962780]  r7:8005ac44 r6:ec088000 r5:7fffffff
[   48.967651]  r4:ecf88a80
[   48.970233] [<8057ee48>] (sock_alloc_send_pskb) from [<8057f0d0>] (sock_alloc_send_skb+0x28/0x30)
[   48.979120]  r10:eba5eb00 r9:00000000 r8:eda67e7c r7:00003eb0 r6:00003eb0 r5:00000000
[   48.987079]  r4:0000ffff
[   48.989663] [<8057f0a8>] (sock_alloc_send_skb) from [<805c52f4>] (__ip_append_data.isra.42+0x7cc/0xae8)
[   48.999083] [<805c4b28>] (__ip_append_data.isra.42) from [<805c70d4>] (ip_make_skb+0xb4/0xf0)
[   49.007622]  r10:ecf88d80 r9:ec089ca4 r8:805c4a7c r7:ec089ed8 r6:ecf88a80 r5:ec089d48
[   49.015583]  r4:00004000
[   49.018171] [<805c7020>] (ip_make_skb) from [<805ee698>] (udp_sendmsg+0x250/0x8a4)
[   49.025756]  r9:00000000 r8:ffffff7f r7:00003ea8 r6:ec089ed8 r5:00003eb0 r4:ecf88a80
[   49.033644] [<805ee448>] (udp_sendmsg) from [<805f98f8>] (inet_sendmsg+0xc8/0xfc)
[   49.041141]  r10:00000000 r9:ec088000 r8:00000000 r7:ec089e10 r6:ec089ed8 r5:00003ea8
[   49.049103]  r4:ecf88a80
[   49.051684] [<805f9830>] (inet_sendmsg) from [<8057b184>] (do_sock_sendmsg+0xd8/0xf4)
[   49.059528]  r8:7ecb3e48 r7:edf9a400 r6:00004000 r5:00000000 r4:ec089e10
[   49.066368] [<8057b0ac>] (do_sock_sendmsg) from [<8057b1b4>] (sock_sendmsg+0x14/0x18)
[   49.074212]  r5:00000000 r4:00003ea8
[   49.077858] [<8057b1a0>] (sock_sendmsg) from [<8057d558>] (SyS_sendto+0xc8/0xf8)
[   49.085285] [<8057d490>] (SyS_sendto) from [<8000f780>] (ret_fast_syscall+0x0/0x4c)
[   49.092956]  r8:8000f944 r7:00000122 r6:7ecb3e34 r5:00000010 r4:7ecb3e08
[   49.099796] CPU: 3 PID: 206 Comm: udevd Tainted: G      D    O   3.19.0uniwest-evi+ #100
[   49.107908] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   49.114451] Backtrace: 
[   49.116957] [<80013170>] (dump_backtrace) from [<8001338c>] (show_stack+0x18/0x1c)
[   49.124544]  r6:80a0e294 r5:00000000 r4:00000000 r3:00000000
[   49.130328] [<80013374>] (show_stack) from [<806fc6f0>] (dump_stack+0x8c/0xa4)
[   49.137583] [<806fc664>] (dump_stack) from [<80065608>] (spin_dump+0x7c/0xa4)
[   49.144734]  r6:0039911c r5:80a4d5c0 r4:ece81380 r3:00000000
[   49.150517] [<8006558c>] (spin_dump) from [<800657bc>] (do_raw_spin_lock+0xf4/0x1b8)
[   49.158276]  r5:80a0e27c r4:80a4d5c0
[   49.161928] [<800656c8>] (do_raw_spin_lock) from [<80703550>] (_raw_spin_lock+0x40/0x48)
[   49.170033]  r9:00000000 r8:00000000 r7:80a4d540 r6:6ddd3000 r5:809e92fc r4:80a4d5c0
[   49.177931] [<80703510>] (_raw_spin_lock) from [<800b3338>] (free_pcppages_bulk+0x30/0x3ec)
[   49.186298]  r4:80a4d540
[   49.188886] [<800b3308>] (free_pcppages_bulk) from [<800b5440>] (free_hot_cold_page+0x190/0x1d0)
[   49.197686]  r10:20080013 r9:00000000 r8:00000000 r7:80a4d540 r6:6ddd3000 r5:809e92fc
[   49.205647]  r4:0000001f
[   49.208232] [<800b52b0>] (free_hot_cold_page) from [<800b54b4>] (free_hot_cold_page_list+0x34/0x50)
[   49.217293]  r10:00000000 r9:000001d7 r8:ece88758 r7:00000000 r6:00000000 r5:ecc4da08
[   49.225255]  r4:ef5808a0
[   49.227842] [<800b5480>] (free_hot_cold_page_list) from [<800bb860>] (release_pages+0x218/0x22c)
[   49.236643]  r6:0000000c r5:000001d7 r4:ef595140 r3:00000000
[   49.242435] [<800bb648>] (release_pages) from [<800e6370>] (free_pages_and_swap_cache+0x60/0x8c)
[   49.251235]  r10:00000001 r9:00000001 r8:ece88000 r7:000001d7 r6:ece88758 r5:ef595140
[   49.259198]  r4:000001d7
[   49.261783] [<800e6310>] (free_pages_and_swap_cache) from [<800db9b4>] (exit_mmap+0x124/0x1fc)
[   49.270410]  r8:ece4cc00 r7:00000001 r6:ecc4da98 r5:ece4cc00 r4:ece6f7e8 r3:00000086
[   49.278299] [<800db890>] (exit_mmap) from [<800266cc>] (mmput+0x54/0xfc)
[   49.285015]  r7:0000000b r6:ece4cc54 r5:00000000 r4:ece4cc00
[   49.290796] [<80026678>] (mmput) from [<8002a654>] (do_exit+0x2a4/0x990)
[   49.297512]  r5:ece81740 r4:ece81380
[   49.301165] [<8002a3b0>] (do_exit) from [<800135a8>] (die+0x218/0x3f8)
[   49.307708]  r7:0000000b
[   49.310293] [<80013390>] (die) from [<806fa1f0>] (__do_kernel_fault.part.11+0x5c/0x7c)
[   49.318225]  r10:00000000 r9:efa4c914 r8:ecc4dcb0 r7:ece4cc00 r6:ecc4dcb0 r5:00000005
[   49.326187]  r4:efa4c914
[   49.328779] [<806fa194>] (__do_kernel_fault.part.11) from [<8001b0f0>] (do_bad_area+0x8c/0x90)
[   49.337406]  r7:ece4cc00 r3:ecc4dcb0
[   49.341058] [<8001b064>] (do_bad_area) from [<8001b180>] (do_translation_fault+0x74/0xbc)
[   49.349250]  r7:efa4c914 r6:80004000 r5:00003be8 r4:00000005
[   49.355030] [<8001b10c>] (do_translation_fault) from [<80008584>] (do_DataAbort+0x3c/0xa0)
[   49.363309]  r6:8001b10c r5:00000005 r4:809f5dec r3:00000000
[   49.369084] [<80008548>] (do_DataAbort) from [<80013e64>] (__dabt_svc+0x44/0x80)
[   49.376497] Exception stack(0xecc4dcb0 to 0xecc4dcf8)
[   49.381573] dca0:                                     80a4d540 00000000 00000034 80a4d67c
[   49.389776] dcc0: 0000000e 0000001f ef5975f4 00000000 80a4d540 efa4c914 00000000 ecc4dd3c
[   49.397975] dce0: ecc4dd40 ecc4dcf8 00000003 800b5c50 200f0093 ffffffff
[   49.404604]  r8:80a4d540 r7:ecc4dce4 r6:ffffffff r5:200f0093 r4:800b5c50
[   49.411457] [<800b5bd0>] (__rmqueue) from [<800b6484>] (get_page_from_freelist+0x4f8/0x6cc)
[   49.419823]  r10:00000000 r9:808a9770 r8:80a4d540 r7:00000000 r6:ef5975f4 r5:0000001f
[   49.427783]  r4:0000000e
[   49.430370] [<800b5f8c>] (get_page_from_freelist) from [<800b6944>] (__alloc_pages_nodemask+0xfc/0x990)
[   49.439778]  r10:00000000 r9:00000000 r8:00000000 r7:00000141 r6:80a4e200 r5:00000000
[   49.447740]  r4:000080d0
[   49.450326] [<800b6848>] (__alloc_pages_nodemask) from [<800b71f0>] (__get_free_pages+0x18/0x34)
[   49.459127]  r10:00000400 r9:eb4cca78 r8:ecc4df5c r7:ecc4dec8 r6:ffffff9c r5:eb424c38
[   49.467089]  r4:eb424c38
[   49.469674] [<800b71d8>] (__get_free_pages) from [<800b7224>] (get_zeroed_page+0x18/0x1c)
[   49.477886] [<800b720c>] (get_zeroed_page) from [<80159940>] (kernfs_iop_follow_link+0x1c/0x194)
[   49.486704] [<80159924>] (kernfs_iop_follow_link) from [<800fc008>] (generic_readlink+0x38/0x94)
[   49.495505]  r10:00000400 r9:eb4cca78 r8:ecc4df5c r7:7e8c9278 r6:ffffff9c r5:eb424c38
[   49.503468]  r4:00000400 r3:80159924
[   49.507116] [<800fbfd0>] (generic_readlink) from [<800f72a8>] (SyS_readlinkat+0x9c/0xe8)
[   49.515221]  r7:7e8c8e78 r6:ffffff9c r5:00004000 r4:ffffffea
[   49.520999] [<800f720c>] (SyS_readlinkat) from [<800f7318>] (SyS_readlink+0x24/0x28)
[   49.528757]  r10:00000000 r9:ecc4c000 r8:8000f944 r7:00000055 r6:7e8c9690 r5:7e8c9278
[   49.536718]  r4:7e8c8e78
[   49.539300] [<800f72f4>] (SyS_readlink) from [<8000f780>] (ret_fast_syscall+0x0/0x4c)
