From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 17 Nov 2009 13:39:35 +0100
Subject: imx27 - hanging at freeing init memory -- getting some junk
	characters here after on console ..
In-Reply-To: <OF8F8BC118.05889ED4-ON65257671.0041E186-65257671.0041E18F@tcs.com>
References: <20091117091713.GN14091@buzzloop.caiaq.de>
	<20091117071744.GM14091@buzzloop.caiaq.de>
	<20091110064900.GK14091@buzzloop.caiaq.de>
	<20091104131500.GZ14091@buzzloop.caiaq.de>
	<OF15AFD08D.F28F9544-ON65257664.002A1275-65257664.002A127F@tcs.com>
	<OF899D5B75.A8958BE5-ON65257666.001F50BF-65257666.001F50C4@tcs.com>
	<OF409EDC40.B7ED8C90-ON65257671.001667E7-65257671.001667F5@tcs.com>
	<OF29677297.CAA27B00-ON65257671.002E6F4B-65257671.002E6F5C@tcs.com>
	<OF8F8BC118.05889ED4-ON65257671.0041E186-65257671.0041E18F@tcs.com>
Message-ID: <20091117123935.GV14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2009 at 05:29:35PM +0530, Vadivelan M wrote:
>    Thanks for the continuous support. 
>    As you have suggested we have tried in main kernel with default
>    configuration.
> 
>    Without any change its stopping at

[...]

>    <1>Unhandled fault: external abort on non-linefetch (0x008) at 0xf4300000
>    Internal error: : 8 [#1]
>    Modules linked in:
>    CPU: 0    Not tainted  (2.6.27 #11)
>    PC is at mx27ads_timer_init+0x14/0x44
>    LR is at time_init+0x1c/0x24
>    pc : [<c0011390>]    lr : [<c000f8ac>]    psr: 800000d3
>    sp : c0429fa8  ip : c0429fb8  fp : c0429fb4
>    r10: a0021b58  r9 : 41069264  r8 : a0021b8c
>    r7 : c042ce5c  r6 : c0023f14  r5 : c044bcf0  r4 : c044bce4
>    r3 : f4300000  r2 : 00000000  r1 : 00000000  r0 : 019bfcc0
>    Flags: Nzcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
>    Control: 0005317f  Table: a0004000  DAC: 00000017
>    Process swapper (pid: 0, stack limit = 0xc0428268)
>    Stack: (0xc0429fa8 to 0xc042a000)
>    9fa0:                   c0429fc4 c0429fb8 c000f8ac c001138c c0429ff4
>    c0429fc8
>    9fc0: c0008ae8 c000f8a0 c000853c 00000000 00000000 c0023f14 00000000
>    00053175
>    9fe0: c044c60c c0024318 00000000 c0429ff8 a0008034 c0008970 00000000
>    00000000
>    Backtrace:
>    [<c001137c>] (mx27ads_timer_init+0x0/0x44) from [<c000f8ac>]
>    (time_init+0x1c/0x24)
>    [<c000f890>] (time_init+0x0/0x24) from [<c0008ae8>]
>    (start_kernel+0x188/0x30c)
>    [<c0008960>] (start_kernel+0x0/0x30c) from [<a0008034>] (0xa0008034)
>     r6:c0024318 r5:c044c60c r4:00053175
>    Code: e92dd800 e24cb004 e59f3020 e59f0020 (e1d330b0)
>    <4>---[ end trace 1b75b31a2719ed1c ]---
>    <0>Kernel panic - not syncing: Attempted to kill the idle task!

Assuming this is the reference hardware which you're running on, others
should be able to reproduce this error. Unfortunately I can't help here,
as I don't have access to any MX2 based hardware. Anyone else?

Daniel
