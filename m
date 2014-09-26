From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 26 Sep 2014 22:57:38 +0200
Subject: Crash on ARM: 8148/1 flush TLS and thumbee register
Message-ID: <CAGhQ9VzyK3qW2pr-YOFywUS7=9RLDzrj6wOFFhnvyDkks_2VCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

My Cortex-M4 noMMU platform crashes on 3.17-rc6 with fbfb872f5f417cea4
"ARM: 8148/1: flush TLS and thumbee register state during exec".

Revering fbfb872f5f417cea4 makes it good as normal again.

The platform I am working on is a Thum only Cortex-M4 that is not upstream yet.

Boot log of crash:
[ 6.100000] clk: Not disabling unused clocks
[ 6.110000] RAMDISK: gzip image found at block 0
[ 9.590000] VFS: Mounted root (ext2 filesystem) readonly on device 1:0.
[ 9.600000] devtmpfs: mounted
[ 9.610000] Freeing unused kernel memory: 68K (281e5000 - 281f6000)
[ 9.630000]
[ 9.630000] Unhandled exception: IPSR = 00000005 LR = fffffff1
[ 9.630000]
[ 9.630000] CPU: 0 PID: 1 Comm: swapper Not tainted
3.17.0-rc6-00313-gd2205fa30aa7 #191
[ 9.630000] task: 29834000 ti: 29832000 task.ti: 29832000
[ 9.630000] PC is at flush_thread+0x2e/0x40
[ 9.630000] LR is at flush_thread+0x21/0x40
[ 9.630000] pc : [<2800954a>] lr : [<2800953d>] psr: 4100000b
[ 9.630000] sp : 29833d60 ip : 00000000 fp : 00000001
[ 9.630000] r10: 00003cf8 r9 : 29b1f000 r8 : 00000000
[ 9.630000] r7 : 29b0bc00 r6 : 29834000 r5 : 29832000 r4 : 29832000
[ 9.630000] r3 : ffff0ff0 r2 : 29832000 r1 : 00000000 r0 : 282121f0
[ 9.630000] xPSR: 4100000b
[ 9.630000] CPU: 0 PID: 1 Comm: swapper Not tainted
3.17.0-rc6-00313-gd2205fa30aa7 #191
[ 9.630000] [<2800afa5>] (unwind_backtrace) from [<2800a327>]
(show_stack+0xb/0xc)
[ 9.630000] [<2800a327>] (show_stack) from [<2800a963>]
(__invalid_entry+0x4b/0x4c)


regards,
Joachim Eastwood
