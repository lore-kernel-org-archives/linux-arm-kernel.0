From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 3 Jun 2018 18:53:36 +0200
Subject: Common config for N900 and D4
In-Reply-To: <20180603104839.GA21197@amd>
References: <20180603104839.GA21197@amd>
Message-ID: <20180603165336.GA26995@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
> Aaro, I know I have asked before, but if you have common config for
> N900 and Droid4, please send me a copy. Yes, it should be somewhere in
> my inbox already, but I can't find it and version for v4.17 would be
> more useful.
> 
> While trying to came up with common config, I hit:
> 
> [    0.000000] L2C-310 erratum 727915 enabled
> [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> [    0.000000] L2C-310 full line of zeros enabled for Cortex-A9

I tried disabling outer cache to get rid of this. That got me further
in boot, but not to working system:

[    0.000000] ti_clk_get_reg_addr: clk-provider not found for
auxclkreq0_ck!
[    0.000000] ti_clk_get_reg_addr: clk-provider not found for
auxclkreq1_ck!
[    0.000000] ti_clk_get_reg_addr: clk-provider not found for
auxclkreq2_ck!
[    0.000000] ti_clk_get_reg_addr: clk-provider not found for
auxclkreq3_ck!
[    0.000000] ti_clk_get_reg_addr: clk-provider not found for
auxclkreq4_ck!
[    0.000000] ti_clk_get_reg_addr: clk-provider not found for
auxclkreq5_ck!
[    0.000000] clocksource: 32k_counter: mask: 0xffffffff max_cycles:
0xfffffffs
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns,
wraps every 6s
[    3.105895] OMAP clocksource: 32k_counter at 32768 Hz
[    3.111541] Unable to handle kernel NULL pointer dereference at
virtual addr0
[    3.111541] pgd = (ptrval)
[    3.122650] [00000000] *pgd=00000000
[    3.122650] Internal error: Oops: 80000005 [#1] SMP ARM
[    3.131683] Modules linked in:
[    3.134826] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
4.17.0-rc7-75535-g2a545
[    3.143310] Hardware name: Generic DT based system
[    3.143310] PC is at   (null)
[    3.143310] LR is at __irq_svc+0x6c/0x90
[    3.143310] pc : [<00000000>]    lr : [<c0101a2c>]    psr: 20000193
[    3.155303] sp : c0d01f70  ip : 00000002  fp : 00000000
[    3.155303] r10: 00000001  r9 : c0d00000  r8 : ef7d2a00
[    3.172424] r7 : c0d01fa4  r6 : ffffffff  r5 : 20000013  r4 :
c0c00b78
[    3.172424] r3 : c01d2db8  r2 : c0d01fc0  r1 : c0d0f678  r0 :
c0d01f70
[    3.172424] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment noe
[    3.193206] Control: 10c5387d  Table: 8000404a  DAC: 00000051
[    3.199096] Process swapper/0 (pid: 0, stack limit = 0x(ptrval))
[    3.205261] Stack: (0xc0d01f70 to 0xc0d02000)
[    3.205261] 1f60:                                     00000000
00000000 00000
[    3.205261] 1f80: 00000000 ffffffff c0d50040 c0c358d4 ef7d2a00
411fc093 00000

Best regards,
									Pavel



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180603/ce084638/attachment.sig>
