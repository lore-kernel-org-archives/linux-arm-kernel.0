From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 28 Aug 2012 20:19:45 +0530
Subject: [PATCH 1/2] ARM: tegra: remove dead code
In-Reply-To: <1346137800-7448-1-git-send-email-swarren@wwwdotorg.org>
References: <1346137800-7448-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <503CDA89.2020403@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 August 2012 12:39 PM, Stephen Warren wrote:
> From: Stephen Warren<swarren@nvidia.com>
>
> Now that all boards are converted to device tree, devices.[ch] and
> board-pinmux.[ch] are no longer used. So, remove them.
>
> The only exception is the EHCI platform data in devices.h. Move that
> data to board-dt-tegra20.c - the only places it's used.
>
> Signed-off-by: Stephen Warren<swarren@nvidia.com>
> ---
> These patches are both destined for Tegra's for-3.7/board-removal branch.


I applied both patches and it crash on with following log:
[    1.652934] VFP support v0.3: implementor 41 architecture 3 part 30 
variant 9
  rev 1
[    1.661661] Unable to handle kernel paging request at virtual address 
fffffe0
7
[    1.670980] pgd = c0004000
[    1.673711] [fffffe07] *pgd=2f7fe821, *pte=00000000, *ppte=00000000
[    1.679988] Internal error: Oops: 17 [#1] PREEMPT SMP ARM
[    1.685369] Modules linked in:
[    1.688419] CPU: 0    Not tainted  (3.6.0-rc3-next-20120824-dirty #2)
[    1.694852] PC is at regulator_disable+0x4/0x60
[    1.699378] LR is at harmony_pcie_init+0x50/0xa0
[    1.703983] pc : [<c01f71f0>]    lr : [<c05e3810>]    psr: 20000013
[    1.703983] sp : ef04bf38  ip : 22222222  fp : 00000000
[    1.715434] r10: c05dd690  r9 : c0602eb0  r8 : c05db26c
[    1.720642] r7 : 00000000  r6 : fffffdfb  r5 : c0459004  r4 : fffffdfb
[    1.727151] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : fffffdfb
[    1.733663] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  
Segment kern
el
[    1.740953] Control: 10c5387d  Table: 0000404a  DAC: 00000015
[    1.746682] Process swapper/0 (pid: 1, stack limit = 0xef04a2f0)
[    1.752672] Stack: (0xef04bf38 to 0xef04c000)
[    1.757015] 
bf20:                                                       fffff
dfb c0459004
[    1.765174] bf40: fffffdfb c05e3810 00000002 c0459004 c045900c 
c05e3718 c05e3
710 c05e36f8
[    1.773333] bf60: c05fd8ec ef04a000 c06595c0 c05dd6ac 00000000 c00085c8
