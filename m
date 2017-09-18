From: vshrirama@gmail.com (Sriram V)
Date: Mon, 18 Sep 2017 20:08:43 +0530
Subject: Alignment crashes debugging?
Message-ID: <CAH9_wRMrkhU2y3qYZSoswe9CRUeCw6K6xweKn3ejz0fLAyCnAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I had posted this question in Linux-Kernel mailing list. However, I
did not receive any response.
I thought, this list is more appropriate one.

I am using a AM437x and an Older 3.12.20 Kernel. Unfortunately, I cant
migrate all our changes to a
recent Kernel. I would appreciate if someone can throw light on how we
can debug the random error we are seeing


[147278.696759] Alignment trap: not handling instruction e1901f9f at
[<c010ad10>]
[147278.714884] Unhandled fault: alignment exception (0x001) at 0xffffff7f
[147278.725921] Internal error: : 1 [#1] PREEMPT SMP ARM
[147278.731321] Modules linked in: omaplfb(O) pvrsrvkm(O)
pruss_remoteproc remoteproc virtio virtio_ring
[147278.741197] CPU: 0 PID: 21706 Comm: zygote Tainted: G           O
3.12.20+ #1
[147278.748893] task: ea86ebc0 ti: ec6cc000 task.ti: ec6cc000
[147278.754749] PC is at __destroy_inode+0xfc/0x14c
[147278.759676] LR is at _raw_spin_unlock+0x30/0x50
[147278.764596] pc : [<c010ad14>]    lr : [<c06d8918>]    psr: a00f0013
[147278.764596] sp : ec6cdd40  ip : ec6cdcf0  fp : ec6cdd54
[147278.777007] r10: dc0e77e0  r9 : e13b0c90  r8 : dc0e7778
[147278.782663] r7 : c06ed8f4  r6 : c06ed8f4  r5 : ece67b80  r4 : ece67b28
[147278.789705] r3 : 00000000  r2 : ec6cdcf0  r1 : 00000000  r0 : ffffff7f
[147278.796750] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment user
[147278.804443] Control: 10c5387d  Table: aae30059  DAC: 00000015
[147278.810654] Process zygote (pid: 21706, stack limit = 0xec6cc248)
[147278.817235] Stack: (0xec6cdd40 to 0xec6ce000)
[147278.821971] dd40: ece67bcc ece67b28 ec6cdd6c ec6cdd58 c010b60c
c010ac24 00000000 ece67b28
[147278.830775] dd60: ec6cdd8c ec6cdd70 c010b740 c010b5f4 00000000
ece67b28 ece67b80 ed096c00
[147278.839581] dd80: ec6cddac ec6cdd90 c010bdf0 c010b650 ecf79118
ece7d3c0 ece67b28 ecf79168
[147278.848385] dda0: ec6cddd4 ec6cddb0 c0108294 c010bd20 ec6cddd4
ec6cddc0 ecf79118 ec6cde0c
[147278.857190] ddc0: dc0e77c8 dc0e7778 ec6cde04 ec6cddd8 c010837c
c01080f4 ec8026f0 dc0e77e0
[147278.865990] dde0: ec6cde0c ece7d3c0 00000000 00002600 ece7d3c0
e13b0c80 ec6cde34 ec6cde08
[147278.874797] de00: c0108464 c01082e0 ece7d3c0 ecea70f8 ecf42978
00000008 c0109940 ec6cde43
[147278.883601] de20: 00000001 ed02b990 ec6cde8c ec6cde38 c014c2f4
c010844c ec6cdea0 00002600
[147278.892406] de40: 396cde9c 00383237 c0075194 c004e8a4 f9c3f101
00000004 ec6cde43 00000000
[147278.901211] de60: ec6cded8 e479fb80 c096f370 00002600 00002735
c0a0b558 e479fb80 00000007
[147278.910015] de80: ec6cdecc ec6cde90 c004bbb8 c014c288 ec6cdecc
ec6cdea0 c0075820 c0075178
[147278.918817] dea0: 0002d65e e479fb80 ec6cdf50 00002600 00002735
00000000 e479fb80 00000007
[147278.927624] dec0: ec6cdf0c ec6cded0 c004c6f4 c004bb78 ec6cdeec
ec6cdee0 0002b575 0000303a
[147278.936429] dee0: ec6cdf0c ec6cdf50 ea86ecf8 ea86ebc0 ec6cc000
fffffff6 e479fb80 ec6cdf68
[147278.945229] df00: ec6cdf4c ec6cdf10 c004c994 c004bf2c ec6cc000
ec6cc000 beaf7480 beaf7378
[147278.954036] df20: ec6cdf44 00000005 00000000 beaf726c 00000000
00000000 ec6cc000 00000000
[147278.962838] df40: ec6cdfa4 ec6cdf50 c004d6c8 c004c8cc 00000003
00000005 00000000 00000000
[147278.971645] df60: beaf726c 00000000 00000000 ea86ebc0 c004bb04
ed093710 ed093710 00000000
[147278.980451] df80: c00181b0 00000000 40cdac74 40ccb482 00000072
c0014c28 00000000 ec6cdfa8
[147278.989259] dfa0: c0014a80 c004d668 00000000 40cdac74 ffffffff
beaf726c 00000001 00000000
[147278.998063] dfc0: 00000000 40cdac74 40ccb482 00000072 40ccb482
00000004 00000001 beaf7644
[147279.006867] dfe0: 40ccb4cd beaf7260 40c961a1 40119e80 400f0010
ffffffff 00000000 00000000
[147279.015667] Backtrace:
[147279.018375] [<c010ac18>] (__destroy_inode+0x0/0x14c) from
[<c010b60c>] (destroy_inode+0x24/0x5c)
[147279.027830]  r4:ece67b28 r3:ece67bcc
[147279.031745] [<c010b5e8>] (destroy_inode+0x0/0x5c) from
[<c010b740>] (evict+0xfc/0x17c)
[147279.040267]  r4:ece67b28 r3:00000000
[147279.044183] [<c010b644>] (evict+0x0/0x17c) from [<c010bdf0>]
(iput+0xdc/0x154)
[147279.051966]  r6:ed096c00 r5:ece67b80 r4:ece67b28 r3:00000000
[147279.058113] [<c010bd14>] (iput+0x0/0x154) from [<c0108294>]
(dentry_kill+0x1ac/0x1ec)
[147279.066543]  r7:ecf79168 r6:ece67b28 r5:ece7d3c0 r4:ecf79118
[147279.072690] [<c01080e8>] (dentry_kill+0x0/0x1ec) from [<c010837c>]
(shrink_dentry_list+0xa8/0xdc)
[147279.082227]  r7:dc0e7778 r6:dc0e77c8 r5:ec6cde0c r4:ecf79118
[147279.088371] [<c01082d4>] (shrink_dentry_list+0x0/0xdc) from
[<c0108464>] (shrink_dcache_parent+0x24/0x68)
[147279.098664] [<c0108440>] (shrink_dcache_parent+0x0/0x68) from
[<c014c2f4>] (proc_flush_task+0x78/0x148)
[147279.108761]  r6:ed02b990 r5:00000001 r4:ec6cde43
[147279.113791] [<c014c27c>] (proc_flush_task+0x0/0x148) from
[<c004bbb8>] (release_task+0x4c/0x3b4)
[147279.123245] [<c004bb6c>] (release_task+0x0/0x3b4) from
[<c004c6f4>] (wait_consider_task+0x7d4/0x9a0)
[147279.133073] [<c004bf20>] (wait_consider_task+0x0/0x9a0) from
[<c004c994>] (do_wait+0xd4/0x1d4)
[147279.142341] [<c004c8c0>] (do_wait+0x0/0x1d4) from [<c004d6c8>]
(SyS_wait4+0x6c/0xd0)
[147279.150698] [<c004d65c>] (SyS_wait4+0x0/0xd0) from [<c0014a80>]
(ret_fast_syscall+0x0/0x30)
[147279.159690]  r8:c0014c28 r7:00000072 r6:40ccb482 r5:40cdac74 r4:00000000
[147279.166953] Code: 0affffdf e3a03000 ee073fba e1901f9f (e2411001)
[147279.229155] ---[ end trace 2b72a04c9c22f45a ]---
[147279.245817] Kernel panic - not syncing: Fatal exception


Regards,
Sriram
